Return-Path: <linux-rdma+bounces-16968-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPE7KJvrlGnUIwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16968-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:28:43 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D68151769
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0922E3021EB7
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 22:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A3D318EF1;
	Tue, 17 Feb 2026 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hx7HbXMt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0C9318B95;
	Tue, 17 Feb 2026 22:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367291; cv=none; b=cWH6rsE4giqLwALRnoZ5KAH8obrq4Jsv1FijAIHh9vfh2t6Am7SVsz5cXic5VkqDJD0/G0tdx5RG7aIUtNEkZSGhyxV4qgcOkIMYpQwAjoYBcflAFrRFL3IfV3EdLsWt5DOs9bkeYObDq1L/MQXNjsD2ySKwjUKrBvknZICuUvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367291; c=relaxed/simple;
	bh=4ZZzJoUypvXc3Bo+CoJlQaH09sZK2TEHfYssmcfGRMI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Vj25RHAoARQhGPtqyySQuKe5FnI15N1riZPDs1za6qyE9vTnWj+SizIXMHWcGMesoh9QXeMX0mDLTQp9zgckWYGFsygC82iwzMnqAfW/Nncjz6mxJL0IGVj3lot3qgfUvgvN8Em8CrSKjkkDGXCwtc+tLfor+AJjMIiVo5RWrOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hx7HbXMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6407C4CEF7;
	Tue, 17 Feb 2026 22:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771367291;
	bh=4ZZzJoUypvXc3Bo+CoJlQaH09sZK2TEHfYssmcfGRMI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=hx7HbXMtLkovS+AS5uZw9BKiRdnXtksG900F1H4AKrRdPhUtVrMk3YeSHGyy55Kff
	 EYjJ7Wa8cjJ65wjH8A3yi68kM3hVmKaMbUCXELghbTrNZaSQB8oZcTrIL2GF9DE8fm
	 IgGKddR8CF56khB8GQ9a0g8UsKJuTxsKvHhtYt23IHpemNLkOMBplPtBWiwwIiSp1U
	 1oA+Z9O6Ma4MpbBk2h0OfjdIZOmxVqjbruMI2+Z5JOnLlIfhNicYnt5Tkg650iuCFo
	 auR9lcVnC6NR3YNEUoEchGohW8kp/aS7HQGw1RgLXinLl1eq079N/k9Uc9BhZcJQEq
	 X6QKANzYZjApw==
Message-ID: <fc5a4706-c40e-48f4-b0e3-f4bc6970b179@kernel.org>
Date: Tue, 17 Feb 2026 23:28:07 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RFC 04/10] driver: core: constify groups array argument in
 device_add_groups and device_remove_groups
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
	TAGGED_FROM(0.00)[bounces-16968-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 45D68151769
X-Rspamd-Action: no action

Now that sysfs_create_groups() and sysfs_remove_groups() allow to
pass constant groups arrays, we can constify the groups array argument
also here.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/base/core.c    | 5 +++--
 include/linux/device.h | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index f599a1384ee..4db63b2603c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2831,14 +2831,15 @@ static ssize_t removable_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(removable);
 
-int device_add_groups(struct device *dev, const struct attribute_group **groups)
+int device_add_groups(struct device *dev,
+		      const struct attribute_group *const *groups)
 {
 	return sysfs_create_groups(&dev->kobj, groups);
 }
 EXPORT_SYMBOL_GPL(device_add_groups);
 
 void device_remove_groups(struct device *dev,
-			  const struct attribute_group **groups)
+			  const struct attribute_group *const *groups)
 {
 	sysfs_remove_groups(&dev->kobj, groups);
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index 0be95294b6e..48a0444ccc1 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1131,9 +1131,9 @@ device_create_with_groups(const struct class *cls, struct device *parent, dev_t
 void device_destroy(const struct class *cls, dev_t devt);
 
 int __must_check device_add_groups(struct device *dev,
-				   const struct attribute_group **groups);
+				   const struct attribute_group *const *groups);
 void device_remove_groups(struct device *dev,
-			  const struct attribute_group **groups);
+			  const struct attribute_group *const *groups);
 
 static inline int __must_check device_add_group(struct device *dev,
 					const struct attribute_group *grp)
-- 
2.53.0



