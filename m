Return-Path: <linux-rdma+bounces-2632-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5558D1BB8
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 14:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE0F1C21FB9
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 12:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61D916DEC3;
	Tue, 28 May 2024 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMjhTSqD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6779F16DEB0
	for <linux-rdma@vger.kernel.org>; Tue, 28 May 2024 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900808; cv=none; b=juSiYxV6kw0bjGzQ7lMDKYk87UacApZVVjKa4F6HAHvV/WkEk6zUu8Kh7UCpaYzhVUfcMYZ5qBKYeRsG4VsEs8P8IkbPsWoJQdQLI/lrVmsJaCtDQt290OqsyQWhLdy3AmX3J+8XEGB/msSQctopqlcnWSvyaui6l2kHlNwzXZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900808; c=relaxed/simple;
	bh=8b1Gin9FaAJQpL4LJCGBu7mBYgjW+aJMJ3DuG0aHCh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=an3cUilfHeADbMSEHOtCQIm289cNiyV2RDr3FNyLmcUIt50pFUBvNxvXi1Tvg7hwjS4c61w7prcrqtHnnl5cuKV2DYZpUEP9uAXUIa3BrtW7k0IC6rL7JSbTRjByrZRykWdh+BD5Qc7fkGnMSFfBnqw/3ihZxyFAbblY4AXvkCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMjhTSqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59686C3277B;
	Tue, 28 May 2024 12:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716900807;
	bh=8b1Gin9FaAJQpL4LJCGBu7mBYgjW+aJMJ3DuG0aHCh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FMjhTSqDVj8rVvLrBDoSJ5K32lcqGBO07nuL4qsuD/bQo+KluVZYZMnmMvpkS66Vg
	 VABZzF9Gr+pY5noPDMzOcjv7jEJ/95GCidIhrepvfM65/yvMNtqHEYtGM8AOluuUqo
	 FPj2VUPilQdXsSrWKVTxnnSPpHMC2QEhbGRMX860Zqp2LQrWm6cPvrzCyCWYdVpLx7
	 PUCTZUSF230oRzhb456ERi89LY0+IZueZofEmVAbqdBL4h+M/Wd1zYnIU4IpUNh6BV
	 lGARCMCbJTDQRr9dxavl6DqbLapbC5w2+4cqSJ6tLZ5axZ5nxFwRCl72ADey2RtjfX
	 JnSNT6wBJSFEw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Mark Zhang <markzhang@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-rc 1/6] RDMA/cache: Release GID table even if leak is detected
Date: Tue, 28 May 2024 15:52:51 +0300
Message-ID: <a62560af06ba82c88ef9194982bfa63d14768ff9.1716900410.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716900410.git.leon@kernel.org>
References: <cover.1716900410.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

When the table is released, we nullify pointer to GID table, it means
that in case GID entry leak is detected, we will leak table too.

Delete code that prevents table destruction.

Fixes: b150c3862d21 ("IB/core: Introduce GID entry reference counts")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cache.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index c02a96d3572a..aa62c8c7ca75 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -794,7 +794,6 @@ static struct ib_gid_table *alloc_gid_table(int sz)
 static void release_gid_table(struct ib_device *device,
 			      struct ib_gid_table *table)
 {
-	bool leak = false;
 	int i;
 
 	if (!table)
@@ -803,15 +802,11 @@ static void release_gid_table(struct ib_device *device,
 	for (i = 0; i < table->sz; i++) {
 		if (is_gid_entry_free(table->data_vec[i]))
 			continue;
-		if (kref_read(&table->data_vec[i]->kref) > 1) {
-			dev_err(&device->dev,
-				"GID entry ref leak for index %d ref=%u\n", i,
-				kref_read(&table->data_vec[i]->kref));
-			leak = true;
-		}
+
+		dev_err(&device->dev,
+			"GID entry ref leak for index %d ref=%u\n", i,
+			kref_read(&table->data_vec[i]->kref));
 	}
-	if (leak)
-		return;
 
 	mutex_destroy(&table->lock);
 	kfree(table->data_vec);
-- 
2.45.1


