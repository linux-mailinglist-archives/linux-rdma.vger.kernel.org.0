Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8E67AE1F2
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 00:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjIYW4E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Sep 2023 18:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjIYW4D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Sep 2023 18:56:03 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F539101;
        Mon, 25 Sep 2023 15:55:57 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5045cb9c091so5553965e87.3;
        Mon, 25 Sep 2023 15:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695682555; x=1696287355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ns7ZEArTE1BO39sjKDu0VPQj937rLVJ+UOWzKiwxhK0=;
        b=dU8fdycnK6zg32sU5NgvslIrefjuvnuh7HC5eRg71jzxv6kA13y6HD5BN+2xwoT5zI
         K+HKxFAmANmWo/i0E3qLA6A04r6xvJ8sVfsR9p4QwwLKax3GGIrzVLagqXgppWvEE3DE
         hG6VL+KCLut1LbFegyfezuxfRPpNGStlhJ7c+cUpxlUOuyg0f0z3YA2RHQEMiV/leY6H
         RGYEmbOK5QYrUM0Dk6Ua9xfwzcprfEMjzGmHjFNLR5rgMSiAWo7qh5B62ed6cN7GGVQu
         8JuKqgxIbiLsvOLYZtzO4iHWq3nWc9Sd4aKRM9jg4ASzhE4FR5Sw52AmfTkzVv+zQFG1
         TUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695682555; x=1696287355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ns7ZEArTE1BO39sjKDu0VPQj937rLVJ+UOWzKiwxhK0=;
        b=jmr9qsEUs+6a9a8Q0ETr1koATy9w4by5tQPsdk1t2W6r9W9ZsFMPTV3MXXhQWEJ25+
         flfJ3+dAxOt8qLXtWJQQjKEDqGJfGm2tw13er4vLHrCAo0HB9uXmr1sj51IFk8ib2Qg7
         TMirQ7P9LuJk7PP+qUe5R9eNvOZpo0W0xBVX2cxlxhnINK2OsEsii4vzd3ku4atTYfQ2
         E9C0oGKPPK2D9dTBAU83rOXizk+clKa6vWBaE10iF8r5G4y6R1ygm5svnEPaf0SC8ULu
         a3Kevoh9npRZWPcuphHEpB5L0ccV+nVziG6F9cFZnSeATGNWcm48QUj8PfbAz1QivRpy
         fYzQ==
X-Gm-Message-State: AOJu0YwUvsDbAZr9rwNfhSjotwh/jrZPHrEOgS1D5CO/dPgBR7uV26Nt
        Xn5+yVZ7YQv+8PgaPIbOyu8xpuxK7pqsucMC0MM=
X-Google-Smtp-Source: AGHT+IEoPsnqkNoSwbveI2pV7v6ITpQkKQVTfdMSq6RV6I51JKONyhAkoGY+gDqo8UW32GHv0kFdF+T97NIDzpUc7ac=
X-Received: by 2002:a19:7009:0:b0:502:adbb:f9db with SMTP id
 h9-20020a197009000000b00502adbbf9dbmr6403156lfc.65.1695682554861; Mon, 25 Sep
 2023 15:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230925020528.777578-1-yury.norov@gmail.com> <20230925020528.777578-3-yury.norov@gmail.com>
 <49c0fa46-3787-99c5-2b8b-3da71ce33216@intel.com>
In-Reply-To: <49c0fa46-3787-99c5-2b8b-3da71ce33216@intel.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Mon, 25 Sep 2023 15:55:43 -0700
Message-ID: <CAAH8bW_Lu_wk7q6eu6evV-ejVXJZn0s3ikw=e=r_tJfYOvqg0Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] Revert "sched/topology: Introduce for_each_numa_hop_mask()"
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, Tariq Toukan <ttoukan.linux@gmail.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Maher Sanalla <msanalla@nvidia.com>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Pawel Chmielewski <pawel.chmielewski@intel.com>,
        Yury Norov <ynorov@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 25, 2023 at 3:46=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
>
>
>
> On 9/24/2023 7:05 PM, Yury Norov wrote:
> > Now that the only user of for_each_numa_hop_mask() is switched to using
> > cpumask_local_spread(), for_each_numa_hop_mask() is a dead code. Thus,
> > revert commit 06ac01721f7d ("sched/topology: Introduce
> > for_each_numa_hop_mask()").
> >
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > ---
> >  include/linux/topology.h | 18 ------------------
> >  1 file changed, 18 deletions(-)
> >
> > diff --git a/include/linux/topology.h b/include/linux/topology.h
> > index fea32377f7c7..344c2362755a 100644
> > --- a/include/linux/topology.h
> > +++ b/include/linux/topology.h
> > @@ -261,22 +261,4 @@ sched_numa_hop_mask(unsigned int node, unsigned in=
t hops)
> >  }
> >  #endif       /* CONFIG_NUMA */
> >
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>
> I might have squashed all of 2 through 4 into a single patch but not a
> big deal.

I just wanted to keep the changes more trackable. No objections to squash 2=
-4,
whatever maintainers will feel better.

Thanks,
Yury
