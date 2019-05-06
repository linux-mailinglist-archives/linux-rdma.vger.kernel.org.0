Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD81151A9
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 18:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfEFQbQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 12:31:16 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:46175 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfEFQbO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 12:31:14 -0400
Received: by mail-ot1-f73.google.com with SMTP id a2so7767949otk.13
        for <linux-rdma@vger.kernel.org>; Mon, 06 May 2019 09:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/Xcm/dv07E6tB6Fg+Bd1uLrNx0q2WagwUZqys5y8XCQ=;
        b=rAOt6QkMD/QKlKVog82fKw84EsQnaASzO/nI8W5EIDbrmmjV3gr6+15mZ10SMb6Rf5
         i/ZniLNvWV//CPRfADxSnSKtN/6Gg017m4Gik6Cenllh7RN6CfI/AKj72maW2yKQfmpN
         GrE1GcO1EKZaX0U+I3FWYiw4misL8V2knxuMTZnhd7+ifYq/drNNa4087ayYcqsu4RzV
         YnDg0sSjmZfX/PgQJ/vdVYIZT3u95MTKmAQy8Dfp2UhL6OXfBsqkSnVsPRCgY0ZcNTeM
         d3f8I7eWT+VKLfqWWZufhZUUDge/eC39ycIbKQ1fqVyQEg05Z5H0MBzHuW0wC/j81BOZ
         a7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/Xcm/dv07E6tB6Fg+Bd1uLrNx0q2WagwUZqys5y8XCQ=;
        b=gJfLr+VnqH1sYEGmB+5DUKwcR1IckdN8yu2y2l6xmU/kFg/qd3qrQPWS1mZWrM88MU
         SjnOWKFMUTOCjbTuSG8zZIdniao3okjUoqvvdrBewaH3fmTyq0AGs/jzXyZaFKY6b8at
         Y15xHYKwRmOkzMsHsa3hjrQLrflU2dfU5FGmlsja0H9XsTaryhFqi7dI/vlokv1dV1K+
         lLtrxVfBS0P5Ev9r3IuLnFHhtCjGJnA484FCsK2IszjLFCUwGKVmyyK4eGtVYKnmzn38
         ZwFh7qDYzJdoUvabLoY1iWQimTIYA+2vxS9Qnl0EKdXOkfrBb9EOe+K/7FqFsvJoHVRO
         e7FA==
X-Gm-Message-State: APjAAAUP+4gciUYNqaFxWNxqxabYdTVQUfNzVQ+jLsBO2hl3YWw2n3LX
        VHkc9WypY0zZyf0wjM5U3Hgrfgf+ck7L/E+W
X-Google-Smtp-Source: APXvYqwsU29/a5rUuddp5tcfbPS3CQhzs1NWwE9FVJC7oUUpeYui7bu7Qsrr1jpZGFt27bCra6fHy1EBLcG5J9Rk
X-Received: by 2002:a9d:4917:: with SMTP id e23mr17423724otf.63.1557160273461;
 Mon, 06 May 2019 09:31:13 -0700 (PDT)
Date:   Mon,  6 May 2019 18:30:48 +0200
In-Reply-To: <cover.1557160186.git.andreyknvl@google.com>
Message-Id: <02e1242715cc1bf23a139e5e8152fb4feaa4b41d.1557160186.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1557160186.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v15 02/17] arm64: untag user pointers in access_ok and __uaccess_mask_ptr
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

copy_from_user (and a few other similar functions) are used to copy data
from user memory into the kernel memory or vice versa. Since a user can
provided a tagged pointer to one of the syscalls that use copy_from_user,
we need to correctly handle such pointers.

Do this by untagging user pointers in access_ok and in __uaccess_mask_ptr,
before performing access validity checks.

Note, that this patch only temporarily untags the pointers to perform the
checks, but then passes them as is into the kernel internals.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/uaccess.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index e5d5f31c6d36..9164ecb5feca 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -94,7 +94,7 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
 	return ret;
 }
 
-#define access_ok(addr, size)	__range_ok(addr, size)
+#define access_ok(addr, size)	__range_ok(untagged_addr(addr), size)
 #define user_addr_max			get_fs
 
 #define _ASM_EXTABLE(from, to)						\
@@ -226,7 +226,8 @@ static inline void uaccess_enable_not_uao(void)
 
 /*
  * Sanitise a uaccess pointer such that it becomes NULL if above the
- * current addr_limit.
+ * current addr_limit. In case the pointer is tagged (has the top byte set),
+ * untag the pointer before checking.
  */
 #define uaccess_mask_ptr(ptr) (__typeof__(ptr))__uaccess_mask_ptr(ptr)
 static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
@@ -234,10 +235,11 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	void __user *safe_ptr;
 
 	asm volatile(
-	"	bics	xzr, %1, %2\n"
+	"	bics	xzr, %3, %2\n"
 	"	csel	%0, %1, xzr, eq\n"
 	: "=&r" (safe_ptr)
-	: "r" (ptr), "r" (current_thread_info()->addr_limit)
+	: "r" (ptr), "r" (current_thread_info()->addr_limit),
+	  "r" (untagged_addr(ptr))
 	: "cc");
 
 	csdb();
-- 
2.21.0.1020.gf2820cf01a-goog

