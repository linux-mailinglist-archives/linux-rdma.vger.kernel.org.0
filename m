Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAB22A4477
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Nov 2020 12:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgKCLqL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Nov 2020 06:46:11 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7411 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgKCLqL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Nov 2020 06:46:11 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CQSfP1fFFz71yY;
        Tue,  3 Nov 2020 19:46:05 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 19:45:58 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <sagi@grimberg.me>, <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] IB/isert: Fix warning Comparison to bool
Date:   Tue, 3 Nov 2020 19:57:54 +0800
Message-ID: <1604404674-32998-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix below warning reported by coccicheck:

./ib_isert.c:1104:12-24: WARNING: Comparison to bool

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index bd47894..e47cd02 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -1101,7 +1101,7 @@ isert_handle_scsi_cmd(struct isert_conn *isert_conn,
 sequence_cmd:
 	rc = iscsit_sequence_cmd(conn, cmd, buf, hdr->cmdsn);
 
-	if (!rc && dump_payload == false && unsol_data)
+	if (!rc && !dump_payload && unsol_data)
 		iscsit_set_unsolicited_dataout(cmd);
 	else if (dump_payload && imm_data)
 		target_put_sess_cmd(&cmd->se_cmd);
-- 
2.6.2

