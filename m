Return-Path: <linux-rdma+bounces-9211-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E33A5A7EB4D
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 20:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692331893B04
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 18:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD5027701E;
	Mon,  7 Apr 2025 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/zZNWjn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D422571D8;
	Mon,  7 Apr 2025 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049860; cv=none; b=NK/yFK9P8K+I67TsKcMs+J7h5cfJ2gQJEiS9F7huAeeO5PLufYdGcjppDwRp5u3BgGvNN4Fnx7J5NUEjnKyxDbxclXjhPOgL2R33WaRHu3/wl5E6Lee/mi3HpALvUg5w3NK2E2/LTiG0lDYZ2RTY53CbaXJMbQF7eHYLyl3TqzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049860; c=relaxed/simple;
	bh=6gX4D+T6syUKIVlFxx20e215ZYktOO/C4FV6e//+H4s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mIqm/Q2CGkfrecF9GvUK2aegB5/7ro8BcUkGDSn7T63OK/UBLaWKE2xERlLe+z84Ob25b/h79gSnJ4RxWBKStfdH6TPWwiiQcp7liaoPxTE2kAvJPAnJt9J2oEwCnWwYyT6TNN2S1Zuxi6yBAFPQlUtKReDafb0X5nyvamwZf5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/zZNWjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DA5C4CEE9;
	Mon,  7 Apr 2025 18:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049859;
	bh=6gX4D+T6syUKIVlFxx20e215ZYktOO/C4FV6e//+H4s=;
	h=From:To:Cc:Subject:Date:From;
	b=u/zZNWjnCPFIgB0VWMXNKGVrlUqxUbsWPhtyWuZWOnfa81CPNP3FQzcFyB3KFZMQV
	 /czkTNRQTtvgFcEGVGluoKfsi5zmPtn39QMODLtHP55lSHmYo8bV/WintfFTGYJL0S
	 kAI1Rv9B7/8rKWpB4fwpe5LXCEx50LbczIr8aJXoPZl1zbrRi3WsFjck3C9exW3KrX
	 Dei7lBG/j5PwB/wPA4Drkrivq17C8shOIogwtRan9pMlT9L71WyGcVK358GF3uLlgP
	 ZQoV2237K7x53wHW/uxSo76GwOefTUfOjfT8W0AKh9mNWUofu9pibAR65BTCeZ6zM4
	 G5HKiY705X5SQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>,
	dennis.dalessandro@cornelisnetworks.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 1/6] qibfs: fix _another_ leak
Date: Mon,  7 Apr 2025 14:17:29 -0400
Message-Id: <20250407181734.3184450-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.86
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit bdb43af4fdb39f844ede401bdb1258f67a580a27 ]

failure to allocate inode => leaked dentry...

this one had been there since the initial merge; to be fair,
if we are that far OOM, the odds of failing at that particular
allocation are low...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/qib/qib_fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/qib/qib_fs.c
index 11155e0fb8395..35d777976c295 100644
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -55,6 +55,7 @@ static int qibfs_mknod(struct inode *dir, struct dentry *dentry,
 	struct inode *inode = new_inode(dir->i_sb);
 
 	if (!inode) {
+		dput(dentry);
 		error = -EPERM;
 		goto bail;
 	}
-- 
2.39.5


