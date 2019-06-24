Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B88351CB5
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 23:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfFXVCJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 17:02:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52845 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbfFXVCJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jun 2019 17:02:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so674330wms.2
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2019 14:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y7+HSfyIPKIyVRlHiPSUTXfMPMA2cBMnzwF3/BJJWoM=;
        b=i+h5jdKODrJM6HAgihfib7r1p3HTIoXotHgwp0BCzd39jXyo1BGTDGN5CpLNMF70TR
         V6PVWeRW3fvAO6anYPbAasncAm2gfDig99onMjq8DGbcxmOsbdJoUx+UOv3Ew172buN4
         Vpsbiiy/5q+1oRn8UdTlfhMTuBnx4G1ji+wcVIaoYK5Nbt5H8mqxT5v/JzerbsooORD5
         HimcJCbD82rblSOa3TsdNlNx3R6AxGDFuxuK+lEyTuOggfGhT5ua5kBPNLimVjJkqu5U
         RIddsbNK0RH7LIGRspoDR8r0YYISQuOycZZHVH/0xfxFXODjXkabiQ3hMa0QYuximxJ6
         o2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y7+HSfyIPKIyVRlHiPSUTXfMPMA2cBMnzwF3/BJJWoM=;
        b=XltxyhcN8Kf1EQpGFO8uq8b8KCbxz7dCA6D5tks29Sltmjna9PCXRC44YmaBjctlol
         u8Z6Y/4Q+eQt0/kQF90ang03M/jQvIilygS3tiZF0T7hQNSoK9crmuwSplvNMZYtOD0n
         juqOTuwOImg5kzziXsxeMAzVHUvdqlKo/IW2Er6BKWp64JwzvhE24X6aavcamsXDnqSO
         40TK/HU3acIgYm9UFJt2nXhQwtRcC11137JFp8dx4D/fnNHAHbrAHzBEkWwghpA56StN
         MN4EYqgS6LNpvARkcB9nbYux/7+rpOUcTg9U0icWhwbIytEwhQjzqSfQ9q/EBRVnTMb8
         FjHg==
X-Gm-Message-State: APjAAAXg1B7HnPuZNsXRPwEK/CwLmDbraKrs8oi6lj6T7P1JqjyTLjBD
        fXMFQRjERns71FtRDNuUdndWRQ==
X-Google-Smtp-Source: APXvYqxYsEWfPj+ojP/Pdo0/oemDCD+9/xSgl5N/QS6OZzqvHa256HMQOw+3zV/4M5gAiwA2ZCoPBA==
X-Received: by 2002:a1c:228b:: with SMTP id i133mr17321325wmi.140.1561410126760;
        Mon, 24 Jun 2019 14:02:06 -0700 (PDT)
Received: from ziepe.ca ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id k125sm600943wmf.41.2019.06.24.14.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 14:02:02 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hfW6D-0001Mv-3O; Mon, 24 Jun 2019 18:02:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Philip Yang <Philip.Yang@amd.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH v4 hmm 10/12] mm/hmm: Poison hmm_range during unregister
Date:   Mon, 24 Jun 2019 18:01:08 -0300
Message-Id: <20190624210110.5098-11-jgg@ziepe.ca>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624210110.5098-1-jgg@ziepe.ca>
References: <20190624210110.5098-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Trying to misuse a range outside its lifetime is a kernel bug. Use poison
bytes to help detect this condition. Double unregister will reliably crash.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Tested-by: Philip Yang <Philip.Yang@amd.com>
---
v2
- Keep range start/end valid after unregistration (Jerome)
v3
- Revise some comments (John)
- Remove start/end WARN_ON (Souptick)
v4
- Fix tabs vs spaces in comment (Christoph)
---
 mm/hmm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 2ef14b2b5505f6..c30aa9403dbe4d 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -925,19 +925,21 @@ void hmm_range_unregister(struct hmm_range *range)
 {
 	struct hmm *hmm = range->hmm;
 
-	/* Sanity check this really should not happen. */
-	if (hmm == NULL || range->end <= range->start)
-		return;
-
 	mutex_lock(&hmm->lock);
 	list_del_init(&range->list);
 	mutex_unlock(&hmm->lock);
 
 	/* Drop reference taken by hmm_range_register() */
-	range->valid = false;
 	mmput(hmm->mm);
 	hmm_put(hmm);
-	range->hmm = NULL;
+
+	/*
+	 * The range is now invalid and the ref on the hmm is dropped, so
+	 * poison the pointer.  Leave other fields in place, for the caller's
+	 * use.
+	 */
+	range->valid = false;
+	memset(&range->hmm, POISON_INUSE, sizeof(range->hmm));
 }
 EXPORT_SYMBOL(hmm_range_unregister);
 
-- 
2.22.0

