//
//  ItineraryFormView.swift
//  Traivel
//
//  Created by Daria on 27.5.2024.
//

import SwiftUI

struct TripFormView: View {
    @EnvironmentObject var router: Router
    @StateObject private var tripFormViewModel = TripFormViewModel()
    @StateObject private var destinationService = DestinationSerivce()
    
    @State private var showCountrySheet: Bool = false
    @State private var showCitySheet: Bool = false
    @State private var isLoadingTrip: Bool = false
    
    var body: some View {
        VStack(spacing: 8) {
            VStack {
                Text("Where to?")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title)
                    .fontWeight(.bold)
                Divider()
                    .padding(.bottom)
                Button(action: {showCountrySheet = true}) {
                    HStack {
                        if tripFormViewModel.selectedCountry == nil {
                            Image(systemName: "flag")
                                .foregroundColor(.secondary)
                            Text("Type destination country")
                                .foregroundStyle(.secondary)
                        } else {
                            Text(destinationService.generateCountryLabel(country: tripFormViewModel.selectedCountry!))
                            Spacer()
                            Button(action: { tripFormViewModel.clearSelectedCountry() }) {
                                Image(systemName: "x.circle.fill")
                            }
                            .foregroundColor(.secondary)
                        }
                        
                    }.frame(maxWidth: .infinity, alignment: .leading)
                }
                .buttonStyle(.plain)
                .sheet(isPresented: $showCountrySheet, content: {
                    VStack {
                        SearchInput(selectedItem: $tripFormViewModel.selectedCountry, showSheet: $showCountrySheet, items: destinationService.countries, filterItems: destinationService.onCountriesFiltering, generateLabel: destinationService.generateCountryLabel, placeholder: "Country")
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .presentationBackground(.thinMaterial)
                })
                if tripFormViewModel.selectedCountry != nil {
                    Button(action: { showCitySheet = true }) {
                        HStack {
                            if tripFormViewModel.selectedCity == nil {
                                Image(systemName: "building.2")
                                    .foregroundColor(.secondary)
                                Text("Type destination city")
                                    .foregroundStyle(.secondary)
                            } else {
                                Image(systemName: "building.2")
                                Text(tripFormViewModel.selectedCity!.name)
                                Spacer()
                                Button(action: { tripFormViewModel.clearSelectedCity() }) {
                                    Image(systemName: "x.circle.fill")
                                }
                                .foregroundColor(.secondary)
                            }
                            
                        }.frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .buttonStyle(.plain)
                    .padding(.top)
                    .sheet(isPresented: $showCitySheet, content: {
                        VStack {
                            SearchInput(selectedItem: $tripFormViewModel.selectedCity, showSheet: $showCitySheet, items: destinationService.getCitiesForCountry(country: tripFormViewModel.selectedCountry), filterItems: destinationService.onCitiesFiltering, generateLabel: destinationService.generateCityLabel, placeholder: "City")
                                .padding()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .presentationBackground(.thinMaterial)
                    })
                }
            }
            .padding().background(RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial))
            .padding()
            
            HStack {
                Text("Days")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Button(action: { tripFormViewModel.decrementDay() }) {
                    Image(systemName: "minus").frame(maxWidth: 35, maxHeight: 35).background(.ultraThinMaterial).clipShape(Circle())
                }
                .buttonStyle(.plain)
                .disabled(tripFormViewModel.numberOfDays == 1)
                
                Text(String(tripFormViewModel.numberOfDays))
                    .font(.largeTitle)
                    .padding([.leading, .trailing])
                    .frame(minWidth: 70)
                
                Button(action: { tripFormViewModel.incrementDay() }) {
                    Image(systemName: "plus").frame(maxWidth: 35, maxHeight: 35).background(.ultraThinMaterial).clipShape(Circle())
                }
                .buttonStyle(.plain)
            }
            .padding().background(RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial)).padding([.leading, .trailing, .bottom])
            VStack {
                Text("Staring date")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title)
                    .fontWeight(.bold)
                Divider()
                    .padding(.bottom)
                HStack {
                    Image(systemName: "calendar")
                    DatePicker("Selected date", selection: $tripFormViewModel.startingDate, displayedComponents: .date)
                }
            }
            .padding().background(RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial)).padding([.leading, .trailing])
            Spacer()
            Button(action: {
                isLoadingTrip = true
                tripFormViewModel.generateTrip { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let generatedTripDays):
                            let newTrip = createTripFromGeneratedTripDays(from: generatedTripDays, startDate: tripFormViewModel.startingDate, participantIds: [User(email: "email.com", username: "test", subscription: .basic).id])
                            router.navigate(to: .newTripDetails(newTrip))
                            isLoadingTrip = false
                        case .failure(let error):
                            print("Error: \(error)")
                            isLoadingTrip = false
                        }
                    }
                }
            }) {
                HStack {
                    Image(systemName: "sparkles")
                    Text("Generate trip")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(.blue))
            }
            .buttonStyle(.plain)
            .padding()
            .disabled(tripFormViewModel.selectedCountry == nil || tripFormViewModel.selectedCity == nil)
        }
        .fullScreenCover(isPresented: $isLoadingTrip) {
            ZStack {
                ProgressView("Generating your trip...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            }
            .presentationBackground(.thinMaterial)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .animation(.default, value: tripFormViewModel.selectedCountry)
        .ignoresSafeArea(.keyboard)
    }
}

struct LoadingView: View {
    var body: some View {
            ZStack {
                ProgressView("Generating trip...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
                    .foregroundColor(.white)
            }
            
        }

}

#Preview {
    TripFormView().preferredColorScheme(.dark)
}
