Return-Path: <linux-rdma+bounces-9210-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD2EA7EB80
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 20:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE9B17D790
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 18:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD52270ECE;
	Mon,  7 Apr 2025 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBkArjw9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2C02571B5;
	Mon,  7 Apr 2025 18:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049843; cv=none; b=BLBCwCK1gAI0VuGKuhvDPuzpgEGbDTsXgNuVlf8mnh8qmU1A5KZaZG9ivyl8zW8RfSpjZdzM4ors+wdp7lwAdxgQe8j0rd5KuZ4vBH474FH3Jq3r7v+yGqLAOiyMKUxgWlDOqd1uPJi6ipdETfdFkBRjU14GfV9qxoOlM0OAPls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049843; c=relaxed/simple;
	bh=sOZHrer63SBrn/aQ2LVQs4PYMqn6YSws1kotFUQ2l70=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hM7+fQKCpcYX+AY969HqjsGAu2tN45bGxyosUEd1TE5Goc2DvacfviKT8V/q7qxqa9clVNXP43I6WqH0jT8lKNr6C7QKlQc8Lvu5w/S2YX136ppItRwVlG41YJ/RN8V/2KSRQHygxfMX4w6rysJ+OL1T7cYG5LkJCrRTT/bdYx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBkArjw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7863FC4CEE7;
	Mon,  7 Apr 2025 18:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049843;
	bh=sOZHrer63SBrn/aQ2LVQs4PYMqn6YSws1kotFUQ2l70=;
	h=From:To:Cc:Subject:Date:From;
	b=BBkArjw9+hSOXmO81I2n2NGHU/ley388+xyyHaTRgS2lH29iMFCLkvF53vuHwFgsA
	 2RDPT6q4gCXoyU+DM4JLirdtbPmiHFoGDTpaRH8yiRVL/5ntRaNKTa52Is+DLL4sfa
	 g+gWdJoFX7PcmWq1fxg7TCXWz22IYW7mCS9e6DmKh1lEUMjIUlem1BCZAjNuf8Aol5
	 Lvpj06zufgD7hdVSdHe7Ro+5iqavylNS53McmNB/ehqnC9GPaG/F/GAQBf/666SlyP
	 e18jfstcDDt+wj8k3rs+7X3eOYP1GfEIleiRp1Ts1dG6ya4wt94hqcKUkecLXvmslT
	 K3trkJqucfWVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>,
	dennis.dalessandro@cornelisnetworks.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 1/7] qibfs: fix _another_ leak
Date: Mon,  7 Apr 2025 14:17:12 -0400
Message-Id: <20250407181718.3184348-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.22
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
index b27791029fa93..b9f4a2937c3ac 100644
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


