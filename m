Return-Path: <linux-rdma+bounces-5690-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8960D9B8A14
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2024 04:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5E11C21541
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2024 03:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C699145324;
	Fri,  1 Nov 2024 03:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ZzeeFI5G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2404D13C67C
	for <linux-rdma@vger.kernel.org>; Fri,  1 Nov 2024 03:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730432908; cv=none; b=fh/NqdJOvquEKxjPSoNreAFzLNJM2ppByKOJxnokJi1Ah1Cc2XaQOXh3+dYqlIQ0xZ43q3xgh/kptlY4KwUrs9txxJ9Gvd52ENmmjQ7eattdF3CTcTBr6xiO4fvdlHo0xtDQt/LyyKtsAqiLuSgYtFPOOmIddMUl2fFNceBsWvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730432908; c=relaxed/simple;
	bh=vb2oy9sCtacw/TXgOT7kaZXJblOW4SHOKBYJ4mHT4RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXqGLU8kCurkqyYGJORSm+z3g8o4qcWIYbQovGtQDJp5JHqqtrjKsrp5zBCVxPXc8L4218E71S1kKz4xUMt9Vy04vEi/BExe4JLzVFiPSSon7n6H40OuN3EZOyAuMHPd5AZrYDjHHpt1zxpHnq56HUHAJZ0TVfNDbbYNIqzWGzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ZzeeFI5G; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-6e36a012af3so777587b3.3
        for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2024 20:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730432904; x=1731037704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Up78lUxvH9q9ucvQFWkY0ZlRiNJvCC25wLA/XPV5mzI=;
        b=ZzeeFI5Gv+utldo5Ncc9JuDW9O2ij/nWykM+hYt3eacndZW+NQ2BgmlNiNuWeyOg3z
         VmZ6RbAqMHKer7PLU3pANnTSi0JvOge7NAz6yU3+MOMLsOLPORib6vkZju2+ZwQam9hO
         EQwYMKA5/LAAuf8rlWlk1kf/LhfmHmMivG/z7x+ved8Hh3Swa4z/FuE+WOVAKSzdoTEx
         b6hv0YBZPQOa0kpds8oyLWvKPAWvGeA01YEZSawMCADj6w/7dB/9gHgp2zO+rJvKkWPr
         qTpew1XhDbvPSccrOy6RULbCI707Rk0kgJmZ4HJIqCt1RlIPGeRiMzb0926tSUFUDfLg
         UYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730432904; x=1731037704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Up78lUxvH9q9ucvQFWkY0ZlRiNJvCC25wLA/XPV5mzI=;
        b=cIzu6C0Mqy+RRlB1CAlxkgzd8fXvc80xQY0QSdA3a6I7VkRicshLlFdGuEu5VldOlE
         KsF2XzqGjYLH03vFT48dIKNAcpHxkEdMbl+953SZ8fDMzvSSvuWMqXqUBr2tkPzlYTM5
         AoqX5KVGrz/pWNfAwvrHwPJ4iAneU8UU6c38XV7zn4nWH+vfESQMlm+JbCJGY4OeK2yP
         ds+kHmCB4uyaUIYqnzqGJcdk/SxLVEJPCVIw+7R9JEzBopk+tr2XCamAl0dGPyeHwoCE
         TLe1FexOWBT6CqFGrazUJUne81WMy5YXaNHM/G5MpvcD3myIBBtaiIm0MySp8U44GdMG
         dVjA==
X-Forwarded-Encrypted: i=1; AJvYcCXfb+/Uo7gokOsdoDQZOuZ1aykCmqjaQLitZHd/Nni97Xxz2pR967Gn9oE/iFAc++xGRY6Scg5HGlEF@vger.kernel.org
X-Gm-Message-State: AOJu0YzHisCD1pkqmnp392gvaaa0l3w61HrSNW4QHjXgCo5lUkYtnmGf
	8VGg26w0C/ds8ag+to7vcNl7sE9NWSEm8fcCrHegd4+NwMk+Xhj3oiIKq8NrBC5QOSdLQVX2Bl6
	8pSoe/OC8e1ZnrUy7+1gDRng8FsEDbfGDz5bWqykPMHS6+qfg
X-Google-Smtp-Source: AGHT+IGWZ6+2TcpibDq+QvmilpiTPyrL6xq18JN2Nx0c+o1Cryy+xInZp0VbeTqIdLLnK+T9JrTGA/dbML47
X-Received: by 2002:a05:690c:fc7:b0:6e2:ad08:492a with SMTP id 00721157ae682-6e9d8aab833mr104947587b3.5.1730432903988;
        Thu, 31 Oct 2024 20:48:23 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-6ea55b0cd8fsm946117b3.20.2024.10.31.20.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 20:48:23 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A182A3406A8;
	Thu, 31 Oct 2024 21:48:22 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 98397E42B1D; Thu, 31 Oct 2024 21:48:22 -0600 (MDT)
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
Subject: [PATCH net-next 2/2] mlx5/core: deduplicate {mlx5_,}eq_update_ci()
Date: Thu, 31 Oct 2024 21:46:40 -0600
Message-ID: <20241101034647.51590-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101034647.51590-1-csander@purestorage.com>
References: <20241101034647.51590-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic of eq_update_ci() is duplicated in mlx5_eq_update_ci(). The
only additional work done by mlx5_eq_update_ci() is to increment
eq->cons_index. Call eq_update_ci() from mlx5_eq_update_ci() to avoid
the duplication.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 859dcf09b770..078029c81935 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -802,19 +802,12 @@ struct mlx5_eqe *mlx5_eq_get_eqe(struct mlx5_eq *eq, u32 cc)
 }
 EXPORT_SYMBOL(mlx5_eq_get_eqe);
 
 void mlx5_eq_update_ci(struct mlx5_eq *eq, u32 cc, bool arm)
 {
-	__be32 __iomem *addr = eq->doorbell + (arm ? 0 : 2);
-	u32 val;
-
 	eq->cons_index += cc;
-	val = (eq->cons_index & 0xffffff) | (eq->eqn << 24);
-
-	__raw_writel((__force u32)cpu_to_be32(val), addr);
-	/* We still want ordering, just not swabbing, so add a barrier */
-	wmb();
+	eq_update_ci(eq, arm);
 }
 EXPORT_SYMBOL(mlx5_eq_update_ci);
 
 static void comp_irq_release_pci(struct mlx5_core_dev *dev, u16 vecidx)
 {
-- 
2.45.2


