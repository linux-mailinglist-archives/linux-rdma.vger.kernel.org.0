Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A3F2F0699
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Jan 2021 12:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbhAJLTx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Jan 2021 06:19:53 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14196 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbhAJLTx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Jan 2021 06:19:53 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffae2b00001>; Sun, 10 Jan 2021 03:19:12 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 10 Jan
 2021 11:19:12 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Sun, 10 Jan 2021 11:19:10 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <jgg@nvidia.com>, <leonro@nvidia.com>, <sagi@grimberg.me>
CC:     <oren@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>
Subject: [PATCH 3/3] IB/isert: simplify signature cap check
Date:   Sun, 10 Jan 2021 11:19:03 +0000
Message-ID: <20210110111903.486681-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210110111903.486681-1-mgurtovoy@nvidia.com>
References: <20210110111903.486681-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610277553; bh=eHtTMbj7+dvsMlCWg5Mtv6YvpESEtWlnitN6xQ36aIE=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        b=l149FmJMJBoAuO44tdq1aJ+nXv/8irQZlZ//wJC3c75vkm0hkU209yLBOKGXv11Pk
         fumWyi+3rcmWmAg605ggvTcs8letHXy33UhEizJxgIlH3PXPtW0v1FUXBUyLcLfZju
         6kj2J4jVNYknhH8aW3kOtPu68sw6Wq3W0qfmleSEv5G+WZt6Xem1OMF7GcU+SxSIwt
         XHN2xSFfuuuE1ZnMDduINSSzrNGEVa0t683f8HsrBuPvJEFfK3ZC0d/5bgEad994F9
         ogg/Z3VIdwVwBXE/q+i5aVt6fmXGPiRfVmL1c9WQwjEPxEJXrrShZMjEHZJmA0vYm/
         q2Dh7AsqRI1eQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use if/else clause instead of "condition ? val1 : val2" to make the code
cleaner and simpler.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/u=
lp/isert/ib_isert.c
index 96514f675427..7305ed8976c2 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -230,8 +230,10 @@ isert_create_device_ib_res(struct isert_device *device=
)
 	}
=20
 	/* Check signature cap */
-	device->pi_capable =3D ib_dev->attrs.device_cap_flags &
-			     IB_DEVICE_INTEGRITY_HANDOVER ? true : false;
+	if (ib_dev->attrs.device_cap_flags & IB_DEVICE_INTEGRITY_HANDOVER)
+		device->pi_capable =3D true;
+	else
+		device->pi_capable =3D false;
=20
 	return 0;
 }
--=20
2.25.4

