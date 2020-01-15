Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5516413C2ED
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 14:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgAONb0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 08:31:26 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:57741 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726562AbgAONbW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jan 2020 08:31:22 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from sergeygo@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 15 Jan 2020 15:31:19 +0200
Received: from rsws38.mtr.labs.mlnx (rsws38.mtr.labs.mlnx [10.209.40.117])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 00FDVJp2017247;
        Wed, 15 Jan 2020 15:31:19 +0200
From:   Sergey Gorenko <sergeygo@mellanox.com>
To:     bvanassche@acm.org
Cc:     linux-rdma@vger.kernel.org, Sergey Gorenko <sergeygo@mellanox.com>
Subject: [PATCH] IB/srp: Never use immediate data if it is disabled by a user
Date:   Wed, 15 Jan 2020 13:30:55 +0000
Message-Id: <20200115133055.30232-1-sergeygo@mellanox.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Some SRP targets that do not support specification SRP-2, put
the garbage to the reserved bits of the SRP login response.
The problem was not detected for a long time because the SRP
initiator ignored those bits. But now one of them is used as
SRP_LOGIN_RSP_IMMED_SUPP. And it causes a critical error on
the target when the initiator sends immediate data.

The ib_srp module has a use_imm_date parameter to enable or
disable immediate data manually. But it does not help in the above
case, because use_imm_date is ignored at handling the SRP login
response. The problem is definitely caused by a bug on the target
side, but the initiator's behavior also does not look correct.
The initiator should not use immediate data if use_imm_date is
disabled by a user.

This commit adds an additional checking of use_imm_date at
the handling of SRP login response to avoid unexpected use of
immediate data.

Fixes: commit 882981f4a411 ("RDMA/srp: Add support for immediate data")
Signed-off-by: Sergey Gorenko <sergeygo@mellanox.com>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index b7f7a5f7bd98..cd1181c39ed2 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2546,7 +2546,8 @@ static void srp_cm_rep_handler(struct ib_cm_id *cm_id,
 	if (lrsp->opcode == SRP_LOGIN_RSP) {
 		ch->max_ti_iu_len = be32_to_cpu(lrsp->max_ti_iu_len);
 		ch->req_lim       = be32_to_cpu(lrsp->req_lim_delta);
-		ch->use_imm_data  = lrsp->rsp_flags & SRP_LOGIN_RSP_IMMED_SUPP;
+		ch->use_imm_data  = srp_use_imm_data &&
+			(lrsp->rsp_flags & SRP_LOGIN_RSP_IMMED_SUPP);
 		ch->max_it_iu_len = srp_max_it_iu_len(target->cmd_sg_cnt,
 						      ch->use_imm_data,
 						      target->max_it_iu_size);
-- 
2.21.0

