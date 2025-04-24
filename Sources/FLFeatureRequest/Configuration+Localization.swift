//
//  Configuration+Localization.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 4/13/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

extension Configuration {

	public struct Localization {

		public var requested: String

		public var pending: String

		public var approved: String

		public var implemented: String

		public var featurelist: String

		public var save: String

		public var submit: String

		public var title: String

		public var description: String

		public var upvote: String

		public var info: String

		public var youCanOnlyVoteOnce: String

		public var youCanNotVoteForAnImplementedFeature: String

		public var youCanNotVoteForYourOwnFeature: String

		public var poweredBy: String

		public var successfullyCreated: String

		public var done: String

		public var detail: String

		public var featureFeaturelist: String

		public var confirm: String

		public var cancel: String

		public var ok: String

		public var titleOfFeature: String

		public var titleDescriptionCannotBeEmpty: String

		public var votes: String

		public var close: String

		public var createFeature: String

		public var optional: String

		public var required: String

		public var emailRequiredText: String

		public var emailFormatWrongText: String

		public var comments: String

		public var writeAComment: String

		public var admin: String

		public var user: String

		public var noFeatureRequests: String

		public var emailOptional: String

		public var emailRequired: String

		public init(
			requested: String = Localization.default().requested,
			pending: String = Localization.default().pending,
			approved: String = Localization.default().approved,
			implemented: String = Localization.default().implemented,
			featurelist: String = Localization.default().featurelist,
			save: String = Localization.default().save,
			submit: String = Localization.default().submit,
			title: String = Localization.default().title,
			description: String = Localization.default().description,
			upvote: String = Localization.default().upvote,
			info: String = Localization.default().info,
			youCanOnlyVoteOnce: String = Localization.default().youCanOnlyVoteOnce,
			youCanNotVoteForAnImplementedFeature: String = Localization.default().youCanNotVoteForAnImplementedFeature,
			youCanNotVoteForYourOwnFeature: String = Localization.default().youCanNotVoteForYourOwnFeature,
			poweredBy: String = Localization.default().poweredBy,
			successfullyCreated: String = Localization.default().successfullyCreated,
			done: String = Localization.default().done,
			detail: String = Localization.default().detail,
			featureFeaturelist: String = Localization.default().featureFeaturelist,
			confirm: String = Localization.default().confirm,
			cancel: String = Localization.default().cancel,
			ok: String = Localization.default().ok,
			titleOfFeature: String = Localization.default().titleOfFeature,
			titleDescriptionCannotBeEmpty: String = Localization.default().titleDescriptionCannotBeEmpty,
			votes: String = Localization.default().votes,
			close: String = Localization.default().close,
			createFeature: String = Localization.default().createFeature,
			optional: String = Localization.default().optional,
			required: String = Localization.default().required,
			emailRequiredText: String = Localization.default().emailRequiredText,
			emailFormatWrongText: String = Localization.default().emailFormatWrongText,
			comments: String = Localization.default().comments,
			writeAComment: String = Localization.default().writeAComment,
			admin: String = Localization.default().admin,
			user: String = Localization.default().user,
			noFeatureRequests: String = Localization.default().noFeatureRequests,
			emailOptional: String = Localization.default().emailOptional,
			emailRequired: String = Localization.default().emailRequired
		) {
			self.requested = requested
			self.pending = pending
			self.approved = approved
			self.implemented = implemented
			self.featurelist = featurelist
			self.save = save
			self.submit = submit
			self.title = title
			self.description = description
			self.upvote = upvote
			self.info = info
			self.youCanOnlyVoteOnce = youCanOnlyVoteOnce
			self.youCanNotVoteForAnImplementedFeature = youCanNotVoteForAnImplementedFeature
			self.youCanNotVoteForYourOwnFeature = youCanNotVoteForYourOwnFeature
			self.poweredBy = poweredBy
			self.successfullyCreated = successfullyCreated
			self.done = done
			self.detail = detail
			self.featureFeaturelist = featureFeaturelist
			self.confirm = confirm
			self.cancel = cancel
			self.ok = ok
			self.titleOfFeature = titleOfFeature
			self.titleDescriptionCannotBeEmpty = titleDescriptionCannotBeEmpty
			self.votes = votes
			self.close = close
			self.createFeature = createFeature
			self.optional = optional
			self.required = required
			self.emailRequiredText = emailRequiredText
			self.emailFormatWrongText = emailFormatWrongText
			self.comments = comments
			self.writeAComment = writeAComment
			self.admin = admin
			self.user = user
			self.noFeatureRequests = noFeatureRequests
			self.emailOptional = emailOptional
			self.emailRequired = emailRequired
		}

		public static func `default`() -> Localization {
			Localization(
				requested: String(localized: "Requested", bundle: .module),
				pending: String(localized: "Pending", bundle: .module),
				approved: String(localized: "Approved", bundle: .module),
				implemented: String(localized: "Implemented", bundle: .module),
				featurelist: String(localized: "Feature Requests", bundle: .module),
				save: String(localized: "Save", bundle: .module),
				submit: String(localized: "Submit", bundle: .module),
				title: String(localized: "Title", bundle: .module),
				description: String(localized: "Description (Optional)", bundle: .module),
				upvote: String(localized: "Upvote", bundle: .module),
				info: String(localized: "Info", bundle: .module),
				youCanOnlyVoteOnce: String(localized: "You can only vote once.", bundle: .module),
				youCanNotVoteForAnImplementedFeature: String(localized: "You can not vote for a feature that is already implemented.", bundle: .module),
				youCanNotVoteForYourOwnFeature: String(localized: "You cannot vote for your own feature request.", bundle: .module),
				poweredBy: String(localized: "Powered by", bundle: .module),
				successfullyCreated: String(localized: "Successfully created", bundle: .module),
				done: String(localized: "Done", bundle: .module),
				detail: String(localized: "Detail", bundle: .module),
				featureFeaturelist: String(localized: "Feature Requests", bundle: .module),
				confirm: String(localized: "Confirm", bundle: .module),
				cancel: String(localized: "Cancel", bundle: .module),
				ok: String(localized: "Ok", bundle: .module),
				titleOfFeature: String(localized: "Title of the feature..", bundle: .module),
				titleDescriptionCannotBeEmpty: String(localized: "Title/Description cannot be empty.", bundle: .module),
				votes: String(localized: "Votes", bundle: .module),
				close: String(localized: "Close", bundle: .module),
				createFeature: String(localized: "Create Feature", bundle: .module),
				optional: String(localized: "optional", bundle: .module),
				required: String(localized: "required", bundle: .module),
				emailRequiredText: String(localized: "Please enter your email address.", bundle: .module),
				emailFormatWrongText: String(localized: "Wrong email format.", bundle: .module),
				comments: String(localized: "Comments", bundle: .module),
				writeAComment: String(localized: "Write a comment..", bundle: .module),
				admin: String(localized: "Admin", bundle: .module),
				user: String(localized: "User", bundle: .module),
				noFeatureRequests: String(localized: "No feature requests, yet ✨", bundle: .module),
				emailOptional: String(localized: "Email (optional)", bundle: .module),
				emailRequired: String(localized: "Email (required)", bundle: .module)
			)
		}
	}
}
