Return-Path: <linux-rdma+bounces-16017-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qP6sGthnd2nCfQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16017-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 14:10:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A7E889FF
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 14:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7297303CD10
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 13:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111C7337B8C;
	Mon, 26 Jan 2026 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPaJ6r1b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC7B3382E3
	for <linux-rdma@vger.kernel.org>; Mon, 26 Jan 2026 13:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432855; cv=none; b=nSBqJGb5MisevtYle2ytL4CVv0PaEVCfMyD0faLBWwQEC7ien5Q0xbTq4qX/q0+gVCd9nqG+U/Rb9K3puFQ97lno1K+pP+llMQPgwzi975DCEv6mjIravJQUUk/a2i0vcHRk5PdKnKGU4GbgUeseKgiS2aMHXpDGSQSLFM75Qho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432855; c=relaxed/simple;
	bh=Btkthq2UJqqKZAhl9oVrZExtchHUrd4/6IOxwmWK+AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glPZHiswcEhE84rvf0Qk+ciKb+mH/V4h5NwvZCJL+rlR7/AxaH0Noug1s3N6f9AzN87I6rYDrPtAyKC+AW011diVfF5qP/ifzXNQKHTpRImozeCkyxRwlVtjKyldQTp8G6bObue9NwBr+jdB+ladINdfhzpdxAi67Dv9dL7aOGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPaJ6r1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979BDC116C6;
	Mon, 26 Jan 2026 13:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769432855;
	bh=Btkthq2UJqqKZAhl9oVrZExtchHUrd4/6IOxwmWK+AM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nPaJ6r1bOjVipcfuyKHqDymq0wp94Metfz9D73TNUdhG/D5ENMRACnBcM/6U1sGGI
	 Xf6l9zacref4hBaYP3BW4tl/fuCHZYcyC78oBGm8L1ubRNWRuI6pcD5B954d7ZDvxB
	 ZljqEFyV4LpMWgLPa7rOwolLunpaGPYdwZbbS1mMEGxOsUA+ynm2gq3+u81AJCNpv6
	 3THxo+qOprWWpXNp8wklVLsdmOqWy6avMoe8KDnlbepEkkhkat1jlVaAC/q46Kxjga
	 CXBBCMX6xqtvWByLz1H+ePLG8zQaegPFux3/xjK1tRX2BQdnnyZAnB5C6NIkK7jYY+
	 kqI+Q8Ub7vFuQ==
Date: Mon, 26 Jan 2026 15:07:30 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Yi Liu <liuy22@mails.tsinghua.edu.cn>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/uverbs: Validate wqe_size before using it in
 ib_uverbs_post_send
Message-ID: <20260126130730.GM13967@unreal>
References: <20260122142900.2356276-1-liuy22@mails.tsinghua.edu.cn>
 <20260122142900.2356276-2-liuy22@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122142900.2356276-2-liuy22@mails.tsinghua.edu.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16017-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tsinghua.edu.cn:email]
X-Rspamd-Queue-Id: C1A7E889FF
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 10:29:00PM +0800, Yi Liu wrote:
> ib_uverbs_post_send() uses cmd.wqe_size from userspace without any
> validation before passing it to kmalloc() and using the allocated
> buffer as struct ib_uverbs_send_wr.
> 
> If a user provides a small wqe_size value (e.g., 1), kmalloc() will
> succeed, but subsequent accesses to user_wr->opcode, user_wr->num_sge,
> and other fields will read beyond the allocated buffer, resulting in
> an out-of-bounds read from kernel heap memory. This could potentially
> leak sensitive kernel information to userspace.
> 
> Additionally, providing an excessively large wqe_size can trigger a
> WARNING in the memory allocation path, as reported by syzkaller.
> 
> This is inconsistent with ib_uverbs_unmarshall_recv() which properly
> validates that wqe_size >= sizeof(struct ib_uverbs_recv_wr) before
> proceeding.
> 
> Add the same validation for ib_uverbs_post_send() to ensure wqe_size
> is at least sizeof(struct ib_uverbs_send_wr).
> 
> Fixes: 67cdb40ca444 ("[IB] uverbs: Implement more commands")

The commit referenced in the "fixes" tag already includes the cmd.wqe_size  
check. The correct commit is c3bea3d2dc53 ("RDMA/uverbs: Use the iterator  
for ib_uverbs_unmarshall_recv()").

In addition, I added _GFP_NOWARN to suppress warnings when a large size is  
provided.

I took this patch and fixed it.

Thanks

> Signed-off-by: Yi Liu <liuy22@mails.tsinghua.edu.cn>
> ---
>  drivers/infiniband/core/uverbs_cmd.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index ce16404cd..a80b95948 100644
> --- a/drivers/infiniband/core/uverbs_cmd.c
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -2049,6 +2049,9 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
>  	if (ret)
>  		return ret;
>  
> +	if (cmd.wqe_size < sizeof(struct ib_uverbs_send_wr))
> +		return -EINVAL;
> +
>  	user_wr = kmalloc(cmd.wqe_size, GFP_KERNEL);
>  	if (!user_wr)
>  		return -ENOMEM;
> -- 
> 2.34.1
> 
> 

