Return-Path: <linux-rdma+bounces-887-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DAF848D97
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Feb 2024 13:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED211F212CF
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Feb 2024 12:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA90224C2;
	Sun,  4 Feb 2024 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyYjJ83u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D671642F;
	Sun,  4 Feb 2024 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707049818; cv=none; b=CkdDgC1j0turIh2Sw7Ce1YnyK65ReSobWawtOVPm7lPi9Gk1k0YRCuL20QbGjl9SbXLFbpfWcfl3TtHNEbN7jk88uHXddRtMBwy/gl8D7t0al4cpwQnupdSQNzANuZNX/7/wN8HuoavN9/Yigc4Vbj6k5x4qLvFrB6TMmRvzgAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707049818; c=relaxed/simple;
	bh=Pb7/TOXMPhP8wCM0xEbRDHLAVDHixu4nEALYru47Eb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSnGurIHUhs8zYSVDTm5B1X4ai2T9QIlnjtB+4dGP2iI3gtjjignc0RTYMjH5+NQxCrEhyt1aZnmQIDQi/DCN8ihUQBbpK66+AJwCJ9LPYP/p9Q1vcEtIEpOr1wZJiXP5hNRkzHWU6nfNNVYQeQjVWgOlIrY7Awl80enbawJZvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyYjJ83u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FD2C433C7;
	Sun,  4 Feb 2024 12:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707049817;
	bh=Pb7/TOXMPhP8wCM0xEbRDHLAVDHixu4nEALYru47Eb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DyYjJ83ucjaAIB4MujZ+CsY1YG4tLrqtarlfLC0XIc5b9zfIU97s+zkDJCFo/9jQ3
	 cl4iTEmY7c2bIvC9k7xq3UNiY+KUkaJDZ/wwopNsPghhQ3f2dICJHWgztCaiNcTLZD
	 ZJGZ5+E0Yng4crbUT+aRYjxo/nYJ1vgxF1xYv3eLmi/ktsM4PUnGdhgaFav85voZ2o
	 CgxA9jEQmhMbzHIbLdwWffEs0jhdUlrtgMGlB452FzKSKpnOOXPbaqGO/zF0E/A3Op
	 jh5zFD3fSifFSgpg2MZM8+Iu6ZGCrq/mwcz5W0GvX1p3O9nkVrQGoh/7G2OKC/x7si
	 E1I2IfLTFAHXA==
Date: Sun, 4 Feb 2024 14:30:13 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, sharmaajay@microsoft.com, longli@microsoft.com,
	jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 2/5] RDMA/mana_ib: Create and destroy rnic
 adapter
Message-ID: <20240204123013.GE5400@unreal>
References: <1706886397-16600-1-git-send-email-kotaranov@linux.microsoft.com>
 <1706886397-16600-3-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1706886397-16600-3-git-send-email-kotaranov@linux.microsoft.com>

On Fri, Feb 02, 2024 at 07:06:34AM -0800, Konstantin Taranov wrote:
> This patch adds RNIC creation and destruction.
> If creation of RNIC fails, we support only RAW QPs as they are served by
> ethernet driver.

So please make sure that you are creating RNIC only when you are
supporting it. The idea that some function tries-and-fails with dmesg
errors is not good idea.

Thanks

