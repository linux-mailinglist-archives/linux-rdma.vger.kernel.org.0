Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B103CD13B4
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2019 18:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731800AbfJIQKK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Oct 2019 12:10:10 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45558 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731822AbfJIQKK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Oct 2019 12:10:10 -0400
Received: by mail-qt1-f196.google.com with SMTP id c21so4133262qtj.12
        for <linux-rdma@vger.kernel.org>; Wed, 09 Oct 2019 09:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bms+IT5MZqNV0OUlVj1frgTxwihSaQb2fJLJiJ9ZrWc=;
        b=Y0MhJ6kIYXzrhv++FoRDJkxrazfNw3XNZiut27AfSMTql2epnTcC4qqwV05H+76Zdn
         653hx8nJBWrS7WWaiiODYVe9293z2W4rpezP8n8+2JKEmT2OQf0cO/KyvAIh8KG/FNtY
         kZ/fK+XW/EfUjHJzwTCtjU2TPovYSjHX2gu/n00yOm87sRHpG1/jR6Y2Mub/Zd5dxOMC
         v2m3/h6CgR8iZAsEqAHdeRDRtTEWpMIuKgkEopn+ckb40QwMBr+bVMGrMvRQxUhfJqEE
         4Tjxn4MfAr9h17OVALW1xFWdPb4Dtq016U3kj6M01yOQmeXAOAxUcsMarjSmAjyx6FJD
         zZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bms+IT5MZqNV0OUlVj1frgTxwihSaQb2fJLJiJ9ZrWc=;
        b=nmVlIzcudebN6U/cEZk/I6R13EzH+0YZEDeuoE4dMStYW/WYeGShEbdZZFeBhBIUzg
         H+4VbJO2ulkg4W5GK028U8Wb1niIPn29aRsq6QxUkAMG57RI+MyN+LG7y765EbehNBrR
         cDLdMb4vMlxNoFeB52wZ7lgSLESVBZk7wOhK5bjNR+TJaeCT9LeYAYf31Aw63sjqjvv4
         3tHD8Ud55FLhTQDzY2IMi7/AOlDPXeH493T5tmahzPcAb8JiGer6TIhIQaAPiaD62V2b
         rS/0pqEVDkO/eLJ4f9iPtTvzmGjTueWJo57doqM8Quy1mTXGLgDJsh8VihFeWXX9pIRr
         e2kw==
X-Gm-Message-State: APjAAAXuBy08VHljwk2I/p/eTnvrKu/C0HFuzYubCUJHz3yGb3nSSkHK
        x/KS/EpTGIwhVQ1Ao4CH5tl/NQEKf10=
X-Google-Smtp-Source: APXvYqxNNJU7F7wr/2JBmJg6Xbl1AxC+7GK2uTJSQLboO03PmF85FAHwSO1nGam2y5MDjp+4Syx4AA==
X-Received: by 2002:ac8:3934:: with SMTP id s49mr4282357qtb.321.1570637408516;
        Wed, 09 Oct 2019 09:10:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id n44sm1610762qtf.51.2019.10.09.09.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Oct 2019 09:10:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iIEXM-0000qs-W3; Wed, 09 Oct 2019 13:10:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>
Subject: [PATCH 07/15] RDMA/mlx5: Set the HW IOVA of the child MRs to their place in the tree
Date:   Wed,  9 Oct 2019 13:09:27 -0300
Message-Id: <20191009160934.3143-8-jgg@ziepe.ca>
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

Instead of rewriting all the IOVA's to 0 as things progress down the tree
make the IOVA of the children equal to placement in the tree. This makes
things easier to understand by keeping mmkey.iova == HW configuration.

Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 9b912d2f786192..74f7caa9c99fb9 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -211,9 +211,11 @@ void mlx5_odp_populate_klm(struct mlx5_klm *pklm, size_t offset,
 			struct mlx5_ib_mr *mtt = odp->private;
 
 			pklm->key = cpu_to_be32(mtt->ibmr.lkey);
+			pklm->va = cpu_to_be64(va);
 			odp = odp_next(odp);
 		} else {
 			pklm->key = cpu_to_be32(dev->null_mkey);
+			pklm->va = 0;
 		}
 		mlx5_ib_dbg(dev, "[%d] va %lx key %x\n",
 			    i, va, be32_to_cpu(pklm->key));
@@ -446,7 +448,7 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	mr->umem = &odp->umem;
 	mr->ibmr.lkey = mr->mmkey.key;
 	mr->ibmr.rkey = mr->mmkey.key;
-	mr->mmkey.iova = 0;
+	mr->mmkey.iova = idx * MLX5_IMR_MTT_SIZE;
 	mr->parent = imr;
 	odp->private = mr;
 	INIT_WORK(&odp->work, mr_leaf_free_action);
@@ -462,7 +464,6 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 		goto out_release;
 	}
 
-	mr->mmkey.iova = idx * MLX5_IMR_MTT_SIZE;
 	xa_store(&imr->dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key),
 		 &mr->mmkey, GFP_ATOMIC);
 
-- 
2.23.0

