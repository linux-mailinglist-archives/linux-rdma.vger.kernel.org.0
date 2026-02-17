Return-Path: <linux-rdma+bounces-16971-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCEaJxLslGnUIwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16971-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:30:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D271517A8
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F306E302335D
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 22:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561602F5A05;
	Tue, 17 Feb 2026 22:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsSVo1CX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183F713AA2F;
	Tue, 17 Feb 2026 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367422; cv=none; b=g/xIqJCuqVmwgGxAMuflqvCbJ64uFtdGRbfyVsV/OQpxdK1EeZpIxcvYrAp2ta9YUd752wxgCVENe1Yw/Kdag0fsLD4Dw2CriRhddP0zJRC8AtlycZcleg5U5ToSW4aCl78f76nEJmBs5WxUuntG3YokmHuv6lAt65ArLiR5FiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367422; c=relaxed/simple;
	bh=VsVjc+rt/VTr9goq9phUEQQxFoTsYqWk1U/35E2GGPs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AChpQCLtrovklIpEua2O2ps2Sx9zr9KxAFTH27PrEV9N8e393yqqFyHvyDaC/6rULa3dCydeYnj6tzLpGHR/MQWuPb8vS+rAu9Ol2Yluukz2lKfKKt6dbjqBunIdfQjRXy7nHBRFbs+B3pVVh/gxpIuFcwJHADsJDakIaxAZCOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsSVo1CX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679C7C4CEF7;
	Tue, 17 Feb 2026 22:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771367421;
	bh=VsVjc+rt/VTr9goq9phUEQQxFoTsYqWk1U/35E2GGPs=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=fsSVo1CX31qjds7XGu2AO2QgL3smsrdmvUwrB4pLu22V+z18sAorEMFPUHtEoiIcj
	 R7nbj2JEWeh3y8Em4PH/7bxsMZ2E8xjWPCBVc/nF0PImbGBuv7AgrYMi0J34wn3F/b
	 cwbYYayBZ5MuheMe8V/YVuNJ6ergCwT4lXLcY+hYYZtk5/odqXIkLk315gLT3DinD0
	 GNId0r0Lo2H3HaVnpy6PpB1QBLN+Z6MSydCkh4/RjWYQc9HyvXVri2vkuleHxzzZXT
	 KoWwrjvLDQivxQKf48XHmxugBcyFd3GVFa31oseTRpvLY87KI4/iq/gccXZZMKagpq
	 s4jtRje6/6N8g==
Message-ID: <4a2389ed-6ea4-4cff-aad6-a5a9f9bd13e7@kernel.org>
Date: Tue, 17 Feb 2026 23:30:17 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RFC 07/10] driver core: make struct bus_type groups members
 constant arrays
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
	TAGGED_FROM(0.00)[bounces-16971-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 80D271517A8
X-Rspamd-Action: no action

Constify the groupss arrays, allowing to assign constant arrays.
As a prerequisite this requires to constify the groups array argument
in few functions.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/base/base.h        | 6 ++++--
 drivers/base/driver.c      | 4 ++--
 include/linux/device/bus.h | 6 +++---
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 8c2175820da..b6852ba45cd 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -202,8 +202,10 @@ static inline void dev_sync_state(struct device *dev)
 		dev->driver->sync_state(dev);
 }
 
-int driver_add_groups(const struct device_driver *drv, const struct attribute_group **groups);
-void driver_remove_groups(const struct device_driver *drv, const struct attribute_group **groups);
+int driver_add_groups(const struct device_driver *drv,
+		      const struct attribute_group *const *groups);
+void driver_remove_groups(const struct device_driver *drv,
+			  const struct attribute_group *const *groups);
 void device_driver_detach(struct device *dev);
 
 static inline void device_set_driver(struct device *dev, const struct device_driver *drv)
diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 8ab010ddf70..c5ebf1fdad7 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -203,13 +203,13 @@ void driver_remove_file(const struct device_driver *drv,
 EXPORT_SYMBOL_GPL(driver_remove_file);
 
 int driver_add_groups(const struct device_driver *drv,
-		      const struct attribute_group **groups)
+		      const struct attribute_group *const *groups)
 {
 	return sysfs_create_groups(&drv->p->kobj, groups);
 }
 
 void driver_remove_groups(const struct device_driver *drv,
-			  const struct attribute_group **groups)
+			  const struct attribute_group *const *groups)
 {
 	sysfs_remove_groups(&drv->p->kobj, groups);
 }
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 99c3c83ea52..00d8a080f93 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -78,9 +78,9 @@ struct fwnode_handle;
 struct bus_type {
 	const char		*name;
 	const char		*dev_name;
-	const struct attribute_group **bus_groups;
-	const struct attribute_group **dev_groups;
-	const struct attribute_group **drv_groups;
+	const struct attribute_group *const *bus_groups;
+	const struct attribute_group *const *dev_groups;
+	const struct attribute_group *const *drv_groups;
 
 	int (*match)(struct device *dev, const struct device_driver *drv);
 	int (*uevent)(const struct device *dev, struct kobj_uevent_env *env);
-- 
2.53.0



