Return-Path: <linux-rdma+bounces-14918-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B213CAD496
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Dec 2025 14:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 907A6308CB5E
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Dec 2025 13:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95577314D12;
	Mon,  8 Dec 2025 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPbO4rp5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB821EE033;
	Mon,  8 Dec 2025 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765200797; cv=none; b=a+Xr/3nkoizDOLAL8nHQ2MwGsuRHhwALubWB/XR89w+SugYsXzMHOjeb1k+ty6xUNB6mggPFgv4653ienrlYi7menj/xwifJIxEnkAJbCmzV/EsP8TMJPsvKDkGTghurSztXl5XC1LiJGIL98VZJTZjb0e1ZsgsB0IaYYRtWgvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765200797; c=relaxed/simple;
	bh=UKzwph4n7+DE3wQUt9HCn2QfOXRBKK9v1fiZqaJlFMo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jD3lHWPn9dww+9grILIt2v8WjMobNh08eoowTt/n3v3wT+h2JHC05oS1aj77L6PVX5S5gmEmF9MUWJjzT8XPL7I27Qwm4rfaSXb6RUMkfNvSzfvvt3RzdFISK3fhRWgm6GGoF5Bhh/95QflkKWxUSexTPZp1ZTkpS8n8+oBTS7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPbO4rp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECD8C4CEF1;
	Mon,  8 Dec 2025 13:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765200796;
	bh=UKzwph4n7+DE3wQUt9HCn2QfOXRBKK9v1fiZqaJlFMo=;
	h=From:To:Cc:Subject:Date:From;
	b=MPbO4rp5Silgf8F07S7Y3ScffmLleX9esqKh8q2tZscuswi/eu6NN/xWNdcEX4ehw
	 zzZ/H2Wbzo/8iFUxGfXTfNRiq8Rz7xBkDiZXC/+DX0ITtuNxjL5khlBDtJosMTGCTm
	 AvSmj1jsZGNJQzrPwghjrCoBgG4yYr0vdJ58bhR6inEDI22ZKgWK34tbYAse/hArhN
	 xEfnSjx2I7/9mhjRRLB3YbLAGV+r10s7z63+CkUJNZh3iAO0qAvc5pj4gZcdTF8xI0
	 mGeJWm8jKqPkIYEoL9qNUyYCtpInikCUT5nWe6epbhCEPMdaomupcZ9QpzlsU6nLN0
	 xtr70XiW6D2WA==
From: Arnd Bergmann <arnd@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Mark Zhang <markzhang@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/ucma: fix rdma_ucm_query_ib_service_resp struct padding
Date: Mon,  8 Dec 2025 14:33:05 +0100
Message-Id: <20251208133311.313977-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

On a few 32-bit architectures, the newly added ib_user_service_rec
structure is not 64-bit aligned the way it is on most regular ones.

Add explicit padding into the rdma_ucm_query_ib_service_resp and
rdma_ucm_resolve_ib_service structures that embed it, so that the
layout is compatible across all of them.

This is an ABI change on i386, aligning it with x86_64 and the other
64-bit architectures to avoid having to use a compat ioctl handler.

Fixes: 810f874eda8e ("RDMA/ucma: Support query resolved service records")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/rdma/rdma_user_cm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/rdma/rdma_user_cm.h b/include/uapi/rdma/rdma_user_cm.h
index 5ded174687ee..8e1d584f6633 100644
--- a/include/uapi/rdma/rdma_user_cm.h
+++ b/include/uapi/rdma/rdma_user_cm.h
@@ -192,6 +192,7 @@ struct rdma_ucm_query_path_resp {
 
 struct rdma_ucm_query_ib_service_resp {
 	__u32 num_service_recs;
+	__u32 :32;
 	struct ib_user_service_rec recs[];
 };
 
@@ -362,6 +363,7 @@ struct rdma_ucm_ib_service {
 
 struct rdma_ucm_resolve_ib_service {
 	__u32 id;
+	__u32 :32;
 	struct rdma_ucm_ib_service ibs;
 };
 
-- 
2.39.5


