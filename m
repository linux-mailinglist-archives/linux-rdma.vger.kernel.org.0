Return-Path: <linux-rdma+bounces-18783-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHtsNWRnymll8gUAu9opvQ
	(envelope-from <linux-rdma+bounces-18783-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 14:07:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5808A35ACDF
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 14:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 578EC30763FA
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 11:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DD03C5529;
	Mon, 30 Mar 2026 11:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwhgfWfB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB12B3C5DCD;
	Mon, 30 Mar 2026 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871897; cv=none; b=I0DL0Au8AhcLzKZk9eTrDusp0eHZmM1q6FrEQ6+PL2UFTouqYbn0NMx9fhlYkSZkElc40K9C8fuvqrl8ri6yajnQND7qkebTI7xF6JjIRKpWTm24f4ny2HbUaJxEDxXf31XBY1CAIE/cGKgRqsHTvvw9k1JceQkxObofpQ2eE9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871897; c=relaxed/simple;
	bh=/VSSXRZ1zlAZCJjZVtuKCEKvGJrUIfk49M8uwJbzjsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoft6sXq2xtMlrlpELNj9eSOaUeTAFOEj0Lp9f45WZ6NQmwY0T73Y7FvrVCJsVE4cmeaXj80i6mq8zTdiD5JcLpMsmq4cD63IL8N2jIx3WpNrcwynyDifOOcE2tRNfziQB+HMTBGr5liHvOTZmYlbLd9iWAt4w6eeWv3SrxgDas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwhgfWfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B6AC2BCB1;
	Mon, 30 Mar 2026 11:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774871896;
	bh=/VSSXRZ1zlAZCJjZVtuKCEKvGJrUIfk49M8uwJbzjsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BwhgfWfBAgrhZ64xcS3BzZ80zkJFPiEdgP1aqbgnWTvm5GOUgh2GhvrUg4obNpSXt
	 CzE3VaVd19xuYUwh1MvPRrYftYvxLaMgkcfWjIU0V3WGy7FPKVZhAl+Nuna6NWzhg/
	 HnzTGIeluUiagKDCuxq3T2+g6sBbPXxY3ySnKN0Q/CT7czXySt92WSSYu0rHNk3Pn6
	 N+WAyYYZWS0dpiSuyW4CdTGdDX5CHGXK4QosfqpRTvGuvaazArlAbhAKE7iyJqSZ1N
	 ly5JRlBsT9i7c0W2HxLcdO77UP4ExK5DJBUtNuNyWD6lfEJQycQeMSvpeMONVz1/Xg
	 ou9VJoIz0GIPw==
Date: Mon, 30 Mar 2026 14:58:10 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, shirazsaleem@microsoft.com,
	longli@microsoft.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 1/1] RDMA/mana_ib: memory windows
Message-ID: <20260330115810.GU814676@unreal>
References: <20260318172323.1416803-1-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318172323.1416803-1-kotaranov@linux.microsoft.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18783-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 5808A35ACDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 10:23:23AM -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Implement .alloc_mw() and .dealloc_mw() for mana device.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
> v2: fixed comments. Cleaned up the use of mana_gd_send_request()
>  drivers/infiniband/hw/mana/device.c  |  3 ++
>  drivers/infiniband/hw/mana/mana_ib.h |  8 +++++
>  drivers/infiniband/hw/mana/mr.c      | 53 +++++++++++++++++++++++++++-
>  include/net/mana/gdma.h              |  5 +++
>  4 files changed, 68 insertions(+), 1 deletion(-)

<...>

> +static int mana_ib_gd_create_mw(struct mana_ib_dev *dev, struct mana_ib_pd *pd, struct ib_mw *ibmw)
> +{
> +	struct mana_ib_mw *mw = container_of(ibmw, struct mana_ib_mw, ibmw);
> +	struct gdma_context *gc = mdev_to_gc(dev);
> +	struct gdma_create_mr_response resp = {};
> +	struct gdma_create_mr_request req = {};
> +	int err;
> +
> +	mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_MR, sizeof(req), sizeof(resp));
> +	req.pd_handle = pd->pd_handle;

Both sashiko, which runs on Gemnini https://sashiko.dev/#/patchset/20260318172323.1416803-1-kotaranov@linux.microsoft.com
and my local claude checks pointed to the same area of the code:

   25 > +     mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_MR, sizeof(req), sizeof(resp));
   26 > +     req.pd_handle = pd->pd_handle;
   27
   28 mana_gd_init_req_hdr() sets msg_version to GDMA_MESSAGE_V1.
   29 mana_ib_gd_create_mr() explicitly upgrades this to GDMA_MESSAGE_V2
   30 for all GDMA_CREATE_MR requests, regardless of mr_type:
   31
   32 mana_ib_gd_create_mr() {
   33         mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_MR, ...);
   34         req.hdr.req.msg_version = GDMA_MESSAGE_V2;
   35         ...
   36 }
   37
   38 Is it intentional that mana_ib_gd_create_mw() sends GDMA_CREATE_MR
   39 at GDMA_MESSAGE_V1 rather than GDMA_MESSAGE_V2?

Thanks

