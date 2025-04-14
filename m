Return-Path: <linux-rdma+bounces-9399-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A404AA87B38
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 11:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FA377A4D1C
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 08:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F182E25E47F;
	Mon, 14 Apr 2025 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TCx0a/Rn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE7B1F37D4;
	Mon, 14 Apr 2025 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744621242; cv=none; b=BhvhyaAqNVap6ritkl9N4i6WLk9L5lFh+XyCvo0HWttqgVjF2YlTaLv0MW/SEIDcwlSBxbhTzTDx1rd4KTrS/xyORrtarg2aosy9nsQHOPC0INl2JGOWtLjS8t36xXDlplzsjB3RCOpeLOZFaT/7rKD5na0aLtF8I4Gt8KI3FSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744621242; c=relaxed/simple;
	bh=GfzipUVy5RaTdAOqBjCv6TrYY3q+oixO4mtRqKujpGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TPZp3lInwsfBBBpfXgj3lqTnBTx12mV5sJc7AcRgvrQJJszzOlb2Q+c5qMkHI5GVWABT0C1EICYcT9O1DkuTzg9U3nvzP2C+PC3P15pNTq1P341+bMbdDzlq8A4oB51Z9/bBAn9oJJOw4ABll/GKOHI/FXO2EtvbwsByutX8Oa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TCx0a/Rn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id B6DEC21180D1; Mon, 14 Apr 2025 02:00:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B6DEC21180D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744621234;
	bh=Hu0kugxBiz8/p6dDvzQx99KKmNT1Fzl3KzmqCbUqqmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TCx0a/RnokTAPpO24utJAae6F6af6YSsuZmNVLx45JX6cuD76HZWvSh5c5MSROkrx
	 qwZeeTuVdbSYnoeBo1u7CT0LG6XDVx6VTga2fIqbh7nqbPzmLSccEucoRvjoA0fUQ5
	 xxtsgxltnQHTa2SISQyczwVu3d3ixMrW84PmLFTQ=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	pabeni@redhat.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	edumazet@google.com,
	kuba@kernel.org,
	davem@davemloft.net,
	decui@microsoft.com,
	wei.liu@kernel.org,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH rdma-next v2 1/3] RDMA/mana_ib: Access remote atomic for MRs
Date: Mon, 14 Apr 2025 02:00:32 -0700
Message-Id: <1744621234-26114-2-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744621234-26114-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1744621234-26114-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Add IB_ACCESS_REMOTE_ATOMIC to the valid flags for MRs and use
the corresponding flag bit during MR creation in the HW.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/mr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index f99557e..e4a9f53 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -5,8 +5,8 @@
 
 #include "mana_ib.h"
 
-#define VALID_MR_FLAGS                                                         \
-	(IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_READ)
+#define VALID_MR_FLAGS (IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_READ |\
+			IB_ACCESS_REMOTE_ATOMIC)
 
 #define VALID_DMA_MR_FLAGS (IB_ACCESS_LOCAL_WRITE)
 
@@ -24,6 +24,9 @@ mana_ib_verbs_to_gdma_access_flags(int access_flags)
 	if (access_flags & IB_ACCESS_REMOTE_READ)
 		flags |= GDMA_ACCESS_FLAG_REMOTE_READ;
 
+	if (access_flags & IB_ACCESS_REMOTE_ATOMIC)
+		flags |= GDMA_ACCESS_FLAG_REMOTE_ATOMIC;
+
 	return flags;
 }
 
-- 
2.43.0


