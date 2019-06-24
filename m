Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE9D51CAC
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 23:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfFXVCG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 17:02:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34365 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbfFXVCF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jun 2019 17:02:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so15401683wrl.1
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2019 14:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2HyibpLykYkiKTwGwDVDE6Jz0uAzR58LFXlNi/YRy3U=;
        b=o/tFvhN275Le/5WQ2vu2fc7dpnfllCtch7SunXoc0gfrceioMrV84vJNXj3fcaoXjc
         qKdfy6+FErMOpWLLywUqcU/CCvqkzz60BPZVTd/0tIIXWv44kB8+wkXkIP3fIfmQuRfU
         VCtdLewh0B23U6TTG5KtYq7rxUdtI/n6yUmErMCpp/rXPr3h474Gd7GbjYQ+iiDYdpy1
         7shV4eVpmV49XoNejllG2+McGSuy2k7ZkrwJwBNEK6NQF3+JDLsqVqku3k4UUdsaGuab
         CgCCYDDWmuYZ06PXgv5ghP0Ro725vIEY+j0ePamWI4Lrm/GuhZ/Rebt3wxbycRP+uaHI
         i7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2HyibpLykYkiKTwGwDVDE6Jz0uAzR58LFXlNi/YRy3U=;
        b=TtjBwmt1jGNn+81oyPy0cYvUTqzerABuyBOutKfoU5PQDovtC1PlbEqQTWhmnd/HOP
         nHRyQsVBt4r4yMJy/ZJTkgA+LfwgZ3mse50ijcYNvPJybGeiiXi0emOWgxoUYPgXEmsN
         XgP1mnQ5lZZjjiKNjcvXbAHf3QL6zpvPgED46H04SbsmSVM1WL4RZzkV6T2e7JmMebZc
         wPGDn2OorShPSW3mKnIYon2cShf1h7w8Djy3BCtR/C/PfEB/F59/8l3Fg9KGo+25gyVC
         J3ozi91NMS9SP30k6XRloG+AerBB3fbq8n2JO2Z7C22Wore5QdfrzSnaiLEe3+k/BbAd
         cTPg==
X-Gm-Message-State: APjAAAXXLZ8siprYdAashlpFAP+EW8xLgean1LnpW/m0ckuBUx3v4U9J
        NcX7iIyI/Y7KSMetY9rSbG9YAg==
X-Google-Smtp-Source: APXvYqxbykTnskxCEk6vJXnhGhJhL+Hc/YVg3s4yNHZO6Rq1Ef69wTB8s8QzzXVmzALZYfvIEAb5sA==
X-Received: by 2002:adf:fa4c:: with SMTP id y12mr96903628wrr.282.1561410123670;
        Mon, 24 Jun 2019 14:02:03 -0700 (PDT)
Received: from ziepe.ca ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id x11sm469693wmg.23.2019.06.24.14.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 14:02:02 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hfW6D-0001Mb-0S; Mon, 24 Jun 2019 18:02:01 -0300
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
Subject: [PATCH v4 hmm 08/12] mm/hmm: Use lockdep instead of comments
Date:   Mon, 24 Jun 2019 18:01:06 -0300
Message-Id: <20190624210110.5098-9-jgg@ziepe.ca>
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

So we can check locking at runtime.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Philip Yang <Philip.Yang@amd.com>
---
v2
- Fix missing & in lockdeps (Jason)
---
 mm/hmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 1eddda45cefae7..6f5dc6d568feb1 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -246,11 +246,11 @@ static const struct mmu_notifier_ops hmm_mmu_notifier_ops = {
  *
  * To start mirroring a process address space, the device driver must register
  * an HMM mirror struct.
- *
- * THE mm->mmap_sem MUST BE HELD IN WRITE MODE !
  */
 int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)
 {
+	lockdep_assert_held_exclusive(&mm->mmap_sem);
+
 	/* Sanity check */
 	if (!mm || !mirror || !mirror->ops)
 		return -EINVAL;
-- 
2.22.0

