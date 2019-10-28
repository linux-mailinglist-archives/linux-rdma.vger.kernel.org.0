Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB4CE75B3
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 17:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbfJ1QAJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 12:00:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35745 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730448AbfJ1QAI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 12:00:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id x5so2469121wmi.0
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 09:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/nLBDNnI2ytUN/R+LaCECQ51HAzPdQVxI7fwxKBAxkk=;
        b=nodnf2sRqlZqlo2vQ/hdno2iYJ6Ru5PmNQkP645SG5eYXTuO8PLb/beTbDK7mu+28e
         UmINNW9BMWYonxuRM2wxEkmKHTGxNCQsitmOo1NvuU+c4bxZvQr0eHoMwNkLNq4aYO9c
         ITeTys/9j8HlN8fXAcUIJtcaAswQzCXFNVJe1zzmN9GIxwaVSKws+2VvSdqfkOvVBdkD
         BbB5bS3WTRGWqxKj6V8Samm6bGoI0lFWL7Nni3xLfNSjVJ9qI2mMCASAO6osrgMgTaUP
         RhlsDg/8BEx5CwogBiEm0IwB2pSjFvlZH59JDklNJqZD+lBj1AyBNHFdTE8ryiBV2KgA
         lndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/nLBDNnI2ytUN/R+LaCECQ51HAzPdQVxI7fwxKBAxkk=;
        b=VHhlGv+vEcncYm0pmCf64oEJ7+YRwAofhpCKsA/NM0xGRZusH1JaMJRjagT34KU9QD
         Np8oTMUs13Xk5ugORW7d0UvuNVg3QsnT9LxP0y4qGlDikXFocImBXExHLDkFTgr8DC+o
         vNGXpildrFmvKkESihfNGUs9VDWRUV34kXV3BaQj44HnhcPBoGr61UW08Pi/0qY9EKlP
         SgafJ7oDlbqs30CGA4HvrZxaGs/PQ/m+/CU9fYQBMgk6bUPjKu8Ws3UcqZhKFti9QrHI
         KJUCL7Nvq5REWGbPVb45jnpiEc8eE0OIB+NLHVvAmnX2hdT6EED4bibj7UmvNb2yKGJJ
         OsTQ==
X-Gm-Message-State: APjAAAWvnv6zFVbk7OvoTbCF24IUCi17VYASAE+H2JSTbmKXmEoMZ9Vv
        KEu2Am8w7vzC/uStWNMWz6If8T9fsus=
X-Google-Smtp-Source: APXvYqw9EdZszj07yN0CtK6/aFlorqwi06zyjmrrmbo80De5PVZWyY/slwGlHQPjldJHT3f/qL2Pdg==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr16503wmb.138.1572278406584;
        Mon, 28 Oct 2019 09:00:06 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id a2sm11871600wrv.39.2019.10.28.09.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:00:06 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [for-next v4 3/4] RDMA/ocrdma: Remove unsupported modify_port callback
Date:   Mon, 28 Oct 2019 17:59:30 +0200
Message-Id: <20191028155931.1114-4-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028155931.1114-1-kamalheib1@gmail.com>
References: <20191028155931.1114-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is no need to return always zero for function which is not
supported.

Fixes: fe2caefcdf58 ("RDMA/ocrdma: Add driver for Emulex OneConnect IBoE RDMAadapter")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma_main.c  | 1 -
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 6 ------
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h | 2 --
 3 files changed, 9 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
index c15cfc6cef81..d8c47d24d6d6 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
@@ -166,7 +166,6 @@ static const struct ib_device_ops ocrdma_dev_ops = {
 	.get_port_immutable = ocrdma_port_immutable,
 	.map_mr_sg = ocrdma_map_mr_sg,
 	.mmap = ocrdma_mmap,
-	.modify_port = ocrdma_modify_port,
 	.modify_qp = ocrdma_modify_qp,
 	.poll_cq = ocrdma_poll_cq,
 	.post_recv = ocrdma_post_recv,
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index e8267e590772..e72050de5734 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -190,12 +190,6 @@ int ocrdma_query_port(struct ib_device *ibdev,
 	return 0;
 }
 
-int ocrdma_modify_port(struct ib_device *ibdev, u8 port, int mask,
-		       struct ib_port_modify *props)
-{
-	return 0;
-}
-
 static int ocrdma_add_mmap(struct ocrdma_ucontext *uctx, u64 phy_addr,
 			   unsigned long len)
 {
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
index 32488da1b752..3a5010881be5 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
@@ -54,8 +54,6 @@ int ocrdma_arm_cq(struct ib_cq *, enum ib_cq_notify_flags flags);
 int ocrdma_query_device(struct ib_device *, struct ib_device_attr *props,
 			struct ib_udata *uhw);
 int ocrdma_query_port(struct ib_device *, u8 port, struct ib_port_attr *props);
-int ocrdma_modify_port(struct ib_device *, u8 port, int mask,
-		       struct ib_port_modify *props);
 
 enum rdma_protocol_type
 ocrdma_query_protocol(struct ib_device *device, u8 port_num);
-- 
2.20.1

