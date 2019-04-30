Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B34FFA17
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 15:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfD3N0n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 09:26:43 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:52271 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbfD3N0E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Apr 2019 09:26:04 -0400
Received: by mail-yw1-f73.google.com with SMTP id g7so12807074ywb.19
        for <linux-rdma@vger.kernel.org>; Tue, 30 Apr 2019 06:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5vVbThWFeNTYFxwbQq67jdT1oZny+xOKBFoxX+2Uk7M=;
        b=FRME1COezh5b+xsqn4P+Wuk9kST7usWvir2xQhAmIzYbqhd+Dle1XM/PaJl5NwGBwF
         z7/SMrTqJtHy/gO4CF7xbqlFAwpIk8PwR9mnXkXEY1b5HFuyeguAZJRX9uVnCx/+N6Cg
         GdXjue/eQFQ6wfKzJUzNubo15IJ6ki/RwkeGwPRaQhUCcsmSJMlmZ6DdqtqFu3fOL0bX
         01e0qP9aKT8hITIugatecY8TuWXLv4w13ho7n2rx3qvyQwxwSmnnV+ESWDP6rPMjBLm6
         9em8VBa1zwsikfNNQo9I2iNQIYFHDIjY+xXevJ0y76Ma6MtOAyKoTjWTXLT8lERzPHTd
         0Kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5vVbThWFeNTYFxwbQq67jdT1oZny+xOKBFoxX+2Uk7M=;
        b=sAgg/TG/jrFBNYtTrbiNE/NwhGERbsL+s5UxwfngdkkH2INE6lJLGJ3+3Z2IZht2w+
         PiUc7YaNkNC2cej4ki5yEwymNEN5nA0AvR1vzgKryJXbpEb5vFSwZS79dFbZDuBXp8gi
         sCBWmH7IrDEQasPRaNm6avMk5C8R+biNdTufSN1opOkGyf+GyHe/dnh2mUosTNr5rl5S
         2FZFeFc5BVdHBVlRU4dSIPSqE6M9RNngv0hKt5Cm68qco/V55fBS6NYeMu4y2eP/zkCs
         KohB6fOjMJH/CHsBlJzsFS5l4/2APA68Pwz5oW0VH+4lgXg4fTImY1xi7n4a0gRiIf51
         abRg==
X-Gm-Message-State: APjAAAV4VbhNq6wOrpl20xQIJSsOCrWUPeU1QIg1rESosuY3wGZw3LJx
        n5FOmpAotctiY8P9bcFhnCAYhe0K9cnrvDyW
X-Google-Smtp-Source: APXvYqyv8kHiq9IuRt8k8uxL630nsRVEEuszbAKJggJOMl5SWFBjzMAnW0IWxRwAYYoqlPXLLWZ5sEsVnC5FF0Vx
X-Received: by 2002:a81:3c89:: with SMTP id j131mr56890450ywa.183.1556630764032;
 Tue, 30 Apr 2019 06:26:04 -0700 (PDT)
Date:   Tue, 30 Apr 2019 15:25:11 +0200
In-Reply-To: <cover.1556630205.git.andreyknvl@google.com>
Message-Id: <1b2a46dbfa24bde41f11cff6f53683a5ea5915c7.1556630205.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1556630205.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v14 15/17] tee, arm64: untag user pointers in tee_shm_register
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

tee_shm_register()->optee_shm_unregister()->check_mem_type() uses provided
user pointers for vma lookups (via __check_mem_type()), which can only by
done with untagged pointers.

Untag user pointers in this function.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/tee/tee_shm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 0b9ab1d0dd45..8e7b52ab6c63 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -263,6 +263,7 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 	shm->teedev = teedev;
 	shm->ctx = ctx;
 	shm->id = -1;
+	addr = untagged_addr(addr);
 	start = rounddown(addr, PAGE_SIZE);
 	shm->offset = addr - start;
 	shm->size = length;
-- 
2.21.0.593.g511ec345e18-goog

