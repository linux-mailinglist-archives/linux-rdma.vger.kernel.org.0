Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623DF473E0B
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Dec 2021 09:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhLNILE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Dec 2021 03:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhLNILE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Dec 2021 03:11:04 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C15C061574;
        Tue, 14 Dec 2021 00:11:04 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id a24so16687078qvb.5;
        Tue, 14 Dec 2021 00:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y4CwYy1oz5qCFH7hnn8EGWRG4TQi5zkgqW0pRWIQj40=;
        b=Mi+R0O58z/Q7IJFNBeLTjlwQgH2+9zmqgrqFIpSpAkQIsBhalLD2mIy6EXtDcCOxIa
         Nn9HUyJCbff3VzxFI7MhVie5A9vxvoRSB5AGd7SlxPLp70+M719iHJ1upI0YiIHTxeLT
         c+TxwtvWy4RogW/gAAcm1Q/YfxqxYc7fFkdgzLcvLCIFLOeSYPMcjEOwmm5of8be4hdY
         rtuhQf9DzHR2NdLc5LuRtBlebx1WaiTT1UIF2HZ/uJ9OvT4E2oKaFAQprbgw4s3vGG3m
         EmtMwXpJfCpg8kCs94EM6QdGPuFBu2dePoJiYqtJ4+yCj/rtWhrEUXW7xyMiFXY5vEPg
         nb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y4CwYy1oz5qCFH7hnn8EGWRG4TQi5zkgqW0pRWIQj40=;
        b=s+Xg2oMo6zUCjFW2VdqnhrboFEBKqVAavJG4KSRkwDDdJ5QEjI/PreHOJgDZZo/wim
         g7DaLXNTYxov1h4f1qjwUtMLUtHVdFSGxD18ayw4ccKf7LrzAWPegpm+SrEG1EgdK28h
         Kx5W+2cJSnFs3ipPGsv89ARDzRFRBsiaiAfV1G421BzdH0eApsGST4YGaGFbVMKZNKCs
         jPghh8UmTOz11cSEVkX9ZLlVkT6kGDv/4tGUITVsWIgwwUhvwEvQcQDe0FTUvUrh144v
         fbUxUrd6zQS1T41DgZmGRivWbN5YmaK365nW7b7OnTRGct308GB63TIYGCTItuqqG9a5
         yHTg==
X-Gm-Message-State: AOAM533SaGz9nYLqcMPl7sAVuifwvEVmIeSBKKD+ugWpaaWz+/mrjSpf
        6R38dfUFMtV8Iz/lOi436bI=
X-Google-Smtp-Source: ABdhPJwXABuNpGgJ0qajPBlBDvDDJnzRFkSz9oNByYV4gj55Ga7Sezvy8zGGA/fQA6XJzw0ktzV3yw==
X-Received: by 2002:a05:6214:2682:: with SMTP id gm2mr3888157qvb.64.1639469463364;
        Tue, 14 Dec 2021 00:11:03 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x15sm7155576qko.82.2021.12.14.00.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 00:11:02 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     devesh.s.sharma@oracle.com
Cc:     cgel.zte@gmail.com, chi.minghao@zte.com.cn,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        galpress@amazon.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        mbloch@nvidia.com, selvin.xavier@broadcom.com, trix@redhat.com,
        zealci@zte.com.cm, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v3 ocrdma-next] drivers: ocrdma: remove unneeded variable
Date:   Tue, 14 Dec 2021 08:10:54 +0000
Message-Id: <20211214081054.438166-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CO6PR10MB5635FDF74CA549F662C33F4DDD759@CO6PR10MB5635.namprd10.prod.outlook.com>
References: <CO6PR10MB5635FDF74CA549F662C33F4DDD759@CO6PR10MB5635.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return status directly from function called.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
change since v2: [PATCHv2] drivers:ocrdma:remove unneeded variable
             v3: [PATCH v3 ocrdma-next] drivers: ocrdma: remove unneeded variable 
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 735123d0e9ec..3bfbf4ec040d 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -1844,12 +1844,10 @@ int ocrdma_modify_srq(struct ib_srq *ibsrq,
 
 int ocrdma_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *srq_attr)
 {
-	int status;
 	struct ocrdma_srq *srq;
 
 	srq = get_ocrdma_srq(ibsrq);
-	status = ocrdma_mbx_query_srq(srq, srq_attr);
-	return status;
+	return ocrdma_mbx_query_srq(srq, srq_attr);
 }
 
 int ocrdma_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
@@ -1960,7 +1958,6 @@ static int ocrdma_build_inline_sges(struct ocrdma_qp *qp,
 static int ocrdma_build_send(struct ocrdma_qp *qp, struct ocrdma_hdr_wqe *hdr,
 			     const struct ib_send_wr *wr)
 {
-	int status;
 	struct ocrdma_sge *sge;
 	u32 wqe_size = sizeof(*hdr);
 
@@ -1972,8 +1969,7 @@ static int ocrdma_build_send(struct ocrdma_qp *qp, struct ocrdma_hdr_wqe *hdr,
 		sge = (struct ocrdma_sge *)(hdr + 1);
 	}
 
-	status = ocrdma_build_inline_sges(qp, hdr, sge, wr, wqe_size);
-	return status;
+	return ocrdma_build_inline_sges(qp, hdr, sge, wr, wqe_size);
 }
 
 static int ocrdma_build_write(struct ocrdma_qp *qp, struct ocrdma_hdr_wqe *hdr,
-- 
2.25.1

