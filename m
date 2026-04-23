Return-Path: <linux-rdma+bounces-19482-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOokNi+L6WkecwIAu9opvQ
	(envelope-from <linux-rdma+bounces-19482-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 04:59:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FD244C67F
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 04:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78F93302DF64
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 02:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44E53C1991;
	Thu, 23 Apr 2026 02:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rC4iF5Yv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7586A1E98EF;
	Thu, 23 Apr 2026 02:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776913189; cv=none; b=lW/a67WaMOSfkwIGefvK29gRJ+ApdBKCbifylyfkYtG/reLqBI7N+DkaeVnc/DBscLeHlsEEFpwg0AswUeIVFzhbSjEvPevCmPuA4Bo6pjEijPvm7O42LqhrkLQoQiXVSLSz9v/bgprHmtio7b8ulnTvC1E8NuR0IAVti2JrfCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776913189; c=relaxed/simple;
	bh=nrPmGgWOlDO3ud/YqvY9Phquk3C5jLK2y8xKPWW8mwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMvaIq3Z8cuRBOQY8kM+ABDS27CO3b71sKLAnOmFhDLEXqPJhBvQInai+QG0DrpHFO/JjT3pEAeDOSFuB3wHHg7Ph7tXZSWjqwmTiL8cMO2WYuL+keIzDJPL900G6cUkxTyol6afMK37h1cKLUpOYN9+VhVuyOS/uwRP3a+XVSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rC4iF5Yv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F835C19425;
	Thu, 23 Apr 2026 02:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776913189;
	bh=nrPmGgWOlDO3ud/YqvY9Phquk3C5jLK2y8xKPWW8mwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rC4iF5YvZWRWJyCEgxyVVTSFyUnfa5fOr2hQ6Q62jNF5pSsYxDH1sT8b+zr+MtXkz
	 wA6T92x1YuoRaIxr/JLIBKICL+cwTnTlMmWXMAdCLW36LiG4Y0OXivRMz2narxyrDa
	 Ms+oOLBsphUxMwvz9QafBbrfCfNxS0hNcoYvzGp+xzdicxtsKXXLRZ/aAdhCpqn2WG
	 2D/pQHkuW69AnNSRAeypCY275pQTQEDQygpxGcRqN+hBxTQms1336i3T2Hdl3GRJHT
	 AkaoKxF+br+bg0LkEACwUrLoOoSeH99Ugk5wBLoiArKobjyLd3Tf5yJZ1QPr6GJf6C
	 JsK3UHL1ioUhA==
Date: Wed, 22 Apr 2026 19:59:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: Boris Pismenny <borisp@nvidia.com>, "willemdebruijn.kernel@gmail.com"
 <willemdebruijn.kernel@gmail.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "leon@kernel.org"
 <leon@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "edumazet@google.com"
 <edumazet@google.com>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Raed Salem <raeds@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 "kees@kernel.org" <kees@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net 1/2] net/mlx5e: psp: Fix invalid access on PSP dev
 registration fail
Message-ID: <20260422195947.5b5dc5b1@kernel.org>
In-Reply-To: <5167f0714e3ddf750f80740bf2ab18a7bb567b16.camel@nvidia.com>
References: <20260417050201.192070-2-tariqt@nvidia.com>
	<20260418190848.204170-1-kuba@kernel.org>
	<d7e2d46769e120a16ce12d345c51a47349733828.camel@nvidia.com>
	<20260420100917.1e4be22a@kernel.org>
	<f327ce67e69c27ed971f4ed38f46381cd2f97ec7.camel@nvidia.com>
	<20260421072609.4b15e7b9@kernel.org>
	<3ca1bee450608d37cd0f9199ebc44c52c084cb08.camel@nvidia.com>
	<20260421080951.570e6e49@kernel.org>
	<6d96452f67d5b58578f67f97f750101abd4af9f6.camel@nvidia.com>
	<20260421113210.4f6a8eb6@kernel.org>
	<e9d10b11f73c0ff212a5dee0b08d9ca90eca5407.camel@nvidia.com>
	<5167f0714e3ddf750f80740bf2ab18a7bb567b16.camel@nvidia.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,lunn.ch,davemloft.net,kernel.org,vger.kernel.org,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-19482-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70FD244C67F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 22 Apr 2026 15:13:04 +0000 Cosmin Ratiu wrote:
> > > Can you call mlx5e_psp_cleanup() when register fails for now?  
> > 
> > Done for the next version, currently undergoing testing.  
> 
> There's a snag: priv->psp may be accessed concurrently from
> mlx5e_get_stats() -> mlx5e_fold_sw_stats64() so we'd need to play
> tricks with RCU and that goes beyond what a net fix should be: It's a
> redesign of how priv->psp is handled in the driver. There's a risk we
> are missing things, or it becomes more intrusive that what a fix should
> be.

Questionable.

> I would like to ask you: let's please not do this redesign of priv->psp
> in a rush, and leave it for the net-next series I mentioned...
> 
> To reiterate, would you like to take patch 2?

Sure, whatever. But it has to be reposted, of course.

