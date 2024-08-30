Return-Path: <linux-rdma+bounces-4669-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E17F396651E
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 17:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A49D1F252AC
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 15:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23181B581C;
	Fri, 30 Aug 2024 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="WwYUfFfy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431781B4C29;
	Fri, 30 Aug 2024 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031006; cv=none; b=CPqbSMKmslEZHzXobJtomFyBt0m8cgT9F/Y509OtE08sL96awcFigRd/i8QOednUz6c7tjxcXXGWJHRox9FnvUkrecJQC1uTei1Cecf5yKI4+5ImWFT4WRJfo0aoHQhe5/yHP3e1FmHuNgcNwVj04LZW4msZ4q+en+if4YKPoZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031006; c=relaxed/simple;
	bh=L7Iu5qwM3GJ5quJn8zLnlihhTtlRQpg9g81Gl2sLvpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NYzOL3TgezZQorTVgtQKteup1CiQ2SVjrnVJJjY0tXH+f/ehjEGaeTws4XCk/4HD4x05ST7trZDHewKxn/rsLFtzAyARsgFClosSlF8sXSglDfo3OomRTF7EGPRIW33q5TEiYe69RS31nlYdYGnt8OaMsMLDZnQP6ww/NPEdfy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=WwYUfFfy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id F310620B7123; Fri, 30 Aug 2024 08:16:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F310620B7123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1725030999;
	bh=H+SUfZWshjMk9JAvgxKvB0iP3y3vfzyhaaXS/SuOMWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=WwYUfFfyBNVsIlYmk03V17hDAtLb1AjVVqOm69JbUg3QDbv64PXgfiiH/h1V94zI7
	 yQQrDixfiM5k2gL0JTxyXOwKWZZE0ku7qCmmcIZzPO1rPJu4eLBj4PrUkJxT8BxL1P
	 fk0HhOqVxzUvtCCe3U8ynvYhZKkWJ+Qrf9PT+6yA=
From: longli@linuxonhyperv.com
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH rdma-next v2 2/2] RDMA/mana_ib: use the correct page size for mapping user-mode doorbell page
Date: Fri, 30 Aug 2024 08:16:33 -0700
Message-Id: <1725030993-16213-2-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1725030993-16213-1-git-send-email-longli@linuxonhyperv.com>
References: <1725030993-16213-1-git-send-email-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

When mapping doorbell page from user-mode, the driver should use the system
page size as this memory is allocated via mmap() from user-mode.

Cc: stable@vger.kernel.org
Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
Signed-off-by: Long Li <longli@microsoft.com>
---
change log
v2: used rdma-next tag in patch title. fixed printk format identifier for unsigned long.

 drivers/infiniband/hw/mana/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index f68f54aea820..67c2d43135a8 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -511,13 +511,13 @@ int mana_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vma)
 	      PAGE_SHIFT;
 	prot = pgprot_writecombine(vma->vm_page_prot);
 
-	ret = rdma_user_mmap_io(ibcontext, vma, pfn, gc->db_page_size, prot,
+	ret = rdma_user_mmap_io(ibcontext, vma, pfn, PAGE_SIZE, prot,
 				NULL);
 	if (ret)
 		ibdev_dbg(ibdev, "can't rdma_user_mmap_io ret %d\n", ret);
 	else
-		ibdev_dbg(ibdev, "mapped I/O pfn 0x%llx page_size %u, ret %d\n",
-			  pfn, gc->db_page_size, ret);
+		ibdev_dbg(ibdev, "mapped I/O pfn 0x%llx page_size %lu, ret %d\n",
+			  pfn, PAGE_SIZE, ret);
 
 	return ret;
 }
-- 
2.17.1


