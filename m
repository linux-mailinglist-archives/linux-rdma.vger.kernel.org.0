Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C382335AA
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2019 18:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfFCQ5V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jun 2019 12:57:21 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:55074 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbfFCQ4E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jun 2019 12:56:04 -0400
Received: by mail-qt1-f202.google.com with SMTP id r57so8073957qtj.21
        for <linux-rdma@vger.kernel.org>; Mon, 03 Jun 2019 09:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EspxEupGJGiWEDXD9P4jjgWKmcXH74NzvYIbJ/AWgMI=;
        b=TJVcn1cLKwrCDqfOoDXp30a4H6TaXBKiwiHjDAdwongHK/bKzo02AftS+NOLHZV2qk
         uaXFTsh7OP9kK6tBgKChXJ2KBusgSI13ByE5QAJT4opcCyHzVAEN7KnoiqvVvgIk9UeZ
         thbX5DYw+Ya/O9Bt8a5AL4KNqAUsZ4B4hEfnsQKdt+gJFBe02e/Gllpw40I3Eh8jjzXh
         yX2E6mPgl8q0tFyhEApdfs/i0GKdcLnrmq2mOZHSQm727N+W9pKIuuH8ohRLmjbmQDTf
         QCPeVpMCsS5AlW/faffrLj+KIOBAFryuyM2XhBVLl0qrMu2w3WMArdINiV+/WP+bh/um
         j3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EspxEupGJGiWEDXD9P4jjgWKmcXH74NzvYIbJ/AWgMI=;
        b=Y73YB0/ubmRI7MmnU2++7VhAV2robmCt19W+z34xSCJCJFGipLb83J0/EMPlb1G6M1
         aWZnL4dnFYOZvIHwseZgjI9JlraDMTr4DIe00olyJbpLUyrCiD4q9N1Zl5pDbsvFy5VP
         OEw5qAv71e169XSSi0TXpFzurQ3ayR2SLrwK3YwbJrqlIxypaSCYC62vdtcVy/sNxFnt
         ZGCYD/JUx7Z1HcA3CnYsbgiaJfHZRhmjTs3EmUlRJsu6myNpq6uBVGESBuDsrXhv5Z8s
         DLtxFzMYQOwWWFHavgMcAmjvc9LeDErb7wqd1T/DAUUOgMICr9BB0I4TnRXkkZFToiSr
         VMtw==
X-Gm-Message-State: APjAAAWEzeatI9Smc6Qm/3ryGqUbv6YQNHHKqs2RJoveJUMeRj89y/yi
        QFLC0tB+wW12ZakuD6AMuwScakAofQk4jx34
X-Google-Smtp-Source: APXvYqyTJQX58jIU+0IdRLMyhel9C9SXAf29MqpC57OIYMzhYLqjfoH2DhcsbA5oBHVd1rJqiIiEUBwjKZJxchdB
X-Received: by 2002:a0c:be87:: with SMTP id n7mr3853859qvi.65.1559580963191;
 Mon, 03 Jun 2019 09:56:03 -0700 (PDT)
Date:   Mon,  3 Jun 2019 18:55:14 +0200
In-Reply-To: <cover.1559580831.git.andreyknvl@google.com>
Message-Id: <c829f93b19ad6af1b13be8935ce29baa8e58518f.1559580831.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v16 12/16] IB, arm64: untag user pointers in ib_uverbs_(re)reg_mr()
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

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

ib_uverbs_(re)reg_mr() use provided user pointers for vma lookups (through
e.g. mlx4_get_umem_mr()), which can only by done with untagged pointers.

Untag user pointers in these functions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 5a3a1780ceea..f88ee733e617 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -709,6 +709,8 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
+	cmd.start = untagged_addr(cmd.start);
+
 	if ((cmd.start & ~PAGE_MASK) != (cmd.hca_va & ~PAGE_MASK))
 		return -EINVAL;
 
@@ -791,6 +793,8 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
+	cmd.start = untagged_addr(cmd.start);
+
 	if (cmd.flags & ~IB_MR_REREG_SUPPORTED || !cmd.flags)
 		return -EINVAL;
 
-- 
2.22.0.rc1.311.g5d7573a151-goog

