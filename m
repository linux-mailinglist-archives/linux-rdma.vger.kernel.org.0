Return-Path: <linux-rdma+bounces-4969-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A14CF97A2E2
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 15:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571BE1F23B2C
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 13:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C4E155316;
	Mon, 16 Sep 2024 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmkVj/1b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F23A155730;
	Mon, 16 Sep 2024 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726493083; cv=none; b=RQJZpAkjNAl9dK8i1rC9eT/OmyIrsAQXepS7Ip3yDec8CSscenhtvRvmh8TngLbNcoLtO+jdXWlDVjXBYfob3S+Bet3n3LerR4qXWPSOGsYGvE8eMgA/VeMSociFRy297x9FoZbJouJgdkcPjWVIu41/NK183DaII+VADz+4JAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726493083; c=relaxed/simple;
	bh=5xEJh1ub1kI+EIttBB2hxBzNK3bDB4gn6m8TFf1RBn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ppNnryBtq9R8bgX1Haipcjz8/u9EZ+wjQEpqhQDpzgcDAXcmsJx7b2SEBCmWrCN3U4jJFeJtM7UbQuE5odIRoAsTQSQUyejtZVlh7f3p50HhOyh2A8vvqrnMUZXrnjRBeHIYNDqiDVx6xa5cj5bqqInSuALs7mDtgGIuJTEcC2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmkVj/1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CBEC4CEC4;
	Mon, 16 Sep 2024 13:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726493082;
	bh=5xEJh1ub1kI+EIttBB2hxBzNK3bDB4gn6m8TFf1RBn8=;
	h=From:Date:Subject:To:Cc:From;
	b=AmkVj/1bXah3OMR9pEIkqvu4NK8bETgCx/vAoYwshj5ZY0EjJySrOE8eeCYJ4rf6B
	 rZSegSoI+d/gcUeFDq/tS/3UsJ8jJYo8n96d8MxRPtUwhbyhF/3SFzgoIcJpfWE2qe
	 o6nGbjgFwcDpa6+iMHyx+OKApJ1BJPCWgBsjIsTTC4csTE98XkdmJ1NpaOama6WkL0
	 Wf84QkS4mNTpza3rNj5Gabe+/ZbFVRxyMPc2Fi8cR9xPgLhiwfX4MLGH6Pc72JFLT3
	 LYHOz6gEGI3W+1BUKbBL92tLRx3zrdZpdICZZaU8nZ4PS+H5faQLEnqhCyi6vnAi+C
	 ln8mVfAiDoRPA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 16 Sep 2024 06:24:34 -0700
Subject: [PATCH] RDMA/nldev: Add missing break in rdma_nl_notify_err_msg()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240916-rdma-fix-clang-fallthrough-nl_notify_err_msg-v1-1-89de6a7423f1@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJIx6GYC/x2NUQrCMBAFr1L224UkVGO9ikgI7SZZSBPZVFFK7
 27wc3jMmx0aCVOD27CD0Jsb19JBnwaYky+RkJfOYJQZ1aQvKMvqMfAH59xnDD7nLUl9xYQlu1I
 3Dl9HIm5tEe00BntWSltzhX75FOrqP3d/HMcPCYEonX4AAAA=
X-Change-ID: 20240916-rdma-fix-clang-fallthrough-nl_notify_err_msg-794f75001728
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>, 
 Michael Guralnik <michaelgur@nvidia.com>, linux-rdma@vger.kernel.org, 
 llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1525; i=nathan@kernel.org;
 h=from:subject:message-id; bh=5xEJh1ub1kI+EIttBB2hxBzNK3bDB4gn6m8TFf1RBn8=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGkvDGf5Ld6o38x24kJhtNcMY9X2BwvrJq70ebWRyWvi7
 x/9py/v7yhlYRDjYpAVU2Spfqx63NBwzlnGG6cmwcxhZQIZwsDFKQATeePGyLBa+ft21QzTSQue
 XHXjaC/9HOP98e+KC0rvikJWnkhe2XmGkWF7a+yJ5RHXNG18QnRtdmx6fbYqSeT7R16rNfFWWk1
 b+3gB
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Clang warns (or errors with CONFIG_WERROR=y):

  drivers/infiniband/core/nldev.c:2795:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
   2795 |         default:
        |         ^

Clang is a little more pedantic than GCC, which does not warn when
falling through to a case that is just break or return. Clang's version
is more in line with the kernel's own stance in deprecated.rst, which
states that all switch/case blocks must end in either break,
fallthrough, continue, goto, or return. Add the missing break to silence
the warning.

Fixes: 9cbed5aab5ae ("RDMA/nldev: Add support for RDMA monitoring")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/infiniband/core/nldev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 10b1411ac53d8e9c89b6705659e772eb84f4c923..39f89a4b86498220ec30bcb16bcc804f2b049752 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -2792,6 +2792,7 @@ static void rdma_nl_notify_err_msg(struct ib_device *device, u32 port_num,
 		dev_warn_ratelimited(&device->dev,
 				     "Failed to send RDMA monitor netdev detach event: port %d\n",
 				     port_num);
+		break;
 	default:
 		break;
 	}

---
base-commit: e766e6a92410ca269161de059fff0843b8ddd65f
change-id: 20240916-rdma-fix-clang-fallthrough-nl_notify_err_msg-794f75001728

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


