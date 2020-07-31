Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C44233EE1
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jul 2020 08:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbgGaGEy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jul 2020 02:04:54 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:16455 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbgGaGEx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 Jul 2020 02:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1596175492; x=1627711492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vt0zI3fDDtd1ANIDRXK+ewCfOdFiB8BMJhAdYSvV/zU=;
  b=WvDL0pzLjWcTtYT5f00n0Eefhuskj+Y/T/znNuXFd0rxowHoNl4Jluqe
   i13HCZAkxRYKQ3OcY1b7SsVt2EuQUET/X6U8Y628CGNa5e8/Yop8FUwrG
   tjxFsv7gk+anlYroFMEFRR0n6NXtaWvmQTbu3DdjN72Viyx13f6h/klNv
   4=;
IronPort-SDR: EjVjJ5kvrtpM6gCreWWpxS66yhTQ4bWtLodPjBkEI6+e0N6DFtQPyHqNdn2Cq4+dcX7fiuzuPi
 n/DvS4FsplQw==
X-IronPort-AV: E=Sophos;i="5.75,417,1589241600"; 
   d="scan'208";a="46638257"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 31 Jul 2020 06:04:52 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (Postfix) with ESMTPS id 8635BA25E7;
        Fri, 31 Jul 2020 06:04:51 +0000 (UTC)
Received: from EX13D13EUB002.ant.amazon.com (10.43.166.205) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 31 Jul 2020 06:04:50 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D13EUB002.ant.amazon.com (10.43.166.205) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 31 Jul 2020 06:04:49 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.212.6) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 31 Jul 2020 06:04:47 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        "Yossi Leybovich" <sleybo@amazon.com>
Subject: [PATCH for-next 3/4] RDMA/efa: Introduce SRD QP state machine
Date:   Fri, 31 Jul 2020 09:04:19 +0300
Message-ID: <20200731060420.17053-4-galpress@amazon.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200731060420.17053-1-galpress@amazon.com>
References: <20200731060420.17053-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This precursory patch adds the SRD QP type state machine, which is
currently identical to the one of UD QP type.  A following patch is
going to change the SRD QP state machine to support RNR retry
modifications.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 119 +++++++++++++++++++++++++-
 1 file changed, 117 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index c66bfe1b386a..6c524cea3e9c 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -739,11 +739,120 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
 	return ERR_PTR(err);
 }
 
