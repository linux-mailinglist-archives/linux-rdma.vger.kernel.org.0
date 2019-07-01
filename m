Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0992233554
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2019 18:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfFCQz1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jun 2019 12:55:27 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:38954 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbfFCQz1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jun 2019 12:55:27 -0400
Received: by mail-yw1-f74.google.com with SMTP id w127so17210158ywe.6
        for <linux-rdma@vger.kernel.org>; Mon, 03 Jun 2019 09:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BzAJ0+9x2pcfr7Do5TUN53ZGOyHm87DfwLwwZIYymzc=;
        b=Gd3MS7x4gwNqCAsuebDb+LQXe1ROUCAjzPqIs7DNAteGO+I/k2kuk/JUQDg2yytLs0
         mAnj4aXyNOLD53bou+rnAjAI+DoFCDM6597Xb+r9d5tHdnUBLOhHUJdZUvwspRQQklB/
         nVb9mJ+RVgKXuTmdk46XK6MPO9GX2CvoeDiI4JmSZych6aS7p7s1LkUgQ8IFSJW5YLx/
         IwfItaZEAlz+YxcxGixqEutWhh0H0I+YiPlFdGJFMPEbbW0iVK8sXmL/5Dzp9W2t8wq7
         Jn42agr19zJj2QbOHan385htTUuPv+QknbBnCycF9d956GlhodbETKPupW6IU9maR3WJ
         cryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BzAJ0+9x2pcfr7Do5TUN53ZGOyHm87DfwLwwZIYymzc=;
        b=aKqSvLwqi4gb3EcQW5ufC6iGDYIY0I0faa0+Uh5GD+s31jb6nVn/FTW1O3AD8NHZiT
         vkIX/x4kkZa3lp+7VjLBC3uaaKHl51LYIku80Q8zNd1IDgveOwQCvrCMLQDrkXf3KdDb
         6BKh8B5DbcTFghipmiv+mGzxXAONbchzCK55fCjGPBFf807JLebkPCHB2GF8NgacQppE
         yV8zvk7TY8lwXCWiiFlDBBtQCBbpnYO2YKkwbZHeQqMHCCcprieV8cCScRMDJaeVIh/d
         3ahiW2vzmKT5EmKHI9cOaR0DBDWpYLZQKa05Jad4rV3GcY6Xwi3ZOgXAh31MkbMlR62X
         RAgw==
X-Gm-Message-State: APjAAAUKCQigS+sBNumQaYJWtvSipv4Bg0ZmT2Npyc/i5/NJnx7NM1jK
        CjyjlHcLcMU5LKqc95J1R50l+cnwBL9YkkRv
X-Google-Smtp-Source: APXvYqw8qo6YCAA2LDG0hCmceBSOfUoHZIsTSjRJKNeADMAk1c3BAJX7XTjP1o6wTWUARrevZDffoxW7ORioylDq
X-Received: by 2002:a25:4445:: with SMTP id r66mr13094125yba.55.1559580926346;
 Mon, 03 Jun 2019 09:55:26 -0700 (PDT)
Date:   Mon,  3 Jun 2019 18:55:03 +0200
In-Reply-To: <cover.1559580831.git.andreyknvl@google.com>
Message-Id: <097bc300a5c6554ca6fd1886421bb2e0adb03420.1559580831.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v16 01/16] uaccess: add untagged_addr definition for other arches
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

To allow arm64 syscalls to accept tagged pointers from userspace, we must
untag them when they are passed to the kernel. Since untagging is done in
generic parts of the kernel, the untagged_addr macro needs to be defined
for all architectures.

Define it as a noop for architectures other than arm64.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/mm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0e8834ac32b7..949d43e9c0b6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -99,6 +99,10 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 
+#ifndef untagged_addr
+#define untagged_addr(addr) (addr)
+#endif
+
 #ifndef __pa_symbol
 #define __pa_symbol(x)  __pa(RELOC_HIDE((unsigned long)(x), 0))
 #endif
-- 
2.22.0.rc1.311.g5d7573a151-goog

