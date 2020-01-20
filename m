Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC92C1428C4
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2020 12:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgATLEV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jan 2020 06:04:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53134 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726573AbgATLER (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Jan 2020 06:04:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579518255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0D2NV9EyT8+bRJWlmQx32SvVPgUYttr3IYvJpCG0gTo=;
        b=UlzPZXXkfStwOUTOhlmhLUgn8H1x/D1EM04ioleX1smxggN/QOfkA4IFvQnk1Ysf4my3F/
        sDhm8lZNLzJMUFGBiuRL6tAaQelttCOy7LH1BePcqNiuQ2Gm1hi5d2FK76AB0y/CPJGVyO
        v9foDTcMzfQjZeR4udPm7juF1/+8JkU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-plCZYW-dNoqFtgVsjG5KyQ-1; Mon, 20 Jan 2020 06:04:14 -0500
X-MC-Unique: plCZYW-dNoqFtgVsjG5KyQ-1
Received: by mail-lf1-f70.google.com with SMTP id z3so6170117lfq.22
        for <linux-rdma@vger.kernel.org>; Mon, 20 Jan 2020 03:04:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0D2NV9EyT8+bRJWlmQx32SvVPgUYttr3IYvJpCG0gTo=;
        b=CSuD3OPnpIIVT8nFxzf14vVPhNRvtfGQZlpA81Zw8OtEa3XgZ1IYt1m4VXabzYSB36
         KXka+mHWoNN4hQJhc67iZUpjU7lWkeJNPj1pSaIaJy5cgsmnXlBt7GtBMZ4fdZRR5Ifp
         1rvI2N+K+8V1IyOHIIuxQcWc9jgkwIjgZZRT5n5urd3yXnz2QkbtHBjtsTBpfC+9B1sE
         sfno2z9ny5FlaopT5XzPOEJbVbvC+dVgm0z7Ox73uNAdNY6sTDm/WEeePCHWUhY1T5VU
         uY1qvRtzEQuoB1KjgLn5HQUkWolEW6W87b5autrGx52d0hnoJrKc/eL46eQRORPEYvh8
         MSow==
X-Gm-Message-State: APjAAAUpBNCEWcyyI3qbSRjB42X521c6PF2Uz39rpZHJXJZkLN76lkTf
        LBvvr5e/R4BEs8BFNqDOMGQrqepNOFsj9+wBkNgF4pFSJO3Leabd0onS83q9YYBbwnoTkxfkXd6
        jRh2gdlEiZjp09PTidI6DWg==
X-Received: by 2002:a2e:2c16:: with SMTP id s22mr13113874ljs.248.1579518252323;
        Mon, 20 Jan 2020 03:04:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqzXI2yd2Oi5VKXpLVh9lATHnVWtfkEINyqNvSzJ0CGsMQ8EPIgo05xlthJ7jXSiWSfn+eDmEA==
X-Received: by 2002:a2e:2c16:: with SMTP id s22mr13113829ljs.248.1579518251933;
        Mon, 20 Jan 2020 03:04:11 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([85.204.121.218])
        by smtp.gmail.com with ESMTPSA id z5sm16616586lji.40.2020.01.20.03.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 03:04:11 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 50B871804D6; Mon, 20 Jan 2020 12:04:09 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
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
        Shuah Khan <shuah@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-rdma@vger.kernel.org,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH bpf-next v4 02/10] tools/bpf/runqslower: Fix override option for VMLINUX_BTF
In-Reply-To: <CAEf4BzY3RM3LS3bvU4dHY+8U27RaezeaC9rfuW1YLAcFQEQKEA@mail.gmail.com>
References: <157926819690.1555735.10756593211671752826.stgit@toke.dk> <157926819920.1555735.13051810516683828343.stgit@toke.dk> <CAEf4BzY3RM3LS3bvU4dHY+8U27RaezeaC9rfuW1YLAcFQEQKEA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 20 Jan 2020 12:04:09 +0100
Message-ID: <87blqypexi.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Jan 17, 2020 at 5:37 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>
>> The runqslower tool refuses to build without a file to read vmlinux BTF
>> from. The build fails with an error message to override the location by
>> setting the VMLINUX_BTF variable if autodetection fails. However, the
>> Makefile doesn't actually work with that override - the error message is
>> still emitted.
>>
>> Fix this by including the value of VMLINUX_BTF in the expansion, and only
>> emitting the error message if the *result* is empty. Also permit running
>> 'make clean' even though no VMLINUX_BTF is set.
>>
>> Fixes: 9c01546d26d2 ("tools/bpf: Add runqslower tool to tools/bpf")
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>
> approach looks good, thanks, few nits below
>
>>  tools/bpf/runqslower/Makefile |   18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefi=
le
>> index cff2fbcd29a8..b62fc9646c39 100644
>> --- a/tools/bpf/runqslower/Makefile
>> +++ b/tools/bpf/runqslower/Makefile
>> @@ -10,13 +10,9 @@ CFLAGS :=3D -g -Wall
>>
>>  # Try to detect best kernel BTF source
>>  KERNEL_REL :=3D $(shell uname -r)
>> -ifneq ("$(wildcard /sys/kernel/btf/vmlinux)","")
>> -VMLINUX_BTF :=3D /sys/kernel/btf/vmlinux
>> -else ifneq ("$(wildcard /boot/vmlinux-$(KERNEL_REL))","")
>> -VMLINUX_BTF :=3D /boot/vmlinux-$(KERNEL_REL)
>> -else
>> -$(error "Can't detect kernel BTF, use VMLINUX_BTF to specify it explici=
tly")
>> -endif
>> +VMLINUX_BTF_PATHS :=3D /sys/kernel/btf/vmlinux /boot/vmlinux-$(KERNEL_R=
EL)
>> +VMLINUX_BTF_PATH :=3D $(abspath $(or $(VMLINUX_BTF),$(firstword \
>> +       $(wildcard $(VMLINUX_BTF_PATHS)))))
>
> you can drop abspath, relative path for VMLINUX_BTF would work just fine

OK.

>>
>>  abs_out :=3D $(abspath $(OUTPUT))
>>  ifeq ($(V),1)
>> @@ -67,9 +63,13 @@ $(OUTPUT):
>>         $(call msg,MKDIR,$@)
>>         $(Q)mkdir -p $(OUTPUT)
>>
>> -$(OUTPUT)/vmlinux.h: $(VMLINUX_BTF) | $(OUTPUT) $(BPFTOOL)
>> +$(OUTPUT)/vmlinux.h: $(VMLINUX_BTF_PATH) | $(OUTPUT) $(BPFTOOL)
>>         $(call msg,GEN,$@)
>> -       $(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
>> +       @if [ ! -e "$(VMLINUX_BTF_PATH)" ] ; then \
>
> $(Q), not @

This was actually deliberate, since I was replacing an $(error) (which
doesn't show up in V=3D1 output). But OK, I guess we can output the whole
if statement as well on verbose builds...

>> +               echo "Couldn't find kernel BTF; set VMLINUX_BTF to speci=
fy its location."; \
>> +               exit 1;\
>
> nit: please align \'s (same above for VMLONUX_BTF_PATH) at the right
> edge as it's done everywhere in this Makefile

Right, I'll try to fix those up (for the whole series). My emacs is
being a bit weird with displaying tabstops, so some of these look
aligned when I'm editing. I'll see if I can figure out how to fix this
so it becomes obvious while I'm making changes...

-Toke

