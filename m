Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D513F35AF5C
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Apr 2021 19:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbhDJRnC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 10 Apr 2021 13:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhDJRnB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 10 Apr 2021 13:43:01 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537A9C06138C
        for <linux-rdma@vger.kernel.org>; Sat, 10 Apr 2021 10:42:45 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id l22so2875784ljc.9
        for <linux-rdma@vger.kernel.org>; Sat, 10 Apr 2021 10:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YQRCaZgP2UefM3Ubw17zbmZirkjkTDsaBGQG+axJ5kQ=;
        b=mjbnE9JRYwo/fH61O7Xyg2aVRfgPRGJsm4XORh9xQMVPMxNp+zDIb9pMaFMV3ATQt1
         +M6LrxvuT5e9oDB0rkXB3wmBvNR5UTP6ndLcJvIlUC/C6YqLmzFDpNWr6yxOzloHsibA
         tBA385gGi2e6vbt5P0I+lZ4/gLnEsvg1MMxBJz/poKMw42gMCkjCZeJAsSPJtDpkVpmL
         h4P0hfiQhLFbhxUpMMAUkID0aSo/qqJaKEmrSEfzJ2rIKAOhoLyFc+USxeCPa8Cy817P
         zqEMX41eeVSLoHDtC8131M4jumJazcD+PQis77VUdbRdVU4X/JjbmLmGylWWbsV/pbX4
         HxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YQRCaZgP2UefM3Ubw17zbmZirkjkTDsaBGQG+axJ5kQ=;
        b=cV+8+8U7J8lmtbUR2twjxvROReeokaNNBheMxiQL1C9wKJd/RCwp4wnJ4vSZixlKzh
         VjljIceV5nsWaDUnalJqWNAhm2OtrZnyDCuBM/4/fUhNt8OvxCV3wCm921FjhFx4mYd2
         OP5CtkCuWLZ0QlXqyvYNnJpj4D4RiOvSAHCjBg6G2IdohELT7zQ4zUtDwJXCo9/EP2OT
         2Pin4QJIQ+OWyLY74TIaBRMGx1TKj1sAxAxwS36KSlTttMP+WiOXE7yqskuuE14n2Esg
         X0BprDytEbKS2WNZ1/atsjnAcZy2I67UJteDa60x+7wrs7MOMFi9Y9CE4e3Ikn9q4JyR
         NCGQ==
X-Gm-Message-State: AOAM5329hWBQUG1MpNlmt8odBtdiP3NYg0enrZe4Bi7YNOaD4KSspIxm
        rtkQHJh5KrOSyu0XoVfUvPp9Yh8jo+sOtpGhQAq7ag==
X-Google-Smtp-Source: ABdhPJz54PyIV6KeuDGJx6pxTDDePDj+YPgyrhMW/RNrlHb4Plp9GyuL8iOp7iVgh+YTm/eAuEaH7X7lzhVg+2SHD4E=
X-Received: by 2002:a2e:9cc4:: with SMTP id g4mr12781684ljj.34.1618076563428;
 Sat, 10 Apr 2021 10:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210409223801.104657-1-mcroce@linux.microsoft.com>
 <20210409223801.104657-3-mcroce@linux.microsoft.com> <20210410154824.GZ2531743@casper.infradead.org>
 <YHHPbQm2pn2ysth0@enceladus>
In-Reply-To: <YHHPbQm2pn2ysth0@enceladus>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 10 Apr 2021 10:42:30 -0700
Message-ID: <CALvZod7UUxTavexGCzbKaK41LAW7mkfQrnDhFbjo-KvH9P6KsQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/5] mm: add a signature in struct page
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        netdev <netdev@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Rohit Maheshwari <rohitm@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Boris Pismenny <borisp@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Yu Zhao <yuzhao@google.com>,
        Will Deacon <will@kernel.org>,
        Michel Lespinasse <walken@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Roman Gushchin <guro@fb.com>, Hugh Dickins <hughd@google.com>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Cong Wang <cong.wang@bytedance.com>, wenxu <wenxu@ucloud.cn>,
        Kevin Hao <haokexin@gmail.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Marco Elver <elver@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Guillaume Nault <gnault@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Apr 10, 2021 at 9:16 AM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Matthew
>
> On Sat, Apr 10, 2021 at 04:48:24PM +0100, Matthew Wilcox wrote:
> > On Sat, Apr 10, 2021 at 12:37:58AM +0200, Matteo Croce wrote:
> > > This is needed by the page_pool to avoid recycling a page not allocated
> > > via page_pool.
> >
> > Is the PageType mechanism more appropriate to your needs?  It wouldn't
> > be if you use page->_mapcount (ie mapping it to userspace).
>
> Interesting!
> Please keep in mind this was written ~2018 and was stale on my branches for
> quite some time.  So back then I did try to use PageType, but had not free
> bits.  Looking at it again though, it's cleaned up.  So yes I think this can
> be much much cleaner.  Should we go and define a new PG_pagepool?
>
>

Can this page_pool be used for TCP RX zerocopy? If yes then PageType
can not be used.

There is a recent discussion [1] on memcg accounting of TCP RX
zerocopy and I am wondering if this work can somehow help in that
regard. I will take a look at the series.

[1] https://lore.kernel.org/linux-mm/20210316013003.25271-1-arjunroy.kdev@gmail.com/
