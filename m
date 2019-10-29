Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0D80E803D
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 07:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfJ2G14 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 02:27:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730550AbfJ2G1z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 02:27:55 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEA2B2086A;
        Tue, 29 Oct 2019 06:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572330475;
        bh=nGQ3lM/Ln/Z1iWTGRKhW/Lo47jYSGZznCijX5hNKXmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OaLTkoDiq2nveAE+ZQ9AkhdJ/cD8daliV8OqEnDO3nAdAzpfkFT7l4SdbfU73VC0N
         rr+0QAgyPiMDiQoY/Mb7y9v+lCfnb+wfzf42jrA1LJsd98SM6kRcYUJejhyz/C+p86
         BD9h2vFgk0CVKJWTAHD9yaKuEWQwPmCB3ruTK624=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <ralph.campbell@qlogic.com>
Subject: [PATCH rdma-next 02/16] RDMA/mad: Allocate zeroed MAD buffer
Date:   Tue, 29 Oct 2019 08:27:31 +0200
Message-Id: <20191029062745.7932-3-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029062745.7932-1-leon@kernel.org>
References: <20191029062745.7932-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Ensure that MAD output buffer is zero-based allocated.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 92c932c067cb..62c756ea5668 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -481,8 +481,8 @@ static int get_perf_mad(struct ib_device *dev, int port_num, __be16 attr,
 	if (!dev->ops.process_mad)
 		return -ENOSYS;
 
-	in_mad  = kzalloc(sizeof *in_mad, GFP_KERNEL);
-	out_mad = kmalloc(sizeof *out_mad, GFP_KERNEL);
+	in_mad = kzalloc(sizeof(*in_mad), GFP_KERNEL);
+	out_mad = kzalloc(sizeof(*out_mad), GFP_KERNEL);
 	if (!in_mad || !out_mad) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.20.1

