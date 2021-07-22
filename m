Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376393D2F0A
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jul 2021 23:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhGVUnH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jul 2021 16:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhGVUnG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Jul 2021 16:43:06 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE13C06175F
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jul 2021 14:23:39 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id u15so8139678oiw.3
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jul 2021 14:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f0Y/ocDdRQ4XTDM8mFWl3U3xVeDb3pxbEATe5M1rfu8=;
        b=b529q1f30oQMbBHGwnh7geMM9z5tDzEEBrh0lSkOAl+AzCFLbrvNrduIdTCMm1U5Ve
         h3YfyBjpOa+D+hiLzB1EkNQY5ba3KcAIfElwSNu/4NXsTTmIjszq7F2Bt9FRRgFbepCf
         VxliCrBt1sG5VeeV7pOh9UmhD3I6PTFaG9EkJXpPdCVWonAREaG7BtBWfJWc2qf/2Vu8
         g9333MJZs2VRuTnEZJYfAMDmNk6MLNdopLGmJoW4iauV9WXQsDd1xHnlHn98Q58Gmwyc
         +rx3sMpycuP2LZm5TlwinEbtJmIE5UzuVoiu3MPY9cC0KGgMz6leLwT88vLL2GLKmngt
         PPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f0Y/ocDdRQ4XTDM8mFWl3U3xVeDb3pxbEATe5M1rfu8=;
        b=H1g0NCCkQUgeJs25rlVSiRkMq2L25bblVJ3EhbnpgmWqt/wyFkD2/duJuxkccbqt/3
         TRdEem/ss3M0pgPirdVL4xdCc0GGmwzlBFis2eWa89WZ9xDxHcudrIT/1eoXnF3yr134
         dVNxBo/ZRhHMbtsc0E/vuTxmxIlXQFAGS2BYr0ihRCyBKaRG6vVoQAO/XOE9n7b9jfdY
         IVtjtnwNAEqLZN7f/zGphWhHASxW/xbiBYj6cJeh7WpMX+PEdSVbJvHLnSqcW2tWWnSc
         fwUFB0Zt+zBSFTOKgf6C7wFqdLjRCoHdFzBoIprv+SxiuFhrhQGMbp4i/OgdosILso1g
         FlVg==
X-Gm-Message-State: AOAM531apclRy/efBWFt0S3U37H8pDquqfkrmwEIuJqyLIlhQYxOnwZ0
        JnHkO+ebq94bpWoRsposCLo=
X-Google-Smtp-Source: ABdhPJwU+r5d48mdjXECIpXYoZfb4xHgcEaMqaR7age4NZ0Jc8KInzp/C5nxCosN4hJzC/0KU44a1w==
X-Received: by 2002:a05:6808:2015:: with SMTP id q21mr1285464oiw.52.1626989019145;
        Thu, 22 Jul 2021 14:23:39 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-d50d-298a-08dc-a5ed.res6.spectrum.com. [2603:8081:140c:1a00:d50d:298a:8dc:a5ed])
        by smtp.gmail.com with ESMTPSA id s19sm1105787ooj.7.2021.07.22.14.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:23:38 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v3 2/6] RDMA/rxe: Change AH objects to indexed
Date:   Thu, 22 Jul 2021 16:22:41 -0500
Message-Id: <20210722212244.412157-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210722212244.412157-1-rpearsonhpe@gmail.com>
References: <20210722212244.412157-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make changes to rxe_param.h and rxe_pool.c to allow indexing of AH
objects. Valid indices are non-zero so older providers can be detected.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h | 4 +++-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 742e6ec93686..ec5c6331bee8 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -67,7 +67,9 @@ enum rxe_device_param {
 	RXE_MAX_MCAST_GRP		= 8192,
 	RXE_MAX_MCAST_QP_ATTACH		= 56,
 	RXE_MAX_TOT_MCAST_QP_ATTACH	= 0x70000,
-	RXE_MAX_AH			= 100,
+	RXE_MAX_AH			= 16383,
+	RXE_MIN_AH_INDEX		= 1,
+	RXE_MAX_AH_INDEX		= 16383,
 	RXE_MAX_SRQ_WR			= 0x4000,
 	RXE_MIN_SRQ_WR			= 1,
 	RXE_MAX_SRQ_SGE			= 27,
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 0b8e7c6255a2..342f090152d1 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -26,7 +26,9 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.name		= "rxe-ah",
 		.size		= sizeof(struct rxe_ah),
 		.elem_offset	= offsetof(struct rxe_ah, pelem),
-		.flags		= RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
+		.min_index	= RXE_MIN_AH_INDEX,
+		.max_index	= RXE_MAX_AH_INDEX,
 	},
 	[RXE_TYPE_SRQ] = {
 		.name		= "rxe-srq",
-- 
2.30.2

