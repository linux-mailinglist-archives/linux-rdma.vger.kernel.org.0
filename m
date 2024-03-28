Return-Path: <linux-rdma+bounces-1634-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 416128901DC
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Mar 2024 15:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EFDD1C2CA9C
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Mar 2024 14:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E87A130E45;
	Thu, 28 Mar 2024 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WanTW1Lx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C6112EBC3;
	Thu, 28 Mar 2024 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636328; cv=none; b=CI6JyHWPs7c6EUY7d1gfUKdtOz93HQxy3IXBMd41Cb32lfEbCcxLLExpiebbcn+DQrvDZMdMlStclx1cPh3k7EqnLQyVPW///uZpjGpmofp3iNZD7VBtNRso6o0wWnbj72LDc0UfvcFAu7PYeiQB8bgyHb5yPXF/epdg+3TbmIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636328; c=relaxed/simple;
	bh=5/qbxUkF4XswjPzTkOHdQkkFpw7qxD+eOfPSj/d7hr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m4a7n+UKtvSLhlhVFBrx5upet8qpSctGA+/efERpYQGd6VGSVbDXLmDBsAo4UvzfQotKIydnBFz/3u4OJwQdYanQhwfWIJOJyIR3a6K3rWLeWcRlICALfXNoo2v+cLrc3jRu5xVaITfNRUFKJPbzVLK2maVR94JC//g31ryYlF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WanTW1Lx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37564C433C7;
	Thu, 28 Mar 2024 14:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711636327;
	bh=5/qbxUkF4XswjPzTkOHdQkkFpw7qxD+eOfPSj/d7hr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WanTW1LxmCiyp25kaYKbNaTCXXDTjSDownunWR9JZmRwCTDNGNQxSdcnN1xIHNJSo
	 L3iz0NAMG51wKLLXAlB1NEoMc2VAFg39cTLa913tDH1T7eeD2GRVJ4Z+0XsQ4WJSsY
	 660ztX8dQxR2cUwhRiT/l/cnSgF4JNtWwG1w9ZFzZe5w2BTNo0c1tVmwOmnH3Dnj2d
	 x1ut9KB1UHF61fzwASMGFwpRm0+BHMHInvkysZnnPuxhZ6qHDwC2L/S/wFzEJzWpd9
	 pCH3aAxaKW2O4hhYvNdWZV95xXK6FFGhvvuqOVqVJi38rornVhrtKjryCxqQ/fhdNQ
	 NIHFYujkzPDtw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-rdma@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 7/9] infiniband: uverbs: avoid out-of-range warnings
Date: Thu, 28 Mar 2024 15:30:45 +0100
Message-Id: <20240328143051.1069575-8-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328143051.1069575-1-arnd@kernel.org>
References: <20240328143051.1069575-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang warns for comparisons that are always true, which is the case
for these two page size checks on architectures with 64KB pages:

drivers/infiniband/core/uverbs_ioctl.c:90:39: error: result of comparison of constant 65536 with expression of type 'u16' (aka 'unsigned short') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
        WARN_ON_ONCE(method_elm->bundle_size > PAGE_SIZE);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
include/asm-generic/bug.h:104:25: note: expanded from macro 'WARN_ON_ONCE'
        int __ret_warn_on = !!(condition);                      \
                               ^~~~~~~~~
drivers/infiniband/core/uverbs_ioctl.c:621:17: error: result of comparison of constant 65536 with expression of type '__u16' (aka 'unsigned short') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
        if (hdr.length > PAGE_SIZE ||
            ~~~~~~~~~~ ^ ~~~~~~~~~

Add a cast to u32 in both cases, so it never warns about this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/core/uverbs_ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
index f80da6a67e24..e0cc3ddae71b 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -90,7 +90,7 @@ void uapi_compute_bundle_size(struct uverbs_api_ioctl_method *method_elm,
 		ALIGN(bundle_size + 256, sizeof(*pbundle->internal_buffer));
 
 	/* Do not want order-2 allocations for this. */
-	WARN_ON_ONCE(method_elm->bundle_size > PAGE_SIZE);
+	WARN_ON_ONCE((u32)method_elm->bundle_size > PAGE_SIZE);
 }
 
 /**
@@ -636,7 +636,7 @@ long ib_uverbs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	if (err)
 		return -EFAULT;
 
-	if (hdr.length > PAGE_SIZE ||
+	if ((u32)hdr.length > PAGE_SIZE ||
 	    hdr.length != struct_size(&hdr, attrs, hdr.num_attrs))
 		return -EINVAL;
 
-- 
2.39.2


