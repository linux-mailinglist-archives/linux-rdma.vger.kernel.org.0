Return-Path: <linux-rdma+bounces-9824-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75615A9D831
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Apr 2025 08:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D254E9A4241
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Apr 2025 06:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D13A1AA782;
	Sat, 26 Apr 2025 06:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oM+fGOuh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF04717A2F0;
	Sat, 26 Apr 2025 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647973; cv=none; b=NQhuusmtcXpu250ABaZdIWgQsOqna3tXRuKRKcTsF0pfd7JEklp1MDG3Y+Bw67+oKDMJamWKU7A+mHTe/togG2sWrRr80eUjm9r8diVYmnZIEQ2PH88Uh3xX1caeN/KmGPCp8Vx/GwMQ8Yhm86Z9iSirP+NguP4uSP7m0Dz9fNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647973; c=relaxed/simple;
	bh=eLMzgnp0Tp+zHfC9zxuE9SoevDgje/8MdefHYrG3WkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=imCS0448ELQCb3MG3hivtgMnnWbySp4iZbEos4AzpYry5skAVP/36Jz++p17yeeVK7tVCeU/YcXCHWeKRvCQW1fAH9OHLToquQes0crNoeGi9Tl0lEVTIi+Gd280gYKRIqTBXKOulBjaJLVEELVt/r6raotpRcGLUev452s4LsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oM+fGOuh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E732C4CEE2;
	Sat, 26 Apr 2025 06:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745647972;
	bh=eLMzgnp0Tp+zHfC9zxuE9SoevDgje/8MdefHYrG3WkQ=;
	h=From:To:Cc:Subject:Date:From;
	b=oM+fGOuhhmXUYJT65cR4cHOmCAjXmtYwjxtNsieNJaZKNVm2TggyH9mdlNTBpTsW3
	 xnYYi3ld0Aw3ywsEyfemKgYdrINe5XuPspp0sonWUev/Aajwdi1eRG2HkC6VsBYy9D
	 2Qi0hAZ05LYJIf4Ifllf8F9sLskk+mxlsFDbGdslfmx+jpZl/lXqL6phTYmufKnKYn
	 xP56uDsRRnVxrVajASWHvVGs7CofA4/QAa9NysQzOfaur0KBGxMRJkgAo2WezTGePP
	 o9QY8oTrLvHhUKg0GttnFqVDkZJH9ctlMimliOtQ5gsvdx5HDm3j6l55M02UMf0lul
	 ChSgR6hOxQKqQ==
From: Kees Cook <kees@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Kees Cook <kees@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] IB/hfi1: Adjust fd->entry_to_rb allocation type
Date: Fri, 25 Apr 2025 23:12:48 -0700
Message-Id: <20250426061247.work.261-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1385; i=kees@kernel.org; h=from:subject:message-id; bh=eLMzgnp0Tp+zHfC9zxuE9SoevDgje/8MdefHYrG3WkQ=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk8lfGntNiE5O7/3mrd9XODvPKD7NNCzyZ/01O64XD9R mZg/omlHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABPJFGL4Xxl5SI578W4FNmXB MjZpa6nSL9LCTYEiRhdf/zzbKrvoIyPDwxjHJbw1a8uVhBg2FLhfmap6y23+53nl4n5+WubPdqR zAgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for making the kmalloc family of allocators type aware,
we need to make sure that the returned type from the allocation matches
the type of the variable being assigned. (Before, the allocator would
always return "void *", which can be implicitly cast to any pointer type.)

The assigned type is "struct tid_rb_node **", but the return type will be
"struct rb_node **". These are the same allocation size (pointer size),
but the types do not match. Adjust the allocation type to match the
assignment.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: <linux-rdma@vger.kernel.org>
---
 drivers/infiniband/hw/hfi1/user_exp_rcv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
index cf2d29098406..62b4f16dab27 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -53,7 +53,7 @@ int hfi1_user_exp_rcv_init(struct hfi1_filedata *fd,
 	int ret = 0;
 
 	fd->entry_to_rb = kcalloc(uctxt->expected_count,
-				  sizeof(struct rb_node *),
+				  sizeof(*fd->entry_to_rb),
 				  GFP_KERNEL);
 	if (!fd->entry_to_rb)
 		return -ENOMEM;
-- 
2.34.1


