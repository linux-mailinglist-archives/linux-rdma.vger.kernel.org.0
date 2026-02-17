Return-Path: <linux-rdma+bounces-16974-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPJtJ7PslGnUIwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16974-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:33:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 260F1151825
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98DBB3026584
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 22:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05B92F9C3D;
	Tue, 17 Feb 2026 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jypbKAFR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614A32EA473;
	Tue, 17 Feb 2026 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367570; cv=none; b=gmDAUYWkQBypmkMO/zVYXkxGFRdOVYK4iCV8An9eWQ0dD6bcJL1wmQSv8eIo3cillhQnWBYdJaieUu2M4bBxthSbstRr8tHptHIh9QnetS+REeKeMn/Ojp0uSbItw73PmCXrUIwax8AUxmdJpXSgI/cFTdwmBgR8jpRP6LXGeh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367570; c=relaxed/simple;
	bh=bsHw0CdDAwiKv+O4iPUOnlnloSTFSuZaPE4oWUfsSAY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Fpov6U7C4y+yGBw3bpKZp2CViHZSDWLj29ILY33WRaNAs4Fa/hsQRKyUaiF9rD/RbZEVF4AR9BBLC1lYnfSSRiqiUYbZCYa8yXydjYTJhqtvuE9gN/jWQE/1L5euRf5H6uuSVe9vs4S1KFJ5z0YVeWnxC7V6RaCaNprmV7hy4F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jypbKAFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB1BC19421;
	Tue, 17 Feb 2026 22:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771367570;
	bh=bsHw0CdDAwiKv+O4iPUOnlnloSTFSuZaPE4oWUfsSAY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=jypbKAFR2Jh4xWXGrHhlTaprdPNVnyhg5aUnSDib2lnw8pRwqxz8cUvy39LFHftR6
	 jboHuR40a73E40sq4IqHQLio0m1Jzx0tcaE6g4eFk6Yi9o3gEeGtPT4cn5HG+VWGdj
	 AEZhdvd5RgbJP/9MGexrJKYZFjPxn+NKM6S75t4vyW6FyZd0tAx/7CbWee+jRlygvl
	 SfyR2hMorqcAaccz3nltJIbr2z0M6TutI2wgVdm13dVuRClPliIwGPSYF3hTvgYGcA
	 A1DSs7McC2zECDnU8lyANXJ9DPv/R+ww2thyPr1/72PxN+qQI/uTfjSRfuFYqdxBDP
	 hcEqcyhEE791A==
Message-ID: <04c85242-dc51-4ddf-9920-4dab57f2498f@kernel.org>
Date: Tue, 17 Feb 2026 23:32:46 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RFC 10/10] kobject: make struct kobject member default_groups
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16974-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 260F1151825
X-Rspamd-Action: no action

Constify the default_groups array, allowing to assign constant arrays.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/kobject.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index c8219505a79..e45ee843931 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -116,7 +116,7 @@ char *kobject_get_path(const struct kobject *kobj, gfp_t flag);
 struct kobj_type {
 	void (*release)(struct kobject *kobj);
 	const struct sysfs_ops *sysfs_ops;
-	const struct attribute_group **default_groups;
+	const struct attribute_group *const *default_groups;
 	const struct kobj_ns_type_operations *(*child_ns_type)(const struct kobject *kobj);
 	const void *(*namespace)(const struct kobject *kobj);
 	void (*get_ownership)(const struct kobject *kobj, kuid_t *uid, kgid_t *gid);
-- 
2.53.0



