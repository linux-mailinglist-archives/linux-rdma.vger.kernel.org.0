Return-Path: <linux-rdma+bounces-12710-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 503ECB249AB
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 14:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9574F7AD2CB
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 12:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8992E0B6D;
	Wed, 13 Aug 2025 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXyXOFVG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D452E03EA
	for <linux-rdma@vger.kernel.org>; Wed, 13 Aug 2025 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755089006; cv=none; b=YT72cxbxFUg0CRqm96tx1euUUMIBHKL7c1cR96V80FoMlESJW/EL6EHZ97b3eYmsfvon094Y/CjM62E5woJoDa3sqwCNHSjZ7vSGIL8ShEbYhwuzMLG3eJ05HkMA96JUkLWPXjZ/GV0yxiGMfQKzJC9YqS5aYqLvpjKuZOY6rks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755089006; c=relaxed/simple;
	bh=uV8hPAUPtWpCSfsYJiHAobKdqG5TGS9Z2Z9lvxohHWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S0xocNHAZd70FZOeb67qMd2O7qFpFf1IxRnnL3rWMV9TUAGRU1/O5vg0GKrVBrWtmPSG9MjozMYE2w3T1S2cqR6nAbOjEH11Ez6j/IfFF0b8jPTKmsZhgAnizjKZW2aygY4EmQ/IMxvA9l/2yAoJ9F8vq2mtByj8vZ44QNjTkuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXyXOFVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9604FC4CEEB;
	Wed, 13 Aug 2025 12:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755089006;
	bh=uV8hPAUPtWpCSfsYJiHAobKdqG5TGS9Z2Z9lvxohHWw=;
	h=From:To:Cc:Subject:Date:From;
	b=nXyXOFVGv9xHLSxqsiasJxtYa3CRogSm3REomdzYcB18gNvk58vCD2R3dUB/8Pz1J
	 PBCaPCqlCSkkHfphtOENChZAb072pavBTX9aRqCx7R4O9/73m6bxZ9FwHamur1GWWU
	 2DlftW4A5+D9EmYJ1CIuGgMGtKdPVN8gecyl1gZmnbi3L911ILy5dYT72axd9+cuxC
	 AgJOBnyJyQs9h9PCMP8EsbhTPxUn/9Rb8tfMUSxVlhZemhALZol7oM1XsgiTABB9uA
	 prCi1TzjkbMEXgFcHawZr7XylGaLpwB+mamt909EOY0IJjERCHEhk+kn4aC1yuYccs
	 vBFjhWiSM42iQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Or Har-Toov <ohartoov@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] IB/mlx5: Fix obj_type mismatch for SRQ event subscriptions
Date: Wed, 13 Aug 2025 15:43:20 +0300
Message-ID: <8f1048e3fdd1fde6b90607ce0ed251afaf8a148c.1755088962.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Or Har-Toov <ohartoov@nvidia.com>

Fix a bug where the driver's event subscription logic for SRQ-related
events incorrectly sets obj_type for RMP objects.

When subscribing to SRQ events, get_legacy_obj_type() did not handle
the MLX5_CMD_OP_CREATE_RMP case, which caused obj_type to be 0
(default).
This led to a mismatch between the obj_type used during subscription
(0) and the value used during notification (1, taken from the event's
type field). As a result, event mapping for SRQ objects could fail and
event notification would not be delivered correctly.

This fix adds handling for MLX5_CMD_OP_CREATE_RMP in get_legacy_obj_type,
returning MLX5_EVENT_QUEUE_TYPE_RQ so obj_type is consistent between
subscription and notification.

Fixes: 759738537142 ("IB/mlx5: Enable subscription for device events over DEVX")
Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Edward Srouji <edwards@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index f21c82cb9a15..fad2c6142a8a 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -233,6 +233,7 @@ static u16 get_legacy_obj_type(u16 opcode)
 {
 	switch (opcode) {
 	case MLX5_CMD_OP_CREATE_RQ:
+	case MLX5_CMD_OP_CREATE_RMP:
 		return MLX5_EVENT_QUEUE_TYPE_RQ;
 	case MLX5_CMD_OP_CREATE_QP:
 		return MLX5_EVENT_QUEUE_TYPE_QP;
-- 
2.50.1


