Return-Path: <linux-rdma+bounces-22790-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LxH6G/1GS2ozOgEAu9opvQ
	(envelope-from <linux-rdma+bounces-22790-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 08:11:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA6170CCCA
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 08:11:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VP+K7WfZ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22790-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22790-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8DC573009398
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2026 06:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765953BED79;
	Mon,  6 Jul 2026 06:11:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F41723ED6F;
	Mon,  6 Jul 2026 06:11:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318262; cv=none; b=keczaYvWyo2K4j5Au4xXpHsBxP1qe4pLmGcL2G9BuQtUVoiHX5aghgDgOunwFveB4UmrspqSTz8Ru2Y5M48Zzw9CXjqzwIHlA8/gkjafBZXosqeTi2SFlLxdLRHNprlOcc4lrP2nrXIOhmqved/+iTHxHvzAaAmUbPTBzv/l81k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318262; c=relaxed/simple;
	bh=Ki6wu9Sre3Mr3HxsVy6+wQZjwVDrgpvq6EDJNnyrQr0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OcQWJxOsAVo8nsSM7CAEmGDk7bipW915oM+ECt9S7UUWzWjdzObBMAUd3fyKAkkDcOpU75UpuO9R+Uvn3DB55NFdj/dDM7JFDU78JyRwbo3Md9EHtNQJoxvpYmeCbenQOuKD67IMeKHyFDfjBSY/dRlbDtLzw9oFTRqsR+YijrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VP+K7WfZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A811F000E9;
	Mon,  6 Jul 2026 06:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783318260;
	bh=zLjXhRtEewgKOyiY3StQ5BZr6b0QOilnFr+YEnNZnFI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=VP+K7WfZf3I5+9wTquBolNDbKutbwbqK4y9fNHX4h3MUQ4NC4ws7tP1cfXkSZ13Gg
	 YYANnGvhFCDJPHez1vQoIhKaxe7wuprKgXogvpMf0O5+MKBovBlgA9rDQHqtXMOCtL
	 03h/IzZy8VIv0h++wkQbtLphbRbCuF+IncnTw8FL/o1PrVPYJKEGXPV5V9jbDM2d2m
	 dbbeplgVnTdV5iRQN0PwSfgFyjp+UscGjGZ7SqNm1bcK45ic2PLik03SScjrKrzztL
	 JGgD9/mItYtSB2EP5se3rYWnJ85jLLgpiVElWuQYiXorV6jzaZwmzRXo5MvIsrIGGE
	 55VVeRgwQvCSA==
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 linux-rdma@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <20260701150510.384858-1-mschmidt@redhat.com>
References: <20260701150510.384858-1-mschmidt@redhat.com>
Subject: Re: [PATCH for-next] RDMA/hfi1: Remove unused non-user-accessible
 device class
Message-Id: <178331825780.992989.13098026029043860697.b4-ty@kernel.org>
Date: Mon, 06 Jul 2026 02:10:57 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dennis.dalessandro@cornelisnetworks.com,m:linux-rdma@vger.kernel.org,m:mschmidt@redhat.com,m:jgg@ziepe.ca,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22790-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4FA6170CCCA


On Wed, 01 Jul 2026 17:05:10 +0200, Michal Schmidt wrote:
> The driver defines two device classes: "hfi1" (mode 0600) and
> "hfi1_user" (mode 0666), selected by a user_accessible parameter to
> hfi1_cdev_init(). The only caller always passes user_accessible=true,
> so the "hfi1" class is registered but never used.
> 
> The 0600 class was originally used by the diagnostics UI char device
> (hfi1_ui*), but that was removed over 10 years ago in commit
> 7312f29d8ee5 ("IB/hfi1: Remove UI char device"). The class and the
> user_accessible parameter were left behind.
> 
> [...]

Applied, thanks!

[1/1] RDMA/hfi1: Remove unused non-user-accessible device class
      https://git.kernel.org/rdma/rdma/c/297b5b747a0a2c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


