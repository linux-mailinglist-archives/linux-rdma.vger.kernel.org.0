Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3A92DBC29
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Dec 2020 08:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgLPHjh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Dec 2020 02:39:37 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:42742 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725710AbgLPHjh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Dec 2020 02:39:37 -0500
X-IronPort-AV: E=Sophos;i="5.78,423,1599494400"; 
   d="scan'208";a="102452514"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Dec 2020 15:38:48 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 3BD2D4CE4BCB;
        Wed, 16 Dec 2020 15:38:44 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 16 Dec 2020 15:38:43 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.31) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Wed, 16 Dec 2020 15:38:43 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <leon@kernel.org>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH 1/2] RDMA/uverbs: Don't set rcq if qp_type is IB_QPT_XRC_INI
Date:   Wed, 16 Dec 2020 15:17:54 +0800
Message-ID: <20201216071755.149449-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 3BD2D4CE4BCB.AB984
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

INI QP doesn't require receive CQ.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 418d133a8fb0..d8bc8ea3ad1e 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1345,7 +1345,7 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 		if (has_sq)
 			scq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ,
 						cmd->send_cq_handle, attrs);
-		if (!ind_tbl)
+		if (!ind_tbl && cmd->qp_type != IB_QPT_XRC_INI)
 			rcq = rcq ?: scq;
 		pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd->pd_handle,
 				       attrs);
-- 
2.25.1



