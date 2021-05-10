Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1989E377786
	for <lists+linux-rdma@lfdr.de>; Sun,  9 May 2021 18:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhEIQTC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 May 2021 12:19:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:35118 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhEIQTC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 9 May 2021 12:19:02 -0400
IronPort-SDR: QsQnqgM7nuJ1LeB9hOR53nc6dZXYwF42i5Q+/jKEkC8zWYdZkY2Ueg+svHlWIJIPgMB59YIaaU
 BEN8bhybhy+A==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="195949260"
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; 
   d="scan'208";a="195949260"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2021 09:17:57 -0700
IronPort-SDR: DFl36rkrpY+ElyzMCOxQC2hEU2axuJqXmgPxFCaLwLU2IBHqvkj/2lnaY979gKot5gvLCOE59l
 Jn5Src715mHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; 
   d="scan'208";a="435776018"
Received: from unknown (HELO intel-86.bj.intel.com) ([10.238.154.86])
  by orsmga008.jf.intel.com with ESMTP; 09 May 2021 09:17:55 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     zyjzyj2000@gmail.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
Subject: [PATCH 1/1] RDMA/rxe: remove the unnecessary break
Date:   Mon, 10 May 2021 04:42:35 -0400
Message-Id: <20210510084235.223628-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <zyjzyj2000@gmail.com>

In the final default, the break is not necessary.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 34ae957a315c..00588735744f 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -186,7 +186,6 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	default:
 		qp->ibqp.qp_num		= qpn;
-		break;
 	}
 
 	INIT_LIST_HEAD(&qp->grp_list);
-- 
2.27.0

