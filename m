Return-Path: <linux-rdma+bounces-22838-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wmRUKPEOTWp7uQEAu9opvQ
	(envelope-from <linux-rdma+bounces-22838-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 16:36:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8373571CB4E
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 16:36:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kaspersky.com header.s=mail202505 header.b=vRn2Ptud;
	dkim=pass header.d=kaspersky.com header.s=mail202505 header.b=nQqLH7JO;
	dmarc=pass (policy=reject) header.from=kaspersky.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22838-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22838-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A88D3050D41
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 14:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BF34252C0;
	Tue,  7 Jul 2026 14:17:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailhub9-fb.kaspersky-labs.com (mailhub9-fb.kaspersky-labs.com [195.122.169.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0308C41610A;
	Tue,  7 Jul 2026 14:17:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433834; cv=none; b=Ke+1mKKElGo3iR0GIbyh/GMoqcRTZj4b/KaP2QcHJxE4f1EEvtdmxTzOKXZ0DSvCq4qrf3n55GjwGT8fEI8jD6UyWiq46Vsp0thSejiqeNQgZNd6gmKiGLyg61/lE+M6ZkTgTY28Le2mkv/feeu0qY8fxQThG9WZh0jenqKpsPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433834; c=relaxed/simple;
	bh=yhGQahQOCPZz7JseoaL/a2P5LTYNU3VSFzzv5E3WmmI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r2UaGJ4RzZJry4v1elf1k8Gb/x/sP7XVij71wPFQmfnR4mERiyDgqOEXDhdO1tIeqigymM+V9g1krHOlPZu28j7qoqsHvtLv2zlom2DUIXK0apGmX9Lh0B9CfV5r2rHXPx/2oFV/DOBeoxzSSD7gYKW8rj6tfsWsX/U3b5gTd2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=vRn2Ptud; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=nQqLH7JO; arc=none smtp.client-ip=195.122.169.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1783433391;
	bh=KOpTyhoe2Irsyxnw0tccmTf6A2EilUrNjrxf0YkWg60=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=vRn2PtudRID+y3H07nwPKldyUMS5gNf/C8gPqMoD8iByNMDm0S1Ox9Z16LEUIibKk
	 PXhuhrMjIGbanyh2Nib8KTvfn82xuZkBBZpGs8tecmlZEcfSR6qEpVRZCw8lsjaTJD
	 QnKsAYiKogj6uD3wAdZ11lfG4THvqhYxGPe08epaexj8c/fA+U/Jnu05F/OTAMYj5h
	 9GgeN/kgAH/M3olN3RPlJgr/HPxYbg6j5sYklrehkOw1vSblucRuWfcnoXcXvr0AMG
	 9xRnc2iJ2YZzRlrrb188LVZQms12BLN+kI0tnnPvXQAQrSxYdp+Cvob7vu42+A22Cz
	 AOd4I3Mdh2dhQ==
Received: from mailhub9-fb.kaspersky-labs.com (localhost [127.0.0.1])
	by mailhub9-fb.kaspersky-labs.com (Postfix) with ESMTP id 79A3C900791;
	Tue,  7 Jul 2026 17:09:51 +0300 (MSK)
Received: from mx16.kaspersky-labs.com (mx16.kaspersky-labs.com [5.79.125.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "mx16.kaspersky-labs.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub9-fb.kaspersky-labs.com (Postfix) with ESMTPS id 524479005B9;
	Tue,  7 Jul 2026 17:09:51 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1783433382;
	bh=KOpTyhoe2Irsyxnw0tccmTf6A2EilUrNjrxf0YkWg60=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=nQqLH7JOL1XNYiK7NdUdzKmG4EQx/vv9vCEJeXwyrIhlqg3Icq4QrEeAbVyH8l4TO
	 6LHhz7ySVDFZyqv/YJGiziP7L+9/YTeCw/ComxFDQr2EvIDTinKUWkdrcXDExRFigR
	 zHYjIWd7+sIu95Qhcko4gKfhxVFkrFwnjgORNUXJHah0gh6CSi67kmz3oBtokrL+pK
	 qLB+j7H6GA94nHs+4jtvoALxUMDq7vBhRyvoti5j4gLEYNJ61Gsv8Rvm2qMtmYTTVr
	 g10n4oyC9FqGkloVy6bkw7+pIjNpVNK7elI1krYYKuVlL3SLx7mqHHFQf1I9Hf6qDD
	 vw2I4XTpJQwgA==
Received: from relay16.kaspersky-labs.com (localhost [127.0.0.1])
	by relay16.kaspersky-labs.com (Postfix) with ESMTP id E64E9C07655;
	Tue,  7 Jul 2026 17:09:42 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub16.kaspersky-labs.com (Postfix) with ESMTPS id 6C360C07A60;
	Tue,  7 Jul 2026 17:09:41 +0300 (MSK)
Received: from chesnokov.avp.ru (10.16.105.7) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 17:09:40 +0300
From: <Alexander.Chesnokov@kaspersky.com>
To: <xuhaoyue1@hisilicon.com>
CC: <lvc-project@linuxtesting.org>, <Oleg.Kazakov@kaspersky.com>,
	<Pavel.Zhigulin@kaspersky.com>, <stable@vger.kernel.org>, Wenpeng Liang
	<liangwenpeng@huawei.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, Xi Wang <wangxi11@huawei.com>, Weihang Li
	<liweihang@huawei.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alexander Chesnokov
	<Alexander.Chesnokov@kaspersky.com>
Subject: [PATCH] RDMA/hns: Fix arithmetic overflow in hns_roce_v2_set_hem()
Date: Tue, 7 Jul 2026 17:09:38 +0300
Message-ID: <20260707140938.3106919-1-Alexander.Chesnokov@kaspersky.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV3.avp.ru (10.64.57.53) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 07/07/2026 13:52:20
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 204297 [Jul 07 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.22
X-KSE-AntiSpam-Info: Envelope from: Alexander.Chesnokov@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 112 0.3.112
 7c8d497b0e572fbfa504a2ee62037c045a8cb4ec
X-KSE-AntiSpam-Info: {date_rfc_vio_soft_silent}
X-KSE-AntiSpam-Info: {Tracking_ml_letters}
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;chesnokov.avp.ru:7.1.1,5.0.1;kaspersky.com:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/07/2026 13:54:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/7/2026 1:33:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/07/07 13:46:00 #28409727
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kaspersky.com,reject];
	R_DKIM_ALLOW(-0.20)[kaspersky.com:s=mail202505];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-22838-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[Alexander.Chesnokov@kaspersky.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:xuhaoyue1@hisilicon.com,m:lvc-project@linuxtesting.org,m:Oleg.Kazakov@kaspersky.com,m:Pavel.Zhigulin@kaspersky.com,m:stable@vger.kernel.org,m:liangwenpeng@huawei.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:wangxi11@huawei.com,m:liweihang@huawei.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Alexander.Chesnokov@kaspersky.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxtesting.org:url,vger.kernel.org:from_smtp,kaspersky.com:from_mime,kaspersky.com:email,kaspersky.com:mid,kaspersky.com:dkim];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Alexander.Chesnokov@kaspersky.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kaspersky.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8373571CB4E

From: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>

If hop_num is 2 or 1, then the expressions like
i * chunk_ba_num + j are computed in 32-bit
arithmetic before being assigned to a u64 index field,
which can lead to overflow.

Cast the first operand to u64 to ensure the arithmetic
is performed in 64-bit.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: a81fba28136d ("RDMA/hns: Configure BT BA and BT attribute for the contexts in hip08")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 1c180a6b1c07..b62513b4db09 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4257,11 +4257,11 @@ static int hns_roce_v2_set_hem(struct hns_roce_dev *hr_dev,
 	chunk_ba_num = mhop.bt_chunk_size / 8;
 
 	if (hop_num == 2) {
-		hem_idx = i * chunk_ba_num * chunk_ba_num + j * chunk_ba_num +
+		hem_idx = (u64)i * chunk_ba_num * chunk_ba_num + (u64)j * chunk_ba_num +
 			  k;
-		l1_idx = i * chunk_ba_num + j;
+		l1_idx = (u64)i * chunk_ba_num + j;
 	} else if (hop_num == 1) {
-		hem_idx = i * chunk_ba_num + j;
+		hem_idx = (u64)i * chunk_ba_num + j;
 	} else if (hop_num == HNS_ROCE_HOP_NUM_0) {
 		hem_idx = i;
 	}
-- 
2.43.0


