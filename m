Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 485E9DDD27
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Oct 2019 09:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfJTHQU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Oct 2019 03:16:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfJTHQU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 20 Oct 2019 03:16:20 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1469A21744;
        Sun, 20 Oct 2019 07:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571555778;
        bh=9lX0dY96lDe/nG8RBrPiy4okSQRATw+koAPWb6/TloM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z/ffiTuGgN3S4P1jl9P24APIOgJr4oTNG83t025MGlOPmt9vipPgMLtwRQx9O8MN9
         qrAuo4qQHGwEjeH2vUycFz/lQv1TNOk63Gg19AwW7AkVPpGEWuMrIAdVobrWGYE1b1
         0BIu4SwQpZ7ZuHCqV/STMXo94x5b2FfVPwKT4B14=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH rdma-next 5/6] RDMA/cm: Provide private data size to CM users
Date:   Sun, 20 Oct 2019 10:15:58 +0300
Message-Id: <20191020071559.9743-6-leon@kernel.org>
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

Prepare code to removal IB_CM_*_PRIVATE_DATA_SIZE enum so we will store
such size in adjacent to actual data.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 11 +++++++++++
 include/rdma/ib_cm.h         |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 2eb8e1fab962..ecd868954958 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1681,6 +1681,7 @@ static void cm_format_req_event(struct cm_work *work,
 	param->srq = cm_req_get_srq(req_msg);
 	param->ppath_sgid_attr = cm_id_priv->av.ah_attr.grh.sgid_attr;
 	work->cm_event.private_data = &req_msg->private_data;
+	work->cm_event.private_data_len = IB_CM_REQ_PRIVATE_DATA_SIZE;
 }

 static void cm_process_work(struct cm_id_private *cm_id_priv,
@@ -2193,6 +2194,7 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
 	param->rnr_retry_count = cm_rep_get_rnr_retry_count(rep_msg);
 	param->srq = cm_rep_get_srq(rep_msg);
 	work->cm_event.private_data = &rep_msg->private_data;
+	work->cm_event.private_data_len = IB_CM_REP_PRIVATE_DATA_SIZE;
 }

 static void cm_dup_rep_handler(struct cm_work *work)
@@ -2395,6 +2397,7 @@ static int cm_rtu_handler(struct cm_work *work)
 		return -EINVAL;

 	work->cm_event.private_data = &rtu_msg->private_data;
+	work->cm_event.private_data_len = IB_CM_RTU_PRIVATE_DATA_SIZE;

 	spin_lock_irq(&cm_id_priv->lock);
 	if (cm_id_priv->id.state != IB_CM_REP_SENT &&
@@ -2597,6 +2600,7 @@ static int cm_dreq_handler(struct cm_work *work)
 	}

 	work->cm_event.private_data = &dreq_msg->private_data;
+	work->cm_event.private_data_len = IB_CM_DREQ_PRIVATE_DATA_SIZE;

 	spin_lock_irq(&cm_id_priv->lock);
 	if (cm_id_priv->local_qpn != cm_dreq_get_remote_qpn(dreq_msg))
@@ -2671,6 +2675,7 @@ static int cm_drep_handler(struct cm_work *work)
 		return -EINVAL;

 	work->cm_event.private_data = &drep_msg->private_data;
+	work->cm_event.private_data_len = IB_CM_DREP_PRIVATE_DATA_SIZE;

 	spin_lock_irq(&cm_id_priv->lock);
 	if (cm_id_priv->id.state != IB_CM_DREQ_SENT &&
@@ -2770,6 +2775,7 @@ static void cm_format_rej_event(struct cm_work *work)
 	param->ari_length = cm_rej_get_reject_info_len(rej_msg);
 	param->reason = __be16_to_cpu(rej_msg->reason);
 	work->cm_event.private_data = &rej_msg->private_data;
+	work->cm_event.private_data_len = IB_CM_REJ_PRIVATE_DATA_SIZE;
 }

 static struct cm_id_private * cm_acquire_rejected_id(struct cm_rej_msg *rej_msg)
@@ -2982,6 +2988,7 @@ static int cm_mra_handler(struct cm_work *work)
 		return -EINVAL;

 	work->cm_event.private_data = &mra_msg->private_data;
+	work->cm_event.private_data_len = IB_CM_MRA_PRIVATE_DATA_SIZE;
 	work->cm_event.param.mra_rcvd.service_timeout =
 					cm_mra_get_service_timeout(mra_msg);
 	timeout = cm_convert_to_ms(cm_mra_get_service_timeout(mra_msg)) +
@@ -3214,6 +3221,7 @@ static int cm_lap_handler(struct cm_work *work)
 	param->alternate_path = &work->path[0];
 	cm_format_path_from_lap(cm_id_priv, param->alternate_path, lap_msg);
 	work->cm_event.private_data = &lap_msg->private_data;
+	work->cm_event.private_data_len = IB_CM_LAP_PRIVATE_DATA_SIZE;

 	spin_lock_irq(&cm_id_priv->lock);
 	if (cm_id_priv->id.state != IB_CM_ESTABLISHED)
@@ -3367,6 +3375,7 @@ static int cm_apr_handler(struct cm_work *work)
 	work->cm_event.param.apr_rcvd.apr_info = &apr_msg->info;
 	work->cm_event.param.apr_rcvd.info_len = apr_msg->info_length;
 	work->cm_event.private_data = &apr_msg->private_data;
+	work->cm_event.private_data_len = IB_CM_APR_PRIVATE_DATA_SIZE;

 	spin_lock_irq(&cm_id_priv->lock);
 	if (cm_id_priv->id.state != IB_CM_ESTABLISHED ||
@@ -3515,6 +3524,7 @@ static void cm_format_sidr_req_event(struct cm_work *work,
 	param->port = work->port->port_num;
 	param->sgid_attr = rx_cm_id->av.ah_attr.grh.sgid_attr;
 	work->cm_event.private_data = &sidr_req_msg->private_data;
+	work->cm_event.private_data_len = IB_CM_SIDR_REQ_PRIVATE_DATA_SIZE;
 }

 static int cm_sidr_req_handler(struct cm_work *work)
@@ -3664,6 +3674,7 @@ static void cm_format_sidr_rep_event(struct cm_work *work,
 	param->info_len = sidr_rep_msg->info_length;
 	param->sgid_attr = cm_id_priv->av.ah_attr.grh.sgid_attr;
 	work->cm_event.private_data = &sidr_rep_msg->private_data;
+	work->cm_event.private_data_len = IB_CM_SIDR_REP_PRIVATE_DATA_SIZE;
 }

 static int cm_sidr_rep_handler(struct cm_work *work)
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index b01a8a8d4de9..b476e0e27ec9 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -254,6 +254,7 @@ struct ib_cm_event {
 	} param;

 	void			*private_data;
+	u8			private_data_len;
 };

 #define CM_REQ_ATTR_ID		cpu_to_be16(0x0010)
--
2.20.1

