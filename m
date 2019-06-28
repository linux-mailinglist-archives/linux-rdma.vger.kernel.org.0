Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5955918D
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2019 04:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfF1Crf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 22:47:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33593 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfF1Crf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jun 2019 22:47:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id m4so1908450pgk.0;
        Thu, 27 Jun 2019 19:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fJ47MRa54/spRr5r/yI2vCauDi4XF+3e9HtKZ+72i2A=;
        b=Yy36lrjiwCSs9R4ZhVQ52tV1gXdemOjTie9roi4hmX3PedS49fBZmmE/YQdM2BupeO
         uKt5Iahra9+TmtcGujB08m87Py44LYXYwnaroLZoJN5erU6jn+1ZO84rYbqT3DTj6ceC
         0fhsgZCftyw7YAheAoOO8tv/yToJe9mk4CEs4AVjCh6lgKvePQxcF+sP5dks7fJQh3JO
         z2+A3ehJQJQ5CCgaRQ+i23yZpE4Fs22wy+K6OedmvMjt0/JaX6V0RzLle6CwXWwxm803
         zCpXnHwr/+SQnfcXeiTk2GXZF7JoGeePRK80VAvkkjQDF0fVJo0KC/z5euVXQOboko5z
         FXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fJ47MRa54/spRr5r/yI2vCauDi4XF+3e9HtKZ+72i2A=;
        b=lALY5rOWui2Kv/5Mp6c6W/BDBBa5ImHMRogUSj2YDh38/5I7PaMIrzv8x1ZjaEVhk0
         /ZTNdF0JuzY2g5pWrtx6p/oGsemi0ZyDn54Yt7jcXwOlG3tnxF47n/I4z+3GvwdZX2Sf
         l4jyuFMAb2s5j6rKFUqQ1chUoREocmFgAeO0oR9uXCQRLp8xVfCfCQ8JtACfVugRZIYB
         NNz3OybJIDdkauRVMnfw2DJnwJD/JbZRQjcMPwRaKPtwcvIpyE8hAEWVy1Mlbu3UB/B0
         alqbjcECyU1hvVTDjPQzX5v3c3OUei4Ly3JEI2P4cXOHaPkzxYNGdQMTHsjQSeguJZBS
         dFiA==
X-Gm-Message-State: APjAAAXi0/EQSzoYaCqNBHVwkcdDLrSiBDzMLlhlB7Qw10RYfFNsws19
        MYRky1hp1BXrMifmzGxuQf8=
X-Google-Smtp-Source: APXvYqyNKjCfKw0uS9FHgo1ZKeidSLXzQvup8gT+VNqLgKVlL09OIjph9yqDq0KpSESxzjoRwd/zNA==
X-Received: by 2002:a17:90a:33c4:: with SMTP id n62mr10366199pjb.28.1561690053333;
        Thu, 27 Jun 2019 19:47:33 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id f17sm388158pgv.16.2019.06.27.19.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 19:47:32 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Parav Pandit <parav@mellanox.com>,
        Kamal Heib <kamalheib1@gmail.com>,
        Feras Daoud <ferasda@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Aaron Knister <aaron.s.knister@nasa.gov>,
        Denis Drozdov <denisd@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/27] infiniband: remove unneeded memset
Date:   Fri, 28 Jun 2019 10:47:19 +0800
Message-Id: <20190628024723.15257-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

pci_alloc_consistent calls dma_alloc_coherent directly.
In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent/dmam_alloc_coherent has already zeroed the memory.
So the memset after these 3 function calls is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/infiniband/hw/cxgb3/cxio_hal.c        | 3 ---
 drivers/infiniband/hw/cxgb4/cq.c              | 1 -
 drivers/infiniband/hw/cxgb4/qp.c              | 1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c    | 1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 3 ---
 drivers/infiniband/hw/mthca/mthca_allocator.c | 2 --
 drivers/infiniband/hw/nes/nes_verbs.c         | 3 ---
 drivers/infiniband/hw/ocrdma/ocrdma_hw.c      | 3 ---
 drivers/infiniband/ulp/ipoib/ipoib_cm.c       | 1 -
 9 files changed, 18 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb3/cxio_hal.c b/drivers/infiniband/hw/cxgb3/cxio_hal.c
