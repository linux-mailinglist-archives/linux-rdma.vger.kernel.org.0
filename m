Return-Path: <linux-rdma+bounces-6759-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D410B9FD6D5
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Dec 2024 19:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C95B3A2623
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Dec 2024 18:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C421F8913;
	Fri, 27 Dec 2024 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="LSHqAXvG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC6F1F2C45;
	Fri, 27 Dec 2024 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735323057; cv=none; b=RSH8JZ2YgbTAsBa56mGNpGj9jOpDJrmfsLP8oJq5L606DLuZvnJ4cdSBOnMCd8gVnvyc5A8USUZpSndHc5wL5750jDsa8yjhF8Rb85oCs7OwZ1oK+rK3wu6ZPtkKS38x3EUcqCl4YPmAaXjNYIUVWHum9zv7+ZnZTGyC86v3TYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735323057; c=relaxed/simple;
	bh=baYYmO+xPvlr04bGFbAE9Co2U4ljOtRgZnNejUSU4Ro=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u82R98/K99it0ko74HsBuAzeOIRbKj9xvIWlqwxCZsgnTv9EZx9aJH8GXtJUY47TT8eW9TOnmhbPYhOSmrYAxx4hAoz0aPDPlcU32oKO3Fk07/7XfVshKdnz9dT77dVwbT+vWAfytH7QwsL4V/lH/i2ZvPSyMY7xzXc34dlCzaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=LSHqAXvG; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 0B335C0009;
	Fri, 27 Dec 2024 21:10:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 0B335C0009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1735323044; bh=6LtxCC/JUoZ5G/hmJKsTCOpVL/MnjirK0lxryGHAYPw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=LSHqAXvGjzRmK5I11Rqp2cowmNpAoa31UQERpGoFVxnL11qAXp3ugPXXgF3kvjbLk
	 dOEuiG32MuDBAxG8xEB/UHXZXu9Ksh/K8GV8aSqf5z4sV89NzCrebuABAlQq9IM0TZ
	 eV/JZE/n+FFgAqHEhQSL8sVaARL+V225HisKfJ0Xn2Q/L4v/SvsMLvYtmqT+TEkmjZ
	 BQ+dRgu5zhoXKGPLlqlzrYYCkT0B1jST/QYnod3wYSasiPsuRdq2thwLjPwBsX3Rlt
	 HH0nhXOnBaG8uOGbGivYAH74pVqIlN2nSxhVfAUO2Q9TJRjY8HQyaUzFapM19mkSfc
	 /ndLblXp+KHsw==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Fri, 27 Dec 2024 21:10:43 +0300 (MSK)
Received: from localhost.maximatelecom.ru (217.116.54.35) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.4; Fri, 27 Dec 2024 21:10:42 +0300
From: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
CC: Vitaliy Shevtsov <v.shevtsov@maxima.ru>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, Mitko Haralanov
	<mitko.haralanov@intel.com>, Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Doug Ledford <dledford@redhat.com>, Don Hiatt <don.hiatt@intel.com>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] IB/hfi1: fix buffer underflow in fault injection code
Date: Fri, 27 Dec 2024 23:09:38 +0000
Message-ID: <20241227230940.20894-1-v.shevtsov@maxima.ru>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch01.mt.ru
 (81.200.124.61)
X-KSMG-Rule-ID: 7
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 190124 [Dec 27 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: v.shevtsov@mt-integration.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dmarc=none header.from=maxima.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 49 0.3.49 28b3b64a43732373258a371bd1554adb2caa23cb, {rep_avail}, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;maxima.ru:7.1.1;127.0.0.199:7.1.2;ksmg01.maxima.ru:7.1.1;mt-integration.ru:7.1.1;81.200.124.61:7.1.2, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, FromAlignment: n, ApMailHostAddress: 81.200.124.61
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/12/27 12:45:00 #26922086
X-KSMG-AntiVirus-Status: Clean, skipped

[Why]
The fault injection code may have a buffer underflow, which may cause
memory corruption by writing a newline character before the base address of
the array. This can happen if the fault->opcodes bitmap is empty.

Since a file in debugfs is created with an empty bitmap, it is possible to
read the file before any set bits are written to it.

[How]
Fix this by checking that the size variable is greater than zero, otherwise
return zero as the number of bytes read.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Fixes: a74d5307caba ("IB/hfi1: Rework fault injection machinery")
Signed-off-by: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
---
 drivers/infiniband/hw/hfi1/fault.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/fault.c b/drivers/infiniband/hw/hfi1/fault.c
index ec9ee59fcf0c..2d87f9c8b89d 100644
--- a/drivers/infiniband/hw/hfi1/fault.c
+++ b/drivers/infiniband/hw/hfi1/fault.c
@@ -190,7 +190,8 @@ static ssize_t fault_opcodes_read(struct file *file, char __user *buf,
 		bit = find_next_bit(fault->opcodes, bitsize, zero);
 	}
 	debugfs_file_put(file->f_path.dentry);
-	data[size - 1] = '\n';
+	if (size)
+		data[size - 1] = '\n';
 	data[size] = '\0';
 	ret = simple_read_from_buffer(buf, len, pos, data, size);
 free_data:
-- 
2.47.1


