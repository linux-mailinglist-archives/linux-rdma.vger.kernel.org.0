Return-Path: <linux-rdma+bounces-3127-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 959FA907A7D
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 20:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0F51C23A8A
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 18:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB53146D7A;
	Thu, 13 Jun 2024 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enN/smSJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6BF12EBF3;
	Thu, 13 Jun 2024 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301619; cv=none; b=HAWZy8IvZOM62cX+O77hL8qz4rD2rK+3RK99W7cXO6zhsUeNZsTbcs8ph62/nmNBc//6e/qHKF2c0sGP3075PGjdeL4l/vB0hEJum4WAfNgwy22qGjKb1ChRTxWYscEzTpXdSfEN3jy3cDMQ59wKKiskWTwHI4WNyrXxMhs8NKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301619; c=relaxed/simple;
	bh=jxSjdY9QHPYiDbL8HMSZLUmmHEflYIPj8PB9Z2ua1Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3GFRbD3mFiOUeXIidfcvlKcAS6EB20c1AhxQo9ambpa3MjPu46YlrPBOjfzujtGpkzT4Xf+v89wgKFkZb0sG7zY2yUn1R17FQlKWbiql41xE+rlNyCJ2sAIFQ7LxpUCPHi1GRjSVL73ukL6HpVA6a1nLcdy/+ClaO5tVyZYHgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enN/smSJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BD5C2BBFC;
	Thu, 13 Jun 2024 18:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718301619;
	bh=jxSjdY9QHPYiDbL8HMSZLUmmHEflYIPj8PB9Z2ua1Qc=;
	h=From:To:Cc:Subject:Date:From;
	b=enN/smSJdwzPaZt9w1cZ1dQZPd9PDCdflgLJY0lLBCElwbrWnkpnc2wvkYEL1ZaLu
	 woixKoNvajGT+U95F/meAtxQB43r1ukZD/hPxrMNiioRttEtJM3ftCBX6xbqCM/o9a
	 z1vRJxQDo07ZStKe6Yzlhbd8EXHeMlFg20aKMx/uquXwJN5hWWXWGusCcaJIVDr2Yv
	 i+jN/9O7PeWAglH2nyvIp3jG82G8PQJoOqMCxujjmPmTSekZGcACtM5eJfN1aYZJT6
	 JEEe7xV+L0sw0SKDF4L6sUEdCZl4ht0WZLaNTncZUhCJVsVJNfvnjHqTcuoq8uz4Qw
	 mGEoGJXFiujvQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next] RDMA/mlx5: Add Qcounters req_transport_retries_exceeded/req_rnr_retries_exceeded
Date: Thu, 13 Jun 2024 21:00:04 +0300
Message-ID: <250466af94f4989d638fab168e246035530e912f.1718301543.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

The req_transport_retries_exceeded counter shows the number of times
requester detected transport retries exceed error.

The req_rnr_retries_exceeded counter show the number of times the
requester detected RNR NAKs retries exceed error.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/counters.c | 4 ++++
 include/linux/mlx5/mlx5_ifc.h         | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index 8300ce622835..4f6c1968a2ee 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -83,6 +83,8 @@ static const struct mlx5_ib_counter extended_err_cnts[] = {
 	INIT_Q_COUNTER(resp_remote_access_errors),
 	INIT_Q_COUNTER(resp_cqe_flush_error),
 	INIT_Q_COUNTER(req_cqe_flush_error),
+	INIT_Q_COUNTER(req_transport_retries_exceeded),
+	INIT_Q_COUNTER(req_rnr_retries_exceeded),
 };
 
 static const struct mlx5_ib_counter roce_accl_cnts[] = {
@@ -102,6 +104,8 @@ static const struct mlx5_ib_counter vport_extended_err_cnts[] = {
 	INIT_VPORT_Q_COUNTER(resp_remote_access_errors),
 	INIT_VPORT_Q_COUNTER(resp_cqe_flush_error),
 	INIT_VPORT_Q_COUNTER(req_cqe_flush_error),
+	INIT_VPORT_Q_COUNTER(req_transport_retries_exceeded),
+	INIT_VPORT_Q_COUNTER(req_rnr_retries_exceeded),
 };
 
 static const struct mlx5_ib_counter vport_roce_accl_cnts[] = {
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index ea5d569862d7..ae8e13a883f2 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -5672,7 +5672,11 @@ struct mlx5_ifc_query_q_counter_out_bits {
 
 	u8         local_ack_timeout_err[0x20];
 
-	u8         reserved_at_320[0xa0];
+	u8         reserved_at_320[0x60];
+
+	u8         req_rnr_retries_exceeded[0x20];
+
+	u8         reserved_at_3a0[0x20];
 
 	u8         resp_local_length_error[0x20];
 
-- 
2.45.2


