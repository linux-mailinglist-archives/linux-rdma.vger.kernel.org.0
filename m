Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA09F42470
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 13:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438492AbfFLLoJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 07:44:09 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:46438 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438485AbfFLLoI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 07:44:08 -0400
Received: by mail-ot1-f73.google.com with SMTP id z52so7598983otb.13
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2019 04:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9qcG2BgTwk3XlX0RcWVeDPHI8lhK5DjmwRDy1FE/sPA=;
        b=NtLJcSSFMHHu317AevzAQ/30ZKEUOStp0YqobtwksbYseFWqgtaBTFdiHMGyyyf7At
         YDJhLaCkyHoSzl2vKPQ0kqczt1dgoIP6M4Ipn73b/OGJITm9/nwiI3El0EdSAptKyxy3
         b89x7f/UmAMLYhahbGWtvHAEQvqe/KEbHnD9FTBIwA/5CD9mYyTGMXM5MGTE55QAL6sy
         I3ZLX4P7OcoVJPIKw9PZDhGTJmKOWHMHOrsjABMEwlErwDLgIe9+iGkSdgcah0pP/nqE
         b30uAgSnuW/RhTjVNWI3Kw8grpBZAvIwRQ2tzxM9A7fFKVadA2sdBJN3nJtOltKf1dPe
         uUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9qcG2BgTwk3XlX0RcWVeDPHI8lhK5DjmwRDy1FE/sPA=;
        b=ocyXCJpduUNrCoy7A7R6FnZu4djejeLKJqMujRaK4mGDIQN23sitX8jviOwPMvp/Mf
         k17PT4vIYL0AQMv9p+UCN/AINm6ugoXSdrHAGByfnUuCNk5XUfU5FMJ7/mTxfABCxmjb
         HYF/JH/UBYF3NS6XRNW4+aUgbsC8TIxm22JIo4OssKyaZFLeXNVpYS0DMmf2hVQtM4NI
         JR+tbh1TMVcrD8xyvek3Cs+QsePM+Udxmk7NIJUZYC95iTa5vvspbgwqdTEyJFCDqQrJ
         VcusvDOXc2Hi/4h4pOU0A2dTYtsaVAK/B6bgZgqJr2kNXm3BUDNto+v7wjSFHEjfQQSR
         IMGw==
X-Gm-Message-State: APjAAAVWXK31Oi2SDiy1w2qSgaToFhxFGLQDpwl8BS9KOMSbSW5aGY53
        ZMpqty9y4x+1aGD36Aq7vQNnn0d6Fv3dULr+
X-Google-Smtp-Source: APXvYqwmn5LtjaTY+f4hsmtZfAoqdCdKYyyJ3TA1JpFnaOV6Nu/BG+R38vnyWSwcum180MP3Ic/YmQmm8bwHU1r3
X-Received: by 2002:a05:6830:119:: with SMTP id i25mr175410otp.288.1560339848209;
 Wed, 12 Jun 2019 04:44:08 -0700 (PDT)
Date:   Wed, 12 Jun 2019 13:43:27 +0200
In-Reply-To: <cover.1560339705.git.andreyknvl@google.com>
Message-Id: <9ba6199f01b8e941404b18bf8f7079ff384fb60b.1560339705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1560339705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v17 10/15] drm/radeon, arm64: untag user pointers in radeon_gem_userptr_ioctl
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

In radeon_gem_userptr_ioctl() an MMU notifier is set up with a (tagged)
userspace pointer. The untagged address should be used so that MMU
notifiers for the untagged address get correctly matched up with the right
BO. This funcation also calls radeon_ttm_tt_pin_userptr(), which uses
provided user pointers for vma lookups, which can only by done with
untagged pointers.

This patch untags user pointers in radeon_gem_userptr_ioctl().

Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/gpu/drm/radeon/radeon_gem.c | 2 ++
 1 file changed, 2 insertions(+)

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
 
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

