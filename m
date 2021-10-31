Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CD2440FAE
	for <lists+linux-rdma@lfdr.de>; Sun, 31 Oct 2021 18:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhJaRK0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 31 Oct 2021 13:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbhJaRK0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 31 Oct 2021 13:10:26 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52279C061570
        for <linux-rdma@vger.kernel.org>; Sun, 31 Oct 2021 10:07:54 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so4466260wmd.1
        for <linux-rdma@vger.kernel.org>; Sun, 31 Oct 2021 10:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eZxCOZH9qy7rJWJvW/QyLWN9o0syFg2xHBOhupZY3m0=;
        b=o6WCcozdnz8elvmE15n3yRPeHq3FEvsW4vZLDMC5Tpjev0qb/aRG9x9O7qp/dwKvqr
         A9k96UlP5khj6Hp+i9RKlCmU/pk1BkVCRh74RWRfOpnkdecLf6DfPTKOJ/oQEhPLUeIg
         mwQRyvQbhzAfR7zfcKduslsIvDRoAdwHZ1H+LkKJUX3/buGYBJCKhCP6LRZ6gXkRnsF8
         6TmW0DYAJxRo68GC5V7OAoj/QhVasiBmfpUOrzXDXVYAheIY+jZ0GuixY4zWxXJUFBE8
         Bmm9ZBVLntqz6i4hX4JEM1UZTpulR4IU2Xb48hmKBhLvlj8z+ddsi0uvntxlNlzSTy8r
         Mp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eZxCOZH9qy7rJWJvW/QyLWN9o0syFg2xHBOhupZY3m0=;
        b=hyz51+lh38ZXUf4yc1h4jHgfp8fJkGjhi0H60pnI9pN7WjVGmNr94+nok4gS1ob5x9
         /uBkY25fbJzK4qmiAUBTjueX2nc7MA6XMxWnsLiBq7bffH0+77Jo3gqAdrnUB+rOrNL1
         sIDHS70lQTKYavmMtWJiIRqydcnb7OnXSbR05Kd7EuHlLwFaex3n5ci6Zu7nRDPZrPCg
         Ge1ORZ3JYnlfdQRqXFL9BQ/Dknns08qaDXnuem4Iq04aW9vVR8sC6FltYoFmRxN5jsgn
         m1QbbZj/7JdgP8CUs97xuE8FnW5XXWZYU8LKIFN4JFS9qGknXBnQS7gMpOaUcPb6EQ3C
         GdyA==
X-Gm-Message-State: AOAM530lPs/qcyuQ0oQji7tEM4b0CaieOJ3+dsgz6ZUdo3PQBa6vnvcV
        ufM75QqwbUNWWHVBuogsk3TubWMAJqn9Lg==
X-Google-Smtp-Source: ABdhPJzkCHDOSX3WcaKOKqv0guG45BpQT37ZZl24wa9FI5VjEc0W9eW3bFW5MVdepM3SlzkmPnSl/Q==
X-Received: by 2002:a05:600c:4e91:: with SMTP id f17mr25806118wmq.180.1635700072696;
        Sun, 31 Oct 2021 10:07:52 -0700 (PDT)
Received: from fedora.redhat.com ([2a00:a040:19b:e02f::1004])
        by smtp.gmail.com with ESMTPSA id m2sm13708491wml.15.2021.10.31.10.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 10:07:52 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/qed: Use helper function to set GUIDs
Date:   Sun, 31 Oct 2021 19:07:43 +0200
Message-Id: <20211031170743.81755-1-kamalheib1@gmail.com>
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
 drivers/net/ethernet/qlogic/qed/qed_rdma.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.c b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
index 4f4b79250a2b..4af24dc2e82e 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_rdma.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
+#include <net/addrconf.h>
 #include "qed.h"
 #include "qed_cxt.h"
 #include "qed_hsi.h"
@@ -410,18 +411,6 @@ static void qed_rdma_free(struct qed_hwfn *p_hwfn)
 	qed_rdma_resc_free(p_hwfn);
 }
 
-static void qed_rdma_get_guid(struct qed_hwfn *p_hwfn, u8 *guid)
-{
-	guid[0] = p_hwfn->hw_info.hw_mac_addr[0] ^ 2;
-	guid[1] = p_hwfn->hw_info.hw_mac_addr[1];
-	guid[2] = p_hwfn->hw_info.hw_mac_addr[2];
-	guid[3] = 0xff;
-	guid[4] = 0xfe;
-	guid[5] = p_hwfn->hw_info.hw_mac_addr[3];
-	guid[6] = p_hwfn->hw_info.hw_mac_addr[4];
-	guid[7] = p_hwfn->hw_info.hw_mac_addr[5];
-}
-
 static void qed_rdma_init_events(struct qed_hwfn *p_hwfn,
 				 struct qed_rdma_start_in_params *params)
 {
@@ -449,7 +438,9 @@ static void qed_rdma_init_devinfo(struct qed_hwfn *p_hwfn,
 	dev->fw_ver = (FW_MAJOR_VERSION << 24) | (FW_MINOR_VERSION << 16) |
 		      (FW_REVISION_VERSION << 8) | (FW_ENGINEERING_VERSION);
 
-	qed_rdma_get_guid(p_hwfn, (u8 *)&dev->sys_image_guid);
+	addrconf_addr_eui48((u8 *)&dev->sys_image_guid,
+			    p_hwfn->hw_info.hw_mac_addr);
+
 	dev->node_guid = dev->sys_image_guid;
 
 	dev->max_sge = min_t(u32, RDMA_MAX_SGE_PER_SQ_WQE,
-- 
2.31.1

