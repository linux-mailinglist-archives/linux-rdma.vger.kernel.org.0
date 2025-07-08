Return-Path: <linux-rdma+bounces-11957-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB57AFC71B
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 11:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E59767A30B9
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 09:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A3822FDFF;
	Tue,  8 Jul 2025 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W38ARoRv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0DF2264A1
	for <linux-rdma@vger.kernel.org>; Tue,  8 Jul 2025 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751967108; cv=none; b=SsvgE39LgWElVYZNPXKi/g0wrGlBDbKmWSzfri6C6Ir4XWFF8FO+MKbyONWEW6B+WkTBbl8KySFD4E3zLmyzOjsdVYKmuT9SvhNTg2iuEoHtooWqqMNHdldzN6vtGrl27YgKr7fAtKWBIomdN4iIUvYmFvgnk/AGk1+Oe53a6to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751967108; c=relaxed/simple;
	bh=7nj3tdVxANE8rmdEvbmgJN93ELQ85p+/nC8aqJH0gko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PvtS6d2WclP1F3eGz1ldvSzL/ZcNNw05rTjHHy/UFGtUgvAatCotChu0yL3hRN+wjzItQYr2RRnsZg0WVa40yRinLuFrbfXJffy3s/bKejM8gGphyVfas5gPAPmN0lrrkX8OlBCNYQTC3NjpN6B/ncfpH/thgEoJah86Kxdf0ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W38ARoRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF30C4CEED;
	Tue,  8 Jul 2025 09:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751967108;
	bh=7nj3tdVxANE8rmdEvbmgJN93ELQ85p+/nC8aqJH0gko=;
	h=From:To:Cc:Subject:Date:From;
	b=W38ARoRvYWYmYjm+G+CfaeaQgizuYEHiGr/1viuQbzMCSORu2s3fytnx/eOVJREbc
	 s60VUa59EUvDVfQ2YB6oW5frkr2UZj+3UjVHDtD4n/1YFYAetwLtfbo/wOITeLr9mQ
	 VNI4QaNc+dL3K9QKEjCYl1xTBPVhTgNAMaxTSaNCP4ycy+uYIv4EbX2jT7SRDW2m/e
	 DrOstY+S7Qv62QzkxPyjlBh1vO9IeMoBvSUlTDDwVxUEgTS7c9+eU+qTm2uOlyfEdg
	 F/LUzYAj0OycCKTVdyHw83wbay5ZAzDp8UoCPk1rA4yYvqhkyxL/vA5Dk8UTRz2xsQ
	 x2Ew8NU02IC0Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	kernel test robot <lkp@intel.com>,
	linux-rdma@vger.kernel.org,
	Parav Pandit <parav@nvidia.com>
Subject: [PATCH rdma-next] RDMA/uverbs: Add empty rdma_uattrs_has_raw_cap() declaration
Date: Tue,  8 Jul 2025 12:31:39 +0300
Message-ID: <72dee6b379bd709255a5d8e8010b576d50e47170.1751967071.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

The call to rdma_uattrs_has_raw_cap() is placed in mlx5 fs.c file,
which is compiled without relation to CONFIG_INFINIBAND_USER_ACCESS.

Despite the check is used only in flows with CONFIG_INFINIBAND_USER_ACCESS=y|m,
the compilers generate the following error for CONFIG_INFINIBAND_USER_ACCESS=n
builds.

>> ERROR: modpost: "rdma_uattrs_has_raw_cap" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!

Fixes: f458ccd2aa2c ("RDMA/uverbs: Check CAP_NET_RAW in user namespace for flow create")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507080725.bh7xrhpg-lkp@intel.com/
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/rdma/ib_verbs.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index c263327a0205..ce4180c4db14 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4841,15 +4841,19 @@ struct ib_ucontext *ib_uverbs_get_ucontext_file(struct ib_uverbs_file *ufile);
 
 #if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 int uverbs_destroy_def_handler(struct uverbs_attr_bundle *attrs);
+bool rdma_uattrs_has_raw_cap(const struct uverbs_attr_bundle *attrs);
 #else
 static inline int uverbs_destroy_def_handler(struct uverbs_attr_bundle *attrs)
 {
 	return 0;
 }
+static inline bool
+rdma_uattrs_has_raw_cap(const struct uverbs_attr_bundle *attrs)
+{
+	return false;
+}
 #endif
 
-bool rdma_uattrs_has_raw_cap(const struct uverbs_attr_bundle *attrs);
-
 struct net_device *rdma_alloc_netdev(struct ib_device *device, u32 port_num,
 				     enum rdma_netdev_t type, const char *name,
 				     unsigned char name_assign_type,
-- 
2.50.0


