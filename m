Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C212FA07
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 15:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfD3N0J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 09:26:09 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:40873 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfD3N0I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Apr 2019 09:26:08 -0400
Received: by mail-pg1-f202.google.com with SMTP id m9so9018309pge.7
        for <linux-rdma@vger.kernel.org>; Tue, 30 Apr 2019 06:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Qo5FEqXeJKdpmXvqV1aNmsvS1qf4QOcuAEvGRZnbU+I=;
        b=WJvgA7FhPH4nnlwUD7/cK+UGsQvztnpEwl/EwgwpETKSn2jcm2n8vXAJ5vmz+updJQ
         hv5vQG7S1TSnGIvsNFWmNlDJOuMgBbHPDTDqE1/Q7BSkSWZGsQSxWFmbI9EyZ11RD35O
         PoWicUER0x2L/roTgi03inDjhawM/RefWqQ0HU9dp3Bfb6piRBIYbrmvMjy86XgTN3si
         Ctsvudz1bGthwFBvr6qlHQElPSiMTUZTlDJzHWjXIK5Av3TkDr+6XQPdcLfX/oczYas3
         y01MzwmNMMd59RGZLYJMIFoZY0gr9B1FAyRfwBPJvm7Zd8dDqsp5xcnwSnBCo7S+GHIh
         eAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Qo5FEqXeJKdpmXvqV1aNmsvS1qf4QOcuAEvGRZnbU+I=;
        b=gSZvkNiOOYxKg6+J4+St4LSmJd2kY4ydvuaN7iyVSwcrWobw04mBf7HIB9qF+UQjzB
         406Wg8SGGcbmTmVA/Vf3jKuwke5lPpZpB2AcUNSocevgrFE70L584fGFhWZBrYasZGkD
         Z+dqCjqEd7DPQ5VkMCMTXKSLZsxSIF4dXs+QlIsL80zRVAC29dGh/RBw2j7zWgYEDBhA
         JjUl2asM2jw3wHsjdzUxBy+iUJYX8A1h6MbqSgHp2VEOm24o8zMPiK9NbOPQlpRojmWd
         KfCCSj/u7BBYlOvyqM6cr5lCZ6NNtiEte0NfQ9WNLAKj3iZKADYbsSGj1nPGPmj9oQtj
         +pqA==
X-Gm-Message-State: APjAAAVxSg2O9NV/5hNKmHwPu379KCfginfdTqFMiBVMU5vN5fQpoCiW
        lz/Ic6+V8ioj9er67kqcCQ9zcbbmppUvpA9Y
X-Google-Smtp-Source: APXvYqzC1lVWU3xOxPIpeGY1IySKfn9D9N99TINTSZcSwcwIPCbrd75tIMQec4oX3DSqqzuBnQc6miaAqMAhwGUH
X-Received: by 2002:a63:1d4f:: with SMTP id d15mr64183239pgm.347.1556630767405;
 Tue, 30 Apr 2019 06:26:07 -0700 (PDT)
Date:   Tue, 30 Apr 2019 15:25:12 +0200
In-Reply-To: <cover.1556630205.git.andreyknvl@google.com>
Message-Id: <c9ef2282b1860e3ca6da28a4d599c24ff7147bb7.1556630205.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1556630205.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v14 16/17] vfio/type1, arm64: untag user pointers in vaddr_get_pfn
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>, Kuehling@google.com,
        Felix <Felix.Kuehling@amd.com>, Deucher@google.com,
        Alexander <Alexander.Deucher@amd.com>, Koenig@google.com,
        Christian <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

vaddr_get_pfn() uses provided user pointers for vma lookups, which can
only by done with untagged pointers.

Untag user pointers in this function.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/vfio/vfio_iommu_type1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index d0f731c9920a..5daa966d799e 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -382,6 +382,8 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
 
 	down_read(&mm->mmap_sem);
 
+	vaddr = untagged_addr(vaddr);
+
 	vma = find_vma_intersection(mm, vaddr, vaddr + 1);
 
 	if (vma && vma->vm_flags & VM_PFNMAP) {
-- 
2.21.0.593.g511ec345e18-goog

