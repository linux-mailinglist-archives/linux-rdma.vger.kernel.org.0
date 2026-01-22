Return-Path: <linux-rdma+bounces-15893-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOXsKclicmnfjQAAu9opvQ
	(envelope-from <linux-rdma+bounces-15893-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 18:47:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3255A6BA1C
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 18:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 375483119DF2
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 17:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D3837754C;
	Thu, 22 Jan 2026 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xb7H3R46"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785A736EAA0
	for <linux-rdma@vger.kernel.org>; Thu, 22 Jan 2026 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101827; cv=none; b=h+ow2qPb7DLSEgjMKywmdc8SqfIa2W+gy6hwPl1bhEI3BjY/S//yfPO8GhP2jmOH4IEZlGYmXBKkBZELgbXFUqMvHJ7ZO2kQkU5Zw01KMTiCItr4N54rqz1/GgtIEFADJaE5sRXkr67gPSoCuMpmmzDp3h54w2MG7CP0qu7GAXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101827; c=relaxed/simple;
	bh=zBnvsdfUFIH6H/LwxoLwoZMrEtz3ZRAh9o4fFp4THCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yuye9jsDKwpxwbJ0kKxf/cJfFrILlZNkyA0llqq/eDgqH5SDAKH1LNv3ZeNRKcKCbbYEgcpNJ0AFoghhITMBkNGWEV5LNG64ciS/bmX4Q0RXeDFq0vLhkptbYRLK94N5RsOUusQmJ9S3PvzEAGI1isuJtFGGJeSiYoKBFlO05FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xb7H3R46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFB5C116C6;
	Thu, 22 Jan 2026 17:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769101826;
	bh=zBnvsdfUFIH6H/LwxoLwoZMrEtz3ZRAh9o4fFp4THCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xb7H3R46EVPQ6cPJEWuIIz/9Dk1wHA5X6uwEy1cO5mlCLMjvBSGDeO8ReNKMSrTld
	 WrxI1Td4JqGvgC299rGiVzOMfAi1fe8+tUghJ3Fn/91Rrj6J5g6pzlyx5fB5UqrP1L
	 /Fcu66YXl2i/jFrxH7CQT0Ma7H16XWuFj8YxGCPE=
Date: Thu, 22 Jan 2026 18:10:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yi Liu <liuy22@mails.tsinghua.edu.cn>
Cc: jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
	security@kernel.org
Subject: Re: [PATCH 1/1] RDMA/uverbs: Validate wqe_size before using it in
 ib_uverbs_post_send
Message-ID: <2026012211-curable-issue-0342@gregkh>
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
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15893-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,tsinghua.edu.cn:email]
X-Rspamd-Queue-Id: 3255A6BA1C
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

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

