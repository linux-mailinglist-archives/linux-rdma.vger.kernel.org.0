Return-Path: <linux-rdma+bounces-16970-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JOzJvPrlGnUIwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16970-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:30:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7CD151798
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AD6830238CA
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 22:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B261D3191B7;
	Tue, 17 Feb 2026 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4r7ltZz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7336B318ED3;
	Tue, 17 Feb 2026 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367381; cv=none; b=C93+Tb7iC+hI6dOU8F/XzWOTjPYHeGbg0QRiWP5GPXgCSKrMw2t6Wts9t8KaZ1G8vERfOX2w8WDtSww+v/Gvbboy8S/4Jpyviv5h9py2GQy/XSa6VHSof6eRrPvt90mHwXYnRwrIr0WpVCGNAr6Uu85PjE2VDFHCMWHrvRjYj0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367381; c=relaxed/simple;
	bh=xrd9ece0m84ThVFko3txeePisZV2G0M/1l0pyaeu434=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DckB3Bj5+3XvY4EldUTNS1uds5MKk3A0QwoWkQSUQUZ+ov9pxkVYbN7bRnzZYIf1JLQ1k07p6noRWHIIm/f97sJ0f+FT/ta3Mqumkks4sfXPpXUN+PP4xu79u0+WLFesPR/7nDlRYOyiiJyr4SVbTVkeJDLHGARr7o0/JfTK8IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4r7ltZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17ABC4CEF7;
	Tue, 17 Feb 2026 22:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771367381;
	bh=xrd9ece0m84ThVFko3txeePisZV2G0M/1l0pyaeu434=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=L4r7ltZzbr5xFxyE40X/d9feLRSAOAK9Wx2x3+pAIsMq9qZT4/CUUNcZwbWYzRq1x
	 xQGl4RVpfrlqF0EPv9AgUh9rvvdmpj25ZmlJHi9onv2/aIIdfLY7VL007TJwjRuuUB
	 IDc8lfC2qQ3bD87Q9ox84//jCaFwmy5bsKBJXnJE88sBVIg38gyjFOFmRT3BttlXXT
	 ga14nBM1rx3wX44Dn31yeD06820kpCnOPNOlDwtOZkJSPzA/+PRg2VK8IpgQgtf1lY
	 Po1LCda6odIOpBXJ0horTwJtdE2QRsYmf5JIs9/EgMekDqYbDb6AkBcLfFfPBy+IMa
	 jx3V0B8UytYuQ==
Message-ID: <66a78ec0-2980-4376-96fb-3193b6cbe943@kernel.org>
Date: Tue, 17 Feb 2026 23:29:37 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RFC 06/10] driver core: make struct device_type member groups
 a constant array
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16970-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E7CD151798
X-Rspamd-Action: no action

Constify the groups array, allowing to assign constant arrays.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index bfa2ca603c2..808f723bbcf 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -87,7 +87,7 @@ int subsys_virtual_register(const struct bus_type *subsys,
  */
 struct device_type {
 	const char *name;
-	const struct attribute_group **groups;
+	const struct attribute_group *const *groups;
 	int (*uevent)(const struct device *dev, struct kobj_uevent_env *env);
 	char *(*devnode)(const struct device *dev, umode_t *mode,
 			 kuid_t *uid, kgid_t *gid);
-- 
2.53.0



