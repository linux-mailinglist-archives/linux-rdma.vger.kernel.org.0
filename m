Return-Path: <linux-rdma+bounces-21747-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bTV0JZdlIWr9FgEAu9opvQ
	(envelope-from <linux-rdma+bounces-21747-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:46:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D3763F8A1
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:46:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=Yy0AOsGX;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21747-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21747-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 565DA309F751
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 11:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116794279F9;
	Thu,  4 Jun 2026 11:45:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529D1423A74;
	Thu,  4 Jun 2026 11:45:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573538; cv=none; b=TlCx0O9bINM6rnEgVKvQZNTlb0PO7sSSFn/XZ9xBXEzlkHrjdjbWvxjsFqr5gV5b1kaq9B54XwVws1eCuS4vbYnbBnPFCW7/SJXwb9tJKZ08T2mFX4ANMcQgVHooxXjXHIQWly6uQNEZpC9bDmamq6NSgcetRuInhkFwzgEDOWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573538; c=relaxed/simple;
	bh=f7LAI2PMsU85yi91Wa8asifcKa4mC4WqSt9elqWcYVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SEjPSsWOwJJhSf0MDaB0jZ1NdaikHFIt43cXxjdmmXReXzlukMLaUtks9LW8ZXzga2o4syNl63gdg/CdI+yU5Ouk7bNtuVQfc2HAUZJk+n9qPy8mSLfxG2QHJlm4QYfurjAwcDkLBK9yzqbGQjbg/Kz3xH1s5TNtGXmeHt7269A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Yy0AOsGX; arc=none smtp.client-ip=220.197.31.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=sK
	vRjgEOpE4ZRI9X65crI9iY1d6AFyn3P2P0M+TlX+4=; b=Yy0AOsGXD4xm40CCez
	yRApIn4Og7vSq+XAnSUpBE4woWX8vLfU2lzz04rwidQ4B1hj9qqWfMn66Ae+GCfP
	98IKWzvfkfNyQGLu8xs8VLzqJbzf4TqBjAsFvm+wujck3exB9+Loq1UhceUHR96c
	dMObKL1JxCWJ/EzYIjkce8tQM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgA320NHZSFqPEN8AQ--.47837S5;
	Thu, 04 Jun 2026 19:45:13 +0800 (CST)
From: hginjgerx@163.com
To: huangjunxian6@hisilicon.com,
	hginjgerx@qq.com
Cc: Chengchang Tang <tangchengchang@huawei.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org (open list:HISILICON ROCE DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH for-next 3/3] RDMA/hns: Support setting GSI QP SL
Date: Thu,  4 Jun 2026 19:45:10 +0800
Message-Id: <20260604114510.2955010-4-hginjgerx@163.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260604114510.2955010-1-hginjgerx@163.com>
References: <20260604114510.2955010-1-hginjgerx@163.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgA320NHZSFqPEN8AQ--.47837S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF4kXF4DZw4DCFWxArW3trb_yoWrXw17pa
	n0kFyYkrWUGF12gws3Cr47Zryftas3W3srJFyvk34avrsxC3yFqrnFkry8JrykJr98Gw4a
	qr45JrZY9a4xWw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b8fO7UUUUU=
X-CM-SenderInfo: hkjl0yhjhu5qqrwthudrp/xtbDAAlOIWohZUmmMAAA3X
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21747-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[hginjgerx@163.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:huangjunxian6@hisilicon.com,m:hginjgerx@qq.com,m:tangchengchang@huawei.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[hisilicon.com,qq.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hginjgerx@163.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,huawei.com:email,hisilicon.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61D3763F8A1

From: Chengchang Tang <tangchengchang@huawei.com>

Add debugfs interface to set SL for GSI QP. The interface validates
that SL value does not exceed MAX_SERVICE_LEVEL.

The GSI QP uses the configured SL instead of the SL from AH when
posting UD SQ WQE.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_debugfs.c | 30 ++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_debugfs.h |  1 +
 drivers/infiniband/hw/hns/hns_roce_device.h  |  1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c   |  5 ++--
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_debugfs.c b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
index 05630f7c9155..2f9410fdd0d7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_debugfs.c
+++ b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
@@ -339,6 +339,29 @@ static void create_cc_param_debugfs(struct hns_roce_dev *hr_dev,
 	}
 }
 
+static int gsi_sl_debugfs_read(struct seq_file *seq, void *data)
+{
+	struct hns_roce_dev *hr_dev = data;
+
+	seq_printf(seq, "%u\n", hr_dev->gsi_sl);
+	return 0;
+}
+
+static ssize_t gsi_sl_debugfs_write(char *buf, size_t count, void *data)
+{
+	struct hns_roce_dev *hr_dev = data;
+	u32 val;
+
+	if (kstrtou32(buf, 0, &val))
+		return -EINVAL;
+
+	if (val > MAX_SERVICE_LEVEL)
+		return -EINVAL;
+
+	hr_dev->gsi_sl = val;
+	return count;
+}
+
 /* debugfs for device */
 void hns_roce_register_debugfs(struct hns_roce_dev *hr_dev)
 {
@@ -349,6 +372,13 @@ void hns_roce_register_debugfs(struct hns_roce_dev *hr_dev)
 
 	create_sw_stat_debugfs(hr_dev, dbgfs->root);
 	create_cc_param_debugfs(hr_dev, dbgfs->root);
+
+	dbgfs->gsi_sl_seqfile.read = gsi_sl_debugfs_read;
+	dbgfs->gsi_sl_seqfile.write = gsi_sl_debugfs_write;
+	dbgfs->gsi_sl_seqfile.data = hr_dev;
+	debugfs_create_file("gsi_sl", 0600, dbgfs->root,
+			    &dbgfs->gsi_sl_seqfile,
+			    &hns_debugfs_seqfile_fops);
 }
 
 void hns_roce_unregister_debugfs(struct hns_roce_dev *hr_dev)
diff --git a/drivers/infiniband/hw/hns/hns_roce_debugfs.h b/drivers/infiniband/hw/hns/hns_roce_debugfs.h
index 116b1e8b6677..f04683900022 100644
--- a/drivers/infiniband/hw/hns/hns_roce_debugfs.h
+++ b/drivers/infiniband/hw/hns/hns_roce_debugfs.h
@@ -47,6 +47,7 @@ struct hns_roce_dev_debugfs {
 	struct dentry *root;
 	struct hns_sw_stat_debugfs sw_stat_root;
 	struct hns_cc_param_debugfs cc_param_root[CONG_TYPE_MAX_NUM];
+	struct hns_debugfs_seqfile gsi_sl_seqfile;
 };
 
 struct hns_roce_dev;
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 686610642c0a..8a5a116efd9e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1048,6 +1048,7 @@ struct hns_roce_dev {
 	struct hns_roce_dev_debugfs dbgfs;
 	atomic64_t *dfx_cnt;
 	struct hns_roce_scc_param *scc_param;
+	u8 gsi_sl;
 };
 
 enum hns_roce_trace_type {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 6dd56a85d890..8d6444f44553 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -442,8 +442,9 @@ static int fill_ud_av(struct hns_roce_qp *qp,
 	hr_reg_write(ud_sq_wqe, UD_SEND_WQE_HOPLIMIT, ah->av.hop_limit);
 	hr_reg_write(ud_sq_wqe, UD_SEND_WQE_TCLASS, ah->av.tclass);
 	hr_reg_write(ud_sq_wqe, UD_SEND_WQE_FLOW_LABEL, ah->av.flowlabel);
-	if (!qp->ud_sl_set) {
-		qp->sl = ah->av.sl;
+	if (!qp->ud_sl_set || qp->ibqp.qp_type == IB_QPT_GSI) {
+		qp->sl = qp->ibqp.qp_type == IB_QPT_GSI ?
+				hr_dev->gsi_sl : ah->av.sl;
 		qp->ud_sl_set = true;
 	}
 
-- 
2.33.0


