Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B128C393F
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 17:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfJAPii (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 11:38:38 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34818 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfJAPii (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 11:38:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id m15so22200597qtq.2
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 08:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M8TytSI9W0EaNiTDJIBpTTQUheltq6fvtn/bWPVhJh0=;
        b=CUOnmnmRrfKeY+HsmVV4VVhxeYuNximkEJE5jSrM9tqwXpfiavH3PngsSBmgcjgyX5
         p67h75WBmrfgWWO1sLmIvW93iONURYVqUgJhbPH7l/Ag4+JmomYBXz8kou5b7faYszpj
         TK8JYyT+BQG3kbfWa6KgZ5QuZ1ja2w6lhOry7eJEJ/HSwKS9NdLY3UMKEE9VLU0ZImKS
         D1ilq98f/zWf1BIKCcGBERvJwfxT0EzX81H9SGq54rccgv7axkht9/zCXedWtn4vG5KG
         yI+Zjl+wTmfn75vHNk/8cT+a8YghI+Mt3VCxZWcEyGMNnWWvPKnYjt7Q/IXS0oT/FZ3K
         Dvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M8TytSI9W0EaNiTDJIBpTTQUheltq6fvtn/bWPVhJh0=;
        b=p6jMFo6HQ/FN2SJDLMseIo6OsXWK3QcLV7A2xASXrxq9uwxq7pryIOYQEVLORJc8cS
         o5NQuBx0p6pLkRoci2d3irlFibdKzV/s/gVbFBNdaQfc/6H//ERW/SBdYzAxqNKFHU9G
         6W0FLGXTceJ2okw0umLAtoP613Zo8w2AS3OiWXi2qATJjfrSH7gFfKvoULo+6GYBabdN
         N+Usg3+dJG406Ca1q5B20KR3t2JsuovZvjPjlKEjk4YXXPL+ynNF1kt5EGjHXRaFRoB+
         OwQR/B89pw/aNcFbhUNurW82bsuAvBGUEvpIRTUjAzWeYZrCmElK80eesmMWFydzaqiL
         MlPA==
X-Gm-Message-State: APjAAAUJEj8Wy5h9Z8B3yRYyXgByQXw+ZOcivAenOAy1K0BSspnm56cs
        G4gLOC8OPweEh9RDy/yFqnoxgF4WKaE=
X-Google-Smtp-Source: APXvYqzcYNSQxIxUsYDdzrcUalJ9ckmjQ8vaqWqtpx/04voydhrI2uHxOt6U/e//et8okaJjcDxb+w==
X-Received: by 2002:ac8:2f81:: with SMTP id l1mr31693007qta.269.1569944317534;
        Tue, 01 Oct 2019 08:38:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id g45sm9073129qtc.9.2019.10.01.08.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 08:38:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFKEU-0006EX-0e; Tue, 01 Oct 2019 12:38:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>
Subject: [PATCH 1/6] RDMA/mlx5: Do not allow rereg of a ODP MR
Date:   Tue,  1 Oct 2019 12:38:16 -0300
Message-Id: <20191001153821.23621-2-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001153821.23621-1-jgg@ziepe.ca>
References: <20191001153821.23621-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

This code is completely broken, the umem of a ODP MR simply cannot be
discarded without a lot more locking, nor can an ODP mkey be blithely
destroyed via destroy_mkey().

Fixes: 6aec21f6a832 ("IB/mlx5: Page faults handling infrastructure")
Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 1eff031ef04842..e7f840f306e46a 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1441,6 +1441,9 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 	if (!mr->umem)
 		return -EINVAL;
 
+	if (is_odp_mr(mr))
+		return -EOPNOTSUPP;
+
 	if (flags & IB_MR_REREG_TRANS) {
 		addr = virt_addr;
 		len = length;
@@ -1486,8 +1489,6 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 		}
 
 		mr->allocated_from_cache = 0;
-		if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING))
-			mr->live = 1;
 	} else {
 		/*
 		 * Send a UMR WQE
@@ -1516,7 +1517,6 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 
 	set_mr_fields(dev, mr, npages, len, access_flags);
 
-	update_odp_mr(mr);
 	return 0;
 
 err:
-- 
2.23.0

