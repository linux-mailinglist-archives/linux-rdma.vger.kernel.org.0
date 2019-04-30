Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC7BAFA1D
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 15:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfD3N1E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 09:27:04 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:49314 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbfD3NZt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Apr 2019 09:25:49 -0400
Received: by mail-qt1-f202.google.com with SMTP id w45so13382418qtb.16
        for <linux-rdma@vger.kernel.org>; Tue, 30 Apr 2019 06:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pQaENO1QgY/e9MwQ0ENVfJipTlkpkaPmrD1twTVYLJ0=;
        b=DQlymDAakXGN/s4aLv8FvnKDxFM3vFWe0ntwkbEht00uRZJyqzxLv2z+v+0YWcHIgB
         sKEjfbgI8NGPishfLFVkzFtit1j8To4k9tOzAqlClb7eaOmN2puCzEFRoWDOow3x6abM
         kF5rtq7WeiaNC1bvr93O8cSv4wiLQYr7p1i1gibkW3E+uyrFOpeeQawgxMfeq7+k8NA+
         lhqPJjcIYupZYzc0GZblGzb4ejeI2t/6j/U8CyZxFUtArO4WewVdwtuEJHeP7D/0QDFm
         3J0WxXCQ6Yi/AJW67UTm3sBwIOkc0wcf7BPZUgJdkZ1LyiC4qY/JaOc6zgNq+gGsc78b
         WDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pQaENO1QgY/e9MwQ0ENVfJipTlkpkaPmrD1twTVYLJ0=;
        b=Y0XPswBTjd2kNMBURF6OkSRKHETyMi6yhPkRmYt6VxujVsmd9j6iQNY5wVV1yUqxV7
         mfhKKzK3AnmaJBUiv5kgbxPUE0nMz+naSQXPrEf0Hyu/6u202mMIFYY0GaIvVARUjMPd
         KJyzyuBqKrrW2MLhdScyGgff8CsnB1zGR0EeIDt0jVBXJwKC40QHz1bVvvm1xqZLa886
         NXI7/yjrWSzCksid5+zELQShcjGFy2mnVmL4Lu4EnVrwNMKKJBLdH4bDyEcCF+SuRukF
         y5KAwOI8sxykG0sOYV0/359/FdjfzWg1j1UhIs+UGhEL0mEVGErwN0MDoxOv7LIwht4t
         ujLQ==
X-Gm-Message-State: APjAAAU0QzsqQH4L/Yh3/p8zlG2ePkBrf4HVXLZ8H8/0QsHpjGJ8qubn
        zxCDhDyCP8P1Isr6QPK/i6kcaTWvl/gbqI92
X-Google-Smtp-Source: APXvYqzXVakUsCoJZt28GHuUY2fVSxrYrmmdkh7uTay5rLBg9HnfxGjKEfUnDj0v5eIkWQX2umWuPHIlib2dmYL6
X-Received: by 2002:aed:2a0c:: with SMTP id c12mr9957100qtd.232.1556630748252;
 Tue, 30 Apr 2019 06:25:48 -0700 (PDT)
Date:   Tue, 30 Apr 2019 15:25:06 +0200
In-Reply-To: <cover.1556630205.git.andreyknvl@google.com>
Message-Id: <7d3b28689d47c0fa1b80628f248dbf78548da25f.1556630205.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1556630205.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v14 10/17] fs, arm64: untag user pointers in fs/userfaultfd.c
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

userfaultfd_register() and userfaultfd_unregister() use provided user
pointers for vma lookups, which can only by done with untagged pointers.

Untag user pointers in these functions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 fs/userfaultfd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index f5de1e726356..fdee0db0e847 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1325,6 +1325,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		goto out;
 	}
 
+	uffdio_register.range.start =
+		untagged_addr(uffdio_register.range.start);
+
 	ret = validate_range(mm, uffdio_register.range.start,
 			     uffdio_register.range.len);
 	if (ret)
@@ -1514,6 +1517,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
 		goto out;
 
+	uffdio_unregister.start = untagged_addr(uffdio_unregister.start);
+
 	ret = validate_range(mm, uffdio_unregister.start,
 			     uffdio_unregister.len);
 	if (ret)
-- 
2.21.0.593.g511ec345e18-goog

