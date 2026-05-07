Return-Path: <linux-rdma+bounces-20106-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mD8qJjzp+2nEHwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20106-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 03:22:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EEB4E1E9E
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 03:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E4A23022558
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 01:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0BF246768;
	Thu,  7 May 2026 01:21:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894A322F388
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 01:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778116915; cv=none; b=rxNYa4buK/tJYGyU5UGtjk+A3YFFyzE1g7dbRFoE/e7m7vUcChOsGr0rF4Rm2o7ZyUYq3E8buobTtqyYHNUzeebFKellP3nP7XZDpooUF5oYhtp2FnstDQEFy6QJlAb8iaBomj5uIaa5ibXUuSfllSB7QFeD86GW5cELRinSUDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778116915; c=relaxed/simple;
	bh=ESyqU1xQCyXNELDG1N5kSrTP8d+QCy56cJ5Vb4dBBew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFgtVbbLhlBRleWPsYNTTmwo20+INJ8uDIbOnHGOT0hS28GFyfc6PGsZJQ0/r4nL6JHXchLSfMN4psyO2YRvzktAqr32jawcyB4VTCrLuMJNQ44C4ysnBd+sbvbs4gY96LpeU0mDmanoGO/Lhy0fgQ72loHWevjvrx5+SGsIgXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4g9vRj3rFNz12LDG;
	Thu,  7 May 2026 09:14:41 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 6384940538;
	Thu,  7 May 2026 09:21:50 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 7 May 2026 09:21:49 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH v2 for-next 3/3] RDMA/hns: Support congestion control algorithm parameter configuration
Date: Thu, 7 May 2026 09:21:48 +0800
Message-ID: <20260507012148.1079712-4-huangjunxian6@hisilicon.com>
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
X-Rspamd-Queue-Id: 40EEB4E1E9E
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
	TAGGED_FROM(0.00)[bounces-20106-lists,linux-rdma=lfdr.de];
	TAGGED_RCPT(0.00)[linux-rdma];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huangjunxian6@hisilicon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hisilicon.com:email,hisilicon.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chengchang Tang <tangchengchang@huawei.com>

hns RoCE supports 4 congestion control algorithms. Each algorihm
involves multiple parameters. Support configuring these parameters
by debugfs.

Here are some examples of this feature:

* The directory structure:
$ ls /sys/kernel/debug/hns_roce/0000\:35\:00.0/
dcqcn_cc_param  dip_cc_param  hc3_cc_param  ldcp_cc_param
$ ls /sys/kernel/debug/hns_roce/0000\:35\:00.0/dcqcn_cc_param/
ai  al  alp  ashift  cnp_time  f  g  lifespan  max_speed  tkp  tmp

* Read the value of a param:
$ cat /sys/kernel/debug/hns_roce/0000\:35\:00.0/dcqcn_cc_param/ai
1

* Set a new value for a param:
$ echo 2 > /sys/kernel/debug/hns_roce/0000\:35\:00.0/dcqcn_cc_param/ai

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_debugfs.c | 251 +++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_debugfs.h |  25 ++
 drivers/infiniband/hw/hns/hns_roce_device.h  |  21 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c   |  54 ++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h   | 125 +++++++++
 5 files changed, 476 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_debugfs.c b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
index 724d5ad90bfe..efcbb79ac232 100644
--- a/drivers/infiniband/hw/hns/hns_roce_debugfs.c
+++ b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
@@ -3,11 +3,13 @@
  * Copyright (c) 2023 Hisilicon Limited.
  */
 
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/pci.h>
 
 #include "hns_roce_device.h"
+#include "hns_roce_hw_v2.h"
 
 static struct dentry *hns_roce_dbgfs_root;
 
@@ -93,6 +95,253 @@ static void create_sw_stat_debugfs(struct hns_roce_dev *hr_dev,
 			    &hns_debugfs_seqfile_fops);
 }
 
