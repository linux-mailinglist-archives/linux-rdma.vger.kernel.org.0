Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4293142BB6
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2020 14:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgATNHs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jan 2020 08:07:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35120 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728600AbgATNGs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jan 2020 08:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579525607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kMzta49FGi59zAWBh6JcpPryK5CAVyLgor/XGDFTJFQ=;
        b=LgVUSukG3ik0ak2C5mNhG38qBjx0MO9+6zi17Yu3mLqiV9pl8sjWXbLPSAdDZjXKLpwLN2
        g8rGo8iCyrU+YS7o/jpxkfTCO2sZLdXNHz+USbnTMom2HDCQY8l9yBLvtKQQ3w1LmAH1C1
        9VBOUYigCWUYRIcYseq5P814EgXDog0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-DZwfZR8MPriuVpQfiw-yuw-1; Mon, 20 Jan 2020 08:06:46 -0500
X-MC-Unique: DZwfZR8MPriuVpQfiw-yuw-1
Received: by mail-lj1-f198.google.com with SMTP id g5so7538087ljj.22
        for <linux-rdma@vger.kernel.org>; Mon, 20 Jan 2020 05:06:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=kMzta49FGi59zAWBh6JcpPryK5CAVyLgor/XGDFTJFQ=;
        b=fqvuUmIdT9nVah8FxkGCPgJsNsfM694hOXUZGKN2hJVh49iU9cBP7dl6ExRaDdC6/c
         mP/5xkwjQQIqB7Sv7unQzYoISw8j+bmwkohAopp6oa8DcPR8G563FNdQ+nWifhOLLIdI
         iKU5Ej+VCCB529vGBAlPPzHBu68bSKfMm/sqL7hdmMi2oSIhRLajAznT/q+kKjBJ6Gi5
         J9SBIL0uRQFKiUCPIn9rnXXpff4Xp9c13dn/v4MFCmn2Qu58vhz487zAu+TRk4f5hNy+
         RWgmOiM9G5vmb78a4CYFJ9oEQ0zS3/7Vf8RtSPbF84L2AifZFbnRMiF27kuk+xhkMBfZ
         2R+Q==
X-Gm-Message-State: APjAAAXAjdHAfrzVJzhrYIgDO7ttkBhDuu7nti+lycHvk7CVuf18W/p4
        n+unZccuPyjAbeu+TuiMKT2U5TeEfS3XUWw6dymSf1IF6IZU1xXnbgMQpnRn4krmLnKIhN8H1S0
        B0n67+jbT3D2OOnv9fADuig==
X-Received: by 2002:a05:651c:1a8:: with SMTP id c8mr13483664ljn.207.1579525604694;
        Mon, 20 Jan 2020 05:06:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqzo6PPrjA+yEC25WheWBME+LbIJh05BG+CMwVRxmNLaLUKATUm84PPo4NGjn917QF32fT66dg==
X-Received: by 2002:a05:651c:1a8:: with SMTP id c8mr13483642ljn.207.1579525604292;
        Mon, 20 Jan 2020 05:06:44 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([85.204.121.218])
        by smtp.gmail.com with ESMTPSA id e8sm19898063ljb.45.2020.01.20.05.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 05:06:43 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6CD9C1804D6; Mon, 20 Jan 2020 14:06:42 +0100 (CET)
Subject: [PATCH bpf-next v5 02/11] tools/bpf/runqslower: Fix override option
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
        Jakub Kicinski <kuba@kernel.org>,
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
Date:   Mon, 20 Jan 2020 14:06:42 +0100
Message-ID: <157952560237.1683545.17771785178857224877.stgit@toke.dk>
In-Reply-To: <157952560001.1683545.16757917515390545122.stgit@toke.dk>
References: <157952560001.1683545.16757917515390545122.stgit@toke.dk>
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

Fix this by including the value of VMLINUX_BTF in the expansion, and only
emitting the error message if the *result* is empty. Also permit running
'make clean' even though no VMLINUX_BTF is set.

Fixes: 9c01546d26d2 ("tools/bpf: Add runqslower tool to tools/bpf")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/bpf/runqslower/Makefile |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index cff2fbcd29a8..3242ab874ac0 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -10,13 +10,9 @@ CFLAGS := -g -Wall
 
 # Try to detect best kernel BTF source
 KERNEL_REL := $(shell uname -r)
-ifneq ("$(wildcard /sys/kernel/btf/vmlinux)","")
-VMLINUX_BTF := /sys/kernel/btf/vmlinux
-else ifneq ("$(wildcard /boot/vmlinux-$(KERNEL_REL))","")
-VMLINUX_BTF := /boot/vmlinux-$(KERNEL_REL)
-else
-$(error "Can't detect kernel BTF, use VMLINUX_BTF to specify it explicitly")
-endif
+VMLINUX_BTF_PATHS := /sys/kernel/btf/vmlinux /boot/vmlinux-$(KERNEL_REL)
+VMLINUX_BTF_PATH := $(or $(VMLINUX_BTF),$(firstword			       \
+					  $(wildcard $(VMLINUX_BTF_PATHS))))
 
 abs_out := $(abspath $(OUTPUT))
 ifeq ($(V),1)
@@ -67,9 +63,14 @@ $(OUTPUT):
 	$(call msg,MKDIR,$@)
 	$(Q)mkdir -p $(OUTPUT)
 
-$(OUTPUT)/vmlinux.h: $(VMLINUX_BTF) | $(OUTPUT) $(BPFTOOL)
+$(OUTPUT)/vmlinux.h: $(VMLINUX_BTF_PATH) | $(OUTPUT) $(BPFTOOL)
 	$(call msg,GEN,$@)
-	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
+	$(Q)if [ ! -e "$(VMLINUX_BTF_PATH)" ] ; then \
+		echo "Couldn't find kernel BTF; set VMLINUX_BTF to"	       \
+			"specify its location." >&2;			       \
+		exit 1;\
+	fi
+	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF_PATH) format c > $@
 
 $(OUTPUT)/libbpf.a: | $(OUTPUT)
 	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC)			       \

