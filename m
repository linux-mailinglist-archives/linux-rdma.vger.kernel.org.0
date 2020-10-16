Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCF0290D1F
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 23:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410941AbgJPVOE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 17:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410923AbgJPVOE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Oct 2020 17:14:04 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4753C061755
        for <linux-rdma@vger.kernel.org>; Fri, 16 Oct 2020 14:14:03 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w204so4060827oiw.1
        for <linux-rdma@vger.kernel.org>; Fri, 16 Oct 2020 14:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=edXgjKep23ZEtADiHnrWfcrpJxhzZwGHPRTxqCgBpl4=;
        b=JZz1s451i9/xvxUtzDxcwANaFPj8jXWXnBNObBi8k5PaAJpwf6hg8A6jNjrjTRCwfx
         nDRK9iUYIlJa8f1buXP6ctWQkr4AcqrJZYwkqIky2VpyN1QTbIT9RKFKOJzlTJM7UpqD
         Q0dWxm6f4OyybGgMpjLICOsfQT2bBJ+fTYXQNWfiQhFK476U00LuaztjF9tAD+FtpAmn
         ae+pv4LW+oRLPvfuOEjxxCzCHNcvk/cp6XAZ8n1M9+qax91nG+7h+knCYAsvioryIcLV
         uzKwfel3IIzFeSebn8oPbJSFlzwR+CJ/VPgfN+e9Xse9qh3v2TVJH0vAK/tuRhbrfG+S
         m7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=edXgjKep23ZEtADiHnrWfcrpJxhzZwGHPRTxqCgBpl4=;
        b=s3HeE5gMr1+T3nIX9uHQ8gS6VFU6tRA2xHdb1ooHVxA+RTrrI7DWlXfbBWnEBBqyyC
         scnxm4PD5eUysRHvm/FFmGMC4XlGWLEz9FTZIUxL/vriCk6rXsPbQh7UqidML+BRD19B
         5xg312Zem2dixzSB91aXmIqpsctB0Y8DUIUrPv8AHHe0jo7RSEfR0yVrK45nZVVHO3N4
         Iq8m9dAoH2hFXtTeBXhLpvo8qnFmo3B4AxdWu0IDwV2V0hP/NG8LDi+OOmE3w0XtXnEm
         wbwaXLPlxTiGFRQn6gR7UYb8vGnSPzf+8KHb3x2tBZ8dC70R8a5HwQ0umVq8E5Cvni+A
         cEqQ==
X-Gm-Message-State: AOAM532ZigHR11WGvKOoMPvvBMpEHkuTRj4/mpVs/AkUki/G2hHhh9Lr
        hHqUkLFe9FrfRbyOnSPT0ek=
X-Google-Smtp-Source: ABdhPJxKqhfvy58rLnzH6tXP36SySoEDdG5bzBVMsSAyA8lOdKCBTDQ98wdNjdREsV6lrmT/OCXS7g==
X-Received: by 2002:aca:5151:: with SMTP id f78mr3950550oib.166.1602882843219;
        Fri, 16 Oct 2020 14:14:03 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-3929-4284-f7ac-4bbd.res6.spectrum.com. [2603:8081:140c:1a00:3929:4284:f7ac:4bbd])
        by smtp.gmail.com with ESMTPSA id z126sm1352278oia.57.2020.10.16.14.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 14:14:02 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next] RDMA/rxe: Fix small problem in network_type patch
Date:   Fri, 16 Oct 2020 16:13:44 -0500
Message-Id: <20201016211343.22906-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The patch referenced below has a typo that results in using the wrong
L2 header size for outbound traffic. (V4 <-> V6).

It also breaks RC traffic because they use AVs that use RDMA_NETWORK_XXX
enums instead of RXE_NETWORK_TYPE_XXX enums. Fix this by transcoding
between these enum types.

Fixes: e0d696d201dd ("RDMA/rxe: Move the definitions for rxe_av.network_type to uAPI")
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_av.c  | 35 +++++++++++++++++++++++++----
 drivers/infiniband/sw/rxe/rxe_net.c |  2 +-
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
index 38021e2c8688..df0d173d6acb 100644
--- a/drivers/infiniband/sw/rxe/rxe_av.c
+++ b/drivers/infiniband/sw/rxe/rxe_av.c
@@ -16,15 +16,24 @@ void rxe_init_av(struct rdma_ah_attr *attr, struct rxe_av *av)
 
 int rxe_av_chk_attr(struct rxe_dev *rxe, struct rdma_ah_attr *attr)
 {
+	const struct ib_global_route *grh = rdma_ah_read_grh(attr);
 	struct rxe_port *port;
+	int type;
 
 	port = &rxe->port;
 
 	if (rdma_ah_get_ah_flags(attr) & IB_AH_GRH) {
-		u8 sgid_index = rdma_ah_read_grh(attr)->sgid_index;
+		if (grh->sgid_index > port->attr.gid_tbl_len) {
+			pr_warn("invalid sgid index = %d\n",
+					grh->sgid_index);
+			return -EINVAL;
+		}
 
-		if (sgid_index > port->attr.gid_tbl_len) {
-			pr_warn("invalid sgid index = %d\n", sgid_index);
+		type = rdma_gid_attr_network_type(grh->sgid_attr);
+		if (type < RDMA_NETWORK_IPV4 ||
+		    type > RDMA_NETWORK_IPV6) {
+			pr_warn("invalid network type for rdma_rxe = %d\n",
+					type);
 			return -EINVAL;
 		}
 	}
@@ -65,11 +74,29 @@ void rxe_av_to_attr(struct rxe_av *av, struct rdma_ah_attr *attr)
 void rxe_av_fill_ip_info(struct rxe_av *av, struct rdma_ah_attr *attr)
 {
 	const struct ib_gid_attr *sgid_attr = attr->grh.sgid_attr;
+	int ibtype;
+	int type;
 
 	rdma_gid2ip((struct sockaddr *)&av->sgid_addr, &sgid_attr->gid);
 	rdma_gid2ip((struct sockaddr *)&av->dgid_addr,
 		    &rdma_ah_read_grh(attr)->dgid);
-	av->network_type = rdma_gid_attr_network_type(sgid_attr);
+
+	ibtype = rdma_gid_attr_network_type(sgid_attr);
+
+	switch (ibtype) {
+	case RDMA_NETWORK_IPV4:
+		type = RXE_NETWORK_TYPE_IPV4;
+		break;
+	case RDMA_NETWORK_IPV6:
+		type = RXE_NETWORK_TYPE_IPV4;
+		break;
+	default:
+		/* not reached - checked in rxe_av_chk_attr */
+		type = 0;
+		break;
+	}
+
+	av->network_type = type;
 }
 
 struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt)
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 575e1a4ec821..34bef7d8e6b4 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -442,7 +442,7 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 	if (IS_ERR(attr))
 		return NULL;
 
-	if (av->network_type == RXE_NETWORK_TYPE_IPV6)
+	if (av->network_type == RXE_NETWORK_TYPE_IPV4)
 		hdr_len = ETH_HLEN + sizeof(struct udphdr) +
 			sizeof(struct iphdr);
 	else
-- 
2.25.1

