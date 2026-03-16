Return-Path: <linux-rdma+bounces-18181-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDB3FtsKuGkWYQEAu9opvQ
	(envelope-from <linux-rdma+bounces-18181-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 14:51:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E774E29AC33
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 14:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 274103061BE9
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 13:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7395739B486;
	Mon, 16 Mar 2026 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uw9R/+PV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952BF39A7F3
	for <linux-rdma@vger.kernel.org>; Mon, 16 Mar 2026 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773668768; cv=none; b=iDFBYs79I9WL4Lz60uHHCY60QHsKKwj+Y2W/yyVmy31GPVD1YToUf3nUDsppEGm5qLnPuGPRUFiyTaMiDIprqjemcveiA8bXpjZOEwMkcACIn+Ifz42c4jN344PRuTZGTQ6hxl1Hy6GjTwCFH7lENItzstgrYXFS8Mi5kVIB+0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773668768; c=relaxed/simple;
	bh=KDXj3Hwau+w9Po4BYDPpezR1wc/k1bzIy3CyeSGKk0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNU0z39b4EMtmb/5JhA2sIGFSFPJFOnmhJro5z0mo7T+zdgkNCxRAQj8p4YCEdvzI7exnFB/o84oYlfzdcDtPnTEZx1RCLcafup7VWsEwPAWyxDl/mBiXoXjfABq/WTtmTXYwmcZy2/YK9T3PLFu8ZZRgJkxWNwCeya14pmx9BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uw9R/+PV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C5EC19421;
	Mon, 16 Mar 2026 13:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773668768;
	bh=KDXj3Hwau+w9Po4BYDPpezR1wc/k1bzIy3CyeSGKk0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uw9R/+PVvHImn1KZv+O7qHV7DcE/H9gE01rc6jICxdnaOQ1gU/oLKJejt9G9rYuWH
	 UYznhW+rkKgzPwaskyHwn5PQJRpmOco0v3BzT+BTILNT0QZXPmM5S5L/xpICtCEFSL
	 vHfIcmMDk5p3OhmINKRyq7MeOSaf1JfmdvIO0CRqn95W78LEhH9HYmmPGJ9tQXdx6P
	 /7g92aiC5Nca5/fbabuX5nZttAtc+b1lgYFonY0HFeQbmT8Ba6cK7pMktkEyDKwfgA
	 ChRu4+ISV2uo9bKH6G+1F9ABKnJ/5fRCsX71D/1LZnaiKlH66oodTImYL+Zqzaq6Dr
	 mCE5enfE2oIDQ==
Date: Mon, 16 Mar 2026 15:46:02 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: jgg@ziepe.ca, Dean Luick <dean.luick@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/core: Add writev to uverbs file descriptor
Message-ID: <20260316134602.GA61385@unreal>
References: <177325041723.52970.2153579331168741909.stgit@awdrv-04.cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177325041723.52970.2153579331168741909.stgit@awdrv-04.cornelisnetworks.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18181-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E774E29AC33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 01:33:37PM -0400, Dennis Dalessandro wrote:
> From: Dean Luick <dean.luick@cornelisnetworks.com>
> 
> Add a writev pass-through between the uverbs file descriptor and
> infiniband devices.  Interested devices may subscribe to this
> functionality.
> 
> The goal is to keep all the semantics of the user interface the same so
> it's an easy migration to the uverbs cdev from the private cdev. The idea
> is that all the command and control is still ioctl, but the "data path" is
> still using the writev() to pass in the iovecs.
> 
> Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> 
> ---
> Changes since v1:
> Updated commit message to indiate why we are keeping the
> writev semantic.
> ---
>  drivers/infiniband/core/device.c      |    1 +
>  drivers/infiniband/core/uverbs_main.c |   22 ++++++++++++++++++++++
>  include/rdma/ib_verbs.h               |    2 ++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 1b5f1ee0a557..e94aebea16e1 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2805,6 +2805,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
>  	SET_DEVICE_OP(dev_ops, set_vf_link_state);
>  	SET_DEVICE_OP(dev_ops, ufile_hw_cleanup);
>  	SET_DEVICE_OP(dev_ops, report_port_event);
> +	SET_DEVICE_OP(dev_ops, write_iter);
>  
>  	SET_OBJ_SIZE(dev_ops, ib_ah);
>  	SET_OBJ_SIZE(dev_ops, ib_counters);
> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> index 7b68967a6301..b393d3a0f11c 100644
> --- a/drivers/infiniband/core/uverbs_main.c
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -713,6 +713,26 @@ static int ib_uverbs_mmap(struct file *filp, struct vm_area_struct *vma)
>  	return ret;
>  }
>  
> +static ssize_t ib_uverbs_write_iter(struct kiocb *kiocb, struct iov_iter *from)
> +{
> +	struct ib_uverbs_file *file = kiocb->ki_filp->private_data;
> +	struct ib_ucontext *ucontext;
> +	ssize_t ret = -EOPNOTSUPP;
> +	int srcu_key;

I see that this function is modeled after ib_uverbs_mmap(), not
ib_uverbs_write(). Why is ib_safe_file_access(ki_filp) not used here?

Also, this should be documented as a narrow, migration‑only path for the
legacy hfi1 driver, and it must not be used by any other new code.

Thanks

