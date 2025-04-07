Return-Path: <linux-rdma+bounces-9212-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDABA7EB8D
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 20:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E11B3A847E
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 18:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2339125743D;
	Mon,  7 Apr 2025 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7Jgm9ln"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08B025743F;
	Mon,  7 Apr 2025 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049873; cv=none; b=r75j2wviFAjTzoJllVtk6UBlBsHAg5awK0PNAgD9YnUmlJoMB192k2yl/2fORRWJ3yb6Y8wFLFNjKgq33x9hdes+0w0qsYfn1H5ZEI6CVpofXIuHDzasClZRvD2s/C0ZMyeZ/BauTXFZIOZ0Tj2e3gHKvkiZUYZ/FgPURgswFpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049873; c=relaxed/simple;
	bh=JRYWJK1r/qGELe66KzeYLhzUPKcDITJXk2CcNVbbQTs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=czadjyMFN7tLInul94Xy+Vd/7oYqynjP+2G5Z2e28ObPb1lStEbsYRSRed54Mp1Z1EAhwrjX3ckfEKEfCGPzcRTPVlfeXhBs17SLe8J/4rgzsb8zqdWLn3ymuT1reJtmHo4KfS89HZ32Fm49ZFdshSys+rguZn/pgESwqrs6KAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7Jgm9ln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A10C4CEDD;
	Mon,  7 Apr 2025 18:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049873;
	bh=JRYWJK1r/qGELe66KzeYLhzUPKcDITJXk2CcNVbbQTs=;
	h=From:To:Cc:Subject:Date:From;
	b=R7Jgm9lneN/LWFlqR0nAqWdzgZFHN/7oy4G8ZftUC/fI+RZZK0qgPwrYNqIieSlfO
	 o5qZ8AJuZikvL7VVZWIMe+LjMxOG6K12kFi97wthlAvBXgWfCWoG7ebzD2n2554/u+
	 EKN5JlW9Rov5sNEDSpVstIMf3BGCRQNFn9/DlLpGfuLl5QfCpo+2whNkd7hkwvfOS0
	 3BUkGYklYitdtx2hnVxFljzf+OoEx9c96SFHfXbCzanoLYf1zw7SKcxw0R2rEvwE7j
	 kkdoBDrpqK0ZLFdIEZTV+e2++jzVZJzyePWcGCksPqM/AULNjjiTfuGZW4LrCQYnyn
	 HSVeW+ejNWOkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>,
	dennis.dalessandro@cornelisnetworks.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 1/5] qibfs: fix _another_ leak
Date: Mon,  7 Apr 2025 14:17:44 -0400
Message-Id: <20250407181749.3184538-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.133
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
index 182a89bb24ef4..caade796bc3cb 100644
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