> 
> Signed-off-by: Konstantin Taranov <kotaranov@linux.microsoft.com>
> ---
>  drivers/infiniband/hw/mana/main.c    | 31 +++++++++++++++++++++++++++++++
>  drivers/infiniband/hw/mana/mana_ib.h | 29 +++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
> index c64d569..33cd69e 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -581,14 +581,31 @@ static void mana_ib_destroy_eqs(struct mana_ib_dev *mdev)
>  
>  void mana_ib_gd_create_rnic_adapter(struct mana_ib_dev *mdev)
>  {
> +	struct mana_rnic_create_adapter_resp resp = {};
> +	struct mana_rnic_create_adapter_req req = {};
> +	struct gdma_context *gc = mdev_to_gc(mdev);
>  	int err;
>  
> +	mdev->adapter_handle = INVALID_MANA_HANDLE;
> +
>  	err = mana_ib_create_eqs(mdev);
>  	if (err) {
>  		ibdev_err(&mdev->ib_dev, "Failed to create EQs for RNIC err %d", err);
>  		goto cleanup;
>  	}
>  
> +	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_ADAPTER, sizeof(req), sizeof(resp));
> +	req.hdr.req.msg_version = GDMA_MESSAGE_V2;
> +	req.hdr.dev_id = gc->mana_ib.dev_id;
> +	req.notify_eq_id = mdev->fatal_err_eq->id;
> +
> +	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
> +	if (err) {
> +		ibdev_err(&mdev->ib_dev, "Failed to create RNIC adapter err %d", err);
> +		goto cleanup;
> +	}
> +	mdev->adapter_handle = resp.adapter;
> +
>  	return;
>  
>  cleanup:
> @@ -599,5 +616,19 @@ void mana_ib_gd_create_rnic_adapter(struct mana_ib_dev *mdev)
>  
>  void mana_ib_gd_destroy_rnic_adapter(struct mana_ib_dev *mdev)
>  {
> +	struct mana_rnic_destroy_adapter_resp resp = {};
> +	struct mana_rnic_destroy_adapter_req req = {};
> +	struct gdma_context *gc;
> +
> +	if (!rnic_is_enabled(mdev))
> +		return;
> +
> +	gc = mdev_to_gc(mdev);
> +	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_ADAPTER, sizeof(req), sizeof(resp));
> +	req.hdr.dev_id = gc->mana_ib.dev_id;
> +	req.adapter = mdev->adapter_handle;
> +
> +	mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
> +	mdev->adapter_handle = INVALID_MANA_HANDLE;
>  	mana_ib_destroy_eqs(mdev);
>  }
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
> index a4b94ee..96454cf 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -48,6 +48,7 @@ struct mana_ib_adapter_caps {
>  struct mana_ib_dev {
>  	struct ib_device ib_dev;
>  	struct gdma_dev *gdma_dev;
> +	mana_handle_t adapter_handle;
>  	struct gdma_queue *fatal_err_eq;
>  	struct mana_ib_adapter_caps adapter_caps;
>  };
> @@ -115,6 +116,8 @@ struct mana_ib_rwq_ind_table {
>  
>  enum mana_ib_command_code {
>  	MANA_IB_GET_ADAPTER_CAP = 0x30001,
> +	MANA_IB_CREATE_ADAPTER  = 0x30002,
> +	MANA_IB_DESTROY_ADAPTER = 0x30003,
>  };
>  
>  struct mana_ib_query_adapter_caps_req {
> @@ -143,6 +146,32 @@ struct mana_ib_query_adapter_caps_resp {
>  	u32 max_inline_data_size;
>  }; /* HW Data */
>  
> +struct mana_rnic_create_adapter_req {
> +	struct gdma_req_hdr hdr;
> +	u32 notify_eq_id;
> +	u32 reserved;
> +	u64 feature_flags;
> +}; /*HW Data */
> +
> +struct mana_rnic_create_adapter_resp {
> +	struct gdma_resp_hdr hdr;
> +	mana_handle_t adapter;
> +}; /* HW Data */
> +
> +struct mana_rnic_destroy_adapter_req {
> +	struct gdma_req_hdr hdr;
> +	mana_handle_t adapter;
> +}; /*HW Data */
> +
> +struct mana_rnic_destroy_adapter_resp {
> +	struct gdma_resp_hdr hdr;
> +}; /* HW Data */
> +
> +static inline bool rnic_is_enabled(struct mana_ib_dev *mdev)
> +{
> +	return mdev->adapter_handle != INVALID_MANA_HANDLE;
> +}
> +
>  static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev)
>  {
>  	return mdev->gdma_dev->gdma_context;
> -- 
> 1.8.3.1
> 

