Return-Path: <linux-rdma+bounces-16082-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO0hMZvJeGmNtQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16082-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 15:20:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AA295847
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 15:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE1AC3006230
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 14:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0939B33B6FC;
	Tue, 27 Jan 2026 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0dbYMwT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC40C2BE02A;
	Tue, 27 Jan 2026 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523574; cv=none; b=LWlFGcL7bPW3f08j1RHU/KK5PQMEXqpSB4Syls9IBpZBkPHs5yrOTCUD1+bmWlReyLajct+k6Rcz+7OpLcShSX1Sv5Jm0B34uVajAp1AR/SSE12KVnYGzZezplY5mMiBEENd4Q1xUmGbd9SCjQs3HQPs/pVKbqpmZjihhpysVjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523574; c=relaxed/simple;
	bh=viHJjh6LIbvYjL0rcjh5lUrLaxMl+LZACm67W+FPSKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwAo1INKdSA9462sEAeZpvgPccJExWlnp1G4i6JWFpcKyERu9B+3L1CJgeqWtLtBKCnLJc0HDi0Aaz72bG0yFLHyBEG8RUR9tl4i0DhMy5qy/fdl0Hr6aV3frf0olGj/4vuuuDd5bo0G2gE/FjObUfH0t69zNlz8vKm94OBESbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0dbYMwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03967C116C6;
	Tue, 27 Jan 2026 14:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769523574;
	bh=viHJjh6LIbvYjL0rcjh5lUrLaxMl+LZACm67W+FPSKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0dbYMwT77CdBv2Vk24BSd9FNozwePu43Ehc5vpGQzc4j0ieLakhw9EsWSPEgtyQs
	 iZAY3r+3g7FstiQr2xmfisIm3GblzEpA9TA0C6cBI0c9Uo/OQbIymFmPN36bvEWGqo
	 N+4/8dgItMotxpG83mCxS6te8DQRY/uy6Q4ZXcDwOk59lBXpvR/X7xkP8VzSYhQRFI
	 M0Ogy+Wuu7dKAr56vNWaYndm2qd2TNRxTqblsopr9Fh3yWS9o14Tz1o2k4wC34Mu7J
	 IERdNvKMgrc9hoUB847YXJ6nYP9fhrLDfBIVsyqA6hN70ovKOfbYmPpVVE8L+Szhpw
	 SANfvv/3oSliQ==
Date: Tue, 27 Jan 2026 16:19:29 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, shirazsaleem@microsoft.com,
	longli@microsoft.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 1/1] RDMA/mana_ib: device memory support
Message-ID: <20260127141929.GV13967@unreal>
References: <20260127082649.429018-1-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127082649.429018-1-kotaranov@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16082-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0AA295847
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 12:26:49AM -0800, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Basic implementation of DM allowing to create and register
> DM memory and use its memory keys for networking.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
> v2 removed debug prints. Removed comment and made destroy dm to fail,
> which can be useful when mana adds support of binding to DM memory.
>  drivers/infiniband/hw/mana/device.c  |   7 ++
>  drivers/infiniband/hw/mana/mana_ib.h |  12 +++
>  drivers/infiniband/hw/mana/mr.c      | 130 +++++++++++++++++++++++++++
>  include/net/mana/gdma.h              |  47 +++++++++-
>  4 files changed, 193 insertions(+), 3 deletions(-)

<...>

> +	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
> +	if (err || resp.hdr.status) {
> +		if (!err)
> +			err = -EPROTO;
> +
> +		return err;
> +	}

Please submit a patch that adds the `resp.hdr.status` check to  
`mana_gd_send_request()`, and update all callers to rely solely on this  
function's return value.

