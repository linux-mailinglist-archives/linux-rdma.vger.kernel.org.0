Return-Path: <linux-rdma+bounces-16450-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH22Oe3qgWkFMAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16450-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 13:32:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6E5D90DF
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 13:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A52CD30B76D5
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 12:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4F934029C;
	Tue,  3 Feb 2026 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxfSkO5/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43710338931
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121584; cv=none; b=i5UGsHZcP78q1Eyb8dshFdHy0IdbQFUyC2VglCftkdrYEh402cRKrppx0r65S4V1NyuqthCFBiaXH2ckWfPj4FISZ1gNNrf2X9qothEewZzqh6LwZvq/CeI1dRMHOUCIk6xSPHIC59tSICDMVdPbBKpg5LwnCNcg6MVRZQcd9tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121584; c=relaxed/simple;
	bh=6tQ4B7tkoEKVo+hKLJXysY3faRo3TMnngx4WeqcGWdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAXs/jIFOF6O8XnTiEtSuLvNkTOhuZFe1v4idbM0lLwl3FKviucOA9XL0SptQ26yd+dw0lfqp6gPdhadYN65HT2IrViOpJhB6jjUrYG+vsWQKg0gUYzQRn069U28xooLk7rLZw1EKX1u7agZKlhrNyqqMhfnKFVpilFlpknbMRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxfSkO5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3113FC116D0;
	Tue,  3 Feb 2026 12:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770121583;
	bh=6tQ4B7tkoEKVo+hKLJXysY3faRo3TMnngx4WeqcGWdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JxfSkO5/yxUHIcHUieyghvf3dYKQp9NXtM1h4I3yF98J0wPGxjE0PtAgErOYlzPBr
	 Oyfhpm2kwi8ILuDzOF4+0hize9J8LF1E2D2EhltFQqRc8bZeUu15AXnWcEy6cDdp6d
	 uwhMoyJYGp7h2X7GyDRlQPVlgGlHtq47aLCSYpd+7AjNiqLgZtLS3GJkwNCykheyUx
	 lVh1ZpDqBg+dEv1cj/cK3pbZwPdfmGFvPetsHhzrD939zIQ1xTb7bMQxO/Dd2x/lhf
	 0ZoYZgoQMvY0RIddpwIseRY4UOlyYViZfBl8+5RBF0rFx8TtwLYKepmJYo51SQxjpt
	 X96s8+81VQwBw==
Date: Tue, 3 Feb 2026 14:26:18 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, mrgolin@amazon.com,
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com,
	mbloch@nvidia.com, yanjun.zhu@linux.dev, wangliang74@huawei.com,
	marco.crivellari@suse.com, roman.gushchin@linux.dev,
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com,
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com, michaelgur@nvidia.com, shayd@nvidia.com,
	edwards@nvidia.com, sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next 01/10] RDMA/umem: Add reference counting to
 ib_umem
Message-ID: <20260203122618.GT34749@unreal>
References: <20260203085003.71184-1-jiri@resnulli.us>
 <20260203085003.71184-2-jiri@resnulli.us>
 <20260203100327.GS34749@unreal>
 <vw3hrr5fsamtsgydvydoewd4fnglas5xzickgfpjgp5y44gxkm@dmmvo36blqtb>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vw3hrr5fsamtsgydvydoewd4fnglas5xzickgfpjgp5y44gxkm@dmmvo36blqtb>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16450-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D6E5D90DF
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 11:11:39AM +0100, Jiri Pirko wrote:
> Tue, Feb 03, 2026 at 11:03:27AM +0100, leon@kernel.org wrote:
> >On Tue, Feb 03, 2026 at 09:49:53AM +0100, Jiri Pirko wrote:
> >> From: Jiri Pirko <jiri@nvidia.com>
> >> 
> >> Introduce reference counting for ib_umem objects to simplify memory
> >> lifecycle management when umem buffers are shared between the core
> >> layer and device drivers.

