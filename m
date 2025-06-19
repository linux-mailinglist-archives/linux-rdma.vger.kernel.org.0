Return-Path: <linux-rdma+bounces-11440-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB79ADFB6F
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 04:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8581BC144E
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 02:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C927214232;
	Thu, 19 Jun 2025 02:51:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B392113B5AE;
	Thu, 19 Jun 2025 02:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750301482; cv=none; b=rR249z6gjX8cIbc6fW9MWJ1V18WGERKUPlEuNPSZP74pCI939dOHPnJ4ZJ0tiVdnR0kcaAMlYxboxIyCV9oETQ85gCXIW5vTD87sls0AZbZoovFOgsWHMknzjhHPEwaSsvmoNvQw1UuGtAMJBZGTL0tuUXNprtmm1DLiKbFnMzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750301482; c=relaxed/simple;
	bh=jyRflxAFHZroptj2sNJ+CcplE3Wd/GyADtBwSwXDZcQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Aqrsrv9eu3XenIYJ2bpyedSCaLtvohPoDq+essX2UQuS1Y3hVpl/VZDFOng6z0QhwTSM2qQCBM4YO6ZHyuLMKk7JeN+qTNjd3vpiT2pd2t+KZemkFZMnP3dkqfF2M+PYDDFNOLl8vaGXx9Tax7WhTP+kUXCc5aWfofCgCRLbPms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bN4rm4lzrz2QVJY;
	Thu, 19 Jun 2025 10:52:08 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id A80B81800B2;
	Thu, 19 Jun 2025 10:51:14 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Jun
 2025 10:51:13 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<linux-rdma@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net/smc: remove unused function smc_lo_supports_v2
Date: Thu, 19 Jun 2025 11:08:54 +0800
Message-ID: <20250619030854.1536676-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500016.china.huawei.com (7.185.36.197)

The smcd_ops->supports_v2 is only called in smcd_register_dev(), which
calls function smcd_supports_v2 for ism. For loopback-ism, function
smc_lo_supports_v2 is unused, remove it.

Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 net/smc/smc_loopback.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 3c5f64ca4115..0eb00bbefd17 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -251,11 +251,6 @@ static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
 	return 0;
 }
 
-static int smc_lo_supports_v2(void)
-{
-	return SMC_LO_V2_CAPABLE;
-}
-
 static void smc_lo_get_local_gid(struct smcd_dev *smcd,
 				 struct smcd_gid *smcd_gid)
 {
@@ -288,7 +283,6 @@ static const struct smcd_ops lo_ops = {
 	.reset_vlan_required	= NULL,
 	.signal_event		= NULL,
 	.move_data = smc_lo_move_data,
-	.supports_v2 = smc_lo_supports_v2,
 	.get_local_gid = smc_lo_get_local_gid,
 	.get_chid = smc_lo_get_chid,
 	.get_dev = smc_lo_get_dev,
-- 
2.34.1


