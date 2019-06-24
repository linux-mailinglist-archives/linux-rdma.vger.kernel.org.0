Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEAEF50E5D
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 16:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfFXOdb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 10:33:31 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:40763 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbfFXOd1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jun 2019 10:33:27 -0400
Received: by mail-qt1-f202.google.com with SMTP id z6so17174852qtj.7
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2019 07:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hgUbj0aIma7FN/fDppNoJ1F9osla3F1YuX2112+Mp8s=;
        b=XScBtinbiUGDniM5VWwPkGG4/4TOXpRMgLEipRA38wBRqrcXcDq9jBk/0BRZ6x9hlI
         V9LUyuozhqT/IxEnIqdvY3TfW2BBFmFPeZMV6/kHE3QjS3QjydQyEBZrtxP0iPkgc0Lq
         Fl63uCJcNPhGHDYzX4eXyVr2le0SZJjeeiUUJ6M7ZIcaEAu7j+hLiu/GnMRfjOmk9l2j
         73WehpBOM1MSylhUeiF0hVgN+PDN+5kZdcFg4wO/LJNJCaEb2km52xgKxYMc9FCtyBPh
         HEL+2jGVAoHMOTxdl5nV9rz2oXMXpuOjUoFsub2nzlRgfcoGoFmp1CkWMhgLIpXXStyF
         WB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hgUbj0aIma7FN/fDppNoJ1F9osla3F1YuX2112+Mp8s=;
        b=QsGU4f3RKSNQiWqLWnzS6wehfUdj5SNg5uM5qSQS90dUCjxi1lXQVeih/MSA71N0QC
         AtyVbql641hUPKx7keH/TChclQ+oZ+5wtdocQKMLivZvDkv+hdEDIvgKTBSaOyAeMxVA
         vK7MkFY9qS5ACPXjGmL9fe6intqx+uvDbPinJCtUEul9d0oVgWdzlAIm3Wst412eciEj
         Tzt9BrgXCQqvAF5PIM4lubPiX/4YqocfqUj7+osjFLSd3pAafgvhUdA7Ix2TJhuRggo4
         BN/6Ph+bs2p8BPzkKYnuvHdC9MJV89LuN8vwrmMZlvTeDWvpJvTu1iJZXrT3OgwYJvgO
         JuWA==
X-Gm-Message-State: APjAAAUT6weLa2x10nfN5woFdFkTvnvVJDWA5VhwGepZxkiG9OnVtdSH
        Pk3T0DsCEHdAd1TYm7xpjjn3vuB7if/DIDBu
X-Google-Smtp-Source: APXvYqz02tw9mMb0OtKeZ2W98zeRoHwxKY7XE2woJy2A8vtl93nXys5C7sVpsVp2/N99zMzUyfh+KRmcoF+IJQVn
X-Received: by 2002:ac8:3811:: with SMTP id q17mr99190639qtb.315.1561386806511;
 Mon, 24 Jun 2019 07:33:26 -0700 (PDT)
Date:   Mon, 24 Jun 2019 16:32:52 +0200
In-Reply-To: <cover.1561386715.git.andreyknvl@google.com>
Message-Id: <41e0a911e4e4d533486a1468114e6878e21f9f84.1561386715.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1561386715.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v18 07/15] fs/namespace: untag user pointers in copy_mount_options
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

In copy_mount_options a user address is being subtracted from TASK_SIZE.
If the address is lower than TASK_SIZE, the size is calculated to not
allow the exact_copy_from_user() call to cross TASK_SIZE boundary.
However if the address is tagged, then the size will be calculated
incorrectly.

Untag the address before subtracting.

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 7660c2749c96..ec78f7223917 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2994,7 +2994,7 @@ void *copy_mount_options(const void __user * data)
 	 * the remainder of the page.
 	 */
 	/* copy_from_user cannot cross TASK_SIZE ! */
-	size = TASK_SIZE - (unsigned long)data;
+	size = TASK_SIZE - (unsigned long)untagged_addr(data);
 	if (size > PAGE_SIZE)
 		size = PAGE_SIZE;
 
-- 
2.22.0.410.gd8fdbe21b5-goog

