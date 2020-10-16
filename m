Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B27290D42
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 23:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410826AbgJPV0X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 17:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390191AbgJPV0S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Oct 2020 17:26:18 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019FDC061755
        for <linux-rdma@vger.kernel.org>; Fri, 16 Oct 2020 14:26:17 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id d28so3874569ote.1
        for <linux-rdma@vger.kernel.org>; Fri, 16 Oct 2020 14:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7dB9OrLiq4gFDSfJkPlzzTn99yl56iJZq6ENHlLwu8M=;
        b=QhsgbpzP01qLX4oJAl02itYYqqAXSp6QLTDXYF59eKqHEMESSebYffDT4qZ9Uc71j4
         F9ZbRmD429h4cvG1wEyYFH0v7kgFRSAGhnwT6nastWQb6J4+J1pyytrcIYja3QjV2fOI
         +YIW/6+fli5VRbgubrhOxFZocq0m8qgAeB1RWIecueNC9XxAvkMFBAxHRZvT4HO2IiYi
         WulTBlRGOJLQJ74ISEXXDVNz22az9oiZsQYTJceDhlE/MeF+7AjWv2czxRBrRdAzbxDi
         gEpj/spLYDvsfriXDAyn3jxf4BXBDDTp/lv/+KvNssKxLYsPiEn0qS2KRl9oe9w04QTh
         MORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7dB9OrLiq4gFDSfJkPlzzTn99yl56iJZq6ENHlLwu8M=;
        b=OQyKgEplX5Q6nY9ElIYEQ2ZhunkPxKtItdUxDaaEY11JAA0Y+nDqEFmoQpd9k+FXL8
         66E21sh8fPYoKeUGKK8dMcr9WLBQu29/51DShnRt4wqpkgtwYIKfU7q1IFWb4s6GZJq3
         V5rn0lIoyGlQ9p0M1CKSepBxM2o7VsyRM+Bwrb/Gr3ByrgLQUK6KrnxIWjBBkwUoVxVb
         1N3snPywVnv1zastYbpnslxMs5tKg8fmz/5D//oiyQOOKcb/4b1UMrLExGtS8jnEsvSD
         c97fOraU1pj6kzGaNOp8aPyHu56QERhyibK5H/PmuS/BhFV2LELlO1Fq/0xjFsQ1ptxr
         SiGQ==
X-Gm-Message-State: AOAM5306C9VoLLem2LpvX77a3aTkTng3wOEc2DmKW9Gswsxfx32Nr5nv
        a8LuQXhcHkFjOdWeTE9r8dE=
X-Google-Smtp-Source: ABdhPJyo/7OsYPjTDNY3miYRcs04+E++45s2gHESVq44TTMuugeOhKqDS4ZmldjcGGCThy/3L27OoA==
X-Received: by 2002:a05:6830:94:: with SMTP id a20mr3901112oto.366.1602883576451;
        Fri, 16 Oct 2020 14:26:16 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-3929-4284-f7ac-4bbd.res6.spectrum.com. [2603:8081:140c:1a00:3929:4284:f7ac:4bbd])
        by smtp.gmail.com with ESMTPSA id x194sm586633oia.8.2020.10.16.14.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 14:26:16 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next] provider/rxe: Support UD network_type patch
Date:   Fri, 16 Oct 2020 16:25:00 -0500
Message-Id: <20201016212459.23140-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The patch referenced below changed the type of the enum to be returned in
send WQEs to the kernel. This patch makes the corresponding change to the
rxe provider. Without this change the driver is not functional.

Reference: e0d696d201dd ("RDMA/rxe: Move the definitions for rxe_av.network_type to uAPI")
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 kernel-headers/rdma/rdma_user_rxe.h | 6 ++++++
 providers/rxe/rxe.c                 | 2 +-
 providers/rxe/rxe.h                 | 6 ------
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel-headers/rdma/rdma_user_rxe.h b/kernel-headers/rdma/rdma_user_rxe.h
index d8f2e0e4..e591d8c1 100644
--- a/kernel-headers/rdma/rdma_user_rxe.h
+++ b/kernel-headers/rdma/rdma_user_rxe.h
@@ -39,6 +39,11 @@
 #include <linux/in.h>
 #include <linux/in6.h>
 
+enum {
+	RXE_NETWORK_TYPE_IPV4 = 1,
+	RXE_NETWORK_TYPE_IPV6 = 2,
+};
+
 union rxe_gid {
 	__u8	raw[16];
 	struct {
@@ -57,6 +62,7 @@ struct rxe_global_route {
 
 struct rxe_av {
 	__u8			port_num;
+	/* From RXE_NETWORK_TYPE_* */
 	__u8			network_type;
 	__u8			dmac[6];
 	struct rxe_global_route	grh;
diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 3af58bfb..f270d410 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -801,7 +801,7 @@ static struct ibv_ah *rxe_create_ah(struct ibv_pd *pd, struct ibv_ah_attr *attr)
 	memcpy(&av->grh, &attr->grh, sizeof(attr->grh));
 	av->network_type =
 		ipv6_addr_v4mapped((struct in6_addr *)attr->grh.dgid.raw) ?
-		RDMA_NETWORK_IPV4 : RDMA_NETWORK_IPV6;
+		RXE_NETWORK_TYPE_IPV4 : RXE_NETWORK_TYPE_IPV6;
 
 	rdma_gid2ip(&av->sgid_addr, &sgid);
 	rdma_gid2ip(&av->dgid_addr, &attr->grh.dgid);
diff --git a/providers/rxe/rxe.h b/providers/rxe/rxe.h
index 96f4ee9c..628adf21 100644
--- a/providers/rxe/rxe.h
+++ b/providers/rxe/rxe.h
@@ -42,12 +42,6 @@
 #include <rdma/rdma_user_rxe.h> /* struct rxe_av */
 #include "rxe-abi.h"
 
-enum rdma_network_type {
-	RDMA_NETWORK_IB,
-	RDMA_NETWORK_IPV4,
-	RDMA_NETWORK_IPV6
-};
-
 struct rxe_device {
 	struct verbs_device	ibv_dev;
 	int	abi_version;
-- 
2.25.1

