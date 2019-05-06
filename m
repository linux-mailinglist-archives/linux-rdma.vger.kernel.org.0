Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB825151B5
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 18:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfEFQbM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 12:31:12 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:45025 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFQbL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 12:31:11 -0400
Received: by mail-qk1-f201.google.com with SMTP id h16so2297693qke.11
        for <linux-rdma@vger.kernel.org>; Mon, 06 May 2019 09:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3tB4TRcqPwl6IgCCTq3FyKBtrVczmpENbbiRumQIu5I=;
        b=C5Bzseg2BAkWez5di4p65TqBX8PhS2fPXqJjrcuborrGzdIMmjBkEGS1oepu/kO4gi
         ZrAiwZ1YbirX9TOQW6iDBsdtMTgTZyQlBla9C/k5+v0DS9Eu7yTQTxvIZJRaIMRpa57h
         rZkszsH1RsVjkBjXJm8Nw6zDYrexUGyc9BNsDlgeAocqmj+aaO1LdZJjYgfxEDSFYcJj
         gjdVUEcQ+veFKjzDustw9+BWdSodbg3cE0gzjdewRwKOf7czWg4u+rE0852iiQixBdas
         JIw3pQAvoPC6IfNeEfBV09Q69TtafbxIB+dc/sgJQwlLGyiy5Ze3tqDZ/eiYCNwSry9q
         rXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3tB4TRcqPwl6IgCCTq3FyKBtrVczmpENbbiRumQIu5I=;
        b=rB2RuZJLtZnvvLBBTipNtwjgPSb/dVm/zaRERD7EjwZJ62gjluBT+M3oULJOojH1mm
         8ULsx5SaFYuZUyZ09QPLPHl0eljgMBPeIy/fVpsUtnImS7sFsjsjo3mR+Pl79rScV85S
         R7m0pBs1AMeIzJKa0Aaagzr/IJfjfXLgqVmbULqSwfeQYGW1MANp9Vus/l2eoA8DMhTc
         /a1I+U32YzbfWo5UXMqir+FFBStrkiFeTmil7IL6lThepG7Z+RUV44fbtHu0ApxR3jpl
         +ikSyH2pXnC3dwxE8Z9nDEsDbooYwpM2zExc/1AWoF3ODpWEOwM6DCkBy8qLFBeBHtmf
         g7gw==
X-Gm-Message-State: APjAAAUdHOL6LvWwH9gfmFfI6+tzQKke7L0YUUeqvZZt59foIxUvZX24
        9RMtBrZwVVxiKqZZ59+nowGU2sVIemaAgeoA
X-Google-Smtp-Source: APXvYqwDoIRoTGaFyeue7qd81SpE5xeykRQrED4HzbPSjcVVRn6t+xvIGHOhvH8ghp1kYB1swN7rJoVGjZYp31y2
X-Received: by 2002:ac8:3390:: with SMTP id c16mr6277321qtb.315.1557160270425;
 Mon, 06 May 2019 09:31:10 -0700 (PDT)
Date:   Mon,  6 May 2019 18:30:47 +0200
In-Reply-To: <cover.1557160186.git.andreyknvl@google.com>
Message-Id: <67ae3bd92e590d42af22ef2de0ad37b730a13837.1557160186.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1557160186.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v15 01/17] uaccess: add untagged_addr definition for other arches
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

To allow arm64 syscalls to accept tagged pointers from userspace, we must
untag them when they are passed to the kernel. Since untagging is done in
generic parts of the kernel, the untagged_addr macro needs to be defined
for all architectures.

Define it as a noop for architectures other than arm64.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/mm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6b10c21630f5..44041df804a6 100644
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
2.21.0.1020.gf2820cf01a-goog

