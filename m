Return-Path: <linux-rdma+bounces-7333-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F023EA22963
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 09:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083EA3A61CA
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 08:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3819D1A840D;
	Thu, 30 Jan 2025 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="js3viEcB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.crpt.ru (mail.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0DE819;
	Thu, 30 Jan 2025 08:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738224287; cv=none; b=Bhxg4GpYWLRg/MP8dHtYy2adA9Jn2wfZ1kblwYWb8UQVmfVX8MNld36vFeOMNwMIoJ//8siAqIoOjivOfyGXvPvYjfSxAcGZAuNn6ZKlVzly1SF1obY8hViY74nBJLeiVxVtuKTcvOcJZPAQM1DpmczKHZSNgJD/IK9StKC+uOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738224287; c=relaxed/simple;
	bh=FPyuAYQUhs13KSVfHwzqY6NrV2NyGs/Eq/hi0BLT2+o=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QANVimOwVEmOGOavBIKykUhfjQ96ADkKycH9Lm4vWgQMCBNmchZwMcTju9sMv1g8rkBqCbTZ10r14oB7NtGB50zkXTIdmtWYclfrrl4Eg0D31E22aBTUx0XDdizx5YQtcCE+t6vJFq5iyeDc05TEncA8gHKKWj9IYnBtXlSwKMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=js3viEcB; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.4])
	by mail.crpt.ru  with ESMTP id 50U84PBC001057-50U84PBE001057
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Thu, 30 Jan 2025 11:04:25 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex2.crpt.local (192.168.60.4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 30 Jan
 2025 11:04:25 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Thu, 30 Jan 2025 11:04:25 +0300
From: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>
To: Cheng Xu <chengyou@linux.alibaba.com>
CC: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>, Kai Shen
	<kaishen@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH] RDMA/erdma: Drop redundant NULL check on error path
Thread-Topic: [PATCH] RDMA/erdma: Drop redundant NULL check on error path
Thread-Index: AQHbcu2Tinz3gFtKbkO9g5PbXuMOAA==
Date: Thu, 30 Jan 2025 08:04:24 +0000
Message-ID: <20250130080418.37915-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX2.crpt.local, 9
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
X-FEAS-Client-IP: 192.168.60.4
X-FE-Policy-ID: 2:4:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=19idjH+TZoSSFpKdhgl4ec5+ZtE0tIU0bGAgd1gN7eI=;
 b=js3viEcBN3VYCOxtGOPASh6isS5yNZH48K3NKf0XPLuivlT5jMKc2klv4j3VeQJNcjHVk/LNYOBL
	DB/nrI5vE5WkHLrDN6kdKdul5Esq8GjOg9fbsmEvEqU7mgnMrTmylk4UFxYP38XIPG+KevFQsG6d
	Zu+BFTLdUy/pSx0VwZv86/zNNsJt9WksEymobzMfGRX03sMSgLopNoiZqCubjILuxC4k3JYzyHlF
	hKcU6/sIP1zY8wXhwxwx6S/p9n8K+PtwZQUGvJnhkqR1HuFQ/8WyrWRYPr8izY3T9MUDQyU+hQLX
	hb6LGnNJmxxRVrhf3Nhc8gford+6fD3fHPk0OQ==

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

Static analysis shows that on the error handling path in the
erdma_connect() function, the socket pointer cannot be NULL, since it is
pre-initialized in sock_create().  A potential failure in sock_create()
is processed.

Remove the extra NULL check. It is meaningless and harms the readability
of the code, since before that the socket pointer is unconditionally
dereferenced.

Found by Linux Verification Center (linuxtesting.org) with SVACE.
      =20
Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
---
 drivers/infiniband/hw/erdma/erdma_cm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_cm.c b/drivers/infiniband/hw=
/erdma/erdma_cm.c
index 771059a8eb7d..2934081dfbd4 100644
--- a/drivers/infiniband/hw/erdma/erdma_cm.c
+++ b/drivers/infiniband/hw/erdma/erdma_cm.c
@@ -1116,8 +1116,7 @@ int erdma_connect(struct iw_cm_id *id, struct iw_cm_c=
onn_param *params)
 	erdma_cep_put(cep);
=20
 error_release_sock:
-	if (s)
-		sock_release(s);
+	sock_release(s);
 error_put_qp:
 	erdma_qp_put(qp);
=20
--=20
2.43.0

