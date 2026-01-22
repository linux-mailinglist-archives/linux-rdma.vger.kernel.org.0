Return-Path: <linux-rdma+bounces-15875-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JHrH+qecWmgKQAAu9opvQ
	(envelope-from <linux-rdma+bounces-15875-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 04:52:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A45C617FA
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 04:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 82246522444
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 03:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AB33921FB;
	Thu, 22 Jan 2026 03:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHwfsX4y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B34393DD6;
	Thu, 22 Jan 2026 03:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769053349; cv=none; b=D1LQa0L1Ul5/+olXs2eghOCOjP3noX9Vhx2E2iSE5cWazOkUdMXM6fBDs2SJXmXMNCLiblXgoCuRdMixyiXJHPRLEKo0y27H9FeWwU6ib9AyIYfeLejlxZ2mvnVUsBJitjxXhw2Rdb2I5yjGzhJYRAXonQrNQANWyuzAhIUJGLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769053349; c=relaxed/simple;
	bh=m71i5XZiMka0DYPEikMpp4G1MVwcK6evQvAL8kViuio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVbktqPDPxsslamXsmjdndSI2t+oBrXTDw9a2p1wuYB8anX4tz2DeTAKnSC9zSKdCkDHvF32cRcn31s4Z/Nb7feD1T2DZenfzWeJEt9hI2Wb9Ts8ILeVLGktkMAj5dCxnffs6zJbdd89XFEGRMKt0GDIT5kR2zpDUY1I1PRHVaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHwfsX4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DA4C116C6;
	Thu, 22 Jan 2026 03:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769053348;
	bh=m71i5XZiMka0DYPEikMpp4G1MVwcK6evQvAL8kViuio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GHwfsX4ypWtH6/2sfXexFJCclQ1J7Gyp+uybADaY2zSQcPBu3/2ES1pd/YZ9sG6OK
	 vMpI7mEgiKhm5FwovsXg6v+ju1JeVGsf3i5kBm+tfi4RoHSacTtYUAjwduyrVyQBVv
	 HkoCvd3cBAxh4gR9Mp2/zfUCgZewRLhXTu87HZludp9ejcxloDB2LjmmRU99epEpRI
	 Pu3TjTGgOWePzSr6yAl39Z+Mq0gK1B8v+T1Yz6Knn9Y75lyxABLiuboIiXjAT7nFIy
	 0nC35HDfGR1gL46SsZIlf7ZjmPbnbTYObQTGLrdnJzHvhDnhuRWVD2eGBAnY1i4UbZ
	 jFja43TH2T/KA==
Date: Wed, 21 Jan 2026 19:42:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: tariqt@nvidia.com
Cc: cratiu@nvidia.com, saeedm@nvidia.com, cjubran@nvidia.com,
 davem@davemloft.net, horms@kernel.org, linux-doc@vger.kernel.org,
 mbloch@nvidia.com, moshe@nvidia.com, jiri@nvidia.com, edumazet@google.com,
 gal@nvidia.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 jiri@resnulli.us, krzk@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, rdunlap@infradead.org, leon@kernel.org,
 corbet@lwn.net
Subject: Re: [net-next,V5,11/15] net/mlx5: Expose a function to clear a
 vport's parent
Message-ID: <20260121194226.43044b20@kernel.org>
In-Reply-To: <20260122034001.2579161-1-kuba@kernel.org>
References: <1768895878-1637182-12-git-send-email-tariqt@nvidia.com>
	<20260122034001.2579161-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,davemloft.net,kernel.org,vger.kernel.org,google.com,lunn.ch,gmail.com,resnulli.us,redhat.com,infradead.org,lwn.net];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15875-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23]
X-Rspamd-Queue-Id: 2A45C617FA
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 19:40:01 -0800 Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net/mlx5e: Skip ESN replay window setup for IPsec crypto offload
> 
> This patch fixes a WARN_ON being triggered for crypto offload by adding
> a check to skip the replay window setup when the offload type is not
> XFRM_DEV_OFFLOAD_PACKET.
> 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> > index a8fb4bec369c..63aa23f5c49e 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> > @@ -430,7 +430,8 @@ void mlx5e_ipsec_build_accel_xfrm_attrs(struct mlx5e_ipsec_sa_entry *sa_entry,
> >  		attrs->replay_esn.esn = sa_entry->esn_state.esn;
> >  		attrs->replay_esn.esn_msb = sa_entry->esn_state.esn_msb;
> >  		attrs->replay_esn.overlap = sa_entry->esn_state.overlap;
> > -		if (attrs->dir == XFRM_DEV_OFFLOAD_OUT)
> > +		if (attrs->dir == XFRM_DEV_OFFLOAD_OUT ||
> > +		    attrs->type != XFRM_DEV_OFFLOAD_PACKET)
> >  			goto skip_replay_window;  
> 
> At this point in mlx5e_ipsec_build_accel_xfrm_attrs(), attrs->type has not
> been initialized yet. The function starts with memset(attrs, 0, ...) which
> sets attrs->type to 0 (XFRM_DEV_OFFLOAD_UNSPECIFIED).
> 
> The assignment attrs->type = x->xso.type happens later after the
> skip_replay_window label. This means the condition attrs->type !=
> XFRM_DEV_OFFLOAD_PACKET evaluates as 0 != 2 which is always true.
> 
> As a result, the replay window setup will be skipped for all inbound
> configurations, not just crypto offload. Should this check use x->xso.type
> instead of attrs->type, or should attrs->type be assigned earlier in the
> function before this check?

Herm, something misfired here, this is a review for the series of fixes
posted on the same day, not for the rate scheduling.

