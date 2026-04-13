Return-Path: <linux-rdma+bounces-19276-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLjOFAm23Gm2VgkAu9opvQ
	(envelope-from <linux-rdma+bounces-19276-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 11:23:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA2F3E9CA6
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 11:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C14273081EB1
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 09:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D358C3B27D7;
	Mon, 13 Apr 2026 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="xv8nx/x9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx9.kaspersky-labs.com (mx9.kaspersky-labs.com [195.122.169.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A413ACA5C;
	Mon, 13 Apr 2026 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.122.169.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776071734; cv=none; b=P5BksJ2rj5m1oPnZcpOARXp9URSo7VSyit3ueHoCKwu8XFQUtirGdCEJU7IVwE+zVegY/l4azUfxu5VrBhAtGS13VM82lcb3+WO9uJD9XA3Y/a8xSyMYW2/nZkvxsQbnegrK3EHA86i3Jpebunyx2WN5DfzuTs8yCbQoIFc6Q+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776071734; c=relaxed/simple;
	bh=my+4zcw8DCB3IRl9UpolPauVWAcCE826mU53qp36BWo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OXBnIzUUsC4pHV25X3jGER2SqsjjfvJFHKINRB4bU0HGti62KDQ/OnNmkz6DiWNGQoGyu2WKphDE+QDgfY/xRYKRPycWDVg4HpDtuYFVtig1r1QVnK3QBckfSVJGOPpeTGJVGjBTjy4q5q8Uh4GyF/2LfvxnSP3t/boETgPkhjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=xv8nx/x9; arc=none smtp.client-ip=195.122.169.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1776071730;
	bh=Vg75vwiFjoRJ3pwXhJsJ2pa+cPLCZD7VDsFftvV7KjU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=xv8nx/x9hQ/DDNon1rL2Q4mUPFYqgpSkQodaJW7WzpaaSOxC6uIg6RxTNrRh5pvr+
	 rfMvssuwJfyn5f5WZB/ommkq11vn1hbPAl3s6o1XeJMMipq9okApfaB12JXn5OtgU3
	 Ztd0DiFS1pABGJPCSkGEvz+HzV4Urvhoq5Hs35E5FFmKi9cWhZ/W/kPMoqljyZBALI
	 TEVF2k80/tfa1+qHX2BLL5FCUImo0vySfg9r/ytKCGnUJ5CHjDaKXhNKfPxa6tUE2i
	 KkX9ROrcUQ6jAlx1Y99kVgKsPToHE2qo7TwtZkWS/TXKlLU2qJ9y1EZmXgkgP+YSyF
	 a3me0L7z6GaYg==
Received: from relay9.kaspersky-labs.com (localhost [127.0.0.1])
	by relay9.kaspersky-labs.com (Postfix) with ESMTP id 42E908A063E;
	Mon, 13 Apr 2026 12:15:30 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub9.kaspersky-labs.com (Postfix) with ESMTPS id 0B4AA8A0F4C;
	Mon, 13 Apr 2026 12:15:29 +0300 (MSK)
Received: from chesnokov.avp.ru (10.16.105.7) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 13 Apr
 2026 12:15:28 +0300
From: <Alexander.Chesnokov@kaspersky.com>
To: <xuhaoyue1@hisilicon.com>
CC: <lvc-project@linuxtesting.org>, <Oleg.Kazakov@kaspersky.com>,
	<Pavel.Zhigulin@kaspersky.com>, Alexander Chesnokov
	<Alexander.Chesnokov@kaspersky.com>, <stable@vger.kernel.org>, Wenpeng Liang
	<liangwenpeng@huawei.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, Xi Wang <wangxi11@huawei.com>, Weihang Li
	<liweihang@huawei.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] RDMA/hns: Fix arithmetic overflow in calc_hem_config()
Date: Mon, 13 Apr 2026 12:14:43 +0300
Message-ID: <20260413091527.39990-1-Alexander.Chesnokov@kaspersky.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV4.avp.ru (10.64.57.54) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 04/13/2026 08:51:32
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 202221 [Apr 13 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.22
X-KSE-AntiSpam-Info: Envelope from: Alexander.Chesnokov@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 98 0.3.98
 ca9d2f3beca9ca2a85e178af9d8e97d5fa2c38a3
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: kaspersky.com:7.1.1,5.0.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;chesnokov.avp.ru:7.1.1,5.0.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/13/2026 08:54:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/13/2026 8:25:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/04/13 06:49:00 #28394185
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kaspersky.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kaspersky.com:s=mail202505];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19276-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kaspersky.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Alexander.Chesnokov@kaspersky.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxtesting.org:url,kaspersky.com:dkim,kaspersky.com:email,kaspersky.com:mid]
X-Rspamd-Queue-Id: 9FA2F3E9CA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>

If bt_num is 3 or 2, then the expressions like
l0_idx * chunk_ba_num + l1_idx are computed in 32-bit
arithmetic before being assigned to a u64 index field,
which can lead to overflow.

Cast the first operand to u64 to ensure the arithmetic
is performed in 64-bit.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 2f49de21f3e9 ("RDMA/hns: Optimize mhop get flow for multi-hop addressing")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 173ab794fa78..862acdf59867 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -355,14 +355,14 @@ static int calc_hem_config(struct hns_roce_dev *hr_dev,
 	bt_num = hns_roce_get_bt_num(table->type, mhop->hop_num);
 	switch (bt_num) {
 	case 3:
-		index->l1 = l0_idx * chunk_ba_num + l1_idx;
+		index->l1 = (u64)l0_idx * chunk_ba_num + l1_idx;
 		index->l0 = l0_idx;
-		index->buf = l0_idx * chunk_ba_num * chunk_ba_num +
-			     l1_idx * chunk_ba_num + l2_idx;
+		index->buf = (u64)l0_idx * chunk_ba_num * chunk_ba_num +
+					 (u64)l1_idx * chunk_ba_num + l2_idx;
 		break;
 	case 2:
 		index->l0 = l0_idx;
-		index->buf = l0_idx * chunk_ba_num + l1_idx;
+		index->buf = (u64)l0_idx * chunk_ba_num + l1_idx;
 		break;
 	case 1:
 		index->buf = l0_idx;
-- 
2.43.0


