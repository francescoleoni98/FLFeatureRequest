//
//  Configuration+Localization.swift
//  wishkit-ios
//
//  Created by Martin Lasek on 4/13/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

extension Configuration {

	public struct Localization {

		public var requested: String

		public var pending: String

		public var approved: String

		public var implemented: String

		public var wishlist: String

		public var save: String

		public var title: String

		public var description: String

		public var upvote: String

		public var info: String

		public var youCanOnlyVoteOnce: String

		public var youCanNotVoteForAnImplementedWish: String

		public var youCanNotVoteForYourOwnWish: String

		public var poweredBy: String

		public var successfullyCreated: String

		public var done: String

		public var detail: String

		public var featureWishlist: String

		public var confirm: String

		public var cancel: String

		public var ok: String

		public var titleOfWish: String

		public var titleDescriptionCannotBeEmpty: String

		public var votes: String

		public var close: String

		public var createWish: String

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
			wishlist: String = Localization.default().wishlist,
			save: String = Localization.default().save,
			title: String = Localization.default().title,
			description: String = Localization.default().description,
			upvote: String = Localization.default().upvote,
			info: String = Localization.default().info,
			youCanOnlyVoteOnce: String = Localization.default().youCanOnlyVoteOnce,
			youCanNotVoteForAnImplementedWish: String = Localization.default().youCanNotVoteForAnImplementedWish,
			youCanNotVoteForYourOwnWish: String = Localization.default().youCanNotVoteForYourOwnWish,
			poweredBy: String = Localization.default().poweredBy,
			successfullyCreated: String = Localization.default().successfullyCreated,
			done: String = Localization.default().done,
			detail: String = Localization.default().detail,
			featureWishlist: String = Localization.default().featureWishlist,
			confirm: String = Localization.default().confirm,
			cancel: String = Localization.default().cancel,
			ok: String = Localization.default().ok,
			titleOfWish: String = Localization.default().titleOfWish,
			titleDescriptionCannotBeEmpty: String = Localization.default().titleDescriptionCannotBeEmpty,
			votes: String = Localization.default().votes,
			close: String = Localization.default().close,
			createWish: String = Localization.default().createWish,
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
			self.wishlist = wishlist
			self.save = save
			self.title = title
			self.description = description
			self.upvote = upvote
			self.info = info
			self.youCanOnlyVoteOnce = youCanOnlyVoteOnce
			self.youCanNotVoteForAnImplementedWish = youCanNotVoteForAnImplementedWish
			self.youCanNotVoteForYourOwnWish = youCanNotVoteForYourOwnWish
			self.poweredBy = poweredBy
			self.successfullyCreated = successfullyCreated
			self.done = done
			self.detail = detail
			self.featureWishlist = featureWishlist
			self.confirm = confirm
			self.cancel = cancel
			self.ok = ok
			self.titleOfWish = titleOfWish
			self.titleDescriptionCannotBeEmpty = titleDescriptionCannotBeEmpty
			self.votes = votes
			self.close = close
			self.createWish = createWish
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
				wishlist: String(localized: "Feature Requests", bundle: .module),
				save: String(localized: "Save", bundle: .module),
				title: String(localized: "Title", bundle: .module),
				description: String(localized: "Description (Optional)", bundle: .module),
				upvote: String(localized: "Upvote", bundle: .module),
				info: String(localized: "Info", bundle: .module),
				youCanOnlyVoteOnce: String(localized: "You can only vote once.", bundle: .module),
				youCanNotVoteForAnImplementedWish: String(localized: "You can not vote for a feature that is already implemented.", bundle: .module),
				youCanNotVoteForYourOwnWish: String(localized: "You cannot vote for your own feature request.", bundle: .module),
				poweredBy: String(localized: "Powered by", bundle: .module),
				successfullyCreated: String(localized: "Successfully created", bundle: .module),
				done: String(localized: "Done", bundle: .module),
				detail: String(localized: "Detail", bundle: .module),
				featureWishlist: String(localized: "Feature Requests", bundle: .module),
				confirm: String(localized: "Confirm", bundle: .module),
				cancel: String(localized: "Cancel", bundle: .module),
				ok: String(localized: "Ok", bundle: .module),
				titleOfWish: String(localized: "Title of the feature..", bundle: .module),
				titleDescriptionCannotBeEmpty: String(localized: "Title/Description cannot be empty.", bundle: .module),
				votes: String(localized: "Votes", bundle: .module),
				close: String(localized: "Close", bundle: .module),
				createWish: String(localized: "Create Feature", bundle: .module),
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
