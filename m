Return-Path: <linux-rdma+bounces-1550-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF70988B13E
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 21:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8045F1F62906
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 20:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E10B45033;
	Mon, 25 Mar 2024 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGjiBMZJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DA543AB6;
	Mon, 25 Mar 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398250; cv=none; b=Es34zwfLTqEwrBZGQbPEHJQaWEOOLbpAFu9FTgTxau3V2I7VHEcBkADeF6+IWDN7OXsTxlm5bxS9sR2iaEt4ucWnmGCii/vJx7SI3ZbAbxs2PB8bPOUsr3RuuSLBVjwEl1QH85BCy9JOf18siUkdoq0HUeTlzTSsfs+CYlvNjd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398250; c=relaxed/simple;
	bh=s4mxlWFOQHsHeS33PiyHipgWfd/TWr7AQKJn8SBt0b4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O2AOyOLkFXd3k604kDY7L9rSYACKExphR60LIBchlcZznb1lDXkXrEtXVJz0giSCiHIfyT73Z4Ivf/sS5YJGruy25NLmvnmyDRnMXW9qwAkjJ4lmSlUVOG8NbyiWZPPqmylbq6z2n+0dwM+sM4BLHr9OvDkL6Q432FStNyeV0j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGjiBMZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D26C433F1;
	Mon, 25 Mar 2024 20:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711398249;
	bh=s4mxlWFOQHsHeS33PiyHipgWfd/TWr7AQKJn8SBt0b4=;
	h=Date:From:To:Cc:Subject:From;
	b=KGjiBMZJdEp8z12YgVYHXGqAElUMr5TUVI1UZfcxsXWAgZqcigfebkrckxkkTw+jh
	 JLgwdPYIGVbo6HCnRdKVc06iEUdb6nRMzAoG73t3B8AKCCKH+9qkjA2fxi/NJ8E5AT
	 SrnTJ9MsM2gMsKxaTXkK/tp99WtQDkK7G9uZadbkZbsoDSgmrRc7fBErGrMLPSgMpH
	 B4Z4DbyPnlK3m/kHvPkfzuiE3U415PHmAbC9ihYwrWLQe323SNjZgiZywBt7eqRPzW
	 s4j4JkMb/qf/ebZl+BdeGF/APtOUVBH/GEgRw5dzNneIKSGYHWx9DhH/vyFj5GywsI
	 /9OUfIFrl0a8w==
Date: Mon, 25 Mar 2024 14:24:07 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] RDMA/cm: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <ZgHdZ15cQ7MIHsGL@neat>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally.

Use the `struct_group_tagged()` helper to separate the flexible array
from the rest of the members in flexible `struct cm_work`, and avoid
embedding the flexible-array member in `struct cm_timewait_info`.

Also, use `container_of()` to retrieve a pointer to the flexible
structure.

So, with these changes, fix the following warning:
drivers/infiniband/core/cm.c:196:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/infiniband/core/cm.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index bf0df6ee4f78..80c87085499c 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -182,18 +182,21 @@ struct cm_av {
 };
 
 struct cm_work {
-	struct delayed_work work;
-	struct list_head list;
-	struct cm_port *port;
-	struct ib_mad_recv_wc *mad_recv_wc;	/* Received MADs */
-	__be32 local_id;			/* Established / timewait */
-	__be32 remote_id;
-	struct ib_cm_event cm_event;
+	/* New members must be added within the struct_group() macro below. */
+	struct_group_tagged(cm_work_hdr, hdr,
+		struct delayed_work work;
+		struct list_head list;
+		struct cm_port *port;
+		struct ib_mad_recv_wc *mad_recv_wc;	/* Received MADs */
+		__be32 local_id;			/* Established / timewait */
+		__be32 remote_id;
+		struct ib_cm_event cm_event;
+	);
 	struct sa_path_rec path[];
 };
 
 struct cm_timewait_info {
-	struct cm_work work;
+	struct cm_work_hdr work;
 	struct list_head list;
 	struct rb_node remote_qp_node;
 	struct rb_node remote_id_node;
@@ -3440,7 +3443,7 @@ static int cm_timewait_handler(struct cm_work *work)
 	struct cm_timewait_info *timewait_info;
 	struct cm_id_private *cm_id_priv;
 
-	timewait_info = container_of(work, struct cm_timewait_info, work);
+	timewait_info = container_of(&work->hdr, struct cm_timewait_info, work);
 	spin_lock_irq(&cm.lock);
 	list_del(&timewait_info->list);
 	spin_unlock_irq(&cm.lock);
-- 
2.34.1


