Return-Path: <linux-rdma+bounces-7943-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F44A3ED47
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 08:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6489E19C0B7B
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 07:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92701FF1A6;
	Fri, 21 Feb 2025 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="uLFS1n03"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.crpt.ru (mail.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687E11FBCBD;
	Fri, 21 Feb 2025 07:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740122391; cv=none; b=OZg0VyEQkivibJDF+YklEeYApE464RvhxDQT/G6pBwX6Pf6Z+wuMS567usKXnmd8EyqiVdUkP+p40g/KhJ3aOIhaPzR8B+/vMOX9Pww52BSLjX8AKXQ2SQ6DA/5IrgBswuZvh6Tb9piriZpA9y/6wxvuNnv+smsBfh/R6jHJ2n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740122391; c=relaxed/simple;
	bh=sObIvvCiUAn9qXnHNJpDFM36vWf1/wfpwgBNnrtetPc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lOvuQDQuoeoAh00/ZzXoj7/QJC26mCsCUBdkjkB4ACdbJCJ8soc2cjRMDzxrjrInQteSwloB2P7ct2yXsCzfX/4RR7AC2WZtWv6JOhnha2iOyUOS8PcqZZKwmmbAEAetdW+ojzFgT2d8B1mehvYkmDixRYXLJWyEDzX88z4Xzq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=uLFS1n03; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.3])
	by mail.crpt.ru  with ESMTP id 51L73AUP029765-51L73AUR029765
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Fri, 21 Feb 2025 10:03:10 +0300
Received: from EX02-PR-BO.crpt.local (10.200.60.52) by ex1.crpt.local
 (192.168.60.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 21 Feb
 2025 10:03:09 +0300
Received: from EX1.crpt.local (192.168.60.3) by EX02-PR-BO.crpt.local
 (10.200.60.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 21 Feb
 2025 10:03:09 +0300
Received: from EX1.crpt.local ([192.168.60.3]) by EX1.crpt.local
 ([192.168.60.3]) with mapi id 15.01.2507.044; Fri, 21 Feb 2025 10:03:09 +0300
From: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>
To: Kai Shen <kaishen@linux.alibaba.com>
CC: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Wei Yongjun
	<weiyongjun1@huawei.com>, Yang Li <yang.lee@linux.alibaba.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH] RDMA/erdma: handle ib_umem_find_best_pgsz() return value
Thread-Topic: [PATCH] RDMA/erdma: handle ib_umem_find_best_pgsz() return value
Thread-Index: AQHbhC6pbGv+eguF8Uexqo4ANK64zw==
Date: Fri, 21 Feb 2025 07:03:09 +0000
Message-ID: <20250221070301.18010-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX02-PR-BO.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 17.02.2025 9:52:00
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-ServerInfo: EX1.crpt.local, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-FEAS-Client-IP: 192.168.60.3
X-FE-Policy-ID: 2:4:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=rM29OcfKSzG0Xvr/iq7K+TDmsX7muLKw5JXGtiH19iw=;
 b=uLFS1n03admF9tfidPvwn/BC2su4qLerS0j6nq2kVEW4Rh6wuJffcft7mwqJOfXDiyVMznpqIdot
	MYEa2W2q8lHL1hXKKf4BH9v6tVBnMUE3tw2TfmfVaDCv4sdT++cdnMkvX15S3H/kfQxWveB8LSyr
	AytOu8sHwIiswjrAhOQQe/Nj+I2UXM/fteRoeqPdI6ohHHeqYagELhOeyPYcLjxRLu8GN8iosYxU
	730s1r442jxwxo1HZsuAkUP5P972SKZR0sfMr/4FKVpn7S2hBloYImDj2/Akd0ShDAxzSnnweZD2
	x200rurhsv+7QZooGg3xMjRI80u2al9D6LWTjQ==

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

The ib_umem_find_best_pgsz function is necessary for obtaining the optimal
hardware page size. In the comment above, function has statement:=20
"Drivers always supporting PAGE_SIZE or smaller will never see a 0 result."

But it's hard to prove this holds true for the erdma driver.

Similar to other drivers that use ib_umem_find_best_pgsz, it is essential=20
to add an error handler to manage potential error situations in the future.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 155055771704 ("RDMA/erdma: Add verbs implementation")
Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband=
/hw/erdma/erdma_verbs.c
index 51d619edb6c5..7ad38fb84661 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -781,6 +781,10 @@ static int get_mtt_entries(struct erdma_dev *dev, stru=
ct erdma_mem *mem,
 	mem->page_size =3D ib_umem_find_best_pgsz(mem->umem, req_page_size, virt)=
;
+	if (!mem->page_size) {
+		ret =3D -EINVAL;
+		goto error_ret;
+	}
 	mem->page_offset =3D start & (mem->page_size - 1);
 	mem->mtt_nents =3D ib_umem_num_dma_blocks(mem->umem, mem->page_size);
 	mem->page_cnt =3D mem->mtt_nents;
 	mem->mtt =3D erdma_create_mtt(dev, MTT_SIZE(mem->page_cnt),
 				    force_continuous);
--=20
2.43.0

