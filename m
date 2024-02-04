Return-Path: <linux-rdma+bounces-890-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9AE848F69
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Feb 2024 17:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE699281FC3
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Feb 2024 16:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3536A2374C;
	Sun,  4 Feb 2024 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgRKvVdQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D2022F08;
	Sun,  4 Feb 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707065518; cv=none; b=Fv68d7yV4UO9g4FiNWIPebgWHnhBzK10pPo7KagXGkfR3GXUMUKWmCguWWJ+PIm3QzbpX4bX9f4LhE7RJYHvPDuOTca2irHt6EYpDnT/tg19Xi2ZAQEjZUmZR8sDOEkVRmwnHEbtaVOFjSG+vsI0Mio4yw2LgGUGBGbnP3+KNPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707065518; c=relaxed/simple;
	bh=heJUHoTjXjhk5+FF7eXTqd/UoiUQjPIUOTL/veOuRnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOQ9KpG5JSmmBKVsxxJfwmKmnrQugn8Mv4/ZXn/S39n2ZlpMRVDRP/TwZb/iXmQcb4cbqU8zJJfdWSQAscQk6EouX8JGWBmNPQusl6BvOx2thYa7Orez3Uc/SiGppy5Np7VHDLlYJUTWbc1Xw9GYhG9jWah4nV/yrHYxBy9NryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgRKvVdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BEFC433F1;
	Sun,  4 Feb 2024 16:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707065517;
	bh=heJUHoTjXjhk5+FF7eXTqd/UoiUQjPIUOTL/veOuRnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SgRKvVdQSHACuwJdWERFbPA/Dvj/WbWs/Xse09te/I2ZcyyF9JSjhH7r2C6DFIRjQ
	 nXCU/6wzl1RCx4yL7gZEY5KtNWxwGUqYrNWmXuolAAxlVPtE9RjaAFB25nIoklYg0U
	 07sQRB0WyuzHuJLBKhSmtS+MuzglhOAFGzu/pdmmYjTybJJ59+ewwGXO4+86P9OoLt
	 +R2sNOkpKXm8OjOQvVOOZdua4pJ6xjTC3s4WsnRfBGk3qhQeKJv3dY3/z/e/tXpHSS
	 S30ge3eQx7MV9utJpih3xBFQt9Im+wHBjE+kqQqGkdoMNqeRLR5jcz90cw//GhCZH9
	 cy+a0I2sLLSgQ==
Date: Sun, 4 Feb 2024 18:51:52 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH rdma-next v2 2/5] RDMA/mana_ib: Create and
 destroy rnic adapter
Message-ID: <20240204165152.GH5400@unreal>
References: <1706886397-16600-1-git-send-email-kotaranov@linux.microsoft.com>
 <1706886397-16600-3-git-send-email-kotaranov@linux.microsoft.com>
 <20240204123013.GE5400@unreal>
 <DU0PR83MB0553DF0BA184971EDD66DB0EB4402@DU0PR83MB0553.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR83MB0553DF0BA184971EDD66DB0EB4402@DU0PR83MB0553.EURPRD83.prod.outlook.com>

On Sun, Feb 04, 2024 at 03:50:40PM +0000, Konstantin Taranov wrote:
> > From: Leon Romanovsky <leon@kernel.org>
> > On Fri, Feb 02, 2024 at 07:06:34AM -0800, Konstantin Taranov wrote:
> > > This patch adds RNIC creation and destruction.
> > > If creation of RNIC fails, we support only RAW QPs as they are served
> > > by ethernet driver.
> > 
> > So please make sure that you are creating RNIC only when you are supporting
> > it. The idea that some function tries-and-fails with dmesg errors is not good
> > idea.
> > 
> > Thanks
> > 
> 
> Hi Leon. Thanks for your comments and suggestion. I will incorporate them in the next version.
> Regarding this "try-and-fail", we cannot guarantee now that RNIC is supported, and try-and-fail is the only way
> to skip RNIC creation without impeding RAW QPs. Could you, please, suggest how we could correctly incorporate
> the "try-and-fail" strategy to get it upstreamed?

You already query NIC for its capabilities, so you can check if it supports RNIC.

