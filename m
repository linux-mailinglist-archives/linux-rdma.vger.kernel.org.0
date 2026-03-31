Return-Path: <linux-rdma+bounces-18847-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHV9BKXQy2mILwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18847-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 15:48:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6B536A7FE
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 15:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE21630225E9
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 13:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B989E3D9DA0;
	Tue, 31 Mar 2026 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8HoAgLX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD5C336EC9;
	Tue, 31 Mar 2026 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774964898; cv=none; b=ls+2Gef/M/CY+VkU/z3Jo6ynQygmhS3RGkhLwmt4ln3COxpwLGjxk+LcUCoudrTlt4cv4shyAgh1jQIGE+FRzb0iMdfNrZgNsoDaeH6Wb7c1B4cBRNGZq5+KEa3yyojkuI7xkiEalPlER7eeWg9jVPbFTNHw5HTBFk3xpA3szbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774964898; c=relaxed/simple;
	bh=Vjrt46tholdVr1WjMzDE6cv0w5LtS1fEvNbaDtL/mYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+IYbMqQOiUOIvNBe3ySZrF+8ULArD5sO/+G5E05t5JdirXLhUfmhS+vBRACZ9jLBBUMorbPiAj4PiccxytU89NHAhdd4bUMO0llsg0pzp4VpAyNxqyNh92A/6GUIeuv9OQTLQrcFZrrHTbSiY9gV7os+pSjHPLrPf0EwEFRzBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8HoAgLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0292C19423;
	Tue, 31 Mar 2026 13:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774964898;
	bh=Vjrt46tholdVr1WjMzDE6cv0w5LtS1fEvNbaDtL/mYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P8HoAgLXMdcxU05J77kNJS6C0RFmMcH75W2NzhwnwNZn34aV8iJvYlM3SCszJkS2w
	 8khqhXg81CRBsJl0qlsWi8tKhShWqE13fRyZErMhYcOxkwAaOBvxHK7Avk6NNkzJo7
	 rYKiMHDG2kW/Vt+zmW1TEJnRGU4+T8LQXi/bj2+4iZUDEXk+HCAsRcgduwMJpOr10P
	 AhKtzYVilyVMaWiE7lMAW1GxYfvYAOfULy46HwmQixIedTUyIA9rwXeNo4BMpOO+U1
	 0b1RZPMw8zSiTYGsWsaqKGj4O6f2S9508O5uXGbM0g8246Q1fzI0YSyD1OK//37OPw
	 xWukA8wnM7c2A==
Date: Tue, 31 Mar 2026 16:48:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Haggai Eran <haggaie@mellanox.com>,
	Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/mlx5: Clarify success return path in
 mlx5_ib_alloc_transport_domain
Message-ID: <20260331134813.GE814676@unreal>
References: <20260331012806.10077-1-prathameshdeshpande7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331012806.10077-1-prathameshdeshpande7@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18847-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: AF6B536A7FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 02:28:06AM +0100, Prathamesh Deshpande wrote:
> In mlx5_ib_alloc_transport_domain(), the function returns 'err' if
> loopback enablement is skipped. At this point, 'err' is always 0
> because the preceding transport domain allocation succeeded.
> 
> Smatch warns that this is a "missing error code" because returning
> a variable instead of a literal 0 in an early-exit path is ambiguous.
> Explicitly return 0 to clarify that this is an intentional success path
> and to improve code robustness.
> 
> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index 635002e684a5..ae4c8ed1c87d 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -2068,7 +2068,7 @@ static int mlx5_ib_alloc_transport_domain(struct mlx5_ib_dev *dev, u32 *tdn,
>  	if ((MLX5_CAP_GEN(dev->mdev, port_type) != MLX5_CAP_PORT_TYPE_ETH) ||
>  	    (!MLX5_CAP_GEN(dev->mdev, disable_local_lb_uc) &&
>  	     !MLX5_CAP_GEN(dev->mdev, disable_local_lb_mc)))
> -		return err;
> +		return 0;

Let's fix it together with AI findings.
https://sashiko.dev/#/patchset/20260331012806.10077-1-prathameshdeshpande7@gmail.com

Thanks

>  
>  	return mlx5_ib_enable_lb(dev, true, false);
>  }
> -- 
> 2.43.0
> 
> 

