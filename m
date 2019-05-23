Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00BC028155
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 17:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbfEWPep (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 11:34:45 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33373 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731075AbfEWPep (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 11:34:45 -0400
Received: by mail-qt1-f196.google.com with SMTP id z5so884866qtb.0
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2019 08:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fyMd/20M9wRDEt2CUwmbtJJl1RcuuD2R+QgKbl3Q/tc=;
        b=JIjtmXhIk+ouBJQ777LOHATYHiCxeddr9NRCIpfSEdrQ1ap9ixS0CW54V6HURwC9xA
         RKpjT/mKs8jM8bOrU+JpE9OrzRhV1PSZWwxlmuIpZMYfSawM5XO76xU4PAAGkcWLSm5s
         7ndty4jjdbxARiXmFK166PeUPWVyFicpugoKluqPMkVT0YjQEoLXox9cyoZwmEcFagdx
         vDMEFLfHF1VypHEJSnZkoDjj4S4j7WOn++WkjrFxWKF7S2FzamGOtEw9nQxisne15cmS
         QxE2dETQ9lLxC5EcMBOuIOrkEj8esYg8qdZuZD+Z0aF0lIU814C/ZVRZzLowQaUo/lk1
         YE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fyMd/20M9wRDEt2CUwmbtJJl1RcuuD2R+QgKbl3Q/tc=;
        b=RhKCj8DufQHdzP/9CBeh8jI88O85sCnYqnyDtYFRIheAlpU7s4ZInEmC2Ers/rJUjh
         uHJvwv1KWXfn8RyuxTDJ0I2jXufVIdMQeV1+3VyzaJIrw+klGXqN1XZfXtQcwFaccSEf
         2HWoeDN9fwopk+xcS6QK8o4PSiHDbjLlVbEWe1fLk6fAswl3CIwxWC3rhMIMVfjw7/bx
         0ATkjOLGVhi+o3/4lnpRfmXexIi7rh+r0y7N3WGcbrLQXAb9b6O1pCUH0aF8619XAvqQ
         cEzDZdm2AVyd4+Du0lbh+lcxkUVAwfNy64cj6f9rEuvjB3dZ4DKRFVvZiPmRC3dz+Mib
         ruZA==
X-Gm-Message-State: APjAAAVMfuT4IZ3xhikA0fCewGInoUnVIvEBBwLdUVEh+JDR6C/MRUV9
        CGT81gt01ZhLPGqU1abxnrxNRGPiaRM=
X-Google-Smtp-Source: APXvYqx/4tQV+dyjpchgQ23NYg/m02UvYl5N+Rh/idEA6TgEqyIlzTWmi6NKvXZCk10ahm2Boj71vA==
X-Received: by 2002:ac8:7c9:: with SMTP id m9mr15162695qth.127.1558625684072;
        Thu, 23 May 2019 08:34:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id t17sm17461892qte.66.2019.05.23.08.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 08:34:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTpjq-000503-9i; Thu, 23 May 2019 12:34:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [RFC PATCH 10/11] mm/hmm: Poison hmm_range during unregister
Date:   Thu, 23 May 2019 12:34:35 -0300
Message-Id: <20190523153436.19102-11-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523153436.19102-1-jgg@ziepe.ca>
References: <20190523153436.19102-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Trying to misuse a range outside its lifetime is a kernel bug. Use WARN_ON
and poison bytes to detect this condition.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 6c3b7398672c29..02752d3ef2ed92 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -936,8 +936,7 @@ EXPORT_SYMBOL(hmm_range_register);
  */
 void hmm_range_unregister(struct hmm_range *range)
 {
-	/* Sanity check this really should not happen. */
-	if (range->hmm == NULL || range->end <= range->start)
+	if (WARN_ON(range->end <= range->start))
 		return;
 
 	mutex_lock(&range->hmm->lock);
@@ -945,9 +944,13 @@ void hmm_range_unregister(struct hmm_range *range)
 	mutex_unlock(&range->hmm->lock);
 
 	/* Drop reference taken by hmm_range_register() */
-	range->valid = false;
 	hmm_put(range->hmm);
-	range->hmm = NULL;
+
+	/* The range is now invalid, leave it poisoned. */
+	range->valid = false;
+	range->start = ULONG_MAX;
+	range->end = 0;
+	memset(&range->hmm, POISON_INUSE, sizeof(range->hmm));
 }
 EXPORT_SYMBOL(hmm_range_unregister);
 
-- 
2.21.0

