Return-Path: <linux-rdma+bounces-23062-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B9YdEYVQU2oVZwMAu9opvQ
	(envelope-from <linux-rdma+bounces-23062-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 10:29:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A5F744285
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 10:29:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=j1zTt+tn;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23062-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23062-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFAF1300E39B
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 08:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7275E371CF1;
	Sun, 12 Jul 2026 08:29:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A4C352C35
	for <linux-rdma@vger.kernel.org>; Sun, 12 Jul 2026 08:29:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783844993; cv=none; b=pK8rlkcFC7PiqxdhY6JchrQijmkyDaJQ4mHRLmRPM9mYRDbd4oykwHBWVcEFchDW88E/XykRsvyKop4oOaKsGQANE8pkkg0lCsUrDMt/KF+6SfwQH/ykDg1SmLjpkESV3skuHC8LWhL9sA44jCO5Wr/aFZJPzSHhjVybq3jC53Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783844993; c=relaxed/simple;
	bh=C4fF6bg4G9mnSGarK3QnWD1Cq/+DlbrdRN56In7C5jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLA/cAV/a3jcZHJD50XGGWXnWuJBNQ5EfTvxWWlxyPtVXnTqnX9OAgmrIikqLDb87l3ryzCXBqt7g5slin388X7kmYJ9UY4KPQ+AZNzpkK0kgTiHGY6LMKgY8zPXE2IlVBwrodLBpu7j81esnQK9W3Edex3CwDtkT8AyvJPPyRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1zTt+tn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38931F000E9;
	Sun, 12 Jul 2026 08:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783844991;
	bh=uNOsZ0CjEH4zz7/0xzRSEexQWSLFK8gqG3/we5ry4Yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j1zTt+tnfIv90jQyhMtmYj1oaCYQyY5Jps04lHGwEjiv2Q/0WDxE+rgiDUE772Xbr
	 iQ4S5x9g6Xk6u+8vZW0kHr+ZBNXODNWaokpknQC+q0ttGSiHi5s9v8zQf1kczEL5X0
	 7UmmOpf41HKvGQ5QHAQrP39sp0B/GncvwPrH1I7zrjAiYmno39+Yh90zupp269Wedt
	 Piah2ObC9nhdw/godrQCMpkE3nnHMU/JLNYIighhiL/KBDZtRU3KelN4AlDlpwMub2
	 j7gg7y3vfQunsxwJYhW8DSOt+WbrmwyxIlZSIsrnLJBhDDLlXwi2tburoog9AGfQp2
	 wz2A21sY7tvrQ==
Date: Sun, 12 Jul 2026 11:29:41 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jacob Moroni <jmoroni@google.com>
Cc: tatyana.e.nikolova@intel.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v3 5/7] RDMA/irdma: Use robust udata helper for
 QP creation
Message-ID: <20260712082941.GA33197@unreal>
References: <20260702170652.4159201-1-jmoroni@google.com>
 <20260702170652.4159201-6-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702170652.4159201-6-jmoroni@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23062-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jmoroni@google.com,m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,unreal:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91A5F744285

On Thu, Jul 02, 2026 at 05:06:50PM +0000, Jacob Moroni wrote:
> Replace the manual udata input copy and validation during
> QP creation with the robust helper.
> 
> The irdma driver is backwards compatible with the legacy
> i40iw userspace provider. The current create_qp ABI contains
> two 8 byte fields. The legacy i40iw ABI was the same but
> also contained two additional fields which were never actually
> used. Furthermore, the i40iw userspace provider never explicitly
> zero-initialized those extra fields, so there is a chance that
> existing binaries are passing non-zero garbage values down
> to the kernel.
> 
> Previously, the irdma driver only copied out the first 16
> bytes and did not have any check for the rest of the buffer
> being zero, so that additional garbage didn't matter.
> 
> By switching to ib_copy_validate_udata_in(), we will now be
> checking to ensure that data beyond the kernel's definition
> of the request is all zero.
> 
> In order to avoid breaking legacy binaries, we therefore need
> to increase the request structure size to cover those garbage
> fields.
> 
> - Legacy binaries will continue to pass down a 32 byte request,
>   with the driver copying the entire 32 bytes out but ignoring
>   the second 16 bytes, just as before.
> 
> - Newer binaries will pass down the normal 16 byte request. The
>   ib_copy_validate_udata_in() call will allow this to succeed
>   because we use user_compl_ctx as our minimum length (16 bytes).
> 
> - If the request is ever extended, the new fields would be
>   added after the "don't use" fields and would work as per
>   the normal uAPI mechanism.
> 
> Signed-off-by: Jacob Moroni <jmoroni@google.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 41 ++++++++++++++++-------------
>  include/uapi/rdma/irdma-abi.h       |  1 +
>  2 files changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index 519ac780e9f1..00a648922c7b 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -632,37 +632,29 @@ static void irdma_setup_virt_qp(struct irdma_device *iwdev,
>  
>  /**
>   * irdma_setup_umode_qp - setup sq and rq size in user mode qp
> - * @udata: udata
> + * @ucontext: user context
> + * @req: user request pointer
>   * @iwdev: iwarp device
>   * @iwqp: qp ptr (user or kernel)
>   * @info: initialize info to return
>   * @init_attr: Initial QP create attributes
>   */
> -static int irdma_setup_umode_qp(struct ib_udata *udata,
> +static int irdma_setup_umode_qp(struct irdma_ucontext *ucontext,
> +				struct irdma_create_qp_req *req,
>  				struct irdma_device *iwdev,
>  				struct irdma_qp *iwqp,
>  				struct irdma_qp_init_info *info,
>  				struct ib_qp_init_attr *init_attr)
>  {
> -	struct irdma_ucontext *ucontext = rdma_udata_to_drv_context(udata,
> -				struct irdma_ucontext, ibucontext);
>  	struct irdma_qp_uk_init_info *ukinfo = &info->qp_uk_init_info;
> -	struct irdma_create_qp_req req;
>  	unsigned long flags;
>  	int ret;
>  
> -	ret = ib_copy_from_udata(&req, udata,
> -				 min(sizeof(req), udata->inlen));
> -	if (ret) {
> -		ibdev_dbg(&iwdev->ibdev, "VERBS: ib_copy_from_data fail\n");
> -		return ret;
> -	}
> -
> -	iwqp->ctx_info.qp_compl_ctx = req.user_compl_ctx;
> +	iwqp->ctx_info.qp_compl_ctx = req->user_compl_ctx;
>  	iwqp->user_mode = 1;
>  
>  	spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags);
> -	iwqp->iwpbl = irdma_get_pbl((unsigned long)req.user_wqe_bufs,
> +	iwqp->iwpbl = irdma_get_pbl((unsigned long)req->user_wqe_bufs,
>  				    &ucontext->qp_reg_mem_list);
>  	spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);

Which codebase did you use for this series?

That function differs from the current implementation, which has
remained unchanged since 2023:
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/tree/drivers/infiniband/hw/irdma/verbs.c#n639

Thanks

