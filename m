Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB05D6897
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2019 19:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbfJNRij (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Oct 2019 13:38:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52193 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730508AbfJNRij (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Oct 2019 13:38:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so18151171wme.1
        for <linux-rdma@vger.kernel.org>; Mon, 14 Oct 2019 10:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pZB6ccNxWfk6NZibMKYvriXwtcv9GEZSbjmWhYH39uM=;
        b=lMX0xWSe+fRd0y328Srb0mXFWasaRWw3Jzo3NbMTd4nnvgeN3N+VsDWy5W2S9rWY8j
         wu47ddVVY1HsX0EkGNUITF2x7ZKLm8rVaEGOS7jhaKk02E4qs8wJKeiOyCDzutlZk6rF
         4iWo7+Lp7EgmkEdLU+nNhHrKLR7Q0ABuLhymaDknZUUmvk1yQ4HUuFPU6Uo8+zR5In4d
         dPW6j/XvideO+QuXF23GON+r3If+kZpiAJb05wlciSvEFjOjfb8LScGzfcH5LDBaoB1U
         g2xp/jQrYRGwg6njTrChKsrUDKdCondUpR5c4OJgXHhkWRs9QIh/hpHZGpltKpdt6Q0u
         XsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pZB6ccNxWfk6NZibMKYvriXwtcv9GEZSbjmWhYH39uM=;
        b=bNVtNOpyt+WNdt5vQ5FhvFcdoMAINPzPZtrJpVoUcpAFMu58sI5xJ+11lpOCVjXH6E
         hKjfr+iysKG5Dbm95Jncl7EHnnkUtk7Y3+LzM9KgLYqY3dUf6Lk8lJNGP/FCUWwgTFV6
         JO2XA8Lo0gJUypVyfOBnAs4b9Z/R3vC0s+s2QnofBgk/qJvmTH6kkZfn0kRvCiY0mX+3
         xemuYNrEgU8RplFjaelgbZ56KAsuvLdzL8o6e8KT6LNb4xrQcjUFW39jS33nTBhC2FsB
         oQjBmI+ac53GHXBigz9KvFAarlbssca+AhUO8Cxx/2XDVI/tlWSoEYmBpFheIoWs3rtm
         GTWA==
X-Gm-Message-State: APjAAAVVzul9QdE+SGzBVxbtcl6kw8HDS2Gk3147b+TcBJzLwPvu/t8j
        NjLIxTS40CIhwQ3HOq7gUBOZd4bV
X-Google-Smtp-Source: APXvYqyXLQWP2YWfYYXXf9XULb2Gw7fEtx4CWNCQPRRlT6dSpDpNlZ6TmcDfGvNyRjVprADoEf1eMw==
X-Received: by 2002:a1c:5609:: with SMTP id k9mr15760608wmb.103.1571074716885;
        Mon, 14 Oct 2019 10:38:36 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id 36sm24981585wrp.30.2019.10.14.10.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 10:38:36 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 1/4] RDMA/core: Fix return code when modify_port isn't supported
Date:   Mon, 14 Oct 2019 20:38:14 +0300
Message-Id: <20191014173817.10596-2-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014173817.10596-1-kamalheib1@gmail.com>
References: <20191014173817.10596-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The proper return code is "-EOPNOTSUPP" when modify_port callback is not
supported.

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

