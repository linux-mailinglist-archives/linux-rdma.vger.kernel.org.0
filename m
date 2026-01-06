Return-Path: <linux-rdma+bounces-15324-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 301C5CF83CA
	for <lists+linux-rdma@lfdr.de>; Tue, 06 Jan 2026 13:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 976C93014BDB
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jan 2026 12:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65311327204;
	Tue,  6 Jan 2026 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UqVRIuNd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7232B32720E
	for <linux-rdma@vger.kernel.org>; Tue,  6 Jan 2026 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767701098; cv=none; b=Cc+G8F4lu2f/N0Ajp164eQjFFAH7O0ZRi6EEou4gGTrt5DRoN6Ik0jeXdJNepcM6ug95qmobdyea3A8LaBuzBWDH68vl7+WjlG7AIyqPyhVP3KTZhfhQV/4qZhvaqJpSuGmP+0LMJ2K9wGy5q+2PafQkf86Vt/k5I9/DzGjuDdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767701098; c=relaxed/simple;
	bh=1OPRuptt0l14knqkqCrZZFFsnVxvjV8Qkglu8nuiUvU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YKWz7fT6dtsH1N5Qjj7qZojI+Bt7fMdfkfKlAaksPFTVOqnTItkCSdxl0cJDS/OD0xbaC+//aPb4kv/RGCie/QkGhQK8EegE5c/xELDuRqSSVQdVnPdokK9IOnOakqrNaClUkIer+kxZi+VK/n6ZHz/GHFqJhK2G28LuiTUEKsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UqVRIuNd; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767701091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FM1Id0090aj7tXLDWwQBlYAxu8vqhdxEtiN13OtC5DM=;
	b=UqVRIuNd730qmmufDYrFtNwtSYC4r5H3v8izRf1Tk8woyPhPOcW8F1QixxSLAGH7Fukfuy
	VUj/IQd/KiUQ2NeRBQFSUlfSY1YZunc7uiA99ctvsyzw2WR7LfoVkULTO2eaGMYnuNgT3v
	k8Ip9E/JvPsM9cWupP4yl0HYn/pheEw=
From: sunliming@linux.dev
To: siva.kallam@broadcom.com,
	gg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunliming <sunliming@kylinos.cn>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH] RDMA/bng_re: fix variable dereferenced before check in bng_re_net_ring_free()
Date: Tue,  6 Jan 2026 20:03:43 +0800
Message-Id: <20260106120343.54758-1-sunliming@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: sunliming <sunliming@kylinos.cn>

Fix below smatch warnings:
drivers/infiniband/hw/bng_re/bng_dev.c:113 bng_re_net_ring_free() warn:
variable dereferenced before check 'rdev'

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202601010413.sWadrQel-lkp@intel.com/
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 drivers/infiniband/hw/bng_re/bng_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
index d8f8d7f7075f..c32395d1593f 100644
--- a/drivers/infiniband/hw/bng_re/bng_dev.c
+++ b/drivers/infiniband/hw/bng_re/bng_dev.c
@@ -118,7 +118,7 @@ static void bng_re_fill_fw_msg(struct bnge_fw_msg *fw_msg, void *msg,
 static int bng_re_net_ring_free(struct bng_re_dev *rdev,
 				u16 fw_ring_id, int type)
 {
-	struct bnge_auxr_dev *aux_dev = rdev->aux_dev;
+	struct bnge_auxr_dev *aux_dev;
 	struct hwrm_ring_free_input req = {};
 	struct hwrm_ring_free_output resp;
 	struct bnge_fw_msg fw_msg = {};
@@ -127,6 +127,7 @@ static int bng_re_net_ring_free(struct bng_re_dev *rdev,
 	if (!rdev)
 		return rc;
 
+	aux_dev = rdev->aux_dev;
 	if (!aux_dev)
 		return rc;
 
-- 
2.25.1


