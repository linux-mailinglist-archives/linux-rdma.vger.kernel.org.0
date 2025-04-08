Return-Path: <linux-rdma+bounces-9230-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB26A7FEA1
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 13:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8DC19E4421
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 11:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D2E268688;
	Tue,  8 Apr 2025 11:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUZr8iFo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6F61FBCB2;
	Tue,  8 Apr 2025 11:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110306; cv=none; b=e0wu/nNGz77fSN2h+/B+9T0J6rJrDcPj1yynYrqJ60zJ9sHB/zfbk8u2gCMJkMj0u7v/zflOPKy69A3vDCWEaT445shnKslo7iPELTuD47CZ7v9xbiVLbeEqs8/t1hJMB7l9Hl9r9cRVhvAnWqkEELTdoOB3V77umvVWswHDzDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110306; c=relaxed/simple;
	bh=VINHAV6YV6ZaBbxDJLswKxL25ABp48NsLqGyFS57yJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U1LHgnVgloDgb4hNVKeP58AyPzzm6kSVBRvFFjI3rNHRoZ+gd31zbpJ96d1yaWopfFRMSN63QrqTzUvI30wEeDr2w33E6fd0R0jjGFoUGgyKW8GtGD1dMdhn+XaYSCohXeGr5P8oU5PFdqZYDT9S9ROEOLl4aiUBWVYCxZi4nk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUZr8iFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CBFC4CEE5;
	Tue,  8 Apr 2025 11:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744110305;
	bh=VINHAV6YV6ZaBbxDJLswKxL25ABp48NsLqGyFS57yJg=;
	h=From:To:Cc:Subject:Date:From;
	b=LUZr8iFo3IB+gT0khYUi295rjLXqF35fwUQSnhcmeSl9wlkfYkvTo4YQtXbdThanb
	 cY2t3RfG+1DISAXMJSitoPv9Txy2ckhecTl+MAfswqk2V68HmrPlyDCY4PwkyM5wr7
	 rUGcg/xeFZIXVJMXIU/zf6YJ37WunL7yCAcK1MjytL16phAeI9wPSLEloEGgdq+FNx
	 +zEI+DuukTy7GNaSahyEslm7JtmTdEnC7WACH5P7/DbuKDBQKLLvmJM9/QPZfJCIPB
	 /QRdp6PPYP/k2HzdCxTk+8sp7gcrSUKbuhV/An4Hnn1svW7FSloZT1MUsWbfvqHlFV
	 lXs8kBpxCusAg==
From: Leon Romanovsky <leon@kernel.org>
To: Allison Henderson <allison.henderson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	rds-devel@oss.oracle.com
Subject: [PATCH net-next] rds: rely on IB/core to determine if device is ODP capable
Date: Tue,  8 Apr 2025 14:04:55 +0300
Message-ID: <bfc8ffb7ea207ed90c777a4f61a8afe1badef212.1744109826.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

There is no need to perform checks if IB device ODP capable as
ib_reg_user_mr() will check all access flags anyway.

RDS is the only one in-kernel ODP user, so change return value for ODP
not supported case, to the value used by RDS.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/verbs.c | 2 +-
 net/rds/ib.c                    | 8 --------
 net/rds/ib.h                    | 1 -
 net/rds/ib_rdma.c               | 5 -----
 4 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index c5e78bbefbd0..61620787ee48 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2218,7 +2218,7 @@ struct ib_mr *ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 		if (!(pd->device->attrs.kernel_cap_flags &
 		      IBK_ON_DEMAND_PAGING)) {
 			pr_debug("ODP support not available\n");
-			return ERR_PTR(-EINVAL);
+			return ERR_PTR(-EOPNOTSUPP);
 		}
 	}
 
diff --git a/net/rds/ib.c b/net/rds/ib.c
index 9826fe7f9d00..c62aa2ff4963 100644
--- a/net/rds/ib.c
+++ b/net/rds/ib.c
@@ -153,14 +153,6 @@ static int rds_ib_add_one(struct ib_device *device)
 	rds_ibdev->max_wrs = device->attrs.max_qp_wr;
 	rds_ibdev->max_sge = min(device->attrs.max_send_sge, RDS_IB_MAX_SGE);
 
-	rds_ibdev->odp_capable =
-		!!(device->attrs.kernel_cap_flags &
-		   IBK_ON_DEMAND_PAGING) &&
-		!!(device->attrs.odp_caps.per_transport_caps.rc_odp_caps &
-		   IB_ODP_SUPPORT_WRITE) &&
-		!!(device->attrs.odp_caps.per_transport_caps.rc_odp_caps &
-		   IB_ODP_SUPPORT_READ);
-
 	rds_ibdev->max_1m_mrs = device->attrs.max_mr ?
 		min_t(unsigned int, (device->attrs.max_mr / 2),
 		      rds_ib_mr_1m_pool_size) : rds_ib_mr_1m_pool_size;
diff --git a/net/rds/ib.h b/net/rds/ib.h
index 8ef3178ed4d6..f3ec4ff5951f 100644
--- a/net/rds/ib.h
+++ b/net/rds/ib.h
@@ -246,7 +246,6 @@ struct rds_ib_device {
 	struct list_head	conn_list;
 	struct ib_device	*dev;
 	struct ib_pd		*pd;
-	u8			odp_capable:1;
 
 	unsigned int		max_mrs;
 	struct rds_ib_mr_pool	*mr_1m_pool;
diff --git a/net/rds/ib_rdma.c b/net/rds/ib_rdma.c
index d1cfceeff133..75ab7b8db864 100644
--- a/net/rds/ib_rdma.c
+++ b/net/rds/ib_rdma.c
@@ -568,11 +568,6 @@ void *rds_ib_get_mr(struct scatterlist *sg, unsigned long nents,
 		struct ib_sge sge = {};
 		struct ib_mr *ib_mr;
 
-		if (!rds_ibdev->odp_capable) {
-			ret = -EOPNOTSUPP;
-			goto out;
-		}
-
 		ib_mr = ib_reg_user_mr(rds_ibdev->pd, start, length, virt_addr,
 				       access_flags);
 
-- 
2.49.0