index 8ac72ac7cbac..0e37f55678f8 100644
--- a/drivers/infiniband/hw/cxgb3/cxio_hal.c
+++ b/drivers/infiniband/hw/cxgb3/cxio_hal.c
@@ -174,7 +174,6 @@ int cxio_create_cq(struct cxio_rdev *rdev_p, struct t3_cq *cq, int kernel)
 		return -ENOMEM;
 	}
 	dma_unmap_addr_set(cq, mapping, cq->dma_addr);
-	memset(cq->queue, 0, size);
 	setup.id = cq->cqid;
 	setup.base_addr = (u64) (cq->dma_addr);
 	setup.size = 1UL << cq->size_log2;
@@ -538,8 +537,6 @@ static int cxio_hal_init_ctrl_qp(struct cxio_rdev *rdev_p)
 	dma_unmap_addr_set(&rdev_p->ctrl_qp, mapping,
 			   rdev_p->ctrl_qp.dma_addr);
 	rdev_p->ctrl_qp.doorbell = (void __iomem *)rdev_p->rnic_info.kdb_addr;
-	memset(rdev_p->ctrl_qp.workq, 0,
-	       (1 << T3_CTRL_QP_SIZE_LOG2) * sizeof(union t3_wr));
 
 	mutex_init(&rdev_p->ctrl_qp.lock);
 	init_waitqueue_head(&rdev_p->ctrl_qp.waitq);
diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index 52ce586621c6..fcd161e3495b 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -104,7 +104,6 @@ static int create_cq(struct c4iw_rdev *rdev, struct t4_cq *cq,
 		goto err3;
 	}
 	dma_unmap_addr_set(cq, mapping, cq->dma_addr);
