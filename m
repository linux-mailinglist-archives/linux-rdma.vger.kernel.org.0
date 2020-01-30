Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEA614D76B
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2020 09:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgA3IVB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jan 2020 03:21:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56190 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgA3IVA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jan 2020 03:21:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so2725573wmj.5
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jan 2020 00:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dq6lDtiD2rh1Q9g4Sy3QN/AJI5VfcnQigh5h26EBr0k=;
        b=pVKVOHn81O5oFSlUMhezR1XLZ7YVzxF3oFiujSqMP9AFFVu36HlP5jOTnd7nRCYi6F
         7vEu6N3MJR86XbzQjCNspDP4KQz3iUazBY3O0neBRNGuPbGYPigq6nCbILKxS4A+SI6Z
         9FGuPPyDANTiNtybyWBa3bGQbmC4k/4zFZoIbKLaSH4dk+lzZjpPUdUfF7KaBTYgpQIl
         U7UJSm7TzDMs+i0nJOAk/ZPhcw73QpOf26P380WkH16LWYxM/YQHoSC+9s5E6A59y6g+
         H1qb7l+RtyvhaB4ZGQXzhFpJEr7+TwzpfaELKvwDHQUl3KzEOYHfeIEnudFyvWaYDNLf
         lUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dq6lDtiD2rh1Q9g4Sy3QN/AJI5VfcnQigh5h26EBr0k=;
        b=CQ0V2VUzdkKgggNmJmNwjT/ELEcYv8aNJYpOMwv65kJCEzSbo9J5Oo1IF8oiggRsqm
         3cfCK1mO5T1tnsfDyAkAFeoWGGY1tZocLN+DuyJ5DzU+oKw/4SWpawC6SWnyqK6TG+lT
         O06DyU3IKGhomUc++jHBHi4X7jFidJgF9YhD3qpQu5yDujQNnGDy7YiRys9QV+XoEyuG
         wT50CsyuTAv1lOTenUKaQ3FBcbsa09DJIyWCCspg7PyPjKRLrlLIaNHKZgU1qh1EBQD2
         mb+1AB1kFu6G9Ocg7iaFSjWo1+c/+1AJ6pUkymgyr2n8FXceLoSbKtX57nYRx08n3/iX
         V5Sg==
X-Gm-Message-State: APjAAAVKmcMSEBJGETsAMDYgTfdaQI1LgFTfTTs0318ovlIabzyUKQd+
        wsMjGQ/6L9RbRjOobFio71pnLNLl
X-Google-Smtp-Source: APXvYqxuu4w4iQR1dqneNT1/hxavhdgvcrDVtXbK0xssZtEmpZ/w/MqWJrBXDgZOuInQNbBNaf555g==
X-Received: by 2002:a1c:488a:: with SMTP id v132mr4106606wma.153.1580372457792;
        Thu, 30 Jan 2020 00:20:57 -0800 (PST)
Received: from kheib-workstation.redhat.com (bzq-79-183-20-197.red.bezeqint.net. [79.183.20.197])
        by smtp.gmail.com with ESMTPSA id x11sm5373524wmg.46.2020.01.30.00.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 00:20:57 -0800 (PST)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/providers: Fix return value when QP type isn't supported
