Return-Path: <linux-rdma+bounces-6045-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D15A9D4371
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2024 22:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB23282F60
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2024 21:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86EF156872;
	Wed, 20 Nov 2024 21:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="kdB08FMd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from ksmg02.maxima.ru (ksmg02.maxima.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A71386D7;
	Wed, 20 Nov 2024 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732137527; cv=none; b=h1WdxYFoS+bHpmyTdsuEiW5ulHIwuhe3Gi+7tEDE7sBxCcN1Fag48GGusWP4WOin6QWJveB59kCP9GV06HRaxGzloK2/MS/fKXdcq93CaT+AF3zoBMDOaZRqxgsDiir+oJhAWlYemQo8UOdnVyKiCN1nrsMr67w8J/Yze32Hmjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732137527; c=relaxed/simple;
	bh=s/ykia8tnQquMAciCLcq2D1BsQ1o40nj9QdizvoVbks=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=napd5cr8WyyDnSso8xIiOhyZt1GJHMsu6H3Xv41VgeOCIcb8ylOevBogY+YAv6npWYFmsEwfYt8C4JPsg6Is9RaqnR25taihoFKH1PKu1qAM2MERrojeE/jBANyqGbB8Q3A2NtKTd/VZvX8o/BcTiU5OfccbhHpTcfNOBSIjS3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=maxima.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=kdB08FMd; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxima.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id B85B11E0010;
	Thu, 21 Nov 2024 00:18:32 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru B85B11E0010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1732137512; bh=dXFFfkwKeRkZcHX5xFLpg60SG0o9S7rzk+KxSIUCzgk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=kdB08FMdFrg89QOmVYldTaVKLSQIeJz0R8QTxhaCBvlc2FpLfMvYqlPfTr4MkMwda
	 pxP8f7EpGTzEaNL2zOxYInTqdPrIqkTK6QDVP85jqGBR8dnsklpB1soKrgDcon1CS0
	 sLU68i9fCudm8IuEC40c1mSWqsgKoGVmL2fBC0VkdYbEBQMRRZTCawoHOENzHoJHr4
	 iITieYuWdk6Or21233RNHO2QzctNRkaghoztwTRhLiL6gPPxS1M5wxlDa1dex2cRPd
	 xmET58w9N1D+lxXuNSJXYl80pd+ecuu1o/Po11gxCiSf2+4oDF/MYJj0jvK6l/CpHS
	 oJO9oDDBJHU0w==
Received: from ksmg02.maxima.ru (mail.maxima.ru [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Thu, 21 Nov 2024 00:18:32 +0300 (MSK)
Received: from GS-NOTE-190.mt.ru (10.0.247.42) by mmail-p-exch02.mt.ru
 (81.200.124.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Thu, 21 Nov
 2024 00:18:31 +0300
From: Murad Masimov <m.masimov@maxima.ru>
To: Mustafa Ismail <mustafa.ismail@intel.com>
CC: Murad Masimov <m.masimov@maxima.ru>, Tatyana Nikolova
	<tatyana.e.nikolova@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Shiraz Saleem <shiraz.saleem@intel.com>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] RDMA/irdma: prevent out-of-bounds shift on timeout calculation
Date: Thu, 21 Nov 2024 00:18:07 +0300
Message-ID: <20241120211809.922-1-m.masimov@maxima.ru>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch02.mt.ru
 (81.200.124.62)
X-KSMG-Rule-ID: 7
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189318 [Nov 20 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: m.masimov@maxima.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dmarc=none header.from=maxima.ru;spf=none smtp.mailfrom=maxima.ru;dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 42 0.3.42 bec10d90a7a48fa5da8c590feab6ebd7732fec6b, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;maxima.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;81.200.124.62:7.1.2;ksmg02.maxima.ru:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.62
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/20 17:47:00 #26877225
X-KSMG-AntiVirus-Status: Clean, skipped

After some finite number of tries, bitshift in the calculation of timetosend at
function irdma_cm_timer_tick() will lead to out-of-bounds shift, which in this
case is an undefined behaviour. For instance, if HZ is equal to 1024, the issue
occurs after 21 tries, which will take less than
IRDMA_MAX_TIMEOUT / HZ * 21 = 252 seconds.

Lower IRDMA_DEFAULT_RETRANS from 32 to 20 to prevent out-of-bounds shift for
any HZ value less than 2048.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 8385a875c9ee ("RDMA/irdma: Increase iWARP CM default rexmit count")
Signed-off-by: Murad Masimov <m.masimov@maxima.ru>
---
 drivers/infiniband/hw/irdma/cm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/cm.h b/drivers/infiniband/hw/irdma/cm.h
index 48ee285cf745..dc4ee1b185eb 100644
--- a/drivers/infiniband/hw/irdma/cm.h
+++ b/drivers/infiniband/hw/irdma/cm.h
@@ -41,7 +41,7 @@
 #define TCP_OPTIONS_PADDING	3

 #define IRDMA_DEFAULT_RETRYS	64
-#define IRDMA_DEFAULT_RETRANS	32
+#define IRDMA_DEFAULT_RETRANS	20
 #define IRDMA_DEFAULT_TTL		0x40
 #define IRDMA_DEFAULT_RTT_VAR		6
 #define IRDMA_DEFAULT_SS_THRESH		0x3fffffff
--
2.39.2


