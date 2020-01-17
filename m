Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF81B1406C6
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jan 2020 10:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgAQJrD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Jan 2020 04:47:03 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21952 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726778AbgAQJrD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Jan 2020 04:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579254422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MRdZZz9P8UIoKzsy8bUaagOkve384w9nZaJDimC4aAA=;
        b=RIeXKXaoWoahHcca3rf5aBFLFtIykftH+O4yYyp4+xclJ4xiBJ3UgM6UDmWRgLX//CtOiE
        mL6xb9CrTHkTlHJX+nB06PW+j6zuLL9MTmlpxx+kFkamUlDsdTqgiyI9WjPpOKnKbFzP4M
        Wu8f3xXPw6CtVZ4aCMyGdXXGFISILmE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-kVpwixLeNdiTGjXNfUVQVg-1; Fri, 17 Jan 2020 04:47:01 -0500
X-MC-Unique: kVpwixLeNdiTGjXNfUVQVg-1
Received: by mail-lf1-f70.google.com with SMTP id d6so4268525lfl.3
        for <linux-rdma@vger.kernel.org>; Fri, 17 Jan 2020 01:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=MRdZZz9P8UIoKzsy8bUaagOkve384w9nZaJDimC4aAA=;
        b=pN6TmWQ09tevWo+PI9NcX8fJKqJ4PwK/oEazKNVZtdOfnJyKUD4fXnvfZE9voDARQJ
         YAh/8nHuqiaLYZDtSgCWsN+MuZccto392S0RahSDswdMsuf8ph2e9P5ygt+matf1FaFZ
         ku4wHqt9TPweBRSZR86fqdCpWRtcmbYp1C7ek7/p/zNEJDKPCcb9SBi+APhT2vV1bX/5
         VU8VQCtC54l4njDystwcDRrX5+qP/yH7+y3D9gdQgY5gdNiba9aUF/3C0pAfEaF/oKZS
         9+G3x7uYUmejhKFMHd85LfP2dSqRqA2XOGxpcyxHzPZRBQecQcJ5zBaZM5XnpRd7cUYq
         aoFg==
X-Gm-Message-State: APjAAAXs52KF1Gy/lz71cCJSZhdNQrDc34PsiH6RJsxjjLvBdS4HhvGw
        qjMVcBp4DNGKO5u8oaD/vq6pOGiQVIwFijfnPd8mr06HH/pVveVta89578oQ7jPsDpWRrbYncnO
        kUQUAKplg+FcazFpJk87u7A==
X-Received: by 2002:a19:7015:: with SMTP id h21mr4868733lfc.68.1579254419648;
        Fri, 17 Jan 2020 01:46:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjvTMUn7InwON8DwCpRgzC4ouRW99OTFzcLs217w1iCLWqujy5RCewHLMusTudpnVGBByZkg==
X-Received: by 2002:a19:7015:: with SMTP id h21mr4868705lfc.68.1579254419486;
        Fri, 17 Jan 2020 01:46:59 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id r15sm12041957ljh.11.2020.01.17.01.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 01:46:58 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3553E1804D6; Fri, 17 Jan 2020 10:46:58 +0100 (CET)
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
Subject: Re: [PATCH bpf-next v3 04/11] tools/runqslower: Use consistent include paths for libbpf
In-Reply-To: <CAEf4BzbJZ7JUyr8p3YKX-Rrth_B7OMbih50xxyt_YNBd--107w@mail.gmail.com>
References: <157918093154.1357254.7616059374996162336.stgit@toke.dk> <157918093613.1357254.10230277763921623892.stgit@toke.dk> <CAEf4BzbJZ7JUyr8p3YKX-Rrth_B7OMbih50xxyt_YNBd--107w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 17 Jan 2020 10:46:58 +0100
Message-ID: <87tv4uqust.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Jan 16, 2020 at 5:23 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>
>> Fix the runqslower tool to include libbpf header files with the bpf/
>> prefix, to be consistent with external users of the library. Also ensure
>> that all includes of exported libbpf header files (those that are export=
ed
>> on 'make install' of the library) use bracketed includes instead of quot=
ed.
>>
>> To not break the build, keep the old include path until everything has b=
een
>> changed to the new one; a subsequent patch will remove that.
>>
>> Fixes: 6910d7d3867a ("selftests/bpf: Ensure bpf_helper_defs.h are taken =
from selftests dir")
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  tools/bpf/runqslower/Makefile         |    5 +++--
>>  tools/bpf/runqslower/runqslower.bpf.c |    2 +-
>>  tools/bpf/runqslower/runqslower.c     |    4 ++--
>>  3 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefi=
le
>> index 89fb7cd30f1a..c0512b830805 100644
>> --- a/tools/bpf/runqslower/Makefile
>> +++ b/tools/bpf/runqslower/Makefile
>> @@ -5,6 +5,7 @@ LLC :=3D llc
>>  LLVM_STRIP :=3D llvm-strip
>>  DEFAULT_BPFTOOL :=3D $(OUTPUT)/sbin/bpftool
>>  BPFTOOL ?=3D $(DEFAULT_BPFTOOL)
>> +LIBBPF_INCLUDE :=3D -I$(abspath ../../lib) -I$(abspath ../../lib/bpf)
>
> I'd probably put all the -I's into single INCLUDES var and include
> that one instead of mixing -I$(OUTPUT) and $(LIBBPF_INCLUDE), but this
> works too.

Hmm, yeah, not a bad idea, actually. Since it seems I'm respinning
anyway, I'll fix that up as well.

-Toke

