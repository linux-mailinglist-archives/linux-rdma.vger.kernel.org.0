Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72C3FF9FB
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 15:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbfD3NZ5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 09:25:57 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:37134 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfD3NZz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Apr 2019 09:25:55 -0400
Received: by mail-vk1-f202.google.com with SMTP id y19so6345238vky.4
        for <linux-rdma@vger.kernel.org>; Tue, 30 Apr 2019 06:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/erHdYVyxDvhPu3v7RMhd3dO9bpNIdyHyuRFKthPw/o=;
        b=eEiOGFetYWxih+SqIZFzGNfWcb2WG27fgr8umX6U99zGn9TVk7qoyvUJvyLbyO9646
         My6AFQXfx+E54pBbdCbbmUTy552nSiekbu8p+Z3EjOZkkRzKh6/KPKq2xMXR6PGCbeOC
         fF7Wnybo7p7oNGCxEtdGcC/SjUjb33krZmpxfplFBazN0BgfioX0FSzySTA4N97gTFrT
         W6ijBCliSwnkOOpdiWk5kSemwYixok6PKUQxZHW6VplcdEwGvrCZqCKdW+XjRywAL4b4
         tr3KgVn6nyJgYRcK+gwURasQznomoMLJd50NL8tFT/I0TUKbeATfwfeLLEXDX2wH0kWJ
         cXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/erHdYVyxDvhPu3v7RMhd3dO9bpNIdyHyuRFKthPw/o=;
        b=HM6Jir9pQNgG/gTX6UD9u/wD1qxs8xIgMmtrEF0uU2JoZDqYdij52KgqwHtNSmeO9M
         /cFYypNN7ym8AF5ZrP6L18r+FQQ3FD/RzLsmJ8j20+78SdlFmv4/LMf1/oDg6sNQPy1e
         ezuQyLXQGVU19xVhVEmt/T8O6tV2Qu9He4LquhkpddIaJ8cyRr23lgDNcAt+hHmTa5zz
         IWiylA9wihWbP/JBaBD/DMtYrH9iLuVL1EMHQEE8zAUENkujTBkFTzKJz58MewwYao+P
         5sltQQQBaVI/4Dy35YCilJdtqifM9obQEFF0OJQpN9i3CH2PXvnMH0V8709rtLHesYA/
         w7vA==
X-Gm-Message-State: APjAAAXD24qCZzUm4ut5yBmnded8hsc064Ufj+Snv5hoHjtrHeb4mjhL
        J32GLT3Gv7MHL/SBvybjtfg4a0gDyPazdJS/
X-Google-Smtp-Source: APXvYqz67px3tLUaZFP489IW2cHQSs+LvJjC7bfPcwFfPsiBelEm070ukqvUpFmAC3UEaQxQ+Sud/QNcvCPvUR/K
X-Received: by 2002:a67:82c8:: with SMTP id e191mr36596964vsd.24.1556630754448;
 Tue, 30 Apr 2019 06:25:54 -0700 (PDT)
Date:   Tue, 30 Apr 2019 15:25:08 +0200
In-Reply-To: <cover.1556630205.git.andreyknvl@google.com>
Message-Id: <9a50ef07d927cbccd9620894bda825e551168c3d.1556630205.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1556630205.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v14 12/17] drm/radeon, arm64: untag user pointers
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

radeon_ttm_tt_pin_userptr() uses provided user pointers for vma
lookups, which can only by done with untagged pointers. This patch
untags user pointers when they are being set in
radeon_ttm_tt_pin_userptr().

In amdgpu_gem_userptr_ioctl() an MMU notifier is set up with a (tagged)
userspace pointer. The untagged address should be used so that MMU
notifiers for the untagged address get correctly matched up with the right
BO. This patch untags user pointers in radeon_gem_userptr_ioctl().

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/gpu/drm/radeon/radeon_gem.c | 2 ++
 drivers/gpu/drm/radeon/radeon_ttm.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 44617dec8183..90eb78fb5eb2 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -291,6 +291,8 @@ int radeon_gem_userptr_ioctl(struct drm_device *dev, void *data,
 	uint32_t handle;
 	int r;
 
+	args->addr = untagged_addr(args->addr);
+
 	if (offset_in_page(args->addr | args->size))
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 9920a6fc11bf..dce722c494c1 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -742,7 +742,7 @@ int radeon_ttm_tt_set_userptr(struct ttm_tt *ttm, uint64_t addr,
 	if (gtt == NULL)
 		return -EINVAL;
 
-	gtt->userptr = addr;
+	gtt->userptr = untagged_addr(addr);
 	gtt->usermm = current->mm;
 	gtt->userflags = flags;
 	return 0;
-- 
2.21.0.593.g511ec345e18-goog

