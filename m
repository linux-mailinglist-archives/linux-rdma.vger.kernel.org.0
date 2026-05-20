Return-Path: <linux-rdma+bounces-21019-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDhNJodNDWoNvwUAu9opvQ
	(envelope-from <linux-rdma+bounces-21019-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 07:58:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1286D587F5C
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 07:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 346EA300FFB4
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 05:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADF9370ADF;
	Wed, 20 May 2026 05:58:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4DF367B9C
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 05:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779256687; cv=none; b=hb3AEFe2uWGzpYF/IC0o2ij6X78Xz1dvrb2W/rgQ7WpG6qNs85Bne4u4j22wdSGr0bRYcpQqgkmZ+Pywtsh+7refkzatBKAttg9y1obJtn7BLrSzW1n0tNf4SPFUe57hSFNUSDkBpL2nmSo7d9oRkU6PJOqUK1WCLlmnkQesCo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779256687; c=relaxed/simple;
	bh=k+pU808WBOALoa9owiQSv6ZZkxUhtS4cm6Z3Nf9wdss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUiUkrZGnQgZrva45aH2hrASDToAdmCQRvJshTHRf0Zhi5GlKbey/jzn92fJh7xU5U4j9Bseg8gaULW6GVMZnA70cYZFnBNF3PIyya+1+BAsnDA/df3Nhee4RAC6JzrDdenzzteRLF8SlmmAc9SztPlHCvU1pi8qIrio8GGafMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gL0yH4hMWzpStM;
	Wed, 20 May 2026 13:50:47 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 304E14056B;
	Wed, 20 May 2026 13:58:01 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 20 May 2026 13:58:00 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 1/3] RDMA/hns: Fix memory leak of bonding resource
Date: Wed, 20 May 2026 13:57:57 +0800
Message-ID: <20260520055759.2354037-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260520055759.2354037-1-huangjunxian6@hisilicon.com>
References: <20260520055759.2354037-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100018.china.huawei.com (7.202.181.17)
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[hisilicon.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21019-lists,linux-rdma=lfdr.de];
	TAGGED_RCPT(0.00)[linux-rdma];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huangjunxian6@hisilicon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hisilicon.com:mid,hisilicon.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1286D587F5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In a corner case of concurrent driver removal and driver reset,
bonding resource is first released in hns_roce_hw_v2_exit() during
driver removal, and then is allocated again in hns_roce_register_device()
during driver reset. This leads to memory leak because the release
timing has already passed. This may also lead to a kernel panic
as below because of the leaked notifier callback:

 Call trace:
  0xffffa20fccc04978 (P)
  raw_notifier_call_chain+0x20/0x38
  call_netdevice_notifiers_info+0x60/0xb8
  netdev_lower_state_changed+0x4c/0xb8

Bonding resource allocation and release should occur only during
driver init and removal, so don't do the allocation during reset.

Fixes: b37ad2e290fc ("RDMA/hns: Initialize bonding resources")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index c17ff5347a01..a7308a3c586e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -795,6 +795,7 @@ static const struct ib_device_ops hns_roce_dev_restrack_ops = {
 
 static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 {
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hns_roce_ib_iboe *iboe = NULL;
 	struct device *dev = hr_dev->dev;
 	struct ib_device *ib_dev = NULL;
@@ -838,7 +839,8 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 
 	dma_set_max_seg_size(dev, SZ_2G);
 
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_BOND) {
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_BOND &&
+	    priv->handle->rinfo.reset_state != HNS_ROCE_STATE_RST_INIT) {
 		ret = hns_roce_alloc_bond_grp(hr_dev);
 		if (ret) {
 			dev_err(dev, "failed to alloc bond_grp for bus %u, ret = %d\n",
-- 
2.33.0


