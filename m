Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1627BCF8E
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Oct 2023 20:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344391AbjJHS1j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 Oct 2023 14:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjJHS1i (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 8 Oct 2023 14:27:38 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F27A3;
        Sun,  8 Oct 2023 11:27:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3247cefa13aso3504021f8f.1;
        Sun, 08 Oct 2023 11:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696789654; x=1697394454; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UYhUlM0v/kiBnSA7qqkERNTe3ha0hd9wd9BeXsJuFRo=;
        b=JSwbmiZCaHGFO9Si6aH78Qhj9fM1wPHsOC6QWVJSzNk857ic9djFm1+pqpk7pKGGxp
         WK3OroWhyW83kshoTJkBSqAM1tR+Ha3SNMtzTkzxy1+isDHg9DCb4sfzdO7iJyuJ4vM6
         GR2qEFcddyvF98b18yVubStOuYHQp2n0ihk/bQA6RkeUJIo/sveVPblAg0ZN09hsaqyM
         dG01SXARf3kz3CV69rmGyz7YMWvRliAwYR/MGwfFklyf+gu5FEFUxCYFM2/q+RPlmJX4
         C/c22d/ojpo4+0PIJCZW8bq3aphc45v1g8lUjODL6QBp1vFVIxeZE+lgJLSKmsTX/Dxg
         6ODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696789654; x=1697394454;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYhUlM0v/kiBnSA7qqkERNTe3ha0hd9wd9BeXsJuFRo=;
        b=WASWiYr5sredpi3vQS1/AmmtvabMd5lZPwX3X+pCdWlas685T/aeukaJTe1NBGjjqz
         yuK6Iw2W7tN+r/cVUcjwQw31/MyXl3wenZx4YAPUCy+MAKfhLRDgyuxFq6HyWX6LIEwb
         jbUsN0YI1cMDojNxa5lcHfk0KOYMsXapjwuyyLGGr+7d/vHsOxPuLsSNtvJzadipK0oF
         JmRSDYPsRYPG6yY9cdsx2i8Wags3/yNj5YNy8ouRDYcYfkoDjcGNLr/kkh162swm0Wgx
         V7bu4qs8hVWpaCKKoa+XPhamUDwni8IBhWk974uao9Y0P06vjHmuRPgZsWwYXaSz2fe0
         onUA==
X-Gm-Message-State: AOJu0Yy9/hL3kn78PiCc3H19pEopZxmLbFnorDbRsO6fcEN9Unjx4ePY
        xE3KXStg9Tfq9CbOTiQz4k4=
X-Google-Smtp-Source: AGHT+IG1Z2UQG/8uimtzwOsX0SSnSzQeAnFClPvayUdx2bESkKFHKQw9/TSlsvhrREuwaEcXQ8SiYA==
X-Received: by 2002:a5d:50c8:0:b0:316:f24b:597a with SMTP id f8-20020a5d50c8000000b00316f24b597amr11755917wrt.46.1696789653876;
        Sun, 08 Oct 2023 11:27:33 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id j14-20020adff54e000000b003233a31a467sm7413627wrp.34.2023.10.08.11.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 11:27:33 -0700 (PDT)
Message-ID: <6522f495.df0a0220.326ed.de6c@mx.google.com>
X-Google-Original-Message-ID: <ZSL0kLgKGmK2HJ9x@Ansuel-xps.>
Date:   Sun, 8 Oct 2023 20:27:28 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Eric Dumazet <edumazet@google.com>
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
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
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
Subject: Re: [net-next PATCH v2 4/4] netdev: use napi_schedule bool instead
 of napi_schedule_prep/__napi_schedule
References: <20231003145150.2498-1-ansuelsmth@gmail.com>
 <20231003145150.2498-4-ansuelsmth@gmail.com>
 <CANn89iLtYZJPOQE7OkAbEdmhT8qjzAJ+27poa__3c8Nf0M6u_w@mail.gmail.com>
 <652056c5.5d0a0220.2b60d.c5dc@mx.google.com>
 <CANn89i+Cie+oE_hTWkyJWutTG9CnPy+dbW+-A97Q+E9Rq-f9rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+Cie+oE_hTWkyJWutTG9CnPy+dbW+-A97Q+E9Rq-f9rQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 08, 2023 at 09:08:41AM +0200, Eric Dumazet wrote:
> On Fri, Oct 6, 2023 at 8:49 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > On Thu, Oct 05, 2023 at 06:16:26PM +0200, Eric Dumazet wrote:
> > > On Tue, Oct 3, 2023 at 8:36 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > >
> > > > Replace if condition of napi_schedule_prep/__napi_schedule and use bool
> > > > from napi_schedule directly where possible.
> > > >
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > >  drivers/net/ethernet/atheros/atlx/atl1.c     | 4 +---
> > > >  drivers/net/ethernet/toshiba/tc35815.c       | 4 +---
> > > >  drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 4 +---
> > > >  3 files changed, 3 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
> > > > index 02aa6fd8ebc2..a9014d7932db 100644
> > > > --- a/drivers/net/ethernet/atheros/atlx/atl1.c
> > > > +++ b/drivers/net/ethernet/atheros/atlx/atl1.c
> > > > @@ -2446,7 +2446,7 @@ static int atl1_rings_clean(struct napi_struct *napi, int budget)
> > > >
> > > >  static inline int atl1_sched_rings_clean(struct atl1_adapter* adapter)
> > > >  {
> > > > -       if (!napi_schedule_prep(&adapter->napi))
> > > > +       if (!napi_schedule(&adapter->napi))
> > > >                 /* It is possible in case even the RX/TX ints are disabled via IMR
> > > >                  * register the ISR bits are set anyway (but do not produce IRQ).
> > > >                  * To handle such situation the napi functions used to check is
> > > > @@ -2454,8 +2454,6 @@ static inline int atl1_sched_rings_clean(struct atl1_adapter* adapter)
> > > >                  */
> > > >                 return 0;
> > > >
> > > > -       __napi_schedule(&adapter->napi);
> > > > -
> > > >         /*
> > > >          * Disable RX/TX ints via IMR register if it is
> > > >          * allowed. NAPI handler must reenable them in same
> > > > diff --git a/drivers/net/ethernet/toshiba/tc35815.c b/drivers/net/ethernet/toshiba/tc35815.c
> > > > index 14cf6ecf6d0d..a8b8a0e13f9a 100644
> > > > --- a/drivers/net/ethernet/toshiba/tc35815.c
> > > > +++ b/drivers/net/ethernet/toshiba/tc35815.c
> > > > @@ -1436,9 +1436,7 @@ static irqreturn_t tc35815_interrupt(int irq, void *dev_id)
> > > >         if (!(dmactl & DMA_IntMask)) {
> > > >                 /* disable interrupts */
> > > >                 tc_writel(dmactl | DMA_IntMask, &tr->DMA_Ctl);
> > > > -               if (napi_schedule_prep(&lp->napi))
> > > > -                       __napi_schedule(&lp->napi);
> > > > -               else {
> > > > +               if (!napi_schedule(&lp->napi)) {
> > > >                         printk(KERN_ERR "%s: interrupt taken in poll\n",
> > > >                                dev->name);
> > > >                         BUG();
> > >
> > > Hmmm... could you also remove this BUG() ? I think this code path can be taken
> > > if some applications are using busy polling.
> > >
> > > Or simply rewrite this with the traditional
> > >
> > > if (napi_schedule_prep(&lp->napi)) {
> > >    /* disable interrupts */
> > >    tc_writel(dmactl | DMA_IntMask, &tr->DMA_Ctl);
> > >     __napi_schedule(&lp->napi);
> > > }
> > >
> > >
> >
> > Mhhh is it safe to do so? I mean it seems very wrong to print a warning
> > and BUG() instead of disabling the interrupt only if napi can be
> > scheduled... Maybe is very old code? The more I see this the more I see
> > problem... (randomly disabling the interrupt and then make the kernel
> > die)
> 
> I am pretty sure this BUG() can be hit these days with busy polling or
> setting gro_flush_timeout.
> 
> I wish we could remove these bugs before someone copy-paste them.
> 
> Again, this is orthogonal, I might simply stop doing reviews if this
> is not useful.

They are very useful and thanks a lot for them! I'm asking these as to
understand how to proceed. I have in queue 2 other series that depends
on this and I'm just asking info on how to speedup the progress on this!

Soo think I have to send v3 with the suggested change and BUG() dropped?
Happy to do everything to fix and improve this series!

-- 
	Ansuel
