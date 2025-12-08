Return-Path: <linux-rdma+bounces-14919-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B26CAD4AB
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Dec 2025 14:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42BF5302C8E5
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Dec 2025 13:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617682E7F3F;
	Mon,  8 Dec 2025 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQy6qUVi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A92518DB37;
	Mon,  8 Dec 2025 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765201135; cv=none; b=UFjgDdZIQlFYWemrfiR4ycMulQeOnjyLN0FZZKHrHPGL0lKmw25TPYoERFE2egkmDUMMtiJN7ohBykPSqaAxule6dfZXdwZWTiIsreN1oS8+cgi4Cvr7dPZz2Zgv7kK7c7ahJeSdWxKqWl/auQ+rmGhHxQmGz33t4DoMK/RAHls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765201135; c=relaxed/simple;
	bh=/QIG0s8qwDFQEfzNx7yLoTfUfom/TgzAQ/HslXH1rVE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pq6TQyuIb0Jw03fwLXd9iNSyUagl4uNFyPgVAuLTlyp0Zv+sx/g6lneHgwES1Mtr1Qrypm21wG6NpdWpxdDQTanzAP1giesb66vNGv5V/hvwh4LqxgQZCls6i5L3rs0RkbfXMkGr13U51S1TIkuCSUMykkvVSQk4Y1y8UrYSpTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQy6qUVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BBAC4CEF1;
	Mon,  8 Dec 2025 13:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765201134;
	bh=/QIG0s8qwDFQEfzNx7yLoTfUfom/TgzAQ/HslXH1rVE=;
	h=From:To:Cc:Subject:Date:From;
	b=LQy6qUViJ4u7tDkk4E3pzJcwsUZbTnlOvWScqcXuOdJ+wT+st/cJbgRdljD9BWanP
	 EvoW6upsnxCSKNpHwW4SLjeDPVFKEUBbvO1fAQpVoMqOlxrehQDhUEtZAhvKCBnQ3f
	 GZ3ZDulYsg+7Zx1oiZo7qlD+qUtLmi/drtdYMXZ8ulvUF+xRS9fU7CffLmhM+PQ4Mv
	 pdI2vHl6OVslbSiWG1TPqWskkjetcSpaxQ7jwJA+kz0yJnwDhFO6zy1MoFq8DaBgWH
	 10T/YRieNy4EOeSweOzuIJNbESzQxbkd264RYaZsV88UzLTtYu0uuddPG/u6YLkT/z
	 t2blFg2lQDtRQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Faisal Latif <faisal.latif@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/irdma: fix irdma_alloc_ucontext_resp padding
Date: Mon,  8 Dec 2025 14:38:44 +0100
Message-Id: <20251208133849.315451-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

A recent modified struct irdma_alloc_ucontext_resp by adding a member
with implicit padding in front of it, changing the ABI in an
incompatibible way on all architectures other than m68k, as
reported by scripts/check-uapi.sh:

==== ABI differences detected in include/rdma/irdma-abi.h from 1dd7bde2e91c -> HEAD ====
    [C] 'struct irdma_alloc_ucontext_resp' changed:
      type size changed from 704 to 640 (in bits)
      1 data member deletion:
        '__u8 rsvd3[2]', at offset 640 (in bits) at irdma-abi.h:61:1
      1 data member insertion:
        '__u8 revd3[2]', at offset 592 (in bits) at irdma-abi.h:60:1

Change the ABI back to the previous version, by moving the new
max_hw_srq_quanta member into a naturally aligned location.

Fixes: 563e1feb5f6e ("RDMA/irdma: Add SRQ support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/rdma/irdma-abi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/rdma/irdma-abi.h b/include/uapi/rdma/irdma-abi.h
index f7788d33376b..36f20802bcc8 100644
--- a/include/uapi/rdma/irdma-abi.h
+++ b/include/uapi/rdma/irdma-abi.h
@@ -57,8 +57,8 @@ struct irdma_alloc_ucontext_resp {
 	__u8 rsvd2;
 	__aligned_u64 comp_mask;
 	__u16 min_hw_wq_size;
+	__u8 revd3[2];
 	__u32 max_hw_srq_quanta;
-	__u8 rsvd3[2];
 };
 
 struct irdma_alloc_pd_resp {
-- 
2.39.5


