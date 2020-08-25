Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0E1251DE3
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 19:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgHYRNk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 13:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgHYRNY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Aug 2020 13:13:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E05C061574;
        Tue, 25 Aug 2020 10:13:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s20so3284495wmj.1;
        Tue, 25 Aug 2020 10:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9zdPP+ixD5btB9rUnV2PCqMFaLWLmvokRKNqPaploMc=;
        b=l7OqcEqzpV5sFQAKUw4Ad4brtyHFww6VzX++cOtf6yiV72jVHnvNVQXtWF9NEBYNyF
         O6ucgAFd/4xHHZ91bS7PkniSrGvGcw99TvWDs8b7IkiScC5szoZWhdHCK0NucTAAdzo5
         9jSSY1J0NQ1jeepijReRWNxN/b4ehR0eVQD6HxjUgQipFR3dHofBjU2ZwKZ2cURpyNaI
         OwGsjrOAdJH/iRVHm3wDAKxiQKEYLfuf15jKFeDSON5Ikeoh3SVO74fLD9K/2G/V3PYJ
         5YW0roKwRfeF/QxnQTRjKlRAbMM+Y+GuPkNCIwgiiYKu5X2aCb4ASqn/7O01eq7GQVzr
         nV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9zdPP+ixD5btB9rUnV2PCqMFaLWLmvokRKNqPaploMc=;
        b=fn+nCJ7fbXpfrMy4tUF4zqLSfUeh5phBX+fB4259uShe0Hiz7V7BZ5Imln6rWUt28n
         B2cAknKDt2sz0vfm8mDR6OLiCaX2+Xye8HQ+0Ys5tNEOdXNd359fnvVZVpfsHXi0MqPi
         oSjPopYm6KeTZcXCQpiAhrT1ykpUX6FwsGQywmhGeC/c5dQgRXI5F/sDCOKBWuZbT7Or
         uaopxyxecifsMBxoqCWsvPFLVSkeeWvdxIaqXLIRPFTYLqTbYkbQCt3xl3zdRh9i6pSn
         EK4FhuCHgU0InQcR/O8iWfkhOEIHnsX0cHZ76xQzqUOlnj7eNN7IulJpx5RjdZ+abH8f
         npNQ==
X-Gm-Message-State: AOAM531gQvWEgcx6RMQ2grBZYY2cE6ROXdNPfkXqcqw+AcIaD1i4PFqN
        6s7PNGrYVCpnB79BH11QUoU=
X-Google-Smtp-Source: ABdhPJyFP291QNDx9GUuNRd5pgcfbKBAtt9Sb52CfXp51RJacXX/0KuVQbGbCCcd0gk166zbdJVtJA==
X-Received: by 2002:a1c:bc85:: with SMTP id m127mr2933256wmf.70.1598375602806;
        Tue, 25 Aug 2020 10:13:22 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id v11sm33135194wrr.10.2020.08.25.10.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 10:13:22 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     alex.dewar90@gmail.com
Cc:     dennis.dalessandro@intel.com, dledford@redhat.com,
        gustavo@embeddedor.com, jgg@ziepe.ca, joe@perches.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        mike.marciniszyn@intel.com, roland@purestorage.com
Subject: [PATCH v2 1/2] IB/qib: remove superfluous fallthrough statements
Date:   Tue, 25 Aug 2020 18:12:42 +0100
Message-Id: <20200825171242.448447-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <64d7e1c9-9c6a-93f3-ce0a-c24b1c236071@gmail.com>
References: <64d7e1c9-9c6a-93f3-ce0a-c24b1c236071@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit 36a8f01cd24b ("IB/qib: Add congestion control agent implementation")
erroneously marked a couple of switch cases as /* FALLTHROUGH */, which
were later converted to fallthrough statements by commit df561f6688fe
("treewide: Use fallthrough pseudo-keyword"). This triggered a Coverity
warning about unreachable code.

Remove the fallthrough statements.

Addresses-Coverity: ("Unreachable code")
Fixes: 36a8f01cd24b ("IB/qib: Add congestion control agent implementation")
Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
v2: Do refactoring in a separate patch (Gustavo)
---
 drivers/infiniband/hw/qib/qib_mad.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_mad.c b/drivers/infiniband/hw/qib/qib_mad.c
index e7789e724f56..f972e559a8a7 100644
--- a/drivers/infiniband/hw/qib/qib_mad.c
+++ b/drivers/infiniband/hw/qib/qib_mad.c
@@ -2322,7 +2322,6 @@ static int process_cc(struct ib_device *ibdev, int mad_flags,
 			ret = cc_get_congestion_control_table(ccp, ibdev, port);
 			goto bail;
 
-			fallthrough;
 		default:
 			ccp->status |= IB_SMP_UNSUP_METH_ATTR;
 			ret = reply((struct ib_smp *) ccp);
@@ -2339,7 +2338,6 @@ static int process_cc(struct ib_device *ibdev, int mad_flags,
 			ret = cc_set_congestion_control_table(ccp, ibdev, port);
 			goto bail;
 
-			fallthrough;
 		default:
 			ccp->status |= IB_SMP_UNSUP_METH_ATTR;
 			ret = reply((struct ib_smp *) ccp);
-- 
2.28.0

