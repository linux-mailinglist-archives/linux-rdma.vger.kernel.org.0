Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C3021F989
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 20:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgGNSet (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 14:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGNSes (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 14:34:48 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4012DC061755
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 11:34:48 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z13so23978007wrw.5
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 11:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p3yzgToC0gntlXge9ApCI/vT94bnlN6utlTzUkNXB2s=;
        b=em/9xBX69eZbRc+KcjacIriJ4jPD1T6rjxlPoa31E51Xz7i5hRbt5JT8H73saCeW2V
         Ouatp7e/7UDOAblANk+j8Y4O954CoFSfSE7PkfBlQ35ea1JUE2sp+zlbB8r3wsTIMvW0
         rRIjkCVjSNJfxMg6SwP0JqITdoCwW0DpMtoUD5rINpEBumRPdKAQ5KFXBRwq3Wrb138N
         91eQ0xxJSGNjEYD56MCN7ytvWLr7tWKi93YQalA5U1JBE2YvSf2tWWNUhJsp9a8w03z3
         g26CMwko+fvTegGCH/Ljnz8M1N8u1HjA1OekXqUltLrXsJGwAiaBS8iayQfN1YvT3b9N
         HvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p3yzgToC0gntlXge9ApCI/vT94bnlN6utlTzUkNXB2s=;
        b=NuhPNz/N3zkgJmlOPszmqdLna/O9/wxa6+RqK+V4emrRksN3+0L6g5zpiWUZZMt0SK
         2j7zgXztv1X3UPnMPrzSFHkev3w73YN57qYQKE3CM7qhAFtwpT/JcpOrBzfXDVbgH1/F
         qtFb+qjJcK6fgK68e14UpsBWiMnHtOa7EGBa++pcRmic3OZJFeiJVDkevHfOS5hYI583
         XYob1gOS3TM6KEx2xlnwjrmexzexoQX181yMA+y2Ubi+Cuc7e3EIfb2E4yRFbU/QEtp/
         8uoO5SpsVzsINEslNJhUMrPJInhWUxhICUll00j5L6WZQ49QkSbO5tSDeA71t6GGlncv
         sM9Q==
X-Gm-Message-State: AOAM532RcWAh2MiSv91GBmpsbnE4FrbMpxr7656p0CvkQEzvouppSHhu
        dtLLUOO+Zi5i5fRupcThRtLdL/DJxBU=
X-Google-Smtp-Source: ABdhPJwPqjcgkHj5aRdXFWN4wPVeqMBf5lsgMOd76GGeDdm5jIzHjMSU/WOeToWsSM9GPcpbtVXZkw==
X-Received: by 2002:a5d:6749:: with SMTP id l9mr7200112wrw.63.1594751686776;
        Tue, 14 Jul 2020 11:34:46 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id 190sm5728982wmb.15.2020.07.14.11.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 11:34:46 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kamalheib1@gmail.com>,
        Michal Kalderon <michal.kalderon@marvell.com>
Subject: [PATCH for-next v1 7/7] RDMA/qedr: Remove the query_pkey callback
Date:   Tue, 14 Jul 2020 21:34:14 +0300
Message-Id: <20200714183414.61069-8-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714183414.61069-1-kamalheib1@gmail.com>
References: <20200714183414.61069-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Now that the query_pkey() isn't mandatory by the RDMA core for iwarp
providers, this callback can be removed from the common ops and moved to
the RoCE only ops within the qedr driver.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
Acked-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/hw/qedr/main.c  | 3 +--
 drivers/infiniband/hw/qedr/verbs.c | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index ccaedfd53e49..c9eeed25c662 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -110,7 +110,6 @@ static int qedr_iw_port_immutable(struct ib_device *ibdev, u8 port_num,
 	if (err)
 		return err;
 
-	immutable->pkey_tbl_len = 1;
 	immutable->gid_tbl_len = 1;
 	immutable->core_cap_flags = RDMA_CORE_PORT_IWARP;
 	immutable->max_mad_size = 0;
@@ -179,6 +178,7 @@ static int qedr_iw_register_device(struct qedr_dev *dev)
 
 static const struct ib_device_ops qedr_roce_dev_ops = {
 	.get_port_immutable = qedr_roce_port_immutable,
+	.query_pkey = qedr_query_pkey,
 };
 
 static void qedr_roce_register_device(struct qedr_dev *dev)
@@ -221,7 +221,6 @@ static const struct ib_device_ops qedr_dev_ops = {
 	.post_srq_recv = qedr_post_srq_recv,
 	.process_mad = qedr_process_mad,
 	.query_device = qedr_query_device,
-	.query_pkey = qedr_query_pkey,
 	.query_port = qedr_query_port,
 	.query_qp = qedr_query_qp,
 	.query_srq = qedr_query_srq,
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 3d7d5617818f..63eb935a1596 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -239,7 +239,6 @@ int qedr_query_port(struct ib_device *ibdev, u8 port, struct ib_port_attr *attr)
 	attr->ip_gids = true;
 	if (rdma_protocol_iwarp(&dev->ibdev, 1)) {
 		attr->gid_tbl_len = 1;
-		attr->pkey_tbl_len = 1;
 	} else {
 		attr->gid_tbl_len = QEDR_MAX_SGID;
 		attr->pkey_tbl_len = QEDR_ROCE_PKEY_TABLE_LEN;
-- 
2.25.4

