Return-Path: <linux-rdma+bounces-9209-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C568A7EB2F
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 20:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E88188E725
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 18:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95B6256C85;
	Mon,  7 Apr 2025 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPL31Iju"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614F4256C80;
	Mon,  7 Apr 2025 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049823; cv=none; b=lXM4s+vQt4Qu6SO5lXDxFuRigpxJ4kmQtBeHS3OKRKzktJ0MXvG/PUE6vBD+wINSyqAYphgVN9H+KlEd6jAOko0bs5/NkUm+SD663oRUb36irFecaPMYWrdCKROjiVPl3ONXyoImKxY8iR9mxMaXyLgbVwewe1fz03DTIUGVqqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049823; c=relaxed/simple;
	bh=sOZHrer63SBrn/aQ2LVQs4PYMqn6YSws1kotFUQ2l70=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nWV+p38biNXG91uSATVYdCjN0swuRSw+Pug9Bj7IuQzOrRXHb3dyIfcjIqQdT5qP22u4cLG8B9E8L/gnlwXGmafTXQJPb+PPIIzE1HZJhylelFs5vBzB7gUpB9YHgbWRq/ZtG/TsIgpoj51wTdb4zLEv0ZCDcylXrKbbw57U384=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPL31Iju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74244C4CEE7;
	Mon,  7 Apr 2025 18:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049823;
	bh=sOZHrer63SBrn/aQ2LVQs4PYMqn6YSws1kotFUQ2l70=;
	h=From:To:Cc:Subject:Date:From;
	b=lPL31IjuLbXeaUU5iD0dEK1o53J6tGmVWRaYN00OnSKBaNGtjkkYgDCtkne8EmyFf
	 t2gfDgCfymU+KKeZ6Z5tqCdR2gNGkmBM7N2Xkc55VOWmUlGmzIVFsmd4IogXImN32c
	 t9CXPsOrXkHFVA7ViapqFV/fBqNk0cxXOyAt1kiwlKTJ4bIngimfO1sjp6bXn7i/aC
	 TMJ3AkJiTrSQs0Ru/AA7IowtpyU6z2ixUsPbVyYYBkVNWqC3iaryBCzkiLvkcnWO8t
	 7NujseZ7qOXa+WfLCwGmfwX8FEcjntjsLzTj7xj2jnckU0yLFZwHKpJkypQeHM096r
	 fU35Ge16BSFvw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>,
	dennis.dalessandro@cornelisnetworks.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 1/8] qibfs: fix _another_ leak
Date: Mon,  7 Apr 2025 14:16:51 -0400
Message-Id: <20250407181658.3184231-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.10
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


