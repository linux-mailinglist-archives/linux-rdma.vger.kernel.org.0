Return-Path: <linux-rdma+bounces-9208-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8E6A7EB44
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 20:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E56D3B8A02
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 18:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280B72236E0;
	Mon,  7 Apr 2025 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGjiqrEM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAF721ABD4;
	Mon,  7 Apr 2025 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049800; cv=none; b=X0H20cOfwYJZAfRQt+FmbgXeGY7oi2gRnMLIf2PDaE8b2NsgeNSf3mpqOPb9SLm26MrVtLfjZFYf+761w9C2WRSnynPryWnSB5w9ZfAuk5nq0F+yiDeXI97eUnuS9lYYDuK4uuYAXK4ZvK+vquZ3YLFCGIJh6sxKG6y6CFEahG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049800; c=relaxed/simple;
	bh=sOZHrer63SBrn/aQ2LVQs4PYMqn6YSws1kotFUQ2l70=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MuRsmhZsuduNl44uKFwuVfNYRmEOemjG757a5HqIUmupOWDhamLBQfz8uLR0DgDOtgm7jylSi0hWPsHHAY7oaYX4Q+mWM0snjZ+ySO4yvctk9x+jXbRit9aBAzUb6BLGgD07QcCNhNdFbOuKl7bnX1kAOTk8G5S9EXg3rsAx3tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGjiqrEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D4DC4CEEE;
	Mon,  7 Apr 2025 18:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049800;
	bh=sOZHrer63SBrn/aQ2LVQs4PYMqn6YSws1kotFUQ2l70=;
	h=From:To:Cc:Subject:Date:From;
	b=oGjiqrEM2qN6suhbt9xX86yQlvCgc2OXv4QzBKVaR8x6Yzy5dU9kHgp3sbOEv9mZd
	 yunU6/LXWQDCOl6ZFTCJlkagchTNI9ZWfAXsxBTAPkDdQxLyTnArOeLWugP+pd+4v9
	 wcKX/XGoUe0mCaZSdMQDCT2alsDipr9HyibQV0wUUdqcibyrv3Jzsi9DMqvEQMslcq
	 MdFNfDW0/E8qIxAfjKXv5RLXaSyQt3bfGQzP+4BOV9A16XZJIqrbImr5SMgq/0RTw+
	 Szz8LxaDWS/Qv8MskK1Ra8aWCG6HmNnZG0nqGUtcxCEzAR8j40fjVUp7FvCBonwx0V
	 u3mAavXTgzGIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>,
	dennis.dalessandro@cornelisnetworks.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 1/9] qibfs: fix _another_ leak
Date: Mon,  7 Apr 2025 14:16:27 -0400
Message-Id: <20250407181635.3184105-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.1
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


