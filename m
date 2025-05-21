Return-Path: <linux-rdma+bounces-10479-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C8CABF2F0
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 13:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5214D1B683E6
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 11:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A1126460B;
	Wed, 21 May 2025 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUjuMUgb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F7D2641FB
	for <linux-rdma@vger.kernel.org>; Wed, 21 May 2025 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747827378; cv=none; b=YHXQYvdgxb3qayzeZnaiBfeXHJWbJCg5mXW2LHhPb/LZHs+FfGnWC3SEukXyC9nwqbBWagz7ttKvbRo1Y9zdWPxAu5wU7UNQGunpSUkI+npnhqwGTY3ThpdUm1htbWgVgeVKo+2EPhhxCFt0weCmDjkVg8M6iS1OjHNV69OTJdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747827378; c=relaxed/simple;
	bh=goIkCxP1tJ26O1/I2HyezzsuN8puxjjl+9pgZvF1e3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NUZIbOTZzInzuOGx1QhaB9U+U4Eqk5kfclWWhywow6ZJG3uPBw25uUFqFd9qnluTSpYChAHr0dkrC0Wgm5jtoZWCNVrJxPUaVvHf3fG3p+kNI9Cpzg1g3MiFPugGGh3h4kn24SwlbvWUtwYNfxjNNSz0QbX+wvKiVAoyJ0a/dF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUjuMUgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92C3C4CEF1;
	Wed, 21 May 2025 11:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747827377;
	bh=goIkCxP1tJ26O1/I2HyezzsuN8puxjjl+9pgZvF1e3c=;
	h=From:To:Cc:Subject:Date:From;
	b=HUjuMUgbW7NRoE6AqxnmfMlZXhK9GK5bJH18k79udAti3m5OK/O49B9Ni66rWTaMb
	 331aA0v3W9fUuW5ySdG/wan1poSf8DCFi0b6jLsgUl5n+H6StL9cZMJ9QbTl/oz57F
	 SRgwW53HjKyljlVs0ECJnxo3su14/1VduBIElQ3DUY2WxNsd5WH/MPA0TfI2uKyak/
	 4il4A3BHuHSJI/7ClrTmqthNGhNr7sG8g86YqboF/eeP/+zG1D3UnV1QZDN2jy7TtF
	 oyunxF5KQ0bzX2oz8rtFFejjDR474tP8H+xPvBkCI7jXqJ93XKCFgBo9cc2yT/hiSH
	 Ds1Zw4OyYf10Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jack Morgenstein <jackm@nvidia.com>,
	Feng Liu <feliu@nvidia.com>,
	=?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
	linux-rdma@vger.kernel.org,
	Patrisious Haddad <phaddad@nvidia.com>,
	Sharath Srinivasan <sharath.srinivasan@oracle.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: [PATCH rdma-rc] RDMA/cma: Fix hang when cma_netevent_callback fails to queue_work
Date: Wed, 21 May 2025 14:36:02 +0300
Message-ID: <4f3640b501e48d0166f312a64fdadf72b059bd04.1747827103.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Morgenstein <jackm@nvidia.com>

The cited commit fixed a crash when cma_netevent_callback was called for
a cma_id while work on that id from a previous call had not yet started.
The work item was re-initialized in the second call, which corrupted the
work item currently in the work queue.

However, it left a problem when queue_work fails (because the item is
still pending in the work queue from a previous call). In this case,
cma_id_put (which is called in the work handler) is therefore not
called. This results in a userspace process hang (zombie process).

Fix this by calling cma_id_put() if queue_work fails.

Fixes: 45f5dcdd0497 ("RDMA/cma: Fix workqueue crash in cma_netevent_work_handler")
Signed-off-by: Jack Morgenstein <jackm@nvidia.com>
Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index ab31eefa916b3..274cfbd5aaba7 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -5245,7 +5245,8 @@ static int cma_netevent_callback(struct notifier_block *self,
 			   neigh->ha, ETH_ALEN))
 			continue;
 		cma_id_get(current_id);
-		queue_work(cma_wq, &current_id->id.net_work);
+		if (!queue_work(cma_wq, &current_id->id.net_work))
+			cma_id_put(current_id);
 	}
 out:
 	spin_unlock_irqrestore(&id_table_lock, flags);
-- 
2.49.0


