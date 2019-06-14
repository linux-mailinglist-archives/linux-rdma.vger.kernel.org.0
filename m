Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16A08450DC
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 02:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfFNAo7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 20:44:59 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33673 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfFNAo6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 20:44:58 -0400
Received: by mail-qt1-f194.google.com with SMTP id x2so637953qtr.0
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2019 17:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dvkFkBeOW+6z/DYza2/ra7fU7bkF8TW6bEZ+9Ch/ZO4=;
        b=eYn88FgunOZPk+YyYFR2JnEf7f2u6p9sflPJ4sT+jetqG8JYSyAB8le6N712NkSohY
         Xwi2VyaEkzxPEqC8yi2d5vTAq6YJehvf3luJZZZ4GvsaI+jdZ2gVqX0uxK3KJG8fUqJN
         3FvqnY5Sb8nnX+WQ++LovwzB8U/d4qUmUyh+DIkLwGIxK2N5g7LSrT+GUNIoWzDFfVad
         ehBIjCCC/XRamOtEckjvwtqZSft++bwMX6ZPisONHj3wc7uPh1GqiR5ueIOcNZHjO+1j
         aWPQ70BMw6QV6bP5mmW+tRl6mOixqkIWqtgj8Ext78+i143gu4SmwIuthYXP1wzIHsDP
         faQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dvkFkBeOW+6z/DYza2/ra7fU7bkF8TW6bEZ+9Ch/ZO4=;
        b=C1bEaR6PXV+q5WXXLngZiZu0EJWsVASrih/H7/Hmou9DhmBu+EbL1QiHwv0NqOAM3c
         l2FGWzsa5iFE+TwOg7oQHHgdCIHXxi/DO4ssz2q/LekfhIXEFNv3f9rkdGQIku/SZxZU
         7w0G9CaHh1pKsEXpv7giLzsPl2GmJ4LQsXL+pLjdrqgCjMhOlCMpYeVSnZyhrkt59XEU
         WpZ5AfVyOdeHDqzmHBA8iiRiZmrhEXvxpDgCE57fGnyyWK+EYZKAdozczRGfy+VH0S+X
         2yOGRkVkSlyLzvrf20pDt4lfTwUlrPNLLW/F68iO1al5JkVbE9D3GWjyjA0klS64FTTD
         wasg==
X-Gm-Message-State: APjAAAUmwT3iWMS3rWf8WgZIgoLV92GJxB3ai6yZ7KkAHNrYj7U50UAU
        O9l7dHHpzz4DyUS+eiT018Nryg==
X-Google-Smtp-Source: APXvYqwehM/5YZE2rHAarSGtvnt4dD381MX43AFO3OEKYtZwTgDkAYkIX/giHqXAhpmFto1vVdJqMw==
X-Received: by 2002:aed:21ca:: with SMTP id m10mr72204568qtc.97.1560473097656;
        Thu, 13 Jun 2019 17:44:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id o27sm688657qtf.13.2019.06.13.17.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 17:44:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbaKr-0005K8-TQ; Thu, 13 Jun 2019 21:44:53 -0300
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
        Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 hmm 07/12] mm/hmm: Use lockdep instead of comments
Date:   Thu, 13 Jun 2019 21:44:45 -0300
Message-Id: <20190614004450.20252-8-jgg@ziepe.ca>
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

So we can check locking at runtime.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
Tested-by: Philip Yang <Philip.Yang@amd.com>
---
v2
- Fix missing & in lockdeps (Jason)
---
 mm/hmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 58712d74edd585..c0f622f86223c2 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -253,11 +253,11 @@ static const struct mmu_notifier_ops hmm_mmu_notifier_ops = {
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
2.21.0