> 
> > >
> > > Signed-off-by: Konstantin Taranov <kotaranov@linux.microsoft.com>
> > > ---
> > >  drivers/infiniband/hw/mana/main.c    | 31
> > +++++++++++++++++++++++++++++++
> > >  drivers/infiniband/hw/mana/mana_ib.h | 29
> > > +++++++++++++++++++++++++++++
> > >  2 files changed, 60 insertions(+)
> > >
> > > diff --git a/drivers/infiniband/hw/mana/main.c
> > > b/drivers/infiniband/hw/mana/main.c
> > > index c64d569..33cd69e 100644
> > > --- a/drivers/infiniband/hw/mana/main.c
> > > +++ b/drivers/infiniband/hw/mana/main.c
> > > @@ -581,14 +581,31 @@ static void mana_ib_destroy_eqs(struct
> > > mana_ib_dev *mdev)
> > >
> > >  void mana_ib_gd_create_rnic_adapter(struct mana_ib_dev *mdev)  {
> > > +     struct mana_rnic_create_adapter_resp resp = {};
> > > +     struct mana_rnic_create_adapter_req req = {};
> > > +     struct gdma_context *gc = mdev_to_gc(mdev);
> > >       int err;
> > >
> > > +     mdev->adapter_handle = INVALID_MANA_HANDLE;
> > > +
> > >       err = mana_ib_create_eqs(mdev);
> > >       if (err) {
> > >               ibdev_err(&mdev->ib_dev, "Failed to create EQs for RNIC err %d",
> > err);
> > >               goto cleanup;
> > >       }
> > >
> > > +     mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_ADAPTER,
> > sizeof(req), sizeof(resp));
> > > +     req.hdr.req.msg_version = GDMA_MESSAGE_V2;
> > > +     req.hdr.dev_id = gc->mana_ib.dev_id;
> > > +     req.notify_eq_id = mdev->fatal_err_eq->id;
> > > +
> > > +     err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
> > > +     if (err) {
> > > +             ibdev_err(&mdev->ib_dev, "Failed to create RNIC adapter err %d",
> > err);
> > > +             goto cleanup;
> > > +     }
> > > +     mdev->adapter_handle = resp.adapter;
> > > +
> > >       return;
> > >
> > >  cleanup:
> > > @@ -599,5 +616,19 @@ void mana_ib_gd_create_rnic_adapter(struct
> > > mana_ib_dev *mdev)
> > >
> > >  void mana_ib_gd_destroy_rnic_adapter(struct mana_ib_dev *mdev)  {
> > > +     struct mana_rnic_destroy_adapter_resp resp = {};
> > > +     struct mana_rnic_destroy_adapter_req req = {};
> > > +     struct gdma_context *gc;
> > > +
> > > +     if (!rnic_is_enabled(mdev))
> > > +             return;
> > > +
> > > +     gc = mdev_to_gc(mdev);
> > > +     mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_ADAPTER,
> > sizeof(req), sizeof(resp));
> > > +     req.hdr.dev_id = gc->mana_ib.dev_id;
> > > +     req.adapter = mdev->adapter_handle;
> > > +
> > > +     mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
> > > +     mdev->adapter_handle = INVALID_MANA_HANDLE;
> > >       mana_ib_destroy_eqs(mdev);
> > >  }
> > > diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> > > b/drivers/infiniband/hw/mana/mana_ib.h
> > > index a4b94ee..96454cf 100644
> > > --- a/drivers/infiniband/hw/mana/mana_ib.h
> > > +++ b/drivers/infiniband/hw/mana/mana_ib.h
> > > @@ -48,6 +48,7 @@ struct mana_ib_adapter_caps {  struct mana_ib_dev {
> > >       struct ib_device ib_dev;
> > >       struct gdma_dev *gdma_dev;
> > > +     mana_handle_t adapter_handle;
> > >       struct gdma_queue *fatal_err_eq;
> > >       struct mana_ib_adapter_caps adapter_caps;  }; @@ -115,6 +116,8
> > > @@ struct mana_ib_rwq_ind_table {
> > >
> > >  enum mana_ib_command_code {
> > >       MANA_IB_GET_ADAPTER_CAP = 0x30001,
> > > +     MANA_IB_CREATE_ADAPTER  = 0x30002,
> > > +     MANA_IB_DESTROY_ADAPTER = 0x30003,
> > >  };
> > >
> > >  struct mana_ib_query_adapter_caps_req { @@ -143,6 +146,32 @@ struct
> > > mana_ib_query_adapter_caps_resp {
> > >       u32 max_inline_data_size;
> > >  }; /* HW Data */
> > >
> > > +struct mana_rnic_create_adapter_req {
> > > +     struct gdma_req_hdr hdr;
> > > +     u32 notify_eq_id;
> > > +     u32 reserved;
> > > +     u64 feature_flags;
> > > +}; /*HW Data */
> > > +
> > > +struct mana_rnic_create_adapter_resp {
> > > +     struct gdma_resp_hdr hdr;
> > > +     mana_handle_t adapter;
> > > +}; /* HW Data */
> > > +
> > > +struct mana_rnic_destroy_adapter_req {
> > > +     struct gdma_req_hdr hdr;
> > > +     mana_handle_t adapter;
> > > +}; /*HW Data */
> > > +
> > > +struct mana_rnic_destroy_adapter_resp {
> > > +     struct gdma_resp_hdr hdr;
> > > +}; /* HW Data */
> > > +
> > > +static inline bool rnic_is_enabled(struct mana_ib_dev *mdev) {
> > > +     return mdev->adapter_handle != INVALID_MANA_HANDLE; }
> > > +
> > >  static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev
> > > *mdev)  {
> > >       return mdev->gdma_dev->gdma_context;
> > > --
> > > 1.8.3.1
> > >

