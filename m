Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5320ED8953
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2019 09:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfJPHW6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Oct 2019 03:22:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37174 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfJPHW6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Oct 2019 03:22:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id f22so1527169wmc.2
        for <linux-rdma@vger.kernel.org>; Wed, 16 Oct 2019 00:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PviuyabPKIUKvylhvFSX9SEcIFgxFxjDOcPMsr4oBCs=;
        b=QE2Uo2aIkmIAKeej+740TwKIcJJptMtwc2e7v3UdxYccx/lDvtxqeLpk6lIzfeu0QO
         Yrca1h92zkQ8tD2DbbIE2lvzdAEfU8rPUohXdHLr2korlgdXIcP5Cxx+E5e4QZ0G+T3X
         SCa8dBABtLPCAEOI6M9wicIOCcbdoj1jcUWJ60oQ+LnN5N/hX3Vt+IrYXMLCpCzgbft/
         58NivtxVqcHJdVheiMmrgS2u7+eqTX/8JcOVLtaX37z0ocO/T/JKlosYlfQasQMJlxan
         I3iZu4W6cLRSIZ61Yumfsyf2l9jro5LtSZwUCblB4OKJm0p/X8hEdeNDCayq+Fbes0q6
         wBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PviuyabPKIUKvylhvFSX9SEcIFgxFxjDOcPMsr4oBCs=;
        b=bJaJym7Owkis7pn6BMxVlCyhRu5+0dKHIcMdH36jLTYm3uuX5I9tepweog6YgY226Y
         DFNbgH+vjd2M9pY8i5M1k/A0zes/VG6NWitEEvqN8ThScp5RtNJU+tu1BFiwaJ+1kFFD
         +a3nIqOerkHO4Vx7BreysTPhBvS2tEVjqPz1AclQXxI/z8lhjCByszuyuPIgY9z96I8x
         Sm6f+KE3RA7/moUTdiHrHg1rZuoXmzEQOnl402q8mvNKOYP7Qa4Ln0jgUVjwj95PD3lM
         CBhGif74hqyZ8uO7ftHlgoLgyNeP0rTiAC+Tcfkt+Vy8EDX3JbODICzxxDrCne96iV2m
         PBhw==
X-Gm-Message-State: APjAAAUcwD/bsHuZ90Zv/jKNLHE61djlPJ6jmgHRnYgjiE5IEpKs+Lw1
        Km8dh7WwtFOgOEJmNlfgHLC9opnq
X-Google-Smtp-Source: APXvYqyQ6relfssaKI9GtHnIG68HPRimhB+NUHXpEwsyeSg/AaYESwRx5uxJgwNeQgSe5lc0FeyLCA==
X-Received: by 2002:a1c:f011:: with SMTP id a17mr2016439wmb.18.1571210575952;
        Wed, 16 Oct 2019 00:22:55 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id r140sm1687046wme.47.2019.10.16.00.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:22:55 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next v2 1/4] RDMA/core: Fix return code when modify_port isn't supported
Date:   Wed, 16 Oct 2019 10:22:31 +0300
Message-Id: <20191016072234.28442-2-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191016072234.28442-1-kamalheib1@gmail.com>
References: <20191016072234.28442-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The proper return code is "-EOPNOTSUPP" when modify_port callback is not
supported.

Fixes: 61e0962d5221 ("IB: Avoid ib_modify_port() failure for RoCE devices")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/core/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index a667636f74bf..98a01caf7850 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2397,7 +2397,7 @@ int ib_modify_port(struct ib_device *device,
 					     port_modify_mask,
 					     port_modify);
 	else
-		rc = rdma_protocol_roce(device, port_num) ? 0 : -ENOSYS;
+		rc = rdma_protocol_roce(device, port_num) ? 0 : -EOPNOTSUPP;
 	return rc;
 }
 EXPORT_SYMBOL(ib_modify_port);
-- 
2.20.1

