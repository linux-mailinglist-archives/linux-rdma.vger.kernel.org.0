Return-Path: <linux-rdma+bounces-19454-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLdOBlaJ52kU9wEAu9opvQ
	(envelope-from <linux-rdma+bounces-19454-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 16:27:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E3C43C017
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 16:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E99163021A03
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 14:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B809D3D9021;
	Tue, 21 Apr 2026 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4UhCFK4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759A53D8906;
	Tue, 21 Apr 2026 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781571; cv=none; b=MZrFNYX6zdrQ/cdIwwyhgvveGm1E36+bAa+GKVrLEBsyzv7fP/aISEfQM74OaJzi1AzLlAxlTSDw9HWicQdCQznmwccS6mx0WRzyqVM4gOABZq3OZPz5fBiIJMWyjIedQd3xJVR2/lmwcRQH+Qc7cyct1o+MeAcFGwrmZMtQRDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781571; c=relaxed/simple;
	bh=0RnKxqwFw2DtWwlFTcCVreOiLyVJwetPRsjoYkkIW3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQjsSzWVcNDHXb47dyr7Ec+07uBbhOI79PiYU6I5k2d0uhVlX4vgBJBQa688j/EFDgCxuTYpDaJi16TP+P7dhVSpeKhJQLi3q9RNTnRiTQ2xw60AIxBHv9FSzqt2We3dle7aR+LGLrE4UT6BXO3dE8raztF5Hk99rAsxgvaGjoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4UhCFK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30696C2BCB0;
	Tue, 21 Apr 2026 14:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776781571;
	bh=0RnKxqwFw2DtWwlFTcCVreOiLyVJwetPRsjoYkkIW3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h4UhCFK4vbEl4Wp1gSiv44FJev9LCzWPglxkORJlz9frcLRGe77nkuK2HJKhW629o
	 wRngOskZ4vF5GAjkFfmZJY88ttaV9ulNglyDlbSbyWigFjBO0GueqfYxhReOLgDJrA
	 OA/1NpEWp9ciPPicvJYgGCeSczrQT7syBs7FjZCgJYKs+eofHSE+t5cp5mwYD7xxWj
	 ZrTgfzW+8wOd8jFEDLLUzt7L0Sx9YSBWBhTAJx6LHpfBIcZUN/JmthjaaUoXAA69XO
	 NbSNl08XI9IXI3h3CstvStjyZ0H+VknKC4W1B99Pb7/dohGMUiWdJy1PG7MaJ0qLEB
	 6jB7BrjDb6uPA==
Date: Tue, 21 Apr 2026 07:26:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: Boris Pismenny <borisp@nvidia.com>, "willemdebruijn.kernel@gmail.com"
 <willemdebruijn.kernel@gmail.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "leon@kernel.org"
 <leon@kernel.org>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, Raed Salem <raeds@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, "kees@kernel.org" <kees@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, "edumazet@google.com"
 <edumazet@google.com>, Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed
 <saeedm@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Gal
 Pressman <gal@nvidia.com>
Subject: Re: [PATCH net 1/2] net/mlx5e: psp: Fix invalid access on PSP dev
 registration fail
Message-ID: <20260421072609.4b15e7b9@kernel.org>
In-Reply-To: <f327ce67e69c27ed971f4ed38f46381cd2f97ec7.camel@nvidia.com>
References: <20260417050201.192070-2-tariqt@nvidia.com>
	<20260418190848.204170-1-kuba@kernel.org>
	<d7e2d46769e120a16ce12d345c51a47349733828.camel@nvidia.com>
	<20260420100917.1e4be22a@kernel.org>
	<f327ce67e69c27ed971f4ed38f46381cd2f97ec7.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,lunn.ch,davemloft.net,kernel.org,vger.kernel.org,redhat.com,google.com];
	TAGGED_FROM(0.00)[bounces-19454-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B4E3C43C017
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 21 Apr 2026 12:29:13 +0000 Cosmin Ratiu wrote:
> > Sure but why are you leaving the priv->psp struct in place and
> > whatever
> > FS init has been done? IOW if you really want PSP init to not block
> > probe why is mlx5e_psp_register() a void function rather than
> > mlx5e_psp_init() ? Ignoring errors from psp_dev_create()
> > makes no sense to me - what are you protecting from?
> > kmalloc(GFP_KERNEL)
> > failing?  
> 
> priv->psp and steering at the time of mlx5e_psp_register() is inert
> without the PSP device. Cleaning it on psp_dev_create() failure would
> be weird, it's cleaned up anyway on netdev teardown. The fact that only
> memory allocations can fail inside psp_dev_create() is irrelevant here.
> psp_dev_create() failing shouldn't bring down the whole netdevice, so
> logging a message and continuing is ok (which is what is also done for
> macsec and ktls).

This is a misguided cargo cult. Or something motivated by OOT
compatibility. Alex D sometimes tries to do the same thing with Meta
drivers. I don't get it. Of course we want the device to be operational
if some *device* init fails. The compatibility matrix with all device
generations and fw versions could justify that. But continuing init
when a single-page kmalloc failed is pure silliness.

> mlx5e_psp_register() is void because it's called from
> mlx5e_nic_enable() which can't fail, so it really can't do much other
> than complain to dmesg.
> 
> But while thinking about this, I suppose we could change the entire PSP
> initialization to happen at the time of the current
> mlx5e_psp_register(), and that would simplify the number of states.
> I will do that in the next planned PSP series for net-next.
> 
> Meanwhile, could you please take the 2nd patch and leave this one out?
> It should apply with no conflicts by itself.
> 
> Or you would like to see a separate submission with the 2nd patch
> alone?

Please resubmit.

