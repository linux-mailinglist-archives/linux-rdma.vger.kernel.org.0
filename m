Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0D041D260
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 06:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347928AbhI3E26 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 00:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347733AbhI3E24 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 00:28:56 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F203FC06176A
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 21:27:14 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id d12-20020a05683025cc00b0054d8486c6b8so5770968otu.0
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 21:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pcxAdiImyK4B9yAh9TbVrtYx8EXTONj/TcOyvXcVc/w=;
        b=Ix9Nhru8lqlhBJ8TTPpbX/vX6ah0Hf257E5Jf1ZHm9M048BwjqMM5Gz7z7gb/TSPzh
         xN6dHALQzGB5/t29toP8dmTe9FjHgX2PB8vpiPCyp5EvHlMRgCQgR/aiJhQ9XiXTN6d9
         WAs3s/niQj5U6mVklGBsraxQYex+w/p/xc8XNwIYhWGO4CSh7mypgaH7NZXGzSABf44I
         DXGbUfhuTsRMg4sFZKTO2P/vg/xGMGTVOQI59b/eaZuI6bCE7qXh5zGKf3jLusk04YYh
         NHaG3nwm9DRmi+QfV5tWmpex9byqSQN1km3TUfvrQ5nDdPTYeFcBQcmeYynX0b1TZtgF
         I2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pcxAdiImyK4B9yAh9TbVrtYx8EXTONj/TcOyvXcVc/w=;
        b=xosNje1AgCZ7nA/1t/XFbtXp44dsv4RajF4AvwVFXKgaJ4OUiy4Nmsvdf+yXC9akxO
         HqoUbuqArWfRJl/jBVSd+lBbIhqp6YQKlmujiKuvaDak756wIysPkVkExOiFOcX8tYdQ
         NVPMhd9lDPvmN6xzI3Q7hJv5nzNDBsIxg4Qff6o+uFzxRL9EU+H1ojLp5r+Jk6PvH11M
         VQXda9HrxMstGSWxJKgT/lGFaaDK7NF1mgSyOzV6dGu2qUiUOWHm/isjzBTOd7M4c7ey
         GnCmhOR+vD83gHkc9jtwDSbFBd5KkMmwqlVWibuOg8+LF5RVi0ayC2deDZFYK8dL/Rpz
         ZCmA==
X-Gm-Message-State: AOAM5304XgspI6KanYSZJ0WnpvteNL6tCEGrJR4Aiq/Xdyrzx3UfWfkR
        1HeV2UDcoS7jBu8WWiDsjpHzQ2UGUYw1tA==
X-Google-Smtp-Source: ABdhPJyo991Zf0glgxtdBGq0KQdxiVjIQ/ilnN8lZ8R606ZeYqgr1wC9whqf71ckD0M5o7Thj0gZUA==
X-Received: by 2002:a05:6830:112:: with SMTP id i18mr3227513otp.186.1632976034415;
        Wed, 29 Sep 2021 21:27:14 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-48b3-0edc-a395-cab0.res6.spectrum.com. [2603:8081:140c:1a00:48b3:edc:a395:cab0])
        by smtp.gmail.com with ESMTPSA id a23sm373661otp.44.2021.09.29.21.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 21:27:14 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 1/6] RDMA/rxe: Move AV from rxe_send_wqe to rxe_send_wr
Date:   Wed, 29 Sep 2021 23:25:59 -0500
Message-Id: <20210930042603.4318-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210930042603.4318-1-rpearsonhpe@gmail.com>
References: <20210930042603.4318-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Move the struct rxe_av av from struct rxe_send_wqe to struct rxe_send_wr
placing it in wr.ud at the same offset as it was previously. This has the
effect of increasing the size of struct rxe_send_wr while keeping the size of
struct rxe_send_wqe the same. This better reflects the use of this field
which is only used for UD sends. This change has no effect on ABI
compatibility so the modified rxe driver will operate with older versions
of rdma-core.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_av.c    | 2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 3 ++-
 include/uapi/rdma/rdma_user_rxe.h     | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
index da2e867a1ed9..85580ea5eed0 100644
--- a/drivers/infiniband/sw/rxe/rxe_av.c
+++ b/drivers/infiniband/sw/rxe/rxe_av.c
@@ -107,5 +107,5 @@ struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt)
 	if (qp_type(pkt->qp) == IB_QPT_RC || qp_type(pkt->qp) == IB_QPT_UC)
 		return &pkt->qp->pri_av;
 
-	return (pkt->wqe) ? &pkt->wqe->av : NULL;
+	return (pkt->wqe) ? &pkt->wqe->wr.wr.ud.av : NULL;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 9d0bb9aa7514..c09e1c25ce66 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -584,7 +584,8 @@ static void init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	if (qp_type(qp) == IB_QPT_UD ||
 	    qp_type(qp) == IB_QPT_SMI ||
 	    qp_type(qp) == IB_QPT_GSI)
-		memcpy(&wqe->av, &to_rah(ud_wr(ibwr)->ah)->av, sizeof(wqe->av));
+		memcpy(&wqe->wr.wr.ud.av, &to_rah(ud_wr(ibwr)->ah)->av,
+		       sizeof(struct rxe_av));
 
 	if (unlikely(ibwr->send_flags & IB_SEND_INLINE))
 		copy_inline_data_to_wqe(wqe, ibwr);
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index e283c2220aba..2f1ebbe96434 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -98,6 +98,9 @@ struct rxe_send_wr {
 			__u32	remote_qpn;
 			__u32	remote_qkey;
 			__u16	pkey_index;
+			__u16	reserved;
+			__u32	pad[5];
+			struct rxe_av av;
 		} ud;
 		struct {
 			__aligned_u64	addr;
@@ -148,7 +151,6 @@ struct rxe_dma_info {
 
 struct rxe_send_wqe {
 	struct rxe_send_wr	wr;
-	struct rxe_av		av;
 	__u32			status;
 	__u32			state;
 	__aligned_u64		iova;
-- 
2.30.2

