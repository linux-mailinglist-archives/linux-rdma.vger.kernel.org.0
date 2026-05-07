Return-Path: <linux-rdma+bounces-20105-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCv6Mjvp+2nEHwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20105-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 03:22:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B404E1E97
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 03:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 811EE300A5A6
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 01:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7518223370F;
	Thu,  7 May 2026 01:21:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5D9221FC6
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 01:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778116915; cv=none; b=NJGnNZNxwRVliC0tYs5FIgeSv+HiAHd3cDpYgpXOU7x4m2VPFUkNj98WjdEnJHNRaCsWapiuytjvZAmqUw3K1clWCOfoZrW6ko2keyJmJ0cmxiAuxNqjINxqHp8/HMWWg55u5MoaGiJqHE7W+KF9b72JBA7PuxhNZJdSNslpT9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778116915; c=relaxed/simple;
	bh=V2ep7v7094kgWqKQzYapMJvBUs4scLDss8yUUd8YcNs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/2fPvk9TfpRorqXjhFI8NSGcc0AzT78RbnojWfqLPhunLKU+CR0aPxLdnn9Yyb26V0poJG08Ph2UFzBI9Ovn9e4302iWtJczZfUKGRQnhBl/V1a/mCrm9r+RaMbtys33llHrKvDdhXaL+34hPxYaFbklk1o1oU1xrtEKwryHus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4g9vRG1nqnz1K96s;
	Thu,  7 May 2026 09:14:18 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A0B940562;
	Thu,  7 May 2026 09:21:50 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 7 May 2026 09:21:49 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH v2 for-next 2/3] RDMA/hns: Add write support to debugfs
Date: Thu, 7 May 2026 09:21:47 +0800
Message-ID: <20260507012148.1079712-3-huangjunxian6@hisilicon.com>
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
X-Rspamd-Queue-Id: C5B404E1E97
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[hisilicon.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20105-lists,linux-rdma=lfdr.de];
	TAGGED_RCPT(0.00)[linux-rdma];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huangjunxian6@hisilicon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hisilicon.com:email,hisilicon.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add write support to debugfs.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_debugfs.c | 20 ++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_debugfs.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_debugfs.c b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
index db32c5897640..724d5ad90bfe 100644
--- a/drivers/infiniband/hw/hns/hns_roce_debugfs.c
+++ b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
@@ -18,11 +18,31 @@ static int hns_debugfs_seqfile_open(struct inode *inode, struct file *f)
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


