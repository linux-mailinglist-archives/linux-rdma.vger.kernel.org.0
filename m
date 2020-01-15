Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33DF213C81F
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 16:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgAOPlR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 10:41:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32967 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726132AbgAOPlR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jan 2020 10:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579102876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3l69K3PDMlJemoFXpDZpBSROJVwgjnc3IAfTJYLJE1A=;
        b=gmr0V+2sz4RlsgC/DPErjcbN3Ez+1sPP+oeHGkAH45PpsZJ9HF+DLkqqfRog6QAW/JUFaB
        D/X41BqZueSv47yS3fSjbFv8f7ahSRQpwTpCqp92F35PgEX9cpQpvawBwvuAMXKi09c+BJ
        O+7D5OIlQGGG3uk8tJJ3Bx3Zkfw6UZ4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-L8E5oczAPFqDjcmMKae-EA-1; Wed, 15 Jan 2020 10:41:15 -0500
X-MC-Unique: L8E5oczAPFqDjcmMKae-EA-1
Received: by mail-lf1-f70.google.com with SMTP id v10so3300315lfa.14
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jan 2020 07:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=3l69K3PDMlJemoFXpDZpBSROJVwgjnc3IAfTJYLJE1A=;
        b=O76ahLEB4fGFq/n2M2FOy+cfeY0UplDiNFDBa/kd4bjhVqRU7IS53ge0NHAYnvnnOO
         WSphpgIyoUUVFu/SLfOpzWaRPlehFlkFRJpyqabG0yU5bfKqeVPDsMj2bS0xWVBK60PW
         Dy+eRj1i0VQpwaEFJrh+tfWi45a0zMylwSOHH/QAIEb9zJ1d4adkOnTp8q51Giedx0/e
         mEOjB9EM27CYQ+rZNNkkKA9/drfvCJ3eEqTBf/Npr6V9hEqOTncmeyVFvH8SdYABQZS5
         l7f6S9M9Jdh3LUCpVtvbbUdPRuTCu0A+bUS7amUf1/fEpAF9TIGZvvit/kGxw+lbdYUu
         II2A==
X-Gm-Message-State: APjAAAXBje9jhysJFI+ceV17K4Rucm6NoQ/neWONJysORg2edt8cAN5x
        z+/IUO9OKpwPVoxFLtKyuAKKn5G/3b5BI19Z2oC7BtRETdONHzu71oPtGxGjqnMwp++TMTpUkac
        MRGnHb24RrmOmIdBymAmdZQ==
X-Received: by 2002:a19:5e0a:: with SMTP id s10mr5018194lfb.165.1579102874485;
        Wed, 15 Jan 2020 07:41:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqyazUrqAH6dclikkhYZ4/DJpUS4QXtSoJ0WpysfA1lHkQWnuS6US8Z0PNCGkK1YfaYA0049DA==
X-Received: by 2002:a19:5e0a:: with SMTP id s10mr5018171lfb.165.1579102874260;
        Wed, 15 Jan 2020 07:41:14 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id s22sm9557271ljm.41.2020.01.15.07.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:41:13 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DB6C51804D6; Wed, 15 Jan 2020 16:41:12 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
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
        clang-built-linux@googlegroups.com, brouer@redhat.com
Subject: Re: [PATCH bpf-next v2 07/10] samples/bpf: Use consistent include paths for libbpf
In-Reply-To: <20200115161825.351ebf23@carbon>
References: <157909756858.1192265.6657542187065456112.stgit@toke.dk> <157909757639.1192265.16930011370158657444.stgit@toke.dk> <20200115161825.351ebf23@carbon>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 15 Jan 2020 16:41:12 +0100
Message-ID: <87y2u8u3qf.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> On Wed, 15 Jan 2020 15:12:56 +0100
> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> wrote:
>
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>=20
>> Fix all files in samples/bpf to include libbpf header files with the bpf/
>> prefix, to be consistent with external users of the library. Also ensure
>> that all includes of exported libbpf header files (those that are export=
ed
>> on 'make install' of the library) use bracketed includes instead of quot=
ed.
>>=20
>> To make sure no new files are introduced that doesn't include the bpf/
>> prefix in its include, remove tools/lib/bpf from the include path entire=
ly,
>> and use tools/lib instead.
>>=20
>> Fixes: 6910d7d3867a ("selftests/bpf: Ensure bpf_helper_defs.h are taken =
from selftests dir")
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> I like this change. Maybe the reason so many samples/bpf/ files
> still included "libbpf.h" was that once-upon-a-time we had a "eBPF mini
> library" in the file samples/bpf/libbpf.h that were included.

Yes, I think something similar is the case with bpf_helpers.h - that
used to be outside libbpf, and I guess no one bothered to do a cleanup
such as this one when it was moved...

-Toke

