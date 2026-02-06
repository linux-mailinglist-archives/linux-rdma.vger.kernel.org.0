Return-Path: <linux-rdma+bounces-16643-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMhLEALDhWltGAQAu9opvQ
	(envelope-from <linux-rdma+bounces-16643-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 11:31:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA923FCAA7
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 11:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FCAF3034C9D
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 10:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D36F37646A;
	Fri,  6 Feb 2026 10:31:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17522FE59A
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770373881; cv=none; b=oCBWVYqbtOz53igT9DNkDIJpPlm3I4HrNP3NawbiwOyd4IPyUPhAHJA9HsIh1qgkS5Oba0O5VQE+Vs8yVLZ7pDCbJMqBszeJRAI6OIIFhJnUIzcl8mquZF0+XvkWxRXqP+yA/cvvYjzLtNe+L5Piu/ATqc+BX7Dgjy+rEUVhZVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770373881; c=relaxed/simple;
	bh=ZWHxNxZ4dh6Zr5uvt38U6aDSH4EllB3o21ogwN+WtTE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fp2Z2D10B0EJ0YzQZsjpEA2TX1SeCkqcMFbfxtTXm4iDoxAssRxMfHN2040vvru6fWk2iwte/S0XxuCsFxRkyKl2gpEhr6MVJKbfBTmuuZkut6u+4EQs7xxX/Id+tckKzv0VqtZhon7JOa6neUzJt56iJ/7m+n0KtjLSFLKFNFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4f6qyG2xFSzcb2y;
	Fri,  6 Feb 2026 18:26:46 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id A50D440567;
	Fri,  6 Feb 2026 18:31:12 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 6 Feb 2026 18:31:12 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 2/3] RDMA/hns: Add write support to debugfs
Date: Fri, 6 Feb 2026 18:31:09 +0800
Message-ID: <20260206103110.3414311-3-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260206103110.3414311-1-huangjunxian6@hisilicon.com>
References: <20260206103110.3414311-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100018.china.huawei.com (7.202.181.17)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[hisilicon.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16643-lists,linux-rdma=lfdr.de];
	TAGGED_RCPT(0.00)[linux-rdma];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huangjunxian6@hisilicon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.980];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA923FCAA7
X-Rspamd-Action: no action

Add write support to debugfs.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_debugfs.c | 38 +++++++++++++++++---
 drivers/infiniband/hw/hns/hns_roce_debugfs.h |  1 +
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_debugfs.c b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
index 3f0a692e6ac7..32773ffb6f6e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_debugfs.c
+++ b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
@@ -18,23 +18,50 @@ static int hns_debugfs_seqfile_open(struct inode *inode, struct file *f)
 	return single_open(f, seqfile->read, seqfile->data);
 }
 
+static ssize_t hns_debugfs_seqfile_write(struct file *file,
+					 const char __user *buffer,
+					 size_t count, loff_t *ppos)
+{
+	struct hns_debugfs_seqfile *seqfile = file_inode(file)->i_private;
+	char buf[16] = {};
+
+	if (!seqfile->write)
+		return -EOPNOTSUPP;
+
+	if (count >= sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, buffer, count))
+		return -EFAULT;
+
+	return seqfile->write(buf, count, seqfile->data);
+}
+
 static const struct file_operations hns_debugfs_seqfile_fops = {
 	.owner = THIS_MODULE,
 	.open = hns_debugfs_seqfile_open,
 	.release = single_release,
 	.read = seq_read,
+	.write = hns_debugfs_seqfile_write,
 	.llseek = seq_lseek
 };
 
+struct hns_debugfs_rw_ops {
+	int (*read)(struct seq_file *seq, void *data);
+	ssize_t (*write)(char *buf, size_t count, void *data);
+};
+
 static void init_debugfs_seqfile(struct hns_debugfs_seqfile *seq,
 				 const char *name, struct dentry *parent,
-				 int (*read_fn)(struct seq_file *, void *),
+				 const struct hns_debugfs_rw_ops *ops,
 				 void *data)
 {
-	seq->read = read_fn;
+	seq->read = ops->read;
+	seq->write = ops->write;
 	seq->data = data;
 
-	debugfs_create_file(name, 0400, parent, seq, &hns_debugfs_seqfile_fops);
+	debugfs_create_file(name, ops->write ? 0600 : 0400, parent,
+			    seq, &hns_debugfs_seqfile_fops);
 }
 
 static const char * const sw_stat_info[] = {
@@ -75,11 +102,14 @@ static void create_sw_stat_debugfs(struct hns_roce_dev *hr_dev,
 				   struct dentry *parent)
 {
 	struct hns_sw_stat_debugfs *dbgfs = &hr_dev->dbgfs.sw_stat_root;
+	const struct hns_debugfs_rw_ops ops = {
+		.read = sw_stat_debugfs_show,
+	};
 
 	dbgfs->root = debugfs_create_dir("sw_stat", parent);
 
 	init_debugfs_seqfile(&dbgfs->sw_stat, "sw_stat", dbgfs->root,
-			     sw_stat_debugfs_show, hr_dev);
+			     &ops, hr_dev);
 }
 
 /* debugfs for device */
diff --git a/drivers/infiniband/hw/hns/hns_roce_debugfs.h b/drivers/infiniband/hw/hns/hns_roce_debugfs.h
index 98e87bd3161e..4e77dea0fbf6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_debugfs.h
+++ b/drivers/infiniband/hw/hns/hns_roce_debugfs.h
@@ -9,6 +9,7 @@
 /* debugfs seqfile */
 struct hns_debugfs_seqfile {
 	int (*read)(struct seq_file *seq, void *data);
+	ssize_t (*write)(char *buf, size_t count, void *data);
 	void *data;
 };
 
-- 
2.33.0


