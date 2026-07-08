Return-Path: <linux-rdma+bounces-22875-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oIt0OMMZTmrwDAIAu9opvQ
	(envelope-from <linux-rdma+bounces-22875-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 11:34:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A64723C73
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 11:34:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kaspersky.com header.s=mail202505 header.b=fho+RJaW;
	dkim=pass header.d=kaspersky.com header.s=mail202505 header.b=wqOFLfNV;
	dmarc=pass (policy=reject) header.from=kaspersky.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22875-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22875-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AA22302F0EB
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 09:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3D6409600;
	Wed,  8 Jul 2026 09:29:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailhub16-fb.kaspersky-labs.com (mailhub16-fb.kaspersky-labs.com [5.79.125.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311A134A794
	for <linux-rdma@vger.kernel.org>; Wed,  8 Jul 2026 09:29:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502975; cv=none; b=NIqh+ZpBa1z3NSCo4g6ZlmrL/WpARmlb2PNq7JJA0Hn53hha8CkWMJYNOjb0UtbYJgxOufw4KDZfwBq1YngNMhdoqKIcSvLlXtGWdeI2qWBp0zCxG0t/tDTsCFrb3ngB9ijlQZ+/12WUliU+beUXdEBqBhYnmyniu89cY3SNdeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502975; c=relaxed/simple;
	bh=JyHGaKNBXAN0PL9ma9wZZ7G8XLymml8Muadg3sYvntQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PCT7kv4lLwlId2b6a1H2UtHOXaffwY7XOBlAY4XIY9O17QMgNxX48aZeqK7MSdrWX6xkooN3Wqb7k8tr9Jq2eJY1vVacPKw9h1l20DAmlTWGUCJ2hJJqrI2D+ZZaPWp7KHkqFYUBmK7mhli10SP1HPAbwDGPd64UqnKyPu92wIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=fho+RJaW; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=wqOFLfNV; arc=none smtp.client-ip=5.79.125.29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1783502518;
	bh=bYMx7THpHVtQ0n594Cs3wygpCcOwOfBrSmRxwAvvqss=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=fho+RJaWHagkqqCw3Co1yZGo5kOQq8E2oWYR12OOyLzUjJoehdUTCdz/lKbR7KfDo
	 qhok7ghKJXRuDB9S/d1R6zfuX4nhU8ephRkbfTDzmoyB07m/9ZCQVKDfnni6CtNvoF
	 MWX+2BibffYdNJHvpqM24DoEGYvRbDlszQP7kuHBzBPNcowBuDST9SubBoT6j6tY++
	 KVJLkA0BzoZM0vpcqSozrMwwaa8F/QpMLFhChU0X7nI5o+2ot/CBYEBzaHyf3IvGV3
	 kgIcItQ9vPt8gTjaKrCEXlPNxfYpBQBu5MX8i0NS8VAcpNncPV5Z4H7hasw4TZaXCW
	 jCP1V/+GJ207Q==
Received: from mailhub16-fb.kaspersky-labs.com (localhost [127.0.0.1])
	by mailhub16-fb.kaspersky-labs.com (Postfix) with ESMTP id F37FFC07D5E;
	Wed,  8 Jul 2026 12:21:57 +0300 (MSK)
Received: from mx15.kaspersky-labs.com (mx15.kaspersky-labs.com [46.165.235.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "mx15.kaspersky-labs.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub16-fb.kaspersky-labs.com (Postfix) with ESMTPS id CA911C00801;
	Wed,  8 Jul 2026 12:21:57 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1783502510;
	bh=bYMx7THpHVtQ0n594Cs3wygpCcOwOfBrSmRxwAvvqss=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=wqOFLfNVUM6w6Y3LuRVWCUZN1PTKHvBMJ8V+wZlWGyX3/rKSIOUecqgZ4rfO9vH6s
	 lJyezaAKpRSeCBDBqbrGlPsDK+yCNj/qsobidWujGD8VcbbFAwFZLHHq5epb51eJuj
	 weQIDqBPP33bKaR0EDGvMDihLWRsyj4fW5oQwpWvW7T2Pzv4XA1Sjc8k8ATvalwLIM
	 DlUJlynTPFYwGDzBGgvdlByJQcdMmDjp/ZVvNfOXGy+QZrYOoBUASX3MHHy5t4370x
	 8aPvtnrZkaqRh9z1gOui5jWbLZUn2maafMXLKH0w2Q6imi9eTKn1/w8Pxlpa41mYIU
	 5Gf/VS7gP14xw==
Received: from relay15.kaspersky-labs.com (localhost [127.0.0.1])
	by relay15.kaspersky-labs.com (Postfix) with ESMTP id 8DEEAA25B6;
	Wed,  8 Jul 2026 12:21:50 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub15.kaspersky-labs.com (Postfix) with ESMTPS id 5544CA256F;
	Wed,  8 Jul 2026 12:21:49 +0300 (MSK)
Received: from chesnokov.avp.ru (10.16.105.7) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 12:21:48 +0300
From: <Alexander.Chesnokov@kaspersky.com>
To: <xuhaoyue1@hisilicon.com>
CC: David Laight <david.laight.linux@gmail.com>,
	<lvc-project@linuxtesting.org>, <Oleg.Kazakov@kaspersky.com>,
	<Pavel.Zhigulin@kaspersky.com>, <stable@vger.kernel.org>, Wenpeng Liang
	<liangwenpeng@huawei.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, Xi Wang <wangxi11@huawei.com>, Weihang Li
	<liweihang@huawei.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alexander Chesnokov
	<Alexander.Chesnokov@kaspersky.com>
Subject: [PATCH v2] RDMA/hns: Fix arithmetic overflow in hns_roce_v2_set_hem()
Date: Wed, 8 Jul 2026 12:21:46 +0300
Message-ID: <20260708092146.3325855-1-Alexander.Chesnokov@kaspersky.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707140938.3106919-1-Alexander.Chesnokov@kaspersky.com>
References: <20260707140938.3106919-1-Alexander.Chesnokov@kaspersky.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV5.avp.ru (10.64.57.55) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 07/08/2026 09:07:19
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 204317 [Jul 08 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.22
X-KSE-AntiSpam-Info: Envelope from: Alexander.Chesnokov@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 112 0.3.112
 7c8d497b0e572fbfa504a2ee62037c045a8cb4ec
X-KSE-AntiSpam-Info: {date_rfc_vio_soft_silent}
X-KSE-AntiSpam-Info: {Tracking_ml_letters}
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: chesnokov.avp.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;kaspersky.com:7.1.1,5.0.1;lore.kernel.org:7.1.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/08/2026 09:10:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/8/2026 7:38:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/07/08 07:50:00
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/07/08 04:33:00 #28416621
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/07/08 07:50:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kaspersky.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kaspersky.com:s=mail202505];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[Alexander.Chesnokov@kaspersky.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[gmail.com,linuxtesting.org,kaspersky.com,vger.kernel.org,huawei.com,ziepe.ca,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22875-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xuhaoyue1@hisilicon.com,m:david.laight.linux@gmail.com,m:lvc-project@linuxtesting.org,m:Oleg.Kazakov@kaspersky.com,m:Pavel.Zhigulin@kaspersky.com,m:stable@vger.kernel.org,m:liangwenpeng@huawei.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:wangxi11@huawei.com,m:liweihang@huawei.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Alexander.Chesnokov@kaspersky.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kaspersky.com:from_mime,kaspersky.com:email,kaspersky.com:mid,kaspersky.com:dkim,linuxtesting.org:url];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Alexander.Chesnokov@kaspersky.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kaspersky.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43A64723C73

From: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>

If hop_num is 2 or 1, then the expressions like
i * chunk_ba_num + j are computed in 32-bit
arithmetic before being assigned to a u64 index field,
which can lead to overflow.

Declare i, j and k as u64 so that the address index
arithmetic is performed in 64-bit.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: a81fba28136d ("RDMA/hns: Configure BT BA and BT attribute for the contexts in hip08")
Cc: stable@vger.kernel.org
Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>

---
Changes in v2:
- Instead of casting the operands to u64, declare i, j and k as u64
  so the index arithmetic is performed in 64-bit (David Laight).

v1: https://lore.kernel.org/linux-rdma/20260707140938.3106919-1-Alexander.Chesnokov@kaspersky.com/
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 1c180a6b1c07..3469a9a68d3b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4238,7 +4238,7 @@ static int hns_roce_v2_set_hem(struct hns_roce_dev *hr_dev,
 	struct hns_roce_hem_mhop mhop;
 	struct hns_roce_hem *hem;
 	unsigned long mhop_obj = obj;
-	int i, j, k;
+	u64 i, j, k;
 	int ret = 0;
 	u64 hem_idx = 0;
 	u64 l1_idx = 0;
-- 
2.43.0


