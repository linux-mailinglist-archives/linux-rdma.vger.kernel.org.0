Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302AE7BD533
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 10:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbjJII1u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 04:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbjJII1s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 04:27:48 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CE8AC
        for <linux-rdma@vger.kernel.org>; Mon,  9 Oct 2023 01:27:45 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so12412a12.0
        for <linux-rdma@vger.kernel.org>; Mon, 09 Oct 2023 01:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696840064; x=1697444864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/6BMjrzXld+2G2niRt8GwZnrjwExfOE5RsZF3IWDsg=;
        b=1Fvemo0zUEKWZz2P8ySOREgI6whV3blDLPFWkyKqFgGnIo++FsYUKbIP4/v7ivCHeK
         HKlpENY6UMOXVLbHCvDYYYK7MoDXsUjMfHaZ2UEdldT75b1O/Er2Yh5btjd8ZUJhWuAd
         rVQ5SV3f0XtPlgMiXb6nEWyN+j70uil5mEVNJMGPArnD4m9tOasbYa/FL/1FBiiPftff
         ROaXOl2frpDh74+GBeY+SLMfKPaygCn7bRT6t9RBAjQ9mFprSkkPJTtoSWBen/+EmpvI
         4i0JPXoO2v2LotPZrj3m0CSHW6K7VQ44iqg4uuGaSz02JOkwqxGqIucOTdLbhRGbURkW
         lIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696840064; x=1697444864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/6BMjrzXld+2G2niRt8GwZnrjwExfOE5RsZF3IWDsg=;
        b=fwsICfICemnC/8eNlLLdjLkbG4wLV1EXScskvLpuvYPx5nfmJjTCK4g8rcKa+SzyI8
         yXoKDoW00hpW4311a+p3TmCDFzGqNRb37+FYWxVZuRMt3l0JMsrxNpVGb/N2/vdQ+oLc
         7c/QjgElnimEkorLGV9sxFTlVF4AiBhqQkapRfpgKGd4QYF5F1x9Z+vVSIs6HjR5Sl1F
         Q6ZG1Mr83MAkbqSX3aztYGLhOT8tQ5euJdkrt4hEJjm8+j+LWlSDcAuEIK+r7LVH+g2I
         wpIafzYI/ztNBGGBqckE7yPSoIQ+LMU2MHIlCCIToSafOF31q+HIr/OCZwRtPar5aHuU
         hUYA==
X-Gm-Message-State: AOJu0YzjUZqbDpt3YGUQU1nEFlIyebxjj6IZHHf/8XNlcr3p6WW/dkG+
        gacYXRRdnsiaCHOoidwGuxhvHrFxd1VT4ijeWn15aw==
X-Google-Smtp-Source: AGHT+IHwFKC+Y1e+xZpwgUIz2ef+3S7gZvKInf35YDgwedW3l6WDYZ0JQtR1RAcQrjw2Yv9CI2XyHOq3oVUBlcAavLI=
X-Received: by 2002:a50:9fa4:0:b0:538:5f9e:f0fc with SMTP id
 c33-20020a509fa4000000b005385f9ef0fcmr350450edf.0.1696840063815; Mon, 09 Oct
 2023 01:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231003145150.2498-1-ansuelsmth@gmail.com> <20231003145150.2498-4-ansuelsmth@gmail.com>
 <CANn89iLtYZJPOQE7OkAbEdmhT8qjzAJ+27poa__3c8Nf0M6u_w@mail.gmail.com>
 <652056c5.5d0a0220.2b60d.c5dc@mx.google.com> <CANn89i+Cie+oE_hTWkyJWutTG9CnPy+dbW+-A97Q+E9Rq-f9rQ@mail.gmail.com>
 <6522f495.df0a0220.326ed.de6c@mx.google.com>
In-Reply-To: <6522f495.df0a0220.326ed.de6c@mx.google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 9 Oct 2023 10:27:32 +0200
Message-ID: <CANn89iLLsM8=fqoa_7O8iYyCzT2ebNs_jpY+e-RW+xCc7UnSDg@mail.gmail.com>
Subject: Re: [net-next PATCH v2 4/4] netdev: use napi_schedule bool instead of napi_schedule_prep/__napi_schedule
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Chris Snook <chris.snook@gmail.com>,
        Raju Rangoju <rajur@chelsio.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Shailend Chand <shailend@google.com>,
        Douglas Miller <dougmill@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nick Child <nnac123@linux.ibm.com>,
        Haren Myneni <haren@linux.ibm.com>,
        Rick Lindsley <ricklind@linux.ibm.com>,
        Dany Madden <danymadden@us.ibm.com>,
        Thomas Falcon <tlfalcon@linux.ibm.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
        Intel Corporation <linuxwwan@intel.com>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
        Liu Haijun <haijun.liu@mediatek.com>,
        M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
        Ziwei Xiao <ziweixiao@google.com>,
        Rushil Gupta <rushilg@google.com>,
        Coco Li <lixiaoyan@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Junfeng Guo <junfeng.guo@intel.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Wei Fang <wei.fang@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yuri Karpov <YKarpov@ispras.ru>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Zheng Zengkai <zhengzengkai@huawei.com>,
        Lee Jones <lee@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dawei Li <set_pte_at@outlook.com>,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        Benjamin Berg <benjamin.berg@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 8, 2023 at 8:27=E2=80=AFPM Christian Marangi <ansuelsmth@gmail.=
