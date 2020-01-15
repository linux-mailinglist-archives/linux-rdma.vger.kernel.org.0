Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53A2313C5B5
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 15:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgAOOQV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 09:16:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53802 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729225AbgAOOM4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jan 2020 09:12:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579097575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5kZC7agzU6ERgvosRoOEsIt+SJXOB994svdT5EEHwwQ=;
        b=ckblYdWPV9vj+c13F1OizRXZK8Zes3MQKvrGsW4dTjxesvZbpcm5nntUgFBO319iS+utVC
        zPtNZwyF155Y59iL/dPEvsqu2AEKRF8Us2DFNijTw2qBYvNiIV/PbiDyDrWmlzNzUQb+x8
        Uo088d5N/aRac3Hu8U/WVd6v4dCqKEs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-Plv23S4bMiePkLXI_R9GqA-1; Wed, 15 Jan 2020 09:12:53 -0500
X-MC-Unique: Plv23S4bMiePkLXI_R9GqA-1
Received: by mail-lf1-f71.google.com with SMTP id t3so3261903lfp.15
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jan 2020 06:12:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5kZC7agzU6ERgvosRoOEsIt+SJXOB994svdT5EEHwwQ=;
        b=O432TtInOMcpaKzp1HOWcFrgVs7fC0XvUDC8MfLj/0YiMJW7o504m/E6hFNxZwpd0A
         WsPnmwzwZHcrMP7UAJSU/0/KvtGVi4rfr8JJTBsXMd5KfQLF+sbiG9tOriTIC2g2+DXW
         uyXmCPku3MMu4qSViyE2jXNllkYx5AdKAMnoPF2xawFvlGV/L96RkfsP9pWeSHera1js
         ro4WhduxZN3JSvp5fkkLTh8Pr8LDV2p/Vzm/jPxIDcDC3Y+n3uQEdXY9vetOttuqB2MB
         ZTBYH+4vZvlCQhA+zQ3GL3Nv5waGa9dR95WZG3Nu17+cCpUPfnU/9/zIugh3CXBYdtXu
         liWQ==
X-Gm-Message-State: APjAAAUjQmCv6oB+3ZIa8jXzKpXNZFWrhixNALyOVvNBz2QSRRdYiJWE
        pHz6iLeBkvpHIY8Eeh+h5FKKxYVuyJdFJKP5Sor2i0hU1XYiK720thCqQihWinUiQYg67CptUOy
        wMqWy9xgi0tsfm00tGsyrOQ==
X-Received: by 2002:a05:651c:2c7:: with SMTP id f7mr1780377ljo.125.1579097571935;
        Wed, 15 Jan 2020 06:12:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqzyuoOjc+eVP5Ci0BzdoyleP1ltz4n/QthZHzLyJz+nAamj3hS1TdOZkbCInbJ5A/OXc+hTog==
X-Received: by 2002:a05:651c:2c7:: with SMTP id f7mr1780322ljo.125.1579097571478;
        Wed, 15 Jan 2020 06:12:51 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id m21sm8930987lfh.53.2020.01.15.06.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:12:50 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D8D8E1804D7; Wed, 15 Jan 2020 15:12:49 +0100 (CET)
Subject: [PATCH bpf-next v2 01/10] samples/bpf: Don't try to remove user's
 homedir on clean
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
Date:   Wed, 15 Jan 2020 15:12:49 +0100
Message-ID: <157909756981.1192265.5504476164632952530.stgit@toke.dk>
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

The 'clean' rule in the samples/bpf Makefile tries to remove backup
files (ending in ~). However, if no such files exist, it will instead try
to remove the user's home directory. While the attempt is mostly harmless,
it does lead to a somewhat scary warning like this:

rm: cannot remove '~': Is a directory

Fix this by using find instead of shell expansion to locate any actual
backup files that need to be removed.

Fixes: b62a796c109c ("samples/bpf: allow make to be run from samples/bpf/ directory")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 samples/bpf/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 5b89c0370f33..f86d713a17a5 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -254,7 +254,7 @@ all:
 
 clean:
 	$(MAKE) -C ../../ M=$(CURDIR) clean
-	@rm -f *~
+	@find $(CURDIR) -type f -name '*~' -delete
 
 $(LIBBPF): FORCE
 # Fix up variables inherited from Kbuild that tools/ build system won't like

