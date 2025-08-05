Return-Path: <linux-rdma+bounces-12588-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC078B1B476
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Aug 2025 15:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B653918A45B6
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Aug 2025 13:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B4427510C;
	Tue,  5 Aug 2025 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xlcxum7L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85957276049;
	Tue,  5 Aug 2025 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399505; cv=none; b=mSpoAdyG5GlCobR4k+qgRXVdAnqBDL5+libugDbsukN8RqdIDeCHZivuebc7NJ3JWgQfXnIQ+AxCK+iGoFf3aEnAFnD2YF2k+k4aEn22ihqOqr28drpWThhk+l1VDlwuGGDtWXwxjub9YTec0nXRpl2oWoXhhloaJErRK3Wh1dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399505; c=relaxed/simple;
	bh=XlRRW7J0SgjweNCzL6+/uPhiEFwo+fUWbFL65dx6opk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tnO5JtMGWBHiYUbldfKEKeRE0nDcgOnE5psijiiKIuuJeM0GrKvdbO1uPmOsN0SJdkaqXSKSAi8h8mgvee4/EleFyUAln+mbWr4ufRZx0K5+IbU9KYcDnkrYfr5/ESZ/Su93JAhcyG7FDTKvnr9rUyaptZotS7Xm+tlwDCraDKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xlcxum7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4009C4CEF4;
	Tue,  5 Aug 2025 13:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754399505;
	bh=XlRRW7J0SgjweNCzL6+/uPhiEFwo+fUWbFL65dx6opk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xlcxum7L01NhQLbSMnfnyWbFy3INzpQRclcNfT42K3vVDD6x1VtCXXhKnjE6ek+vb
	 l3BXTcwOAsLpoBWSzMzyQP5rHowopGhagAkD9t9psnrECcGwL25bnNBlQiVG+e8+Lc
	 WvkYxVVFJwLOx8xoxW59TOnpndAHAEvcMS0cN8HdjD4rVbOaav9p2ZR60wxlXGADFa
	 6TBCmbWW+6XfzoV0pYfZFLlIgnLo+bQvbu92lfqrQdqhDMvnnUIsH7I/IWi+xdjMTt
	 iZ6zI8cWDfVu8vtFgLIBp/pkxVYpQZNyj4ohQTL1GIw5dhKQesKq+jCSo8bBOXPert
	 JX+k/shqI2eDg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Shravya KN <shravya.k-n@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	selvin.xavier@broadcom.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16-6.12] RDMA/bnxt_re: Fix size of uverbs_copy_to() in BNXT_RE_METHOD_GET_TOGGLE_MEM
Date: Tue,  5 Aug 2025 09:09:28 -0400
Message-Id: <20250805130945.471732-53-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250805130945.471732-1-sashal@kernel.org>
References: <20250805130945.471732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16
Content-Transfer-Encoding: 8bit

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

[ Upstream commit 09d231ab569ca97478445ccc1ad44ab026de39b1 ]

Since both "length" and "offset" are of type u32, there is
no functional issue here.

Reviewed-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Signed-off-by: Shravya KN <shravya.k-n@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Link: https://patch.msgid.link/20250704043857.19158-2-kalesh-anakkur.purayil@broadcom.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Clear Bug Fix**: The commit fixes a genuine copy-paste error where
   `sizeof(length)` was incorrectly used instead of `sizeof(offset)`
   when copying the offset value to userspace in line 4749. This bug has
   been present since the code was introduced in commit 9b0a7a2cb87d9
   (December 2023).

2. **Potential Functional Impact**: While the commit message states "no
   functional issue" because both `length` and `offset` are u32 types
   (and thus have the same size), this is still a correctness issue that
   should be fixed. The bug could become problematic if:
   - The types are changed in the future
   - Compiler optimizations or static analysis tools get confused
   - It sets a bad precedent for similar code patterns

3. **Small and Contained Fix**: This is a one-line change that simply
   corrects the sizeof() argument from `sizeof(length)` to
   `sizeof(offset)`. The change is minimal, easy to verify, and has zero
   risk of introducing regressions.

4. **Affects User-Kernel Interface**: The buggy code is in the
   `uverbs_copy_to()` function which copies data to userspace through
   the RDMA uverbs interface. This is part of the user-kernel ABI for
   the Broadcom NetXtreme-E RoCE driver, making correctness particularly
   important.

5. **Recently Introduced Bug**: The bug was introduced relatively
   recently (December 2023), meaning it could affect stable kernels from
   6.8 onwards. Backporting ensures all affected stable versions get the
   fix.

6. **No Architecture Changes**: This is purely a bug fix with no feature
   additions or architectural changes. It simply corrects an obvious
   typo in the sizeof() operator usage.

The commit meets all the stable tree criteria: it fixes a real bug (even
if currently benign), is minimal in scope, has no side effects, and
carries essentially zero risk of regression.

 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 063801384b2b..3a627acb82ce 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -4738,7 +4738,7 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 		return err;
 
 	err = uverbs_copy_to(attrs, BNXT_RE_TOGGLE_MEM_MMAP_OFFSET,
-			     &offset, sizeof(length));
+			     &offset, sizeof(offset));
 	if (err)
 		return err;
 
-- 
2.39.5


