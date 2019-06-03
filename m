Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5E3335B5
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2019 18:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfFCQzv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jun 2019 12:55:51 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:47332 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfFCQzu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jun 2019 12:55:50 -0400
Received: by mail-ot1-f74.google.com with SMTP id n19so1475770ota.14
        for <linux-rdma@vger.kernel.org>; Mon, 03 Jun 2019 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZBmZ0AJkpI6Le2BTudY9LfSDHiJInTNRilsGVrjkAC4=;
        b=URpy1zkCsiHDZT4QO7sl51daLEh3EGQ+QBRWhBXCE891aX0bBPmoAKSOA31jx1eR/L
         lVC6wRB0VJkhYxePvRUt+LMH36W5FFHQFgoa3GPev4OVYVi3rHZ7c3DIf31iffj+WRWq
         O/UwDncv5Fut/rLbuSahvZjC3AOwYT8i5PrP8W6A3ApbgszBZnpxe6Ijm9sVziVKebM1
         iMXDrWTNGRgrpGSzVkD4uXSftJythbi88SDUBif5NioLplX3HzpUrRyFyzSWH4dNAKRr
         WMIQ2F6id96lYcVo97o9s2zuDCTDHymNEv75yNnQamJ6cKIMShowZNQgGMTsd3D7DLBr
         FGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZBmZ0AJkpI6Le2BTudY9LfSDHiJInTNRilsGVrjkAC4=;
        b=P78+hc5jnT2SAGGUwSM9J6rmJGDshCOo7stF2I43KO1pbzHMg4HTV3eSqGOf0ERXDM
         m5dYlN9CiNmSZOPJAaCOQaOdSvE1HbQkQipvoMtPQzD0pvxUn+uGvtL4i8xavy/DMKUM
         oKXxfFZ3lKPvZw/cLE204QXzwDI/V1imWV/+d7j/7RPhInzKW2fi1BD6xLF0qaZ4gsOl
         E8IC4cGGevxBekpfzAZFCrn0ib0aydKjOSeNdh5pYZdeM2wNWNbT3euH8oPKF62Xo2l4
         yDHuIzUW5a3hJZ1PUZ0iEbQQfwlqWXjNHIqs9sqEoMs5udTV0tIjrqJ3X2/EdNbc1buQ
         1DEw==
X-Gm-Message-State: APjAAAWnVDXbV9HBshMf4IDdoc54AKgPpn71e4/UX+AoEtvcnUDjtXW5
        flKnFMxWv55MtUHpVITS/niR+wNr7f+JOUvI
X-Google-Smtp-Source: APXvYqy+jD2zPLosNFGdbJ9ezUNMRGpcmbF5VcOnmGNGlPs/hbYWUHg1PJfAxR5NSiop2ABNMtv5Bkf3tC6COzAd
X-Received: by 2002:aca:4c3:: with SMTP id 186mr1626180oie.12.1559580949610;
 Mon, 03 Jun 2019 09:55:49 -0700 (PDT)
Date:   Mon,  3 Jun 2019 18:55:10 +0200
In-Reply-To: <cover.1559580831.git.andreyknvl@google.com>
Message-Id: <51f44a12c4e81c9edea8dcd268f820f5d1fad87c.1559580831.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v16 08/16] fs, arm64: untag user pointers in copy_mount_options
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

In copy_mount_options a user address is being subtracted from TASK_SIZE.
If the address is lower than TASK_SIZE, the size is calculated to not
allow the exact_copy_from_user() call to cross TASK_SIZE boundary.
However if the address is tagged, then the size will be calculated
incorrectly.

Untag the address before subtracting.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index b26778bdc236..2e85712a19ed 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2993,7 +2993,7 @@ void *copy_mount_options(const void __user * data)
 	 * the remainder of the page.
 	 */
 	/* copy_from_user cannot cross TASK_SIZE ! */
-	size = TASK_SIZE - (unsigned long)data;
+	size = TASK_SIZE - (unsigned long)untagged_addr(data);
 	if (size > PAGE_SIZE)
 		size = PAGE_SIZE;
 
-- 
2.22.0.rc1.311.g5d7573a151-goog

