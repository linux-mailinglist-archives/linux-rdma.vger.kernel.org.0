Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BD87BBF38
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Oct 2023 20:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjJFSyn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Oct 2023 14:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjJFSyl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Oct 2023 14:54:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B83125;
        Fri,  6 Oct 2023 11:52:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-317c3ac7339so2172481f8f.0;
        Fri, 06 Oct 2023 11:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696618378; x=1697223178; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X70lVOFCcfRrz5BPTne6oD5pXVKA4lkjxXDB0TaolDY=;
        b=EtTHJ7bh7i2ZFGjdOIyW6uq1bhu+psU/u9RnXVZwwMHbTV7UZxGoYE8vnv2riL7bwc
         fuPuZq7pDtRvAPNWxCFN/s7S/FSz5JveMSRDhFrBi1eo68QWfxGuBR4wYWF5MsZ86mXG
         1ZBFudI4YduVH7oqLrqh8sG/RwHZ0v5SHjtmSWutZRYDuL9TML4yqrs4UZubGv5JpiIg
         iHK2aQIPrCmyWnJXvpGDQ5tVCSP1LrKCpWD1+zWkbb+EVrbRUrHVZ+44Ant/76nupM+c
         cvlHDd4xhTueioZoCiPNNLpe7GK87rUfEZX2kJyDkSiF2nuhelG2aaPaYZxm8VuGfuqU
         M1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618378; x=1697223178;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X70lVOFCcfRrz5BPTne6oD5pXVKA4lkjxXDB0TaolDY=;
        b=RT7l6vK8xZbyEPMiGYQ4CCwU+1PLonOaL1JWKtXj67Hrkpqvwn5/s2ovq00r06NR+n
         vwDBb54kRX4D0KznWNhKjsTsyEycEQfm2b5RRsNJLICNpjsqHoswmV3bRujTqgAo7w8S
         arAhnp4+k7IXgkWbOakhgvIMDzK526lwvhoAoZlUxJ9BFs3igtwToeXUqpP/xq2kWjQv
         MP+8LUTBlAEU0xdLZbifdS8loORnL5NdmPclD5KJK5oxu5GnOJIt3hyMPXUd/VWiAB8U
         +zggeE7g4YDVuAWAP20TtWGUyPlmkmYtZsQvcqKJ0gvhLx/JgQt4Kk6BZZeUi0nrS2BG
         ZAyg==
X-Gm-Message-State: AOJu0Yw/SGRJstUMfsVzPyOyM7wBmj7vdRs7MI44wkVxcF4FoVZTzEjM
        e1HvLAvZyyR0vpQHAZLCxKk=
X-Google-Smtp-Source: AGHT+IG8xdl5PYYzmkg371/9IVLxOcEUg0/AO4c3FMmCpHBI1rBYraaud13cZvVNCZmgDH81LCr6PA==
X-Received: by 2002:a5d:4d8e:0:b0:324:7bdd:678e with SMTP id b14-20020a5d4d8e000000b003247bdd678emr7728648wru.60.1696618377892;
        Fri, 06 Oct 2023 11:52:57 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id h9-20020a5d5489000000b003179d5aee67sm2231805wrv.94.2023.10.06.11.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:52:57 -0700 (PDT)
Message-ID: <65205789.5d0a0220.7e49b.ccb0@mx.google.com>
X-Google-Original-Message-ID: <ZSBXiecYhFuSdjkC@Ansuel-xps.>
Date:   Fri, 6 Oct 2023 20:52:57 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
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
Subject: Re: [net-next PATCH v2 3/4] netdev: replace napi_reschedule with
 napi_schedule
References: <20231003145150.2498-1-ansuelsmth@gmail.com>
 <20231003145150.2498-3-ansuelsmth@gmail.com>
 <CANn89iK226C-pHUJm7HKMyEtMycGC=KCA2M6kw2KJaUj0cCT6w@mail.gmail.com>
 <20231005093253.2e25533a@kernel.org>
 <CANn89iJQ50AdXP2C1YB2pGjE02WCJ-QCsZqE1yGXtcGsfLA0Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJQ50AdXP2C1YB2pGjE02WCJ-QCsZqE1yGXtcGsfLA0Jw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 05, 2023 at 06:41:03PM +0200, Eric Dumazet wrote:
> On Thu, Oct 5, 2023 at 6:32 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Thu, 5 Oct 2023 18:11:56 +0200 Eric Dumazet wrote:
> > > OK, but I suspect some users of napi_reschedule() might not be race-free...
> >
> > What's the race you're thinking of?
> 
> This sort of thing... the race is in fl_starving() though...
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c
> b/drivers/net/ethernet/chelsio/cxgb4/sge.c
> index 98dd78551d89..b5ff2e1a9975 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
> @@ -4261,7 +4261,7 @@ static void sge_rx_timer_cb(struct timer_list *t)
> 
>                         if (fl_starving(adap, fl)) {
>                                 rxq = container_of(fl, struct sge_eth_rxq, fl);
> -                               if (napi_reschedule(&rxq->rspq.napi))
> +                               if (napi_schedule(&rxq->rspq.napi))
>                                         fl->starving++;
>                                 else
>                                         set_bit(id, s->starving_fl);

Ehhh problem is that this is a simple rename so if any race is present,
it's already there and not caused by this rename :(

Don't know maybe this is out of scope and should be investigated with a
bug report?

Maybe this should be changed to prep/__schedule to prevent any kind of
race? But doing so doesn't prevent any kind of ""starving""?

-- 
	Ansuel
