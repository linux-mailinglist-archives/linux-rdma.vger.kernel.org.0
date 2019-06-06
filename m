Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA3E737C75
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 20:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfFFSov (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 14:44:51 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46069 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfFFSou (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 14:44:50 -0400
Received: by mail-qk1-f195.google.com with SMTP id s22so2104246qkj.12
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jun 2019 11:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m5r23PQEATRs0yuo7EiwMQdVkzY1U+YCz5n+ShEeoJ4=;
        b=NWo/t5Eg8vkPop9rmLEJM24/TPCJSDGLkfJSg++y8tqe0YH7o0F0c+BLBxXYqlWbHn
         TQBM+rvo5UiyMgZHvqK7Pvgn4ARc08XbQ20YAC3fqCirAP5zyCBTuaRKGYQxA5+ez9MY
         5dtAcK3pg10dTEX2QJmbgVOe2q4izOeIa/IhaKfFTg1LtlOqd5CgPkliph8c0pVndS4n
         r9g5yTZjE2Bz4PyNamQroNF8IT3K4ojSe1Y0KMRcIsSxPFsRL0WgkcnPYGMbxXNaACfs
         /YPv4ioHw6zlpgsrcrlglyXYrBLyXki3e7XQt67BaOsoljLrmJ+pampgcg1bCjvTHEk3
         u1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m5r23PQEATRs0yuo7EiwMQdVkzY1U+YCz5n+ShEeoJ4=;
        b=RyFCIkzyp19GQAbs/kp/LMhWTN992tjosL8Dp+4kiQiUq7Grb+i5ZaREHtAZXWP9s/
         q/ifSfQXjGEOp8+51cIcaDUnJwtLfcEww9fMzwxMqPUf1gZGp2rtwHlxbdRZhueslkFk
         EQ0n4L/6yhrV3FnaLgNvUycXFslZClHrqwZCKisKmv1tKPYSXx8eT362z8xoWYDirb6Z
         12Q7v1B0HzDcZVN01/3xRcLOoe9pmvGmoSJYLJNJ4R0DaS6xW3rwNjRobOeqOGOWsGLg
         CSCTPXV2Nt85l+eQgoTorIT/KURcH3GNe3h2Xvi93hZurP9WvQy8L+t/1WufjyGArIoA
         fCpw==
X-Gm-Message-State: APjAAAWhybLDzq7YCW7O+e8u7A9rrpGEI2byIPV0YjcHFTWIZV4xJPsA
        jDz1/1zdPi/ZE8Z62cC8pc5r51sfe5JNMQ==
X-Google-Smtp-Source: APXvYqyDTfgtep66c/jLgBTZULmgoKmkAN7hyfuI/DrREbp9gQ0U06D4ocKYi5xCroJDWLKbh/kYjQ==
X-Received: by 2002:ae9:c30e:: with SMTP id n14mr34724569qkg.220.1559846689590;
        Thu, 06 Jun 2019 11:44:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id s64sm1267327qkb.56.2019.06.06.11.44.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 11:44:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYxNV-0008Ir-QZ; Thu, 06 Jun 2019 15:44:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v2 hmm 09/11] mm/hmm: Poison hmm_range during unregister
Date:   Thu,  6 Jun 2019 15:44:36 -0300
Message-Id: <20190606184438.31646-10-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606184438.31646-1-jgg@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Trying to misuse a range outside its lifetime is a kernel bug. Use WARN_ON
and poison bytes to detect this condition.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
---
v2
- Keep range start/end valid after unregistration (Jerome)
---
 mm/hmm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 6802de7080d172..c2fecb3ecb11e1 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -937,7 +937,7 @@ void hmm_range_unregister(struct hmm_range *range)
 	struct hmm *hmm = range->hmm;
 
 	/* Sanity check this really should not happen. */
-	if (hmm == NULL || range->end <= range->start)
+	if (WARN_ON(range->end <= range->start))
 		return;
 
 	mutex_lock(&hmm->lock);
@@ -948,7 +948,10 @@ void hmm_range_unregister(struct hmm_range *range)
 	range->valid = false;
 	mmput(hmm->mm);
 	hmm_put(hmm);
-	range->hmm = NULL;
+
+	/* The range is now invalid, leave it poisoned. */
+	range->valid = false;
+	memset(&range->hmm, POISON_INUSE, sizeof(range->hmm));
 }
 EXPORT_SYMBOL(hmm_range_unregister);
 
-- 
2.21.0

