Return-Path: <linux-rdma+bounces-9216-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B3DA7EB76
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 20:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93DD21891F90
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 18:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26E227CCE9;
	Mon,  7 Apr 2025 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrcgEjv/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7CD257AFA;
	Mon,  7 Apr 2025 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049904; cv=none; b=gTQBIui/ey9ttTdvnkbKVI8RxBBR8NO0m/0NM+EHudlowp6fAUrdPyuUhmgGhmoScJLnO91kjJtCDbYnYqyu9zJSFShobkkpXKQ5JosmstX+hvzmb3Gwcy7N6VXGUjuGJVPmpHBgtmODYElwmB0S0sXtCDajQVeyomYT8RzhCy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049904; c=relaxed/simple;
	bh=T9Zx3vwiTM2+Y33sAeLf5h/TrHKcCQaaj6zPvVbWKLI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GKhq1FfDjbHDqhtGjHyaHD7i0Q6b2DFk8SRDwEycp2cfFJbWSHVOcLxaube0Xc8rBdc1Jic2PptfwN9lB03wx4XN47gbGDuPfswD3OsvEGeBnUUO+aOeLDbfBADzkeleIDHYycKYUOb0zeKyWHDgoNE+noNUT9hMdtjGs2816QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrcgEjv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBE1C4CEDD;
	Mon,  7 Apr 2025 18:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049903;
	bh=T9Zx3vwiTM2+Y33sAeLf5h/TrHKcCQaaj6zPvVbWKLI=;
	h=From:To:Cc:Subject:Date:From;
	b=SrcgEjv/0zn7SHt5Cn20D44fNBPcynp4a9gCnUj2zh/+UhXcJsSdDMhYIDxfLzNBz
	 xCHpyOK7H54cvFgejS+2V5qy/G17McHxSkam7kJBWzemVvKRa6oAfchrmJIPO9kTbm
	 xTkcwe/khm3V1bhqmjvLXXwjs2bnFJtlwnTgK8ehWojxkQXg0fA1FzjW+prEQcJbv1
	 u40UdH1FUG+3d9b3hR/4Dm6mlysXqM6FFQeIXJS5dGJPlSCjWKm6hcCBBWGm8NfXt6
	 HUgHxv44IBxoq6b+ODICD4qfMqf81xRUEn8mZ+zDAk64xhFq0Z6i3tdEa8xZAZDidT
	 l9YxruOn99iOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>,
	dennis.dalessandro@cornelisnetworks.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/2] qibfs: fix _another_ leak
Date: Mon,  7 Apr 2025 14:18:18 -0400
Message-Id: <20250407181819.3184695-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
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
index e336d778e076e..5ec67e3c2d03c 100644
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -56,6 +56,7 @@ static int qibfs_mknod(struct inode *dir, struct dentry *dentry,
 	struct inode *inode = new_inode(dir->i_sb);
 
 	if (!inode) {
+		dput(dentry);
 		error = -EPERM;
 		goto bail;
 	}
-- 
2.39.5


