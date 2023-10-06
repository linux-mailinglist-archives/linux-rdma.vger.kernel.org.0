Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478617BBEF4
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Oct 2023 20:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjJFStr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Oct 2023 14:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjJFStq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Oct 2023 14:49:46 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96221CE;
        Fri,  6 Oct 2023 11:49:44 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4064867903cso23648685e9.2;
        Fri, 06 Oct 2023 11:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696618183; x=1697222983; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J8TnZukIluCCYT6M1BV1r+HvisyoMBi+KKDF01G+Mhg=;
        b=M+VuO8kI5wZUDXLEV6RujN0d4RyRfRhwuuqxrt5xrHfHfn3YNP6rk+RqNVTtDtyMnj
         /weoqEDta1TErA2m3SK5LnJPLm9ZOlvk0hNgyb64q7SIIWgGxgG6GMErgFShx3FlOPrR
         M1vJ6FhqKHQJDOvfK/qkfDFC8gU+RD55LhGYOh8ih6s5Hp7oNfCZAIIpng0ez4XaFTgr
         6QQkR2xcLWYA64VcrPG+IQYDtoyCiGrAvQQgdwFxgcqqrv+dK/EhJAJdU2QrcmYMPD/k
         TYSQ5iz9GIW8BE7Avzxopo+Urxd6kMBrODndeoKBYy4s9+fiSeBZvnBkPozo7/qCsB9w
         PK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618183; x=1697222983;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J8TnZukIluCCYT6M1BV1r+HvisyoMBi+KKDF01G+Mhg=;
        b=jzvLhBScqiquwVYSN7AK446RuiYk8DgsflAm+dwf2g0zsJ85l+vaOKGusL265wA19a
         P4SLmFhu3ecwTLFUZPuk7Nc73tKOANWG+bQ8lWiHO6mwGk56f6a7PEvUIVPaJyQz9kV2
         EaXmByuGYCJgvdLHWQCkxmf6gB4SpRq+GxD8sQ0oFTWnY/xjKsjsNFLIpxVxZ2rxh6hM
         vkmCjH3/mdd5TD9gz1YtbmSiRjw0XAI1Ukzob4mFKR+LsyV6NCQihTkyTZN6XcCZ7sfT
         AnXhCUYn8FWXv+MsFP28/G9q9PYz50SxSRIXeVBvEAiy/i0//Gdh0mofLjNcHypCkyHa
         MXXw==
X-Gm-Message-State: AOJu0YyPuSmyWHivwk1mcMPmeKq5lzFOvs2VjggLWdxZ7+tin8hh9cZs
        2ACU3b4S5PkkSy5qDIkrbRA=
X-Google-Smtp-Source: AGHT+IGnyXDNMYk8HFRpUEcTSZlI2oSIFcmKPz3Tef9zJ6V0zvxO56KtfzCWQ2oyr2OO4KuUJibc4g==
X-Received: by 2002:a05:6000:48:b0:31f:f8a5:15db with SMTP id k8-20020a056000004800b0031ff8a515dbmr8155280wrx.48.1696618182580;
        Fri, 06 Oct 2023 11:49:42 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id p4-20020a5d68c4000000b003232f167df5sm2217218wrw.108.2023.10.06.11.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:49:41 -0700 (PDT)
