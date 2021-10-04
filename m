Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBC1420B0E
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Oct 2021 14:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbhJDMoN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Oct 2021 08:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbhJDMoM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Oct 2021 08:44:12 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F0BC061746
        for <linux-rdma@vger.kernel.org>; Mon,  4 Oct 2021 05:42:23 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 5-20020a9d0685000000b0054706d7b8e5so21327097otx.3
        for <linux-rdma@vger.kernel.org>; Mon, 04 Oct 2021 05:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OVSwl/mXXto5uL+RrHEGqRvQahW/ZfpPh6/yhUtWjo=;
        b=HJ8uQ7DxBnpPf3XPuZlSbUWz53S0T4RwhN6VuHCS4wRZHfCz1LLXdiKQ+ydLW2RUdb
         28+OYtF8ML2eKXjc4NSQy6X8cgloCI86P+SoUO/A6tXiVvjjX7OLR5IQ9p3+sgO3VjWj
         3DPXtdDUBhgaDGOhfLs2Humqr5sF3G5z+ggWRR8TXO98f753b/LAue0gZHq9NTBe9T3f
         0HMjIhyx/4tuYVo0U9QqCbYtMhoutvd7X47QydD51LkEhByiJNhaOR4KvoEwSrHKQo5k
         Vimq0ULM2EvDxO1DFDjQXQIJK8kp2ZuK9qzCTwc3zVBrT7Fv4UWvW1lygVatwvXDNeN/
         ObDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OVSwl/mXXto5uL+RrHEGqRvQahW/ZfpPh6/yhUtWjo=;
        b=M+w2qBSZICd2zlBYswzw4f9+R0Uw5NaH7RjoPv9nEIKRTQKwcPz+JXG5/QlRQjOf+j
         UEsQ1wFhFHr6IeytDX1n0aYOYna6y9/BRDKj23z6Fe0RZboTFBv1O3iQ41D41dctd8FP
         Ghh6OgPpK7rq5WnsVElovxL3BlTTaWeY4AutaDp2dNfmkKLhMCGtoj1RZpvkVaM6yg5n
         D85Ir02rHS8wlrLUJg1mnew/74NRRUufBZKyvz1uh4uEFi3ttEjGesYDn6dNHJ/LxvGb
         GxyA75kPSzw6zdQ3WRdVWJEc2U/zrYsHJ+ynKaPb2HPSJup4vPJEPPND1y9giwTulZO2
         Jmgw==
X-Gm-Message-State: AOAM530aKpxrBSsI8sU54tiV8fIi7JNr0ikcoz62rMVXjRoszUao9hln
        MkAk6EO8tQRirTaD7EJvRE5mU215ULfitVrxHbuGEw==
X-Google-Smtp-Source: ABdhPJx2JwdrPZUg8v0yUg8VLP/XIba3nx9KYrRusMF5XCEooJWRHYSk4ge6U+8iAFiktjHfoRdkf6bu/rBFKBMDWSE=
X-Received: by 2002:a9d:2f28:: with SMTP id h37mr9040432otb.196.1633351342781;
 Mon, 04 Oct 2021 05:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000005a800a05cd849c36@google.com>
In-Reply-To: <0000000000005a800a05cd849c36@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 4 Oct 2021 14:42:11 +0200
Message-ID: <CACT4Y+ZRrxmLoor53nkD54sA5PJcRjWqheo262tudjrLO2rXzQ@mail.gmail.com>
Subject: Re: [syzbot] BUG: RESTRACK detected leak of resources
To:     Doug Ledford <dledford@redhat.com>,
        syzbot <syzbot+3a992c9e4fd9f0e6fd0e@syzkaller.appspotmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 4 Oct 2021 at 12:45, syzbot
<syzbot+3a992c9e4fd9f0e6fd0e@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c7b4d0e56a1d Add linux-next specific files for 20210930
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=104be6cb300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c9a1f6685aeb48bd
> dashboard link: https://syzkaller.appspot.com/bug?extid=3a992c9e4fd9f0e6fd0e
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3a992c9e4fd9f0e6fd0e@syzkaller.appspotmail.com

+RESTRACK maintainers

(it would also be good if RESTRACK would print a more standard oops
with stack/filenames, so that testing systems can attribute issues to
files/maintainers).

> rdma_rxe: rxe-pd pool destroyed with unfree'd elem
> rdma_rxe: rxe-mr pool destroyed with unfree'd elem
> restrack: ------------[ cut here ]------------
> infiniband syz0: BUG: RESTRACK detected leak of resources
> restrack: Kernel PD object allocated by rds_rdma is not freed
> restrack: ------------[ cut here ]------------
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
