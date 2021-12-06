Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE7346A0B9
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 17:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359076AbhLFQMg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 11:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389413AbhLFQJi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 11:09:38 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1F6C0A891E
        for <linux-rdma@vger.kernel.org>; Mon,  6 Dec 2021 07:46:52 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so14076018oto.13
        for <linux-rdma@vger.kernel.org>; Mon, 06 Dec 2021 07:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZvLDCefckRxy1mFS+DGveqUXXlACJvPiqsGSf+7cPdU=;
        b=pkhD10q96kZQ17G0L+FNtmM4PPtjxvEc865qK9rk+KMxbxicU+W7DVaRsE6H3r5YeX
         GuIVqGmzU0lFG63Tra4eHceMTmkWe2kUH2qZ8DQwyKoXghWWAStv12Oi94xFYYo9hUAL
         Pkvpo/Z0LfmF2AMZpho+WfC70JIMhOeAOmemi4xWMsQKPTfvghLrAPOelxgor7hNF3H2
         LBy9uf41tEY6iTw7YXOajUL/BPkKJ+O86saHp/6wF6dz9/fgvGiN4v2aLsKMY1UTNdw2
         CHiJdAAxWyHlyI8hzpUxF1fSw7EeM2aTSV6u4PM3zi/F77sjqV8YrjIPH40t/ZDNPkG3
         I8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZvLDCefckRxy1mFS+DGveqUXXlACJvPiqsGSf+7cPdU=;
        b=WWsI2k9riTsyj8V674px0y8SASV+apZ7u3IqQz/KKUhE9TQ7Qu9w9dde5Oh2zJ7ht3
         5NDuUDbXNzSWZFkV8KPwQABrbf3VHbgdnBRKLQtwpYE8MDy1gEIvHXHZetT8Q0QVC68c
         XkEv6qUzLXp5OxXhi2B6uqdJs4If9EutiF2MhAKssIF1YxCozRSS+ccV9usN+oJ31BqX
         Rtfr/o6B6cl6tXmv//gCs6NKB3XU20WBOLzbHUb/cn299Q1Vm3DyaY1EmVY4sS9/FpEk
         X5Wq19aqV4/D2v2C00LqZoAKwKIG+lEpahrFYf+uPbmWhhfohgASiS/Y7zou89xwPc4S
         GUwg==
X-Gm-Message-State: AOAM5319mM27l8SjqPqT6vxp33Eg62P498s+PG7xlTvI4/owl5HAudHg
        MPIVxZL/8LCgSQNO+p+XsEsOyD+AkMD70dYxlq7awA==
X-Google-Smtp-Source: ABdhPJyl8P4IkJCac6YLt/389WF6b9JLZz8073J1RhzQ9qagfuUxvx37gGzVPpu/IkYdpH4YeI+iUnaAux2ii3gLgLU=
X-Received: by 2002:a05:6830:2425:: with SMTP id k5mr29986009ots.319.1638805611763;
 Mon, 06 Dec 2021 07:46:51 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c3eace05d24f0189@google.com> <20211206154159.GP5112@ziepe.ca>
In-Reply-To: <20211206154159.GP5112@ziepe.ca>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 6 Dec 2021 16:46:40 +0100
Message-ID: <CACT4Y+bnJ5M84RjUONFYMXSOpzC5UOq2DxVNoQkq6c6nYwG9Og@mail.gmail.com>
Subject: Re: [syzbot] BUG: corrupted list in rdma_listen (2)
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     syzbot <syzbot+c94a3675a626f6333d74@syzkaller.appspotmail.com>,
        avihaih@nvidia.com, dledford@redhat.com, haakon.bugge@oracle.com,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 6 Dec 2021 at 16:42, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Sat, Dec 04, 2021 at 01:54:17AM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    bf152b0b41dc Merge tag 'for_linus' of git://git.kernel.org..
>
> ??
>
> This commit is nearly a year old?
>
> $ git describe --contains bf152b0b41dc
> v5.12-rc4~28
>
> I think this has probably been fixed since, why did a report for such
> an old kernel get sent?

Hi Jason,

Oh, that's because the arm32 kernel was broken for that period, so
syzbot tested the latest working kernel. There is a more fresh x86_64
crash available on the dashboard:
https://syzkaller.appspot.com/bug?extid=c94a3675a626f6333d74
