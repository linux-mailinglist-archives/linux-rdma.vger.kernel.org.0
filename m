Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9A85D13AF
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2019 18:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbfJIQKH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Oct 2019 12:10:07 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40845 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731676AbfJIQKH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Oct 2019 12:10:07 -0400
Received: by mail-qt1-f195.google.com with SMTP id m61so4175551qte.7
        for <linux-rdma@vger.kernel.org>; Wed, 09 Oct 2019 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZC1v9ugnaaFWH7UTiFTNH8kHjwko438bz+jhFBDh8+g=;
        b=gUxFjjN2bRRJuNBccaNrUAEVrjV8VROumW0YJnYkvczpVKZKaFiRigvxxqaZ7apbYi
         RHxifbwnnF0O7BFjGU0zsVDT5Xehca0AqapNCA1lhuxXtNYzLkzF0LvgJUf1rQJXPbfE
         HjUbePB5H/2nmdpTdZoaC9QllqUPZiUx/OWG6jvW8fIFOnzlTnErlZ2kOoDnZZWYKO8D
         2AepUtiJv/g11VMbxmfnGabZ1Ms0OZ64ihG/RDt0ttSK4BVsr+qURjLRjKOLSotK8LPs
         pmzvFzZV0jYArrQEvcncOm9yRBUV7Bla0nsHfXlYt5/qEOipcdzCG1nTRaWjRCbW0vyA
         BIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZC1v9ugnaaFWH7UTiFTNH8kHjwko438bz+jhFBDh8+g=;
        b=tH72/j5WGfl4zI9mjhw++R0vEWcrgPZ1T7ApteaZ6TYBdFVg5F9fOFgGTjmC2k/kLs
         XiIw/3DKNiaap6CaznSKwYtG//psjPVRN3SwE6RfMgEwaD66MMqcgTAmbChgCh1Grwcf
         0AiU8Tg0hWuZwRaTszuvWPHuN80h8urKqp2uhKZvE7ceTCtGDBHjGS/L+tkiibYowxUu
         d/1uYlAoXI/c8BVNW6pWx5CMLx6lvYSotQ4pt+YIABxKkVf85fiqIV+nRu9WpdNzgMZK
         5oE/lex8E/hRuuTfzi1YSSPQFttgwOxAKP9am0wVdjz2sZZ8D1ICyjNaWQe18uusUfa/
         on1Q==
X-Gm-Message-State: APjAAAU1xdw3fqecPtSkV/cZqqJI6Sxst1A+CFe6gLwXGXAu3VJxitFu
        YljqKYk/9K06lrtdIwdRBla21AuXEyE=
X-Google-Smtp-Source: APXvYqwfhDND/eJsdYTTN3AO0UN32d9ZOENVXBX4mM7VM3nRiuZsX7q9rdxUQCkz8X1a5FY1jijg4w==
X-Received: by 2002:ac8:740b:: with SMTP id p11mr4375538qtq.75.1570637406064;
        Wed, 09 Oct 2019 09:10:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id q126sm1119616qkf.47.2019.10.09.09.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Oct 2019 09:10:05 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iIEXM-0000qO-Oc; Wed, 09 Oct 2019 13:10:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 02/15] RDMA/mlx5: Split sig_err MR data into its own xarray
Date:   Wed,  9 Oct 2019 13:09:22 -0300
Message-Id: <20191009160934.3143-3-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009160934.3143-1-jgg@ziepe.ca>
References: <20191009160934.3143-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

The locking model for signature is completely different than ODP, do not
share the same xarray that relies on SRCU locking to support ODP.

Simply store the active mlx5_core_sig_ctx's in an xarray when signature
MRs are created and rely on trivial xarray locking to serialize
everything.

The overhead of storing only a handful of SIG related MRs is going to be
much less than an xarray full of every mkey.

Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/mlx5/cq.c      | 33 ++++++++++++++--------------
 drivers/infiniband/hw/mlx5/main.c    |  2 ++
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 ++
 drivers/infiniband/hw/mlx5/mr.c      |  8 +++++++
 4 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 45f48cde6b9d54..cc938d27f9131a 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -423,9 +423,6 @@ static int mlx5_poll_one(struct mlx5_ib_cq *cq,
 	struct mlx5_cqe64 *cqe64;
 	struct mlx5_core_qp *mqp;
 	struct mlx5_ib_wq *wq;
-	struct mlx5_sig_err_cqe *sig_err_cqe;
-	struct mlx5_core_mkey *mmkey;
-	struct mlx5_ib_mr *mr;
 	uint8_t opcode;
 	uint32_t qpn;
 	u16 wqe_ctr;
@@ -519,27 +516,29 @@ static int mlx5_poll_one(struct mlx5_ib_cq *cq,
 			}
 		}
 		break;
