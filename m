Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B417E6433
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Nov 2023 08:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjKIHRQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Nov 2023 02:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjKIHRO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Nov 2023 02:17:14 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEFC2584;
        Wed,  8 Nov 2023 23:17:12 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2809fb0027cso470513a91.2;
        Wed, 08 Nov 2023 23:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699514232; x=1700119032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h676+oWfQL/lpBtg3jVOc9Wf/b1Mbf60YLr0tyi5B20=;
        b=hRIfywNgUyV9RfAHXXSyXqOs9pQp+b9CuI9Ng4vI3NYuqGMWYO/I0KQCpIaoIZyIhc
         ZvsThktRowhOZLxHx/nahrx8tezvNpE6ES4+22BY45U1HaQwvxaJHE2OLw+CBe19Jyhd
         sCyokqe5BpJJhkwlaUrWFgqYXBRaUj6pXrtPFHnsF6s4PfyOAM3N1aKSFidZ43jKHCnu
         06XAUmpI0NZBqNOQYF9z96eGdAbeeLxwyhqSNG8XePPchq+zDkPynEzN1c5ddsop6XIj
         NrI5bmjQCaQGcwtPvkPy42vOgBNtaXt+WwBYN3bkG310M4r0y/fjjGRHA0MAPB9HCXOW
         UbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699514232; x=1700119032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h676+oWfQL/lpBtg3jVOc9Wf/b1Mbf60YLr0tyi5B20=;
        b=RKdwN+wfN0HCJQYuxNyyvsY4kX14SnZzwFEmvIdJJ2tyvSZWVir+psli7ivEikVxJK
         hQyffgHfDZJMG1ksRAjAV3gw85YK3AZ96KRvuvvdk56FhC0SmzEnPH7BJA3xKqaH3SZG
         i+nKRh2yE4G/UWAw1yiwidRk/CnnORAmw1DYDbQwqeG68j+qYfNhoEkMhETL2dLKaECF
         0ELxumt0LBsy9AhgIXf7ydKxkkwJKZM8Kp6+L8s56MeYM93w3FTkgjn1B59ti14EsbTA
         4+mikEHnfhDo2OoAlf/Ip3mMJ4XgDSw21qAnTOrm+l57wlprV5LAksscjnBYsJahtKjs
         xN5Q==
X-Gm-Message-State: AOJu0YwWKuY9GgQ+Crh2lVEKN37wU32pOELDEa7KQVyWaFQSXs5dU2Wu
        9Va2Uf0qh5wLSLM1jIwR4az6Yu+RHKaFQ4DeAG8=
X-Google-Smtp-Source: AGHT+IEx/fcKeZwE2IJhfgPKrIXqrF7HxQ/nNX6XsxkCr18l+nvOLzAGlFhxMJNfj2t20TtoYXeWTFZggs7/zaPMqlk=
X-Received: by 2002:a17:90b:1e4c:b0:27d:28ad:3086 with SMTP id
 pi12-20020a17090b1e4c00b0027d28ad3086mr866298pjb.2.1699514231496; Wed, 08 Nov
 2023 23:17:11 -0800 (PST)
MIME-Version: 1.0
References: <20231103095549.490744-1-lizhijian@fujitsu.com>
 <d838620b-51df-4216-864e-1c793dae7721@linux.dev> <a256a01d-1572-427a-80df-46f2079af967@fujitsu.com>
 <c736ddff-8523-463a-aa9a-3c8542486d69@linux.dev> <037148c3-c15b-4859-9b82-8349fcb54d0a@fujitsu.com>
