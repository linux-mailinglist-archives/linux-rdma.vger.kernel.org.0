Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A55825CDC1
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Sep 2020 00:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgICWlp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 18:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbgICWll (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 18:41:41 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1EFC061245
        for <linux-rdma@vger.kernel.org>; Thu,  3 Sep 2020 15:41:41 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id x19so4776360oix.3
        for <linux-rdma@vger.kernel.org>; Thu, 03 Sep 2020 15:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b9cY45iHvdyAfjfF4P4HqCrxc4jOlagOSab+Wq9z7SE=;
        b=bmC0958O0MYl9tHb6qZo0bq4QYK3X+RAp6qoNA0LneA5M1zqBx0X8KQt451hSdewc9
         JvZuFfkFzF13/KtgZlaJOmWNTWzf9F3nGcXlJdGAoXPGMebFluOpmFldua6JQRntSlXk
         TldrKD4rmKfN+sjPIBayKE7Px2aNVdcXzO9ka4k0GJlh78MiGqtLDPmncdr+76qgJuOq
         nVnwGmV8W/jQqhtB7GKADe/sItOiYSFhauSo+uDF0u5bfMsrNMYxg4e+Kp6yvmbhdgwx
         aePEvI9+IqFT6/oOEaV692HCcKVmDTpvCfuA2f4dPCvluSgNzKRqfYq8e1aDVotrzcSU
         /bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b9cY45iHvdyAfjfF4P4HqCrxc4jOlagOSab+Wq9z7SE=;
        b=QvtDGGoukNMT8A0+wtIpWzS7f3C56HNU1UL0n0erL2vwaQGkUnzfjrhDuFP8ok/EuS
         5d95s6PMzNLfQAzMDBA217MJbmudNgTWi/2x+vh+prqvNdKjzYF5b8kmkbW2rFA0udPY
         fd2Cj2yJ8ZmKjtRr8PjTb70CN75k7SBv90/XFdXPM/gjoDFMbgQ6v+xOsGkNEVsy2qgp
         C/VIuqo3CBM0Bq/9D9VS/TVQsacRTQexN+BPWcWkXPsRLnIq1zTHBvOARe0+witcipyP
         MlceC/UfMPdA3hWnDcCyCPlHesMtXrjHGKUAUqiiksE98VTOyET3vJUNngmjBBt3hJok
         +IXg==
X-Gm-Message-State: AOAM531tt0GstDSW/QFgZ71ubgNzgZvGgqDSDYoTD0dp4N9zXFDxh1my
        +jabwjBywHffe+/uB7Pq7S+VkMufvDUzHg==
X-Google-Smtp-Source: ABdhPJwYBUevMsQYDNnF9Y74UnUW0nArHi3w2G9HGk38aBouCPhv+xUc/h5pvgSBrgSy4i82t5WuXQ==
X-Received: by 2002:aca:db0b:: with SMTP id s11mr3542903oig.161.1599172900847;
        Thu, 03 Sep 2020 15:41:40 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:6a3a:fc5c:851c:306a])
        by smtp.gmail.com with ESMTPSA id q15sm886901ooh.44.2020.09.03.15.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:41:40 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v4 for-next 1/7] ib_user_verbs.h: Added missing WR and WC opcodes
Date:   Thu,  3 Sep 2020 17:40:34 -0500
Message-Id: <20200903224039.437391-2-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903224039.437391-1-rpearson@hpe.com>
References: <20200903224039.437391-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Added work completion opcodes to a new ib_uverbs_wc_opcode enum in
ib_user_verbs.h. This plays the same role as ib_uverbs_wr_opcode
documenting the opcodes in the user space API.

Assigned the IB_WC_XXX opcodes in ib_verbs.h to the IB_UVERBS_WC_XXX
where they are defined. This follows the same pattern as the IB_WR_XXX
opcodes. This fixes an incorrect value for LSO that had crept in but
is not currently being used.

Added a missing IB_WR_BIND_MW opcode in ib_verbs.h.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 include/rdma/ib_verbs.h           | 16 +++++++++-------
 include/uapi/rdma/ib_user_verbs.h | 11 +++++++++++
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index c868609a4ffa..f33318e45523 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -952,13 +952,14 @@ enum ib_wc_status {
 const char *__attribute_const__ ib_wc_status_msg(enum ib_wc_status status);
 
 enum ib_wc_opcode {
-	IB_WC_SEND,
-	IB_WC_RDMA_WRITE,
-	IB_WC_RDMA_READ,
-	IB_WC_COMP_SWAP,
-	IB_WC_FETCH_ADD,
-	IB_WC_LSO,
-	IB_WC_LOCAL_INV,
+	IB_WC_SEND = IB_UVERBS_WC_SEND,
+	IB_WC_RDMA_WRITE = IB_UVERBS_WC_RDMA_WRITE,
+	IB_WC_RDMA_READ = IB_UVERBS_WC_RDMA_READ,
+	IB_WC_COMP_SWAP = IB_UVERBS_WC_COMP_SWAP,
+	IB_WC_FETCH_ADD = IB_UVERBS_WC_FETCH_ADD,
+	IB_WC_BIND_MW = IB_UVERBS_WC_BIND_MW,
+	IB_WC_LOCAL_INV = IB_UVERBS_WC_LOCAL_INV,
+	IB_WC_LSO = IB_UVERBS_WC_TSO,
 	IB_WC_REG_MR,
 	IB_WC_MASKED_COMP_SWAP,
 	IB_WC_MASKED_FETCH_ADD,
@@ -1291,6 +1292,7 @@ enum ib_wr_opcode {
 	IB_WR_RDMA_READ = IB_UVERBS_WR_RDMA_READ,
 	IB_WR_ATOMIC_CMP_AND_SWP = IB_UVERBS_WR_ATOMIC_CMP_AND_SWP,
 	IB_WR_ATOMIC_FETCH_AND_ADD = IB_UVERBS_WR_ATOMIC_FETCH_AND_ADD,
+	IB_WR_BIND_MW = IB_UVERBS_WR_BIND_MW,
 	IB_WR_LSO = IB_UVERBS_WR_TSO,
 	IB_WR_SEND_WITH_INV = IB_UVERBS_WR_SEND_WITH_INV,
 	IB_WR_RDMA_READ_WITH_INV = IB_UVERBS_WR_RDMA_READ_WITH_INV,
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 0474c7400268..456438c18c2c 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -457,6 +457,17 @@ struct ib_uverbs_poll_cq {
 	__u32 ne;
 };
 
+enum ib_uverbs_wc_opcode {
+	IB_UVERBS_WC_SEND = 0,
+	IB_UVERBS_WC_RDMA_WRITE = 1,
+	IB_UVERBS_WC_RDMA_READ = 2,
+	IB_UVERBS_WC_COMP_SWAP = 3,
+	IB_UVERBS_WC_FETCH_ADD = 4,
+	IB_UVERBS_WC_BIND_MW = 5,
+	IB_UVERBS_WC_LOCAL_INV = 6,
+	IB_UVERBS_WC_TSO = 7,
+};
+
 struct ib_uverbs_wc {
 	__aligned_u64 wr_id;
 	__u32 status;
-- 
2.25.1