+#define __HNS_SCC_ATTR(_name, _type, _offset, _size, _min, _max) {	\
+	.name = _name,							\
+	.algo_type = _type,						\
+	.offset = _offset,						\
+	.size = _size,							\
+	.min = _min,							\
+	.max = _max,							\
+}
+
+#define HNS_DCQCN_CC_ATTR_RW(_name, NAME)				\
+	__HNS_SCC_ATTR(_name, HNS_ROCE_SCC_ALGO_DCQCN,			\
+			HNS_ROCE_DCQCN_##NAME##_OFS,			\
+			HNS_ROCE_DCQCN_##NAME##_SZ,			\
+			0, HNS_ROCE_DCQCN_##NAME##_MAX)
+
+#define HNS_LDCP_CC_ATTR_RW(_name, NAME)				\
+	__HNS_SCC_ATTR(_name, HNS_ROCE_SCC_ALGO_LDCP,			\
+			HNS_ROCE_LDCP_##NAME##_OFS,			\
+			HNS_ROCE_LDCP_##NAME##_SZ,			\
+			0, HNS_ROCE_LDCP_##NAME##_MAX)
+
+#define HNS_HC3_CC_ATTR_RW(_name, NAME)				\
+	__HNS_SCC_ATTR(_name, HNS_ROCE_SCC_ALGO_HC3,			\
+			HNS_ROCE_HC3_##NAME##_OFS,			\
+			HNS_ROCE_HC3_##NAME##_SZ,			\
+			HNS_ROCE_HC3_##NAME##_MIN,			\
+			HNS_ROCE_HC3_##NAME##_MAX)
+
+#define HNS_DIP_CC_ATTR_RW(_name, NAME)				\
+	__HNS_SCC_ATTR(_name, HNS_ROCE_SCC_ALGO_DIP,			\
+			HNS_ROCE_DIP_##NAME##_OFS,			\
+			HNS_ROCE_DIP_##NAME##_SZ,			\
+			0, HNS_ROCE_DIP_##NAME##_MAX)
+
+static const struct hns_roce_cong_attr {
+	enum hns_roce_cong_type cong_type;
+	const char *name;
+	struct hns_roce_cc_param_attr params[HNS_ROCE_CC_PARAM_MAX_NUM];
+} cong_attrs[] = {
+	{ CONG_TYPE_DCQCN, "dcqcn_cc_param",
+		{
+			HNS_DCQCN_CC_ATTR_RW("ai", AI),
+			HNS_DCQCN_CC_ATTR_RW("f", F),
+			HNS_DCQCN_CC_ATTR_RW("tkp", TKP),
+			HNS_DCQCN_CC_ATTR_RW("tmp", TMP),
+			HNS_DCQCN_CC_ATTR_RW("alp", ALP),
+			HNS_DCQCN_CC_ATTR_RW("max_speed", MAX_SPEED),
+			HNS_DCQCN_CC_ATTR_RW("g", G),
+			HNS_DCQCN_CC_ATTR_RW("al", AL),
+			HNS_DCQCN_CC_ATTR_RW("cnp_time", CNP_TIME),
+			HNS_DCQCN_CC_ATTR_RW("ashift", ASHIFT),
+		}
+	},
+	{ CONG_TYPE_LDCP, "ldcp_cc_param",
+		{
+			HNS_LDCP_CC_ATTR_RW("cwd0", CWD0),
+			HNS_LDCP_CC_ATTR_RW("alpha", ALPHA),
+			HNS_LDCP_CC_ATTR_RW("gamma", GAMMA),
+			HNS_LDCP_CC_ATTR_RW("beta", BETA),
+			HNS_LDCP_CC_ATTR_RW("eta", ETA),
+		}
+	},
+	{ CONG_TYPE_HC3, "hc3_cc_param",
+		{
+			HNS_HC3_CC_ATTR_RW("initial_window", INITIAL_WINDOW),
+			HNS_HC3_CC_ATTR_RW("bandwidth", BANDWIDTH),
+			HNS_HC3_CC_ATTR_RW("qlen_shift", QLEN_SHIFT),
+			HNS_HC3_CC_ATTR_RW("port_usage_shift", PORT_USAGE_SHIFT),
+			HNS_HC3_CC_ATTR_RW("over_period", OVER_PERIOD),
+			HNS_HC3_CC_ATTR_RW("max_stage", MAX_STAGE),
+			HNS_HC3_CC_ATTR_RW("gamma_shift", GAMMA_SHIFT),
+		}
+	},
+	{ CONG_TYPE_DIP, "dip_cc_param",
+		{
+			HNS_DIP_CC_ATTR_RW("ai", AI),
+			HNS_DIP_CC_ATTR_RW("f", F),
+			HNS_DIP_CC_ATTR_RW("tkp", TKP),
+			HNS_DIP_CC_ATTR_RW("tmp", TMP),
+			HNS_DIP_CC_ATTR_RW("alp", ALP),
+			HNS_DIP_CC_ATTR_RW("max_speed", MAX_SPEED),
+			HNS_DIP_CC_ATTR_RW("g", G),
+			HNS_DIP_CC_ATTR_RW("al", AL),
+			HNS_DIP_CC_ATTR_RW("cnp_time", CNP_TIME),
+			HNS_DIP_CC_ATTR_RW("ashift", ASHIFT),
+		}
+	}
+};
+
+static int cc_param_debugfs_show(struct seq_file *file, void *offset)
+{
+	struct hns_cc_param_seqfile *param_seqfile = file->private;
+	const struct hns_roce_cc_param_attr *param_attr = param_seqfile->param_attr;
+	int algo_type = param_attr->algo_type;
+	int index = param_seqfile->index;
+	struct hns_roce_dev *hr_dev =
+		container_of(param_seqfile, struct hns_roce_dev,
+			     dbgfs.cc_param_root[algo_type].params[index]);
+	struct hns_roce_scc_param *scc_param;
+	__le32 val = 0;
+
+	scc_param = &hr_dev->scc_param[algo_type];
+
+	scoped_guard(mutex, &scc_param->scc_mutex) {
+		memcpy(&val,
+		       (void *)scc_param->param + param_attr->offset,
+		       param_attr->size);
+	}
+
+	seq_printf(file, "%u\n", le32_to_cpu(val));
+
+	return 0;
+}
+
+static ssize_t cc_param_debugfs_store(char *buf, size_t count, void *data)
+{
+	struct hns_cc_param_seqfile *param_seqfile = data;
+	const struct hns_roce_cc_param_attr *param_attr = param_seqfile->param_attr;
+	int algo_type = param_attr->algo_type;
+	int index = param_seqfile->index;
+	struct hns_roce_dev *hr_dev =
+		container_of(param_seqfile, struct hns_roce_dev,
+			     dbgfs.cc_param_root[algo_type].params[index]);
+	struct hns_roce_scc_param *scc_param;
+	__le32 attr_val, old_val = 0;
+	u32 val;
+	int ret;
+
+	if (kstrtou32(buf, 0, &val))
+		return -EINVAL;
+
+	if (val > param_attr->max || val < param_attr->min)
+		return -EINVAL;
+
+	attr_val = cpu_to_le32(val);
+	scc_param = &hr_dev->scc_param[algo_type];
+	guard(mutex)(&scc_param->scc_mutex);
+
+	memcpy(&old_val, (void *)scc_param->param + param_attr->offset,
+	       param_attr->size);
+	memcpy((void *)scc_param->param + param_attr->offset, &attr_val,
+	       param_attr->size);
+
+	ret = hr_dev->hw->config_scc_param(hr_dev, algo_type);
+	if (ret) {
+		memcpy((void *)scc_param->param + param_attr->offset, &old_val,
+		       param_attr->size);
+		return ret;
+	}
+
+	return count;
+}
+
+static void get_default_scc_param(struct hns_roce_dev *hr_dev)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < HNS_ROCE_SCC_ALGO_TOTAL; i++) {
+		ret = hr_dev->hw->query_scc_param(hr_dev, i);
+		if (ret && ret != -EOPNOTSUPP)
+			ibdev_warn_ratelimited(&hr_dev->ib_dev,
+					       "failed to get default parameters of scc algo %d, ret = %d.\n",
+					       i, ret);
+	}
+}
+
+static int hns_roce_alloc_scc_param(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_scc_param *scc_param;
+	int i;
+
+	scc_param = kvcalloc(HNS_ROCE_SCC_ALGO_TOTAL, sizeof(*scc_param),
+			     GFP_KERNEL);
+	if (!scc_param)
+		return -ENOMEM;
+
+	for (i = 0; i < HNS_ROCE_SCC_ALGO_TOTAL; i++) {
+		scc_param[i].algo_type = i;
+		scc_param[i].hr_dev = hr_dev;
+		mutex_init(&scc_param[i].scc_mutex);
+	}
+
+	hr_dev->scc_param = scc_param;
+
+	get_default_scc_param(hr_dev);
+
+	return 0;
+}
+
+static void hns_roce_dealloc_scc_param(struct hns_roce_dev *hr_dev)
+{
+	int i;
+
+	if (!hr_dev->scc_param)
+		return;
+
+	for (i = 0; i < HNS_ROCE_SCC_ALGO_TOTAL; i++)
+		mutex_destroy(&hr_dev->scc_param[i].scc_mutex);
+
+	kvfree(hr_dev->scc_param);
+}
+
+static void create_cc_param_debugfs(struct hns_roce_dev *hr_dev,
+				    struct dentry *parent)
+{
+	const struct hns_roce_cong_attr *cong_attr;
+	struct hns_cc_param_debugfs *dbgfs;
+	int i, j;
+	int ret;
+
+	if (hr_dev->pci_dev->revision <= PCI_REVISION_ID_HIP08 ||
+	    !(hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL) ||
+	    hr_dev->is_vf)
+		return;
+
+	ret = hns_roce_alloc_scc_param(hr_dev);
+	if (ret) {
+		dev_err(hr_dev->dev, "alloc scc param failed, ret = %d!\n",
+			ret);
+		return;
+	}
+
+	for (i = 0; i < CONG_TYPE_MAX_NUM; i++) {
+		cong_attr = &cong_attrs[i];
+		if (!test_bit(cong_attr->cong_type,
+			      (unsigned long *)&hr_dev->caps.cong_cap))
+			continue;
+
+		dbgfs = &hr_dev->dbgfs.cc_param_root[i];
+		dbgfs->root = debugfs_create_dir(cong_attr->name, parent);
+		for (j = 0; j < HNS_ROCE_CC_PARAM_MAX_NUM; j++) {
+			if (!cong_attr->params[j].name)
+				break;
+			dbgfs->params[j].param_attr = &cong_attr->params[j];
+			dbgfs->params[j].index = j;
+			dbgfs->params[j].seqfile.read = cc_param_debugfs_show;
+			dbgfs->params[j].seqfile.write = cc_param_debugfs_store;
+			dbgfs->params[j].seqfile.data = &dbgfs->params[j];
+			debugfs_create_file(cong_attr->params[j].name, 0600,
+					    dbgfs->root,
+					    &dbgfs->params[j].seqfile,
+					    &hns_debugfs_seqfile_fops);
+		}
+	}
+}
+
 /* debugfs for device */
 void hns_roce_register_debugfs(struct hns_roce_dev *hr_dev)
 {
@@ -102,11 +351,13 @@ void hns_roce_register_debugfs(struct hns_roce_dev *hr_dev)
 					 hns_roce_dbgfs_root);
 
 	create_sw_stat_debugfs(hr_dev, dbgfs->root);
+	create_cc_param_debugfs(hr_dev, dbgfs->root);
 }
 
 void hns_roce_unregister_debugfs(struct hns_roce_dev *hr_dev)
 {
 	debugfs_remove_recursive(hr_dev->dbgfs.root);
+	hns_roce_dealloc_scc_param(hr_dev);
 }
 
 /* debugfs for hns module */
diff --git a/drivers/infiniband/hw/hns/hns_roce_debugfs.h b/drivers/infiniband/hw/hns/hns_roce_debugfs.h
index 4e77dea0fbf6..116b1e8b6677 100644
--- a/drivers/infiniband/hw/hns/hns_roce_debugfs.h
+++ b/drivers/infiniband/hw/hns/hns_roce_debugfs.h
@@ -18,10 +18,35 @@ struct hns_sw_stat_debugfs {
 	struct hns_debugfs_seqfile sw_stat;
 };
 
+struct hns_roce_cc_param_attr {
+	const char *name;
+	int algo_type;
+	u32 offset;
+	u32 size;
+	u32 max;
+	u32 min;
+};
+
+struct hns_cc_param_seqfile {
+	struct hns_debugfs_seqfile seqfile;
+	const struct hns_roce_cc_param_attr *param_attr;
+	int index;
+};
+
+#define HNS_ROCE_CC_PARAM_MAX_NUM 11
+
+struct hns_cc_param_debugfs {
+	struct dentry *root;
+	struct hns_cc_param_seqfile params[HNS_ROCE_CC_PARAM_MAX_NUM];
+};
+
+#define CONG_TYPE_MAX_NUM 4
+
 /* Debugfs for device */
 struct hns_roce_dev_debugfs {
 	struct dentry *root;
 	struct hns_sw_stat_debugfs sw_stat_root;
+	struct hns_cc_param_debugfs cc_param_root[CONG_TYPE_MAX_NUM];
 };
 
 struct hns_roce_dev;
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 3f032b8038af..eb7b1865e4c7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -726,6 +726,14 @@ struct hns_roce_eq_table {
 	struct hns_roce_eq	*eq;
 };
 
+enum hns_roce_scc_algo {
+	HNS_ROCE_SCC_ALGO_DCQCN = 0,
+	HNS_ROCE_SCC_ALGO_LDCP,
+	HNS_ROCE_SCC_ALGO_HC3,
+	HNS_ROCE_SCC_ALGO_DIP,
+	HNS_ROCE_SCC_ALGO_TOTAL,
+};
+
 struct hns_roce_caps {
 	u64		fw_ver;
 	u8		num_ports;
@@ -963,6 +971,18 @@ struct hns_roce_hw {
 			u8 *tc_mode, u8 *priority);
 	const struct ib_device_ops *hns_roce_dev_ops;
 	const struct ib_device_ops *hns_roce_dev_srq_ops;
+	int (*config_scc_param)(struct hns_roce_dev *hr_dev,
+				enum hns_roce_scc_algo algo);
+	int (*query_scc_param)(struct hns_roce_dev *hr_dev,
+			       enum hns_roce_scc_algo alog);
+};
+
+#define HNS_ROCE_SCC_PARAM_SIZE 4
+struct hns_roce_scc_param {
+	__le32 param[HNS_ROCE_SCC_PARAM_SIZE];
+	enum hns_roce_scc_algo algo_type;
+	struct hns_roce_dev *hr_dev;
+	struct mutex scc_mutex; /* protect @param */
 };
 
 struct hns_roce_dev {
@@ -1026,6 +1046,7 @@ struct hns_roce_dev {
 	u64 dwqe_page;
 	struct hns_roce_dev_debugfs dbgfs;
 	atomic64_t *dfx_cnt;
+	struct hns_roce_scc_param *scc_param;
 };
 
 enum hns_roce_trace_type {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 5d0a8662249d..db86e157d6c4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -31,6 +31,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/cleanup.h>
 #include <linux/etherdevice.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
@@ -7196,6 +7197,57 @@ static void hns_roce_v2_cleanup_eq_table(struct hns_roce_dev *hr_dev)
 	kfree(eq_table->eq);
 }
 
+static const enum hns_roce_opcode_type scc_opcode[] = {
+	HNS_ROCE_OPC_CFG_DCQCN_PARAM,
+	HNS_ROCE_OPC_CFG_LDCP_PARAM,
+	HNS_ROCE_OPC_CFG_HC3_PARAM,
+	HNS_ROCE_OPC_CFG_DIP_PARAM,
+};
+
+static int hns_roce_v2_config_scc_param(struct hns_roce_dev *hr_dev,
+					enum hns_roce_scc_algo algo)
+{
+	struct hns_roce_scc_param *scc_param = &hr_dev->scc_param[algo];
+	struct hns_roce_cmq_desc desc;
+	int ret;
+
+	lockdep_assert_held(&scc_param->scc_mutex);
+
+	hns_roce_cmq_setup_basic_desc(&desc, scc_opcode[algo], false);
+	memcpy(&desc.data, scc_param->param, sizeof(scc_param->param));
+
+	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
+	if (ret)
+		ibdev_err_ratelimited(&hr_dev->ib_dev,
+				      "failed to configure scc param, opcode: 0x%x, ret = %d.\n",
+				      le16_to_cpu(desc.opcode), ret);
+
+	return ret;
+}
+
+static int hns_roce_v2_query_scc_param(struct hns_roce_dev *hr_dev,
+				       enum hns_roce_scc_algo algo)
+{
+	struct hns_roce_scc_param *scc_param;
+	struct hns_roce_cmq_desc desc;
+	int ret;
+
+	hns_roce_cmq_setup_basic_desc(&desc, scc_opcode[algo], true);
+	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
+	if (ret) {
+		ibdev_err_ratelimited(&hr_dev->ib_dev,
+				      "failed to query scc param, opcode: 0x%x, ret = %d.\n",
+				      le16_to_cpu(desc.opcode), ret);
+		return ret;
+	}
+
+	scc_param = &hr_dev->scc_param[algo];
+	scoped_guard(mutex, &scc_param->scc_mutex)
+		memcpy(scc_param->param, &desc.data, sizeof(scc_param->param));
+
+	return 0;
+}
+
 static const struct ib_device_ops hns_roce_v2_dev_ops = {
 	.destroy_qp = hns_roce_v2_destroy_qp,
 	.modify_cq = hns_roce_v2_modify_cq,
@@ -7246,6 +7298,8 @@ static const struct hns_roce_hw hns_roce_hw_v2 = {
 	.get_dscp = hns_roce_hw_v2_get_dscp,
 	.hns_roce_dev_ops = &hns_roce_v2_dev_ops,
 	.hns_roce_dev_srq_ops = &hns_roce_v2_dev_srq_ops,
+	.config_scc_param = hns_roce_v2_config_scc_param,
+	.query_scc_param = hns_roce_v2_query_scc_param,
 };
 
 static const struct pci_device_id hns_roce_hw_v2_pci_tbl[] = {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 285fe0875fac..8c7856aa24dc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -202,6 +202,10 @@ enum {
 /* CMQ command */
 enum hns_roce_opcode_type {
 	HNS_QUERY_FW_VER				= 0x0001,
+	HNS_ROCE_OPC_CFG_DCQCN_PARAM			= 0x1A80,
+	HNS_ROCE_OPC_CFG_LDCP_PARAM			= 0x1A81,
+	HNS_ROCE_OPC_CFG_HC3_PARAM			= 0x1A82,
+	HNS_ROCE_OPC_CFG_DIP_PARAM			= 0x1A83,
 	HNS_ROCE_OPC_QUERY_HW_VER			= 0x8000,
 	HNS_ROCE_OPC_CFG_GLOBAL_PARAM			= 0x8001,
 	HNS_ROCE_OPC_ALLOC_PF_RES			= 0x8004,
@@ -1459,6 +1463,127 @@ struct hns_roce_wqe_atomic_seg {
 	__le64          cmp_data;
 };
 
+#define HNS_ROCE_DCQCN_AI_OFS 0
+#define HNS_ROCE_DCQCN_AI_SZ sizeof(u16)
+#define HNS_ROCE_DCQCN_AI_MAX ((u16)(~0U))
+#define HNS_ROCE_DCQCN_F_OFS (HNS_ROCE_DCQCN_AI_OFS + HNS_ROCE_DCQCN_AI_SZ)
+#define HNS_ROCE_DCQCN_F_SZ sizeof(u8)
+#define HNS_ROCE_DCQCN_F_MAX ((u8)(~0U))
+#define HNS_ROCE_DCQCN_TKP_OFS (HNS_ROCE_DCQCN_F_OFS + HNS_ROCE_DCQCN_F_SZ)
+#define HNS_ROCE_DCQCN_TKP_SZ sizeof(u8)
+#define HNS_ROCE_DCQCN_TKP_MAX 10
+#define HNS_ROCE_DCQCN_TMP_OFS (HNS_ROCE_DCQCN_TKP_OFS + HNS_ROCE_DCQCN_TKP_SZ)
+#define HNS_ROCE_DCQCN_TMP_SZ sizeof(u16)
+#define HNS_ROCE_DCQCN_TMP_MAX 15
+#define HNS_ROCE_DCQCN_ALP_OFS (HNS_ROCE_DCQCN_TMP_OFS + HNS_ROCE_DCQCN_TMP_SZ)
+#define HNS_ROCE_DCQCN_ALP_SZ sizeof(u16)
+#define HNS_ROCE_DCQCN_ALP_MAX ((u16)(~0U))
+#define HNS_ROCE_DCQCN_MAX_SPEED_OFS (HNS_ROCE_DCQCN_ALP_OFS + \
+					HNS_ROCE_DCQCN_ALP_SZ)
+#define HNS_ROCE_DCQCN_MAX_SPEED_SZ sizeof(u32)
+#define HNS_ROCE_DCQCN_MAX_SPEED_MAX ((u32)(~0U))
+#define HNS_ROCE_DCQCN_G_OFS (HNS_ROCE_DCQCN_MAX_SPEED_OFS + \
+					HNS_ROCE_DCQCN_MAX_SPEED_SZ)
+#define HNS_ROCE_DCQCN_G_SZ sizeof(u8)
+#define HNS_ROCE_DCQCN_G_MAX 15
+#define HNS_ROCE_DCQCN_AL_OFS (HNS_ROCE_DCQCN_G_OFS + HNS_ROCE_DCQCN_G_SZ)
+#define HNS_ROCE_DCQCN_AL_SZ sizeof(u8)
+#define HNS_ROCE_DCQCN_AL_MAX ((u8)(~0U))
+#define HNS_ROCE_DCQCN_CNP_TIME_OFS (HNS_ROCE_DCQCN_AL_OFS + \
+					HNS_ROCE_DCQCN_AL_SZ)
+#define HNS_ROCE_DCQCN_CNP_TIME_SZ sizeof(u8)
+#define HNS_ROCE_DCQCN_CNP_TIME_MAX ((u8)(~0U))
+#define HNS_ROCE_DCQCN_ASHIFT_OFS (HNS_ROCE_DCQCN_CNP_TIME_OFS + \
+					HNS_ROCE_DCQCN_CNP_TIME_SZ)
+#define HNS_ROCE_DCQCN_ASHIFT_SZ sizeof(u8)
+#define HNS_ROCE_DCQCN_ASHIFT_MAX 15
+
+#define HNS_ROCE_LDCP_CWD0_OFS 0
+#define HNS_ROCE_LDCP_CWD0_SZ sizeof(u32)
+#define HNS_ROCE_LDCP_CWD0_MAX ((u32)(~0U))
+#define HNS_ROCE_LDCP_ALPHA_OFS (HNS_ROCE_LDCP_CWD0_OFS + HNS_ROCE_LDCP_CWD0_SZ)
+#define HNS_ROCE_LDCP_ALPHA_SZ sizeof(u8)
+#define HNS_ROCE_LDCP_ALPHA_MAX ((u8)(~0U))
+#define HNS_ROCE_LDCP_GAMMA_OFS (HNS_ROCE_LDCP_ALPHA_OFS + \
+					HNS_ROCE_LDCP_ALPHA_SZ)
+#define HNS_ROCE_LDCP_GAMMA_SZ sizeof(u8)
+#define HNS_ROCE_LDCP_GAMMA_MAX 7
+#define HNS_ROCE_LDCP_BETA_OFS (HNS_ROCE_LDCP_GAMMA_OFS + \
+					HNS_ROCE_LDCP_GAMMA_SZ)
+#define HNS_ROCE_LDCP_BETA_SZ sizeof(u8)
+#define HNS_ROCE_LDCP_BETA_MAX 7
+#define HNS_ROCE_LDCP_ETA_OFS (HNS_ROCE_LDCP_BETA_OFS + HNS_ROCE_LDCP_BETA_SZ)
+#define HNS_ROCE_LDCP_ETA_SZ sizeof(u8)
+#define HNS_ROCE_LDCP_ETA_MAX 7
+
+#define HNS_ROCE_HC3_INITIAL_WINDOW_OFS 0
+#define HNS_ROCE_HC3_INITIAL_WINDOW_SZ sizeof(u32)
+#define HNS_ROCE_HC3_INITIAL_WINDOW_MIN 0
+#define HNS_ROCE_HC3_INITIAL_WINDOW_MAX ((u32)(~0U))
+#define HNS_ROCE_HC3_BANDWIDTH_OFS (HNS_ROCE_HC3_INITIAL_WINDOW_OFS + \
+					HNS_ROCE_HC3_INITIAL_WINDOW_SZ)
+#define HNS_ROCE_HC3_BANDWIDTH_SZ sizeof(u32)
+#define HNS_ROCE_HC3_BANDWIDTH_MIN 1000
+#define HNS_ROCE_HC3_BANDWIDTH_MAX ((u32)(~0U))
+#define HNS_ROCE_HC3_QLEN_SHIFT_OFS (HNS_ROCE_HC3_BANDWIDTH_OFS + \
+					HNS_ROCE_HC3_BANDWIDTH_SZ)
+#define HNS_ROCE_HC3_QLEN_SHIFT_SZ sizeof(u8)
+#define HNS_ROCE_HC3_QLEN_SHIFT_MIN 0
+#define HNS_ROCE_HC3_QLEN_SHIFT_MAX 31
+#define HNS_ROCE_HC3_PORT_USAGE_SHIFT_OFS (HNS_ROCE_HC3_QLEN_SHIFT_OFS + \
+						HNS_ROCE_HC3_QLEN_SHIFT_SZ)
+#define HNS_ROCE_HC3_PORT_USAGE_SHIFT_SZ sizeof(u8)
+#define HNS_ROCE_HC3_PORT_USAGE_SHIFT_MIN 0
+#define HNS_ROCE_HC3_PORT_USAGE_SHIFT_MAX 100
+#define HNS_ROCE_HC3_OVER_PERIOD_OFS (HNS_ROCE_HC3_PORT_USAGE_SHIFT_OFS + \
+					HNS_ROCE_HC3_PORT_USAGE_SHIFT_SZ)
+#define HNS_ROCE_HC3_OVER_PERIOD_SZ sizeof(u8)
+#define HNS_ROCE_HC3_OVER_PERIOD_MIN 0
+#define HNS_ROCE_HC3_OVER_PERIOD_MAX ((u8)(~0U))
+#define HNS_ROCE_HC3_MAX_STAGE_OFS (HNS_ROCE_HC3_OVER_PERIOD_OFS + \
+					HNS_ROCE_HC3_OVER_PERIOD_SZ)
+#define HNS_ROCE_HC3_MAX_STAGE_SZ sizeof(u8)
+#define HNS_ROCE_HC3_MAX_STAGE_MIN 0
+#define HNS_ROCE_HC3_MAX_STAGE_MAX ((u8)(~0U))
+#define HNS_ROCE_HC3_GAMMA_SHIFT_OFS (HNS_ROCE_HC3_MAX_STAGE_OFS + \
+					HNS_ROCE_HC3_MAX_STAGE_SZ)
+#define HNS_ROCE_HC3_GAMMA_SHIFT_SZ sizeof(u8)
+#define HNS_ROCE_HC3_GAMMA_SHIFT_MIN 0
+#define HNS_ROCE_HC3_GAMMA_SHIFT_MAX 15
+
+#define HNS_ROCE_DIP_AI_OFS 0
+#define HNS_ROCE_DIP_AI_SZ sizeof(u16)
+#define HNS_ROCE_DIP_AI_MAX ((u16)(~0U))
+#define HNS_ROCE_DIP_F_OFS (HNS_ROCE_DIP_AI_OFS + HNS_ROCE_DIP_AI_SZ)
+#define HNS_ROCE_DIP_F_SZ sizeof(u8)
+#define HNS_ROCE_DIP_F_MAX ((u8)(~0U))
+#define HNS_ROCE_DIP_TKP_OFS (HNS_ROCE_DIP_F_OFS + HNS_ROCE_DIP_F_SZ)
+#define HNS_ROCE_DIP_TKP_SZ sizeof(u8)
+#define HNS_ROCE_DIP_TKP_MAX 10
+#define HNS_ROCE_DIP_TMP_OFS (HNS_ROCE_DIP_TKP_OFS + HNS_ROCE_DIP_TKP_SZ)
+#define HNS_ROCE_DIP_TMP_SZ sizeof(u16)
+#define HNS_ROCE_DIP_TMP_MAX 15
+#define HNS_ROCE_DIP_ALP_OFS (HNS_ROCE_DIP_TMP_OFS + HNS_ROCE_DIP_TMP_SZ)
+#define HNS_ROCE_DIP_ALP_SZ sizeof(u16)
+#define HNS_ROCE_DIP_ALP_MAX ((u16)(~0U))
+#define HNS_ROCE_DIP_MAX_SPEED_OFS (HNS_ROCE_DIP_ALP_OFS + HNS_ROCE_DIP_ALP_SZ)
+#define HNS_ROCE_DIP_MAX_SPEED_SZ sizeof(u32)
+#define HNS_ROCE_DIP_MAX_SPEED_MAX ((u32)(~0U))
+#define HNS_ROCE_DIP_G_OFS (HNS_ROCE_DIP_MAX_SPEED_OFS + \
+				HNS_ROCE_DIP_MAX_SPEED_SZ)
+#define HNS_ROCE_DIP_G_SZ sizeof(u8)
+#define HNS_ROCE_DIP_G_MAX 15
+#define HNS_ROCE_DIP_AL_OFS (HNS_ROCE_DIP_G_OFS + HNS_ROCE_DIP_G_SZ)
+#define HNS_ROCE_DIP_AL_SZ sizeof(u8)
+#define HNS_ROCE_DIP_AL_MAX ((u8)(~0U))
+#define HNS_ROCE_DIP_CNP_TIME_OFS (HNS_ROCE_DIP_AL_OFS + HNS_ROCE_DIP_AL_SZ)
+#define HNS_ROCE_DIP_CNP_TIME_SZ sizeof(u8)
+#define HNS_ROCE_DIP_CNP_TIME_MAX ((u8)(~0U))
+#define HNS_ROCE_DIP_ASHIFT_OFS (HNS_ROCE_DIP_CNP_TIME_OFS + \
+					HNS_ROCE_DIP_CNP_TIME_SZ)
+#define HNS_ROCE_DIP_ASHIFT_SZ sizeof(u8)
+#define HNS_ROCE_DIP_ASHIFT_MAX 15
+
 struct hns_roce_sccc_clr {
 	__le32 qpn;
 	__le32 rsv[5];
-- 
2.33.0


