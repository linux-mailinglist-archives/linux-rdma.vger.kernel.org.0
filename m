Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAEC1EC5F
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 12:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfEOKtf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 06:49:35 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:34513 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725953AbfEOKtf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 May 2019 06:49:35 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 15 May 2019 13:49:32 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x4FAnVKO025252;
        Wed, 15 May 2019 13:49:32 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-rdma@vger.kernel.org, leon@kernel.org, jgg@mellanox.com,
        dledford@redhat.com
Cc:     hch@lst.de, sagi@grimberg.me, maxg@mellanox.com,
        israelr@mellanox.com
Subject: [PATCH 3/7] IB/isert: Remove unused sig_attrs argument
Date:   Wed, 15 May 2019 13:49:27 +0300
Message-Id: <1557917371-8777-4-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1557917371-8777-1-git-send-email-maxg@mellanox.com>
References: <1557917371-8777-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 989f1ac4245c..ffef4ac152ca 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2067,8 +2067,7 @@ isert_put_text_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
 }
 
 static inline void
-isert_set_dif_domain(struct se_cmd *se_cmd, struct ib_sig_attrs *sig_attrs,
-		     struct ib_sig_domain *domain)
+isert_set_dif_domain(struct se_cmd *se_cmd, struct ib_sig_domain *domain)
 {
 	domain->sig_type = IB_SIG_TYPE_T10_DIF;
 	domain->sig.dif.bg_type = IB_T10DIF_CRC;
@@ -2096,17 +2095,17 @@ isert_set_sig_attrs(struct se_cmd *se_cmd, struct ib_sig_attrs *sig_attrs)
 	case TARGET_PROT_DIN_INSERT:
 	case TARGET_PROT_DOUT_STRIP:
 		sig_attrs->mem.sig_type = IB_SIG_TYPE_NONE;
-		isert_set_dif_domain(se_cmd, sig_attrs, &sig_attrs->wire);
+		isert_set_dif_domain(se_cmd, &sig_attrs->wire);
 		break;
 	case TARGET_PROT_DOUT_INSERT:
 	case TARGET_PROT_DIN_STRIP:
 		sig_attrs->wire.sig_type = IB_SIG_TYPE_NONE;
-		isert_set_dif_domain(se_cmd, sig_attrs, &sig_attrs->mem);
+		isert_set_dif_domain(se_cmd, &sig_attrs->mem);
 		break;
 	case TARGET_PROT_DIN_PASS:
 	case TARGET_PROT_DOUT_PASS:
-		isert_set_dif_domain(se_cmd, sig_attrs, &sig_attrs->wire);
-		isert_set_dif_domain(se_cmd, sig_attrs, &sig_attrs->mem);
+		isert_set_dif_domain(se_cmd, &sig_attrs->wire);
+		isert_set_dif_domain(se_cmd, &sig_attrs->mem);
 		break;
 	default:
 		isert_err("Unsupported PI operation %d\n", se_cmd->prot_op);
-- 
2.16.3

