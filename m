Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF94571E53
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 20:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391425AbfGWR7y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 13:59:54 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:33436 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391421AbfGWR7w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jul 2019 13:59:52 -0400
Received: by mail-qk1-f201.google.com with SMTP id t196so37161010qke.0
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jul 2019 10:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bykoKqk+RfxIttYDE7/GdnEkPwV+NEF/LkGgW6aheBM=;
        b=t2L6A3co0IUcO5jJEupAYqmfSwA1Pmfl3+ZcIn/5Q85mp2WLmhw1iqLCswQ9as3aOF
         a0D+pYMEhkdmm+KSqXmSiU/lD0Pz3h6uvkPAeVEHs1IFoAwnv5BA1YbF3d7nwG6M8iRR
         Z5NEOhmfG5y3nopQ695DATYQQfXAIYJG7yd7F+lB9VoEza1F669VXhs6jrCa2pvOvN6l
         r1p+w7pUdDXihW/3CqVYzRnheU9A6fqtUiCr4NASapwor3nhJC+/jeMNYPGIPNIFjoFu
         E4g9GrA8tUOQtGrCF4JaEQ7hr5aZJYBDV43aYbaG/BPoNEA3mTX8DLrogiBkcDNJOYJ5
         rrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bykoKqk+RfxIttYDE7/GdnEkPwV+NEF/LkGgW6aheBM=;
        b=IuHRacLYeFLCRO9QoHO2LiNr0LwuhjZMyU44ogJpeG0X4+eD6n0rtZFnYlhwL/WNVY
         kgruHf9/rflhMTXGTeURla1/umsGwWpE/zZrSfVSxKTn5g6ZwaQBrXkn2Lpl3cWaNU9R
         nWORpRWjl5cF3hVo8z2RcrxS1A5Tst8pHD6QRr+PZBqhwl5euezzf0UiMTqT6GQWS0+J
         sqfPxORZiZcOUAvlIG8f/3smxqLWCdPPj+Pq+2bnGbEfTtM1gw7dl0LaLcVz937kG28x
         LyMI6Zw6pj+wlGfUhinHKZ749DuUzOWjeyaMm2VbDCFr0I1pLZNfeni3zKZVlGURzp+4
         I5gA==
X-Gm-Message-State: APjAAAWjGiZWmqeYIJrXYv17QqfCSvmybI/tHU1nhJwiRGxkBF60x0Q1
        sq1g0+zUSDr6A5aCBDG5qQWD3piObHpdRr6F
X-Google-Smtp-Source: APXvYqzy6KvMjkfI7Gkvl5k12zd++ICAyNUe8J8soJHrycJkzCW148ZA79khH20QvBebUrjeGJ/TSw9Gqxxo1fEA
X-Received: by 2002:ac8:7251:: with SMTP id l17mr54199388qtp.277.1563904791730;
 Tue, 23 Jul 2019 10:59:51 -0700 (PDT)
Date:   Tue, 23 Jul 2019 19:58:51 +0200
In-Reply-To: <cover.1563904656.git.andreyknvl@google.com>
Message-Id: <87422b4d72116a975896f2b19b00f38acbd28f33.1563904656.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1563904656.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v19 14/15] vfio/type1: untag user pointers in vaddr_get_pfn
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
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch is a part of a series that extends kernel ABI to allow to pass
tagged user pointers (with the top byte set to something else other than
0x00) as syscall arguments.

vaddr_get_pfn() uses provided user pointers for vma lookups, which can
only by done with untagged pointers.

Untag user pointers in this function.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/vfio/vfio_iommu_type1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 054391f30fa8..67a24b4d0fa4 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -368,6 +368,8 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
 
 	down_read(&mm->mmap_sem);
 
+	vaddr = untagged_addr(vaddr);
+
 	vma = find_vma_intersection(mm, vaddr, vaddr + 1);
 
 	if (vma && vma->vm_flags & VM_PFNMAP) {
-- 
2.22.0.709.g102302147b-goog

