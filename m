Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67D8CDDD28
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Oct 2019 09:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfJTHQW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Oct 2019 03:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfJTHQW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 20 Oct 2019 03:16:22 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98A6621D80;
        Sun, 20 Oct 2019 07:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571555782;
        bh=743Cxu4KRTWlfMx3ZaqQs/0aksqtHskOO1X3RvILynE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wnPCMe0JU0AXcW+I/0cCFUClRMGbYC5iVi0EHzc+Wf6KjBE2Ourrjvx3A6YTPL6UT
         RqEf1X2ceZMHAr2YgRZITToChqSEC88ZvUSSs2MmtwTsrGNfCo81Ef6rd3uZ9rbzit
         v8EWicraDo0ZCVHY2nKmjV+wJw/V1ZWk30jDz3Zo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH rdma-next 6/6] RDMA/srpt: Use private_data_len instead of hardcoded value
Date:   Sun, 20 Oct 2019 10:15:59 +0300
Message-Id: <20191020071559.9743-7-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191020071559.9743-1-leon@kernel.org>
References: <20191020071559.9743-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Reuse recently introduced private_data_len to get IBTA REJ message
private data size.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index daf811abf40a..e66366de11e9 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2609,7 +2609,7 @@ static int srpt_cm_handler(struct ib_cm_id *cm_id,
 	case IB_CM_REJ_RECEIVED:
 		srpt_cm_rej_recv(ch, event->param.rej_rcvd.reason,
 				 event->private_data,
-				 IB_CM_REJ_PRIVATE_DATA_SIZE);
+				 event->private_data_len);
 		break;
 	case IB_CM_RTU_RECEIVED:
 	case IB_CM_USER_ESTABLISHED:
--
2.20.1

