Return-Path: <linux-rdma+bounces-17479-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALvKKcBZqGlxtgAAu9opvQ
	(envelope-from <linux-rdma+bounces-17479-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:11:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6EA203E48
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF8B130A664F
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 15:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0A435CB73;
	Wed,  4 Mar 2026 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYnTYH81"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8104335CB68;
	Wed,  4 Mar 2026 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639957; cv=none; b=HcPywiKuDMCgxs/245un8Dfu7tvQH+HNv3GNiJSvKymtTCrOPrCXX3xk6ezILkqY9yj4ZKbjJIXGKjLHJhFbad6Fgs3VL76Ze0rvfIbknz6ZefPp+5+blfGjgQ6REiMO4vIVk7Y7cMriUEO0/eDojAYgvi4q/t+T6gFPtgLfnZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639957; c=relaxed/simple;
	bh=7SWqAphbgNzD+cNuMVS49QbrxWWKOv9pCl1uYmkREBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaMXu5lbpHM+b7pLMMN2yrdjLQ/6NAbd37uqMTSWEAoRX7t6vGleGOmOkpyLSBUqqqp3tXixR3/CIidrzvCbKjZDIWl3xCGyCF7xm+Mj9PiEJ2FCNtFlxfkXvfJu/nLKJ9p1IiNfLzanQyFBIEwOQFLcuhf4qSgdSUvbGrpQ+aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYnTYH81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB0EC19423;
	Wed,  4 Mar 2026 15:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772639957;
	bh=7SWqAphbgNzD+cNuMVS49QbrxWWKOv9pCl1uYmkREBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iYnTYH81mJvu+Jb5LHTWOei1gY/rug/5kGYpxaMblpPc3yD/f8wl/rd6ka8QvqHAN
	 7Tx800wW3DS4rNhSedv2ciHeHJZrue6fcUTCeHO7IxiJ49EQo3qgX5fiLsdQwiqS8z
	 yQlwASkoeaIsACALJGZo6lZM+M/B8rDH+1Xe2BvHxPRqkcBERhCFL7Ak98RGWP+BGu
	 3HgeREbLmc/Yd74Libo8gjTsm9AkK2skoHM+lqaKx1GBZwYsILD0TGuS5ZeAGyXNn/
	 gxTPpl6WlVnZhPnhreahT1tB8E+QyRyOg7YSJs7FczLK9x2PFkNtVZ8yFLpBpH4gRr
	 uJipQQNVxof6A==
Date: Wed, 4 Mar 2026 17:59:13 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 1/1] RDMA/mana: Provide a modern CQ creation
 interface
Message-ID: <20260304155913.GH12611@unreal>
References: <20260303124825.301452-1-kotaranov@linux.microsoft.com>
 <20260304110500.GZ12611@unreal>
 <DU8PR83MB09757DD51165365AC8BBB884B47CA@DU8PR83MB0975.EURPRD83.prod.outlook.com>
 <DU8PR83MB09750B39D50595F015641D7DB47CA@DU8PR83MB0975.EURPRD83.prod.outlook.com>
 <DU8PR83MB0975A4114E1CFE0B6BFA2DBBB47CA@DU8PR83MB0975.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU8PR83MB0975A4114E1CFE0B6BFA2DBBB47CA@DU8PR83MB0975.EURPRD83.prod.outlook.com>
