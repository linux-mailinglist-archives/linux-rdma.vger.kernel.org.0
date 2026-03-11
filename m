Return-Path: <linux-rdma+bounces-18012-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM6UILq6sWmxEwAAu9opvQ
	(envelope-from <linux-rdma+bounces-18012-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 19:55:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F059B268EEC
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 19:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD2673016813
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5E03E63BE;
	Wed, 11 Mar 2026 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcajt2aC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8144B2C1593;
	Wed, 11 Mar 2026 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773255349; cv=none; b=LEf6oy/27F0BYaU4V6v0ArexZgEMDYQ0mRKRGsFqJvbPGedAnvf4bd+M9XwluvHOBZOQ0YeMh1Yj1x79pGd41dlPlDfxOAPV4XZiODXAH3WV0NCYhOPtXRMYtXnczYgeP3fr2PFq7YkTeF47e6xXvJYBTcy5hhMBuSlOb5kws1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773255349; c=relaxed/simple;
	bh=K8SMkg/AAPt8jLf9U9WTxeCA2dqAgio1+ld7aVJrduw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BznOZtbr/Uk8QMYr4ltavEzJsea3zCvBJhdOYfRU4dwnAk5MpGghNsF2bm5JtzFgvnEEcwTM+Le0GZVApYy2CsCiQh9VVJcfJkZljcvZcGPs/gn/8+z0YK6NHrGOzxJaY8HPZMFfpkfg0x6LZBWAjbm5Ih/pXd8BHSVOFjE7/MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcajt2aC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CC5C116C6;
	Wed, 11 Mar 2026 18:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773255348;
	bh=K8SMkg/AAPt8jLf9U9WTxeCA2dqAgio1+ld7aVJrduw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jcajt2aCstQPsdN1REQMFapWI3jj5a2B60TqYoJplJL74VDR74e9a2QGFvxzS590G
	 GLRC2Mb/AqIUAqiwDjA6Ieujo/MxghSmYLsf9P5P0PF3ayB87muw/Y+wX2vcc6Ugyo
	 wtsn2gd3aI6e5zjGMGK5oRa7t4jw+ZgMjUdc8KvnpPi7OAA8oeR+r2JlHuPdeZEFtz
	 OqluOKMQr3jZNqwanr212ThTmdSr3ur0uPq9zln8+2birvIfnpEisjbqUPw2Obqsng
	 w5V75Hyf+XUVcXyr2KoJWl/eJ6wY6is39OScbOyvARYeNJHMMoQ9+t2q7ayp07/Y8j
	 +boPHjMgWbelQ==
Date: Wed, 11 Mar 2026 20:55:44 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 1/1] RDMA/mana: Provide a modern CQ creation
 interface
Message-ID: <20260311185544.GX12611@unreal>
References: <20260303124825.301452-1-kotaranov@linux.microsoft.com>
 <20260304110500.GZ12611@unreal>
 <DU8PR83MB09757DD51165365AC8BBB884B47CA@DU8PR83MB0975.EURPRD83.prod.outlook.com>
 <DU8PR83MB09750B39D50595F015641D7DB47CA@DU8PR83MB0975.EURPRD83.prod.outlook.com>
 <DU8PR83MB0975A4114E1CFE0B6BFA2DBBB47CA@DU8PR83MB0975.EURPRD83.prod.outlook.com>
 <20260304155913.GH12611@unreal>
 <DU8PR83MB0975407CC490BBDBFAAAAC4BB47DA@DU8PR83MB0975.EURPRD83.prod.outlook.com>
 <DU8PR83MB097562AF48B340E71D8E02CFB447A@DU8PR83MB0975.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU8PR83MB097562AF48B340E71D8E02CFB447A@DU8PR83MB0975.EURPRD83.prod.outlook.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18012-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F059B268EEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 01:29:22PM +0000, Konstantin Taranov wrote:
