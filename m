Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8690C6ADC4
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2019 19:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfGPRhS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 13:37:18 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44255 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfGPRhS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jul 2019 13:37:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so10448291plr.11;
        Tue, 16 Jul 2019 10:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=r8DZ4+TCHU5YJteXYwVIzG9DedFytInB8jpSvxKVm2A=;
        b=M4mQ94xTQPQ9pY9zxGxX73zqKMWtbquCdQycZo/YPz1d4M/fKVfuNJMfN3XWxdwKT2
         2ofTGW48AdtJ577O49p+kPnrfgd7tzcoDOvX8T3FGDQzeGNBzFEi5EH7RIvJRKnO/AgF
         bBKnHdDbv8NNWjg0D82TXs984bNvEMIltWiRsonJNypX1aqgC6iTuF7Vn27PgOw7sfpj
         0glWeZNfHq6P+IkAdx9E9yy04XSZ/X64Ibwa5GALDhNIgX92QsU+sPvd1fzdOiVYQzlK
         1b0+Djrc2ENirIk0XOScDrD1SKXtn1Lu+g3nA2HFpEWZgzikFuGO5LK2YcpYDc6xBUT5
         58Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=r8DZ4+TCHU5YJteXYwVIzG9DedFytInB8jpSvxKVm2A=;
        b=TEIeCrvFTgtFpJym19aJJgEsmbhNpjKdmPwMgjO3hSs0Rw04TpsByWhcm6uI73ZEPA
         VD7PkNU+jRBKqTglg/wLEZIQDD5Rs4MvyGLZus6cnzpBRnRTp78rtZfZtG0V5NZHravF
         CvW2o3lIcg6gRj7TNcgKS8HCL8qJqXVp9UmPUUVozENJPSzSdTuU6R7eoryevfJYhs3e
         xJH2/XFwlKPJKBMWrOQK+tt5rcclXdqfDiGCyU3OG6K3sIpCOx8AMjB4i+QwTB0lthBL
         ocBIzzqbRZtfGHTEHU39sMIsjGsBQrxYeM46bj5Flfy9dJxS6JCFjeJZVjnPffg9rMGC
         Fvnw==
X-Gm-Message-State: APjAAAX4Rowpc0LaYrvY1x8paDu3gd3zFERV7/HIJicn60ze/8hksKxs
        XqpCY/EKFczh9B489lr2Fji/J+Ti
X-Google-Smtp-Source: APXvYqxn9+vgjYsY4Pvt44NfOX+4Q9kf56Ci+2S6DyAMNTg07NX2nwtDAiab0OtbW1fYaO/Nw/ofDA==
X-Received: by 2002:a17:902:12d:: with SMTP id 42mr35458184plb.187.1563298637400;
        Tue, 16 Jul 2019 10:37:17 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id j12sm11011828pff.4.2019.07.16.10.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 10:37:16 -0700 (PDT)
Date:   Tue, 16 Jul 2019 23:07:12 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] infiniband: hw: qedr: Remove Unneeded variable rc
Message-ID: <20190716173712.GA12949@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

fix below issue reported by coccicheck
drivers/infiniband/hw/qedr/verbs.c:2454:5-7: Unneeded variable: "rc".
Return "0" on line 2499

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/infiniband/hw/qedr/verbs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 27d90a84..0c6a4bc 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -2451,7 +2451,6 @@ int qedr_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	struct qedr_dev *dev = qp->dev;
 	struct ib_qp_attr attr;
 	int attr_mask = 0;
-	int rc = 0;
 
 	DP_DEBUG(dev, QEDR_MSG_QP, "destroy qp: destroying %p, qp type=%d\n",
 		 qp, qp->qp_type);
@@ -2496,7 +2495,7 @@ int qedr_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 		xa_erase_irq(&dev->qps, qp->qp_id);
 		kfree(qp);
 	}
-	return rc;
+	return 0;
 }
 
 int qedr_create_ah(struct ib_ah *ibah, struct rdma_ah_attr *attr, u32 flags,
-- 
2.7.4

