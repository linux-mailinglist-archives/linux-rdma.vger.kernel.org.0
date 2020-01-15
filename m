Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45AF213C5B7
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 15:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgAOOQV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 09:16:21 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54898 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729253AbgAOOM5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Jan 2020 09:12:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579097576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B9j+W7gDIaDJz39H0dsQUAJSNrjtTec2FhMoAkHknrs=;
        b=L01R6wDjrJUa2jsqeMymFoujfwEFMGcv9qQD0H3KFU3ZBpCxuBrSTef7zY9XiRw2hL7OX7
        fbZL+nUOEGQj1nWQp81zBw4FFvOa+pniDb6OFZ6hKkNuxe13LXYIytZCR2m870tNhoEWzu
        whb/qzEcw2+7eXuF7GvT9iyx3DJkUTo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-VrrldrkeNjK6bFtSbLtnhQ-1; Wed, 15 Jan 2020 09:12:55 -0500
X-MC-Unique: VrrldrkeNjK6bFtSbLtnhQ-1
Received: by mail-lf1-f71.google.com with SMTP id d6so3277785lfl.3
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jan 2020 06:12:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=B9j+W7gDIaDJz39H0dsQUAJSNrjtTec2FhMoAkHknrs=;
        b=BJ74cYvORXVOcvgmyecmwT2oZWLs36cNZRhmv7rUR4EYJqRonqZpnpNSwrTaaxr298
         yyHuH+EUREJgSB5tLfYGvZUDyVJtnZO2yrB85zQMBBdOpH/NQlkzJeIz2Q7B3+83YBrZ
         k8PEmJqtnGtV0mVTjampdEgwYxvbQ002hpGmyzOTRaK2w0qWV2a72zojkdt+Hyypsx9i
         3UY51NkS3OjvDTIICyNKiS5U+BB418TsjcZS6ppBN3+8J/Dict7slEMVqnKtfW7th31b
         kei2jgGSqaLVdAF63M9GlJL9TuZJaq8YDw5E7VeH9PloExebif+oPu//MXrtXBIRm5WI
         uRSg==
X-Gm-Message-State: APjAAAXq8FXwFs9EB8uk51mFasbBEQj471n2PbKNV4jFsNlXoIiQE6K7
        FmvfJnatt7tozajogHm0LZwo0bbSIXVoLSjsjFeBe5NbgDsHFETihoJAuDODDMCAKgshK/7N3Z3
        xGYPy2o3bHhVKQxQc7x3PUA==
X-Received: by 2002:a2e:a37c:: with SMTP id i28mr1772084ljn.118.1579097574011;
        Wed, 15 Jan 2020 06:12:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqyUW0Ep6uEXtLij//fHtTp+5adTa9pXL0f4oBHP8qleNZhf8ZN29IWsfrnAs2scQN/yNWVb2Q==
X-Received: by 2002:a2e:a37c:: with SMTP id i28mr1772066ljn.118.1579097573864;
        Wed, 15 Jan 2020 06:12:53 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id p136sm9082048lfa.8.2020.01.15.06.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:12:52 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EE0AE1804D8; Wed, 15 Jan 2020 15:12:50 +0100 (CET)
Subject: [PATCH bpf-next v2 02/10] tools/bpf/runqslower: Fix override option
 for VMLINUX_BTF
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com
Date:   Wed, 15 Jan 2020 15:12:50 +0100
Message-ID: <157909757089.1192265.9038866294345740126.stgit@toke.dk>
In-Reply-To: <157909756858.1192265.6657542187065456112.stgit@toke.dk>
References: <157909756858.1192265.6657542187065456112.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

The runqslower tool refuses to build without a file to read vmlinux BTF
from. The build fails with an error message to override the location by
setting the VMLINUX_BTF variable if autodetection fails. However, the
Makefile doesn't actually work with that override - the error message is
still emitted.

Fix this by only doing auto-detection if no override is set. And while
we're at it, also look for a vmlinux file in the current kernel build dir
if none if found on the running kernel.

Fixes: 9c01546d26d2 ("tools/bpf: Add runqslower tool to tools/bpf")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/bpf/runqslower/Makefile |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index cff2fbcd29a8..fb93ce2bf2fe 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -10,12 +10,16 @@ CFLAGS := -g -Wall
 
 # Try to detect best kernel BTF source
 KERNEL_REL := $(shell uname -r)
-ifneq ("$(wildcard /sys/kernel/btf/vmlinux)","")
-VMLINUX_BTF := /sys/kernel/btf/vmlinux
-else ifneq ("$(wildcard /boot/vmlinux-$(KERNEL_REL))","")
-VMLINUX_BTF := /boot/vmlinux-$(KERNEL_REL)
-else
-$(error "Can't detect kernel BTF, use VMLINUX_BTF to specify it explicitly")
+ifeq ("$(VMLINUX_BTF)","")
+  ifneq ("$(wildcard /sys/kernel/btf/vmlinux)","")
+  VMLINUX_BTF := /sys/kernel/btf/vmlinux
+  else ifneq ("$(wildcard /boot/vmlinux-$(KERNEL_REL))","")
+  VMLINUX_BTF := /boot/vmlinux-$(KERNEL_REL)
+  else ifneq ("$(wildcard $(abspath ../../../vmlinux))","")
+  VMLINUX_BTF := $(abspath ../../../vmlinux)
+  else
+  $(error "Can't detect kernel BTF, use VMLINUX_BTF to specify it explicitly")
+  endif
 endif
 
 abs_out := $(abspath $(OUTPUT))

