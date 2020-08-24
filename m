Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D559625073A
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 20:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHXSPD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 14:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgHXSPC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 14:15:02 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CED3C061573
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 11:15:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 17so5246269pfw.9
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 11:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YHfpMtSx+L+zcH4FDEMobBUGqWDjaPP7cyfAZoMjUIk=;
        b=T0S5CDG1jkGs/wznwRawhONxI+Z+LSllJVV0bgrX7gHOiYlWxjZ0s1eojrlOzltWwF
         +AISJpFVKOjWJu9/Ob64yvXNhjjBo5ZIw0Z+cSPv3+PghdrvVAMjTg2WmXDrH0iivZHr
         Ex8Sv8s262f/VhO37J6/Dtisu830LBHopx+qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YHfpMtSx+L+zcH4FDEMobBUGqWDjaPP7cyfAZoMjUIk=;
        b=qer+yLyxtJ5KIBfbatffJwReRAdmi3kGPhOhMtOGR+fFbb6Do47H0xmhJZrSPStg+5
         thdfM0STBLFeor62VcJoledxccuhIOJbm+u2eN8heRl8Ru0OnFQpRDR+VbLSOuuyxwxF
         DSRizg1w+F8o/xXBGFyuMBchWLrx8VP5HfATctKqH2yxCytpdZHE/V2G2Z4/c9VXPIsH
         zSmVL73Ci+MWm30QBxRgz384RG8Gcw7g7eIyxAm8f2lqrDNUYmSdOeCC/MySNml28NWb
         UHXkI/rOCG9PHZFj8Jn8hqUIG4NdnyZWkIMi1cwLVxmuw4JF3yKx+13IjNyXtTk4B13b
         Zdfg==
X-Gm-Message-State: AOAM530Zg+jWvbPQMA2pYE/w3qEcIMonv+SfHm8AAZNbEif+5JtDNsE2
        iGb6Fw3bv4d0yt84du20r1i4SQ==
X-Google-Smtp-Source: ABdhPJyRvVjjUSSStMM4t2ACPrsWvC22qRWXrtx7sktiexVCusZKeqASb+YwliKh+gDdx+i2+e2EkQ==
X-Received: by 2002:a63:4451:: with SMTP id t17mr3545197pgk.92.1598292901669;
        Mon, 24 Aug 2020 11:15:01 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q5sm5027811pfu.16.2020.08.24.11.14.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 11:15:00 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc 5/6] RDMA/bnxt_re: Restrict the max_gids to 256
Date:   Mon, 24 Aug 2020 11:14:35 -0700
Message-Id: <1598292876-26529-6-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1598292876-26529-1-git-send-email-selvin.xavier@broadcom.com>
References: <1598292876-26529-1-git-send-email-selvin.xavier@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>

Some adapters report more than 256 gid entries.
Restrict it to 256 for now.

Fixes: 1ac5a4047975("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 2 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 4cd475e..64d44f5 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -149,7 +149,7 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 	attr->max_inline_data = le32_to_cpu(sb->max_inline_data);
 	attr->l2_db_size = (sb->l2_db_space_size + 1) *
 			    (0x01 << RCFW_DBR_BASE_PAGE_SHIFT);
-	attr->max_sgid = le32_to_cpu(sb->max_gid);
+	attr->max_sgid = BNXT_QPLIB_NUM_GIDS_SUPPORTED;
 
 	bnxt_qplib_query_version(rcfw, attr->fw_ver);
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index 6404f0d..967890c 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -47,6 +47,7 @@
 struct bnxt_qplib_dev_attr {
 #define FW_VER_ARR_LEN			4
 	u8				fw_ver[FW_VER_ARR_LEN];
+#define BNXT_QPLIB_NUM_GIDS_SUPPORTED	256
 	u16				max_sgid;
 	u16				max_mrw;
 	u32				max_qp;
-- 
2.5.5

