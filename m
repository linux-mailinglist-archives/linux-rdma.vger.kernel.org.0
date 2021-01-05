Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9832EA914
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jan 2021 11:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbhAEKou (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jan 2021 05:44:50 -0500
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:58611 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbhAEKot (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jan 2021 05:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1609843488; x=1641379488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G/jeKD5ZhxL0iwCYgl+luUnKJ4C8novY2hUT7oDQmoM=;
  b=CLE4GWQEGCYXdOI+oeVlSRpIfEwXHv8hcQ67iMtkOPOl+fqGLetI5BOV
   ynH96zvjU1q5Spi8ERMrjgPzXfV2Z/iZrtlC0BdM52JTdw4noToPNtiS1
   ps9llG1yBEARmiTxfZnWMjjWpd7GM8Nga01Rbz7wkRkLfMtdGDwDAWqfU
   A=;
X-IronPort-AV: E=Sophos;i="5.78,476,1599523200"; 
   d="scan'208";a="908238428"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9103.sea19.amazon.com with ESMTP; 05 Jan 2021 10:44:01 +0000
Received: from EX13D13EUA004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id E4F43A1CDF;
        Tue,  5 Jan 2021 10:44:00 +0000 (UTC)
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13EUA004.ant.amazon.com (10.43.165.22) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 5 Jan 2021 10:43:59 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.212.6) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 5 Jan 2021 10:43:55 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Leonid Feschuk <lfesch@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH for-next 2/2] RDMA/efa: Report userspace version in host info
Date:   Tue, 5 Jan 2021 12:43:26 +0200
Message-ID: <20210105104326.67895-3-galpress@amazon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105104326.67895-1-galpress@amazon.com>
References: <20210105104326.67895-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Report the userspace version in the host information set feature admin
command.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Leonid Feschuk <lfesch@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa.h                 | 2 +-
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 3 +++
 drivers/infiniband/hw/efa/efa_main.c            | 4 +++-
 drivers/infiniband/hw/efa/efa_verbs.c           | 2 +-
 include/uapi/rdma/efa-abi.h                     | 3 ++-
 5 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 9c9cd5867489..e554b53997c4 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -123,7 +123,7 @@ struct efa_ah {
 	u8 id[EFA_GID_SIZE];
 };
 
-void efa_set_host_info(struct efa_dev *dev);
+void efa_set_host_info(struct efa_dev *dev, u8 *userspace_ver);
 int efa_query_device(struct ib_device *ibdev,
 		     struct ib_device_attr *props,
 		     struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index b199e4ac6cf9..0822a5d5dcb6 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -884,6 +884,9 @@ struct efa_admin_host_info {
 	 * 31:2 : reserved2
 	 */
 	u32 flags;
+
+	/* Userspace version */
+	u8 userspace_ver[32];
 };
 
 /* create_qp_cmd */
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 90a033a6af6c..027f9d0ebf25 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -191,7 +191,7 @@ static void efa_stats_init(struct efa_dev *dev)
 		atomic64_set(s, 0);
 }
 
-void efa_set_host_info(struct efa_dev *dev)
+void efa_set_host_info(struct efa_dev *dev, u8 *userspace_ver)
 {
 	struct efa_admin_set_feature_resp resp = {};
 	struct efa_admin_set_feature_cmd cmd = {};
@@ -230,6 +230,8 @@ void efa_set_host_info(struct efa_dev *dev)
 		EFA_COMMON_SPEC_VERSION_MINOR);
 	EFA_SET(&hinf->flags, EFA_ADMIN_HOST_INFO_INTREE, 1);
 	EFA_SET(&hinf->flags, EFA_ADMIN_HOST_INFO_GDR, 0);
+	strlcpy(hinf->userspace_ver, userspace_ver,
+		sizeof(hinf->userspace_ver));
 
 	efa_com_set_feature_ex(&dev->edev, &resp, &cmd, EFA_ADMIN_HOST_INFO,
 			       hinf_dma, bufsz);
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 5c12bdc28ef0..d3e3787a9e1e 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1696,7 +1696,7 @@ int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata)
 	}
 
 	if (!test_and_set_bit(EFA_FLAGS_HOST_INFO_SET_BIT, dev->flags))
-		efa_set_host_info(dev);
+		efa_set_host_info(dev, cmd.userspace_ver);
 
 	err = efa_user_comp_handshake(ibucontext, &cmd);
 	if (err)
diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
index f89fbb5b1e8d..28a8e3f982a0 100644
--- a/include/uapi/rdma/efa-abi.h
+++ b/include/uapi/rdma/efa-abi.h
@@ -27,7 +27,8 @@ enum {
 
 struct efa_ibv_alloc_ucontext_cmd {
 	__u32 comp_mask;
-	__u8 reserved_20[4];
+	__u8 userspace_ver[32];
+	__u8 reserved_120[4];
 };
 
 enum efa_ibv_user_cmds_supp_udata {
-- 
2.30.0

