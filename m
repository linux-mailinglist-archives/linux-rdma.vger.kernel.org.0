Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0605524BCD4
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Aug 2020 14:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgHTMy1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 08:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730190AbgHTMyR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 08:54:17 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1A2C061385
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 05:54:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r2so1905061wrs.8
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 05:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cseRCzSq/KecmHB/jrPKgFYWFzfjCMT45fU0Uq3EQzQ=;
        b=Zcm73Hxo1Hnzv4zbVfIqeiySZglPd4hky4BJ2SPagAzVC6O0cfELmiMV3ulkMc+GBf
         s39yRRWqu5JPuInWABjCBQ8eCw82VYFLLQdDpM7dj4MFxZ7K3TZFGQAdDrorhhfQTdlN
         VQOLD1pbBMuh/0k5cMfZ/gToaiFLRsBkN1a54FdXAmJnjGTSO33toBWfEg8dyo2Oq2jS
         b9FzWjHZtGx+USx5D5yU7Pqs6H5ppRvDB7919WbWc3Rwttlcz1vqqNg5yQgeSG7G2ofm
         pGRN+jyDy9H7CLkAsSXnvBuxS8GzC+WH+lZt5qbRzCtA9DiyTXd7dkHpzyoHERNf/Py4
         ZQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cseRCzSq/KecmHB/jrPKgFYWFzfjCMT45fU0Uq3EQzQ=;
        b=Zn08CxqWTjZqTyIjjo3F2DwAKva/XZCB944FQHT3ufR1Veosqjwd0zMktspjvlod+1
         H9DthwwPTA4dFP1KbL9bZIxEm+C/Z48Ig9mOYtjmB0GU9opHRJlYdbiiauVUZx7P13+p
         0C9ZK3FMxSOn/DZ/LOGx3rTyRNQ1ZHFt9qo96NrYlXUl6oNIwhvEi0M1aFUZ1Em4ADXY
         ChEffugMZTVTp+cyElYTdkchIGjHl65lNSmo7Z116zsfzlyInQux8i+FgPpW35jFyxYW
         WxJJMdh1Ejxg6wwg0orPYHYNjdZkmBUWwIw94Pe2O6dKK3tS6SVmPrkLVQ+HdnY9p5ly
         1j3Q==
X-Gm-Message-State: AOAM531RIBM/e6TfFedLpV+5ZhpkPLaSzgG09TfOSesUt6sw7IEdAtnC
        p40YmPzadLiz8KP0foUSlI9BzW18kkw=
X-Google-Smtp-Source: ABdhPJyMJOa4Gfk4wv2BP0nA5ntz2ss3PnQgH+gJnmgtZEGJg8KkshYB+9/OLdfgR+bVIzWT/nJ/dg==
X-Received: by 2002:adf:f151:: with SMTP id y17mr3299237wro.179.1597928055535;
        Thu, 20 Aug 2020 05:54:15 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.0.228])
        by smtp.gmail.com with ESMTPSA id h10sm4142209wro.57.2020.08.20.05.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 05:54:15 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Benvenuti <benve@cisco.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/usnic: Remove the query_pkey callback
Date:   Thu, 20 Aug 2020 15:53:46 +0300
Message-Id: <20200820125346.111902-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Now that the query_pkey() isn't mandatory by the RDMA core, this
callback can be removed from the usnic provider.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/usnic/usnic_ib_main.c  |  2 --
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 11 -----------
 drivers/infiniband/hw/usnic/usnic_ib_verbs.h |  2 --
 3 files changed, 15 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniband/hw/usnic/usnic_ib_main.c
index c9abe1c01e4e..515460c4212d 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
@@ -315,7 +315,6 @@ static int usnic_port_immutable(struct ib_device *ibdev, u8 port_num,
 	if (err)
 		return err;
 
-	immutable->pkey_tbl_len = attr.pkey_tbl_len;
 	immutable->gid_tbl_len = attr.gid_tbl_len;
 
 	return 0;
@@ -355,7 +354,6 @@ static const struct ib_device_ops usnic_dev_ops = {
 	.modify_qp = usnic_ib_modify_qp,
 	.query_device = usnic_ib_query_device,
 	.query_gid = usnic_ib_query_gid,
-	.query_pkey = usnic_ib_query_pkey,
 	.query_port = usnic_ib_query_port,
 	.query_qp = usnic_ib_query_qp,
 	.reg_user_mr = usnic_ib_reg_mr,
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index b8a77ce11590..02a49f661c8d 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -367,7 +367,6 @@ int usnic_ib_query_port(struct ib_device *ibdev, u8 port,
 
 	props->port_cap_flags = 0;
 	props->gid_tbl_len = 1;
-	props->pkey_tbl_len = 1;
 	props->bad_pkey_cntr = 0;
 	props->qkey_viol_cntr = 0;
 	props->max_mtu = IB_MTU_4096;
@@ -437,16 +436,6 @@ int usnic_ib_query_gid(struct ib_device *ibdev, u8 port, int index,
 	return 0;
 }
 
-int usnic_ib_query_pkey(struct ib_device *ibdev, u8 port, u16 index,
-				u16 *pkey)
-{
-	if (index > 0)
-		return -EINVAL;
-
-	*pkey = 0xffff;
-	return 0;
-}
-
 int usnic_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct usnic_ib_pd *pd = to_upd(ibpd);
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.h b/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
index 2aedf78c13cf..9195f2b901ce 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
@@ -48,8 +48,6 @@ int usnic_ib_query_qp(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
 				struct ib_qp_init_attr *qp_init_attr);
 int usnic_ib_query_gid(struct ib_device *ibdev, u8 port, int index,
 				union ib_gid *gid);
-int usnic_ib_query_pkey(struct ib_device *ibdev, u8 port, u16 index,
-				u16 *pkey);
 int usnic_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
 void usnic_ib_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);
 struct ib_qp *usnic_ib_create_qp(struct ib_pd *pd,
-- 
2.26.2

