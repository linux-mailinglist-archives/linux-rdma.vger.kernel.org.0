Return-Path: <linux-rdma+bounces-3450-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB0D915328
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 18:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908B91C2251A
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 16:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887CA19D8AB;
	Mon, 24 Jun 2024 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UbAVZE9Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC04519D8A4
	for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2024 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245409; cv=none; b=p4dbAfYa9P68CNefIEdAZQnDdROxdIr9l7qvHtZX3KbV7XZQuH5gZAzXloPrr/vYUOdOtlekdQoMlnKlWOKY/m/Y2AYyFX8WNYEPjER1JMKZpaEask8kFxFqUfdV7kCOC/zxj6gwZ+hfM15wwi8me08MGlHRm1a8mdYe2lnHdbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245409; c=relaxed/simple;
	bh=5ajlewIuva+EkJZYAUVctfLDt7iBzDx1Z9mxbQSjTrk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=upb4TTiGwYgMbnU9VueTmKkYNbwpsnON5nbwffc38SHbCxIEh3/y5MtjMkGPHYHJ4VFGrXEdM5AFtNXFqun86en98OslR//Vw2jR8zgy16I5xyK3WqOlsCBNk4glKSTBkjUfhXNlhBWbU+jZqdSdUM0ll89q8/UMUNbOXdYTTRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UbAVZE9Q; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719245408; x=1750781408;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PjxGOfqjbB745ek7mxuDywEekAytMXi6fT0woUl6ncQ=;
  b=UbAVZE9Qhjl409xgWr9bdz3bRomQLjOVmULjUX2ta9Q/ImgtbT4BUYgs
   surpizjo49m9PqskUv1CuoSyNhIG/fVV/kPk2K6neZ3z2vDg1sQri+igF
   XNOqQHXx2fOa64dnqaLErb3Ws6/6r+Sv1nk+jf/syxhfA4gwUuWFUnrv+
   o=;
X-IronPort-AV: E=Sophos;i="6.08,262,1712620800"; 
   d="scan'208";a="213796628"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 16:09:22 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:40161]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.27.114:2525] with esmtp (Farcaster)
 id 902c93c4-f1e2-4a7b-a308-4d4f215ea8ac; Mon, 24 Jun 2024 16:09:21 +0000 (UTC)
X-Farcaster-Flow-ID: 902c93c4-f1e2-4a7b-a308-4d4f215ea8ac
Received: from EX19D013EUB004.ant.amazon.com (10.252.51.92) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 24 Jun 2024 16:09:20 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D013EUB004.ant.amazon.com (10.252.51.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 24 Jun 2024 16:09:20 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by mail-relay.amazon.com (10.252.134.102) with Microsoft
 SMTP Server id 15.2.1258.34 via Frontend Transport; Mon, 24 Jun 2024 16:09:19
 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>
Subject: [PATCH for-next 0/5] RDMA/efa: Cleanups and minor improvements
Date: Mon, 24 Jun 2024 16:09:13 +0000
Message-ID: <20240624160918.27060-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series contains few cleanups and improvements that were laying
around.

Gal Pressman (1):
  RDMA/efa: Use offset_in_page() function

Michael Margolin (2):
  RDMA/efa: Move type conversion helpers to efa.h
  RDMA/efa: Align private func names to a single convention

Yonatan Nachum (2):
  RDMA/efa: Remove duplicate aenq enable macro
  RDMA/efa: Validate EQ array out of bounds reach

 drivers/infiniband/hw/efa/efa.h       |  41 +++-
 drivers/infiniband/hw/efa/efa_main.c  |   2 +-
 drivers/infiniband/hw/efa/efa_verbs.c | 333 +++++++++++---------------
 3 files changed, 174 insertions(+), 202 deletions(-)

-- 
2.40.1


