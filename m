Return-Path: <linux-rdma+bounces-22424-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9On9LYtaOWoDrAcAu9opvQ
	(envelope-from <linux-rdma+bounces-22424-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 17:53:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFA96B0E13
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 17:53:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="fEzB/4RZ";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22424-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22424-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5981A302D099
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 15:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C784C391842;
	Mon, 22 Jun 2026 15:52:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95C6264A97;
	Mon, 22 Jun 2026 15:52:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143555; cv=none; b=QhQmT0wRKY0Y4NzMJ0FClzR1i/+F4Qk3FAiy/oBOvL7G/jx+Tdrq9tk7f9UqmyuUmMuwwbJvQP9pQYoK3CgJqw34nwGyRapuXkmkHj5sNA31dTR9lN6prfXQCBdBbzr9Xsrqnn/zqiGVNrRMKJHVZL2+DVv9wVy+Ys1Y9WXnzXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143555; c=relaxed/simple;
	bh=7VIGyVRF0G8SLl70rRa4kAPFZ7fICm9uqSiCfGJz4Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gfs1Su2iVE8ZyPDjK8Rzv0nk3cbHejCWYLYkSQ6/P9KQQhERF1wHGlHaYhPEye7OczlfbuJcYLdx/rDVSRiJppQ9sMZuZECXFKHxHwdd/p51URLeRFEHmReGN6jmDXZwVlrYr5Mk0Niadodddh2vSLzDjmAOD6Ez4CuMcXTm/bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEzB/4RZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3F61F000E9;
	Mon, 22 Jun 2026 15:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782143554;
	bh=7VIGyVRF0G8SLl70rRa4kAPFZ7fICm9uqSiCfGJz4Dw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fEzB/4RZ8Hz666TAUQbehEpF7F4xglCph556Wwc/uGt54L0f2Xu0KmKGDX8eqK6V4
	 HIrUfl4KrFHTavJl9NhUzCIHvsmrXZbJSieleiljQz1QAfvbbvH0bY0Z+wkK3Qi436
	 tE/164mPeHKAVQw0rE2GpFsTi9sT6JzaOhUwjS9eCBDiYgTEqaECAOUygKuqTMG/6e
	 L/AiBlKUu5Q7+AuhdTMV5AVjhLD/UCpWYGiFbNUW1S3xTu4m9gXE09ai6fmCjrujeN
	 0tR6ZPb1dpUr+moonk0UpHQOcVRk5PstHkWu+RbmBQdtqjMlI62Txrjejt8H71ITJP
	 Vc22Pg/xDsaBA==
Date: Mon, 22 Jun 2026 08:52:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: lirongqing <lirongqing@baidu.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: Fix L3 tunnel entropy refcount leak
Message-ID: <20260622085232.37d9d5f7@kernel.org>
In-Reply-To: <cd725cc0-9be1-4d12-bc9f-95ecf789613b@nvidia.com>
References: <20260613153631.1752-1-lirongqing@baidu.com>
	<cd725cc0-9be1-4d12-bc9f-95ecf789613b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22424-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:lirongqing@baidu.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3EFA96B0E13

On Mon, 22 Jun 2026 09:49:17 +0300 Tariq Toukan wrote:
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

To be clear -- you have to take this via your tree now.
Our UIs doesn't even show patches older than a week.

