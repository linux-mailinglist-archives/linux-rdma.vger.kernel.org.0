Return-Path: <linux-rdma+bounces-22774-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nFL3OJ1jSmryCAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22774-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 16:01:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD3370A321
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 16:01:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QZ0fMYCV;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22774-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22774-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CEA1F300BD73
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2026 14:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FBC37FF41;
	Sun,  5 Jul 2026 14:00:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AC437DE9D
	for <linux-rdma@vger.kernel.org>; Sun,  5 Jul 2026 14:00:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260047; cv=none; b=rImMBC7zQRBDqHidjtG7Z7atLSzcmuCMxCPe13+QHpynX7YF7PAiv3+ZJMiMzwAaGd2Ayj79z4EukBkssmw50B5dxYrM07muRMiBTxMz6+itwPu0D3DIQwLLUce+blnWTPooYZbMevLICwscPw66nsZiE9WmMq49Mbvm+Ildvbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260047; c=relaxed/simple;
	bh=88q0CT52rP5yiFsVvPXd65J7Rt6CNzCSkaSG6g7RZ0Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RgF/Ql0+JV6asJA80ErI1xL5+6Xbf5xIXnJaj579Am6e7almJbLc9P+T1YEmbmgjmtc0AROVy00zlJDk6SKLOmnHgwAhM8i+pLXIg5C2Eg+9pRAWgBqWGPAMt9wQ/1fgllbnjZvfxlY3JTvR41gqBkLixOlgJ4kpLfHA/3+hJEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZ0fMYCV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33881F000E9;
	Sun,  5 Jul 2026 14:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783260046;
	bh=Ab02AgEenhGfM5mrwuZ3/PPut0V8eLAX6fHcwOw0NV0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QZ0fMYCVbN5A6F8HCP1XS1NOV5d94CeQ/fTrrPSvBFvCZRhCFc3Ky++Mr1z9zHRWu
	 EENVL91v6RXobBZrmuBAnEPA+nhX+9P4CsTrW/e4/hbxRwh2mTRDVd4B59ozefTP9o
	 oF4BcOGx3sB/v+GW/Qqo7K1l/lL94/3s1kcNZV5BxyHC+J/8QFK46RNYe95rusoLRz
	 qYLCYP+BUHg6Ol+a1tLIHKTvg1KdrOKTqmN48gK/UA7vc3RMP8+t/3mPTux/d2bAaW
	 VEMNPoiskr5S0/XvS4301vpx/z5kUXwOfT5MCwqpBXHxb3F05/ryXgkYUtB9Zi8O6M
	 XJUPXjvfVPzJQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Or Gerlitz <ogerlitz@ddn.com>
Cc: Mark Zhang <markzhang@nvidia.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org
In-Reply-To: <20260617-fix-cma-ipoib-v1-1-03f869344304@ddn.com>
References: <20260617-fix-cma-ipoib-v1-1-03f869344304@ddn.com>
Subject: Re: [PATCH] RDMA/cma: Fix hardware address comparison length in
 netevent callback
Message-Id: <178299026931.607917.10072787718698047212.b4-ty@kernel.org>
Date: Thu, 02 Jul 2026 07:04:29 -0400
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
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DATE_IN_PAST(1.00)[74];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22774-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:ogerlitz@ddn.com,m:markzhang@nvidia.com,m:phaddad@nvidia.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DBD3370A321


On Wed, 17 Jun 2026 14:21:05 +0300, Or Gerlitz wrote:
> The cited commit hardcoded the hardware address comparison len to ETH_ALEN.
> 
> This breaks IPoIB, which uses 20-byte addresses. By truncating the
> memcmp, the CMA may incorrectly assume the target address is
> unchanged and fails to abort the stalled connection.
> 
> Fix this by replacing ETH_ALEN with the dynamic neigh->dev->addr_len
> to correctly evaluate the full address regardless of the link layer.
> 
> [...]

Applied, thanks!

[1/1] RDMA/cma: Fix hardware address comparison length in netevent callback
      https://git.kernel.org/rdma/rdma/c/18313833e2c6de

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


