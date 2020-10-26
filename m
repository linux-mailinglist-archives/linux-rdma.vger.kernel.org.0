Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DA4298DDC
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 14:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774828AbgJZN3L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 09:29:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1774827AbgJZN3L (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Oct 2020 09:29:11 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 931FC22281;
        Mon, 26 Oct 2020 13:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603718951;
        bh=vsUNgSw4oKwHvB/OcbWfalbdqIGnKa5VBvKIDzInZ/M=;
        h=From:To:Cc:Subject:Date:From;
        b=s2gTReLO5SjTRMnXz0kq9+aUwHxGSgOzKz4G+tZzGNA+eR2+K0wv1sCVak8h7GJw6
         /pS3idJ6Rs+/qNlFenHFo4ebwOtfdN06gMKEbGmvIM002B6Xd9MwyB81brxZqTcF85
         neYX7a0Bw8GQlxs29SlDrwsUyUe+NY+jl5wf7wsQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Meir Lichtinger <meirl@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/ipoib: Add 50Gb and 100Gb link speeds to ethtool
Date:   Mon, 26 Oct 2020 15:29:04 +0200
Message-Id: <20201026132904.1338526-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Meir Lichtinger <meirl@mellanox.com>

The IBTA specification has new speeds - HDR and NDR, supporting signaling
rate of 50Gb and 100Gb respectively. ethtool support of ipoib driver
translates IB speed to signaling rate. Added translation of HDR and NDR
IB types to rates of 50Gb and 100Gb ethernet speed.

Signed-off-by: Meir Lichtinger <meirl@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_ethtool.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
index 67a21fdf5367..823f6831e7ea 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
@@ -166,6 +166,10 @@ static inline int ib_speed_enum_to_int(int speed)
 		return SPEED_14000;
 	case IB_SPEED_EDR:
 		return SPEED_25000;
+	case IB_SPEED_HDR:
+		return SPEED_50000;
+	case IB_SPEED_NDR:
+		return SPEED_100000;
 	}
 
 	return SPEED_UNKNOWN;
-- 
2.26.2

