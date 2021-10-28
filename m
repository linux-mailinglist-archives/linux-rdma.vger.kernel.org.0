Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2EFB43DDF3
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Oct 2021 11:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhJ1JrH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Oct 2021 05:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhJ1JrC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Oct 2021 05:47:02 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399FDC061570
        for <linux-rdma@vger.kernel.org>; Thu, 28 Oct 2021 02:44:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d3so9050643wrh.8
        for <linux-rdma@vger.kernel.org>; Thu, 28 Oct 2021 02:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dvwH5ntIH8CiQNhQBiTH6FHEzYc4ratCtQn1TnOScHk=;
        b=G4hg0yu7rY11qCoNM+9jlgVhT2xUT5DcxuIHJk6WFL5/hqsRRS9qHBnze34sCCfZZA
         kVQQljKqSM6dkfUk9gzMdAvQ3+ENQUzCvaQUoWq0JMcnrcy4TUGHBgprX+iRWHLw5iA0
         zpnvg4p4nfhIIy9AnT6mTp7SnEG/G5udmE1PWs3ENscSwTotlv4vFArfBHOpDmsywblS
         P7K+kgnxNCFpefqZv56Pv55T5HR1FmBmg0Lb2K5oBbfkbJTZiTMR/O0QKnEW9WJy0Qkc
         b9a0xefTh0oVrzHf7MbhS0wM+5PC4fsQw39x6rzy5uHPA8SvZn90W5MTEYvScPxT8oTk
         tl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dvwH5ntIH8CiQNhQBiTH6FHEzYc4ratCtQn1TnOScHk=;
        b=gYTsmYeuXlt4BGB/qzYR9zOP2wVZVFcKf94Q6OszPgnl7F8iFED2h/U91veSvChIfs
         QyQkUL4MfXFOolYNGiPSd5y6KU1c6hGFN+yehxSkoAWLjCKrfBUOATQ2xTASmtGRLpCc
         3sJOg8dMbjDjizwMfGNaaaLtPoAz3W1B8JjS/2NiuSwPmZqX2S/AcajXsgeWL/P0K4VA
         evfSJHkUnBETdNR1KaY/uK5GfprYxZaUjwgUbrEDJl/A2xL0quBv55iV6Q0eizNJMK9P
         3dICv+kfS9kalgG4uvFCNOuJyLceQHrwUDCogVgKnjnaDqnENWM3v/MhmSVSH6P9gcpZ
         EN1w==
X-Gm-Message-State: AOAM533w0ra9Q+iy35Yi/pMqGZLD2ePhEBA8a2nit4N2qbIHQhdPRJAj
        A7KoW9DV+bEgckXLkibsglgsuRxWXhmkDw==
X-Google-Smtp-Source: ABdhPJxTkYoaiF6It9MF7DZqTd1W4NRmU9l6Y6vblda3ZS4cMRG6loW3UH7I7bYiLdBH97xRQJbfIQ==
X-Received: by 2002:a05:6000:168d:: with SMTP id y13mr4330951wrd.300.1635414273614;
        Thu, 28 Oct 2021 02:44:33 -0700 (PDT)
Received: from fedora.redhat.com ([2a00:a040:19b:e02f::1003])
        by smtp.gmail.com with ESMTPSA id p21sm2058659wmc.11.2021.10.28.02.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 02:44:33 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/bnxt_re: Use helper function to set GUIDs
Date:   Thu, 28 Oct 2021 12:43:59 +0300
Message-Id: <20211028094359.160407-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use addrconf_addr_eui48() helper function to set the GUIDs and remove
the driver specific version.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  5 +++--
 drivers/infiniband/hw/bnxt_re/main.c      |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 17 -----------------
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  1 -
 4 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 67ca794f64e8..d5f347f8d088 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -41,6 +41,7 @@
 #include <linux/pci.h>
 #include <linux/netdevice.h>
 #include <linux/if_ether.h>
+#include <net/addrconf.h>
 
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_user_verbs.h>
@@ -130,8 +131,8 @@ int bnxt_re_query_device(struct ib_device *ibdev,
 	memcpy(&ib_attr->fw_ver, dev_attr->fw_ver,
 	       min(sizeof(dev_attr->fw_ver),
 		   sizeof(ib_attr->fw_ver)));
-	bnxt_qplib_get_guid(rdev->netdev->dev_addr,
-			    (u8 *)&ib_attr->sys_image_guid);
+	addrconf_addr_eui48((u8 *)&ib_attr->sys_image_guid,
+			    rdev->netdev->dev_addr);
 	ib_attr->max_mr_size = BNXT_RE_MAX_MR_SIZE;
 	ib_attr->page_size_cap = BNXT_RE_PAGE_SIZE_SUPPORTED;
 
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 4fa3b14b2613..83c0748e092d 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -730,7 +730,7 @@ static int bnxt_re_register_ib(struct bnxt_re_dev *rdev)
 		strlen(BNXT_RE_DESC) + 5);
 	ibdev->phys_port_cnt = 1;
 
-	bnxt_qplib_get_guid(rdev->netdev->dev_addr, (u8 *)&ibdev->node_guid);
+	addrconf_addr_eui48((u8 *)&ibdev->node_guid, rdev->netdev->dev_addr);
 
 	ibdev->num_comp_vectors	= rdev->num_msix - 1;
 	ibdev->dev.parent = &rdev->en_dev->pdev->dev;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index a1d8a87dc678..bc1ba4b51ba4 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -572,23 +572,6 @@ int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res,
 	return rc;
 }
 
-/* GUID */
-void bnxt_qplib_get_guid(const u8 *dev_addr, u8 *guid)
-{
-	u8 mac[ETH_ALEN];
-
-	/* MAC-48 to EUI-64 mapping */
-	memcpy(mac, dev_addr, ETH_ALEN);
-	guid[0] = mac[0] ^ 2;
-	guid[1] = mac[1];
-	guid[2] = mac[2];
-	guid[3] = 0xff;
-	guid[4] = 0xfe;
-	guid[5] = mac[3];
-	guid[6] = mac[4];
-	guid[7] = mac[5];
-}
-
 static void bnxt_qplib_free_sgid_tbl(struct bnxt_qplib_res *res,
 				     struct bnxt_qplib_sgid_tbl *sgid_tbl)
 {
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index d2951a713cc8..e1411a2352a7 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -346,7 +346,6 @@ void bnxt_qplib_free_hwq(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_hwq *hwq);
 int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
 			      struct bnxt_qplib_hwq_attr *hwq_attr);
-void bnxt_qplib_get_guid(const u8 *dev_addr, u8 *guid);
 int bnxt_qplib_alloc_pd(struct bnxt_qplib_pd_tbl *pd_tbl,
 			struct bnxt_qplib_pd *pd);
 int bnxt_qplib_dealloc_pd(struct bnxt_qplib_res *res,
-- 
2.31.1

