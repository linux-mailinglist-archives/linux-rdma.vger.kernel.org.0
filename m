Return-Path: <linux-rdma+bounces-22176-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x8+9MAz7K2rpIwQAu9opvQ
	(envelope-from <linux-rdma+bounces-22176-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 14:26:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AB86795AD
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 14:26:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=VDIBa2Y5;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=pfAFOWl4;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22176-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22176-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=mailbox.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FE3D30DE85A
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 12:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585463BBA0D;
	Fri, 12 Jun 2026 12:26:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50823A8723
	for <linux-rdma@vger.kernel.org>; Fri, 12 Jun 2026 12:26:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267208; cv=none; b=ejCeuUoEfFicnguPeTkouu98MGnM4ULgBt5lZLS3/pbQwN+diK3xkxpVnBSflbE2annQr7UMlwfo2PMNG+O0qbrMVnnwBpdwM2XnHgoEY5noFkeq4nJhnU+B5XRs39H2vDDHK8UJh55x0tEuyJAjalM71CrK+gUyI9xlOU5sSJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267208; c=relaxed/simple;
	bh=c9+uibl38zu47Fzs8FaOr1SX/4oAzbEJlxCfnlYFDMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NlHWdSjXIrx/wXVX3uML/ByfySYsU1y4zy9zKNIBdk2yuTBm0DpPSOo84iCSR047483EZ9rejnwGtcLnxmNJUFTV7w7d/SH5ZM52825fL9Ug/pqVWnXSn4UVPQEYilMgBgKOfQhf3MTPyCoGs7V/z58NZiiF2sJ/gjE76XAZo80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=VDIBa2Y5; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=pfAFOWl4; arc=none smtp.client-ip=80.241.56.161
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gcJfQ4C4tz9t5H;
	Fri, 12 Jun 2026 14:26:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781267198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lL6EfkpFkYCqwvOdw8ZwNQUZozI+SoVsFwTExAbcEbU=;
	b=VDIBa2Y5p/E5V9eJuaptjbbas8H7eVv83zpeRSyMenP2bSjN9eP5DCJ1QrHbqFLfbNtufU
	LLK9SFjKDb/RAirntLXeYcpxexPVDx6kPWU8g3cHpLsGseVBPzGM8uDUdJsbzqOgVpeXQg
	JErjZwhIWUCJD9rYWMv9R76PURBRnMlj7nTvClAEaC9tNlFi9fN8tPURuQzgYwu1pixwWJ
	Bj2WtT+nj6ZIqIB2Eozrc2iLl3QOWyfTNU0fCEUKEcM3F/wMEEYiaSoAD+E2gtQjdtjPl0
	IGyfwgljwqUfqWhJ2k6Asdg99QY87u27VfhuF5YOftdyH44y/WOteWgZ0PAGrA==
From: Manuel Ebner <manuelebner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781267197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lL6EfkpFkYCqwvOdw8ZwNQUZozI+SoVsFwTExAbcEbU=;
	b=pfAFOWl4xH06z1Z+I0P0xPPmbPEpP0JxYDPysfpdl6dDyexd67M11es/Uyh91r+416EWNm
	GFM8xZZWBw3fbZKPg00SIDarxKnDfpb0vpiOnB6wSe5R4wwpejwWIRYQxmh/OAV8SEwDzc
	P0dUXmtGyXiYHmDkwrfQa5lxwCPjo5i1TULmbUC6H9VGJhu7r6pfA2UO+rvkNzqxkj8huq
	5JydlPyuXhwSvjc2Jk2Uxp38Oletllnim2loDNJJJvjLTatfmvA4OxGlWBtLa5FRSRL8Yx
	ti/EdkA6xN1P5QyTP1eliimfckyYKPRmzWDlgSQilGbC/oa8Smp4sqJExjjy6w==
To: Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-rdma@vger.kernel.org
Cc: Manuel Ebner <manuelebner@mailbox.org>
Subject: [PATCH] ABI: sysfs-class-infiniband: minor cleanup
Date: Fri, 12 Jun 2026 14:26:12 +0200
Message-ID: <20260612122611.183127-2-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: wzduj7dtdi6gz39g1wsa5nwpk3fucucc
X-MBO-RS-ID: 6952ea2f14c9caa9033
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22176-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leonro@nvidia.com,m:linux-rdma@vger.kernel.org,m:manuelebner@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[manuelebner@mailbox.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manuelebner@mailbox.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,mailbox.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 36AB86795AD

Close parenthesis with ')'.
Add '-': 64-bit counter.

Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
---
 Documentation/ABI/stable/sysfs-class-infiniband | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-class-infiniband b/Documentation/ABI/stable/sysfs-class-infiniband
index 694f23a03a28..7ba116103429 100644
--- a/Documentation/ABI/stable/sysfs-class-infiniband
+++ b/Documentation/ABI/stable/sysfs-class-infiniband
@@ -148,17 +148,17 @@ Description:
 		**Data info**:
 
 		port_xmit_data: (RO) Total number of data octets, divided by 4
-		(lanes), transmitted on all VLs. This is 64 bit counter
+		(lanes), transmitted on all VLs. This is a 64-bit counter
 
 		port_rcv_data: (RO) Total number of data octets, divided by 4
-		(lanes), received on all VLs. This is 64 bit counter.
+		(lanes), received on all VLs. This is a 64-bit counter.
 
 		port_xmit_packets: (RO) Total number of packets transmitted on
 		all VLs from this port. This may include packets with errors.
-		This is 64 bit counter.
+		This is a 64-bit counter.
 
 		port_rcv_packets: (RO) Total number of packets (this may include
-		packets containing Errors. This is 64 bit counter.
+		packets containing Errors). This is a 64-bit counter.
 
 		link_downed: (RO) Total number of times the Port Training state
 		machine has failed the link error recovery process and downed
-- 
2.54.0


