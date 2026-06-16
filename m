Return-Path: <linux-rdma+bounces-22292-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VEUsIZG6MWo/pgUAu9opvQ
	(envelope-from <linux-rdma+bounces-22292-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 23:05:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E22B9695586
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 23:05:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SQLTYRBb;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22292-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22292-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAB1131849A1
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 21:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0263A6EF0;
	Tue, 16 Jun 2026 21:05:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC80395AFD;
	Tue, 16 Jun 2026 21:05:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781643907; cv=none; b=Yu54L8/7mvq5OM96Wycpu5TvsEly7KrN8EIoLEdsIY3U6jZcIEWfl60bpIMiWZOSK3tc1qmhPjU9Oa6Idg1uEYzVIoLXxQOJBj1rthxruw3hCI3r6sViSmyTbafgRRR8zZjKilZn8lL9s/g8VeOvh0kfFN/j10ccGXZkv5GJ8Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781643907; c=relaxed/simple;
	bh=20MOj3cFIfEmwj14kTofb3V5BqW7mpcKZIyGsLatgfw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBIeR9FHJOKnqZhgrOxOH86Hj02Iqwuq7h4VyIGapxMLCy8xQo0LqeJgxbEhsknnPEQ4f1jDTAYBP5QgEeJgCmSj4ugbO/3ADtNN9pn+tct64Oo5JXb1ZxWD8TgdMtdyrOu76Jd318JkEZXjsQTJ+j9HPVTjCTpz9lrFO9HlqYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQLTYRBb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94841F000E9;
	Tue, 16 Jun 2026 21:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781643906;
	bh=2R8CmtVTZGIH+ClggiKNd4YljShJHA2SfkJJ6kv1B44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SQLTYRBbi06gYKC7IZ5HTVbl+rJze67jKydMVFmDf+lJ8ZGRbRIKf00iiYEK2zCZl
	 OolnUXytFooF06TzCunHiuhB72WLWp0herX34zZHsiw5FNzMzxmlsMp9p7/DSlZgFs
	 duxuaxQEHEff7Qj/gLUhPMqSu6mqxw4sDzs7ktDQfP2XxqOvlx1/IFP5DGhdhP+djc
	 164+kEgQYm6sdkeMqHauFp3eAOqkRAz9G7WFAKj3x0DqVUSAEg6PKh4Uma95HP21Kl
	 azC1lkGaUUfoXMhcQYqRF142jVkf6xfbckm9o5xeSvmj1NH+lfKvOmCmiqMgldBBIs
	 897ZmG8dq3GEQ==
Date: Tue, 16 Jun 2026 14:05:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, Sunil Goutham
 <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Ethan Nelson-Moore
 <enelsonmoore@gmail.com>, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next V3 2/7] netdevsim: Register devlink after
 device init
Message-ID: <20260616140504.75979b27@kernel.org>
In-Reply-To: <7635d50c-1c82-4090-8907-53a72444fc04@nvidia.com>
References: <20260605181030.3486619-1-mbloch@nvidia.com>
	<20260605181030.3486619-3-mbloch@nvidia.com>
	<20260610165053.7c91f331@kernel.org>
	<eb525345-da07-414c-9d05-7e00e3eb472f@nvidia.com>
	<20260611085440.4fe36bf2@kernel.org>
	<f266dfa5-0c6c-4be0-b73e-b2185dadd6a7@nvidia.com>
	<7635d50c-1c82-4090-8907-53a72444fc04@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22292-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:mbloch@nvidia.com,m:jiri@resnulli.us,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:horms@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:bbhushan2@marvell.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[resnulli.us,google.com,redhat.com,lunn.ch,davemloft.net,lwn.net,linuxfoundation.org,kernel.org,marvell.com,nvidia.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E22B9695586

On Tue, 16 Jun 2026 20:29:25 +0300 Mark Bloch wrote:
> I think the explicit helper is the cleanest option here, without any
> workqueue fallback inside devlink. It avoids depending on devl_register()
> ordering, and makes the support explicit per driver.
> 
> Does that sound like an acceptable direction?

I'd much rather have the workqueue with the purely theoretical race
with user space than a bunch of drivers that don't act on the cmdline
params.

