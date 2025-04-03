Return-Path: <linux-rdma+bounces-9142-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1C2A7A5B0
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 16:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74FC8188E864
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 14:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F642250BF7;
	Thu,  3 Apr 2025 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7Liz9Cc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2955124EF9A;
	Thu,  3 Apr 2025 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743691687; cv=none; b=F1JA9wbFi7B5t654mURKtmHvLFii1B1wN+p/UD7VuiBaS7y36dYiX7/T7cSJgl9IPjw4TiDYKF5RmarbKWMDY/AmrIbqeavYSMZ/muWb2CFDirbjYhwQrYM3YGzaNmi+f/hbYIu7/CYKNbr4zj5ELyn1N7csE6yg6ufphE8RuBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743691687; c=relaxed/simple;
	bh=RrOTQcuANEq2RAIgj9UZ3synNzyYf0fgpXeVeZABxAo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nADAjyXlugAMk0P+dPskWd/g++glVqZUsvdvI4cv0oMA9TDzVUd82p/vVlyOWSniRJmmviuyHlhV4FVMtmYKUy6FiA7U2DwaroDqVZPVpBa4beLcXEsvS3AM2AHlrez0pgydUfs/zz2SLS+uZLxl+aVBfUUuHTi7OJHVSo7VGwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7Liz9Cc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616A3C4CEE7;
	Thu,  3 Apr 2025 14:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743691686;
	bh=RrOTQcuANEq2RAIgj9UZ3synNzyYf0fgpXeVeZABxAo=;
	h=From:To:Cc:Subject:Date:From;
	b=Q7Liz9CcnNg0gAkVAdZyi3RFCL4HagRv98rowwXJS9mRJRN74/Mi2z2qTb2RnFzGm
	 GT481oqIW/8dLNPTWS0QlYdnOIupI6Z+b4lyVLQC+AHaMkoZeEccO3ebdWiPF/uFIe
	 E2ouYwM1Iw1asTI3Kuv41gwH1bUJ2HZQnfbg7GqR32oGfhD1QYloC8bSk6wqdP8NHn
	 I2RnqX7Zvjd6kHHk+74EIaS+rBkYlFVyZsOAkjIqSxu7BuYXEbpQTDWjKaOG9/a5Ip
	 XB5KqmONckpRXOikeNGMLtfJdBSAIfe2o6LBRhRu2ChOmf9c5NzsbTCxqftcfupAB6
	 Thmm7N1UndLqA==
From: Arnd Bergmann <arnd@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Maher Sanalla <msanalla@nvidia.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/hfi1: use a struct group to avoid warning
Date: Thu,  3 Apr 2025 16:47:53 +0200
Message-Id: <20250403144801.3779379-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

On gcc-11 and earlier, the driver sometimes produces a warning
for memset:

In file included from include/linux/string.h:392,
                 from drivers/infiniband/hw/hfi1/mad.c:6:
In function 'fortify_memset_chk',
    inlined from '__subn_get_opa_hfi1_cong_log' at drivers/infiniband/hw/hfi1/mad.c:3873:2,
    inlined from 'subn_get_opa_sma' at drivers/infiniband/hw/hfi1/mad.c:4114:9:
include/linux/fortify-string.h:480:4: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror]
    __write_overflow_field(p_size_field, size);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This seems to be a false positive, and I found no nice way to rewrite
the code to avoid the warning, but adding a a struct group works.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/hw/hfi1/hfi.h | 6 ++++--
 drivers/infiniband/hw/hfi1/mad.c | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index cb630551cf1a..fca37eb167cc 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -883,8 +883,10 @@ struct hfi1_pportdata {
 	 * cc_log_lock protects all congestion log related data
 	 */
 	spinlock_t cc_log_lock ____cacheline_aligned_in_smp;
-	u8 threshold_cong_event_map[OPA_MAX_SLS / 8];
-	u16 threshold_event_counter;
+	struct_group (zero_event_map,
+		u8 threshold_cong_event_map[OPA_MAX_SLS / 8];
+		u16 threshold_event_counter;
+	);
 	struct opa_hfi1_cong_log_event_internal cc_events[OPA_CONG_LOG_ELEMS];
 	int cc_log_idx; /* index for logging events */
 	int cc_mad_idx; /* index for reporting events */
diff --git a/drivers/infiniband/hw/hfi1/mad.c b/drivers/infiniband/hw/hfi1/mad.c
index b39f63ce6dfc..0dea8d01e868 100644
--- a/drivers/infiniband/hw/hfi1/mad.c
+++ b/drivers/infiniband/hw/hfi1/mad.c
@@ -3870,8 +3870,8 @@ static int __subn_get_opa_hfi1_cong_log(struct opa_smp *smp, u32 am,
 	 * Reset threshold_cong_event_map, and threshold_event_counter
 	 * to 0 when log is read.
 	 */
-	memset(ppd->threshold_cong_event_map, 0x0,
-	       sizeof(ppd->threshold_cong_event_map));
+	memset(&ppd->zero_event_map, 0x0,
+	       sizeof(ppd->zero_event_map));
 	ppd->threshold_event_counter = 0;
 
 	spin_unlock_irq(&ppd->cc_log_lock);
-- 
2.39.5


