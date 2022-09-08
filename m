Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816515B17C2
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 10:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiIHIxs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 04:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiIHIxT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 04:53:19 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D211E6B97
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 01:53:18 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r18so9211785eja.11
        for <linux-rdma@vger.kernel.org>; Thu, 08 Sep 2022 01:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=ldknDEzVR51ObhugpTbmz8qodswdlxf/pDmvZsDvbxs=;
        b=eGRAP3op6LfSEWYjWrBvyRFaOrMkuJgjFDMHeDESJN27MR+jLwcUrs0WBANjWlcgDA
         eY5Dc4Uh1jk9ps6FaQj2cUAZ3GIq14MP1K5cVdvTfBdVDQd3a9zjfPCn9ic+FaFjw9mr
         m7FVgH0jKLnH5HtgUp31hNdqmRP/KYUf2zU8ULouZd4EKSqXkNNpsZVVDtRQPD5dFQVL
         OU7o4xCZVktnfH/POZ3rsTVolAQQsOz4w2SsFt1DYHic+lsk6bT+1qmfJdwXI95dKatA
         +hJH2VJg3B/ZbuD5SjjNcRLhJwMFa5kOrzniFG9R2r4CxipqcwAIgFc4LmSxZ4OIhVa0
         MrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ldknDEzVR51ObhugpTbmz8qodswdlxf/pDmvZsDvbxs=;
        b=FYClaN9owb6FDvnCuU9zg+SBzZtR2ld8xUX9Ui+gF9M0q/zqMhmDbEIQIWkIOK8c9R
         FnVyD6qW1fAgDErxQ/i1mbQe/BD3++GhM6hVEWhw+/owRlMypTzMq8+C86q1ZqGn6wQM
         dx/nad/8sl/dbpzItVMQIbjTYecFIst2oR725TCqfNKWwpf2jOjrntz+SpvpPhTCeQbL
         lcVaOKb7qQhSxBNgVcxyza8E3mV85AZUQbK5CxL5XSNTBNSoz+ZJFlF/1UJmouxwjspj
         sMez1eFnlXx0BAcENoFkH4pXbzLwrRVipRUgF8ptJbtOELGYxYl/BEwQCRBBKdAW8iE5
         XZlg==
X-Gm-Message-State: ACgBeo1Ij5cQg8u9rbmwM0q0LxMnu18+rR0K7rOmaleZoZ4kSpMcwfU1
        cMuHrlRvKuCrv4uSP2Xp+ZfxnLyTAk+11CCqpKignQ==
X-Google-Smtp-Source: AA6agR45UdCAtQKDBjY1MVMZqrEqb9s3ESeWL33cf3jIL9RNl3t659wVGPLehwqO7C/qFQ+wAQnJlTuvdshGtLAFHmI=
X-Received: by 2002:a17:906:7621:b0:750:c4a3:8fcd with SMTP id
 c1-20020a170906762100b00750c4a38fcdmr5607743ejn.180.1662627196581; Thu, 08
 Sep 2022 01:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220902101922.26273-1-guoqing.jiang@linux.dev>
 <YxXrf1WKVwlDYgzm@unreal> <0a170dcd-3665-43d2-8467-7566333d0307@linux.dev> <YxcrPY7LGcna1+eM@unreal>
In-Reply-To: <YxcrPY7LGcna1+eM@unreal>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Thu, 8 Sep 2022 10:53:06 +0200
Message-ID: <CAJpMwyiQS9r861iFyse2odEpQeAHa3wQmRSuLDqUk+ZOUa8kjQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] misc changes for rtrs
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>, jinpu.wang@ionos.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 6, 2022 at 1:13 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Sep 06, 2022 at 03:04:50PM +0800, Guoqing Jiang wrote:
> > Hi Leon,
> >
> > On 9/5/22 8:28 PM, Leon Romanovsky wrote:
> > > On Fri, Sep 02, 2022 at 06:19:19PM +0800, Guoqing Jiang wrote:
> > > > Hi,
> > > >
> > > > Pls review the three patches.
> > > >
> > > > Thanks,
> > > > Guoqing
> > > >
> > > > Guoqing Jiang (3):
> > > >    RDMA/rtrs: Update comments for MAX_SESS_QUEUE_DEPTH
> > > >    RDMA/rtrs-clt: Break the loop once one path is connected
> > > >    RDMA/rtrs-clt: Kill xchg_paths
> > > >
> > > >   drivers/infiniband/ulp/rtrs/rtrs-clt.c | 18 +++++-------------
> > > >   drivers/infiniband/ulp/rtrs/rtrs-pri.h |  7 +++----
> > > >   2 files changed, 8 insertions(+), 17 deletions(-)
> > > The third patch still generates warnings.
> >
> > Sorry, I didn't run sparse check, =F0=9F=98=85.
> >
> > > =E2=9E=9C  kernel git:(wip/leon-for-next) mkt ci
> > > ^[[A^[[A^[[Ad9b137e23d31 (HEAD -> build) RDMA/rtrs-clt: Kill xchg_pat=
hs
> > > WARNING: line length of 81 exceeds 80 columns
> > > #43: FILE: drivers/infiniband/ulp/rtrs/rtrs-clt.c:2297:
> > > +           if (try_cmpxchg((typeof(ppcpu_path))ppcpu_path, &clt_path=
, next))
> > >
> > > drivers/infiniband/ulp/rtrs/rtrs-clt.c:2297:21: warning: incorrect ty=
pe in initializer (different address spaces)
> > > drivers/infiniband/ulp/rtrs/rtrs-clt.c:2297:21:    expected struct rt=
rs_clt_path [noderef] __rcu *__new
> > > drivers/infiniband/ulp/rtrs/rtrs-clt.c:2297:21:    got struct rtrs_cl=
t_path *[assigned] next
> >
> > Before send new version, could you help to check whether the incrementa=
l
> > change works or not? Otherwise let's drop the third one.
>
> Thanks, it worked.

Looks good.

Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>

For all 3 patches (3rd one with the latest changes).
Thanks.

>
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > index 0661a4e69fc9..bc3e1722e00d 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > @@ -2294,7 +2294,8 @@ static void rtrs_clt_remove_path_from_arr(struct
> > rtrs_clt_path *clt_path)
> >                  * We race with IO code path, which also changes pointe=
r,
> >                  * thus we have to be careful not to overwrite it.
> >                  */
> > -               if (try_cmpxchg((typeof(ppcpu_path))ppcpu_path, clt_pat=
h,
> > next))
> > +               if (try_cmpxchg((struct rtrs_clt_path **)ppcpu_path,
> > +                               clt_path, next))
> >                         /*
> >                          * @ppcpu_path was successfully replaced with @=
next,
> >                          * that means that someone could also pick up t=
he
> >
> > Thanks,
> > Guoqing
