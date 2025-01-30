Return-Path: <linux-rdma+bounces-7332-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E51AFA22955
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 08:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1D41887463
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 07:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762811A8F9B;
	Thu, 30 Jan 2025 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="vAXCG3tj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.crpt.ru (mail.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6231547C9;
	Thu, 30 Jan 2025 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738223770; cv=none; b=jSdKBZNA59Bm/S/QSe7cDBQoYMXNEw5m0EDeee0IRJerJuydCkeV/O4fT0msQjSTPdJLx4yvqB4XEt0nprEBQpZd/RW89aCaF4BuMk3vnPazUNXLY42npuOzdYej3iyA7cr5e3AOoPEa3du/zuwCsdI4CU76wpHhR3XErpsnz0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738223770; c=relaxed/simple;
	bh=EZYggPNb/46KWWQY8xnaDDma9leRBGSWvIFShopC4Lk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Wg2SqPuLcKLSom7B+daqH04VGF/LLVsjat/W2QYeyc3aIJv+wPpb7Pg90X9QbdxZ5JNaGTkvC+oUD6GLwdKhTRyxETD0MDcW+hk7nZGLWHKJh6/TVWpmEylUdLK/sVDXtzw8O1ugI2F4JBUwZqHSSqBsMoQu8WSMilQ0KCvNv2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=vAXCG3tj; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.3])
	by mail.crpt.ru  with ESMTP id 50U7tdKu017498-50U7tdKw017498
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Thu, 30 Jan 2025 10:55:39 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex1.crpt.local (192.168.60.3)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 30 Jan
 2025 10:55:39 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Thu, 30 Jan 2025 10:55:39 +0300
From: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>
To: Cheng Xu <chengyou@linux.alibaba.com>
CC: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>, Kai Shen
	<kaishen@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH] RDMA/erdma: Drop redundant NULL check on error path
Thread-Topic: [PATCH] RDMA/erdma: Drop redundant NULL check on error path
Thread-Index: AQHbcuxa0HhS1pce2UOX23Sd9kRhCg==
Date: Thu, 30 Jan 2025 07:55:38 +0000
Message-ID: <20250130075534.35847-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX1.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 1/29/2025 10:00:00 PM
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
X-FEAS-Client-IP: 192.168.60.3
X-FE-Policy-ID: 2:4:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=NIY4cRJaMKMdqrJIkKraCNxjNrs/BglfCKZMu7nuiSI=;
 b=vAXCG3tjXp2eeuDS0Oc5/cCz20PW8aaxg5N+h0q9DkeRZ+gXyAvx6WdeHivQqfaN6/uhkXX9hxFk
	obXdHPAdI9v4OHo1NR46NZMur7R225MwprAAC4nwAsaXonz3+jw/Ky87RkmD9tQoVFYKUJ8HmVKx
	upHH6e0bB1KcO2rDXGz7fpGohEsVet9Ox4KTCnRdJivskZSTVpu/9tMASpK6Y9WFrbIUf7QZtaXi
	n60VUiB+cQItqoYAuVQGiv/NZ0qe3NnVTaUqkhWf8gjEP3g9yYD/7vn9hf0AWP85R+gy+yTWSG8V
	TJmCcsnRWsSBE7wtPyiQW46uX4HzIUpayoUdZw==

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

Static analysis shows that on the error handling path in the
get_mtt_entries() function, the mem->umem pointer cannot be NULL,
because it is pointer to struct.

Remove the extra NULL check. It is meaningless and harms the readability
of the code.
      =20
Found by Linux Verification Center (linuxtesting.org) with SVACE.
Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband=
/hw/erdma/erdma_verbs.c
index 51d619edb6c5..fe4b79f15cf6 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -794,10 +794,8 @@ static int get_mtt_entries(struct erdma_dev *dev, stru=
ct erdma_mem *mem,
 	return 0;
=20
 error_ret:
-	if (mem->umem) {
-		ib_umem_release(mem->umem);
-		mem->umem =3D NULL;
-	}
+	ib_umem_release(mem->umem);
+	mem->umem =3D NULL;
=20
 	return ret;
 }
--=20
2.43.0

