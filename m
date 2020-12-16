Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAF42DBC2A
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Dec 2020 08:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725287AbgLPHjz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Dec 2020 02:39:55 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:42742 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725710AbgLPHjy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Dec 2020 02:39:54 -0500
X-IronPort-AV: E=Sophos;i="5.78,423,1599494400"; 
   d="scan'208";a="102452513"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Dec 2020 15:38:48 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 162DE4CE600B;
        Wed, 16 Dec 2020 15:38:45 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 16 Dec 2020 15:38:44 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.31) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Wed, 16 Dec 2020 15:38:44 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <leon@kernel.org>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH 2/2] RDMA/rxe: Add check for supported QP types
Date:   Wed, 16 Dec 2020 15:17:55 +0800
Message-ID: <20201216071755.149449-2-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201216071755.149449-1-yangx.jy@cn.fujitsu.com>
References: <20201216071755.149449-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 162DE4CE600B.AC2EC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

1) Current rdma_rxe only supports five QP types which always sets recv_cq.
2) INI QP doesn't set recv_cq(NULL) so creating INI QP over softroce
   triggers 'missing cq' warning.

Avoid the warning by checking supported QP type.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 656a5b4be847..65c8df812aeb 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -62,6 +62,17 @@ int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init)
 	struct rxe_port *port;
 	int port_num = init->port_num;
 
+	switch(init->qp_type) {
+	case IB_QPT_SMI:
+	case IB_QPT_GSI:
+	case IB_QPT_RC:
+	case IB_QPT_UC:
+	case IB_QPT_UD:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
 	if (!init->recv_cq || !init->send_cq) {
 		pr_warn("missing cq\n");
 		goto err1;
-- 
2.25.1



