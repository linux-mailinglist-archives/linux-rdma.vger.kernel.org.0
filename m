Return-Path: <linux-rdma+bounces-16966-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJ6gDDvrlGnUIwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16966-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:27:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F79F151735
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34F98301B724
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 22:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDFC318EC9;
	Tue, 17 Feb 2026 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaDc5hRk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A68318B96;
	Tue, 17 Feb 2026 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367191; cv=none; b=YJ64JtdqovHBYzqZ4MjHrltAA4WBekliYcbqghslZY2/HgV0bt5oYiM3SkqR5+Zbf/tDHlVnXa5XVRgYqCcXkUclkL5RB5OVvfN0Xt3HLEgDSeJpqMWvI2JK3CFAgKj5WS+P0I3KUET9y16+zCE1lEeH6jcmqQvIx/pmlJUiTcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367191; c=relaxed/simple;
	bh=RmsK6mmAsFn3kMOgdOxe8MRr28G1U6zGaOeHBWEMZ9E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Zi+XA/+pWLVWw2kQ3T8ROjTs0TxSSyQi0I5+TWvoPhj6bEsMCFXxToap7Pynk+KmVHxueVgpoq7q12fd1dxTLJYorBo7uXGxGN2fBy0aeS2bnISZyH+Td0vyQ9fY+nZC9b6uTkMTgtIczKTN1J7mOI5dG0jjKtD2rYmc1TZG8vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaDc5hRk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CA0C4CEF7;
	Tue, 17 Feb 2026 22:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771367190;
	bh=RmsK6mmAsFn3kMOgdOxe8MRr28G1U6zGaOeHBWEMZ9E=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=iaDc5hRkRXBnBH9OIzZW+YliZvA35wCYxK5I1/lQWeue6oq7nvT7OHFjExbAbDpya
	 cygBFw+/gQD7Tk83SHM7ELv5wibPxfQ5fY09xq8vV45Dj2zgRT19VEJvqVHAB5J9xg
	 X/LHLXTXmFbso6sN6pqQSrGw6Npaei70Ci8oBV5IFbGCUQK9afQtA6kGTxxrVEe1e8
	 hfKy6e4GaL9USZtzPzwK0mlBCpfpEdu0rfFB4TRTrDlkXHJ3BiLMfQIYdsupf4Lt0I
	 pmUxX8heePlPZhRsZCQaI0RfYndHtVtk4s2UKUzwp5pPgCj4H7YFE6c5OVE9lyMOAB
	 cLmonA7QfAYJQ==
Message-ID: <95e5af90-ed53-4009-a4ea-19ed04499ecc@kernel.org>
Date: Tue, 17 Feb 2026 23:26:26 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RFC 02/10] rtc: prepare for struct device member groups
 becoming a constant array
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
	TAGGED_FROM(0.00)[bounces-16966-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 9F79F151735
X-Rspamd-Action: no action

This prepares for making struct device member groups a constant array.
The assignment groups = rtc->dev.groups would result in a "discarding
const qualifier" warning with this change.
No functional change intended.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/rtc/sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/sysfs.c b/drivers/rtc/sysfs.c
index 4ab05e105a7..ae5e1252b4c 100644
--- a/drivers/rtc/sysfs.c
+++ b/drivers/rtc/sysfs.c
@@ -308,7 +308,7 @@ const struct attribute_group **rtc_get_dev_attribute_groups(void)
 int rtc_add_groups(struct rtc_device *rtc, const struct attribute_group **grps)
 {
 	size_t old_cnt = 0, add_cnt = 0, new_cnt;
-	const struct attribute_group **groups, **old;
+	const struct attribute_group **groups, *const *old;
 
 	if (grps) {
 		for (groups = grps; *groups; groups++)
@@ -320,9 +320,9 @@ int rtc_add_groups(struct rtc_device *rtc, const struct attribute_group **grps)
 		return -EINVAL;
 	}
 
-	groups = rtc->dev.groups;
-	if (groups)
-		for (; *groups; groups++)
+	old = rtc->dev.groups;
+	if (old)
+		while (*old++)
 			old_cnt++;
 
 	new_cnt = old_cnt + add_cnt + 1;
-- 
2.53.0



