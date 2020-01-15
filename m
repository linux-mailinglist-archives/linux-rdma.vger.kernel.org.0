Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D3813CFD0
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 23:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgAOWJv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 17:09:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55030 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728925AbgAOWJu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jan 2020 17:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579126189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gHyBZ8+XeG4963OEjkw03c1ZgmrL31FuTlHZYv52rM=;
        b=SPB3tdMtc5YmF4MxA6T6G4iFxup9RzG9mcNhluhqP4A4jfvLt8aM4muaIsMdthrpr5Jn3E
        hlIuLwtHku8qwEhAhiEOL7PnhM0/EkwkivpfUr1sSjaQSMIC9SYx32nmnDRGXuSShTTlrf
        LiZFSOMCWMjtb/53eYKhBhf9MZRp/98=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-4JVC9NgAPlGsD0fApDD8MA-1; Wed, 15 Jan 2020 17:09:48 -0500
X-MC-Unique: 4JVC9NgAPlGsD0fApDD8MA-1
Received: by mail-lj1-f197.google.com with SMTP id h23so4466106ljk.14
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jan 2020 14:09:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6gHyBZ8+XeG4963OEjkw03c1ZgmrL31FuTlHZYv52rM=;
        b=ZQAAa4hIco5tH5OHSrYWj83tgRpC2NXahjLaYMZeg3SO3s9Op8GejKlJt+IvuM2cTy
         VbvEXHlCHg/iDrNOKqXhDBO1SLBdxE0/29kMQ7xdurrAnHuEnJJwFwkkpgb+AX1p0QW0
         fvbudkbkwkuk63XoS8jTp4JEa2Fg8kqPxFR6V9Pc4b3Z/9dfGiX1ClGUnq4JwpDoizMz
         i/5da5r9oyNL9dr7J7M98zr5YZ1gAk0o+iSgLLAwPUKiBWrUre9+oEFynFEGTQqZFSJZ
         3jp1lDwIC8394fcJUEwGtdXigE4yKWnXtmPGLzVaQMxutH25R1sCeKLDtuhJ5rLkBkN9
         atVA==
X-Gm-Message-State: APjAAAWKqF3RNMUvz0zq34zhg7rrPsSkjsPPeATaoBegqecap+abTY2A
        fSP24yjN9XDOrWnKzc06tr9+nI6c/rbAR3qZT54seb4Kw6ipCLGYWswuS18P94fp002woq7nCdI
        pPR5O7xztSzwzNHgFD/0B4A==
X-Received: by 2002:a2e:8804:: with SMTP id x4mr309084ljh.187.1579126186247;
        Wed, 15 Jan 2020 14:09:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqyl9usYNPHfWl85TIz6drR9BBM82kZH5HkqsoxTXL5G4+0RjNxZ3iAMQC2ii0NABa1NGrcMXg==
X-Received: by 2002:a2e:8804:: with SMTP id x4mr309055ljh.187.1579126186024;
        Wed, 15 Jan 2020 14:09:46 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id r20sm9450459lfi.91.2020.01.15.14.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 14:09:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 970D01804D6; Wed, 15 Jan 2020 23:09:44 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
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
Subject: Re: [PATCH bpf-next v2 00/10] tools: Use consistent libbpf include paths everywhere
In-Reply-To: <20200115211900.h44pvhe57szzzymc@ast-mbp.dhcp.thefacebook.com>
References: <157909756858.1192265.6657542187065456112.stgit@toke.dk> <20200115211900.h44pvhe57szzzymc@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 15 Jan 2020 23:09:44 +0100
Message-ID: <87r200tlqv.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Jan 15, 2020 at 03:12:48PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> The recent commit 6910d7d3867a ("selftests/bpf: Ensure bpf_helper_defs.h=
 are
>> taken from selftests dir") broke compilation against libbpf if it is ins=
talled
>> on the system, and $INCLUDEDIR/bpf is not in the include path.
>>=20
>> Since having the bpf/ subdir of $INCLUDEDIR in the include path has neve=
r been a
>> requirement for building against libbpf before, this needs to be fixed. =
One
>> option is to just revert the offending commit and figure out a different=
 way to
>> achieve what it aims for. However, this series takes a different approac=
h:
>> Changing all in-tree users of libbpf to consistently use a bpf/ prefix in
>> #include directives for header files from libbpf.
>
> I don't think such approach will work in all cases.
> Consider the user installing libbpf headers into /home/somebody/include/b=
pf/,
> passing that path to -I and trying to build bpf progs
> that do #include "bpf_helpers.h"...
> In the current shape of libbpf everything will compile fine,
> but after patch 8 of this series the compiler will not find bpf/bpf_helpe=
r_defs.h.
> So I think we have no choice, but to revert that part of Andrii's patch.
> Note that doing #include "" for additional library headers is a common pr=
actice.
> There was nothing wrong about #include "bpf_helper_defs.h" in bpf_helpers=
.h.

OK, I'll take another look at that bit and see if I can get it to work
with #include "bpf_helper_defs.h" and still function with the read-only
tree (and avoid stale headers).

-Toke

