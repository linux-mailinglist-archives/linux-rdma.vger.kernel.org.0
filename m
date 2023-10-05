Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D9D7BA61F
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Oct 2023 18:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjJEQ1p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Oct 2023 12:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243477AbjJEQWy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Oct 2023 12:22:54 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769271BF9
        for <linux-rdma@vger.kernel.org>; Thu,  5 Oct 2023 09:16:40 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so15990a12.0
        for <linux-rdma@vger.kernel.org>; Thu, 05 Oct 2023 09:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696522598; x=1697127398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaaqTDoZqbafDQ3l5zFKWxmU6cOLxM0ZIJSzVNTzttI=;
        b=pBanUm71ICytkySd7ssQu81m990I3+BLnwYzRiL6TltMvvKuykTTF08MNB5w6+x1Z4
         tET1HrckbF7IhqBt138j/ON0Cdqqm/yOWYnSQtXBiLQW3RRKk703v+ajvZmZFkpWXLzv
         5GFaukBKBOSzg7JcaupQTAK6Kkh+8pmMxDAvJlurz9DdkMEo+1NzvnpsBk5r0c7rERYX
         VwEVZsACBLEN9c6CuEhEWhjaQe/eaIlbgJ0GhlUWqdpRPDPAg8EGycEvju1ld9xa6eRy
         Ev24pZiVRJqgtwLbJS9hHZ+3qiiisFEuurJYJzFhV5Kr/CQNBtgkQvp7J3BIYJNoKTB0
         QoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696522598; x=1697127398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LaaqTDoZqbafDQ3l5zFKWxmU6cOLxM0ZIJSzVNTzttI=;
        b=kWE6boui0A5hYjWDQAWMsRr++0mhbAkBg24/DVCS6WJ5eOb6dIm5CURBppLy8nA/bf
         pD1QUrZ6/xt/xOgh1lfdSB/n/Mavrx6MPPKxMlu5JjXKBN6EBeWgwNB5KjUkxL51XytD
         nNXFUURcL1A9KfTKec4Fjj/FEDQY/eHcHbEt7FDywgAS38A0G6hTQLJD0aWOZJ23hNvo
         3uiTTdK+O5BZcMHtHFXKJxBYj9c1cEVOzLAtSzZ/EiPwwXEGL5SrcFEz5DK2L+bbIQW0
         H8kJiZSkP9wfDplDxtMNbWPC0Mx4gCPr14FU7XLt0D96TkxIP2NJwGWjYNqmCH2jGgwt
         qPbg==
X-Gm-Message-State: AOJu0YyXNRLNvBRAwTpt7/4FXywso3Ug6M1/v4jYYqpJoe6Zq7V9Em2Y
        U6A1JtgnL3vp2kMBYPy+X6BYFxS0sYcxMFGQLBP1sg==
X-Google-Smtp-Source: AGHT+IF0jOJDhaZhmEhxxLATvP2gGYnCETDcm8l2Y4huhZvHpOvz7u8otUILcV3a8DA5O+J6BhBCfMIuLNxeTSP/Dy0=
X-Received: by 2002:a50:8d5a:0:b0:538:2941:ad10 with SMTP id
 t26-20020a508d5a000000b005382941ad10mr73466edt.5.1696522598066; Thu, 05 Oct
 2023 09:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231003145150.2498-1-ansuelsmth@gmail.com> <20231003145150.2498-4-ansuelsmth@gmail.com>
In-Reply-To: <20231003145150.2498-4-ansuelsmth@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 5 Oct 2023 18:16:26 +0200
Message-ID: <CANn89iLtYZJPOQE7OkAbEdmhT8qjzAJ+27poa__3c8Nf0M6u_w@mail.gmail.com>
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

On Tue, Oct 3, 2023 at 8:36=E2=80=AFPM Christian Marangi <ansuelsmth@gmail.=
com> wrote:
>
> Replace if condition of napi_schedule_prep/__napi_schedule and use bool
> from napi_schedule directly where possible.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/ethernet/atheros/atlx/atl1.c     | 4 +---
>  drivers/net/ethernet/toshiba/tc35815.c       | 4 +---
>  drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 4 +---
>  3 files changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ether=
net/atheros/atlx/atl1.c
> index 02aa6fd8ebc2..a9014d7932db 100644
> --- a/drivers/net/ethernet/atheros/atlx/atl1.c
> +++ b/drivers/net/ethernet/atheros/atlx/atl1.c
> @@ -2446,7 +2446,7 @@ static int atl1_rings_clean(struct napi_struct *nap=
i, int budget)
>
>  static inline int atl1_sched_rings_clean(struct atl1_adapter* adapter)
>  {
> -       if (!napi_schedule_prep(&adapter->napi))
> +       if (!napi_schedule(&adapter->napi))
>                 /* It is possible in case even the RX/TX ints are disable=
d via IMR
>                  * register the ISR bits are set anyway (but do not produ=
ce IRQ).
>                  * To handle such situation the napi functions used to ch=
eck is
> @@ -2454,8 +2454,6 @@ static inline int atl1_sched_rings_clean(struct atl=
1_adapter* adapter)
>                  */
>                 return 0;
>
> -       __napi_schedule(&adapter->napi);
> -
>         /*
>          * Disable RX/TX ints via IMR register if it is
>          * allowed. NAPI handler must reenable them in same
> diff --git a/drivers/net/ethernet/toshiba/tc35815.c b/drivers/net/etherne=
t/toshiba/tc35815.c
> index 14cf6ecf6d0d..a8b8a0e13f9a 100644
> --- a/drivers/net/ethernet/toshiba/tc35815.c
> +++ b/drivers/net/ethernet/toshiba/tc35815.c
> @@ -1436,9 +1436,7 @@ static irqreturn_t tc35815_interrupt(int irq, void =
*dev_id)
>         if (!(dmactl & DMA_IntMask)) {
>                 /* disable interrupts */
>                 tc_writel(dmactl | DMA_IntMask, &tr->DMA_Ctl);
> -               if (napi_schedule_prep(&lp->napi))
> -                       __napi_schedule(&lp->napi);
> -               else {
> +               if (!napi_schedule(&lp->napi)) {
>                         printk(KERN_ERR "%s: interrupt taken in poll\n",
>                                dev->name);
>                         BUG();

Hmmm... could you also remove this BUG() ? I think this code path can be ta=
ken
if some applications are using busy polling.

Or simply rewrite this with the traditional

if (napi_schedule_prep(&lp->napi)) {
   /* disable interrupts */
   tc_writel(dmactl | DMA_IntMask, &tr->DMA_Ctl);
    __napi_schedule(&lp->napi);
}



> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/w=
ireless/intel/iwlwifi/pcie/rx.c
> index 23b5a0adcbd6..146bc7bd14fb 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
> @@ -1660,9 +1660,7 @@ irqreturn_t iwl_pcie_irq_rx_msix_handler(int irq, v=
oid *dev_id)
>         IWL_DEBUG_ISR(trans, "[%d] Got interrupt\n", entry->entry);
>
>         local_bh_disable();
> -       if (napi_schedule_prep(&rxq->napi))
> -               __napi_schedule(&rxq->napi);
> -       else
> +       if (!napi_schedule(&rxq->napi))
>                 iwl_pcie_clear_irq(trans, entry->entry);

Same remark here about twisted logic.

>         local_bh_enable();
>
> --
> 2.40.1
>