X-Rspamd-Queue-Id: AB6EA203E48
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17479-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 02:06:21PM +0000, Konstantin Taranov wrote:
> > > > > The uverbs CQ creation UAPI allows users to supply their own umem
> > > > > for a
> > > > CQ.
> > > > > Update mana to support this workflow while preserving support for
> > > > > creating umem through the legacy interface.
> > > > >
> > > > > To support RDMA objects that own umem, extend
> > > > mana_ib_create_queue()
> > > > > to return the umem to the caller and do not allocate umem if it
> > > > > was allocted by the caller.
> > > > >
> > > > > Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> > > > > ---
> > > > > v2: It is a rework of the patch proposed by Leon
> > > >
> > > > I am curious to know what changes were introduced?
> > >
> > > It is like your patch, but I kept get_umem in mana_ib_create_queue and
> > > introduced ownership.
> > > It made the code simpler and extendable. In your proposal, it was hard
> > > to track the changes and it led to double free of the umem. With new
> > > mana_ib_create_queue() it is clear from the caller what happens and no
> > > special changes in the caller required.
> > >
> > > >
> > > > >  drivers/infiniband/hw/mana/cq.c      | 125 +++++++++++++++++----------
> > > > >  drivers/infiniband/hw/mana/device.c  |   1 +
> > > > >  drivers/infiniband/hw/mana/main.c    |  30 +++++--
> > > > >  drivers/infiniband/hw/mana/mana_ib.h |   5 +-
> > > > >  drivers/infiniband/hw/mana/qp.c      |   5 +-
> > > > >  drivers/infiniband/hw/mana/wq.c      |   3 +-
> > > > >  6 files changed, 111 insertions(+), 58 deletions(-)
> > > > >
> > > > > diff --git a/drivers/infiniband/hw/mana/cq.c
> > > > > b/drivers/infiniband/hw/mana/cq.c index b2749f971..fa951732a
> > > > > 100644
> > > > > --- a/drivers/infiniband/hw/mana/cq.c
> > > > > +++ b/drivers/infiniband/hw/mana/cq.c
> > > > > @@ -8,12 +8,8 @@
> > > > >  int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> > > > > ib_cq_init_attr
> > > > *attr,
> > > > >  		      struct uverbs_attr_bundle *attrs)  {
> > > > > -	struct ib_udata *udata = &attrs->driver_udata;
> > > > >  	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
> > > > > -	struct mana_ib_create_cq_resp resp = {};
> > > > > -	struct mana_ib_ucontext *mana_ucontext;
> > > > >  	struct ib_device *ibdev = ibcq->device;
> > > > > -	struct mana_ib_create_cq ucmd = {};
> > > > >  	struct mana_ib_dev *mdev;
> > > > >  	bool is_rnic_cq;
> > > > >  	u32 doorbell;
> > > > > @@ -26,48 +22,91 @@ int mana_ib_create_cq(struct ib_cq *ibcq,
> > > > > const
> > > > struct ib_cq_init_attr *attr,
> > > > >  	cq->cq_handle = INVALID_MANA_HANDLE;
> > > > >  	is_rnic_cq = mana_ib_is_rnic(mdev);
> > > > >
> > > > > -	if (udata) {
> > > > > -		if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
> > > > > -			return -EINVAL;
> > > > > -
> > > > > -		err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd),
> > > > udata->inlen));
> > > > > -		if (err) {
> > > > > -			ibdev_dbg(ibdev, "Failed to copy from udata for
> > > > create cq, %d\n", err);
> > > > > -			return err;
> > > > > -		}
> > > > > +	if (attr->cqe > U32_MAX / COMP_ENTRY_SIZE / 2 + 1)
> > > > > +		return -EINVAL;
> > > >
> > > > We are talking about kernel verbs. ULPs are not designed to provide
> > > > attributes and recover from random driver limitations.
> > >
> > > I understand, but there was an ask before to add that check as some
> > > automated code verifier detected overflow. So if we remote it, I guess
> > > we get again an ask to fix the potential overflow.
> > >
> > > >
> > > > >
> > > > > -		if ((!is_rnic_cq && attr->cqe > mdev-
> > > > >adapter_caps.max_qp_wr) ||
> > > > > -		    attr->cqe > U32_MAX / COMP_ENTRY_SIZE) {
> > > > > -			ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr-
> > > > >cqe);
> > > > > -			return -EINVAL;
> > > > > -		}
> > > > > +	buf_size = MANA_PAGE_ALIGN(roundup_pow_of_two(attr->cqe *
> > > > COMP_ENTRY_SIZE));
> > > > > +	cq->cqe = buf_size / COMP_ENTRY_SIZE;
> > > > > +	err = mana_ib_create_kernel_queue(mdev, buf_size, GDMA_CQ,
> > > > &cq->queue);
> > > > > +	if (err) {
> > > > > +		ibdev_dbg(ibdev, "Failed to create kernel queue for create cq,
> > > > %d\n", err);
> > > > > +		return err;
> > > > > +	}
> > > > > +	doorbell = mdev->gdma_dev->doorbell;
> > > > >
> > > > > -		cq->cqe = attr->cqe;
> > > > > -		err = mana_ib_create_queue(mdev, ucmd.buf_addr, cq->cqe
> > > > * COMP_ENTRY_SIZE,
> > > > > -					   &cq->queue);
> > > > > +	if (is_rnic_cq) {
> > > > > +		err = mana_ib_gd_create_cq(mdev, cq, doorbell);
> > > > >  		if (err) {
> > > > > -			ibdev_dbg(ibdev, "Failed to create queue for create
> > > > cq, %d\n", err);
> > > > > -			return err;
> > > > > +			ibdev_dbg(ibdev, "Failed to create RNIC cq, %d\n",
> > > > err);
> > > > > +			goto err_destroy_queue;
> > > > >  		}
> > > > >
> > > > > -		mana_ucontext = rdma_udata_to_drv_context(udata, struct
> > > > mana_ib_ucontext,
> > > > > -							  ibucontext);
> > > > > -		doorbell = mana_ucontext->doorbell;
> > > > > -	} else {
> > > > > -		if (attr->cqe > U32_MAX / COMP_ENTRY_SIZE / 2 + 1) {
> > > > > -			ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr-
> > > > >cqe);
> > > > > -			return -EINVAL;
> > > > > -		}
> > > > > -		buf_size = MANA_PAGE_ALIGN(roundup_pow_of_two(attr-
> > > > >cqe * COMP_ENTRY_SIZE));
> > > > > -		cq->cqe = buf_size / COMP_ENTRY_SIZE;
> > > > > -		err = mana_ib_create_kernel_queue(mdev, buf_size,
> > > > GDMA_CQ, &cq->queue);
> > > > > +		err = mana_ib_install_cq_cb(mdev, cq);
> > > > >  		if (err) {
> > > > > -			ibdev_dbg(ibdev, "Failed to create kernel queue for
> > > > create cq, %d\n", err);
> > > > > -			return err;
> > > > > +			ibdev_dbg(ibdev, "Failed to install cq callback, %d\n",
> > > > err);
> > > > > +			goto err_destroy_rnic_cq;
> > > > >  		}
> > > > > -		doorbell = mdev->gdma_dev->doorbell;
> > > > >  	}
> > > > >
> > > > > +	spin_lock_init(&cq->cq_lock);
> > > > > +	INIT_LIST_HEAD(&cq->list_send_qp);
> > > > > +	INIT_LIST_HEAD(&cq->list_recv_qp);
> > > > > +
> > > > > +	return 0;
> > > > > +
> > > > > +err_destroy_rnic_cq:
> > > > > +	mana_ib_gd_destroy_cq(mdev, cq);
> > > > > +err_destroy_queue:
> > > > > +	mana_ib_destroy_queue(mdev, &cq->queue);
> > > > > +
> > > > > +	return err;
> > > > > +}
> > > > > +
> > > > > +int mana_ib_create_user_cq(struct ib_cq *ibcq, const struct
> > > > ib_cq_init_attr *attr,
> > > > > +			   struct uverbs_attr_bundle *attrs) {
> > > > > +	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
> > > > > +	struct ib_udata *udata = &attrs->driver_udata;
> > > > > +	struct mana_ib_create_cq_resp resp = {};
> > > > > +	struct mana_ib_ucontext *mana_ucontext;
> > > > > +	struct ib_device *ibdev = ibcq->device;
> > > > > +	struct mana_ib_create_cq ucmd = {};
> > > > > +	struct mana_ib_dev *mdev;
> > > > > +	bool is_rnic_cq;
> > > > > +	u32 doorbell;
> > > > > +	int err;
> > > > > +
> > > > > +	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
> > > > > +
> > > > > +	cq->comp_vector = attr->comp_vector % ibdev->num_comp_vectors;
> > > > > +	cq->cq_handle = INVALID_MANA_HANDLE;
> > > > > +	is_rnic_cq = mana_ib_is_rnic(mdev);
> > > > > +
> > > > > +	if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata-
> > > > >inlen));
> > > > > +	if (err) {
> > > > > +		ibdev_dbg(ibdev, "Failed to copy from udata for create cq,
> > > > %d\n", err);
> > > > > +		return err;
> > > > > +	}
> > > > > +
> > > > > +	if ((!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) ||
> > > > > +	    attr->cqe > U32_MAX / COMP_ENTRY_SIZE)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	cq->cqe = attr->cqe;
> > > > > +	err = mana_ib_create_queue(mdev, ucmd.buf_addr, cq->cqe *
> > > > COMP_ENTRY_SIZE,
> > > > > +				   &cq->queue, &ibcq->umem);
> > 
> > I just realized that I forgot to handle the case when ibcq->umem == NULL and
> > mana fails later after this call. I need to clean ibcq->umem in this case.
> > I will address that in v3. I am sorry.
> > 
> 
> Hi Leon,
> After re-reading the code, I see that there is no bug in v2 as the umem gets deallocated
> on failure inside the handler of UVERBS_METHOD_CQ_CREATE. I also see that you also had
> the same logic in v1. So, what is your recommendation? Leave v2 logic as is, so mana would
> immediately give ownership of umem to cq->umem, and if mana_ib_create_user_cq() fails at later stage
> it should not clean cq->umem and leave it to the caller handle (i.e., UVERBS_METHOD_CQ_CREATE)
> to clean cq->umem regardless of who created it.
> 
> Or should I make v3, where I will assign umem to cq->umem right before return 0, so that if
> mana_ib_create_user_cq() fails it does not change cq->umem at all.

My suggestion is to stick with my original patch and remove
ib_umem_release(queue->umem) from mana_ib_destroy_queue().

Thanks

> 
> > - Konstantin
> > 
> 
> 

