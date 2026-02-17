Return-Path: <linux-rdma+bounces-16972-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N+8ICnslGnUIwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16972-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:31:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 479D11517BE
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 259743015B63
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 22:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C270D2D781E;
	Tue, 17 Feb 2026 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fj/SQQTO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843E213AA2F;
	Tue, 17 Feb 2026 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367462; cv=none; b=LEIsHI3YQeWfmJLiMafOYORWfGCryoBvMbTkfn1G77qQMCDqTBSKNHF2JBA/WUk9M5Y2m/JM8Lr4QvXSPMcCZ3n37VFt6JsXcvYgH4UOlj4SmGzL4aZqGh7N0vhczfyv6Hlz9v9i9IEkWMyYz2lHC7Fqm4x60yNHEtQay5byrnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367462; c=relaxed/simple;
	bh=SaaFcH6Oc3jCFSVMmx10cF8ncRdwRf8Ta+7Tz1QJAk4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oGUD3e9iuP1MBcOCZOqxS62mfUH5f0MYHb0RuHuubItHY7Lg5TVDyllcVtup9EhyHr8qbnAP2q4RJTQzvck74g0syT4IxeYOUMK6kR9apNFOT4Wt8M9L4KQEEHh82FYM091V8f4YxtS70H/mJUAy2N2nz/VHn8ypZcP4wnoYY3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fj/SQQTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF351C4CEF7;
	Tue, 17 Feb 2026 22:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771367462;
	bh=SaaFcH6Oc3jCFSVMmx10cF8ncRdwRf8Ta+7Tz1QJAk4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=fj/SQQTOupipFBHak4x5z7L7flqm0zVy+U5fU1vEOY5RRLtwEct8yWTlitXXqmbs+
	 YHeKKT3UprB8u+vKjGyJLaSu4F4SxH3FyBl453fEcfHkI2dU0eebWwPJu/cuIWLhzh
	 D0lqVOxFF+uVb8X4HQwhH/TUkyrG6VauKQPgKZ81o54nu047R2pn0qF6hUNAxt1whk
	 c0IHDAPfcIH6r5IH+j6LnYAKmHsCMTxbmPpv8mQCpK8gvlgluP6P9kwykHIQtvkEEF
	 JCn099FPpmSGBu8bL3RFWj/Vrspg6sn5akQ7x6BoHNh7YG3c0iE67j6F9NtfvMIkES
	 Brp7oIXxiianw==
Message-ID: <f1e7f5d0-88cd-4d52-bc23-062f9f506844@kernel.org>
Date: Tue, 17 Feb 2026 23:30:58 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RFC 08/10] driver core: make struct class groups members
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16972-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 479D11517BE
X-Rspamd-Action: no action

Constify the groups arrays, allowing to assign constant arrays.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/device/class.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index 65880e60c72..2079239a5aa 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -50,8 +50,8 @@ struct fwnode_handle;
 struct class {
 	const char		*name;
 
-	const struct attribute_group	**class_groups;
-	const struct attribute_group	**dev_groups;
+	const struct attribute_group	*const *class_groups;
+	const struct attribute_group	*const *dev_groups;
 
 	int (*dev_uevent)(const struct device *dev, struct kobj_uevent_env *env);
 	char *(*devnode)(const struct device *dev, umode_t *mode);
-- 
2.53.0



