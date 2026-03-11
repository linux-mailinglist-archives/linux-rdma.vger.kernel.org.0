Return-Path: <linux-rdma+bounces-18029-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0H4AFf/jsWlbGwAAu9opvQ
	(envelope-from <linux-rdma+bounces-18029-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 22:51:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F265226A996
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 22:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6DF9301C6AA
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 21:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6DC34D3BF;
	Wed, 11 Mar 2026 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dx7jFacZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D01C1B4138;
	Wed, 11 Mar 2026 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773265903; cv=none; b=NCnTAVFQWTodrbljYCGXULPFo1pcbV/ezP1ahiNPsznt9pAKR7JS4+YGJFr22l0VOwLnjw98hodoWw+MYtvGkzL9C1jfcq564QcNjP7pswAxJfsj1VWdLyZbjfxao3KNFGuQ2iYGJX5SDabUHCLpiRxvEwfRwqaMaFe/gvrDr8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773265903; c=relaxed/simple;
	bh=Ky9x4Qc7sXMth54WdQkScEx8aBLAUtoTYC5EOd6QHxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kirH1Dxr8ZcCkLz9BShAPPapML9f+calzP99PhVohWbeDFMznko5a6j37001W7iDhPfOx6GyskJHpwNkpZGBB1Xqxb+zD9eZEkFLRRH8c6pzE5+n5zdwIRHEu0Z4SazKmWmxnDpnfPfaerR59ELZh41JngmsffpC+MofqYlb1TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dx7jFacZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E2CC4CEF7;
	Wed, 11 Mar 2026 21:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773265903;
	bh=Ky9x4Qc7sXMth54WdQkScEx8aBLAUtoTYC5EOd6QHxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dx7jFacZSSM5wqhX2HqVl7lUpW0BEE9MOC0zg7RjB5ksIwDxAWiFZ8g3y/bFQrOJU
	 KgyyZReYbkucYayZ/KcL7xAyjIJahjFxos8+5wjc172EkvLwKREPg6fUMCTTHH9e5e
	 0SRr79WK766w8sZqtz4gS07VU1undwunt1g8fnAM8l9uaJP+41+dKTEgKAzgAC6bf/
	 ZZLf4g5j9YtyfB0DJtKhpkgq99a3yhBGia1Y7+OvqI0ggZIZSbgKqyCcmC73P8o5ei
	 3riUM+OF6hL5IX1V96Jb/coHSW0x2b0lzPO3IE2wBzbwAzqmJfj2pYMsEB2v8Ifrtc
	 tyBfX4sVpALLQ==
Date: Wed, 11 Mar 2026 14:51:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Or Har-Toov <ohartoov@nvidia.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Tariq Toukan <tariqt@nvidia.com>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Donald
 Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, Gal Pressman
 <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Shay Drory
 <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>
Subject: Re: [PATCH net-next V3 00/10] devlink: add per-port resource
 support
Message-ID: <20260311145126.7dcca532@kernel.org>
In-Reply-To: <5de5103e-e2e4-4b72-9c3c-22847728fbb8@nvidia.com>
References: <20260226221916.1800227-1-tariqt@nvidia.com>
	<20260302192640.49af074f@kernel.org>
	<pmxkihhtsskkwsvdia4z2ss4wxpfc4a4kqxkjv5wk3mwdmpzii@6go7pizk2nst>
	<jssifysprwuafkinc3dguspngxmplrngqxvotp76vhvu4e5lp6@e7mdrjqc5rme>
	<20260304101522.09da1f58@kernel.org>
	<np44uzfn6jea56uht4yq4te5clapgj7pk6ygyvkl22wxumwnvt@nrpvzjqzxenq>
	<20260305063729.7e40775d@kernel.org>
	<ni23r4jiwgc6zjjsubtl4ujjgxzwpxrylumofdwxgozfnieynm@zirlbneaz6p2>
	<20260306120301.0ebe1ab2@kernel.org>
	<74dcd7c5-8a2b-49a7-a23c-174d17a61955@nvidia.com>
	<20260309133341.7e08b35d@kernel.org>
	<5de5103e-e2e4-4b72-9c3c-22847728fbb8@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18029-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[resnulli.us,nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F265226A996
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 20:24:08 +0200 Or Har-Toov wrote:
> For the dump-it command:
> devlink resource show
> pci/0000:03:00.0:
> <resource>
> pci/0000:03:00.0/196608:
> <port-resource>
> pci/0000:03:00.0/196609:
> <port-resource>
> pci/0000:03:00.1:
> <resource>
> pci/0000:03:00.1/262144:
> <port-resource>
> 
> devlink resource show scope port
> pci/0000:03:00.0/196608:
> <port-resource>
> pci/0000:03:00.0/196609:
> <port-resource>
> pci/0000:03:00.1/262144:
> <port-resource>
> 
> devlink resource show scope dev
> pci/0000:03:00.0:
> <resource>
> pci/0000:03:00.1:
> <resource>

LGTM

> For the do-it command:
> devlink resource show pci/0000:03:00.0
> pci/0000:03:00.0:
> <resource>
> pci/0000:03:00.0/196608:
> <port-resource>
> pci/0000:03:00.0/196609:
> <port-resource>
> 
> devlink resource show pci/0000:03:00.0 scope port
> pci/0000:03:00.0/196608:
> <port-resource>
> pci/0000:03:00.0/196609:
> <port-resource>
> 
> devlink resource show pci/0000:03:00.0  scope dev
> pci/0000:03:00.0:
> <resource>

Do we have to touch doit? Maybe we should let doit be what it is now
and consider it legacy going forward? doit which is in fact a filtered
dump is a bit of a mistake in the first place, from Netlink's
perspective.

