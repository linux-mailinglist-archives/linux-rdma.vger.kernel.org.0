Return-Path: <linux-rdma+bounces-909-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF15B84971C
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Feb 2024 10:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66EFE1F21AF2
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Feb 2024 09:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724AB12B9D;
	Mon,  5 Feb 2024 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUXixGOG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DF6134A6;
	Mon,  5 Feb 2024 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127052; cv=none; b=Gx6jq+FUstyPqftoUKuxjbk2Vc+QqZatbkkzk0rAQQs0RuNxJue+ptJ+GpImJS8osP2saXDetxLiP4n1TfFaZpStcgoe1Qg6q9dUeEydjV6HWWNE9RgOJO+6ZrlsxPBaNNLUc3mes8sKR6stAEhn2hs8bBIOTefKKeD3fMpI8Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127052; c=relaxed/simple;
	bh=T4MV0Cquf673ToNUKPL+KuFk9ND9SNlaDIwR+oDhlUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rw6Sq9OuRF27BDKgBN+zmY1d3DLjfMIn5Rcx9RYWGRUAbR90D1exFzJVVbSM3ahJVISOzX/hcj0v4wZT/DzEKzwIuNieiTd0EV+buFjw3GqxnWmUVEvvUhCZOQ5xBHL7IJ9JlKoQfy2pqVC6FBwO37llabuwOz7aKYjqcgkbU4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUXixGOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAA7C433C7;
	Mon,  5 Feb 2024 09:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707127051;
	bh=T4MV0Cquf673ToNUKPL+KuFk9ND9SNlaDIwR+oDhlUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MUXixGOGwQ6Q5Mis1EoiJpQKcCaKo3MFUzGj6YiHrNLgQCoFhTtTAQPPQPfPL+XVn
	 lAJ9QhjuaQOQcJLwka1k4rphX3urplulH9NykKEJvWY4kGmhSF3IBH3bCmQ7zGcJoD
	 XK5+xRNbGJU9lpGGBrsA2L2YR1EV0RZBcXKmzbh69yzb+5tRsoeZSyHhB+sdhOm3i4
	 S/2TLVdDoEjVCrE3wWwgtTMZHq6N2+ARG+x3vGrYVnqUx/+TMoQhhy8kgvdHn+fH9F
	 TzBAFhSX3nXemkHk3/+rkhtxbDqYm8X5KzSVtxUgM5wZbxCI3aiulDR9wOS0lP3dPK
	 +6mfgEDR9XC+Q==
Date: Mon, 5 Feb 2024 11:57:27 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH rdma-next v2 2/5] RDMA/mana_ib: Create and
 destroy rnic adapter
Message-ID: <20240205095727.GC6294@unreal>
References: <1706886397-16600-1-git-send-email-kotaranov@linux.microsoft.com>
 <1706886397-16600-3-git-send-email-kotaranov@linux.microsoft.com>
 <20240204123013.GE5400@unreal>
 <DU0PR83MB0553DF0BA184971EDD66DB0EB4402@DU0PR83MB0553.EURPRD83.prod.outlook.com>
 <20240204165152.GH5400@unreal>
 <DU0PR83MB05536AACA6D1E980AD91BD8DB4402@DU0PR83MB0553.EURPRD83.prod.outlook.com>
 <20240205075412.GA6294@unreal>
 <DU0PR83MB05531986447918EBD42EE9A8B4472@DU0PR83MB0553.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR83MB05531986447918EBD42EE9A8B4472@DU0PR83MB0553.EURPRD83.prod.outlook.com>

On Mon, Feb 05, 2024 at 09:15:19AM +0000, Konstantin Taranov wrote:
> > From: Leon Romanovsky <leon@kernel.org>
> > On Sun, Feb 04, 2024 at 05:17:59PM +0000, Konstantin Taranov wrote:
> > > > From: Leon Romanovsky <leon@kernel.org> On Sun, Feb 04, 2024 at
> > > > 03:50:40PM +0000, Konstantin Taranov wrote:
> > > > > > From: Leon Romanovsky <leon@kernel.org> On Fri, Feb 02, 2024 at
> > > > > > 07:06:34AM -0800, Konstantin Taranov wrote:
> > > > > > > This patch adds RNIC creation and destruction.
> > > > > > > If creation of RNIC fails, we support only RAW QPs as they are
> > > > > > > served by ethernet driver.
> > > > > >
> > > > > > So please make sure that you are creating RNIC only when you are
> > > > > > supporting it. The idea that some function tries-and-fails with
> > > > > > dmesg errors is not good idea.
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > >
> > > > > Hi Leon. Thanks for your comments and suggestion. I will
> > > > > incorporate them
> > > > in the next version.
> > > > > Regarding this "try-and-fail", we cannot guarantee now that RNIC
> > > > > is supported, and try-and-fail is the only way to skip RNIC
> > > > > creation without impeding RAW QPs. Could you, please, suggest how
> > > > > we could
> > > > correctly incorporate the "try-and-fail" strategy to get it upstreamed?
> > > >
> > > > You already query NIC for its capabilities, so you can check if it supports
> > RNIC.
> > >
> > > At the moment, the capabilities do not indicate whether RNIC creation will
> > be successful.
> > > The reason is additional checks during RNIC creation that are not reflected
> > in capabilities.
> > > The question is whether we can have the proposed "try and disable" or we
> > must opt for failing the whole mana_ib.
> > 
> > RNIC creation can be seen as an example of any other feature which will be
> > added later, you will never know if it will be successful or not without
> > capabilities.
> > 
> > If you continue with this try-and-fail approach, I afraid that you will end up
> > with whole driver written in this style. Style where you don't separate
> > between "real" failures (wrong configuration, OOM e.t.c) and "expected"
> > failures (feature is not supported).
> > 
> 
> Hi Leon. I understand your concerns and I see how try-and-fail approach can go wrong.
> I think you misunderstood the current HW limitation we have. We *do* distinguish between 
> failures 

