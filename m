Return-Path: <linux-rdma+bounces-7717-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CABA33E80
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 12:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913373A5A9B
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 11:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6D52153C1;
	Thu, 13 Feb 2025 11:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="iLubYIt3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F36B227EBF;
	Thu, 13 Feb 2025 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447702; cv=none; b=pYr8Nv5sKmMKvFc+gAgyh1WwxuhlJhNcPzw0Atd5F2bAfOGX1Rv5OTQWGAaBkfNJ058BI6QnHBr18r1Gx5SRY4DmhcK6cuqL6uuznOCpBLO3L76kNjx9ObMqp7C/MEzMgSjOx8wNlWppF0pj+Ab2eqXE+fGbiv+tFEJAbx8UkZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447702; c=relaxed/simple;
	bh=ieZWzMZqBI8FH3s2gNhdd0n0BwsPNVH2lECzKfx9PAg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s9OhDuH0m4OM7xb1YUSzu0DCOjZCbhg7Fu5/MMI9yd97kYuDqB3p7cY3WzSEBm/B/Lf5crwtVG05/yCEiZxf4fSufVl3MSU9/h2qASQAMQOXzzPEJGN/H0iZlzB4/u7C0Zu9K40E1A7OVklipidy4cZ9UfvDMD+t/3dGk2EDWqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=iLubYIt3; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id ECE89C0008;
	Thu, 13 Feb 2025 14:47:54 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru ECE89C0008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1739447274; bh=TfIdG5Tk5nQELjuNn8VsvdhDZYi8sjTVviMHcjs+d7I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=iLubYIt3ACamDuUdrKEoOWkcjlkoO658LPc7cDxLLfbrTIfyDlQcjC3QUwmz+IkA+
	 9I4dcINAwHcdXI/iEucRZd+t0OsBrrxc4/K5GzW9h9qvj3gMDSYAezhkz8EgGCi5JB
	 7qRkD1bOEZb1trqSgOG1/564kwd2vgNNNlmzxzSQ92c2QjfILcTXrVEHQZWUZCUrN2
	 suePJh2CwbCb7YsarERi98YOq9WbjIIDbfXu2yEHCjKVjIgFfm+FSpPNyZBatfWD0l
	 hogVjLXY0bkQ8BMqy8CQq3DjxpCu+CxgsQA5lkFLxjWazT+TTcOMrrh8A5r25URjSj
	 5LIVP2VzB4q1A==
Received: from ksmg01.maxima.ru (mail.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Thu, 13 Feb 2025 14:47:54 +0300 (MSK)
Received: from localhost.maximatelecom.ru (5.1.51.172) by mmail-p-exch01.mt.ru
 (81.200.124.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Thu, 13 Feb
 2025 14:47:53 +0300
From: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
CC: Vitaliy Shevtsov <v.shevtsov@maxima.ru>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, Mitko Haralanov
	<mitko.haralanov@intel.com>, Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Doug Ledford <dledford@redhat.com>, Don Hiatt <don.hiatt@intel.com>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH resend] IB/hfi1: fix buffer underflow in fault injection code
Date: Thu, 13 Feb 2025 16:46:27 +0500
Message-ID: <20250213114630.2384-1-v.shevtsov@mt-integration.ru>
X-Mailer: git-send-email 2.48.1
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
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: v.shevtsov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, 81.200.124.61:7.1.2;mt-integration.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;ksmg01.maxima.ru:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 190981 [Feb 13 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/02/13 05:44:00 #27202047
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

From: Vitaliy Shevtsov <v.shevtsov@maxima.ru>

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


