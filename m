Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8317C5B3A7A
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Sep 2022 16:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiIIOQT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Sep 2022 10:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiIIOQM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Sep 2022 10:16:12 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D56B517D
        for <linux-rdma@vger.kernel.org>; Fri,  9 Sep 2022 07:16:01 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id y82so2874584yby.6
        for <linux-rdma@vger.kernel.org>; Fri, 09 Sep 2022 07:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=E51sfK2hYiIlIkIpJ3YDblKe1pXs791tcFskKpEqYWg=;
        b=iBLp7+zKNyT79ettXvyH0PLVAmEtdj5iU8dGlJzd164GRLJTA7WGbbsxvIeeaGxUbM
         ja9535PGAh70KvqeiEetPqajslF0cvAjRDS0oV1Ok16gJbqiMQUC5sPS56ccIITRyKQH
         ERrfIqQU0S1GJ9AYb5ujT0cC1NETLoWInQ4+g2JII0OpA/jCOZZqJmmbLTr8aVt+p8J8
         URfB7tJUvS+VAc3Zgr7rgx8BR9vqwRP4M2v/2DIcU9ZYRAD/6psLhpbWjZXWB3oXDPOt
         kasiGeNnIppNVl80Ozhn+VNQF8TjnqSQ4mce6dr1lk+TpZ1ZZR96AsEJR6W33d5oL5Xp
         41qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=E51sfK2hYiIlIkIpJ3YDblKe1pXs791tcFskKpEqYWg=;
        b=JW8jotkOr7uzvibsKJ9QcWtGNfs2bXQJm+8PnQFJ5AAGlMYSpXTsGe+3GyAHrrT4e/
         Phb99f7KDpNQfv1ILQu+2kd7WjDrAdbfu27+f/f6C09yaQZkGxFFByjZfel+z5ceY0b1
         2xly87buvEHKZHB7pXA/1dAkgoqLI/B3H1MNA3rqeR+Wf27N5ta2Fqq28jAJG4yeAkEl
         Wxzw5KvOKQKrVmLzLFaHdZ5oBu7IaaeV8qxuGcqYY52Z92/mZmN68vpYoVF4bw4wWGKd
         TaUAoi4jUmCZ5Pgvj8p0lBhZTuy5DyWiJzpwrcPy1wxQMRzHP7a1iaxvqtwlYlYfPQPs
         YQ6A==
X-Gm-Message-State: ACgBeo0PyXG96gn8G/kP5aARPeBCvDKACycqBItGf6ni2VNt54t2FwgB
        EnLda8YaaW7xsk7qvg/tuuqABdvQSqsjtCtkOQA=
X-Google-Smtp-Source: AA6agR6jlnhmTHMIrIKMucgGne3xLUcAaVFgwm3lOsjnLd8++GjesVzoVwTW62RtJ9ikdTg1lXV68PpCG169n6uxvgY=
X-Received: by 2002:a05:6902:70c:b0:6a9:8517:eace with SMTP id
 k12-20020a056902070c00b006a98517eacemr12833843ybt.531.1662732960944; Fri, 09
 Sep 2022 07:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220908094548.4115-1-guoqing.jiang@linux.dev>
 <20220908094548.4115-4-guoqing.jiang@linux.dev> <CAJpMwyjzEc0hLbq7x5nQDPGp5Bwaqp4nTwcNBFryW28jKm8+aw@mail.gmail.com>
 <be6fca6f-d8a6-660e-dc19-14bac7a8df10@linux.dev>
In-Reply-To: <be6fca6f-d8a6-660e-dc19-14bac7a8df10@linux.dev>
From:   Santosh Pradhan <santosh.pradhan@gmail.com>
Date:   Fri, 9 Sep 2022 16:15:49 +0200
Message-ID: <CAOuNp5=Yb9Ee39xbkd0iRSpGHTzrQYCMtmqun+pEisJ+NY2c9g@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] RDMA/rtrs-clt: Kill xchg_paths
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Haris Iqbal <haris.iqbal@ionos.com>, jinpu.wang@ionos.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Looks good.

As clt->pcpu_path is of type "struct rtrs_clt_path __rcu
**ppcpu_path", using without typecasting with cmpxchg() would fetch
sparse warning.

I still believe we can use rcu_replace_pointer() instead of cmpxchg(),
anyway we are going to allow RCU grace period using synchronize_rcu().

Best Regards,
Santosh

On Thu, Sep 8, 2022 at 12:06 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
>
>
> On 9/8/22 5:55 PM, Haris Iqbal wrote:
> > On Thu, Sep 8, 2022 at 11:46 AM Guoqing Jiang<guoqing.jiang@linux.dev>  wrote:
> >> Let's call try_cmpxchg directly for the same purpose.
> >>
> >> Acked-by: Md Haris Iqbal<haris.iqbal@ionos.com>
> >> Signed-off-by: Guoqing Jiang<guoqing.jiang@linux.dev>
> >> Reported-by: kernel test robot<lkp@intel.com>
> > I am not sure whats the correct way of using this. But technically,
> > this change was NOT done due to a report from the "kernel test robot".
> > It only pointed out the problem in the original patch. To the branch
> > maintainers, if its okay to keep this in this scenario, then ignore
> > this comment.
>
> Me either, just want to give credit to lkp for previous report, but not sure
> if there is a better tag.
>
> Thanks,
> Guoqing
