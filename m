Return-Path: <linux-rdma+bounces-11126-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C23DAD31F7
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 11:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0EE1668C3
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 09:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CD028A41F;
	Tue, 10 Jun 2025 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAEeAVmV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408D1280CFA;
	Tue, 10 Jun 2025 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749547731; cv=none; b=I0jUZfdA2rBF4qLEMGPiVPH0A6Tyl1/ohA7kjFynM6xZu2XTLESROYvXRDz8BRGrtqOACfuGsvpotPwqE8+tNNN5yLgg/8f+76U9eRYdT3OWq9PEx8ghPYEOJh2wN2eG6pCH6lZ5U7QWBIOe7lTpYtbMwPBBD/MKwJvgIxIg+o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749547731; c=relaxed/simple;
	bh=IaYOK2B/lZua6SAzd/RoyITvIaEYGw7gzCzQ4KCweeM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tiZPIGUTauSJQtO52la5C07gPbWTZjUCDkI0S8ue4WpBemhCy3fLqibnbhivRWHoQbjjYGx3kLlHssYLXPWA/wrHDthhevlDOHQq3vOpZ8YwJ4lQn0WQQwmx0AuCyDBdGjf96/8kRJUsFO/0bg+04FRJNzwK5nZ5Sxo/i6xl3KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAEeAVmV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EA1C4CEED;
	Tue, 10 Jun 2025 09:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749547730;
	bh=IaYOK2B/lZua6SAzd/RoyITvIaEYGw7gzCzQ4KCweeM=;
	h=From:To:Cc:Subject:Date:From;
	b=XAEeAVmV/Yn7Hgcyi6RCsTZrN7/s5G967uRy3AS0PzJccsHjtbwxr434duTyhpuzK
	 24jasXy1KEWWZimYdYErqOLOsHKL9KBrsLIWA+ezY7lkJrKAZTIJhx+UfAltbH3D+Q
	 y2SG1qGvgM/HG9WuVYTfqm72/gmkieO6LbUsy9avWQ2J+zG86Op+r215bmdk7sC2Pf
	 1M3+8TJkjn53R6IsqbPkNA+wSdSRNEoxt9ZNfWwospo7ZpTdyQzdXkWE7CnX5iKip0
	 miJ9BsC8n7gieBuKB1N3LHt4COOgtd2zLMcPdEAPMCAa9FFcFkeX6htXM4wyIS2Tec
	 t6KMgA+BeEbfA==
From: Arnd Bergmann <arnd@kernel.org>
To: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Patrisious Haddad <phaddad@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Chiara Meiohas <cmeiohas@nvidia.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/mlx5: reduce stack usage in mlx5_ib_ufile_hw_cleanup
Date: Tue, 10 Jun 2025 11:28:42 +0200
Message-Id: <20250610092846.2642535-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This function has an array of eight mlx5_async_cmd structures, which
often fits on the stack, but depending on the configuration can
end up blowing the stack frame warning limit:

drivers/infiniband/hw/mlx5/devx.c:2670:6: error: stack frame size (1392) exceeds limit (1280) in 'mlx5_ib_ufile_hw_cleanup' [-Werror,-Wframe-larger-than]

Change this to a dynamic allocation instead. While a kmalloc()
can theoretically fail, a GFP_KERNEL allocation under a page will
block until memory has been freed up, so in the worst case, this
only adds extra time in an already constrained environment.

Fixes: 7c891a4dbcc1 ("RDMA/mlx5: Add implementation for ufile_hw_cleanup device operation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/hw/mlx5/devx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 2479da8620ca..c3c0ea219ab7 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2669,7 +2669,7 @@ static void devx_wait_async_destroy(struct mlx5_async_cmd *cmd)
 
 void mlx5_ib_ufile_hw_cleanup(struct ib_uverbs_file *ufile)
 {
-	struct mlx5_async_cmd async_cmd[MAX_ASYNC_CMDS];
+	struct mlx5_async_cmd *async_cmd;
 	struct ib_ucontext *ucontext = ufile->ucontext;
 	struct ib_device *device = ucontext->device;
 	struct mlx5_ib_dev *dev = to_mdev(device);
@@ -2678,6 +2678,10 @@ void mlx5_ib_ufile_hw_cleanup(struct ib_uverbs_file *ufile)
 	int head = 0;
 	int tail = 0;
 
+	async_cmd = kcalloc(MAX_ASYNC_CMDS, sizeof(*async_cmd), GFP_KERNEL);
+	if (WARN_ON(!async_cmd))
+		return;
+
 	list_for_each_entry(uobject, &ufile->uobjects, list) {
 		WARN_ON(uverbs_try_lock_object(uobject, UVERBS_LOOKUP_WRITE));
 
@@ -2713,6 +2717,8 @@ void mlx5_ib_ufile_hw_cleanup(struct ib_uverbs_file *ufile)
 		devx_wait_async_destroy(&async_cmd[head % MAX_ASYNC_CMDS]);
 		head++;
 	}
+
+	kfree(async_cmd);
 }
 
 static ssize_t devx_async_cmd_event_read(struct file *filp, char __user *buf,
-- 
2.39.5