The lifecycle should be confined either to the core or to the driver,
but it should not mix responsibilities across both.

> >> 
> >> When the core RDMA layer allocates an ib_umem and passes it to a driver
> >> (e.g., for CQ or QP creation with external buffers), both layers need
> >> to manage the umem lifecycle. Without reference counting, this requires
> >> complex conditional release logic to avoid double-frees on error paths
> >> and leaks on success paths.
> >
> >This sentence doesn't align with the proposed change.
> 
> Hmm, I'm not sure why you think it does not align. It exactly describes
> the code I had it originally without this path in place :)

There is no complex conditional release logic which this reference
counting solves. That counting allows delayed, semi-random release,
nothing more.

> 
> >
> >> 
> >> With reference counting:
> >> - Core allocates umem with refcount=1
> >> - Driver calls ib_umem_get_ref() to take a reference
> >> - Both layers can unconditionally call ib_umem_release()
> >> - The umem is freed only when the last reference is dropped
> >> 
> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> Change-Id: Ifb1765ea3b14dab3329294633ea5df063c74420d
> >
> >Please remove the Change-Ids and write the commit message yourself,
> >without relying on AI. The current message provides no meaningful
> 
> I'm new in RDMA. Not sure what you mean by meaningful information :)

This part of commit message is clearly generated by Cursor:
With reference counting:
- Core allocates umem with refcount=1
- Driver calls ib_umem_get_ref() to take a reference
- Both layers can unconditionally call ib_umem_release()
- The umem is freed only when the last reference is dropped

The above paragraphs have clear AI pattern as they don't explain why,
but only how.

I'm seeing the SAME commit messages in many internals and externals
patches.

Even my AI review is agreed with me :)
...
"AI-authorship-score": "medium"
...

