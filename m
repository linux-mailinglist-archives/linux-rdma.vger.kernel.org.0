Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7803750E52
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 16:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfFXOeY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 10:34:24 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:37799 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729570AbfFXOdm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jun 2019 10:33:42 -0400
Received: by mail-vs1-f74.google.com with SMTP id a23so3946775vsn.4
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2019 07:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+QjTccShtmk/DNvEu2Adujr4/24uQqkMA4u/Npu2BdA=;
        b=BuaO5811jnUX9zfd4G8ToBhrbhMJy0LzFmcX+sgB7AQM8NJvSv01OIt+sAqC0IYDFj
         O+VE+bcKl7xzCDnEKiecjcqkjUhFXSFgcq02fOM7s9XnYH4kbv5oATeSWl+tEWpHxjax
         uddXNBc9L6bsecbckcats1vGIj+FRm1AXB1jETFkmq7osCy5XjHt0r7A/MylVaoS7sEi
         BEqqQGEpCtD+G1DLTSJRrPX1jP7q6JLRto0o7pT68gHSfXhTroGbTpoKZNwyLPn4gBNV
         8ODVys95W2+g/mSu4Rja/qhLF+ras1jurnSxRwwt4QC/Gcz8iYCVwlkq+O0Dgaz38Z6X
         Qigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+QjTccShtmk/DNvEu2Adujr4/24uQqkMA4u/Npu2BdA=;
        b=E6Fd3Ar9Gbo+4QupjlrTOIyiz9uxovDrXrsI3Z2l11iaGCrjzywf6x+GCOmS2C2eQG
         YN2J8smZXIWS/0IH9DcxAJ3uvHXARp5iTGYXMs472f2zYDKizO8LTSGsbxqknGJIqeMb
         EUOj9v9alNo6M+dNGu1jHm4VHJPYYSd8W/Uoy5oRrw8r3ehk1p++PD7061RKdKjiizNQ
         QHpC2QeyX/1uwHrDyqAiIkcJbMwB+B+n1FN3njf8pGarDffaJJHYK4ecCDOftyHjHwoU
         7V/n36L6SVlr0Hh2BsB/+1+ZXxFACSF8Xcll883tonB6XJpxMSDe4iqzD2go9LrTavvl
         YmpA==
X-Gm-Message-State: APjAAAV9k973pr3ZOba98IP/t2uV3qq3Tir21wBGdd/fOTbUFgrgbTPE
        sPOpIRDvWRA9tRSIu8oYKbXWdCqNEURHHXX0
X-Google-Smtp-Source: APXvYqyUWW8huBSfbOwzfvyZrK53WvzmxiQ9by61ETLtrVtF59paHvOBrjS1vPlQyT8G9KXO3foj9yEr/dGEqynR
X-Received: by 2002:a1f:a887:: with SMTP id r129mr2036386vke.75.1561386821206;
 Mon, 24 Jun 2019 07:33:41 -0700 (PDT)
Date:   Mon, 24 Jun 2019 16:32:56 +0200
In-Reply-To: <cover.1561386715.git.andreyknvl@google.com>
Message-Id: <ea0ff94ef2b8af12ea6c222c5ebd970e0849b6dd.1561386715.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1561386715.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v18 11/15] IB/mlx4: untag user pointers in mlx4_get_umem_mr
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
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch is a part of a series that extends kernel ABI to allow to pass
tagged user pointers (with the top byte set to something else other than
0x00) as syscall arguments.

mlx4_get_umem_mr() uses provided user pointers for vma lookups, which can
only by done with untagged pointers.

Untag user pointers in this function.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/infiniband/hw/mlx4/mr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index 355205a28544..13d9f917f249 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -378,6 +378,7 @@ static struct ib_umem *mlx4_get_umem_mr(struct ib_udata *udata, u64 start,
 	 * again
 	 */
 	if (!ib_access_writable(access_flags)) {
+		unsigned long untagged_start = untagged_addr(start);
 		struct vm_area_struct *vma;
 
 		down_read(&current->mm->mmap_sem);
@@ -386,9 +387,9 @@ static struct ib_umem *mlx4_get_umem_mr(struct ib_udata *udata, u64 start,
 		 * cover the memory, but for now it requires a single vma to
 		 * entirely cover the MR to support RO mappings.
 		 */
-		vma = find_vma(current->mm, start);
-		if (vma && vma->vm_end >= start + length &&
-		    vma->vm_start <= start) {
+		vma = find_vma(current->mm, untagged_start);
+		if (vma && vma->vm_end >= untagged_start + length &&
+		    vma->vm_start <= untagged_start) {
 			if (vma->vm_flags & VM_WRITE)
 				access_flags |= IB_ACCESS_LOCAL_WRITE;
 		} else {
-- 
2.22.0.410.gd8fdbe21b5-goog

