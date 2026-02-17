Return-Path: <linux-rdma+bounces-16969-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCz0CbnrlGnUIwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16969-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:29:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D816151779
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A14B6301DE31
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 22:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDD9318EF1;
	Tue, 17 Feb 2026 22:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRcONCbK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EA2318B95;
	Tue, 17 Feb 2026 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367338; cv=none; b=RTqpDm9EeXqcXqvr353Dm4ZRWeX+0lcCMNSt404d94osqbCwxpn5RPs/SoQwm7RyamOX5cwIr/qTFeUvHfKp6bdaEckxp0Rln450QxeCS6CROmw/3LecLnsqIfhgWZuGbi3tOeYWkZ81x0MzTOeEYed59fLIsRAjXwV2ex/HtvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367338; c=relaxed/simple;
	bh=nol6tUpy3fHDvQ4vYWXQcCQJwZapDwAPPWkod78PTk0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=vAk15wOEpI9oNdQr+mH106OHUZy94y2U8zWQDwFT3i2LpFYW4DKyJxPqqk+NxGifnU3O1GpHKcd2+0uXN2c7KwheQ+yPvOmSEROvvwptFth4sXya31w9qdOGxUkMHxqrXfwJGcz4D+aFrBF5DWAhonE+RDylGFf8y3frfoTRhek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRcONCbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22621C4CEF7;
	Tue, 17 Feb 2026 22:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771367338;
	bh=nol6tUpy3fHDvQ4vYWXQcCQJwZapDwAPPWkod78PTk0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=hRcONCbKJtlwa8v0gzedJ4f82ku/U34ySHCXRtPyb/c9A3LN7aVzrUYBVn+k66wiY
	 Di/z0d1aUxk0NfpZsdRSjKvBrdY4HxdZZXdTzfdLemK3EtY8Wor59DhAaV44Gzkn6q
	 6gP8kHRnb8OqUGEl9MaMMyT7PsO6THptA0SDa1W7xGtk0jEl9Fty3Pt7XKNFQ7ni6B
	 nloNsk0ZIQyElYXLM/H/Yrfbvgrragbi1ytfC4Dnnu11m/3gqzV6NSC5kLT2cJYcIw
	 TjZgs1hjJUSyHLBkaGGBlcKdE7y28K83yLapwSvb7wSuj8A7HeA7wAz9YETTJ4o/6+
	 zs079Y1ku+bYg==
Message-ID: <ca6222be-1380-4a1e-a8d0-330caf3748f6@kernel.org>
Date: Tue, 17 Feb 2026 23:28:54 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RFC 05/10] driver core: make struct device member groups a
 constant array
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16969-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D816151779
X-Rspamd-Action: no action

Constify the groups array, allowing to assign constant arrays.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 48a0444ccc1..bfa2ca603c2 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -640,7 +640,7 @@ struct device {
 	struct list_head	devres_head;
 
 	const struct class	*class;
-	const struct attribute_group **groups;	/* optional groups */
+	const struct attribute_group *const *groups;	/* optional groups */
 
 	void	(*release)(struct device *dev);
 	struct iommu_group	*iommu_group;
-- 
2.53.0