In-Reply-To: <037148c3-c15b-4859-9b82-8349fcb54d0a@fujitsu.com>
From:   Greg Sword <gregsword0@gmail.com>
Date:   Thu, 9 Nov 2023 15:16:58 +0800
Message-ID: <CAEz=LcvVEBgW3f4q=ucuhLwNvD0xcunKLw+fLWSFbp14SUVNyg@mail.gmail.com>
Subject: Re: [PATCH RFC V2 0/6] rxe_map_mr_sg() fix cleanup and refactor
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 9, 2023 at 10:25=E2=80=AFAM Zhijian Li (Fujitsu)
<lizhijian@fujitsu.com> wrote:
>
>
>
> On 06/11/2023 21:58, Zhu Yanjun wrote:
> > =E5=9C=A8 2023/11/6 12:07, Zhijian Li (Fujitsu) =E5=86=99=E9=81=93:
> >>
> >>
> >> On 03/11/2023 21:00, Zhu Yanjun wrote:
> >>> =E5=9C=A8 2023/11/3 17:55, Li Zhijian =E5=86=99=E9=81=93:
> >>>> I don't collect the Reviewed-by to the patch1-2 this time, since i
> >>>> think we can make it better.
> >>>>
> >>>> Patch1-2: Fix kernel panic[1] and benifit to make srp work again.
> >>>>             Almost nothing change from V1.
> >>>> Patch3-5: cleanups # newly add
> >>>> Patch6: make RXE support PAGE_SIZE aligned mr # newly add, but not f=
ully tested
> >>>>
> >>>> My bad arm64 mechine offten hangs when doing blktests even though i =
use the
> >>>> default siw driver.
> >>>>
> >>>> - nvme and ULPs(rtrs, iser) always registers 4K mr still don't suppo=
rted yet.
> >>>
> >>> Zhijian
> >>>
> >>> Please read carefully the whole discussion about this problem. You wi=
ll find a lot of valuable suggestions, especially suggestions from Jason.
> >>
> >> Okay, i will read it again. If you can tell me which thread, that woul=
d be better.
> >>
> >>
> >>>
> >>>   From the whole discussion, it seems that the root cause is very cle=
ar.
> >>> We need to fix this prolem. Please do not send this kind of commits a=
gain.
> >>>
> >>
> >> Let's think about what's our goal first.
> >>
> >> - 1) Fix the panic[1] and only support PAGE_SIZE MR
> >> - 2) support PAGE_SIZE aligned MR
> >> - 3) support any page_size MR.
> >>
> >> I'm sorry i'm not familiar with the linux MM subsystem. It seem it's s=
afe/correct to access
> >> address/memory across pages start from the return of kmap_loca_page(pa=
ge).
> >> In other words, 2) is already native supported, right?
> >
> > Yes. Please read the comments from Jason, Leon and Bart. They shared a =
lot of good advice.
>
> I read the whole discussion again, but I believed i still missed a lost.
>
>
> > From them, we can know the root cause and how to fix this problem.
>
> I don't think i misunderstood the root cause:
> RXE splits memory into PAGE_SIZE units in the xarray. As a result, when w=
e extract an address from the xarray,
> we should not access address beyond a PAGE_SIZE window.
>
> IIUC, then how to fix it?
> - I'm not going to "removing page_size set", it's out of this patch scope=
.
>    Feel free to do the cleanup separately.
> - I'm not going to fix the NVMe/rtrs etc problems in this patch set when =
64K page is enabled.
>    But RXE will tell its callers explicitly "RXE don't don't support such=
 page_size"
> - I didn't state RXE supports PAGE_SIZE aligned page_size MR before refac=
toring rxe_map_mr_sg(),
>    because I worry about it was not correct to access address beyond the =
PAGE_SIZE window.
>
> What I should do next?
> Just state "RXE support PAGE_SIZE aligned MR" ? Then patches become
> RDMA/rxe: RDMA/rxe: don't allow registering !PAGE_SIZE aligned MR
> RDMA/rxe: set RXE_PAGE_SIZE_CAP to starting from PAGE_SIZE
>

What do you take rdma maillist for? Your bugzilla, jira? or your dev
program launch? Or your play ground?

> Or just keep we have done in the V1
>
> Thanks
>
>
> >
> > Good Luck.
> >
> > Zhu Yanjun
> >
> >>
> >> I get totally confused now.
> >>
> >>
> >>
> >>> Zhu Yanjun
> >>>
> >>>>
> >>>> [1] https://lore.kernel.org/all/CAHj4cs9XRqE25jyVw9rj9YugffLn5+f=3D1=
znaBEnu1usLOciD+g@mail.gmail.com/T/
> >>>>
> >>>> Li Zhijian (6):
> >>>>     RDMA/rxe: RDMA/rxe: don't allow registering !PAGE_SIZE mr
> >>>>     RDMA/rxe: set RXE_PAGE_SIZE_CAP to PAGE_SIZE
> >>>>     RDMA/rxe: remove unused rxe_mr.page_shift
> >>>>     RDMA/rxe: Use PAGE_SIZE and PAGE_SHIFT to extract address from
> >>>>       page_list
> >>>>     RDMA/rxe: cleanup rxe_mr.{page_size,page_shift}
> >>>>     RDMA/rxe: Support PAGE_SIZE aligned MR
> >>>>
> >>>>    drivers/infiniband/sw/rxe/rxe_mr.c    | 80 ++++++++++++++++------=
-----
> >>>>    drivers/infiniband/sw/rxe/rxe_param.h |  2 +-
> >>>>    drivers/infiniband/sw/rxe/rxe_verbs.h |  9 ---
> >>>>    3 files changed, 48 insertions(+), 43 deletions(-)
> >>>>
> >
