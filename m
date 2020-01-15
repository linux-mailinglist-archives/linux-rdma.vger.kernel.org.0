Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDFE13C585
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 15:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgAOOPM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 09:15:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26269 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729616AbgAOONI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jan 2020 09:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579097587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IbqVpRR/8QBodrEx/nm52YtktIoV5thrDtYdJd8vMNo=;
        b=TB5DbnvFW4hWpT9H1NxzPaCZA2wsjr4pGnGS0IIxH9Z/By26gw4La97vZXI6zEBxrZ2PMH
        BF4gaUY9EXZqiNJ+yFbjoavQykv4IGvexPfT9G1L3j5JRMAwHRCxHA3xeSkGZeyYoWpeYU
        +ZRhHooMNzJEQBJoXGz5xJoGDIPqOWk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-JSRE9tpQNSelZy4R1mbx0g-1; Wed, 15 Jan 2020 09:13:06 -0500
X-MC-Unique: JSRE9tpQNSelZy4R1mbx0g-1
Received: by mail-lj1-f200.google.com with SMTP id k25so4173596lji.4
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jan 2020 06:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=IbqVpRR/8QBodrEx/nm52YtktIoV5thrDtYdJd8vMNo=;
        b=sWNmlU7dEelGMAzA2CQx/6ELs2FkYwscVL63AXUCTKEb7IcZZEfRMUzqgFhkbg6Ga3
         XOAyey0pP1irNUxdwxP2MnT45BqPu8WaYntO0V+PmyyZ9fXLXGVTiOBQKpvGrqi4fF15
         BQ0NF338G1YkyO62OqjwoaqSwLw9+/7Tbf4WKXtqaUkbF+A4x71TFqZpsoNJN+kd8xr1
         W3M0oPtFK3kQ0RvVJ5j0hriSqN7FuJUdj74THDem19eJgsc7Zn0zBEKRutKxtmXysAIN
         fwHHYbwL26xt/jkFpZFR0xIIeHwuo/CeUBeO13NBzjXSwGIxhlFvN3st46JG1ljl+O4r
         fM6Q==
X-Gm-Message-State: APjAAAXvMdZPbPacJwULP6ypPXKkN9m5x+QXejZdGyzeS8WXKWobsu21
        sj2pAsXu00pezKLVJldpmBmSr1S14BxNyUzFtyFhx91Fq3Pz9O8jo8ho403r5zfk6Ry7vC0VyRw
        MJrMipEKUujzsG+5Zg2kzRA==
X-Received: by 2002:a2e:97c1:: with SMTP id m1mr1938351ljj.270.1579097584140;
        Wed, 15 Jan 2020 06:13:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqxeIyk3JE8ypwVQPor3SVLXXAEfT2KWc9boLbeUl5AIb8BPG0kbZGTyLI5qwFLXqnWRk9pOSw==
X-Received: by 2002:a2e:97c1:: with SMTP id m1mr1938317ljj.270.1579097583924;
        Wed, 15 Jan 2020 06:13:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id t81sm8978733lff.25.2020.01.15.06.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:13:03 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 941A11804D6; Wed, 15 Jan 2020 15:12:57 +0100 (CET)
Subject: [PATCH bpf-next v2 08/10] libbpf: Fix include of bpf_helpers.h when
 libbpf is installed on system
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
Date:   Wed, 15 Jan 2020 15:12:57 +0100
Message-ID: <157909757751.1192265.13380767037659864244.stgit@toke.dk>
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

The change to use angled includes for bpf_helper_defs.h breaks compilation
against libbpf when it is installed in the include path, since the file is
installed in the bpf/ subdirectory of $INCLUDE_PATH. Fix this by adding the
bpf/ prefix to the #include directive.

Fixes: 6910d7d3867a ("selftests/bpf: Ensure bpf_helper_defs.h are taken from selftests dir")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/bpf_helpers.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 050bb7bf5be6..fa43d649e7a2 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -2,7 +2,7 @@
 #ifndef __BPF_HELPERS__
 #define __BPF_HELPERS__
 
-#include <bpf_helper_defs.h>
+#include <bpf/bpf_helper_defs.h>
 
 #define __uint(name, val) int (*name)[val]
 #define __type(name, val) typeof(val) *name

