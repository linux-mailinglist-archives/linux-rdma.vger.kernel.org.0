Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B26E7BCCF3
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Oct 2023 09:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjJHHJE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 Oct 2023 03:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbjJHHJA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 8 Oct 2023 03:09:00 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19131FC
        for <linux-rdma@vger.kernel.org>; Sun,  8 Oct 2023 00:08:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so8158a12.0
        for <linux-rdma@vger.kernel.org>; Sun, 08 Oct 2023 00:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696748935; x=1697353735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6boweBsbEPYLh1haUGvUFhb+7tfvWfkGzP1aLPKTUnI=;
        b=F39qHPk5zk2pyBIKhEM6PcfKPQRqnY9pi/x8dTGkHBXtoFP1RZ9kgEew/bWJahSX7u
         ijedCeuRSfwz7OjfdCyxdqgtiBIWDVnZ+085y5EzOmOe01pKu/WoqWvlKM610Lf5ihNv
         BMUgGXOMdVPIH/J4H13eMVDC7AnXJsSP84YgXJgXK+hcNEhDJZUgmt1wUlUZv3PKqkU0
         g3k1jhh3eNn9QqkZXTNDOqxxoGlKUKZouNkqgcyvOvgTA+tlURIcHSfsmXi4Jc2lAOHi
         Va+NwqU0sc3x25H3/Yd53hz8MkS+gfLDgULe90K8Q9KqVKkuV57WLP+bSXUphgxnKMpJ
         4SZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696748935; x=1697353735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6boweBsbEPYLh1haUGvUFhb+7tfvWfkGzP1aLPKTUnI=;
        b=WSJ+WtA111wtwqFDMdutR0lIfIWOUuIMCyQHA0X7S8DCYyAee2UPvNWfwYzWaetpnC
         mj3DL8VzjsNLtBoBs6nqHZEHBBg31ObJtAYAUWEcn3W8O5bmkwWqvKg611YERB7X+bj7
         +tOWS46GmzhIjxDNyGd0BN7X18h+7S1+Z0R9Gxy7wRi4mddzqzAfetMAWCu866TFmRq3
         kYs9ysq5ebjZbldP3Dr9LWGEg+h7+sAcBK2C+7r7PqVlWvHnn9a8qVuKu9e4MPzhXSai
         WqjBCXsVsSFJSxWdEKmpMAe2EUf1I7oHG30+ZQb94gdTv7oClHHznj5RwQFRT3ELJBvg
         pmfw==
X-Gm-Message-State: AOJu0Yww2d4/sWJOJKkx3ba+y1A6z5fRAdGyGrEoJ6iyRCZtzsDqZXqW
        9JTHAuD7fmDEJAVBnfC/IeJrxtjRGATYsbzcTDlfxg==
X-Google-Smtp-Source: AGHT+IEVhxr/hi+K678k9mZTv6OusdxrCYSsJHysJnZbWTvXJuhiZ+72RbS/nL58DWxeXDrsThbghNBmT+06iJCcOf8=
X-Received: by 2002:a50:9f6c:0:b0:52e:f99a:b5f8 with SMTP id
 b99-20020a509f6c000000b0052ef99ab5f8mr308559edf.7.1696748935193; Sun, 08 Oct
 2023 00:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231003145150.2498-1-ansuelsmth@gmail.com> <20231003145150.2498-4-ansuelsmth@gmail.com>
 <CANn89iLtYZJPOQE7OkAbEdmhT8qjzAJ+27poa__3c8Nf0M6u_w@mail.gmail.com> <652056c5.5d0a0220.2b60d.c5dc@mx.google.com>
