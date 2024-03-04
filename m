Return-Path: <linux-rdma+bounces-1206-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ECB8707FD
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Mar 2024 18:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07EA1F236D6
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Mar 2024 17:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D185E5FDDD;
	Mon,  4 Mar 2024 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXYWqCaW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8611D5FDB0;
	Mon,  4 Mar 2024 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709572032; cv=none; b=rXhzmXSnftERKqcfGjb7u03Hor/1mK5socGtvm20SNZR9hJmSQobtQng8vwv87tekyuAhxswZeoKmzIlYRsMr7SI8SzKph18kPX6sW+MGgI0OUvheMkqakH9uxpEt/raSAXahoktUnyqHUD+rmoKCajKTibz19FiYiVoxdEsoLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709572032; c=relaxed/simple;
	bh=lXtjERnj7O2gxWm2nEqFOD29O6TQACpTdkMEYUhfjZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cv/3xXoINu1FwoApF+d/Vgb+27BJ9TvZ4vO136cbiA2GRhggik5eNK/fE/kdpc+Gr//hDXRRBY0OU/uPTYi1dDnckvt46Et4+qv40AuEiQGNpn1+qwZy/pWP8YECTKedE29h9ebIGg/kaEdQii/6wkco12Ou/Q18v9AlYP5xeZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXYWqCaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CB6C433F1;
	Mon,  4 Mar 2024 17:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709572032;
	bh=lXtjERnj7O2gxWm2nEqFOD29O6TQACpTdkMEYUhfjZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cXYWqCaW2JIaOxS1gttFm9tGZStOXp63YN+FmvcvWMOpoX0DwPC0EnrvisBN8LoMJ
	 E06egE5RPZbZYZy/dOOeHBawGVdI5cCKeZJxVvKVUo0udtER2crgYu75Q6Xn7gSeBC
	 HVpl0uybb8gR0jQf6XSDHqDUKGKWDOmERIx+J3Oln4o49z+g7owYsGIQ7nTyyCh004
	 QnfYh7Kz1RkMuS8sJ7rbHsNsKT7eQz6hGmAhhXwPw+QJErSXWgUiCahKwFFMEkyiwy
	 oYoonTXAxtvjL4J7DXR8bvg9Flxle4EowyPPrh6Op7oCw5P9NXCUToK2HZQS2F6myQ
	 Xi2ZYd1cn39WA==
Date: Mon, 4 Mar 2024 17:07:07 +0000
From: Simon Horman <horms@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com,
	allison.henderson@oracle.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, rds-devel@oss.oracle.com,
	santosh.shilimkar@oracle.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] net/rds: fix WARNING in rds_conn_connect_if_down
Message-ID: <20240304170707.GJ403078@kernel.org>
References: <000000000000c0550506125e4118@google.com>
 <tencent_25067C49AB2EDF6EE5CC95A7FA86C992F806@qq.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_25067C49AB2EDF6EE5CC95A7FA86C992F806@qq.com>

On Sun, Mar 03, 2024 at 12:18:57PM +0800, Edward Adam Davis wrote:
> If connection isn't established yet, get_mr() will fail, trigger connection after
> get_mr().
> 
> Fixes: 584a8279a44a ("RDS: RDMA: return appropriate error on rdma map failures") 
> Reported-and-tested-by: syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  net/rds/rdma.c | 3 +++
>  net/rds/send.c | 6 +-----
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/net/rds/rdma.c b/net/rds/rdma.c
> index fba82d36593a..a4e3c5de998b 100644
> --- a/net/rds/rdma.c
> +++ b/net/rds/rdma.c
> @@ -301,6 +301,9 @@ static int __rds_rdma_map(struct rds_sock *rs, struct rds_get_mr_args *args,
>  			kfree(sg);
>  		}
>  		ret = PTR_ERR(trans_private);
> +		/* Trigger connection so that its ready for the next retry */
> +		if (ret == -ENODEV)
> +			rds_conn_connect_if_down(cp->cp_conn);

Hi Edward,

Elsewhere in this function it is assumed that cp may be NULL.
Does that need to be taken into account here too?

Flagged by Smatch.

>  		goto out;
>  	}
>  
> diff --git a/net/rds/send.c b/net/rds/send.c
> index 5e57a1581dc6..fa1640628b2f 100644
> --- a/net/rds/send.c
> +++ b/net/rds/send.c
> @@ -1313,12 +1313,8 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
>  
>  	/* Parse any control messages the user may have included. */
>  	ret = rds_cmsg_send(rs, rm, msg, &allocated_mr, &vct);
> -	if (ret) {
> -		/* Trigger connection so that its ready for the next retry */
> -		if (ret ==  -EAGAIN)
> -			rds_conn_connect_if_down(conn);
> +	if (ret) 

nit: checkpatch warns that there is a trailing space on the line above.

>  		goto out;
> -	}
>  
>  	if (rm->rdma.op_active && !conn->c_trans->xmit_rdma) {
>  		printk_ratelimited(KERN_NOTICE "rdma_op %p conn xmit_rdma %p\n",

-- 
pw-bot: changes-requested

