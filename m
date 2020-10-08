Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D96287CAB
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 21:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgJHT4U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 15:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbgJHT4U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Oct 2020 15:56:20 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D7FC0613D2
        for <linux-rdma@vger.kernel.org>; Thu,  8 Oct 2020 12:56:20 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n61so6708706ota.10
        for <linux-rdma@vger.kernel.org>; Thu, 08 Oct 2020 12:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KdZ3LXYkHbAFMbBCNy5UZBfd554Je2Wzt24fMili7V4=;
        b=hAtkypIf25dV0fNPZ8fJByJ1xJ2X2UQVSJEJ+FLuAruJi4+o/n42wAkejCRHaHLtq7
         T4o5Qo1gLXApVAJVRLOEoELsIN+RDSH0EoHE3eABELTf41uTqMj3GawfErFFss+aiKC7
         YRSmb+SmQm30N6qk7DsrcT8qsfZIuAVFL6gY1z7MnMYaQ7tWZGlmbxadHHvE3Pz+2P3u
         azxUsVKdEO1d5biuUCbNMLIEQmo5CVNgf/mhYM7LVFtbWZ8Aj5FksdSDS3kqRAFy2N84
         IPgA3zagXn4G0ycf7tManap7LFd/dW0WiMQavm9a64/xI6gopWUyg/MFHGcocd639n3O
         mfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KdZ3LXYkHbAFMbBCNy5UZBfd554Je2Wzt24fMili7V4=;
        b=T0mTms7r8c2sebAjX1S9/3/bbjsLaVEi2DobECQH5wVsbt8iboUNRHFkmSPpV90vdD
         0qQ8xSJqNE2+JXsQYjqz8R+slO6G+AJ3p5Q9RMMTlz6pIouC4S67FaPFdiWvG+5tXGrE
         Gfln+M9fUir10QJY6g0gpaYNjD5Q05d0niCTYmGEOrmRmsqTVfB9K12L3G7+O8uv36PR
         gb/uI3V5uzBc7Y/ug8Vf+7bcjsYrvVns0jTbKDKQIHsuRpwtvm4M8EWyNmB8VKBRncNb
         Hhv0Mi7ij2VBC+rNFIc708JMPEo6XH4wyyaqeS3ScULfjNeXNpoeuEOVOaaamu9mjV/F
         WLuQ==
X-Gm-Message-State: AOAM5332OoealeqwBuIF+3GSVDdXtXy1uxDbaVrEYdK25TLIUe6RSNfb
        UlG8r6IEKIyt3M/RBQkxvB8=
X-Google-Smtp-Source: ABdhPJwB26LZdWNmx9jW/p5Je2WkZNW7lbNY9eLdIYQxZK4Lv3hsPPECo0ewTsFqjo0hsVphfMJNwg==
X-Received: by 2002:a05:6830:4b5:: with SMTP id l21mr6644851otd.334.1602186979572;
        Thu, 08 Oct 2020 12:56:19 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:b5fa:2b2f:81e9:e2a0])
        by smtp.gmail.com with ESMTPSA id v11sm4873115otj.73.2020.10.08.12.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 12:56:19 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next] rdma_rxe: fix bug rejecting multicast packets
Date:   Thu,  8 Oct 2020 14:54:13 -0500
Message-Id: <20201008195412.256485-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

  - Fix a bug in rxe_rcv that causes all multicast packets to be
    dropped. Currently rxe_match_dgid is called for each packet
    to verify that the destination IP address matches one of the
    entries in the port source GID table. This is incorrect for
    IP multicast addresses since they do not appear in the GID table.
  - Add code to detect multicast addresses.
  - Change function name to rxe_chk_dgid which is clearer.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
Fixes: 8700e3e7c485 ("Soft RoCE (RXE) - The software RoCE driver")
---
 drivers/infiniband/sw/rxe/rxe_recv.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index a3eed4da1540..a9be4efba5f3 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -280,7 +280,17 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
-static int rxe_match_dgid(struct rxe_dev *rxe, struct sk_buff *skb)
+/**
+ * rxe_chk_dgid - validate destination IP address
+ * @rxe: rxe device that received packet
+ * @skb: the received packet buffer
+ *
+ * Accept any loopback packets
+ * Extract IP address from packet and
+ * Accept if multicast packet
+ * Accept if matches an SGID table entry
+ */
+static int rxe_chk_dgid(struct rxe_dev *rxe, struct sk_buff *skb)
 {
 	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
 	const struct ib_gid_attr *gid_attr;
@@ -298,6 +308,9 @@ static int rxe_match_dgid(struct rxe_dev *rxe, struct sk_buff *skb)
 		pdgid = (union ib_gid *)&ipv6_hdr(skb)->daddr;
 	}
 
+	if (rdma_is_multicast_addr((struct in6_addr *)pdgid))
+		return 0;
+
 	gid_attr = rdma_find_gid_by_port(&rxe->ib_dev, pdgid,
 					 IB_GID_TYPE_ROCE_UDP_ENCAP,
 					 1, skb->dev);
-- 
2.25.1