> > > On Wed, Mar 04, 2026 at 02:06:21PM +0000, Konstantin Taranov wrote:
> > > > > > > > The uverbs CQ creation UAPI allows users to supply their own
> > > > > > > > umem for a
> > > > > > > CQ.
> > > > > > > > Update mana to support this workflow while preserving
> > > > > > > > support for creating umem through the legacy interface.
> > > > > > > >
> > > > > > > > To support RDMA objects that own umem, extend
> > > > > > > mana_ib_create_queue()
> > > > > > > > to return the umem to the caller and do not allocate umem if
> > > > > > > > it was allocted by the caller.
> > > > > > > >
> > > > > > > > Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> > > > > > > > ---
> > > > > > > > v2: It is a rework of the patch proposed by Leon
> > > > > > >
> > > > > > > I am curious to know what changes were introduced?
> > > > > >
> > > > > > It is like your patch, but I kept get_umem in
> > > > > > mana_ib_create_queue and introduced ownership.
> > > > > > It made the code simpler and extendable. In your proposal, it
> > > > > > was hard to track the changes and it led to double free of the umem.
> > > > > > With new
> > > > > > mana_ib_create_queue() it is clear from the caller what happens
> > > > > > and no special changes in the caller required.
> > > > > >
> > > > > > >
> > > > > > > >  drivers/infiniband/hw/mana/cq.c      | 125 +++++++++++++++++---
> > ---
> > > ----
> > > > > > > >  drivers/infiniband/hw/mana/device.c  |   1 +
> > > > > > > >  drivers/infiniband/hw/mana/main.c    |  30 +++++--
> > > > > > > >  drivers/infiniband/hw/mana/mana_ib.h |   5 +-
> > > > > > > >  drivers/infiniband/hw/mana/qp.c      |   5 +-
> > > > > > > >  drivers/infiniband/hw/mana/wq.c      |   3 +-
> > > > > > > >  6 files changed, 111 insertions(+), 58 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/infiniband/hw/mana/cq.c
> > > > > > > > b/drivers/infiniband/hw/mana/cq.c index b2749f971..fa951732a
> > > > > > > > 100644
> > > > > > > > --- a/drivers/infiniband/hw/mana/cq.c
> > > > > > > > +++ b/drivers/infiniband/hw/mana/cq.c
> > > > > > > > @@ -8,12 +8,8 @@
> > > > > > > >  int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> > > > > > > > ib_cq_init_attr
> > > > > > > *attr,
> > > > > > > >  		      struct uverbs_attr_bundle *attrs)  {
> > > > > > > > -	struct ib_udata *udata = &attrs->driver_udata;
> > > > > > > >  	struct mana_ib_cq *cq = container_of(ibcq, struct
> > > mana_ib_cq, ibcq);
> > > > > > > > -	struct mana_ib_create_cq_resp resp = {};
> > > > > > > > -	struct mana_ib_ucontext *mana_ucontext;
> > > > > > > >  	struct ib_device *ibdev = ibcq->device;
> > > > > > > > -	struct mana_ib_create_cq ucmd = {};
> > > > > > > >  	struct mana_ib_dev *mdev;
> > > > > > > >  	bool is_rnic_cq;
> > > > > > > >  	u32 doorbell;
> > > > > > > > @@ -26,48 +22,91 @@ int mana_ib_create_cq(struct ib_cq
> > > > > > > > *ibcq, const
> > > > > > > struct ib_cq_init_attr *attr,
> > > > > > > >  	cq->cq_handle = INVALID_MANA_HANDLE;
> > > > > > > >  	is_rnic_cq = mana_ib_is_rnic(mdev);
> > > > > > > >
> > > > > > > > -	if (udata) {
> > > > > > > > -		if (udata->inlen < offsetof(struct mana_ib_create_cq,
> > > flags))
> > > > > > > > -			return -EINVAL;
> > > > > > > > -
> > > > > > > > -		err = ib_copy_from_udata(&ucmd, udata,
> > > min(sizeof(ucmd),
> > > > > > > udata->inlen));
> > > > > > > > -		if (err) {
> > > > > > > > -			ibdev_dbg(ibdev, "Failed to copy from udata
> > > for
> > > > > > > create cq, %d\n", err);
> > > > > > > > -			return err;
> > > > > > > > -		}
> > > > > > > > +	if (attr->cqe > U32_MAX / COMP_ENTRY_SIZE / 2 + 1)
> > > > > > > > +		return -EINVAL;
> > > > > > >
> > > > > > > We are talking about kernel verbs. ULPs are not designed to
> > > > > > > provide attributes and recover from random driver limitations.
> > > > > >
> > > > > > I understand, but there was an ask before to add that check as
> > > > > > some automated code verifier detected overflow. So if we remote
> > > > > > it, I guess we get again an ask to fix the potential overflow.
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > -		if ((!is_rnic_cq && attr->cqe > mdev-
> > > > > > > >adapter_caps.max_qp_wr) ||
> > > > > > > > -		    attr->cqe > U32_MAX / COMP_ENTRY_SIZE) {
> > > > > > > > -			ibdev_dbg(ibdev, "CQE %d exceeding
> > > limit\n", attr-
> > > > > > > >cqe);
> > > > > > > > -			return -EINVAL;
> > > > > > > > -		}
> > > > > > > > +	buf_size = MANA_PAGE_ALIGN(roundup_pow_of_two(attr-
> > > >cqe *
> > > > > > > COMP_ENTRY_SIZE));
> > > > > > > > +	cq->cqe = buf_size / COMP_ENTRY_SIZE;
> > > > > > > > +	err = mana_ib_create_kernel_queue(mdev, buf_size,
> > > GDMA_CQ,
> > > > > > > &cq->queue);
> > > > > > > > +	if (err) {
> > > > > > > > +		ibdev_dbg(ibdev, "Failed to create kernel queue for
> > > create
> > > > > > > > +cq,
> > > > > > > %d\n", err);
> > > > > > > > +		return err;
> > > > > > > > +	}
> > > > > > > > +	doorbell = mdev->gdma_dev->doorbell;
> > > > > > > >
> > > > > > > > -		cq->cqe = attr->cqe;
> > > > > > > > -		err = mana_ib_create_queue(mdev, ucmd.buf_addr,
> > > cq->cqe
> > > > > > > * COMP_ENTRY_SIZE,
> > > > > > > > -					   &cq->queue);
> > > > > > > > +	if (is_rnic_cq) {
> > > > > > > > +		err = mana_ib_gd_create_cq(mdev, cq, doorbell);
> > > > > > > >  		if (err) {
> > > > > > > > -			ibdev_dbg(ibdev, "Failed to create queue for
> > > create
> > > > > > > cq, %d\n", err);
> > > > > > > > -			return err;
> > > > > > > > +			ibdev_dbg(ibdev, "Failed to create RNIC cq,
> > > %d\n",
> > > > > > > err);
> > > > > > > > +			goto err_destroy_queue;
> > > > > > > >  		}
> > > > > > > >
> > > > > > > > -		mana_ucontext = rdma_udata_to_drv_context(udata,
> > > struct
> > > > > > > mana_ib_ucontext,
> > > > > > > > -							  ibucontext);
> > > > > > > > -		doorbell = mana_ucontext->doorbell;
> > > > > > > > -	} else {
> > > > > > > > -		if (attr->cqe > U32_MAX / COMP_ENTRY_SIZE / 2 + 1)
> > > {
> > > > > > > > -			ibdev_dbg(ibdev, "CQE %d exceeding
> > > limit\n", attr-
> > > > > > > >cqe);
> > > > > > > > -			return -EINVAL;
> > > > > > > > -		}
> > > > > > > > -		buf_size =
> > > MANA_PAGE_ALIGN(roundup_pow_of_two(attr-
> > > > > > > >cqe * COMP_ENTRY_SIZE));
> > > > > > > > -		cq->cqe = buf_size / COMP_ENTRY_SIZE;
> > > > > > > > -		err = mana_ib_create_kernel_queue(mdev, buf_size,
> > > > > > > GDMA_CQ, &cq->queue);
> > > > > > > > +		err = mana_ib_install_cq_cb(mdev, cq);
> > > > > > > >  		if (err) {
> > > > > > > > -			ibdev_dbg(ibdev, "Failed to create kernel
> > > queue for
> > > > > > > create cq, %d\n", err);
> > > > > > > > -			return err;
> > > > > > > > +			ibdev_dbg(ibdev, "Failed to install cq callback,
> > > %d\n",
> > > > > > > err);
> > > > > > > > +			goto err_destroy_rnic_cq;
> > > > > > > >  		}
> > > > > > > > -		doorbell = mdev->gdma_dev->doorbell;
> > > > > > > >  	}
> > > > > > > >
> > > > > > > > +	spin_lock_init(&cq->cq_lock);
> > > > > > > > +	INIT_LIST_HEAD(&cq->list_send_qp);
> > > > > > > > +	INIT_LIST_HEAD(&cq->list_recv_qp);
> > > > > > > > +
> > > > > > > > +	return 0;
> > > > > > > > +
> > > > > > > > +err_destroy_rnic_cq:
> > > > > > > > +	mana_ib_gd_destroy_cq(mdev, cq);
> > > > > > > > +err_destroy_queue:
> > > > > > > > +	mana_ib_destroy_queue(mdev, &cq->queue);
> > > > > > > > +
> > > > > > > > +	return err;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +int mana_ib_create_user_cq(struct ib_cq *ibcq, const struct
> > > > > > > ib_cq_init_attr *attr,
> > > > > > > > +			   struct uverbs_attr_bundle *attrs) {
> > > > > > > > +	struct mana_ib_cq *cq = container_of(ibcq, struct
> > > mana_ib_cq, ibcq);
> > > > > > > > +	struct ib_udata *udata = &attrs->driver_udata;
> > > > > > > > +	struct mana_ib_create_cq_resp resp = {};
> > > > > > > > +	struct mana_ib_ucontext *mana_ucontext;
> > > > > > > > +	struct ib_device *ibdev = ibcq->device;
> > > > > > > > +	struct mana_ib_create_cq ucmd = {};
> > > > > > > > +	struct mana_ib_dev *mdev;
> > > > > > > > +	bool is_rnic_cq;
> > > > > > > > +	u32 doorbell;
> > > > > > > > +	int err;
> > > > > > > > +
> > > > > > > > +	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
> > > > > > > > +
> > > > > > > > +	cq->comp_vector = attr->comp_vector % ibdev-
> > > >num_comp_vectors;
> > > > > > > > +	cq->cq_handle = INVALID_MANA_HANDLE;
> > > > > > > > +	is_rnic_cq = mana_ib_is_rnic(mdev);
> > > > > > > > +
> > > > > > > > +	if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
> > > > > > > > +		return -EINVAL;
> > > > > > > > +
> > > > > > > > +	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd),
> > > > > > > > +udata-
> > > > > > > >inlen));
> > > > > > > > +	if (err) {
> > > > > > > > +		ibdev_dbg(ibdev, "Failed to copy from udata for
> > > create cq,
> > > > > > > %d\n", err);
> > > > > > > > +		return err;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	if ((!is_rnic_cq && attr->cqe > mdev-
> > > >adapter_caps.max_qp_wr) ||
> > > > > > > > +	    attr->cqe > U32_MAX / COMP_ENTRY_SIZE)
> > > > > > > > +		return -EINVAL;
> > > > > > > > +
> > > > > > > > +	cq->cqe = attr->cqe;
> > > > > > > > +	err = mana_ib_create_queue(mdev, ucmd.buf_addr, cq->cqe
> > > *
> > > > > > > COMP_ENTRY_SIZE,
> > > > > > > > +				   &cq->queue, &ibcq->umem);
> > > > >
> > > > > I just realized that I forgot to handle the case when ibcq->umem
> > > > > == NULL and mana fails later after this call. I need to clean
> > > > > ibcq->umem in
> > > this case.
> > > > > I will address that in v3. I am sorry.
> > > > >
> > > >
> > > > Hi Leon,
> > > > After re-reading the code, I see that there is no bug in v2 as the
> > > > umem gets deallocated on failure inside the handler of
> > > > UVERBS_METHOD_CQ_CREATE. I also see that you also had the same
> > logic
> > > > in v1. So, what is your recommendation? Leave v2 logic as is, so
> > > > mana would immediately give ownership of umem to cq->umem, and if
> > > > mana_ib_create_user_cq() fails at later stage it should not clean
> > > > cq->umem
> > > and leave it to the caller handle (i.e., UVERBS_METHOD_CQ_CREATE) to
> > > clean
> > > cq->umem regardless of who created it.
> > > >
> > > > Or should I make v3, where I will assign umem to cq->umem right
> > > > before return 0, so that if
> > > > mana_ib_create_user_cq() fails it does not change cq->umem at all.
> > >
> > > My suggestion is to stick with my original patch and remove
> > > ib_umem_release(queue->umem) from mana_ib_destroy_queue().
> > 
> > Unfortunately, this will break the code and will require more boilerplate
> > workarounds.
> > MANA still needs to allocate umem for many objects. I see that we can
> > generalize for CQs, but mana RC QPs use 4 queues at the moment, and I am
> > preparing a patch to have 5th queue for BIND WQEs for RC. Our UC QP will
> > use 3 queues. Having a nice entity as mana queue allows us to have clean
> > code and do not have extra complex conditions to detect whether a mana
> > queue has an umem and the cleanup of mana queue handles that.
> > 
> > My proposal is to keep the nice property of mana queues and just extend the
> > mana_ib_create_queue() to satisfy your requirements without adding
> > burden of special handling umems. As I understand the new API requirement
> > is that umem for a CQ should be owned by the ib core, and that is what the
> > helper
> > achieves: the umem pointer is not stored and assigned to cq->umem directly.
> > The only open question I have is what the requirement for writing an umem
> > to cq->umem is. In your patch, I see that you mutate cq->umem even if
> > mana_ib_create_user_cq() fails. Is it the behavior you need/want/allow and
> > will it be enforced in other IB objects that have one umem (e.g., WQs, SRQs)?
> > As it seems to be allowed in the UVERBS_METHOD_CQ_CREATE  code:
> > 	if (ib_dev->ops.create_user_cq)
> > 		ret = ib_dev->ops.create_user_cq(cq, &attr, attrs);
> > 	else
> > 		ret = ib_dev->ops.create_cq(cq, &attr, attrs);
> > 	if (ret)
> > 		goto err_free;
> > ...
> > err_free:
> > 	ib_umem_release(cq->umem);
> > If it is not expected, you might enforce it by adding WARN_ON(cq->umem !=
> > umem); before ib_umem_release() And I am happy to adjust mana code to
> > satisfy this behavior.
> > 
> > here I am just trying to get a win-win situation where we both can be happy
> > about the code. I looked at your proposal and removing ib_umem_release
> > from mana destroy queue will just add it after mana_ib_destroy_queue() in
> > all code paths except the CQ. As well as we would need to add code to
> > handle failures of ib_umem_get, so keeping it in the helper removes the
> > need to have that. Instead, I would like to make the helper to handle the
> > cases when umem is created by upper stack or is not created but want to be
> > owned by the upper stack. What is more, I would like the helper be general
> > enough to be used for other ib core objects and that is why I would like to
> > know the model so I adjust the helper accordingly.
> 
> Hi Leon! Could you please respond to the question above so I can resend v2 or
> suggest a v3 of this patch. I am asking as I would like to send patches for UC QP
> support in mana_ib and it uses mana_ib_create_queue(). Or should I send UC QP
> patches now with existing mana_ib_create_queue() signature and send a v3 for this patch
> later, where I also fix mana_ib_create_queue() for UC QP handling?

It depends on your readiness. If your UC QP support is complete, send it.

Regarding .create_user_cq(), you are not required to implement it if you
prefer not to. Your driver did not support this callback before my
series. The purpose of .create_user_cq() is to enable handling of
additional UMEM types, such as dmabuf for GPU memory. Later in this
cycle, memfd-based UMEMs will be added to improve ib_umem_get()
performance.

If you want your driver to support these UMEM types, you will need to
follow the API contract: do not call ib_umem_release in the
.create_user_cq() or .destroy_cq() paths.

Thanks

> 
> Thanks
> 
> > 
> > Thanks
> > Konstantin
> > 
> > >
> > > Thanks
> > >
> > > >
> > > > > - Konstantin
> > > > >
> > > >
> > > >

