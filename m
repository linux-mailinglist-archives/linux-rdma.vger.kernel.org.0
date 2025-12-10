Return-Path: <linux-rdma+bounces-14951-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4849DCB2F92
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Dec 2025 14:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FC5730413D2
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Dec 2025 13:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAFA323411;
	Wed, 10 Dec 2025 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="hkjEACrQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.176.194.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D408D3191A4
	for <linux-rdma@vger.kernel.org>; Wed, 10 Dec 2025 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.176.194.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765372026; cv=none; b=EguCFRvpbauuFVOE19l55KdFIHt6nyNIMXvayqeiPK44oWJJgx+nxYeVAW7JKs2L/BlBgDhUjBRYnHeUTGmb8bSsrirbYrdJrgOYzOg47p26yAwxHDGrTC6QLctGI7kEXIXIATj0dgZ1tQd7IqOLWK0XM9j6rMn8xgVqf/zbU7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765372026; c=relaxed/simple;
	bh=4t500pydmI73+4cZ4MTWlarHF7Z5o2skrNvRi2a+mfY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iefakym9GPNIaTsldZ3VplYdKvY5DxHl2LVT+iTWbDXkjfZKlCANEunxq5S/XK1hlxKxgFg58PjFajCPgDaN7PioQPI+MRk7+VPlo/m13HjAEHoE93hE8nHU2Xe+XFNiigFexqPVIz7cZ+D+IA9SI2FXZ9kVje/ro3kv2/JWt0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=hkjEACrQ; arc=none smtp.client-ip=63.176.194.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1765372025; x=1796908025;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PcFqiyIkvRLxbtCtdZKEERsY4/Bv6lE9i/kTfU/Brjc=;
  b=hkjEACrQ3Uqd0GAQ10Q8IT4WyhCjoUqOcXDsQD55WXg0BKs37r7698gV
   xOffT8Z6U0e/my46ugABzT3uCeKZpGCe/J1cblQm0p1dyyYIRIXPCj9pN
   HWk7yT4bccI0xsKk4Jy6gdF7wSzyGbCDuV6oZehhqVZfxkd7yVoNHT4A2
   cu+J45C76p4gnm1+sAm/x0ipUcL3M14KXkJN6WIDqFaBn7KOnF+uID7wc
   deqkQqj7vyGoDXSTx0kxQZtCjsdEYuTBZf3xUHdQuD3xDVwqvSe01ypLy
   ZWL6mq0q+60+i5Jf8473EtZEBR+i6wk6hZkJ4hL+1B4X6G9BRxvMkqFIa
   Q==;
X-CSE-ConnectionGUID: wjBWxF5jT9aLYq+xzNK22w==
X-CSE-MsgGUID: PPNDThBbTJmJ4Czd+WTMnw==
X-IronPort-AV: E=Sophos;i="6.20,264,1758585600"; 
   d="scan'208";a="6512908"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 13:06:45 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:3287]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.26.222:2525] with esmtp (Farcaster)
 id 22dc20cf-2a7f-4c6f-8f07-611bc8faeb8a; Wed, 10 Dec 2025 13:06:45 +0000 (UTC)
X-Farcaster-Flow-ID: 22dc20cf-2a7f-4c6f-8f07-611bc8faeb8a
Received: from EX19D011EUB004.ant.amazon.com (10.252.51.93) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 10 Dec 2025 13:06:34 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by EX19D011EUB004.ant.amazon.com (10.252.51.93) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Wed, 10 Dec 2025
 13:06:31 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH 0/2] RDMA/efa: Admin completion context improvements
Date: Wed, 10 Dec 2025 13:06:12 +0000
Message-ID: <20251210130614.36460-1-ynachum@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D011EUB004.ant.amazon.com (10.252.51.93)

This series improves the EFA driver's admin completion context handling
with two key enhancements:

1. Add validation to check that the stored completion context command ID
   matches the received one, improving error detection and debugging.

2. Refactor the admin completion context state machine to be more robust
   and easier to maintain.

These changes enhance the reliability of the EFA admin command processing
path.

Yonatan Nachum (2):
  RDMA/efa: Check stored completion CTX command ID with received one
  RDMA/efa: Improve admin completion context state machine

 drivers/infiniband/hw/efa/efa_com.c | 97 ++++++++++++++++-------------
 1 file changed, 54 insertions(+), 43 deletions(-)

-- 
2.47.3


