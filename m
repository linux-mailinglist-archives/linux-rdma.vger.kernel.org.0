Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5AD40657D
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Sep 2021 04:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbhIJCBw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Sep 2021 22:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhIJCBv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Sep 2021 22:01:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38835C061756
        for <linux-rdma@vger.kernel.org>; Thu,  9 Sep 2021 19:00:41 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x27so853830lfu.5
        for <linux-rdma@vger.kernel.org>; Thu, 09 Sep 2021 19:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Uum+eXxKl7E8Vfz4IYs1ZYTXVuqCttV8A2hHBap2fOM=;
        b=qSj4q/9yh6h2yl7YEKfiMk4cvNkvdKrqNDYlO7ADJT3RtNf8rmf61v4hUVkMCGHGtm
         rthuMbi3bIlUbpqQA3Oc86W6AoundTNhq/2NQBwlfIgPYq939s9mr9aziER9fyXjtCPC
         L/iBCvXMioWN7Fb24TliD/xMM4VOHXGAz8xg41vopC0rNFS9kn3GZGXdafVX2fVYZDoD
         MZSKhiMwgvIg5u7F+O6lJrWtBI48M3S0BlyKrri95bi6Q94LDodaBnUpH5Exj1U6V/l1
         v15kn6/YhKxyKhXGNtUu1Lloi3WpCk18xkOA0Yk3XHa0iy5lBVrub/SSgaeqRy87aO3x
         1hhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Uum+eXxKl7E8Vfz4IYs1ZYTXVuqCttV8A2hHBap2fOM=;
        b=JCK/xvRUy7fESWom6g6L3r8v7dyFfp8iX79WStFylVd/7q6d4/JC154A+hy1jmraHP
         QwLJl5n7EFPh8ffr8jOB71GrKjVYNyShTSq4LL8awpkhwTLJx3VcxLlIF9u4auRqLpsK
         e+77Au1+GGvUvLB0dC6acs8jJGKTUcQoyA5L/YcV6xK2SRd74yUDU47/XE6UYGXz3fcZ
         KVStEn/yJHojQnQdFYgWvqSlfzI7npRkihic5+5wVeGbyDJRTRX8A6ic5Y482R10cTpA
         GgH030yCOJYZq+9T8r/8uWdd3/+Xa44R/Xzlbxy5Zm5FyIIy8YvGv7bYw4+hvKic5XEl
         BzEA==
X-Gm-Message-State: AOAM532bBVot3v9AtWxoMMCfDt3SJ+kpCy9ZU46a4XrBH+d2u+t97YgV
        VGYsPvtcTK10Y4v2Fsuv4FrKGDJ1WfqOS9SKd91wxA==
X-Google-Smtp-Source: ABdhPJxH2uBdeST0nduzHRbFIGPhvw7XFM2pjJsogidqxTFgzaqyizJgKW+U8VqG0FXj6j4icB+UuBwd5B4iXQaokSc=
X-Received: by 2002:a05:6512:139c:: with SMTP id p28mr1915757lfa.523.1631239239581;
 Thu, 09 Sep 2021 19:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210908061611.69823-1-mie@igel.co.jp> <CAD=hENcYPRQXB4NVfpm+_R2qn3czW3oSOS6rS=CEKWwhHEfkZA@mail.gmail.com>
In-Reply-To: <CAD=hENcYPRQXB4NVfpm+_R2qn3czW3oSOS6rS=CEKWwhHEfkZA@mail.gmail.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Fri, 10 Sep 2021 11:00:28 +0900
Message-ID: <CANXvt5qv1wyYZnChG3b0s6WVgv0wUEYTJB_aV09ZsYXwCsfKoQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] RDMA/rxe: Add dma-buf support
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>, taki@igel.co.jp,
        etom@igel.co.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

2021=E5=B9=B49=E6=9C=889=E6=97=A5(=E6=9C=A8) 14:45 Zhu Yanjun <zyjzyj2000@g=
mail.com>:
> After applying the patches, please run rdma-core tests with the patched k=
ernel.
> Then fix all the problems in rdma-core.

I understand. I'd like to do the tests and fix it before posting the next
patches

Regards,
Shunsuke
