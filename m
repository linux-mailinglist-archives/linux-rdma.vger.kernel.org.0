Return-Path: <linux-rdma+bounces-22777-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XrLnDd1jSmotCQEAu9opvQ
	(envelope-from <linux-rdma+bounces-22777-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 16:02:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AE770A34E
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 16:02:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OwI2DclK;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22777-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22777-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5B393003EC8
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2026 14:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3392A37DE9D;
	Sun,  5 Jul 2026 14:00:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E327D37F002
	for <linux-rdma@vger.kernel.org>; Sun,  5 Jul 2026 14:00:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260056; cv=none; b=VKkqtDOzfCXYOeR+4bsx/8Ldk53ht1aj9IdrzWUv2px/UCVLqKO7RXCEXE59XL007AUkAUw/TIokpXo1PMffaraHDPg8ZAgC8az9BP5/qpKn2dzWUvQdq9Jb7LuHWG1sow/02kEJWfMQqiws1Nm3PKOOe1jtbWZPt9nZ7sjgQIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260056; c=relaxed/simple;
	bh=Si3DpwDYpDwnOTs7GXXW5Iy9oAPqcrbSDIPR83KkZnM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j+lwGq10xzcPhBCaQAtiuDal0fk+Wk+zoscxcAuxLGJsOmuQ6FWvYeWpiLvdo6f+UFO7LJSUVrsuvISmyrZzlXSDcpBbSDAFqhTgZqgS4h0IT8I6G6nLAQpCK/4PCPQ4aCPvBVy0Cs3Em4KpmQq4lJhhYZTSHiQ2VMAF+b1nnl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwI2DclK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD181F00A3A;
	Sun,  5 Jul 2026 14:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783260055;
	bh=QbVvK0vU66fjE+kb5RjleVL7f5u6UHbTy5AiP25dgbc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=OwI2DclK52w9kWxpKN70zIWHwnV1E6KNg5oNcLdLwHcAnUjCI8wzFecK0MP5w7jRi
	 2t822PIwZP6WauJ6GN3h9tiRdXrQ0TZjaugJoYlO2U1tsNm1wtGCzAPS77tdEL03ng
	 X1lF329pco8eXjSOYN0LiH3KIifALfJM+nuNmi82LqOxf2vtiSpUPgGzAdHa0lmo/N
	 boIUUzsxaGXDFROkXkdGXZGzSDYrXwFRh3pwrZ8YoNiMNwJlQG+PHulp5RWiYEbsxT
	 NKVHtoyCbKnOssW9fmq0htL3hBW6nRw3z1Qm34pip1wWL8uBny2qq5gPNeyi0auyy7
	 c1tJ1CDiHyqFw==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Seyeong Kim <seyeong.kim@canonical.com>
Cc: Krzysztof Czurylo <krzysztof.czurylo@intel.com>, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20260619050044.1807044-1-seyeong.kim@canonical.com>
References: <20260619050044.1807044-1-seyeong.kim@canonical.com>
Subject: Re: [PATCH v2] RDMA/irdma: Suppress PF reset on HMC error
Message-Id: <178324904776.905277.16330345235008636135.b4-ty@kernel.org>
Date: Sun, 05 Jul 2026 06:57:27 -0400
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:seyeong.kim@canonical.com,m:krzysztof.czurylo@intel.com,m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22777-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99AE770A34E


On Fri, 19 Jun 2026 05:00:44 +0000, Seyeong Kim wrote:
> The irdma driver currently issues an unconditional PF reset whenever the
> HMC Error interrupt (PFINT_OICR bit 26) fires:
> 
> 	if (event->reg & IRDMAPFINT_OICR_HMC_ERR_M) {
> 		ibdev_err(&iwdev->ibdev, "HMC Error\n");
> 		iwdev->rf->reset = true;
> 	}
> 
> [...]

Applied, thanks!

[1/1] RDMA/irdma: Suppress PF reset on HMC error
      https://git.kernel.org/rdma/rdma/c/4dc9c884c0aafa

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


