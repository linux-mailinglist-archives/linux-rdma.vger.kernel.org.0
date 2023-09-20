Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7627A83F0
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 15:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbjITNxS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 09:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbjITNxR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 09:53:17 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EEAAD
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 06:53:12 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1d66bf632bdso2769963fac.2
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 06:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1695217991; x=1695822791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6d94T6Yt3abqLcHWk2Ebh6n1KcC47dH3g+Yc369Vn4=;
        b=VVQldFlmpzut2vKRElw6DAcMq4uzDuPgf2bpjWSpFDVv+CoEnMnjiXQwN8DMT4yIlD
         YirFkvU96OfT5Y4LR8YMVcwt2EVFwFHMU1rdXeM7BO6NOKF7FuAiPxNSr1xJu2e8X9+J
         3MKySmhcPXICacDWdAJxqj6vbscJK51sMuJzKK+47k76Sw8sfKcij4N/OohBMWOupuCA
         5VoktBLz3g3PtWSBmwdxDBYRmueGWIn2R7QVl+TLNOB6KA05il4pdTUM5RojhRrxlyvB
         sOQ8k5Gypp+6m16xHfVC7gn5TCWoRRF3QnmYv5pQTQzmZb0WNOUl4tbaMIpJ7uXR2/B3
         S4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695217991; x=1695822791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6d94T6Yt3abqLcHWk2Ebh6n1KcC47dH3g+Yc369Vn4=;
        b=b1JORlJkmI9F3AWMpXfKK7+Pu6oXALHgdOP2HZL9ybR6B5cgtz4ZZNutNdeRuXh3zm
         0Nb8o1hXMk5E2qoEWZAikeHoUHGZflYJlyB8waanx/3Iyk6OjtN5ei/sr95EiqSiLos9
         YzVoE558MAdeTphEqTzXljtgNNBrGgmIRR7SPZJU2l60ttu5A2HDg890H5cTasNBZc85
         eUcp9tWjVewBaRzgvLW9deoBrurg6VcgJnAJDjkk1Ws/bCFF7jXOCfdpdbZhrCNPEuvg
         /8uZtUHi2jNc58tfflA4A7wv5tKX77QcaOzUMnJ+Vss+rcimcmqxgTnWHF4OjyCsm2A2
         0Apw==
X-Gm-Message-State: AOJu0YxDozkm2ygPTlyxqnTjgnqD3KhxZ5f8IT3ZCSP+Z4d4dz8AXkJh
        fBEkdnbkMcWXbDmCvi0NXp6oBg7d2wRvtKRlhuOKkw==
X-Google-Smtp-Source: AGHT+IEtughVVdNx8wkaKJkpJ2TDDXZl9JWedneH1VY07kCrztVpf2TZYXnL6LDdRvIDjcvh2H8B7DssPlvFMANBWoI=
X-Received: by 2002:a05:6870:462a:b0:1b0:e98:163b with SMTP id
 z42-20020a056870462a00b001b00e98163bmr2414074oao.21.1695217991406; Wed, 20
 Sep 2023 06:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230918142700.12745-1-vitaly@enfabrica.net> <20230919072136.GB4494@unreal>
 <CAF0Wxh=YhKCLbOLZ+-b+_rmzRoWQtqoBGn6Bo9X3zR308Vm1zA@mail.gmail.com>
 <CAF0Wxhkxa1Lk76nnkTQbNL6_v_4amczVd=wodPt00iOU2WB6+w@mail.gmail.com>
 <20230920054452.GH4494@unreal> <20230920125507.GU13733@nvidia.com>
 <CAF0WxhkuN0J3K5tUw0rb3-v=zKPKTh5YcCGSciaBXx9yfN-GEw@mail.gmail.com> <20230920131032.GY13733@nvidia.com>
In-Reply-To: <20230920131032.GY13733@nvidia.com>
From:   Vitaly Mayatskikh <vitaly@enfabrica.net>
Date:   Wed, 20 Sep 2023 09:53:00 -0400
Message-ID: <CAF0WxhnXDfXE94O7etK8edWGiA+b4D792sNzz8b7w7H7D_=kvQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA/core: use rdma_cap_iw_cm() in rdma_resolve_route()
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        linux-rdma@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Roland Dreier <roland@enfabrica.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 20, 2023 at 9:10=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:

> But is it iWarp?
>
> I'm not keen on seeing people abuse iwarp stuff for some non-standards
> based thing. iwarp is already in a disused state, there isn't enough
> community energy there to police something non-standards based.

No, it is IP-based, but not iWarp. Using CM implementation for
IP-network (IW_CM) was a logical decision. In fact, IW_CM can be
rebranded as IP_CM as it is not tightly coupled with iWarp per se and
can serve any IP-based protocols.

Thanks.
