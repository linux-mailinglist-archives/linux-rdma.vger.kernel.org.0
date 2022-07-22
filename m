Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F17357E391
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jul 2022 17:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbiGVPNr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jul 2022 11:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiGVPNq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jul 2022 11:13:46 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0D697D70
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jul 2022 08:13:45 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w205so1367253pfc.8
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jul 2022 08:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XxFzGhwt5AuVJJSYar2lrYEtQS3ifDO6IUtl2O8d2BI=;
        b=UmRUOgT1OdAVEWomXd8Y3kM/G03mjjopBkONO1DJyT0zUQEFR1A+5l9ypGKGUExkF+
         AdbQS98rEMyx27w+3WRdPPR6knC1RaLHySFT/Eax1BvmshPG8Iql+u0/uRk8ZyPvU4Vi
         7S6SL3VwWtMnBrEb6W6DqK0HoRRuML0W0U3nmV42Xc5YvNREjlmLsIQGZVsI6fzoBCmU
         at3y6tsqPJs034uw3DQXlfGyjEvBU1uer5gxIeDhYkYx8zZDK9cBZq+13rxrhhWGkFcu
         g5Wd59jtZgcOuI8DYUNEbuP4VUL60JJnwiPk3pGzTaalME0GOkn5agQQy+YSGuwV+U6k
         9/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XxFzGhwt5AuVJJSYar2lrYEtQS3ifDO6IUtl2O8d2BI=;
        b=DyJRWB71H82/WPzzqRbSNNv4xGbwtTPw5Us6s4XiLJK87+stYGYl/UKbiA57QCzBvM
         DBZhIqowkbxn1KHY3qfYiV2IdyPXkvaH0fCYpdYTsNaWTAvXTr/Xo20lod4NWqFyhAMn
         JRlvF0otbOgolgbTBbpjSPS+P+U8YNJ5ra4w6G13mJkIm9ZlE4jnGZpeKc1Z32f3mDd4
         +oOBxdCXRPRE/WJKg0qsFZQqHXl9U4BTLw1uOmNgc09AZWi8B/+r4aaBGmnBZNkV3lF3
         CpVv0N8uPDiiEP8gg6JIm8D7FsbI7HkECjM/Rb4rCyUPJOhCeYortfNskd/Wffyp2UCB
         IT4w==
X-Gm-Message-State: AJIora+A7FS8DJh40fH5MQpN9iuyH39tDbvqJOorgHdIPpX29W+f4d/b
        hzIbzpSqxXr2+Yrx5jiDkrzCig==
X-Google-Smtp-Source: AGRyM1u8VWto+mkpA8ydv4KTPfzDB9E98y8bthE9+L43CEN7uBd0MFqi78ssA3ajBCVq058BDyBnAw==
X-Received: by 2002:a63:445d:0:b0:41a:841a:8f1 with SMTP id t29-20020a63445d000000b0041a841a08f1mr227512pgk.81.1658502825281;
        Fri, 22 Jul 2022 08:13:45 -0700 (PDT)
Received: from ziepe.ca (S0106a84e3fe8c3f3.cg.shawcable.net. [24.64.144.200])
        by smtp.gmail.com with ESMTPSA id o4-20020a17090ac08400b001ef8ab65052sm3527991pjs.11.2022.07.22.08.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 08:13:44 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1oEuLX-000F7S-7j; Fri, 22 Jul 2022 12:13:43 -0300
Date:   Fri, 22 Jul 2022 12:13:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Li Zhijian <lizhijian@fujitsu.com>,
        Yanjun Zhu <yanjun.zhu@linux.dev>, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leon@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [RESEND RFC PATCH for-next] Revert "RDMA/rxe: Create duplicate
 mapping tables for FMRs"
Message-ID: <20220722151343.GA55077@ziepe.ca>
References: <1658312958-13-1-git-send-email-lizhijian@fujitsu.com>
 <CAJpMwyier2gtHoMhkrFeNXmqjUo9ab2Ba4Ef_YZoCwv__9cz=Q@mail.gmail.com>
 <318d02a4-8028-551c-5cda-e7934153e03d@gmail.com>
 <CAJpMwygwvi=CfJmtgienyfPJ=QgiM6dShGuQB4es7qRtSjuKaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJpMwygwvi=CfJmtgienyfPJ=QgiM6dShGuQB4es7qRtSjuKaQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 22, 2022 at 12:43:27PM +0200, Haris Iqbal wrote:

> IMHO, in addition to finding a use case for this, another question
> would be, whether putting this restriction of "rxe_map_mr_sg" needed
> for every reg_fast_mr/invalidate_mr() cycle makes sense in terms of
> spec and/or mlx drivers.

It doesn't really, the mapping of the MR is supposed to be permanent,
the only thing invalidate does is block use of the mkey. revalidating
without remapping shouldn't be impossible.

Jason
