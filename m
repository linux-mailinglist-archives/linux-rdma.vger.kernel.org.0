Return-Path: <linux-rdma+bounces-5490-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3801F9AD5CC
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2024 22:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E880C282B60
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2024 20:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522EE1D3624;
	Wed, 23 Oct 2024 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Z66+ohz6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC321AB6F8
	for <linux-rdma@vger.kernel.org>; Wed, 23 Oct 2024 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729716704; cv=none; b=LToURZ9q1Oj+BLsXu2GZxzQOpqT4SYeuAQSo0WPQ8aPC3eZ2VHtHePsKYT7nMZhmU5MkWcqtiqgkga+H1u9nTpQmx6erdxNT3dITkgVIifXEKHQdKiA2tsnjR4Sp21/o6kzuOze6NBxYICN+G9svQfbalfR12u4adEPcPlwPJqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729716704; c=relaxed/simple;
	bh=K44ATCiMDHxMTMJcyBAwfGkIfgGnFaUTSMZ5dOBioco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tSmHk4a9lQnlN5I9T7iLxnnLxn0np5so/pWnRh2X+e1PCBSbBs27JSt55aEngTjZ9SYYv8EIAbrf4hOLxopW8bd9veYCqLe5BolCQojK82WBBt32BZ7idOFGskolOUDt6F23RBJwfH44lNcGm8WXV1qxLTXEt+3Ns2GU15xDruo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Z66+ohz6; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-2e56750bb13so39302a91.2
        for <linux-rdma@vger.kernel.org>; Wed, 23 Oct 2024 13:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1729716702; x=1730321502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vCyXfoKZLYIrM6bHNOmey4+JbsNLY/BGPRNE02WxQwo=;
        b=Z66+ohz6/PuKBA4Cw1XCx8sMFctDfz66PzgpeffsEO3CzcUL9ZkvouWpft+AHyiX7F
         WuLVkaGqWI+opb2qABPmJHWUwqIYam3XtOhZha+E9Bky+c89a+l7+ePXIW0iZx5sJ9hL
         /LLEDDA5D5td8ppzDr4XLaJJeAq0P67HS/dJazSTASsQH6KN2Dp042ctaXgsHXGN1ioP
         EMKrsZvzlPLwSmjqNA/aGtTFD0Z5mIfX6N5mmfJiwb9RCZyak4N5teZ5kOI6hj67hCb+
         /oZEtVUV3kqej9ga7M5jki2LzyaSe1ai22s5PskBd0KmuXEjb8tt5lL+Za5m1eclkT3G
         oL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729716702; x=1730321502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vCyXfoKZLYIrM6bHNOmey4+JbsNLY/BGPRNE02WxQwo=;
        b=OE0MbWU1WZnzlMHrrMvABSndaWJdfrddPvlXKFCCYv5WypbJ1FEk8q81SDCr+hB3yh
         KkX9QTTaHPNOW3hMJQo5aaM/HB513cxbYx6AkIDkfi7ATANS+t2xHrhIYvEr7z62LAG9
         nKEbhQDB+B5Zk8cMG7+eLUaOAn2iDlCsJXXI0QscvQChNdlzp7121A6jfK+2gOY9xeZK
         D/8H9rWlJHSjjwxLAn3g3QodO7AlsGVN+DTLmH2tkYhOkTsCdktoQil8gWP+zrlPdzjs
         Y9ci2qgpQnEvzzp58B5VAPRNUWrmPFya4L0iYMQxt4JGjadLKiZgwm8j1pcFieyW9VLc
         Gm2g==
X-Forwarded-Encrypted: i=1; AJvYcCXIjgTG8C1V062ONUvL7YF7vT+mPVpbSS9+yiFo33pZ1ivP3wmEeZNsplO97ZkCSkY1TZeJaPvmeWPC@vger.kernel.org
X-Gm-Message-State: AOJu0YyK3kmK+nCMPqyiEnQLag2Wp+X0j58J/bQsODLdVGpq+0J+0BAB
	d+y8AWg1SFn4RZBba3oTe5CEw8mrwa1DjxofKsA+SpwCK26NDcWWps0TX3ZYjbJoGK5NEKyUnRM
	GH6d5CYX0eFLRlyoPANN/acMGWaRtIlN6WcbQqJ7LTgXmpqzQ