In-Reply-To: <652056c5.5d0a0220.2b60d.c5dc@mx.google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 8 Oct 2023 09:08:41 +0200
Message-ID: <CANn89i+Cie+oE_hTWkyJWutTG9CnPy+dbW+-A97Q+E9Rq-f9rQ@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 6, 2023 at 8:49=E2=80=AFPM Christian Marangi <ansuelsmth@gmail.=
com> wrote:
>
> On Thu, Oct 05, 2023 at 06:16:26PM +0200, Eric Dumazet wrote:
> > On Tue, Oct 3, 2023 at 8:36=E2=80=AFPM Christian Marangi <ansuelsmth@gm=
ail.com> wrote:
> > >
> > > Replace if condition of napi_schedule_prep/__napi_schedule and use bo=
ol
> > > from napi_schedule directly where possible.
> > >
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > >  drivers/net/ethernet/atheros/atlx/atl1.c     | 4 +---
> > >  drivers/net/ethernet/toshiba/tc35815.c       | 4 +---
> > >  drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 4 +---
> > >  3 files changed, 3 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/e=
thernet/atheros/atlx/atl1.c
> > > index 02aa6fd8ebc2..a9014d7932db 100644
> > > --- a/drivers/net/ethernet/atheros/atlx/atl1.c
> > > +++ b/drivers/net/ethernet/atheros/atlx/atl1.c
> > > @@ -2446,7 +2446,7 @@ static int atl1_rings_clean(struct napi_struct =
*napi, int budget)
> > >
> > >  static inline int atl1_sched_rings_clean(struct atl1_adapter* adapte=
r)
> > >  {
> > > -       if (!napi_schedule_prep(&adapter->napi))
> > > +       if (!napi_schedule(&adapter->napi))
> > >                 /* It is possible in case even the RX/TX ints are dis=
abled via IMR
> > >                  * register the ISR bits are set anyway (but do not p=
roduce IRQ).
> > >                  * To handle such situation the napi functions used t=
o check is
> > > @@ -2454,8 +2454,6 @@ static inline int atl1_sched_rings_clean(struct=
 atl1_adapter* adapter)
> > >                  */
> > >                 return 0;
> > >
> > > -       __napi_schedule(&adapter->napi);
> > > -
> > >         /*
> > >          * Disable RX/TX ints via IMR register if it is
> > >          * allowed. NAPI handler must reenable them in same
> > > diff --git a/drivers/net/ethernet/toshiba/tc35815.c b/drivers/net/eth=
ernet/toshiba/tc35815.c
> > > index 14cf6ecf6d0d..a8b8a0e13f9a 100644
> > > --- a/drivers/net/ethernet/toshiba/tc35815.c
> > > +++ b/drivers/net/ethernet/toshiba/tc35815.c
> > > @@ -1436,9 +1436,7 @@ static irqreturn_t tc35815_interrupt(int irq, v=
oid *dev_id)
> > >         if (!(dmactl & DMA_IntMask)) {
> > >                 /* disable interrupts */
> > >                 tc_writel(dmactl | DMA_IntMask, &tr->DMA_Ctl);
> > > -               if (napi_schedule_prep(&lp->napi))
> > > -                       __napi_schedule(&lp->napi);
> > > -               else {
> > > +               if (!napi_schedule(&lp->napi)) {
> > >                         printk(KERN_ERR "%s: interrupt taken in poll\=
n",
> > >                                dev->name);
> > >                         BUG();
> >
> > Hmmm... could you also remove this BUG() ? I think this code path can b=
e taken
> > if some applications are using busy polling.
> >
> > Or simply rewrite this with the traditional
> >
> > if (napi_schedule_prep(&lp->napi)) {
> >    /* disable interrupts */
> >    tc_writel(dmactl | DMA_IntMask, &tr->DMA_Ctl);
> >     __napi_schedule(&lp->napi);
> > }
> >
> >
>
> Mhhh is it safe to do so? I mean it seems very wrong to print a warning
> and BUG() instead of disabling the interrupt only if napi can be
> scheduled... Maybe is very old code? The more I see this the more I see
> problem... (randomly disabling the interrupt and then make the kernel
> die)

I am pretty sure this BUG() can be hit these days with busy polling or
setting gro_flush_timeout.

I wish we could remove these bugs before someone copy-paste them.

Again, this is orthogonal, I might simply stop doing reviews if this
is not useful.
