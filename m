Return-Path: <linux-rdma+bounces-2218-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB66E8BA1CF
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 23:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003FD1C21F74
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 21:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9765117F361;
	Thu,  2 May 2024 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="hEFt0eUQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8424E1E86E
	for <linux-rdma@vger.kernel.org>; Thu,  2 May 2024 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714683964; cv=none; b=BA0ERNw3OUeU8srcVgx2uoJuUVkRPdj08uWO1iabqtwFbZssuMKLy/ZxD+3rfr8G1u0GKhfwLoPy+TpoeWkUv85SePrpQTp89wtVICC33Zm3TuabZe2vexsdtL4kTkyh7JJsvtnnCnMvAFqZaQq7Tzz2b8u0ODtIIrxdDmHQKEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714683964; c=relaxed/simple;
	bh=Ipr6SNWbbredLqkojfAoXFmAWSXDyD5VoO8RXDfeSR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=apRqLzDk8RE5GlAXmi2eUohRB3az/nU2W274DuFKI3srSc7fzgwzD3BXCUOF0N5pTSxyOklCEEad61MwyCXLH6rymg+j9eLZsqRI68zaMivh0NIPON38djUyMxu8mV+lQnAK+ghmXsxhh3VPKPyZqVS3SJX3LZJbx2bGSsnrTp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=hEFt0eUQ; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=LQpRwhExx7UwX+
	TVK1vhp2G/9LdRPROHUaIsPhf4yWc=; b=hEFt0eUQfKxFyf8KnIErz+zFiuBIYS
	lf+Wkc2rs8d/8MkigGsk/F10hZ14N16VUGMEZP8iCrmW9E1edQ+h/UsMcP3XHvz9
	Fl15JH+cJlVyWb+pHyKz0f1nEdgaHecwEA/LzXaMmJLu4ENxyfKPJtLxU7uUGW+U
	TZZWtNoZv8CbQ8f/Bk2lsdikHjq8PC65WL6WKNvJ3F+8rtcfZcDMukusvv6mw7RN
	24KKUHS9jb3NyOxsQu9XDyYJJQUgSVAkCTgNylZibNDMLqEqd9Uoi9HvYf9SDH1V
	wZO6oUIYvWQdZV5BJtt79cHNLzawyIVAx8Mqc56at+Z+N5Z4JM70TMlg==
Received: (qmail 3366869 invoked from network); 2 May 2024 23:06:00 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 May 2024 23:06:00 +0200
X-UD-Smtp-Session: l3s3148p1@d8lY+H4XstVehhrT
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-rdma@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 1/1] IB: sw: rdmavt: mr: use 'time_left' variable with wait_for_completion_timeout()
Date: Thu,  2 May 2024 23:05:59 +0200
Message-ID: <20240502210559.11795-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_timeout() causing patterns like:

	timeout = wait_for_completion_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/infiniband/sw/rdmavt/mr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
index 7a9afd5231d5..689e708032fd 100644
--- a/drivers/infiniband/sw/rdmavt/mr.c
+++ b/drivers/infiniband/sw/rdmavt/mr.c
@@ -441,7 +441,7 @@ static void rvt_dereg_clean_qps(struct rvt_mregion *mr)
  */
 static int rvt_check_refs(struct rvt_mregion *mr, const char *t)
 {
-	unsigned long timeout;
+	unsigned long time_left;
 	struct rvt_dev_info *rdi = ib_to_rvt(mr->pd->device);
 
 	if (mr->lkey) {
@@ -451,8 +451,8 @@ static int rvt_check_refs(struct rvt_mregion *mr, const char *t)
 		synchronize_rcu();
 	}
 
-	timeout = wait_for_completion_timeout(&mr->comp, 5 * HZ);
-	if (!timeout) {
+	time_left = wait_for_completion_timeout(&mr->comp, 5 * HZ);
+	if (!time_left) {
 		rvt_pr_err(rdi,
 			   "%s timeout mr %p pd %p lkey %x refcount %ld\n",
 			   t, mr, mr->pd, mr->lkey,
-- 
2.43.0


