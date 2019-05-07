Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7227164C1
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 15:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfEGNi5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 09:38:57 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:40444 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726509AbfEGNi4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 09:38:56 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 7 May 2019 16:38:41 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x47DcdFE021865;
        Tue, 7 May 2019 16:38:41 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com, maxg@mellanox.com
Subject: [PATCH 14/25] IB/iser: Remove unused sig_attrs argument
Date:   Tue,  7 May 2019 16:38:28 +0300
Message-Id: <1557236319-9986-15-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/ulp/iser/iser_memory.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband/ulp/iser/iser_memory.c
index 7b4a3a2345b1..8c243ed5d90c 100644
--- a/drivers/infiniband/ulp/iser/iser_memory.c
+++ b/drivers/infiniband/ulp/iser/iser_memory.c
@@ -302,8 +302,7 @@ void iser_unreg_mem_fastreg(struct iscsi_iser_task *iser_task,
 }
 
 static void
-iser_set_dif_domain(struct scsi_cmnd *sc, struct ib_sig_attrs *sig_attrs,
-		    struct ib_sig_domain *domain)
+iser_set_dif_domain(struct scsi_cmnd *sc, struct ib_sig_domain *domain)
 {
 	domain->sig_type = IB_SIG_TYPE_T10_DIF;
 	domain->sig.dif.pi_interval = scsi_prot_interval(sc);
@@ -326,21 +325,21 @@ iser_set_sig_attrs(struct scsi_cmnd *sc, struct ib_sig_attrs *sig_attrs)
 	case SCSI_PROT_WRITE_INSERT:
 	case SCSI_PROT_READ_STRIP:
 		sig_attrs->mem.sig_type = IB_SIG_TYPE_NONE;
-		iser_set_dif_domain(sc, sig_attrs, &sig_attrs->wire);
+		iser_set_dif_domain(sc, &sig_attrs->wire);
 		sig_attrs->wire.sig.dif.bg_type = IB_T10DIF_CRC;
 		break;
 	case SCSI_PROT_READ_INSERT:
 	case SCSI_PROT_WRITE_STRIP:
 		sig_attrs->wire.sig_type = IB_SIG_TYPE_NONE;
-		iser_set_dif_domain(sc, sig_attrs, &sig_attrs->mem);
+		iser_set_dif_domain(sc, &sig_attrs->mem);
 		sig_attrs->mem.sig.dif.bg_type = sc->prot_flags & SCSI_PROT_IP_CHECKSUM ?
 						IB_T10DIF_CSUM : IB_T10DIF_CRC;
 		break;
 	case SCSI_PROT_READ_PASS:
 	case SCSI_PROT_WRITE_PASS:
-		iser_set_dif_domain(sc, sig_attrs, &sig_attrs->wire);
+		iser_set_dif_domain(sc, &sig_attrs->wire);
 		sig_attrs->wire.sig.dif.bg_type = IB_T10DIF_CRC;
-		iser_set_dif_domain(sc, sig_attrs, &sig_attrs->mem);
+		iser_set_dif_domain(sc, &sig_attrs->mem);
 		sig_attrs->mem.sig.dif.bg_type = sc->prot_flags & SCSI_PROT_IP_CHECKSUM ?
 						IB_T10DIF_CSUM : IB_T10DIF_CRC;
 		break;
-- 
2.16.3

