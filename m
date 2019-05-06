Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBB01516C
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 18:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfEFQcP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 12:32:15 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:36771 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfEFQb5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 12:31:57 -0400
Received: by mail-yw1-f73.google.com with SMTP id j62so26230833ywe.3
        for <linux-rdma@vger.kernel.org>; Mon, 06 May 2019 09:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=40kxRsKyA2BTdfRG/8ycbW9cjWXHDWQTNAmN4QMp2Tc=;
        b=CbTDaybxwiO68FYaqEU987JbmTIWC/O/zmn5u4LAT2NjIg4zrx3ZZpTdEat2IZI7Zr
         UMjh3JrD6tSSJSHiA2J1SvwKqxkOFH9jD5t4pSSsFkT8XO0YzO5s2D93y2Fvv558QDT8
         PC2RKfy08bb/yMf67M9jkhQd5jNijh0tU+IEPR6RStdwOkRtKLjro1177XiqKVVA8CKn
         7nvBlr71nBnQ+GeGRfOaL9uXIjXsWpEFZPxFZ6iufv0v5siPwgW5vA64wYvStilJ/+ml
         T4dkOygYLm3ryZPhfxVQJsF9+4XGOGyyv3U3USZs8bMzVBnZRwvcMGmsqol00hqY8fWp
         TxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=40kxRsKyA2BTdfRG/8ycbW9cjWXHDWQTNAmN4QMp2Tc=;
        b=onIY6lSDpFg6CRPdpO4z35251g5Zio63Mj+qQtkRQL4mWf0/zsF1NLk27QjE9acie0
         V/TpXtyfjAhlp1EdMmEM3nmmix6wT4qdbH/AnbmJycnxB31h1encrecJstR3bAB64Irf
         gpkUGvhKutRZ4oWTx2hev7mas7lClkd94uH1kghNl8E16nlm+2y1ROiUUowt4H+m0ZUY
         NxglyjdW32vbyXhUgqQJenhZJqqE6H80oi/vQ2cs5W1+3w7JQe9Hz/lHZ9V0Ipm00NX4
         rTg72BEpUmfm1hssD7X9nyblqKAvyi/EGrXhMM2GZelb8mIBGVQNSsb07jZt/iA/mDw2
         0lPg==
X-Gm-Message-State: APjAAAUDJT07L39/yxiX7f5b6dl8fmkAOLf/WKEQjOCiH5sUecHNCbuJ
        U1zDv5Zd3uReC+dZdf1FGs44rlkoTcxC8hK0
X-Google-Smtp-Source: APXvYqy7sMh67zqP2gW9MSWmQP0vNhHkuufaU8XQ9cxxJZb1a1Qrmr7t2Ui4wSymuQ40ovJdWXqcMvlrm4Ub8jqq
X-Received: by 2002:a25:c5c8:: with SMTP id v191mr18795942ybe.52.1557160316771;
 Mon, 06 May 2019 09:31:56 -0700 (PDT)
Date:   Mon,  6 May 2019 18:31:02 +0200
In-Reply-To: <cover.1557160186.git.andreyknvl@google.com>
Message-Id: <69a675a5c48fa2572162338c51a1bfa2a3ced27d.1557160186.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1557160186.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v15 16/17] vfio/type1, arm64: untag user pointers in vaddr_get_pfn
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
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
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
2.21.0.1020.gf2820cf01a-goog