Date:   Thu, 30 Jan 2020 10:20:49 +0200
Message-Id: <20200130082049.463-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The proper return code is "-EOPNOTSUPP" when the requested QP type is
not supported by the provider.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c     | 2 +-
 drivers/infiniband/hw/cxgb4/qp.c             | 2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c      | 2 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c    | 2 +-
 drivers/infiniband/hw/mlx4/qp.c              | 2 +-
 drivers/infiniband/hw/mlx5/qp.c              | 2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c | 2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  | 2 +-
 drivers/infiniband/hw/qedr/verbs.c           | 2 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c | 2 +-
 drivers/infiniband/sw/rdmavt/qp.c            | 2 +-
 drivers/infiniband/sw/siw/siw_verbs.c        | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 52b6a4d85460..f1a75ff44d5a 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1016,7 +1016,7 @@ struct ib_qp *bnxt_re_create_qp(struct ib_pd *ib_pd,
 	if (qp->qplib_qp.type == IB_QPT_MAX) {
 		dev_err(rdev_to_dev(rdev), "QP type 0x%x not supported",
 			qp->qplib_qp.type);
-		rc = -EINVAL;
+		rc = -EOPNOTSUPP;
 		goto fail;
 	}
 
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index bbcac539777a..708216d82852 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -2127,7 +2127,7 @@ struct ib_qp *c4iw_create_qp(struct ib_pd *pd, struct ib_qp_init_attr *attrs,
 	pr_debug("ib_pd %p\n", pd);
 
 	if (attrs->qp_type != IB_QPT_RC)
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(-EOPNOTSUPP);
 
 	php = to_c4iw_pd(pd);
 	rhp = php->rhp;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 3257ad11be48..3df48bda4185 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1097,7 +1097,7 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 	default:{
 		ibdev_err(ibdev, "not support QP type %d\n",
 			  init_attr->qp_type);
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(-EOPNOTSUPP);
 	}
 	}
 
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index c335de91508f..fa1292932b88 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -617,7 +617,7 @@ static struct ib_qp *i40iw_create_qp(struct ib_pd *ibpd,
 	iwqp->ctx_info.qp_compl_ctx = (uintptr_t)qp;
 
 	if (init_attr->qp_type != IB_QPT_RC) {
-		err_code = -EINVAL;
+		err_code = -EOPNOTSUPP;
 		goto error;
 	}
 	if (iwdev->push_mode)
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 26425dd2d960..2f9f78912267 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -1636,7 +1636,7 @@ static struct ib_qp *_mlx4_ib_create_qp(struct ib_pd *pd,
 	}
 	default:
 		/* Don't support raw QPs */
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(-EOPNOTSUPP);
 	}
 
 	return &qp->ibqp;
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index a4f8e7030787..a597c9043b1d 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2789,7 +2789,7 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 		mlx5_ib_dbg(dev, "unsupported qp type %d\n",
 			    init_attr->qp_type);
 		/* Don't support raw QPs */
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(-EOPNOTSUPP);
 	}
 
 	if (verbs_init_attr->qp_type == IB_QPT_DRIVER)
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index ac19d57803b5..69a3e4f62fb1 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -561,7 +561,7 @@ static struct ib_qp *mthca_create_qp(struct ib_pd *pd,
 	}
 	default:
 		/* Don't support raw QPs */
-		return ERR_PTR(-ENOSYS);
+		return ERR_PTR(-EOPNOTSUPP);
 	}
 
 	if (err) {
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index d47ea675734b..10e343894595 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -1111,7 +1111,7 @@ static int ocrdma_check_qp_params(struct ib_pd *ibpd, struct ocrdma_dev *dev,
 	    (attrs->qp_type != IB_QPT_UD)) {
 		pr_err("%s(%d) unsupported qp type=0x%x requested\n",
 		       __func__, dev->id, attrs->qp_type);
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 	/* Skip the check for QP1 to support CM size of 128 */
 	if ((attrs->qp_type != IB_QPT_GSI) &&
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 484b555150e0..a5bd3adaf90a 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1186,7 +1186,7 @@ static int qedr_check_qp_attrs(struct ib_pd *ibpd, struct qedr_dev *dev,
 		DP_DEBUG(dev, QEDR_MSG_QP,
 			 "create qp: unsupported qp type=0x%x requested\n",
 			 attrs->qp_type);
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 
 	if (attrs->cap.max_send_wr > qattr->max_sqe) {
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index 556b8e44a51c..71f82339446c 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -504,7 +504,7 @@ struct ib_qp *usnic_ib_create_qp(struct ib_pd *pd,
 	if (init_attr->qp_type != IB_QPT_UD) {
 		usnic_err("%s asked to make a non-UD QP: %d\n",
 			  dev_name(&us_ibdev->ib_dev.dev), init_attr->qp_type);
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(-EOPNOTSUPP);
 	}
 
 	trans_spec = cmd.spec;
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
index 9de1281f9a3b..afcc2abcf55c 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
@@ -217,7 +217,7 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
 	    init_attr->qp_type != IB_QPT_GSI) {
 		dev_warn(&dev->pdev->dev, "queuepair type %d not supported\n",
 			 init_attr->qp_type);
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(-EOPNOTSUPP);
 	}
 
 	if (is_srq && !dev->dsr->caps.max_srq) {
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 3cdf75d0c7a4..762d4dc11c41 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1196,7 +1196,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 
 	default:
 		/* Don't support raw QPs */
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(-EOPNOTSUPP);
 	}
 
 	init_attr->cap.max_inline_data = 0;
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 07e30138aaa1..fab934bdb2a0 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -322,7 +322,7 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 	}
 	if (attrs->qp_type != IB_QPT_RC) {
 		siw_dbg(base_dev, "only RC QP's supported\n");
-		rv = -EINVAL;
+		rv = -EOPNOTSUPP;
 		goto err_out;
 	}
 	if ((attrs->cap.max_send_wr > SIW_MAX_QP_WR) ||
-- 
2.21.1