➜  kernel git:(wip/leon-for-next) git grep -A 1 mana_gd_send_request
...
drivers/infiniband/hw/mana/mr.c:        err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
drivers/infiniband/hw/mana/mr.c-        if (err || resp.hdr.status) {
--
drivers/infiniband/hw/mana/mr.c:        err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
drivers/infiniband/hw/mana/mr.c-        if (err || resp.hdr.status) {
--
drivers/infiniband/hw/mana/mr.c:        err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
drivers/infiniband/hw/mana/mr.c-        if (err || resp.hdr.status) {
....

Thanks


> +
> +	dm->dm_handle = resp.dm_handle;
> +
> +	return 0;
> +}
> +
> +struct ib_dm *mana_ib_alloc_dm(struct ib_device *ibdev,
> +			       struct ib_ucontext *context,
> +			       struct ib_dm_alloc_attr *attr,
> +			       struct uverbs_attr_bundle *attrs)
> +{
> +	struct mana_ib_dev *dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
> +	struct mana_ib_dm *dm;
> +	int err;
> +
> +	dm = kzalloc(sizeof(*dm), GFP_KERNEL);
> +	if (!dm)
> +		return ERR_PTR(-ENOMEM);
> +
> +	err = mana_ib_gd_alloc_dm(dev, dm, attr);
> +	if (err)
> +		goto err_free;
> +
> +	return &dm->ibdm;
> +
> +err_free:
> +	kfree(dm);
> +	return ERR_PTR(err);
> +}
> +
> +static int mana_ib_gd_destroy_dm(struct mana_ib_dev *mdev, struct mana_ib_dm *dm)
> +{
> +	struct gdma_context *gc = mdev_to_gc(mdev);
> +	struct gdma_destroy_dm_resp resp = {};
> +	struct gdma_destroy_dm_req req = {};
> +	int err;
> +
> +	mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_DM, sizeof(req), sizeof(resp));
> +	req.dm_handle = dm->dm_handle;
> +
> +	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
> +	if (err || resp.hdr.status) {
> +		if (!err)
> +			err = -EPROTO;
> +
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +int mana_ib_dealloc_dm(struct ib_dm *ibdm, struct uverbs_attr_bundle *attrs)
> +{
> +	struct mana_ib_dev *dev = container_of(ibdm->device, struct mana_ib_dev, ib_dev);
> +	struct mana_ib_dm *dm = container_of(ibdm, struct mana_ib_dm, ibdm);
> +	int err;
> +
> +	err = mana_ib_gd_destroy_dm(dev, dm);
> +	if (err)
> +		return err;
> +
> +	kfree(dm);
> +	return 0;
> +}
> +
> +struct ib_mr *mana_ib_reg_dm_mr(struct ib_pd *ibpd, struct ib_dm *ibdm,
> +				struct ib_dm_mr_attr *attr,
> +				struct uverbs_attr_bundle *attrs)
> +{
> +	struct mana_ib_dev *dev = container_of(ibpd->device, struct mana_ib_dev, ib_dev);
> +	struct mana_ib_dm *mana_dm = container_of(ibdm, struct mana_ib_dm, ibdm);
> +	struct mana_ib_pd *pd = container_of(ibpd, struct mana_ib_pd, ibpd);
> +	struct gdma_create_mr_params mr_params = {};
> +	struct mana_ib_mr *mr;
> +	int err;
> +
> +	attr->access_flags &= ~IB_ACCESS_OPTIONAL;
> +	if (attr->access_flags & ~VALID_MR_FLAGS)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
> +	if (!mr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mr_params.pd_handle = pd->pd_handle;
> +	mr_params.mr_type = GDMA_MR_TYPE_DM;
> +	mr_params.da.dm_handle = mana_dm->dm_handle;
> +	mr_params.da.offset = attr->offset;
> +	mr_params.da.length = attr->length;
> +	mr_params.da.access_flags =
> +		mana_ib_verbs_to_gdma_access_flags(attr->access_flags);
> +
> +	err = mana_ib_gd_create_mr(dev, mr, &mr_params);
> +	if (err)
> +		goto err_free;
> +
> +	return &mr->ibmr;
> +
> +err_free:
> +	kfree(mr);
> +	return ERR_PTR(err);
> +}
> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> index eaa27483f..8649eb789 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -35,6 +35,8 @@ enum gdma_request_type {
>  	GDMA_CREATE_MR			= 31,
>  	GDMA_DESTROY_MR			= 32,
>  	GDMA_QUERY_HWC_TIMEOUT		= 84, /* 0x54 */
> +	GDMA_ALLOC_DM			= 96, /* 0x60 */
> +	GDMA_DESTROY_DM			= 97, /* 0x61 */
>  };
>  
>  #define GDMA_RESOURCE_DOORBELL_PAGE	27
> @@ -861,6 +863,8 @@ enum gdma_mr_type {
>  	GDMA_MR_TYPE_GVA = 2,
>  	/* Guest zero-based address MRs */
>  	GDMA_MR_TYPE_ZBVA = 4,
> +	/* Device address MRs */
> +	GDMA_MR_TYPE_DM = 5,
>  };
>  
>  struct gdma_create_mr_params {
> @@ -876,6 +880,12 @@ struct gdma_create_mr_params {
>  			u64 dma_region_handle;
>  			enum gdma_mr_access_flags access_flags;
>  		} zbva;
> +		struct {
> +			u64 dm_handle;
> +			u64 offset;
> +			u64 length;
> +			enum gdma_mr_access_flags access_flags;
> +		} da;
>  	};
>  };
>  
> @@ -890,13 +900,23 @@ struct gdma_create_mr_request {
>  			u64 dma_region_handle;
>  			u64 virtual_address;
>  			enum gdma_mr_access_flags access_flags;
> -		} gva;
> +		} __packed gva;
>  		struct {
>  			u64 dma_region_handle;
>  			enum gdma_mr_access_flags access_flags;
> -		} zbva;
> -	};
> +		} __packed zbva;
> +		struct {
> +			u64 dm_handle;
> +			u64 offset;
> +			enum gdma_mr_access_flags access_flags;
> +		} __packed da;
> +	} __packed;
>  	u32 reserved_2;
> +	union {
> +		struct {
> +			u64 length;
> +		} da_ext;
> +	};
>  };/* HW DATA */
>  
>  struct gdma_create_mr_response {
> @@ -915,6 +935,27 @@ struct gdma_destroy_mr_response {
>  	struct gdma_resp_hdr hdr;
>  };/* HW DATA */
>  
> +struct gdma_alloc_dm_req {
> +	struct gdma_req_hdr hdr;
> +	u64 length;
> +	u32 alignment;
> +	u32 flags;
> +}; /* HW Data */
> +
> +struct gdma_alloc_dm_resp {
> +	struct gdma_resp_hdr hdr;
> +	u64 dm_handle;
> +}; /* HW Data */
> +
> +struct gdma_destroy_dm_req {
> +	struct gdma_req_hdr hdr;
> +	u64 dm_handle;
> +}; /* HW Data */
> +
> +struct gdma_destroy_dm_resp {
> +	struct gdma_resp_hdr hdr;
> +}; /* HW Data */
> +
>  int mana_gd_verify_vf_version(struct pci_dev *pdev);
>  
>  int mana_gd_register_device(struct gdma_dev *gd);
> -- 
> 2.43.0
> 

