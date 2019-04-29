Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE1ADDC6
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2019 10:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfD2IaU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Apr 2019 04:30:20 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35134 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbfD2IaU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Apr 2019 04:30:20 -0400
Received: by mail-vs1-f67.google.com with SMTP id d8so5435396vsp.2;
        Mon, 29 Apr 2019 01:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ejeAg30FO+SrDtF8jst8HDS2kpQ8atdoBfotSwpxGw=;
        b=svqzG533x54Ap5WJ3C0W7KXAnx99/4WT14tCfvNeaikhLHw8zeAeYBgvRx6Snn40HC
         t4wE0fIbhVwalokrsTmrUJoIDOkeqxd44zwZd7SP8HTvApphhTCiVWGctt1pzAguxMIe
         BU6u4UqZT3tFRG8XzvdocJK/xjWRw4uG3Jv9MzsJofhJYQ1hFu5d9Y4JQq+XTWAq/78h
         W0DOZ4bH1ScRYpYKS0kUVUUhG+bMa/Kqtxcf/10QyFpSsea1bmfvx/kYxwQEl2zyrs0P
         grDmOaGmqVrARm9TEUyr4awn06VgCg3Dc2vGtcQgcxF0dNy7jxEszZOVpvSv8jkwKTe4
         IUVQ==
X-Gm-Message-State: APjAAAVbV/f6/naSuKl9utyMM02FwA5dc8MgA9B0LDBbo/kPsEUDwXbw
        yPTQHvxwRL2JW81TvbpajRvjasuuHcCYVChviXk7aAG+
X-Google-Smtp-Source: APXvYqzpqRt7EbZh16JJWNf37hn4Co28yEj8C8YShxPm09scenh8EIcQQAtmmHqFtn2V4S8z4NnkGRneooKSVufHnhI=
X-Received: by 2002:a67:ba07:: with SMTP id l7mr4160689vsn.11.1556526618217;
 Mon, 29 Apr 2019 01:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190429082645.9394-1-geert@linux-m68k.org>
In-Reply-To: <20190429082645.9394-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Apr 2019 10:30:06 +0200
Message-ID: <CAMuHMdUuPPf8T2_WK2V_zW8kxb1ZfzvyKJck9D3MEHMRvYrmdA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.1-rc7
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 29, 2019 at 10:28 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.1-rc7[1] to v5.1-rc6[3], the summaries are:
>   - build errors: +1/-0

  + /kisskb/src/drivers/infiniband/core/uverbs_main.c: error: 'struct
vm_fault' has no member named 'vm_start':  => 898:15, 898:28

mips-allmodconfig
mips-allmodconfig
s390-allmodconfig
s390-allyesconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/37624b58542fb9f2d9a70e6ea006ef8a5f66c30b/ (all 236 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/085b7755808aa11f78ab9377257e1dad2e6fa4bb/ (all 236 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