-	memset(cq->queue, 0, cq->memsize);
 
 	if (user && ucontext->is_32b_cqe) {
 		cq->qp_errp = &((struct t4_status_page *)
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index e92b9544357a..4882dcbb7d20 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -274,7 +274,6 @@ static int create_qp(struct c4iw_rdev *rdev, struct t4_wq *wq,
 			 (unsigned long long)virt_to_phys(wq->sq.queue),
 			 wq->rq.queue,
 			 (unsigned long long)virt_to_phys(wq->rq.queue));
-		memset(wq->rq.queue, 0, wq->rq.memsize);
 		dma_unmap_addr_set(&wq->rq, mapping, wq->rq.dma_addr);
 	}
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index e068a02122f5..36d9dcaaa8f9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -4265,7 +4265,6 @@ static int hns_roce_v1_create_eq(struct hns_roce_dev *hr_dev,
 		}
 
 		eq->buf_list[i].map = tmp_dma_addr;
-		memset(eq->buf_list[i].buf, 0, HNS_ROCE_BA_SIZE);
 	}
 	eq->cons_index = 0;
 	roce_set_field(tmp, ROCEE_CAEP_AEQC_AEQE_SHIFT_CAEP_AEQC_STATE_M,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index b5392cb5b20f..a4a7c5962916 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1774,7 +1774,6 @@ static int hns_roce_init_link_table(struct hns_roce_dev *hr_dev,
 			goto err_alloc_buf_failed;
 
 		link_tbl->pg_list[i].map = t;
-		memset(link_tbl->pg_list[i].buf, 0, buf_chk_sz);
 
 		entry[i].blk_ba0 = (t >> 12) & 0xffffffff;
 		roce_set_field(entry[i].blk_ba1_nxt_ptr,
@@ -5387,8 +5386,6 @@ static int hns_roce_mhop_alloc_eq(struct hns_roce_dev *hr_dev,
 		eq->cur_eqe_ba = eq->l0_dma;
 		eq->nxt_eqe_ba = 0;
 
-		memset(eq->bt_l0, 0, eq->entries * eq->eqe_size);
-
 		return 0;
 	}
 
diff --git a/drivers/infiniband/hw/mthca/mthca_allocator.c b/drivers/infiniband/hw/mthca/mthca_allocator.c
index aaf10dd5364d..aef1d274a14e 100644
--- a/drivers/infiniband/hw/mthca/mthca_allocator.c
+++ b/drivers/infiniband/hw/mthca/mthca_allocator.c
@@ -214,8 +214,6 @@ int mthca_buf_alloc(struct mthca_dev *dev, int size, int max_direct,
 
 		dma_unmap_addr_set(&buf->direct, mapping, t);
 
-		memset(buf->direct.buf, 0, size);
-
 		while (t & ((1 << shift) - 1)) {
 			--shift;
 			npages *= 2;
diff --git a/drivers/infiniband/hw/nes/nes_verbs.c b/drivers/infiniband/hw/nes/nes_verbs.c
index 49024326a518..534f978f1a58 100644
--- a/drivers/infiniband/hw/nes/nes_verbs.c
+++ b/drivers/infiniband/hw/nes/nes_verbs.c
@@ -828,7 +828,6 @@ static int nes_setup_virt_qp(struct nes_qp *nesqp, struct nes_pbl *nespbl,
 		kunmap(nesqp->page);
 		return -ENOMEM;
 	}
-	memset(nesqp->pbl_vbase, 0, 256);
 	/* fill in the page address in the pbl buffer.. */
 	tpbl = pblbuffer + 16;
 	pbl = (__le64 *)nespbl->pbl_vbase;
@@ -898,8 +897,6 @@ static int nes_setup_mmap_qp(struct nes_qp *nesqp, struct nes_vnic *nesvnic,
 			"host descriptor rings located @ %p (pa = 0x%08lX.) size = %u.\n",
 			mem, (unsigned long)nesqp->hwqp.sq_pbase, nesqp->qp_mem_size);
 
-	memset(mem, 0, nesqp->qp_mem_size);
-
 	nesqp->hwqp.sq_vbase = mem;
 	mem += sizeof(struct nes_hw_qp_wqe) * sq_size;
 
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_hw.c b/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
index 5127e2ea4bdd..6e07712eb3ed 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
@@ -1351,7 +1351,6 @@ static int ocrdma_mbx_get_ctrl_attribs(struct ocrdma_dev *dev)
 	mqe->u.nonemb_req.sge[0].pa_hi = (u32) upper_32_bits(dma.pa);
 	mqe->u.nonemb_req.sge[0].len = dma.size;
 
-	memset(dma.va, 0, dma.size);
 	ocrdma_init_mch((struct ocrdma_mbx_hdr *)dma.va,
 			OCRDMA_CMD_GET_CTRL_ATTRIBUTES,
 			OCRDMA_SUBSYS_COMMON,
@@ -1690,7 +1689,6 @@ static int ocrdma_mbx_create_ah_tbl(struct ocrdma_dev *dev)
 		goto mem_err_ah;
 	dev->av_tbl.pa = pa;
 	dev->av_tbl.num_ah = max_ah;
-	memset(dev->av_tbl.va, 0, dev->av_tbl.size);
 
 	pbes = (struct ocrdma_pbe *)dev->av_tbl.pbl.va;
 	for (i = 0; i < dev->av_tbl.size / OCRDMA_MIN_Q_PAGE_SIZE; i++) {
@@ -2905,7 +2903,6 @@ static int ocrdma_mbx_get_dcbx_config(struct ocrdma_dev *dev, u32 ptype,
 	mqe_sge->pa_hi = (u32) upper_32_bits(pa);
 	mqe_sge->len = cmd.hdr.pyld_len;
 
-	memset(req, 0, sizeof(struct ocrdma_get_dcbx_cfg_req));
 	ocrdma_init_mch(&req->hdr, OCRDMA_CMD_GET_DCBX_CONFIG,
 			OCRDMA_SUBSYS_DCBX, cmd.hdr.pyld_len);
 	req->param_type = ptype;
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
index aa9dcfc36cd3..c59e00a0881f 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -1153,7 +1153,6 @@ static int ipoib_cm_tx_init(struct ipoib_cm_tx *p, u32 qpn,
 		ret = -ENOMEM;
 		goto err_tx;
 	}
-	memset(p->tx_ring, 0, ipoib_sendq_size * sizeof(*p->tx_ring));
 
 	p->qp = ipoib_cm_create_tx_qp(p->dev, p);
 	memalloc_noio_restore(noio_flag);
-- 
2.11.0