Message-ID: <652056c5.5d0a0220.2b60d.c5dc@mx.google.com>
X-Google-Original-Message-ID: <ZSBWxW8ba8P0szfD@Ansuel-xps.>
Date:   Fri, 6 Oct 2023 20:49:41 +0200
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLtYZJPOQE7OkAbEdmhT8qjzAJ+27poa__3c8Nf0M6u_w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 05, 2023 at 06:16:26PM +0200, Eric Dumazet wrote:
> On Tue, Oct 3, 2023 at 8:36 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > Replace if condition of napi_schedule_prep/__napi_schedule and use bool
> > from napi_schedule directly where possible.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/net/ethernet/atheros/atlx/atl1.c     | 4 +---
> >  drivers/net/ethernet/toshiba/tc35815.c       | 4 +---
> >  drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 4 +---
> >  3 files changed, 3 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
> > index 02aa6fd8ebc2..a9014d7932db 100644
> > --- a/drivers/net/ethernet/atheros/atlx/atl1.c
> > +++ b/drivers/net/ethernet/atheros/atlx/atl1.c
> > @@ -2446,7 +2446,7 @@ static int atl1_rings_clean(struct napi_struct *napi, int budget)
> >
> >  static inline int atl1_sched_rings_clean(struct atl1_adapter* adapter)
> >  {
> > -       if (!napi_schedule_prep(&adapter->napi))
> > +       if (!napi_schedule(&adapter->napi))
> >                 /* It is possible in case even the RX/TX ints are disabled via IMR
> >                  * register the ISR bits are set anyway (but do not produce IRQ).
> >                  * To handle such situation the napi functions used to check is
> > @@ -2454,8 +2454,6 @@ static inline int atl1_sched_rings_clean(struct atl1_adapter* adapter)
> >                  */
> >                 return 0;
> >
> > -       __napi_schedule(&adapter->napi);
> > -
> >         /*
> >          * Disable RX/TX ints via IMR register if it is
> >          * allowed. NAPI handler must reenable them in same
> > diff --git a/drivers/net/ethernet/toshiba/tc35815.c b/drivers/net/ethernet/toshiba/tc35815.c
> > index 14cf6ecf6d0d..a8b8a0e13f9a 100644
> > --- a/drivers/net/ethernet/toshiba/tc35815.c
> > +++ b/drivers/net/ethernet/toshiba/tc35815.c
> > @@ -1436,9 +1436,7 @@ static irqreturn_t tc35815_interrupt(int irq, void *dev_id)
> >         if (!(dmactl & DMA_IntMask)) {
> >                 /* disable interrupts */
> >                 tc_writel(dmactl | DMA_IntMask, &tr->DMA_Ctl);
> > -               if (napi_schedule_prep(&lp->napi))
> > -                       __napi_schedule(&lp->napi);
> > -               else {
> > +               if (!napi_schedule(&lp->napi)) {
> >                         printk(KERN_ERR "%s: interrupt taken in poll\n",
> >                                dev->name);
> >                         BUG();
> 
> Hmmm... could you also remove this BUG() ? I think this code path can be taken
> if some applications are using busy polling.
> 
> Or simply rewrite this with the traditional
> 
> if (napi_schedule_prep(&lp->napi)) {
>    /* disable interrupts */
>    tc_writel(dmactl | DMA_IntMask, &tr->DMA_Ctl);
>     __napi_schedule(&lp->napi);
> }
> 
>

Mhhh is it safe to do so? I mean it seems very wrong to print a warning
and BUG() instead of disabling the interrupt only if napi can be
scheduled... Maybe is very old code? The more I see this the more I see
problem... (randomly disabling the interrupt and then make the kernel
die)

> 
> > diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
> > index 23b5a0adcbd6..146bc7bd14fb 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
> > @@ -1660,9 +1660,7 @@ irqreturn_t iwl_pcie_irq_rx_msix_handler(int irq, void *dev_id)
> >         IWL_DEBUG_ISR(trans, "[%d] Got interrupt\n", entry->entry);
> >
> >         local_bh_disable();
> > -       if (napi_schedule_prep(&rxq->napi))
> > -               __napi_schedule(&rxq->napi);
> > -       else
> > +       if (!napi_schedule(&rxq->napi))
> >                 iwl_pcie_clear_irq(trans, entry->entry);
> 
> Same remark here about twisted logic.
> 

Ehhh here we need to be careful... We can do the usual prep/__schedule
with the DMA disable in between...

From the comments of iwl_pcie_clear_irq.

	/*
	 * Before sending the interrupt the HW disables it to prevent
	 * a nested interrupt. This is done by writing 1 to the corresponding
	 * bit in the mask register. After handling the interrupt, it should be
	 * re-enabled by clearing this bit. This register is defined as
	 * write 1 clear (W1C) register, meaning that it's being clear
	 * by writing 1 to the bit.
	 */

So the device disable the interrupt after being fired and the bit needs
to set again for the interrupt to be reenabled. So the function
correctly reenable the irq if a napi can't be scheduled... Think there
isn't another way to handle this.

> >         local_bh_enable();
> >
> > --
> > 2.40.1
> >

-- 
	Ansuel