com> wrote:
>
> On Sun, Oct 08, 2023 at 09:08:41AM +0200, Eric Dumazet wrote:
> > On Fri, Oct 6, 2023 at 8:49=E2=80=AFPM Christian Marangi <ansuelsmth@gm=
ail.com> wrote:
> > >
> > > On Thu, Oct 05, 2023 at 06:16:26PM +0200, Eric Dumazet wrote:
> > > > On Tue, Oct 3, 2023 at 8:36=E2=80=AFPM Christian Marangi <ansuelsmt=
h@gmail.com> wrote:
> > > > >
> > > > > Replace if condition of napi_schedule_prep/__napi_schedule and us=
e bool
> > > > > from napi_schedule directly where possible.
> > > > >
> > > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > > ---
> > > > >  drivers/net/ethernet/atheros/atlx/atl1.c     | 4 +---
> > > > >  drivers/net/ethernet/toshiba/tc35815.c       | 4 +---
> > > > >  drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 4 +---
> > > > >  3 files changed, 3 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/n=
et/ethernet/atheros/atlx/atl1.c
> > > > > index 02aa6fd8ebc2..a9014d7932db 100644
> > > > > --- a/drivers/net/ethernet/atheros/atlx/atl1.c
> > > > > +++ b/drivers/net/ethernet/atheros/atlx/atl1.c
> > > > > @@ -2446,7 +2446,7 @@ static int atl1_rings_clean(struct napi_str=
uct *napi, int budget)
> > > > >
> > > > >  static inline int atl1_sched_rings_clean(struct atl1_adapter* ad=
apter)
> > > > >  {
> > > > > -       if (!napi_schedule_prep(&adapter->napi))
> > > > > +       if (!napi_schedule(&adapter->napi))
> > > > >                 /* It is possible in case even the RX/TX ints are=
 disabled via IMR
> > > > >                  * register the ISR bits are set anyway (but do n=
ot produce IRQ).
> > > > >                  * To handle such situation the napi functions us=
ed to check is
> > > > > @@ -2454,8 +2454,6 @@ static inline int atl1_sched_rings_clean(st=
ruct atl1_adapter* adapter)
> > > > >                  */
> > > > >                 return 0;
> > > > >
> > > > > -       __napi_schedule(&adapter->napi);
> > > > > -
> > > > >         /*
> > > > >          * Disable RX/TX ints via IMR register if it is
> > > > >          * allowed. NAPI handler must reenable them in same
> > > > > diff --git a/drivers/net/ethernet/toshiba/tc35815.c b/drivers/net=
/ethernet/toshiba/tc35815.c
> > > > > index 14cf6ecf6d0d..a8b8a0e13f9a 100644
> > > > > --- a/drivers/net/ethernet/toshiba/tc35815.c
> > > > > +++ b/drivers/net/ethernet/toshiba/tc35815.c
> > > > > @@ -1436,9 +1436,7 @@ static irqreturn_t tc35815_interrupt(int ir=
q, void *dev_id)
> > > > >         if (!(dmactl & DMA_IntMask)) {
> > > > >                 /* disable interrupts */
> > > > >                 tc_writel(dmactl | DMA_IntMask, &tr->DMA_Ctl);
> > > > > -               if (napi_schedule_prep(&lp->napi))
> > > > > -                       __napi_schedule(&lp->napi);
> > > > > -               else {
> > > > > +               if (!napi_schedule(&lp->napi)) {
> > > > >                         printk(KERN_ERR "%s: interrupt taken in p=
oll\n",
> > > > >                                dev->name);
> > > > >                         BUG();
> > > >
> > > > Hmmm... could you also remove this BUG() ? I think this code path c=
an be taken
> > > > if some applications are using busy polling.
> > > >
> > > > Or simply rewrite this with the traditional
> > > >
> > > > if (napi_schedule_prep(&lp->napi)) {
> > > >    /* disable interrupts */
> > > >    tc_writel(dmactl | DMA_IntMask, &tr->DMA_Ctl);
> > > >     __napi_schedule(&lp->napi);
> > > > }
> > > >
> > > >
> > >
> > > Mhhh is it safe to do so? I mean it seems very wrong to print a warni=
ng
> > > and BUG() instead of disabling the interrupt only if napi can be
> > > scheduled... Maybe is very old code? The more I see this the more I s=
ee
> > > problem... (randomly disabling the interrupt and then make the kernel
> > > die)
> >
> > I am pretty sure this BUG() can be hit these days with busy polling or
> > setting gro_flush_timeout.
> >
> > I wish we could remove these bugs before someone copy-paste them.
> >
> > Again, this is orthogonal, I might simply stop doing reviews if this
> > is not useful.
>
> They are very useful and thanks a lot for them! I'm asking these as to
> understand how to proceed. I have in queue 2 other series that depends
> on this and I'm just asking info on how to speedup the progress on this!
>
> Soo think I have to send v3 with the suggested change and BUG() dropped?
> Happy to do everything to fix and improve this series!

I think that your patch series is all about doing cleanups,
so I suggested adding another cleanup/fix,
and this can be done independently.

I doubt this matters, this code has probably not been used for quite a
long time...