> I'm always trying to provide it.
> 
> >information, particularly the auto‑generated summary at the end.
> 
> Doh, the changeIDs :) Sorry about that.
> 
> 
> >
> >Thanks
> >
> >> ---
> >>  drivers/infiniband/core/umem.c        | 5 +++++
> >>  drivers/infiniband/core/umem_dmabuf.c | 1 +
> >>  drivers/infiniband/core/umem_odp.c    | 3 +++
> >>  include/rdma/ib_umem.h                | 9 +++++++++
> >>  4 files changed, 18 insertions(+)
> >> 
> >> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> >> index 8137031c2a65..09ce694d66ea 100644
> >> --- a/drivers/infiniband/core/umem.c
> >> +++ b/drivers/infiniband/core/umem.c
> >> @@ -192,6 +192,7 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
> >>  	umem = kzalloc(sizeof(*umem), GFP_KERNEL);
> >>  	if (!umem)
> >>  		return ERR_PTR(-ENOMEM);
> >> +	refcount_set(&umem->refcount, 1);
> >>  	umem->ibdev      = device;
> >>  	umem->length     = size;
> >>  	umem->address    = addr;
> >> @@ -280,11 +281,15 @@ EXPORT_SYMBOL(ib_umem_get);
> >>  /**
> >>   * ib_umem_release - release memory pinned with ib_umem_get
> >>   * @umem: umem struct to release
> >> + *
> >> + * Decrement the reference count and free the umem when it reaches zero.
> >>   */
> >>  void ib_umem_release(struct ib_umem *umem)
> >>  {
> >>  	if (!umem)
> >>  		return;
> >> +	if (!refcount_dec_and_test(&umem->refcount))
> >> +		return;
> >>  	if (umem->is_dmabuf)
> >>  		return ib_umem_dmabuf_release(to_ib_umem_dmabuf(umem));
> >>  	if (umem->is_odp)
> >> diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
> >> index 939da49b0dcc..5c5286092fca 100644
> >> --- a/drivers/infiniband/core/umem_dmabuf.c
> >> +++ b/drivers/infiniband/core/umem_dmabuf.c
> >> @@ -143,6 +143,7 @@ ib_umem_dmabuf_get_with_dma_device(struct ib_device *device,
> >>  	}
> >>  
> >>  	umem = &umem_dmabuf->umem;
> >> +	refcount_set(&umem->refcount, 1);
> >>  	umem->ibdev = device;
> >>  	umem->length = size;
> >>  	umem->address = offset;
> >> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
> >> index 572a91a62a7b..7be30fda57e3 100644
> >> --- a/drivers/infiniband/core/umem_odp.c
> >> +++ b/drivers/infiniband/core/umem_odp.c
> >> @@ -144,6 +144,7 @@ struct ib_umem_odp *ib_umem_odp_alloc_implicit(struct ib_device *device,
> >>  	if (!umem_odp)
> >>  		return ERR_PTR(-ENOMEM);
> >>  	umem = &umem_odp->umem;
> >> +	refcount_set(&umem->refcount, 1);
> >>  	umem->ibdev = device;
> >>  	umem->writable = ib_access_writable(access);
> >>  	umem->owning_mm = current->mm;
> >> @@ -185,6 +186,7 @@ ib_umem_odp_alloc_child(struct ib_umem_odp *root, unsigned long addr,
> >>  	if (!odp_data)
> >>  		return ERR_PTR(-ENOMEM);
> >>  	umem = &odp_data->umem;
> >> +	refcount_set(&umem->refcount, 1);
> >>  	umem->ibdev = root->umem.ibdev;
> >>  	umem->length     = size;
> >>  	umem->address    = addr;
> >> @@ -245,6 +247,7 @@ struct ib_umem_odp *ib_umem_odp_get(struct ib_device *device,
> >>  	if (!umem_odp)
> >>  		return ERR_PTR(-ENOMEM);
> >>  
> >> +	refcount_set(&umem_odp->umem.refcount, 1);
> >>  	umem_odp->umem.ibdev = device;
> >>  	umem_odp->umem.length = size;
> >>  	umem_odp->umem.address = addr;
> >> diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
> >> index 0a8e092c0ea8..44264f78eab3 100644
> >> --- a/include/rdma/ib_umem.h
> >> +++ b/include/rdma/ib_umem.h
> >> @@ -10,6 +10,7 @@
> >>  #include <linux/list.h>
> >>  #include <linux/scatterlist.h>
> >>  #include <linux/workqueue.h>
> >> +#include <linux/refcount.h>
> >>  #include <rdma/ib_verbs.h>
> >>  
> >>  struct ib_ucontext;
> >> @@ -19,6 +20,7 @@ struct dma_buf_attach_ops;
> >>  struct ib_umem {
> >>  	struct ib_device       *ibdev;
> >>  	struct mm_struct       *owning_mm;
> >> +	refcount_t		refcount;
> >>  	u64 iova;
> >>  	size_t			length;
> >>  	unsigned long		address;
> >> @@ -110,6 +112,12 @@ static inline bool __rdma_umem_block_iter_next(struct ib_block_iter *biter)
> >>  
> >>  struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
> >>  			    size_t size, int access);
> >> +
> >> +static inline void ib_umem_get_ref(struct ib_umem *umem)
> >> +{
> >> +	refcount_inc(&umem->refcount);
> >> +}
> >> +
> >>  void ib_umem_release(struct ib_umem *umem);
> >>  int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
> >>  		      size_t length);
> >> @@ -188,6 +196,7 @@ static inline struct ib_umem *ib_umem_get(struct ib_device *device,
> >>  {
> >>  	return ERR_PTR(-EOPNOTSUPP);
> >>  }
> >> +static inline void ib_umem_get_ref(struct ib_umem *umem) { }
> >>  static inline void ib_umem_release(struct ib_umem *umem) { }
> >>  static inline int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
> >>  		      		    size_t length) {
> >> -- 
> >> 2.51.1
> >> 
> >> 

