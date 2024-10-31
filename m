Return-Path: <linux-rdma+bounces-5658-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEF19B799F
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 12:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9378BB26D52
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 11:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963E019939E;
	Thu, 31 Oct 2024 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSaOeVWe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D6A155322
	for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2024 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730373784; cv=none; b=oLpv1wF3IgA/N1yu2A5pyA8rkvDqXrDtCTlRrl9bm5wE7D1uj9NYHs5OHhQ3kPc+zJpJYTCCV8COwLg2KHhUna1rlv+5PAwZp3xEn0R8cuBBplNlEgIXCCcinSuVfR6TFd0uc1k1PkjHzbHPWXun796sVgbmCYEy5Wji2f9xItE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730373784; c=relaxed/simple;
	bh=ofeNdvndLsDQ0uUhENLq8lnmans71PeCPGxg8dYoEts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTGzYcdork6kgzF5K1ecax+OrOcJzedRU3kOXCcU8kVUJ9AAZD22t9LZtfqmos0DzOZS3MxbiIfxpANpZ5mSsxdz13NurLyCkbwkJ8jqY6oJvoWd1aTpnsY0VBz1DEes4fIom64xg267kcGd17BrWeWIJjvKzQMSTlwtXT4OYIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSaOeVWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE1CC4CEDC;
	Thu, 31 Oct 2024 11:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730373784;
	bh=ofeNdvndLsDQ0uUhENLq8lnmans71PeCPGxg8dYoEts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fSaOeVWe+SdzTvNEONrUw+JMNUkNMuJvIT6rELqwixVV2Oi6agkQXMzSABknA6bGl
	 Ozp09uTHHwu+B33oXyOeXQQhjFTDRYC4gQQkL1SRRvHm2jDtQFv9nK0coyYfjW9nA6
	 5sigoJOlsgbu9nWWcZqJKuxZsaDDpUD8DInVFepTwtdJgfSNZytA67j7DnyewuYt3v
	 Kz93MvVK841LL5IzB6ZyC747WXKOMR1h2xtqdO2wd6RtS3xUJWp0JLnq6ouVXRO8J0
	 bhvkfebyu0HFJiIcxaOcB7/i6fCETm1VOaUxPHU/MIBF7qDfqv3ySbdADQyU9axerk
	 ZN+9R4AW5UwQg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 1/3] RDMA/core: Add device ufile cleanup operation
Date: Thu, 31 Oct 2024 13:22:51 +0200
Message-ID: <cabe00d75132b5732cb515944e3c500a01fb0b4a.1730373303.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1730373303.git.leon@kernel.org>
References: <cover.1730373303.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Add a driver operation to allow preemptive cleanup of ufile HW resources
before the standard ufile cleanup flow begins. Thus, expediting the
final cleanup phase which leads to fast teardown overall.

This allows the use of driver specific clean up procedures to make the
cleanup process more efficient.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c    | 1 +
 drivers/infiniband/core/rdma_core.c | 7 ++++++-
 include/rdma/ib_verbs.h             | 6 ++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 93c6d27b5d8f..ca9b956c034d 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2760,6 +2760,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, resize_cq);
 	SET_DEVICE_OP(dev_ops, set_vf_guid);
 	SET_DEVICE_OP(dev_ops, set_vf_link_state);
+	SET_DEVICE_OP(dev_ops, ufile_hw_cleanup);
 
 	SET_OBJ_SIZE(dev_ops, ib_ah);
 	SET_OBJ_SIZE(dev_ops, ib_counters);
diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 29b1ab1d5f93..02ef09e77bf8 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -880,9 +880,14 @@ static void ufile_destroy_ucontext(struct ib_uverbs_file *ufile,
 static int __uverbs_cleanup_ufile(struct ib_uverbs_file *ufile,
 				  enum rdma_remove_reason reason)
 {
+	struct uverbs_attr_bundle attrs = { .ufile = ufile };
+	struct ib_ucontext *ucontext = ufile->ucontext;
+	struct ib_device *ib_dev = ucontext->device;
 	struct ib_uobject *obj, *next_obj;
 	int ret = -EINVAL;
-	struct uverbs_attr_bundle attrs = { .ufile = ufile };
+
+	if (ib_dev->ops.ufile_hw_cleanup)
+		ib_dev->ops.ufile_hw_cleanup(ufile);
 
 	/*
 	 * This shouldn't run while executing other commands on this
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 67551133b522..3417636da960 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2675,6 +2675,12 @@ struct ib_device_ops {
 	 */
 	void (*del_sub_dev)(struct ib_device *sub_dev);
 
+	/**
+	 * ufile_cleanup - Attempt to cleanup ubojects HW resources inside
+	 * the ufile.
+	 */
+	void (*ufile_hw_cleanup)(struct ib_uverbs_file *ufile);
+
 	DECLARE_RDMA_OBJ_SIZE(ib_ah);
 	DECLARE_RDMA_OBJ_SIZE(ib_counters);
 	DECLARE_RDMA_OBJ_SIZE(ib_cq);
-- 
2.46.2


