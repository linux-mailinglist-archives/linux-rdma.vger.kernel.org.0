Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45ECE13C593
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 15:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgAOOPd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 09:15:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21744 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729525AbgAOONG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jan 2020 09:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579097585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oPe3kFF2Bb1O7X4SloqQNMyAocrzl53edv79XqrSw8w=;
        b=QZIhJzIZb0lds96zfNbvsBnj1jHWYzmWmyh5zWn8LK8rKCLOnzpVQ9Db3AnvA6sAbvlTUk
        AcXJGNtHSMXGLA3ieNc5narNyoGAVSJVFTjyy8GQ3Dgvked3IFrOBcWSfV3LeMHJkbEgT2
        +uAOzmtON8j89KWVa+Lql3fcIFsmNkM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-BjqpjUJ8MBiAD5N8t1QGXQ-1; Wed, 15 Jan 2020 09:13:03 -0500
X-MC-Unique: BjqpjUJ8MBiAD5N8t1QGXQ-1
Received: by mail-lj1-f200.google.com with SMTP id k25so4173537lji.4
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jan 2020 06:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=oPe3kFF2Bb1O7X4SloqQNMyAocrzl53edv79XqrSw8w=;
        b=tAjBm6s3RPyZlpnjCVBkQdL4rfadTMwjapw0igWJo0KVhxIjOHZIKbob1ZtX7sR2BV
         q9W5l81Nk7/Kw2J8Ly7edPGEF7foI5XkV61c2DT8Z86SfBy9WyneKOBiMlHd8GbSGcbO
         BdtpCe7jWgMgPpoX+6bk/V45msTcAqR/bDjB1bNQ+XeLXputnPLEpV7nFTd0MiT43cR4
         oyJB2HqgKnoy36bl91bi+oacxH7G/hGRECb8P6Qx291nM8RQ2EaqRT0h/4bqO8jK7c1O
         JEjondy3436bGvoZw4bzAG7Dm+AOKSHy50BON5EU+HPON6F+7WnK3ga/LrFwTJeDrmAb
         WvGg==
X-Gm-Message-State: APjAAAUBHhgS9kXyPSDMjrNkU5H/cITZRy4retlnzWUVGmO9KNcYYgBB
        8+o7n+PubutaCH6VZNBtSBAi0mGZo3rT7iA61Nza7QJM+3kWuBjEkPw7wFlc2kMa/emV7FBKIov
        Pm84pUJT/xyLFHrBmwKFXBA==
X-Received: by 2002:a2e:8145:: with SMTP id t5mr2055246ljg.144.1579097582396;
        Wed, 15 Jan 2020 06:13:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqwrg/AW4KpvxAvki+r+HLehAl3nNAsz0zEr6ykcSYmLONYcH6h74z5xLROKfDYU1h5kzRfemw==
X-Received: by 2002:a2e:8145:: with SMTP id t5mr2055217ljg.144.1579097582258;
        Wed, 15 Jan 2020 06:13:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id h24sm9348451ljc.84.2020.01.15.06.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:13:01 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BC5CA1808D8; Wed, 15 Jan 2020 15:12:59 +0100 (CET)
Subject: [PATCH bpf-next v2 10/10] tools/runqslower: Remove tools/lib/bpf from
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
Date:   Wed, 15 Jan 2020 15:12:59 +0100
Message-ID: <157909757970.1192265.2735388097487906951.stgit@toke.dk>
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

Since we are now consistently using the bpf/ prefix on #include directives,
we don't need to include tools/lib/bpf in the include path. Remove it to
make sure we don't inadvertently introduce new includes without the prefix.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/bpf/runqslower/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index 3b7ae76c8ec4..89338cd16fd2 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -5,7 +5,7 @@ LLC := llc
 LLVM_STRIP := llvm-strip
 DEFAULT_BPFTOOL := $(OUTPUT)/sbin/bpftool
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
-LIBBPF_INCLUDE := -I$(abspath ../../lib) -I$(abspath ../../lib/bpf)
+LIBBPF_INCLUDE := -I$(abspath ../../lib)
 LIBBPF_SRC := $(abspath ../../lib/bpf)
 CFLAGS := -g -Wall
 

