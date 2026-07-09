Return-Path: <linux-rdma+bounces-22918-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q8SbOasrT2pLbgIAu9opvQ
	(envelope-from <linux-rdma+bounces-22918-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 07:03:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6363672CAE1
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 07:03:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kaspersky.com header.s=mail202505 header.b=lzPkDEti;
	dmarc=pass (policy=reject) header.from=kaspersky.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22918-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22918-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3CEB3025928
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 05:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC76435F603;
	Thu,  9 Jul 2026 05:03:33 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx16.kaspersky-labs.com (mx16.kaspersky-labs.com [5.79.125.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517091E633C;
	Thu,  9 Jul 2026 05:03:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783573413; cv=none; b=lxXi43yxhggQ9/SQfLjTV+pksopBOdjklxVFUiZDalHeuDveRNNWtjWgvGo5VghAnCxoRlMAN8POYF0s5lUWFc1XxpCspKYbbmMfk+eVkrlvYu49YEZ8CQlbsCFxk9BmzKgu3ikW1MVYKiGlhQfT9pL27r5xEdQUaAgnDL7wnzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783573413; c=relaxed/simple;
	bh=gw+euuTjCrFmUIq9T71qCTkRERl0w07qKtqGrccYin4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U4a4gl/lgcXV5mp1ZKt+tlOKB0hlQ7Mrt5AsJJer7V/nb/nxLs8xv76MRbNOJxyRzP5K7ZqSrTKVPH2cwEU/9azt/AcsKkN2jNyOkFQcl/vI0IlJ2PAvWMKn1XATOBz8XGKXrOny9cUC718LjT4RqitebUoWdr2DzC33944cAWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=lzPkDEti; arc=none smtp.client-ip=5.79.125.27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1783573409;
	bh=qmZDe8r0X/oqBgTFEuKUkTDyfZFKoZREoLtPJMkS/nM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=lzPkDEtisS1cExrWdLrlMwX+XGemJb1f5R/EO3rqctNz25bqstUlBcrsig02XcfMd
	 qQRnpz6ptCeR2zGAMf+MU6dWHOdbFRV3FfVjVoHl2M2P50ePlGwmsrEXuO9FEaVikC
	 mnb8FNVGC9Pk8jRKBVtOlh+nXMYRNU2ECaX1Qwv9xU59tEP8Z3vCqMqO2gcuwemCvf
	 n1+ZVXzVYhJujToWTRYpeo5qydYriqf7vD/dW3xjdDwISw8uqEc+llwULYMvMU8HXk
	 nQZx9YXKO/BjBJa69yOKxoJJy8obJe3hvYrFbEUo6lpIz1y4+whhYAUo+oOM7mYrhg
	 pcez4RRaLLNnQ==
Received: from relay16.kaspersky-labs.com (localhost [127.0.0.1])
	by relay16.kaspersky-labs.com (Postfix) with ESMTP id C047FC08804;
	Thu,  9 Jul 2026 08:03:29 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub16.kaspersky-labs.com (Postfix) with ESMTPS id 84261C086A9;
	Thu,  9 Jul 2026 08:03:29 +0300 (MSK)
Received: from chesnokov.avp.ru (10.16.105.7) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 08:03:28 +0300
From: <Alexander.Chesnokov@kaspersky.com>
To: <xuhaoyue1@hisilicon.com>
CC: David Laight <david.laight.linux@gmail.com>,
	<lvc-project@linuxtesting.org>, <Oleg.Kazakov@kaspersky.com>,
	<Pavel.Zhigulin@kaspersky.com>, Wenpeng Liang <liangwenpeng@huawei.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Xi Wang
	<wangxi11@huawei.com>, Weihang Li <liweihang@huawei.com>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alexander
 Chesnokov <Alexander.Chesnokov@kaspersky.com>
Subject: [PATCH v3] RDMA/hns: Compute HEM index in 64-bit in hns_roce_v2_set_hem()
Date: Thu, 9 Jul 2026 08:03:27 +0300
Message-ID: <20260709050327.3547237-1-Alexander.Chesnokov@kaspersky.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV2.avp.ru (10.64.57.52) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 07/09/2026 04:48:57
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 204344 [Jul 08 2026]
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
X-KSE-AntiSpam-Info: chesnokov.avp.ru:5.0.1,7.1.1;kaspersky.com:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;lore.kernel.org:7.1.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/09/2026 04:51:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/9/2026 4:11:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/07/09 04:16:00
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/07/09 04:20:00 #28429125
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/07/09 04:16:00
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
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,linuxtesting.org,kaspersky.com,huawei.com,ziepe.ca,kernel.org,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22918-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xuhaoyue1@hisilicon.com,m:david.laight.linux@gmail.com,m:lvc-project@linuxtesting.org,m:Oleg.Kazakov@kaspersky.com,m:Pavel.Zhigulin@kaspersky.com,m:liangwenpeng@huawei.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:wangxi11@huawei.com,m:liweihang@huawei.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Alexander.Chesnokov@kaspersky.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Alexander.Chesnokov@kaspersky.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kaspersky.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,kaspersky.com:from_mime,kaspersky.com:email,kaspersky.com:mid,kaspersky.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6363672CAE1

From: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>

In hns_roce_v2_set_hem() the HEM address indices are computed from
i, j and k (the base-chunk_ba_num decomposition of the 32-bit
table_idx) in 32-bit arithmetic and then assigned to u64 fields.
The recombined value always equals table_idx and cannot exceed
U32_MAX, so this is not a reachable overflow and has no user-visible
impact. Declare i, j and k as u64 so the calculation is done in
64-bit and the pattern no longer trips static analyzers.

No functional change intended.

Found by Linux Verification Center (linuxtesting.org) with SVACE.
Suggested-by: David Laight <david.laight.linux@gmail.com>

Signed-off-by: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
---
Changes in v3:
- Drop the Fixes: tag and Cc: stable and reword the subject/commit
  message: there is no reachable overflow, so this is a robustness
  cleanup rather than a bug fix (David Laight).
- Resend as a standalone message, not threaded under the previous
  version (Leon Romanovsky).

Changes in v2:
- Declare i, j and k as u64 instead of casting the operands (David Laight).

Previous discussion:
https://lore.kernel.org/linux-rdma/20260707140938.3106919-1-Alexander.Chesnokov@kaspersky.com/
https://lore.kernel.org/linux-rdma/20260708092146.3325855-1-Alexander.Chesnokov@kaspersky.com/

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


