Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA721463B82
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Nov 2021 17:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238625AbhK3QVZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Nov 2021 11:21:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50140 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243903AbhK3QUy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Nov 2021 11:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638289049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bh2xH2WYNc1n+eZ6WtfnZ4QpRuO9aH5y18ufnjGl1cA=;
        b=N1jTE+/R0rhhw2cAe8Q7hFcuv1pxTQwMq+OXkpyc/eTCG9rxbitHH4iyZlIiyRWznVLmA1
        soUtq2HISlAKvh3Z7HR7kFGG3lJ75SY6FTqiYH79Pr9tPcfrckFsqvgw/uZ5LF6q1crxkR
        oWFym05dj7kIXwaObPNLOgRHu+2rSJg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-AuCoVP31MzOvGfhK-rEWZA-1; Tue, 30 Nov 2021 11:17:27 -0500
X-MC-Unique: AuCoVP31MzOvGfhK-rEWZA-1
Received: by mail-ed1-f69.google.com with SMTP id m12-20020a056402430c00b003e9f10bbb7dso17379405edc.18
        for <linux-rdma@vger.kernel.org>; Tue, 30 Nov 2021 08:17:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Bh2xH2WYNc1n+eZ6WtfnZ4QpRuO9aH5y18ufnjGl1cA=;
        b=durYVCTo39Z5WEPd9YVRcTZ70OsbBART70ZaUMTDLczyUoNKIUE/Jf7iUIQpfV8h1J
         iF2G7PwJroJkTff6a95u1dpAp48PQQDEkIT74pRYDXbDEMbb/wlA1aE9Z/hBnmANQn5P
         ZVYeF5zwKkgC+sdnn+sihlK1pzP5RWfextd4FTGjeO0VBpH1HdCfJp5DvB0463BQOkIY
         LcijzMfFkDXciPEGux4DYWTMmwNhqIyHAMJwD+RX7FpETYafcxEm3L2eJ4hHCJ9qMrp4
         JBJS+vSgsSyqdrdFD2QzlOzwwwMAQzxRkCK9CMUefPVJvzSLmZKJ+4E8QscXJowkrwdN
         4PoQ==
X-Gm-Message-State: AOAM530VgfLRK/Zriu306WSvxlI6PB3gP9e3T2ouMHER/v3bf0kdx4Oa
        7LG/lcFauOnea2R0uUgvrAGSXB6xt0QSzdmEICaJ70tGUpu2PNWcu6/S2owd/Tzk+TnVQzgjdt0
        EJuDZm3I9sSFxzVrvtrBneA==
X-Received: by 2002:a17:906:d54d:: with SMTP id cr13mr22697ejc.409.1638289045947;
        Tue, 30 Nov 2021 08:17:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzm7jXoK2TvSroiJ5tHiLFjrswRyG0q/IaZ6d4NOHuATUVkXigtSnHPZVM/QNjl22FRlNuJYA==
X-Received: by 2002:a17:906:d54d:: with SMTP id cr13mr22591ejc.409.1638289045383;
        Tue, 30 Nov 2021 08:17:25 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u23sm11967828edi.88.2021.11.30.08.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 08:17:24 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 39B381802A0; Tue, 30 Nov 2021 17:17:24 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shay Agroskin <shayagr@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        Noam Dagan <ndagan@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Yajun Deng <yajun.deng@linux.dev>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 net-next 00/26] net: introduce and use generic XDP stats
In-Reply-To: <20211130155612.594688-1-alexandr.lobakin@intel.com>
References: <20211123163955.154512-1-alexandr.lobakin@intel.com>
 <20211130155612.594688-1-alexandr.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 30 Nov 2021 17:17:24 +0100
Message-ID: <871r2x8vor.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Alexander Lobakin <alexandr.lobakin@intel.com> writes:

> From: Alexander Lobakin <alexandr.lobakin@intel.com>
> Date: Tue, 23 Nov 2021 17:39:29 +0100
>
> Ok, open questions:
>
> 1. Channels vs queues vs global.
>
> Jakub: no per-channel.
> David (Ahern): it's worth it to separate as Rx/Tx.
> Toke is fine with globals at the end I think?

Well, I don't like throwing data away, so in that sense I do like
per-queue stats, but it's not a very strong preference (i.e., I can live
with either)...

> My point was that for most of the systems we have 1:1 Rx:Tx
> (usually num_online_cpus()), so asking drivers separately for
> the number of RQs and then SQs would end up asking for the same
> number twice.
> But the main reason TBH was that most of the drivers store stats
> on a per-channel basis and I didn't want them to regress in
> functionality. I'm fine with reporting only netdev-wide if
> everyone are.
>
> In case if we keep per-channel: report per-channel only by request
> and cumulative globals by default to not flood the output?

... however if we do go with per-channel stats I do agree that they
shouldn't be in the default output. I guess netlink could still split
them out and iproute2 could just sum them before display?

> 2. Count all errors as "drops" vs separately.
>
> Daniel: account everything as drops, plus errors should be
> reported as exceptions for tracing sub.
> Jesper: we shouldn't mix drops and errors.
>
> My point: we shouldn't, that's why there are patches for 2 drivers
> to give errors a separate counter.
> I provided an option either to report all errors together ('errors'
> in stats structure) or to provide individual counters for each of
> them (sonamed ctrs), but personally prefer detailed errors. However,
> they might "go detailed" under trace_xdp_exception() only, sound
> fine (OTOH in RTNL stats we have both "general" errors and detailed
> error counters).

I agree it would be nice to have a separate error counter, but a single
counter is enough when combined with the tracepoints.

> 3. XDP and XSK ctrs separately or not.
>
> My PoV is that those are two quite different worlds.
> However, stats for actions on XSK really make a little sense since
> 99% of time we have xskmap redirect. So I think it'd be fine to just
> expand stats structure with xsk_{rx,tx}_{packets,bytes} and count
> the rest (actions, errors) together with XDP.

A whole set of separate counters for XSK is certainly overkill. No
strong preference as to whether they need a separate counter at all...

> Rest:
>  - don't create a separate `ip` command and report under `-s`;
>  - save some RTNL skb space by skipping zeroed counters.
>
> Also, regarding that I count all on the stack and then add to the
> storage once in a polling cycle -- most drivers don't do that and
> just increment the values in the storage directly, but this can be
> less performant for frequently updated stats (or it's just my
> embedded past).
> Re u64 vs u64_stats_t -- the latter is more universal and
> architecture-friendly, the former is used directly in most of the
> drivers primarily because those drivers and the corresponding HW
> are being run on 64-bit systems in the vast majority of cases, and
> Ethtools stats themselves are not so critical to guard them with
> anti-tearing. Anyways, local64_t is cheap on ARM64/x86_64 I guess?

I'm generally a fan of correctness first, so since you're touching all
the drivers anyway why I'd say go for u64_stats_t :)

-Toke

