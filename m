Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6F2C13CFD9
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 23:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbgAOWKe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 17:10:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30401 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730479AbgAOWKe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Jan 2020 17:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579126232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LWQgt+DnfJs1UobRSdbBwxSCnfmXDMiH/Jey6CvGz7s=;
        b=OaRv6SAkpYDpRFht+xtVrulUMxOjOfz/SZykAPzpw26kCEVr16fYkXJFbHrzcq9Rjui2T/
        yGErWNoBEbKLOMs+scxO0gnkAtL1oOCiMt11glfJelV/QcQQkrx9J2OwguJL0cxXSJsEMI
        8Yb2AjS58/fslAcOw9nbmufS6APtZGg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-w4yb6qpaMqGO134YYB3BpA-1; Wed, 15 Jan 2020 17:10:31 -0500
X-MC-Unique: w4yb6qpaMqGO134YYB3BpA-1
Received: by mail-lj1-f197.google.com with SMTP id h23so4466546ljk.14
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jan 2020 14:10:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=LWQgt+DnfJs1UobRSdbBwxSCnfmXDMiH/Jey6CvGz7s=;
        b=ec/iRthPqp8gZgmqVOQ2YWQx0ACxgo4imFj9vnk4JZkA5Pl8zSuKhdoiu/sDoNNVfJ
         S1VfR8G2LAUmH3ZFVO+IS0Y6C+yf1gSjbvu4UTneCyLN/b02alvU9Hz6b2OTuOlhuu6j
         d67hJzEJ6hZ3RwknOLbcmbGcAVzlZ2a5ZwsrhNNOIauJEU6fekpGL/RGBFjN0joHQIBV
         KGmyEL9/9ZylqpPYFcaFXdlceEb9z1fWkVHatRao5nKNqrB4oUeWdgxfuES4wySJxk8f
         N14enhWJJDVNDrhqcmHua+uUBNuqq+3MuBFRqtceD4TGiuppPrHy3l+KjbN6Gh0nf0F1
         nMKQ==
X-Gm-Message-State: APjAAAWWacU6V0Qdq+1lSl21OWrgMFn+SUMtOo/5knd8YdZ9us1seKFz
        5yIjBOVGin39oQ3HKIWt76TOqFREijxF2Yrv86Stbe12/keeXsKqzpC9YFZzTocSOAjp83J7ZDA
        ORWRuZAjM1Ikcw0RnI4A6qQ==
X-Received: by 2002:a05:651c:102c:: with SMTP id w12mr309527ljm.53.1579126230099;
        Wed, 15 Jan 2020 14:10:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqwrMe2Yt2YfYiFKeLwwCIZhiM2ePXslA9DkgAL9gm4Pt7dVBs/ecmLwBp5r7JQsjiefGPMruw==
X-Received: by 2002:a05:651c:102c:: with SMTP id w12mr309523ljm.53.1579126229909;
        Wed, 15 Jan 2020 14:10:29 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id y1sm9734405ljm.12.2020.01.15.14.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 14:10:29 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A09761804D6; Wed, 15 Jan 2020 23:10:28 +0100 (CET)
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
        Shuah Khan <shuah@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-rdma@vger.kernel.org,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH bpf-next v2 00/10] tools: Use consistent libbpf include paths everywhere
In-Reply-To: <CAEf4Bza+dNoD7HbVQGtXBq=raz4DQg0yTShKZHRbCo+zHYfoSA@mail.gmail.com>
References: <157909756858.1192265.6657542187065456112.stgit@toke.dk> <CAEf4Bza+dNoD7HbVQGtXBq=raz4DQg0yTShKZHRbCo+zHYfoSA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 15 Jan 2020 23:10:28 +0100
Message-ID: <87o8v4tlpn.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Wed, Jan 15, 2020 at 6:13 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> The recent commit 6910d7d3867a ("selftests/bpf: Ensure bpf_helper_defs.h=
 are
>> taken from selftests dir") broke compilation against libbpf if it is ins=
talled
>> on the system, and $INCLUDEDIR/bpf is not in the include path.
>>
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
>>
>> This turns out to be a somewhat invasive change in the number of files t=
ouched;
>> however, the actual changes to files are fairly trivial (most of them ar=
e simply
>> made with 'sed'). Also, this approach has the advantage that it makes ex=
ternal
>> and internal users consistent with each other, and ensures no future cha=
nges
>> breaks things in the same way as the commit referenced above.
>>
>> The series is split to make the change for one tool subdir at a time, wh=
ile
>> trying not to break the build along the way. It is structured like this:
>>
>> - Patch 1-2: Trivial fixes to Makefiles for issues I discovered while ch=
anging
>>   the include paths.
>>
>> - Patch 3-7: Change the include directives to use the bpf/ prefix, and u=
pdates
>>   Makefiles to make sure tools/lib/ is part of the include path, but wit=
hout
>>   removing tools/lib/bpf
>>
>> - Patch 8: Change the bpf_helpers file in libbpf itself to use the bpf/ =
prefix
>>   when including (the original source of breakage).
>>
>> - Patch 9-10: Remove tools/lib/bpf from include paths to make sure we do=
n't
>>   inadvertently re-introduce includes without the bpf/ prefix.
>>
>> ---
>
> Thanks, Toke, for this clean up! I tested it locally for my set up:
> runqslower, bpftool, libbpf, and selftests all build fine, so it looks
> good. My only concern is with selftests/bpf Makefile, we shouldn't
> build anything outside of selftests/bpf. Let's fix that. Thanks!

Great, thanks for testing! I'll fix up your comments (and Alexei's) and
submit another version tomorrow.

-Toke

