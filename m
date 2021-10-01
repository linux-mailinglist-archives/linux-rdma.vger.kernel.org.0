Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081AE41F6F5
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Oct 2021 23:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhJAVeG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Oct 2021 17:34:06 -0400
Received: from ale.deltatee.com ([204.191.154.188]:36212 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355158AbhJAVeG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Oct 2021 17:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
        :references:content-disposition:in-reply-to;
        bh=9EqXMVRmHPxBHNxMn8elH1LYNshwi6HghvHvCX5UL6E=; b=Ejp+EqTjTRV7gnNEFupiDYQyxb
        nFwiBpC4Tsx8bhC2FmLXF+BwF0jgp36UFoLJSUEvJMos+Sb9NkpwZNGVfh979vJUsAiFpyNNwQud2
        gip51Dy4ZfSB234inFzkXham6c5qNZ07aRFsmNmcBc/6oSLd7VLqj2Qs9H6n+qr3DD/BQN8IpB2wW
        AY3W09qboBzhuQ3RA47l4BgXH9tYkMd8UHx90YbDglJuZlg71Qe3xJPP9mHEjCzfkYYPZcyLWI4z2
        BN2y8Qbup7TpjnAyVe8c8JkBYHzkjiAGeMSoSiaFD88cNJQ/FKO6lGsrtjYSaf8SLzOWOCL5bFMX4
        XR1Vcgnw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1mWQ8h-0007oG-6i; Fri, 01 Oct 2021 15:32:20 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1mWQ8e-0000zS-Kh; Fri, 01 Oct 2021 15:32:16 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zheng Yongjun <zhengyongjun3@huawei.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Leon Romanovsky <leon@kernel.org>,
        Weihang Li <liweihang@huawei.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri,  1 Oct 2021 15:32:15 -0600
Message-Id: <20211001213215.3761-1-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, leon@kernel.org, zhengyongjun3@huawei.com, liangwenpeng@huawei.com, liweihang@huawei.com, mbloch@nvidia.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_FREE,MYRULES_NO_TEXT,MYRULES_OFFER autolearn=no
        autolearn_force=no version=3.4.2
Subject: [PATCH] RDMA/rw: switch to dma_map_sgtable()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There are a couple of subtle error path bugs related to mapping the
sgls:

- In rdma_rw_ctx_init(), dma_unmap would be called with an sg that
  could have been incremented from the original call, as well as an
  nents that was not the original number of nents called when mapped.
- Similarly in rdma_rw_ctx_signature_init, both sg and prot_sg were
  unmapped with the incorrect number of nents.

To fix this, switch to the sgtable interface for mapping which
conveniently stores the original nents for unmapping. This will get
cleaned up further once the dma mapping interface supports P2PDMA and
pci_p2pdma_map_sg() can be removed. At that point the sgtable interface
will be preferred as it offers better error reporting for P2PDMA pages.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---

This patch was extracted from my P2PDMA patchset per Jason's request[1]
seeing it fixes some bugs.

[1] https://lore.kernel.org/all/20210928194325.GS3544071@ziepe.ca/

 drivers/infiniband/core/rw.c | 66 ++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 5221cce65675..5a3bd41b331c 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -282,15 +282,22 @@ static void rdma_rw_unmap_sg(struct ib_device *dev, struct scatterlist *sg,
 		ib_dma_unmap_sg(dev, sg, sg_cnt, dir);
 }

-static int rdma_rw_map_sg(struct ib_device *dev, struct scatterlist *sg,
-			  u32 sg_cnt, enum dma_data_direction dir)
+static int rdma_rw_map_sgtable(struct ib_device *dev, struct sg_table *sgt,
+			       enum dma_data_direction dir)
 {
-	if (is_pci_p2pdma_page(sg_page(sg))) {
+	int nents;
+
+	if (is_pci_p2pdma_page(sg_page(sgt->sgl))) {
 		if (WARN_ON_ONCE(ib_uses_virt_dma(dev)))
 			return 0;
-		return pci_p2pdma_map_sg(dev->dma_device, sg, sg_cnt, dir);
+		nents = pci_p2pdma_map_sg(dev->dma_device, sgt->sgl,
+					  sgt->orig_nents, dir);
+		if (!nents)
+			return -EIO;
+		sgt->nents = nents;
+		return 0;
 	}
-	return ib_dma_map_sg(dev, sg, sg_cnt, dir);
+	return ib_dma_map_sgtable_attrs(dev, sgt, dir, 0);
 }

 /**
@@ -313,12 +320,16 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u32 port_num,
 		u64 remote_addr, u32 rkey, enum dma_data_direction dir)
 {
 	struct ib_device *dev = qp->pd->device;
+	struct sg_table sgt = {
+		.sgl = sg,
+		.orig_nents = sg_cnt,
+	};
 	int ret;

-	ret = rdma_rw_map_sg(dev, sg, sg_cnt, dir);
-	if (!ret)
-		return -ENOMEM;
-	sg_cnt = ret;
+	ret = rdma_rw_map_sgtable(dev, &sgt, dir);
+	if (ret)
+		return ret;
+	sg_cnt = sgt.nents;

 	/*
 	 * Skip to the S/G entry that sg_offset falls into:
@@ -354,7 +365,7 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u32 port_num,
 	return ret;

 out_unmap_sg:
-	rdma_rw_unmap_sg(dev, sg, sg_cnt, dir);
+	rdma_rw_unmap_sg(dev, sgt.sgl, sgt.orig_nents, dir);
 	return ret;
 }
 EXPORT_SYMBOL(rdma_rw_ctx_init);
@@ -385,6 +396,14 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	struct ib_device *dev = qp->pd->device;
 	u32 pages_per_mr = rdma_rw_fr_page_list_len(qp->pd->device,
 						    qp->integrity_en);
+	struct sg_table sgt = {
+		.sgl = sg,
+		.orig_nents = sg_cnt,
+	};
+	struct sg_table prot_sgt = {
+		.sgl = prot_sg,
+		.orig_nents = prot_sg_cnt,
+	};
 	struct ib_rdma_wr *rdma_wr;
 	int count = 0, ret;

@@ -394,18 +413,14 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		return -EINVAL;
 	}

-	ret = rdma_rw_map_sg(dev, sg, sg_cnt, dir);
-	if (!ret)
-		return -ENOMEM;
-	sg_cnt = ret;
+	ret = rdma_rw_map_sgtable(dev, &sgt, dir);
+	if (ret)
+		return ret;

 	if (prot_sg_cnt) {
-		ret = rdma_rw_map_sg(dev, prot_sg, prot_sg_cnt, dir);
-		if (!ret) {
-			ret = -ENOMEM;
+		ret = rdma_rw_map_sgtable(dev, &prot_sgt, dir);
+		if (ret)
 			goto out_unmap_sg;
-		}
-		prot_sg_cnt = ret;
 	}

 	ctx->type = RDMA_RW_SIG_MR;
@@ -426,10 +441,11 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,

 	memcpy(ctx->reg->mr->sig_attrs, sig_attrs, sizeof(struct ib_sig_attrs));

-	ret = ib_map_mr_sg_pi(ctx->reg->mr, sg, sg_cnt, NULL, prot_sg,
-			      prot_sg_cnt, NULL, SZ_4K);
+	ret = ib_map_mr_sg_pi(ctx->reg->mr, sg, sgt.nents, NULL, prot_sg,
+			      prot_sgt.nents, NULL, SZ_4K);
 	if (unlikely(ret)) {
-		pr_err("failed to map PI sg (%u)\n", sg_cnt + prot_sg_cnt);
+		pr_err("failed to map PI sg (%u)\n",
+		       sgt.nents + prot_sgt.nents);
 		goto out_destroy_sig_mr;
 	}

@@ -468,10 +484,10 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 out_free_ctx:
 	kfree(ctx->reg);
 out_unmap_prot_sg:
-	if (prot_sg_cnt)
-		rdma_rw_unmap_sg(dev, prot_sg, prot_sg_cnt, dir);
+	if (prot_sgt.nents)
+		rdma_rw_unmap_sg(dev, prot_sgt.sgl, prot_sgt.orig_nents, dir);
 out_unmap_sg:
-	rdma_rw_unmap_sg(dev, sg, sg_cnt, dir);
+	rdma_rw_unmap_sg(dev, sgt.sgl, sgt.orig_nents, dir);
 	return ret;
 }
 EXPORT_SYMBOL(rdma_rw_ctx_signature_init);

base-commit: 450f4f6aa1a369cc3ffadc1c7e27dfab3e90199f
--
2.30.2
