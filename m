Return-Path: <linux-rdma+bounces-9213-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B539A7EB66
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 20:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58950188E8D6
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 18:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B5927CB0A;
	Mon,  7 Apr 2025 18:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qp9o+a3V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6B727CB03;
	Mon,  7 Apr 2025 18:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049887; cv=none; b=ojucuY0uY1mZWYkY0vQz//AIges9qjl45rRSpAjgKbfF1yCHfb/+7t/qnGi/g0ghxGJr40wd0Gwg8de6S7A/7otkylAct3IrcbcP2eVTTqLyNb7S3nYdDPRNfhO5JmGL4M0evdvZyhwBXH6Q1uhkg4SPEvzk3h6Dk/eLwBgsIss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049887; c=relaxed/simple;
	bh=NFHCqJi8j7Nd/g6ez6yrOaWj7clDwODpTXA2tTVuLhI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S7DJ9xs9cvkY1zCmcg/JeSN1Buue1u9FSb0OCs7JnllpabTrT82sDcvr9FoudsFXzLbP608sr0wZhQAXDVzqVpvquuNEsMo4vKkONRdpC0y/LY9lTD81AcxtzBzkJ/lBL5DRgAty0RNpV9UHWN4bogHiNMxFLFlF8kbNGEQgalo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qp9o+a3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E56DC4CEE9;
	Mon,  7 Apr 2025 18:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049886;
	bh=NFHCqJi8j7Nd/g6ez6yrOaWj7clDwODpTXA2tTVuLhI=;
	h=From:To:Cc:Subject:Date:From;
	b=Qp9o+a3VAiTeLEw9oZPZ41NeIeOl2jCzb3a8ltcb22CRd6JNCo2x72c+LuRABZ1NO
	 YPx+kDx5iRmG+AzKrXe54ZDWVO+tcCHPe7Y9aoQgf/gWnvTJS6UAsR+2F1PkefK8fO
	 0FqxYqq1VmKhGhETiQUrNt2qt5+jiFK0lEfXVtcKzF32eGCRPJYdI8NFEGS5nErTfp
	 Oxmzs1tvMnZ1darKdHkIKlX0CnClOOixM4sGrp/foEUr32ulQSnIj4q3XBHzi997e0
	 v49G1J0Ms6ptJciQ+3EICxRxY/tk2f02SNKS0UfhsQxmHLxG4hfE+UDszlOXwxIrGk
	 XjP9sQblWo+dA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>,
	dennis.dalessandro@cornelisnetworks.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 1/2] qibfs: fix _another_ leak
Date: Mon,  7 Apr 2025 14:18:00 -0400
Message-Id: <20250407181802.3184614-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
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
index 8665e506404f9..774037ea44a92 100644
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


