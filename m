Return-Path: <linux-rdma+bounces-16965-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF8rAtjqlGnUIwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16965-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:25:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 997081516F5
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 77CE8301BDCB
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 22:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE748318BBF;
	Tue, 17 Feb 2026 22:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAlsSxkx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A1C3168F6;
	Tue, 17 Feb 2026 22:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367124; cv=none; b=KeTvCLDaJNGoaHe/5ttpSgZtbJG89/Ot4jGjPxtG1eYFnCpCN3UAz0NmKmsa3g6NOu0MqGHZYZFfud3k1EIAAoieojtWJefC9Cal+Ane6+85Jj7MlmYH0KEH3JSf4wHP03Er8SJPLE174MGyMt+Ro+Wkcn03U6YVsVXYTLL9a4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367124; c=relaxed/simple;
	bh=0G2Wu+ork4b43/V01ieIEc5auZF0HDjfDOooAbQRvMM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EUh1YefRn1eKUdemgT9InFwYKGpO5GxmDB8y1QuL5izBNa5AERwu2Sw/iTpRhP3cpPKDVn9nFeQ6MraPSm6ilQk2ASCu8/49742KYBrijg+61wyrKiW6hYho2yaNo3tN6C21CN5xs1NeHiEAzE859tDLGBqfLVtn2Lz1ksy4/rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAlsSxkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068F6C4CEF7;
	Tue, 17 Feb 2026 22:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771367124;
	bh=0G2Wu+ork4b43/V01ieIEc5auZF0HDjfDOooAbQRvMM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=fAlsSxkx3sLN1/XXD48wAPoUeZ0r4sVnEKY6+VKVBhuy8RpHRmSEhRe1lkt3tEyNg
	 /LedgzgSS5NGp9xE1W4+i8YlIXKztRgomPnxA6O1Y8Hs4jCoq99BVs/SR5C5u4HnVb
	 P2ZXY0mZiuwY4TTKJZJxgNFw5awwgws+M0zZSh88lotDKrc9F1fiOWaIyHlYTPzNg7
	 EP/dCOHKOPpP6eYrPGOCx41xRRMXNOnW2Ed3zk0w3ewO5EO+QAYnMvDJ3TPtHdoG3m
	 vPZ9gIHqLZWWYtx5eszqFFrUhdiRsWiGpt/ivPwPLArGm7UA/bsLJguqAIcJVIMmfY
	 mno9B+KD0ipJw==
Message-ID: <0f7f4ffa-1465-4c54-8d3d-e9b551136669@kernel.org>
Date: Tue, 17 Feb 2026 23:25:20 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RFC 01/10] IB/core: Prepare for immutable device groups
From: Heiner Kallweit <hkall@kernel.org>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: driver-core@lists.linux.dev,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-rdma@vger.kernel.org, linux-rtc@vger.kernel.org
References: <5d0951ec-42c9-453f-9966-ecca593c4153@kernel.org>
Content-Language: en-US
In-Reply-To: <5d0951ec-42c9-453f-9966-ecca593c4153@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16965-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkall@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[coredev.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 997081516F5
X-Rspamd-Action: no action

This prepares for making struct device member groups a constant array.
No functional change intended.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/infiniband/core/device.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 1174ab7da62..f967ad534fc 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -565,15 +565,14 @@ static void rdma_init_coredev(struct ib_core_device *coredev,
 	 */
 	BUILD_BUG_ON(offsetof(struct ib_device, coredev.dev) !=
 		     offsetof(struct ib_device, dev));
-
-	coredev->dev.class = &ib_class;
-	coredev->dev.groups = dev->groups;
-
 	/*
 	 * Don't expose hw counters outside of the init namespace.
 	 */
 	if (!is_full_dev && dev->hw_stats_attr_index)
-		coredev->dev.groups[dev->hw_stats_attr_index] = NULL;
+		dev->groups[dev->hw_stats_attr_index] = NULL;
+
+	coredev->dev.class = &ib_class;
+	coredev->dev.groups = dev->groups;
 
 	device_initialize(&coredev->dev);
 	coredev->owner = dev;
-- 
2.53.0



