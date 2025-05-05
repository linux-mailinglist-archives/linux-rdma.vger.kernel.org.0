Return-Path: <linux-rdma+bounces-10023-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34515AAAD60
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 04:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6140161460
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 02:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2047530721F;
	Mon,  5 May 2025 23:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aa1dlmm+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C166E3B3BB5;
	Mon,  5 May 2025 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487257; cv=none; b=iIwS+pCs5XwjWQXAONT7TmwYsrPvd3VVPb0zdO5nEHIgmDEjK8HXd/Mb++7RoaH5KfzXe3AcFxqid8Iz//crO3QUb45VrvipPxPcoQZrbn9KhpkvgMM1Os3+MaRp//48RY4OSRfNL/eT0gZvYSx+7jOKzI924m4ps856QcplW3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487257; c=relaxed/simple;
	bh=i3x/K4kilTFOffX74faqUg69tWw7y/FP7qCjJgWEeps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dfitad7Wuvqfomp0JNAV7otwgF0Ah0uF6XTK3dTmbOzl1xZ415uoLlPLaKrVj/7CZyVLwmLh/pKktrcjb/RFWue46wsw6zeuml2K9X75hq+FlsXHgBdwRNs5BzsYyUN3uNKQj3QsZ0IInHsbucQaHJmaqLAp7onBIFBB1zF+lFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aa1dlmm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AF9C4CEEF;
	Mon,  5 May 2025 23:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487256;
	bh=i3x/K4kilTFOffX74faqUg69tWw7y/FP7qCjJgWEeps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aa1dlmm+l5RRiVJ8DA8Ik+MbDxFdJJuKGo/Qy/d/RLcaTwTgxsaG/BwjJIaSic0G7
	 yjhxKlC+6xVKOMeIXDpDPyPYgyJizPJXdqE8IEM0NsbxhKXyNbYBkYgWJgHxDlsoDa
	 o6virDF+BEdx4mSY2/5MwcYBz7l/gDNJtFJfNGrVHtPgHLShl4O8ngiYEfDMhuf82c
	 8NePNQ++MvNCkXrGMItIfqRIU9JrjhWQtnrutf3u+xatEQ6wrkCG4fbW+JrNTd4aA4
	 dHFU7oaGakc+aNP2PUal7bQ6UaOvsEIp/3Ud1pqHgI93uVXhQ9/En1QAubJBJ6jlOK
	 Qi4+HoDoHtqiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shahar Shitrit <shshitrit@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	saeedm@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 083/114] net/mlx5: Apply rate-limiting to high temperature warning
Date: Mon,  5 May 2025 19:17:46 -0400
Message-Id: <20250505231817.2697367-83-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Transfer-Encoding: 8bit

From: Shahar Shitrit <shshitrit@nvidia.com>

[ Upstream commit 9dd3d5d258aceb37bdf09c8b91fa448f58ea81f0 ]

Wrap the high temperature warning in a temperature event with
a call to net_ratelimit() to prevent flooding the kernel log
with repeated warning messages when temperature exceeds the
threshold multiple times within a short duration.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Link: https://patch.msgid.link/20250213094641.226501-2-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/events.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/events.c b/drivers/net/ethernet/mellanox/mlx5/core/events.c
index 9d7b0a4cc48a9..5e8db7a6185a4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/events.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/events.c
@@ -162,9 +162,10 @@ static int temp_warn(struct notifier_block *nb, unsigned long type, void *data)
 	value_lsb &= 0x1;
 	value_msb = be64_to_cpu(eqe->data.temp_warning.sensor_warning_msb);
 
-	mlx5_core_warn(events->dev,
-		       "High temperature on sensors with bit set %llx %llx",
-		       value_msb, value_lsb);
+	if (net_ratelimit())
+		mlx5_core_warn(events->dev,
+			       "High temperature on sensors with bit set %llx %llx",
+			       value_msb, value_lsb);
 
 	return NOTIFY_OK;
 }
-- 
2.39.5