+static const struct {
+	int			valid;
+	enum ib_qp_attr_mask	req_param;
+	enum ib_qp_attr_mask	opt_param;
+} srd_qp_state_table[IB_QPS_ERR + 1][IB_QPS_ERR + 1] = {
+	[IB_QPS_RESET] = {
+		[IB_QPS_RESET] = { .valid = 1 },
+		[IB_QPS_INIT]  = {
+			.valid = 1,
+			.req_param = IB_QP_PKEY_INDEX |
+				     IB_QP_PORT |
+				     IB_QP_QKEY,
+		},
+	},
+	[IB_QPS_INIT] = {
+		[IB_QPS_RESET] = { .valid = 1 },
+		[IB_QPS_ERR]   = { .valid = 1 },
+		[IB_QPS_INIT]  = {
+			.valid = 1,
+			.opt_param = IB_QP_PKEY_INDEX |
+				     IB_QP_PORT |
+				     IB_QP_QKEY,
+		},
+		[IB_QPS_RTR]   = {
+			.valid = 1,
+			.opt_param = IB_QP_PKEY_INDEX |
+				     IB_QP_QKEY,
+		},
+	},
+	[IB_QPS_RTR] = {
+		[IB_QPS_RESET] = { .valid = 1 },
+		[IB_QPS_ERR]   = { .valid = 1 },
+		[IB_QPS_RTS]   = {
+			.valid = 1,
+			.req_param = IB_QP_SQ_PSN,
+			.opt_param = IB_QP_CUR_STATE |
+				     IB_QP_QKEY,
+		}
+	},
+	[IB_QPS_RTS] = {
+		[IB_QPS_RESET] = { .valid = 1 },
+		[IB_QPS_ERR]   = { .valid = 1 },
+		[IB_QPS_RTS]   = {
+			.valid = 1,
+			.opt_param = IB_QP_CUR_STATE |
+				     IB_QP_QKEY,
+		},
+		[IB_QPS_SQD] = {
+			.valid = 1,
+			.opt_param = IB_QP_EN_SQD_ASYNC_NOTIFY,
+		},
+	},
+	[IB_QPS_SQD] = {
+		[IB_QPS_RESET] = { .valid = 1 },
+		[IB_QPS_ERR]   = { .valid = 1 },
+		[IB_QPS_RTS]   = {
+			.valid = 1,
+			.opt_param = IB_QP_CUR_STATE |
+				     IB_QP_QKEY,
+		},
+		[IB_QPS_SQD] = {
+			.valid = 1,
+			.opt_param = IB_QP_PKEY_INDEX |
+				     IB_QP_QKEY,
+		}
+	},
+	[IB_QPS_SQE] = {
+		[IB_QPS_RESET] = { .valid = 1 },
+		[IB_QPS_ERR]   = { .valid = 1 },
+		[IB_QPS_RTS]   = {
+			.valid = 1,
+			.opt_param = IB_QP_CUR_STATE |
+				     IB_QP_QKEY,
+		}
+	},
+	[IB_QPS_ERR] = {
+		[IB_QPS_RESET] = { .valid = 1 },
+		[IB_QPS_ERR]   = { .valid = 1 },
+	}
+};
+
+static bool efa_modify_srd_qp_is_ok(enum ib_qp_state cur_state,
+				    enum ib_qp_state next_state,
+				    enum ib_qp_attr_mask mask)
+{
+	enum ib_qp_attr_mask req_param, opt_param;
+
+	if (mask & IB_QP_CUR_STATE  &&
+	    cur_state != IB_QPS_RTR && cur_state != IB_QPS_RTS &&
+	    cur_state != IB_QPS_SQD && cur_state != IB_QPS_SQE)
+		return false;
+
+	if (!srd_qp_state_table[cur_state][next_state].valid)
+		return false;
+
+	req_param = srd_qp_state_table[cur_state][next_state].req_param;
+	opt_param = srd_qp_state_table[cur_state][next_state].opt_param;
+
+	if ((mask & req_param) != req_param)
+		return false;
+
+	if (mask & ~(req_param | opt_param | IB_QP_STATE))
+		return false;
+
+	return true;
+}
+
 static int efa_modify_qp_validate(struct efa_dev *dev, struct efa_qp *qp,
 				  struct ib_qp_attr *qp_attr, int qp_attr_mask,
 				  enum ib_qp_state cur_state,
 				  enum ib_qp_state new_state)
 {
+	int err;
+
 #define EFA_MODIFY_QP_SUPP_MASK \
 	(IB_QP_STATE | IB_QP_CUR_STATE | IB_QP_EN_SQD_ASYNC_NOTIFY | \
 	 IB_QP_PKEY_INDEX | IB_QP_PORT | IB_QP_QKEY | IB_QP_SQ_PSN)
@@ -755,8 +864,14 @@ static int efa_modify_qp_validate(struct efa_dev *dev, struct efa_qp *qp,
 		return -EOPNOTSUPP;
 	}
 
-	if (!ib_modify_qp_is_ok(cur_state, new_state, IB_QPT_UD,
-				qp_attr_mask)) {
+	if (qp->ibqp.qp_type == IB_QPT_DRIVER)
+		err = !efa_modify_srd_qp_is_ok(cur_state, new_state,
+					       qp_attr_mask);
+	else
+		err = !ib_modify_qp_is_ok(cur_state, new_state, IB_QPT_UD,
+					  qp_attr_mask);
+
+	if (err) {
 		ibdev_dbg(&dev->ibdev, "Invalid modify QP parameters\n");
 		return -EINVAL;
 	}
-- 
2.27.0

