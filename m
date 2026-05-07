Return-Path: <linux-rdma+bounces-20107-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP+dAj/p+2nEHwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20107-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 03:22:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBA04E1EA5
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 03:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1D7E30237CF
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 01:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A742248F7C;
	Thu,  7 May 2026 01:21:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D161D5174
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 01:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778116916; cv=none; b=U/WIORitnrHgkYAhIgOkAKEBUrzYswefBmdrzKvSpv84s52Nk3WNmMyW1RKq5T1gROrbZv5OxnloTIOB6u/4bK6SHuHcIw1viYZr2CGMCtz25F6ZsKE8j0swammTmOjQJKqUJF+U1SfqLx5YZKl4QeFGnKSVW8YYHhIWfor597M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778116916; c=relaxed/simple;
	bh=c2G7BDryp2z77SUojWXTE39e4DWgZZat9kgs8bmkHsY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ce0HO3z2tp2CbvYBhA1AO2zW7EhJ0wMUjV/BoGO3425igVSwv7Y6ppZuvyRa6Xw0AaOh9qlX6py0Yut8iw8JcyxDt09NRYFOLOUyrbiN4nPzki256iPOZ4/BblaPiPvLxKlAsyZpNrhw7YXp46v4OlB3DdYrczUHmF7L4SiYKZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4g9vRD6STQzRhQT;
	Thu,  7 May 2026 09:14:16 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id CB69920226;
	Thu,  7 May 2026 09:21:49 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 7 May 2026 09:21:49 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH v2 for-next 1/3] RDMA/hns: Initialize seqfile before creating file
Date: Thu, 7 May 2026 09:21:46 +0800
Message-ID: <20260507012148.1079712-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260507012148.1079712-1-huangjunxian6@hisilicon.com>
References: <20260507012148.1079712-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100018.china.huawei.com (7.202.181.17)
X-Rspamd-Queue-Id: BDBA04E1EA5
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-20107-lists,linux-rdma=lfdr.de];
	TAGGED_RCPT(0.00)[linux-rdma];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huangjunxian6@hisilicon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hisilicon.com:email,hisilicon.com:mid]
X-Rspamd-Action: no action

The debugfs file was created before seq->read and seq->data were set,
leaving a small window where userspace could access an uninitialized
seqfile.

Move debugfs_create_file() after the assignments to avoid this issue.
Also, inline the original init_debugfs_seqfile() since it is not a
really necessary helper.

Fixes: ca7ad04cd5d2 ("RDMA/hns: Add debugfs to hns RoCE")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_debugfs.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_debugfs.c b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
index b869cdc54118..db32c5897640 100644
--- a/drivers/infiniband/hw/hns/hns_roce_debugfs.c
+++ b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
@@ -26,17 +26,6 @@ static const struct file_operations hns_debugfs_seqfile_fops = {
 	.llseek = seq_lseek
 };
 
-static void init_debugfs_seqfile(struct hns_debugfs_seqfile *seq,
-				 const char *name, struct dentry *parent,
-				 int (*read_fn)(struct seq_file *, void *),
-				 void *data)
-{
-	debugfs_create_file(name, 0400, parent, seq, &hns_debugfs_seqfile_fops);
-
-	seq->read = read_fn;
-	seq->data = data;
-}
-
 static const char * const sw_stat_info[] = {
 	[HNS_ROCE_DFX_AEQE_CNT] = "aeqe",
 	[HNS_ROCE_DFX_CEQE_CNT] = "ceqe",
@@ -76,10 +65,12 @@ static void create_sw_stat_debugfs(struct hns_roce_dev *hr_dev,
 {
 	struct hns_sw_stat_debugfs *dbgfs = &hr_dev->dbgfs.sw_stat_root;
 
-	dbgfs->root = debugfs_create_dir("sw_stat", parent);
+	dbgfs->sw_stat.read = sw_stat_debugfs_show;
+	dbgfs->sw_stat.data = hr_dev;
 
-	init_debugfs_seqfile(&dbgfs->sw_stat, "sw_stat", dbgfs->root,
-			     sw_stat_debugfs_show, hr_dev);
+	dbgfs->root = debugfs_create_dir("sw_stat", parent);
+	debugfs_create_file("sw_stat", 0400, dbgfs->root, &dbgfs->sw_stat,
+			    &hns_debugfs_seqfile_fops);
 }
 
 /* debugfs for device */
-- 
2.33.0


