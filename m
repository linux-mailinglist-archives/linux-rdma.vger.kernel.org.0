Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B745E7B67B4
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Oct 2023 13:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjJCLSv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Oct 2023 07:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239986AbjJCLSu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Oct 2023 07:18:50 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CB9BB;
        Tue,  3 Oct 2023 04:18:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40566f8a093so7475905e9.3;
        Tue, 03 Oct 2023 04:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696331917; x=1696936717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dRmt6j5dxjz0MCUrCJcyD2cXKQxyJFJdm8ATGNw+KGc=;
        b=XzeQcODl+S0VoX5SHWpA+1Vy+J0EfHQgYFF4wHCFJseWYhVH6qEK29CY9KFGrEzPjN
         MGKiSrLdgE7kLC97WI3EGNbeHUw6kVmIZ9X38gZuiN6j4MaJzA2Emm2Fzeo33ngodS1N
         WNr8jbRY2cXpqsZa/pUyFN7dBClcN1c7Y9SeAMMTz8ozcbryByWVH1LwcuCxN97ri5uQ
         B5zY48CmpkJ5S4Vf9zLqc8vO76Ock9kcn0jqfU4lx17h/eCaOMjRozu70uXcMMhNrwWP
         /ZeqtOvmBFrwt2Ulg8lBsMQa1tOQcgkWP9jmpgKtRcztp9xnpE8zCsrmfug31HAhU6BL
         J8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696331917; x=1696936717;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRmt6j5dxjz0MCUrCJcyD2cXKQxyJFJdm8ATGNw+KGc=;
        b=a9Ls4+Rmk6QWdPBo1Zbm3RxZ1Dvny43CmZSJvHpi8zmVfd7iA2Oa93EpmjS5eQaeNV
         VJyg5Ps3O1lASUce82bfJM0EluQa/DQG7axyEUvEt19CehAYdK8PomsiNSNlEdI6zu7W
         15iNR0R29gFcJkc7k8NeP7x6COaEWxaFpHl+jXwf0uOt3PoM5YT+WSS2JN4cmOWhVFQF
         8W4rccLOedregl31F1bvqH9DV/MneqxSRA7J6ByR0sebzkmf4W8OS7rNtJpxk+tPznCH
         vwTYZp+KNdD9Ws4sHm6TJgPYY/moJ8bCyDr4wZDYVmJSjTREkrT4HMwJuodccOsrxg1I
         ppWw==
X-Gm-Message-State: AOJu0Yz6GZwRoawJH/fa8LBS3FLZCnulP0bCZlb7o2yv3Y1wJw93f2tk
        CAdIADeZUryISqxojprQMB0=
X-Google-Smtp-Source: AGHT+IFLbiLzMIjYq17N9d6C9xhiAG+ijgYatVYbYzZACplv9aboPtXUhqao5fQwPpvl9QyVVVJ1HA==
X-Received: by 2002:a7b:ce89:0:b0:402:f07c:4b48 with SMTP id q9-20020a7bce89000000b00402f07c4b48mr11269565wmj.28.1696331917146;
        Tue, 03 Oct 2023 04:18:37 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id y24-20020a05600c365800b0040652e8ca13sm9195716wmq.43.2023.10.03.04.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 04:18:36 -0700 (PDT)
Message-ID: <651bf88c.050a0220.3a982.31fc@mx.google.com>
X-Google-Original-Message-ID: <ZRv4iZmOuLubYSiN@Ansuel-xps.>
Date:   Tue, 3 Oct 2023 13:18:33 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Chris Snook <chris.snook@gmail.com>,
        Raju Rangoju <rajur@chelsio.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Shailend Chand <shailend@google.com>,
        Douglas Miller <dougmill@linux.ibm.com>,
        Nick Child <nnac123@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
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
        Wei Fang <wei.fang@nxp.com>, Alex Elder <elder@linaro.org>,
        Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
        Bailey Forrest <bcf@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Junfeng Guo <junfeng.guo@intel.com>,
        Ziwei Xiao <ziweixiao@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rushil Gupta <rushilg@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Yuri Karpov <YKarpov@ispras.ru>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Zheng Zengkai <zhengzengkai@huawei.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lee Jones <lee@kernel.org>, Dawei Li <set_pte_at@outlook.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Benjamin Berg <benjamin.berg@intel.com>,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [net-next PATCH 3/4] netdev: replace napi_reschedule with
 napi_schedule
References: <20231002151023.4054-1-ansuelsmth@gmail.com>
 <20231002151023.4054-3-ansuelsmth@gmail.com>
 <20231003-living-seltzer-172ea6aec629-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003-living-seltzer-172ea6aec629-mkl@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 03, 2023 at 09:16:33AM +0200, Marc Kleine-Budde wrote:
> On 02.10.2023 17:10:22, Christian Marangi wrote:
> > Now that napi_schedule return a bool, we can drop napi_reschedule that
> > does the same exact function. The function comes from a very old commit
> > bfe13f54f502 ("ibm_emac: Convert to use napi_struct independent of struct
> > net_device") and the purpose is actually deprecated in favour of
> > different logic.
> > 
> > Convert every user of napi_reschedule to napi_schedule.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/infiniband/ulp/ipoib/ipoib_ib.c                |  4 ++--
> >  drivers/net/can/dev/rx-offload.c                       |  2 +-
> 
> Acked-by: Marc Kleine-Budde # for can/dev/rx-offload.c

Just to make sure can I use the correct tag: (you didn't include the
mail)

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de> # for can/dev/rx-offload.c

?

-- 
	Ansuel
