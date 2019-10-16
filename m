Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B072D8956
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2019 09:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfJPHXD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Oct 2019 03:23:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34948 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfJPHXD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Oct 2019 03:23:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id y21so1538869wmi.0
        for <linux-rdma@vger.kernel.org>; Wed, 16 Oct 2019 00:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TycqH6hRWVQcQ82ZcSfaibr4XzfZ5J5iKsyxzuflrxg=;
        b=ZNkGJulizU9/cOjUsRXIz2b0V2H2c3vqa/71oELKcIldVHiuYWxlEcif0DaDqXRxIJ
         pIo1xl7t+q0VpbWP2lW70wCrTfynaF8w3zHc7NIpMiTozUMHkf6O005OM+7kRvdkEsRj
         G4D/hZ6X8MsBpZVrzM2BXviGAcrn37LkVP9OWRfJHQitWs3YjgCpZTYgi9JOwOvAi2l0
         cslTJuA6h2olS2QaMDGxCMOC9v74QhUjkS8BJKa7X0GqSUfye4ss/Oz+srSAceQhXJGb
         o2WBpqbtwu6LV0xSPL2zcFLOEVfFP/nmGc00i1RjQK/1H35WQirGhRzsTPjfFi3AF2RN
         4dDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TycqH6hRWVQcQ82ZcSfaibr4XzfZ5J5iKsyxzuflrxg=;
        b=nsAN2lIDTNMng2ssr9Rjc8zv313bJGBCJp2YHn3Qu6yr9+gQjEId+yGmz7WFAD6ZhY
         LHYLQ8ydLO8tuxEiqL1rDgq/mrzxhirSfgz7PVrPczCoc6jdfgVTHKlGPJnQsH7+90Jz
         fqWLjhfSuCo4wge64dCHdnmKBxekk8RnksGM5fnnHww7UQS7EdCGnF3QXdlDk7IhZf8u
         pk06ymQB0fXGDf+6ySbnZIomJYvgjFU5r7DmvD3VG7bYLTYyeZgttny8Ry4NOXv847he
         47fmEF/DelDJ1Tc3S6Daaeg5ml/TtYU/ohLG5as653LxaPLpDGtFU6PnS8P+ThHg0Yn9
         IbiA==
X-Gm-Message-State: APjAAAXZfvTCIY7FazRkIcwrmypzuSxysIYMWO5iUcDmCPPe0aXVshot
        TlaW1zG5uAjd86kIwhnM1sRSERP5
X-Google-Smtp-Source: APXvYqy7fp/e4SI5Ee/RSgn/u5d0efM7SpC2qgXxpUls22op4vrgBN0Rw77PhodrGY5992Ka+8m66Q==
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr2097912wmk.145.1571210580214;
        Wed, 16 Oct 2019 00:23:00 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id r140sm1687046wme.47.2019.10.16.00.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:22:59 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next v2 4/4] RDMA/qedr: Remove unsupported modify_port callback
Date:   Wed, 16 Oct 2019 10:22:34 +0300
Message-Id: <20191016072234.28442-5-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191016072234.28442-1-kamalheib1@gmail.com>
References: <20191016072234.28442-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is no need to return always zero for function which is not
supported.

Fixes: ac1b36e55a51 ("qedr: Add support for user context verbs")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/qedr/main.c  | 1 -
 drivers/infiniband/hw/qedr/verbs.c | 6 ------
 drivers/infiniband/hw/qedr/verbs.h | 2 --
 3 files changed, 9 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index 5136b835e1ba..e5f36adb0120 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -212,7 +212,6 @@ static const struct ib_device_ops qedr_dev_ops = {
 	.get_link_layer = qedr_link_layer,
 	.map_mr_sg = qedr_map_mr_sg,
 	.mmap = qedr_mmap,
-	.modify_port = qedr_modify_port,
 	.modify_qp = qedr_modify_qp,
 	.modify_srq = qedr_modify_srq,
 	.poll_cq = qedr_poll_cq,
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 6f3ce86019b7..fee02ac47f32 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -250,12 +250,6 @@ int qedr_query_port(struct ib_device *ibdev, u8 port, struct ib_port_attr *attr)
 	return 0;
 }
 
-int qedr_modify_port(struct ib_device *ibdev, u8 port, int mask,
-		     struct ib_port_modify *props)
-{
-	return 0;
-}
-
 static int qedr_add_mmap(struct qedr_ucontext *uctx, u64 phy_addr,
 			 unsigned long len)
 {
diff --git a/drivers/infiniband/hw/qedr/verbs.h b/drivers/infiniband/hw/qedr/verbs.h
index 9aaa90283d6e..d81b81f86f0a 100644
--- a/drivers/infiniband/hw/qedr/verbs.h
+++ b/drivers/infiniband/hw/qedr/verbs.h
@@ -35,8 +35,6 @@
 int qedr_query_device(struct ib_device *ibdev,
 		      struct ib_device_attr *attr, struct ib_udata *udata);
 int qedr_query_port(struct ib_device *, u8 port, struct ib_port_attr *props);
-int qedr_modify_port(struct ib_device *, u8 port, int mask,
-		     struct ib_port_modify *props);
 
 int qedr_iw_query_gid(struct ib_device *ibdev, u8 port,
 		      int index, union ib_gid *gid);
-- 
2.20.1

