Return-Path: <linux-rdma+bounces-2742-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 835FC8D6CDD
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Jun 2024 01:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2138FB2201F
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 23:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958F584E0E;
	Fri, 31 May 2024 23:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="RbQ7LjPZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D440A24211;
	Fri, 31 May 2024 23:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717198397; cv=none; b=aJS3IugAU93zwU5gToe0XeY1UonkG8dNR4kd1kzYbRvv7ShqtZSwlCdTHOeyXC8tAnC34XWzkkxqftjXV1z0KVYyMqtjks5UOgCf9ugTAAoRy0siq+6M+8/K5QEqVNu795c2dOChZZS3Sc44OKsa8LVi0QDRKgR/VLXTwRWO3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717198397; c=relaxed/simple;
	bh=cQEikURoN6zkb0Ad06gj2cS0OohPcAjVCMWabwc6dY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rULYL2NTuPmqwYIeMCaYma1ryuh+EEM4qxQqYUdHvnY2dxdB7/RLpXPHHxEgkOMYz1Cq9xHEClCIj/gsLWuUpMXXveYLO8Z8RwSjB9qr78pJBgVCadCgwvKn/Ab6Drac9eAkSLJpJcJcxTDD8UYLFvYmm4G04v1MqbVtYCGL9eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=RbQ7LjPZ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=dIG7aELXW8AIB8p5ZBFbF0CI3HRKUJLJKMdh94SebLw=; b=RbQ7LjPZUi7Vo+tB
	63tJUB/oA1HIh0vgrMRszM4hb1i+V3a3GN7AvSB9mZyHQsU6PF0eNLvm3KAJMysE+eHcY2s8mVNNO
	DsBvK7GuPrEFJjfKZugwE3ChN9FUlf6icJdQ3jF+XtaCqMVk0CtwD+Q1bpoXxOKWEL6Ldn0mh32o7
	e79ZL3SueoOOKSqTkYE/4FSRwStgkjXfYC+sNbi8AohZ5Lce+1kBl4P3zrc4YB1wDPtU81y+DLgcY
	kPA7gDnm1kF7R7/OQZV7MvLc2Z7JCMu8LeaLsO86lYBlHKzrzoghNIdueVQTUH0y/jGc7Nmo9314C
	ijpCaSjorLPq3iDI7A==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sDBkC-003gVe-0r;
	Fri, 31 May 2024 23:33:08 +0000
From: linux@treblig.org
To: allison.henderson@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] RDMA/rds: remove unused struct 'rds_ib_dereg_odp_mr'
Date: Sat,  1 Jun 2024 00:33:07 +0100
Message-ID: <20240531233307.302571-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'rds_ib_dereg_odp_mr' has been unused since the original
commit 2eafa1746f17 ("net/rds: Handle ODP mr
registration/unregistration").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 net/rds/ib_rdma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/rds/ib_rdma.c b/net/rds/ib_rdma.c
index 8f070ee7e742..d1cfceeff133 100644
--- a/net/rds/ib_rdma.c
+++ b/net/rds/ib_rdma.c
@@ -40,10 +40,6 @@
 #include "rds.h"
 
 struct workqueue_struct *rds_ib_mr_wq;
-struct rds_ib_dereg_odp_mr {
-	struct work_struct work;
-	struct ib_mr *mr;
-};
 
 static void rds_ib_odp_mr_worker(struct work_struct *work);
 
-- 
2.45.1


