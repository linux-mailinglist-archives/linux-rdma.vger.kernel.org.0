Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B2F39F532
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 13:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhFHLie (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 07:38:34 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:46950 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbhFHLid (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 07:38:33 -0400
Received: by mail-ej1-f48.google.com with SMTP id he7so12642116ejc.13
        for <linux-rdma@vger.kernel.org>; Tue, 08 Jun 2021 04:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O+LEBi5Z/wtsHTWBc3Zdl2VwUxRi/WQcAXOK5w1mBfY=;
        b=CSo3nlFuA3UgZ6dy/vT72tHgPrT/e0Mow9fnC4q1XnYr5P9WZpE9mo4Ie4LpuTLvGL
         SXQfzLNIlR5E2ML/VY6ohX8Y6EKSLBnOpjRRzNv6rRQOsFMCr7mR84krr9sfqfjf9reO
         G/cc2AXNMYaDajpzRShmdFNTpxd7nZpEC1cGoQgel0e5y/ny3BvGY6TQmdI98eNh72EW
         SNL4U16N99hnTlkoesQrNPpQUT7YJ4QwylIJ+XLg5DA8LOjhM5RFJl+VamB1z3EOSrUb
         bY59pb+AYmCAgrO1Be5qsVP7PspZIIv0qbigc2hj5wRKhicVkKtqLSqc+D7Fx0qtq4J5
         eThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O+LEBi5Z/wtsHTWBc3Zdl2VwUxRi/WQcAXOK5w1mBfY=;
        b=TpmT3+IefgUJcITLLzn0uw/h00ugqZzlDaG5YOkDbPa9XPN6QVHkFAPyuSB6cY3Mul
         clUdYrNKf0bwsH/WNkiP6VX64WnN+RzDlR2xZpPdPp+2WK+f5YkivI96y3TuU1W85yPt
         NOJlrU8M5+RIU0zKb18Nj4c+VMmDG5gzDTf06fXTuE1NKYWJaZUtDL5qO2bTtxB3nM7+
         0q3RdXVPZRDevKn00bIOTkYLf6ACkIAMXvI19bXOvy6q+VghtZ8PG7EuFU2BWmn0bngH
         YPM7qYaMmVMTVlQ6tBUnl8G12clasRoyhiCwJzGUq8zZM1NmNezeId59vU8nSknrdWB/
         X7Sg==
X-Gm-Message-State: AOAM530396eoT8JR/x1c3rdRteigkX+PSmT9CwidntU/HGMG9bSwsI/o
        ESdqm9zeEavebdSBkg6FHKTKcc0BLrFKyQ==
X-Google-Smtp-Source: ABdhPJwVvUsbIvK1kOMo0DlVs2FWhlcmBpHv27WxpkorRRr2yRWffI+Wx2jbqWRZd/I1XvwIXM4h/A==
X-Received: by 2002:a17:906:af85:: with SMTP id mj5mr23754522ejb.352.1623152139610;
        Tue, 08 Jun 2021 04:35:39 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4943:5b00:2927:a608:b264:d770])
        by smtp.gmail.com with ESMTPSA id c7sm7675480ejs.26.2021.06.08.04.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 04:35:39 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        axboe@kernel.dk, Jack Wang <jinpu.wang@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCH for-next 3/5] RDMA/rtrs_clt: Alloc less memory with write path fast memory registration
Date:   Tue,  8 Jun 2021 13:35:34 +0200
Message-Id: <20210608113536.42965-4-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608113536.42965-1-jinpu.wang@ionos.com>
References: <20210608113536.42965-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

With write path fast memory registration, we need less memory for
each request.

With fast memory registration, we can reduce max_send_sge to save
memory usage.

Also convert the kmalloc_array to kcalloc.

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index b7c9684d7f62..af738e7e1396 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1372,8 +1372,7 @@ static int alloc_sess_reqs(struct rtrs_clt_sess *sess)
 		if (!req->iu)
 			goto out;
 
-		req->sge = kmalloc_array(clt->max_segments + 1,
-					 sizeof(*req->sge), GFP_KERNEL);
+		req->sge = kcalloc(2, sizeof(*req->sge), GFP_KERNEL);
 		if (!req->sge)
 			goto out;
 
@@ -1674,7 +1673,7 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 		max_recv_wr =
 			min_t(int, sess->s.dev->ib_dev->attrs.max_qp_wr,
 			      sess->queue_depth * 3 + 1);
-		max_send_sge = sess->clt->max_segments + 1;
+		max_send_sge = 2;
 	}
 	cq_num = max_send_wr + max_recv_wr;
 	/* alloc iu to recv new rkey reply when server reports flags set */
-- 
2.25.1

