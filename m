Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0819B140AE7
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jan 2020 14:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgAQNgr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Jan 2020 08:36:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28603 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728665AbgAQNgq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Jan 2020 08:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579268205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3uHiB/rHLsVw+zJgXGJkoutNE3orjbRqSapatBIGTrI=;
        b=DOzKNkb99Y1gLMlH1yPgTTMBOcvE6MhoR4zijvO8gk4nbgVCwvoUkBFSO4B6gnoOJ0nCTr
        ojFKO1RQii8OVWycHUyNd9LDSm2XSi66+EIRKCXC4kDzd6mNdPkEx79zE7m9f8GLty0Jsp
        9Ifv/oE+egLR90E9jful0W1+1OR/7TI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-giF3oYq0OQ2WBRarvDQ_Zg-1; Fri, 17 Jan 2020 08:36:44 -0500
X-MC-Unique: giF3oYq0OQ2WBRarvDQ_Zg-1
Received: by mail-lf1-f72.google.com with SMTP id x23so4370599lfc.5
        for <linux-rdma@vger.kernel.org>; Fri, 17 Jan 2020 05:36:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3uHiB/rHLsVw+zJgXGJkoutNE3orjbRqSapatBIGTrI=;
        b=hOv6KU0eGDQu6oWomqynyd0E8y1q/WzY0lCFxhtha/9+fgP15BHL+M1Iycfw+i3m21
         Mpg1ulrIEgxmPiUe+QikXvDKdmougQ2gbyjmCRRXJAWQoA5KD8lR46NFgYS5Z0kzPtjn
         XskdQaPOsTMlwh0tFfFLcJuXaA9hoNlgGWsgYyJl1QAxkAAAP0c9XL6p7P9nifFsBDA+
         zMZ6K7TZLWUX3dHEM6qs42QixvHxiGvMy/W5WFZoqsPPHmd5eCmDzFRV9PnGMKu8+7po
         xoAzOLMZ9BRUma/t+aXDULNcuIyA03GuQcqKYyRArbFFl7tgaCE64i7a2+YA+mkORjr6
         MF9g==
X-Gm-Message-State: APjAAAUbZsHWL+tYYX7MRve+VYvdtB048+Ek1mu5Awo1ED1EVD1NHcqt
        tj+AUkKORup6alTOz1g9pa+MEojepZ/QPuE2UhF1lj4bUg0MVvSIk1ANABuMsBbfso/c9NGcco3
        0TBEZP8ywk2smKR6EpRTaTA==
X-Received: by 2002:a2e:9cca:: with SMTP id g10mr5571388ljj.258.1579268203337;
        Fri, 17 Jan 2020 05:36:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqyFRQDM7RuuJv2SpQFKkm/d5REFszMdDint07qob4Hs3TAj8lfrBlXW/KoVQwFk65vCLxDe7A==
X-Received: by 2002:a2e:9cca:: with SMTP id g10mr5571378ljj.258.1579268203185;
        Fri, 17 Jan 2020 05:36:43 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id s9sm14366440ljh.90.2020.01.17.05.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:36:41 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4D2A91804D7; Fri, 17 Jan 2020 14:36:40 +0100 (CET)
Subject: [PATCH bpf-next v4 03/10] selftests: Pass VMLINUX_BTF to runqslower
 Makefile
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
Date:   Fri, 17 Jan 2020 14:36:40 +0100
Message-ID: <157926820025.1555735.5663814379544078154.stgit@toke.dk>
In-Reply-To: <157926819690.1555735.10756593211671752826.stgit@toke.dk>
References: <157926819690.1555735.10756593211671752826.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

Add a VMLINUX_BTF variable with the locally-built path when calling the
runqslower Makefile from selftests. This makes sure a simple 'make'
invocation in the selftests dir works even when there is no BTF information
for the running kernel. Do a wildcard expansion and include the same paths
for BTF for the running kernel as in the runqslower Makefile, to make it
possible to build selftests without having a vmlinux in the local tree.

Also fix the make invocation to use $(OUTPUT)/tools as the destination
directory instead of $(CURDIR)/tools.

Fixes: 3a0d3092a4ed ("selftests/bpf: Build runqslower from selftests")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/Makefile |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 246d09ffb296..dcc8dbb1510b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -124,10 +124,14 @@ $(OUTPUT)/test_stub.o: test_stub.c
 	$(call msg,CC,,$@)
 	$(CC) -c $(CFLAGS) -o $@ $<
 
+VMLINUX_BTF_PATHS := $(abspath ../../../../vmlinux)			\
+			/sys/kernel/btf/vmlinux			\
+			/boot/vmlinux-$(shell uname -r)
+VMLINUX_BTF:= $(firstword $(wildcard $(VMLINUX_BTF_PATHS)))
 .PHONY: $(OUTPUT)/runqslower
 $(OUTPUT)/runqslower: force
-	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower	      \
-		    OUTPUT=$(CURDIR)/tools/
+	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower	\
+		    OUTPUT=$(OUTPUT)/tools/ VMLINUX_BTF=$(VMLINUX_BTF)
 
 BPFOBJ := $(OUTPUT)/libbpf.a
 

