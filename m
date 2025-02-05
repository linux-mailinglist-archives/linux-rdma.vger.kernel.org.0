Return-Path: <linux-rdma+bounces-7423-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEF7A28809
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 11:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8068D1882FC6
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 10:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9AD22B8C2;
	Wed,  5 Feb 2025 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="C8AiHq3Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0091122B8C7;
	Wed,  5 Feb 2025 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738751413; cv=none; b=YCm96xUHu6j2zKR+V/b62ZHY6c/W8+sJ56PW69X7Srhh4nY06YjCrUaMeqDLuqIc+t3mvV5O/2PESAQ2SO/TRRxnR9WgBLuTVdbsTG5pWCf9+cgePzCkpluZK2UpfzwsM5wTJTvpy40L1kNRCFqbfNSnh+Yz05QUfNatFvI0GBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738751413; c=relaxed/simple;
	bh=4BZXYBAvL5i9iE5fwLF/a02cQmdcXo4p1C0174KqJag=;
	h=From:To:Cc:Subject:Date:Message-Id; b=o05mVfjFJq292wz/0gFurmVYCwmMMrKj8ML6a/jnqPgpWN8UBTNMQSTbH9cphF0/1vd7i8lMtXw8tors4fBK6HZZXdDjBlu3LSINFOk92MmvOLCpq3uMtBMgMRWNo9ksM9kkNuLlkq8gmt69p32B37iCS0bnV43l7e+hTUzzgg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=C8AiHq3Q; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6E79E203F5BB;
	Wed,  5 Feb 2025 02:30:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6E79E203F5BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738751411;
	bh=oIn/Gxzz41jSTKA1JZAYh2cpY2tsirGSHWd3jPN1gbc=;
	h=From:To:Cc:Subject:Date:From;
	b=C8AiHq3QbMexEPDRndfdumLOsrF2jhtIhBXfp9wZKJu24uObocBQ78IgoteVp3+2O
	 uNafymWNei56OzcDce28nxxDZ+se3LnuYBibGwKkgjMNKayzgKjcfk3PHSTBSlNt4k
	 i7m1ZoF/sQht2PwiwHe6Vs82S1DxveUxvB4LAGvU=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: Allocate PAGE aligned doorbell index
Date: Wed,  5 Feb 2025 02:30:05 -0800
Message-Id: <1738751405-15041-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Allocate a PAGE aligned doorbell index to ensure each process gets a
separate PAGE sized doorbell area space remapped to it in mana_ib_mmap

Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index ae1fb69..0b89fa0 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -177,7 +177,7 @@ static int mana_gd_allocate_doorbell_page(struct gdma_context *gc,
 
 	req.resource_type = GDMA_RESOURCE_DOORBELL_PAGE;
 	req.num_resources = 1;
-	req.alignment = 1;
+	req.alignment = PAGE_SIZE / MANA_PAGE_SIZE;
 
 	/* Have GDMA start searching from 0 */
 	req.allocated_resources = 0;
-- 
2.43.0