X-Google-Smtp-Source: AGHT+IG35rzOCpF6xzICIlXnd2xKWIdeRqdxmgfplqytKRI7gARk7EO/TkF1EVCs0mtdYwpJbkfTYQSa4jYI
X-Received: by 2002:a17:903:32cc:b0:20c:85dc:6630 with SMTP id d9443c01a7336-20fa9deb651mr23890985ad.1.1729716701633;
        Wed, 23 Oct 2024 13:51:41 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-20e7f0dd5c7sm2620325ad.54.2024.10.23.13.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:51:41 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3B88D3400B6;
	Wed, 23 Oct 2024 14:51:40 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 2D9E7E40BE0; Wed, 23 Oct 2024 14:51:40 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mlx5: simplify EQ interrupt polling logic
Date: Wed, 23 Oct 2024 14:51:12 -0600
Message-ID: <20241023205113.255866-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a while loop in mlx5_eq_comp_int() and mlx5_eq_async_int() to
clarify the EQE polling logic. This consolidates the next_eqe_sw() calls
for the first and subequent iterations. It also avoids a goto. Turn the
num_eqes < MLX5_EQ_POLLING_BUDGET check into a break condition.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 22 +++++++-------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 68cb86b37e56..859dcf09b770 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -114,15 +114,11 @@ static int mlx5_eq_comp_int(struct notifier_block *nb,
 	struct mlx5_eq *eq = &eq_comp->core;
 	struct mlx5_eqe *eqe;
 	int num_eqes = 0;
 	u32 cqn = -1;
 
-	eqe = next_eqe_sw(eq);
-	if (!eqe)
-		goto out;
-
-	do {
+	while ((eqe = next_eqe_sw(eq))) {
 		struct mlx5_core_cq *cq;
 
 		/* Make sure we read EQ entry contents after we've
 		 * checked the ownership bit.
 		 */
@@ -140,13 +136,14 @@ static int mlx5_eq_comp_int(struct notifier_block *nb,
 					    "Completion event for bogus CQ 0x%x\n", cqn);
 		}
 
 		++eq->cons_index;
 
-	} while ((++num_eqes < MLX5_EQ_POLLING_BUDGET) && (eqe = next_eqe_sw(eq)));
+		if (++num_eqes >= MLX5_EQ_POLLING_BUDGET)
+			break;
+	}
 
-out:
 	eq_update_ci(eq, 1);
 
 	if (cqn != -1)
 		tasklet_schedule(&eq_comp->tasklet_ctx.task);
 
@@ -213,15 +210,11 @@ static int mlx5_eq_async_int(struct notifier_block *nb,
 	eqt = dev->priv.eq_table;
 
 	recovery = action == ASYNC_EQ_RECOVER;
 	mlx5_eq_async_int_lock(eq_async, recovery, &flags);
 
-	eqe = next_eqe_sw(eq);
-	if (!eqe)
-		goto out;
-
-	do {
+	while ((eqe = next_eqe_sw(eq))) {
 		/*
 		 * Make sure we read EQ entry contents after we've
 		 * checked the ownership bit.
 		 */
 		dma_rmb();
@@ -229,13 +222,14 @@ static int mlx5_eq_async_int(struct notifier_block *nb,
 		atomic_notifier_call_chain(&eqt->nh[eqe->type], eqe->type, eqe);
 		atomic_notifier_call_chain(&eqt->nh[MLX5_EVENT_TYPE_NOTIFY_ANY], eqe->type, eqe);
 
 		++eq->cons_index;
 
-	} while ((++num_eqes < MLX5_EQ_POLLING_BUDGET) && (eqe = next_eqe_sw(eq)));
+		if (++num_eqes >= MLX5_EQ_POLLING_BUDGET)
+			break;
+	}
 
-out:
 	eq_update_ci(eq, 1);
 	mlx5_eq_async_int_unlock(eq_async, recovery, &flags);
 
 	return unlikely(recovery) ? num_eqes : 0;
 }
-- 
2.45.2


