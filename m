Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C82E5450DB
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 02:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfFNAo7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 20:44:59 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39584 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfFNAo7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 20:44:59 -0400
Received: by mail-qt1-f196.google.com with SMTP id i34so598510qta.6
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2019 17:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TdUL2Q0xcyDT6JNdu0gecxArNl/zROPizNaMNSjNgKw=;
        b=FK1BE5Q4R1zyEjUAK720jTuxSx/cyRhVSQ3jayrUcNyqoaPlGBfGmGC1CPOx43s3ST
         6RpK5IdpVUApoJZo8g1TT+C5zdvZ2TG9uTPr7XHg6jJi/A9cEPbHcheLCuTa0i1x7Z41
         Mi3bwHwKr3TrXQAMy8P4kjfKrR78HOCBwiNjC5ZDJZ0bKUEU0G6TbXkgv+rpTyv/xlcc
         dIOmYy6zgWm5Iw4sumeXpNYtGyd/WNLx1EtYDSkyfOURkacd+3GKhBbELl5JFem6hlqX
         2IL4K40Gw3ZaHhwFwAEd4IWGIF1j4HktqVkUa6VK5L2oBj8qFHmE/mdZt+ga7o2HmLyu
         aP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TdUL2Q0xcyDT6JNdu0gecxArNl/zROPizNaMNSjNgKw=;
        b=cpk5JpjEjTB0urhmkAzU1ZEYi+lyoSwgTXTUmvvkiMN5tOls7tauPANS/RB3VoHrPc
         /QaEu2WWt1dgjT8Qci+RCYxNauasg6wAL8zgEue6ouKT/9rhqBvD1B7+2HOZW+QG8q0P
         lbvOnUIUN6/uTM7dRdZqMcjDcWB/GIl/0mTDoZneif9379eQ7ndVzNR38cSTbT/Rg5DY
         0U8WS9jIO4u1CjkqYl//44Ud9NDAgY0dzf6zE9Oh3JoO3G/iXg8QRPie75P5VEFInQS7
         DtQK5FiYnbVwWnvnIZIWIOelb2BnXWaEyo94zE5HYv1qQq+RtWPucwicWGpqW0likA5Q
         1VEQ==
X-Gm-Message-State: APjAAAXXDcPqnzO9TrzVTMypdohomT2HgSjAG4oy4P60QPibj7ckfGwj
        E0gYvZzbHH8fRqdQ+IWmy6MxfQ==
X-Google-Smtp-Source: APXvYqzF52VUT6PLbBdFr+9hAJYSTEw5qk29kEu9lNT9XBNX8ynGL9sSdzpvwppRLNVS4ebk9QrzSQ==
X-Received: by 2002:aed:224e:: with SMTP id o14mr78885704qtc.271.1560473098488;
        Thu, 13 Jun 2019 17:44:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id n48sm812748qtc.90.2019.06.13.17.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 17:44:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbaKr-0005KK-Vm; Thu, 13 Jun 2019 21:44:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 hmm 09/12] mm/hmm: Poison hmm_range during unregister
Date:   Thu, 13 Jun 2019 21:44:47 -0300
Message-Id: <20190614004450.20252-10-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190614004450.20252-1-jgg@ziepe.ca>
References: <20190614004450.20252-1-jgg@ziepe.ca>
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
---
 mm/hmm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index e3e0a811a3a774..e214668cba3474 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -933,19 +933,21 @@ void hmm_range_unregister(struct hmm_range *range)
 {
 	struct hmm *hmm = range->hmm;
 
-	/* Sanity check this really should not happen. */
-	if (hmm == NULL || range->end <= range->start)
-		return;
-
 	mutex_lock(&hmm->lock);
 	list_del_rcu(&range->list);
 	mutex_unlock(&hmm->lock);
 
 	/* Drop reference taken by hmm_range_register() */
-	range->valid = false;
 	mmput(hmm->mm);
 	hmm_put(hmm);
-	range->hmm = NULL;
+
+	/*
+	 * The range is now invalid and the ref on the hmm is dropped, so
+         * poison the pointer.  Leave other fields in place, for the caller's
+         * use.
+         */
+	range->valid = false;
+	memset(&range->hmm, POISON_INUSE, sizeof(range->hmm));
 }
 EXPORT_SYMBOL(hmm_range_unregister);
 
-- 
2.21.0

