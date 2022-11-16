Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CFD62B2F1
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 06:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiKPFoi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Nov 2022 00:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiKPFoh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Nov 2022 00:44:37 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C523B62C7
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 21:44:35 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id l12so27867337lfp.6
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 21:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=35gmfbU0WG3XdSaiyHK00yDSAIhLEzyB6gxYsmgbda4=;
        b=HqcHZ44DTnISjUYEWwRjPjXuYf5rA7TNyxOuwIimBq1WcahtFPaiFDj3Z3lwS7BSTv
         D80jyeE4MsE+aC9KSmOkuEq0aO9Ahi0aFyixoLgTAYpS3+sU4rzswtVj2yxS4I7ELTOu
         MvGSH92HrHHatMVoO/SbwSDMgt8zKi1C5tSPve5YjuKhHEJBBRGejkuTN/I5CMpshhBa
         mRwuJG1X916I75afweBPFr5fQo7kqHAJh0n6ksZBmCF6nV7co4+7IHSnu0CeFUunqQxF
         0hzuCbAGHKjECpTWx52j19b+EfvVeUhuoVayNPQvw+cwD6kC2euYUXd3qd+2AM30TmHr
         BLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=35gmfbU0WG3XdSaiyHK00yDSAIhLEzyB6gxYsmgbda4=;
        b=g4jLsHrDAhlo0QQ34XONYQVzeyGWxCgCodoCwVwoSyDVO2b1aioaN/wvh54OUdkayb
         kbgAf+NBbBOK93LxAtKRgLXcAFh/ZYVCKsCIgbeTMHCoSSmIYySRl16hd3olsWMtTAEK
         hI/umhAhaGGMYBNOhMxWYJQGVzpdPz7zNodUINxttc+Ie/yHAjAZ8v5z8bRLZyiuiPL6
         Ynftxha5I8Jv9lvkVEAtRm5oOxYlhJC1xM1M6zjwtYvVOdKdYnh8mE6gHpi4GNH0yZan
         +IQRlCGzaZHf3g9c+NpWSMY8H4CYO+nxgcEpF4XtHHhHbx3ADrDT3gMBnpgAfDkJlymM
         Hfyw==
X-Gm-Message-State: ANoB5pkOR26x2CSBS8kmA+x/EIjYuFcUPRJWm7lVqPeb8bmQwDJPqnDa
        Y/dFzEZ122GoFw/f15GGBySs09P9mOKWtDY3/l6VpA==
X-Google-Smtp-Source: AA0mqf4LbtiVnpytUZqvFVDaYhAEeJZKqS/ezZ6WRC3st6xK9dez0nAnc/jW+MH5tZBXzv65PY6EA8xUmh9DItUUdmU=
X-Received: by 2002:ac2:5ca4:0:b0:494:6b75:2c1b with SMTP id
 e4-20020ac25ca4000000b004946b752c1bmr7602726lfq.478.1668577474004; Tue, 15
 Nov 2022 21:44:34 -0800 (PST)
MIME-Version: 1.0
References: <20221113010823.6436-1-guoqing.jiang@linux.dev>
 <20221113010823.6436-6-guoqing.jiang@linux.dev> <CAMGffEn3sYLbF1_05mjHvtOM4DPGKR3AYYTBip0BD=4V9g9-+A@mail.gmail.com>
 <9f626b16-ee9a-e8f6-2db9-2277fddab0e5@linux.dev>
In-Reply-To: <9f626b16-ee9a-e8f6-2db9-2277fddab0e5@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 16 Nov 2022 06:44:22 +0100
Message-ID: <CAMGffEmeA2zoGZ3gOn6jAmL01vfwnYPUYS35cjxxH3ri7_n0rQ@mail.gmail.com>
Subject: Re: [PATCH RFC 05/12] RDMA/rtrs-srv: Correct the checking of ib_map_mr_sg
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 16, 2022 at 2:13 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
>
>
> On 11/15/22 7:46 PM, Jinpu Wang wrote:
> > On Sun, Nov 13, 2022 at 2:08 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
> >> We should check with nr_sgt, also the only successful case is that
> >> all sg elements are mapped, so make it explict.
> >>
> >> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> >> ---
> >>   drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> >> index 88eae0dcf87f..f3bf5bbb4377 100644
> >> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> >> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> >> @@ -622,8 +622,8 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
> >>                  }
> >>                  nr = ib_map_mr_sg(mr, sgt->sgl, nr_sgt,
> >>                                    NULL, max_chunk_size);
> >> -               if (nr < 0 || nr < sgt->nents) {
> >> -                       err = nr < 0 ? nr : -EINVAL;
> >> +               if (nr != nr_sgt) {
> >> +                       err = -EINVAL;
> > but with this, the initial errno are lost, we only return EINVAL
>
> OK, assume you mean 'nr' here, I can change it back as iser_memory did.
> But seems the only negative value returned from ib_map_mr_sg is also
> "-EINVAL" from ib_sg_to_pages after go through hw drivers.
Yes, I meant nr.
there is also cases
"
if (unlikely(!mr->device->map_mr_sg))
return -ENOSYS;
"
>
> BTW, I looked all call sites of ib_map_mr_sg, seems they have different
> kind of checking.
>
> 1. if (ret < 0 || ret < nents)
>
> 2. if (ret < nents) or if (ret < 0)
>
> 3. if (ret != nents)
Yes, I also checked them. :)
>
> Thanks,
> Guoqing