This is not what the code is doing, you are ignoring real errors.
The distinguish is usually done by checking the return value of the function after looking
after specific error code returned by FW/HW.

> and this " try-and-fail " will be used once during initialization. As I mentioned above,
> our current HW capabilities cannot reflect whether RNIC is supported. Therefore, we must try
> to create it to understand whether it is really supported. So, if we succeed then the RNIC feature
> is supported and all RNIC-related operations will work. Otherwise, RNIC capability is not present
> and in this case, we just wanted to warn the user about it. If it concerns you, I can remove this warn message. 
> 
> Given the provided explanation, I would appreciate if you wrote whether this approach of querying RNIC support
> could be accepted. 

Unless you have a good explanation why you can add new FW command to configure RNIC, but can't add FW command
to query if RNIC is supported. I'm not keen on adopting this approach.

Thanks

> 
> Thanks!
> 
> > Thanks
> > 
> > >
> > > >
> > > > >
> > > > > > >
> > > > > > > Signed-off-by: Konstantin Taranov
> > > > > > > <kotaranov@linux.microsoft.com>
> > > > > > > ---
> > > > > > >  drivers/infiniband/hw/mana/main.c    | 31
> > > > > > +++++++++++++++++++++++++++++++
> > > > > > >  drivers/infiniband/hw/mana/mana_ib.h | 29
> > > > > > > +++++++++++++++++++++++++++++
> > > > > > >  2 files changed, 60 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/infiniband/hw/mana/main.c
> > > > > > > b/drivers/infiniband/hw/mana/main.c
> > > > > > > index c64d569..33cd69e 100644
> > > > > > > --- a/drivers/infiniband/hw/mana/main.c
> > > > > > > +++ b/drivers/infiniband/hw/mana/main.c
> > > > > > > @@ -581,14 +581,31 @@ static void mana_ib_destroy_eqs(struct
> > > > > > > mana_ib_dev *mdev)
> > > > > > >
> > > > > > >  void mana_ib_gd_create_rnic_adapter(struct mana_ib_dev *mdev)
> > > > > > > {
> > > > > > > +     struct mana_rnic_create_adapter_resp resp = {};
> > > > > > > +     struct mana_rnic_create_adapter_req req = {};
> > > > > > > +     struct gdma_context *gc = mdev_to_gc(mdev);
> > > > > > >       int err;
> > > > > > >
> > > > > > > +     mdev->adapter_handle = INVALID_MANA_HANDLE;
> > > > > > > +
> > > > > > >       err = mana_ib_create_eqs(mdev);
> > > > > > >       if (err) {
> > > > > > >               ibdev_err(&mdev->ib_dev, "Failed to create EQs
> > > > > > > for RNIC err %d",
> > > > > > err);
> > > > > > >               goto cleanup;
> > > > > > >       }
> > > > > > >
> > > > > > > +     mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_ADAPTER,
> > > > > > sizeof(req), sizeof(resp));
> > > > > > > +     req.hdr.req.msg_version = GDMA_MESSAGE_V2;
> > > > > > > +     req.hdr.dev_id = gc->mana_ib.dev_id;
> > > > > > > +     req.notify_eq_id = mdev->fatal_err_eq->id;
> > > > > > > +
> > > > > > > +     err = mana_gd_send_request(gc, sizeof(req), &req,
> > > > > > > + sizeof(resp),
> > > > &resp);
> > > > > > > +     if (err) {
> > > > > > > +             ibdev_err(&mdev->ib_dev, "Failed to create RNIC
> > > > > > > + adapter err %d",
> > > > > > err);
> > > > > > > +             goto cleanup;
> > > > > > > +     }
> > > > > > > +     mdev->adapter_handle = resp.adapter;
> > > > > > > +
> > > > > > >       return;
> > > > > > >
> > > > > > >  cleanup:
> > > > > > > @@ -599,5 +616,19 @@ void
> > > > > > > mana_ib_gd_create_rnic_adapter(struct
> > > > > > > mana_ib_dev *mdev)
> > > > > > >
> > > > > > >  void mana_ib_gd_destroy_rnic_adapter(struct mana_ib_dev
> > > > > > > *mdev)  {
> > > > > > > +     struct mana_rnic_destroy_adapter_resp resp = {};
> > > > > > > +     struct mana_rnic_destroy_adapter_req req = {};
> > > > > > > +     struct gdma_context *gc;
> > > > > > > +
> > > > > > > +     if (!rnic_is_enabled(mdev))
> > > > > > > +             return;
> > > > > > > +
> > > > > > > +     gc = mdev_to_gc(mdev);
> > > > > > > +     mana_gd_init_req_hdr(&req.hdr,
> > MANA_IB_DESTROY_ADAPTER,
> > > > > > sizeof(req), sizeof(resp));
> > > > > > > +     req.hdr.dev_id = gc->mana_ib.dev_id;
> > > > > > > +     req.adapter = mdev->adapter_handle;
> > > > > > > +
> > > > > > > +     mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp),
> > &resp);
> > > > > > > +     mdev->adapter_handle = INVALID_MANA_HANDLE;
> > > > > > >       mana_ib_destroy_eqs(mdev);  } diff --git
> > > > > > > a/drivers/infiniband/hw/mana/mana_ib.h
> > > > > > > b/drivers/infiniband/hw/mana/mana_ib.h
> > > > > > > index a4b94ee..96454cf 100644
> > > > > > > --- a/drivers/infiniband/hw/mana/mana_ib.h
> > > > > > > +++ b/drivers/infiniband/hw/mana/mana_ib.h
> > > > > > > @@ -48,6 +48,7 @@ struct mana_ib_adapter_caps {  struct
> > > > mana_ib_dev {
> > > > > > >       struct ib_device ib_dev;
> > > > > > >       struct gdma_dev *gdma_dev;
> > > > > > > +     mana_handle_t adapter_handle;
> > > > > > >       struct gdma_queue *fatal_err_eq;
> > > > > > >       struct mana_ib_adapter_caps adapter_caps;  }; @@ -115,6
> > > > > > > +116,8 @@ struct mana_ib_rwq_ind_table {
> > > > > > >
> > > > > > >  enum mana_ib_command_code {
> > > > > > >       MANA_IB_GET_ADAPTER_CAP = 0x30001,
> > > > > > > +     MANA_IB_CREATE_ADAPTER  = 0x30002,
> > > > > > > +     MANA_IB_DESTROY_ADAPTER = 0x30003,
> > > > > > >  };
> > > > > > >
> > > > > > >  struct mana_ib_query_adapter_caps_req { @@ -143,6 +146,32 @@
> > > > > > > struct mana_ib_query_adapter_caps_resp {
> > > > > > >       u32 max_inline_data_size;  }; /* HW Data */
> > > > > > >
> > > > > > > +struct mana_rnic_create_adapter_req {
> > > > > > > +     struct gdma_req_hdr hdr;
> > > > > > > +     u32 notify_eq_id;
> > > > > > > +     u32 reserved;
> > > > > > > +     u64 feature_flags;
> > > > > > > +}; /*HW Data */
> > > > > > > +
> > > > > > > +struct mana_rnic_create_adapter_resp {
> > > > > > > +     struct gdma_resp_hdr hdr;
> > > > > > > +     mana_handle_t adapter;
> > > > > > > +}; /* HW Data */
> > > > > > > +
> > > > > > > +struct mana_rnic_destroy_adapter_req {
> > > > > > > +     struct gdma_req_hdr hdr;
> > > > > > > +     mana_handle_t adapter;
> > > > > > > +}; /*HW Data */
> > > > > > > +
> > > > > > > +struct mana_rnic_destroy_adapter_resp {
> > > > > > > +     struct gdma_resp_hdr hdr; }; /* HW Data */
> > > > > > > +
> > > > > > > +static inline bool rnic_is_enabled(struct mana_ib_dev *mdev) {
> > > > > > > +     return mdev->adapter_handle != INVALID_MANA_HANDLE; }
> > > > > > > +
> > > > > > >  static inline struct gdma_context *mdev_to_gc(struct
> > > > > > > mana_ib_dev
> > > > > > > *mdev)  {
> > > > > > >       return mdev->gdma_dev->gdma_context;
> > > > > > > --
> > > > > > > 1.8.3.1
> > > > > > >