-	case MLX5_CQE_SIG_ERR:
-		sig_err_cqe = (struct mlx5_sig_err_cqe *)cqe64;
+	case MLX5_CQE_SIG_ERR: {
+		struct mlx5_sig_err_cqe *sig_err_cqe =
+			(struct mlx5_sig_err_cqe *)cqe64;
+		struct mlx5_core_sig_ctx *sig;
 
-		xa_lock(&dev->mdev->priv.mkey_table);
-		mmkey = xa_load(&dev->mdev->priv.mkey_table,
+		xa_lock(&dev->sig_mrs);
+		sig = xa_load(&dev->sig_mrs,
 				mlx5_base_mkey(be32_to_cpu(sig_err_cqe->mkey)));
-		mr = to_mibmr(mmkey);
-		get_sig_err_item(sig_err_cqe, &mr->sig->err_item);
-		mr->sig->sig_err_exists = true;
-		mr->sig->sigerr_count++;
+		get_sig_err_item(sig_err_cqe, &sig->err_item);
+		sig->sig_err_exists = true;
+		sig->sigerr_count++;
 
 		mlx5_ib_warn(dev, "CQN: 0x%x Got SIGERR on key: 0x%x err_type %x err_offset %llx expected %x actual %x\n",
-			     cq->mcq.cqn, mr->sig->err_item.key,
-			     mr->sig->err_item.err_type,
-			     mr->sig->err_item.sig_err_offset,
-			     mr->sig->err_item.expected,
-			     mr->sig->err_item.actual);
+			     cq->mcq.cqn, sig->err_item.key,
+			     sig->err_item.err_type,
+			     sig->err_item.sig_err_offset,
+			     sig->err_item.expected,
+			     sig->err_item.actual);
 
-		xa_unlock(&dev->mdev->priv.mkey_table);
+		xa_unlock(&dev->sig_mrs);
 		goto repoll;
 	}
+	}
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 831539419c3016..b7eea724beaab7 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6150,6 +6150,7 @@ static void mlx5_ib_stage_init_cleanup(struct mlx5_ib_dev *dev)
 		cleanup_srcu_struct(&dev->mr_srcu);
 	}
 
+	WARN_ON(!xa_empty(&dev->sig_mrs));
 	WARN_ON(!bitmap_empty(dev->dm.memic_alloc_pages, MLX5_MAX_MEMIC_PAGES));
 }
 
@@ -6201,6 +6202,7 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	mutex_init(&dev->cap_mask_mutex);
 	INIT_LIST_HEAD(&dev->qp_list);
 	spin_lock_init(&dev->reset_flow_resource_lock);
+	xa_init(&dev->sig_mrs);
 
 	spin_lock_init(&dev->dm.lock);
 	dev->dm.dev = mdev;
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 1a98ee2e01c4b9..f4ce58354544ad 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -999,6 +999,8 @@ struct mlx5_ib_dev {
 	struct mlx5_srq_table   srq_table;
 	struct mlx5_async_ctx   async_ctx;
 	struct mlx5_devx_event_table devx_event_table;
+
+	struct xarray sig_mrs;
 };
 
 static inline struct mlx5_ib_cq *to_mibcq(struct mlx5_core_cq *mcq)
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 630599311586ec..fd24640606c120 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1560,6 +1560,7 @@ static void clean_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 					  mr->sig->psv_wire.psv_idx))
 			mlx5_ib_warn(dev, "failed to destroy wire psv %d\n",
 				     mr->sig->psv_wire.psv_idx);
+		xa_erase(&dev->sig_mrs, mlx5_base_mkey(mr->mmkey.key));
 		kfree(mr->sig);
 		mr->sig = NULL;
 	}
@@ -1797,8 +1798,15 @@ static int mlx5_alloc_integrity_descs(struct ib_pd *pd, struct mlx5_ib_mr *mr,
 	if (err)
 		goto err_free_mtt_mr;
 
+	err = xa_err(xa_store(&dev->sig_mrs, mlx5_base_mkey(mr->mmkey.key),
+			      mr->sig, GFP_KERNEL));
+	if (err)
+		goto err_free_descs;
 	return 0;
 
+err_free_descs:
+	destroy_mkey(dev, mr);
+	mlx5_free_priv_descs(mr);
 err_free_mtt_mr:
 	dereg_mr(to_mdev(mr->mtt_mr->ibmr.device), mr->mtt_mr);
 	mr->mtt_mr = NULL;
-- 
2.23.0

