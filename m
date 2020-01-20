Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1C9C142BA5
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2020 14:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgATNH0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jan 2020 08:07:26 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56305 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729049AbgATNG4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Jan 2020 08:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579525615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KsPh+K2sGLcZZLAcEa0kQAsvwcVmMWDpkU86Oyeqz+o=;
        b=CGafp+6AcscDmOKb7TOukKRU/pAENkXcEorcv9QzCspgqK4AAMjZl6jxrW/DK3PVUDjdQb
        wtGph+d4ueshXXNVTrmpKWvYG9S4cFIlTT99kYG7SL2EncsMFyWPwvh++jnG9/pjJZLVzl
        pg7QomFc2x9Y+OOsgKJ7090M927wFc0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-HcFZ0WekOmqvJFvHlc8Png-1; Mon, 20 Jan 2020 08:06:54 -0500
X-MC-Unique: HcFZ0WekOmqvJFvHlc8Png-1
Received: by mail-lj1-f198.google.com with SMTP id u9so7535860ljg.12
        for <linux-rdma@vger.kernel.org>; Mon, 20 Jan 2020 05:06:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=KsPh+K2sGLcZZLAcEa0kQAsvwcVmMWDpkU86Oyeqz+o=;
        b=AOFDiyz2xzo1UrNOsX4w4lEic2AFo8tHdNLBviHdC3KXXvDvFCAs7uEmXjZQFl+ATr
         wz9ETPwgAksNzdIFh+zSluPULPS9OkJe6SrbaoI4FpqMaCa+AtqfaCx/ftxmO8LBZdAy
         L6z2rw1y/GWiYKi57k/tM95BiNYIo2EUT42dl+aqlxTS7xYaFN2IOIZU7aZfmvtC4wZ0
         oPTeLP0GTQCtMrGRviylvij0MkOm0RGyeREFg9aZxlTRJOO/c67x0X8UAauIx0CPHib2
         LHjYQH7TeTYs0F66Jr+oH5XdgHhxfh5OpUmQbTEVWyi6GG4tiH/TYJ7z/mnes8lRS1C0
         CXxw==
X-Gm-Message-State: APjAAAXflHGeP8PziOW+gRNVsy5NgI1KXWykqkUlRmOgrJBf4c3KnhN5
        +9M0blL6SZ5WyRV5XfcqBdyUjyIobP0BTG5q8jHUEhhFPcwQFAOzdrXt2bRfES8ybQg+/Ro9uW9
        g/6VA5htY8w/NJg7KUkjZ8w==
X-Received: by 2002:a2e:7a13:: with SMTP id v19mr13537749ljc.43.1579525612609;
        Mon, 20 Jan 2020 05:06:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqxq7D+NOw8boRnGBWgzLuvcBMZuEgfqik8rj3u7ynVqVlOwh9aSescMWf6m9o80N+P1u7Do7g==
X-Received: by 2002:a2e:7a13:: with SMTP id v19mr13537712ljc.43.1579525612235;
        Mon, 20 Jan 2020 05:06:52 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([85.204.121.218])
        by smtp.gmail.com with ESMTPSA id u9sm16734044lji.49.2020.01.20.05.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 05:06:51 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 567801804D8; Mon, 20 Jan 2020 14:06:50 +0100 (CET)
Subject: [PATCH bpf-next v5 09/11] tools/runqslower: Remove tools/lib/bpf from
 include path
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
Date:   Mon, 20 Jan 2020 14:06:50 +0100
Message-ID: <157952561027.1683545.1976265477926794138.stgit@toke.dk>
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

Since we are now consistently using the bpf/ prefix on #include directives,
we don't need to include tools/lib/bpf in the include path. Remove it to
make sure we don't inadvertently introduce new includes without the prefix.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/bpf/runqslower/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index b7b2230f807b..b90044caf270 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -6,7 +6,7 @@ LLVM_STRIP := llvm-strip
 DEFAULT_BPFTOOL := $(OUTPUT)/sbin/bpftool
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
 LIBBPF_SRC := $(abspath ../../lib/bpf)
-INCLUDES := -I$(OUTPUT) -I$(abspath ../../lib) -I$(abspath ../../lib/bpf)
+INCLUDES := -I$(OUTPUT) -I$(abspath ../../lib)
 CFLAGS := -g -Wall
 
 # Try to detect best kernel BTF source

