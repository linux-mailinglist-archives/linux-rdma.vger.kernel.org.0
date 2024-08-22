Return-Path: <linux-rdma+bounces-4495-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B04C95BCE2
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 19:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56EF91C24221
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 17:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9201CDFBC;
	Thu, 22 Aug 2024 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NnExsCq9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB891CDFAF
	for <linux-rdma@vger.kernel.org>; Thu, 22 Aug 2024 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346720; cv=none; b=HtMbzYYYSZdsMEmBSsK6CMJwuym4P9ZX1SWBTGhmlbx8Be/hpFlvTteOEA7K+pOBJpdVX3p+tUIBKnuyvuwG8oxWZPfaSA6gyzmEy20HnoPuhMx2ngq46TB6SmHsfGsq8D144KgAXmQtbYPESWaFE0wqQG65SoacGKPjsOggNfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346720; c=relaxed/simple;
	bh=/incFH1AHOEaZkEtxtOOXel+pe7ZK83WnJ5bjIh4EL8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Az+M78tGu3T53T8EuqdAOX484QvmJ5jM2lhGwCIZjVZs1j65Dl+mm/KLrM+dpyNj+iTfumqaAxtLff006OOu1LhmPit4ILFY1lw+TEcfNBnOJJHIDe0lf8/0Oe/Zvb4kCPvwTcmqZZahzKEdRnoyUi4UVVUhKKLbyl7e42sRU+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NnExsCq9; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724346716; x=1755882716;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xc+q0TsNzBaDjVFKR2jARscnkt7RtlhB9NLvHBIBmPM=;
  b=NnExsCq9CyLpZMEaQRvXlVTDDJN5JFRMt7Q/OgrfJTrsfKdmg6/5ROva
   fwasdPAzxmubimzICb+1klg2lvxdKVdwEGbCH+dKC8lduabrm14aqijJ8
   LJ3MCtdutfR5ihzgYwY4O//odiwXoZLIQWqEXeAg/meAqTsqYTfbEFzZo
   w=;
X-IronPort-AV: E=Sophos;i="6.10,167,1719878400"; 
   d="scan'208";a="446516664"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 17:11:47 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:17020]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.33.204:2525] with esmtp (Farcaster)
 id 873474f3-ec0a-4f14-97c8-905d57ea030b; Thu, 22 Aug 2024 17:11:46 +0000 (UTC)
X-Farcaster-Flow-ID: 873474f3-ec0a-4f14-97c8-905d57ea030b
Received: from EX19D045EUC003.ant.amazon.com (10.252.61.236) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 22 Aug 2024 17:11:45 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D045EUC003.ant.amazon.com (10.252.61.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 22 Aug 2024 17:11:44 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by mail-relay.amazon.com (10.252.135.200) with Microsoft
 SMTP Server id 15.2.1258.34 via Frontend Transport; Thu, 22 Aug 2024 17:11:43
 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Yehuda
 Yitschak" <yehuday@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH for-next] RDMA/efa: Add support for node guid
Date: Thu, 22 Aug 2024 17:11:43 +0000
Message-ID: <20240822171143.2800-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Yehuda Yitschak <yehuday@amazon.com>

Propagate the unique, per device, ID in the device attributes to the
standard node_guid value in IB device.

Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Yehuda Yitschak <yehuday@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 3 +++
 drivers/infiniband/hw/efa/efa_com_cmd.c         | 1 +
 drivers/infiniband/hw/efa/efa_com_cmd.h         | 1 +
 drivers/infiniband/hw/efa/efa_main.c            | 1 +
 4 files changed, 6 insertions(+)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index 4296662e59c3..cd03a5429beb 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -674,6 +674,9 @@ struct efa_admin_feature_device_attr_desc {
 
 	/* Max RDMA transfer size in bytes */
 	u32 max_rdma_size;
+
+	/* Unique global ID for an EFA device */
+	u64 guid;
 };
 
 struct efa_admin_feature_queue_attr_desc {
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index 5b9c2b16df0e..5a774925cdea 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -465,6 +465,7 @@ int efa_com_get_device_attr(struct efa_com_dev *edev,
 	result->db_bar = resp.u.device_attr.db_bar;
 	result->max_rdma_size = resp.u.device_attr.max_rdma_size;
 	result->device_caps = resp.u.device_attr.device_caps;
+	result->guid = resp.u.device_attr.guid;
 
 	if (result->admin_api_version < 1) {
 		ibdev_err_ratelimited(
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
index 9714105fcf7e..668d033f7477 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.h
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
@@ -112,6 +112,7 @@ struct efa_com_get_device_attr_result {
 	u8 addr[EFA_GID_SIZE];
 	u64 page_size_cap;
 	u64 max_mr_pages;
+	u64 guid;
 	u32 mtu;
 	u32 fw_version;
 	u32 admin_api_version;
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 1a777791bea3..ad225823e6f2 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -441,6 +441,7 @@ static int efa_ib_device_add(struct efa_dev *dev)
 	efa_set_host_info(dev);
 
 	dev->ibdev.node_type = RDMA_NODE_UNSPECIFIED;
+	dev->ibdev.node_guid = dev->dev_attr.guid;
 	dev->ibdev.phys_port_cnt = 1;
 	dev->ibdev.num_comp_vectors = dev->neqs ?: 1;
 	dev->ibdev.dev.parent = &pdev->dev;
-- 
2.40.1


