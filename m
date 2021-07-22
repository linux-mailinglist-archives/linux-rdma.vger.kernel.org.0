Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EAE3D2F09
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jul 2021 23:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhGVUnF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jul 2021 16:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhGVUnE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Jul 2021 16:43:04 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D70DC061757
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jul 2021 14:23:39 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u11so8153130oiv.1
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jul 2021 14:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v3nSwBWyPfbr1tgRxF/E5AHscIsy+xBM+wai75Yl1DM=;
        b=tQ8X2A56YdJGFwEBfpbCICRcmGuxJGSV5K1GLsk5V+ijmDP84KrIzhXu0nCyalzslc
         ZTPkR6vLHcEaLA80N6gfH3Fx73wLyC6WC30FEt/ks/2Yt7seWB+7VMqgw8PElnZl8JnK
         0NVBU2jVS8MgvLt5C7P7ty83VgWY21ZenIbVmVEprcn8kbF8kKhkwutPukqdLfuXNqyJ
         rAKkx7mma9AJh9wBzlMMtoxJvqxqWxfJNGts4nqCUhBPMcJniw3ac0jeIgUHiCl5zOgV
         j8DkBKLx4JQeaFzj9ubJwm6m4nK5tDSB9lYbWLz5RUWXpkRPBpZU/PEvc1f1y7+34Jn7
         9bqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3nSwBWyPfbr1tgRxF/E5AHscIsy+xBM+wai75Yl1DM=;
        b=s755oXOwi2JlHLPRFTJLrzGd+1i/V/fkKYWnhCHpCYyMFb2K/gt0P2pmeh7WqcX7o4
         Aukozm16N6q5ec5pOHgG6ZlqGA7u1YeCva1osdKLT4O7ThK2BBHe/Uv6QhQfpUDamWgw
         ZqDzO5e+toFfWyVfAoi7TGP6OwlFQfwRPdp3YX4vu1LcmPXayMe6XmjamA3LMZ6inI69
         Y2u1OrlVza3QXz7FzGM/q/cULJx4/FcZwoZXgKMj4gdQkTr6v68enpkrDeEVMMjvLaBW
         nWyLWOmAnAVZweoifB1RKiTs0JnS9JOyVE47qAmo7LJXp2RibvkDUYxyy0IfED4RdJqI
         2XHA==
X-Gm-Message-State: AOAM530jlxaYaJosAPGwuiQpvcS5fyuIOoNZmotVdZzSWUNqyZGGktr/
        TUJsrd5xUFMBAlzJsMKTi/E=
X-Google-Smtp-Source: ABdhPJzUIGS6wvMmKTdBe7fk/YLlV1dp7m5Cy0m5ar1s4nCmFchQ0s93rsDkCflkBvfihHjtJiwm9g==
X-Received: by 2002:a05:6808:aaf:: with SMTP id r15mr6982288oij.80.1626989018431;
        Thu, 22 Jul 2021 14:23:38 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-d50d-298a-08dc-a5ed.res6.spectrum.com. [2603:8081:140c:1a00:d50d:298a:8dc:a5ed])
        by smtp.gmail.com with ESMTPSA id s6sm4367678otd.6.2021.07.22.14.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:23:38 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v3 1/6] RDMA/rxe: Move AV from rxe_send_wqe to rxe_send_wr
Date:   Thu, 22 Jul 2021 16:22:40 -0500
Message-Id: <20210722212244.412157-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210722212244.412157-1-rpearsonhpe@gmail.com>
References: <20210722212244.412157-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Move the struct rxe_av av from rxe_send_wqe to rxe_send_wr placing
it in wr.ud at the same offset as it was previously. This has the
effect of increasing the size of struct rxe_send_wr and keeping the size of
struct rxe_send_wqe the same. This better reflects the use of this field
which is only used for UD sends. This change has no effect on ABI
compatibility so the modified rxe driver will operate with older versions
of rdma-core.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v3:
  Per Jason's suggestion split up this patch into two pieces one of which
  just moves AV and combine adding the ah_num changes to the third patch.

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
index f7b1a1f64c13..725015a2e84c 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -605,7 +605,8 @@ static void init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
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

