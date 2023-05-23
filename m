Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEAF70D2CA
	for <lists+linux-rdma@lfdr.de>; Tue, 23 May 2023 06:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjEWE3t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 May 2023 00:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjEWE3s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 May 2023 00:29:48 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4EBFA;
        Mon, 22 May 2023 21:29:47 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-510ddeab704so595961a12.3;
        Mon, 22 May 2023 21:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684816186; x=1687408186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53F7nqwqQEhqsr+wrxJIasUQcBALYUEWV178mBfizlk=;
        b=mXWaKofF+P7YXx9mx6Iha/Royl4mFZDvYnnSjPTO2lbPB/HOrkgGkPivIos4HyZC1P
         McYXQvdn9zT+1IXuxt98SkvBKh/YH0jxKYSba+tJxUmVkEkghtQeNXVlBDZKlajwS476
         b3ZQiYndgLu5/VwJRugLFbETdL0HyPUZeB0EEtks0pjnxMwUvPDMXyUc1JUtDReLLh4K
         n70kO8VAR2Lwl+ImWjxTX6n8aDGrJFAbMDkULYlbhXFRPmz07veNg0gUL4un5ZO185iU
         JlWchEhPkhHxTtBZe1DcaSdW+fsb6xQV6NpZH5ymE+4e1jDavV/+PCCOvIEP2PPnjARk
         d+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684816186; x=1687408186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53F7nqwqQEhqsr+wrxJIasUQcBALYUEWV178mBfizlk=;
        b=T/91hPptw8JLAP+2wsxOKd4Nqj7rJ1TlObaGfD00jbSM7HH/PIqCq6WysfdmAKgKPp
         jkZJOdI8vPYkI22hBAzqA/vRXi4K2vFGHhA4zQc0pedAyv3ByOD/hTod2jb4GkTTdMRX
         E17GisO5PsQCc0QdgjpHDqC55IN3Dbm91xFNVdGqKL1vePJnimdn8ZUAWhD0FhKP5Q0X
         qOgZqvkxxUUNdYJrk92wF+IqTiHQYJY0zLwoB6Eq+927DjsFLi7FC7Bjbvi3VeaoEq8J
         6wghJKjTQgLqsZGexC+mgLvrd/JnbUZvJ0820HJ11zmSeF6nssEP2aHubSGKnfun73Pw
         LxKA==
X-Gm-Message-State: AC+VfDyCgsuXIpcAIHN2ozoEfTsyLaHI7k74I+GdihAkOC3YjEOjU1Xv
        OcaqrebrSWLpVepsXtZJRh3vN+swLHNHUr7g1O0=
X-Google-Smtp-Source: ACHHUZ7dVojBJEzxlc7n6PZs/RU6pQT5Zh3lWMe/BsWCAK4ykUBeokawONhnXtSWvLqERwKzfl/SYvJmpOaDP0578s0=
X-Received: by 2002:a17:907:a4c:b0:94e:e30e:7245 with SMTP id
 be12-20020a1709070a4c00b0094ee30e7245mr9463484ejc.8.1684816185754; Mon, 22
 May 2023 21:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a589d005fc52ee2d@google.com> <13528f21-0f36-4fa2-d34f-eecee6720bc1@linux.dev>
 <CAD=hENeCo=-Pk9TWnqxOWP9Pg-JXWk6n6J19gvPo9_h7drROGg@mail.gmail.com>
 <CAD=hENdoyBZaRz7aTy4mX5Kq1OYmWabx2vx8vPH0gQfHO1grzw@mail.gmail.com> <0d515e17-5386-61ba-8278-500620969497@linux.dev>
In-Reply-To: <0d515e17-5386-61ba-8278-500620969497@linux.dev>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 23 May 2023 12:29:33 +0800
Message-ID: <CAD=hENcqa0jQvLjuXw9bMtivCkKpQ9=1e0-y-1oxL23OLjutuw@mail.gmail.com>
Subject: Re: [syzbot] [rdma?] INFO: trying to register non-static key in
 skb_dequeue (2)
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     syzbot <syzbot+eba589d8f49c73d356da@syzkaller.appspotmail.com>,
        jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 23, 2023 at 12:10=E2=80=AFPM Guoqing Jiang <guoqing.jiang@linux=
.dev> wrote:
>
>
>
> On 5/23/23 12:02, Zhu Yanjun wrote:
> > On Tue, May 23, 2023 at 11:47=E2=80=AFAM Zhu Yanjun <zyjzyj2000@gmail.c=
om> wrote:
> >> On Tue, May 23, 2023 at 10:26=E2=80=AFAM Guoqing Jiang <guoqing.jiang@=
linux.dev> wrote:
> >>>
> >>>
> >>> On 5/23/23 10:13, syzbot wrote:
> >>>> Hello,
> >>>>
> >>>> syzbot tried to test the proposed patch but the build/boot failed:
> >>>>
> >>>> failed to apply patch:
> >>>> checking file drivers/infiniband/sw/rxe/rxe_qp.c
> >>>> patch: **** unexpected end of file in patch
> >> This is not the root cause. The fix is not good.
> > This problem is about "INFO: trying to register non-static key. The
> > code is fine but needs lockdep annotation, or maybe"

This warning is from "lock is not initialized". This is a
use-before-initialized problem.
The correct fix is to initialize the lock that is complained before it is u=
sed.

Zhu Yanjun
>
> Which is caused by  "skb_queue_head_init(&qp->resp_pkts)" is not called
> given rxe_qp_init_resp returns error, but the cleanup still trigger the
> chain.
>
> rxe_qp_do_cleanup -> rxe_completer -> drain_resp_pkts ->
> skb_dequeue(&qp->resp_pkts)
>
> But I might misunderstood it ...
>
> Thanks,
> Guoqing
