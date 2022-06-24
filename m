Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D98055A4EC
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jun 2022 01:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiFXXj5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jun 2022 19:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiFXXj5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jun 2022 19:39:57 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480B189D18
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jun 2022 16:39:56 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id k10so2975670qke.9
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jun 2022 16:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y2pv8YOw7LoyOnTaoRSaYSE/K+AgHwp4S93jltd2ta4=;
        b=RWvu/9BtyVhWJ4BEZH1HhUaocZB2WaT+pDmddvDyO3Uey8LzWrDmXYFK3ikFeHnmOT
         huuTxnOW4ws1HNHe39aE/K+Ug7o9lij4HcA+av2ccc2R8rJIS6qbiitu5rlyHNEXabBV
         lixZw0Qc7jn6jUnKszJPTPNlyDI7kwswCey8tRF/ozRvgeQuA8NlWA0x9uhTmn3Kgbhb
         lxM9CPQ6B7qvyvGxx8wULXeF+DyT+t03EdDRBSWDa/JpYaf0Z0NmgbhPGck/TT946YlO
         ufHKkU1NO2VgS9lEYxwEmDaQsD7ikd9eL++4EVz4InYogQZ19Xjl/9OA3IWR7VoGl3tJ
         aOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y2pv8YOw7LoyOnTaoRSaYSE/K+AgHwp4S93jltd2ta4=;
        b=k0GuSzUHBQEGY4WtHYVRYlcXOELyvFcTyJ8vH2qrKVFjyJ2Yz2FL6ax9AS0wY+mQNN
         48Yf/Uj5RrENQlv+lInpU2OZF39Fxhc1AaNdFXJXDAHrULjhXqC4FM/zAWgzQsxXt9hu
         DFnXevsdLItLkxHkIa+9OFaZCXAD8gbqXjAh+wRxQp+4vB839zjldzU4Fv6MEPq+qD6U
         l7HinKXXtQektVOa/OiXjJCWcx7bXJa2Zfwn3TSHahyVIgQDsW0Cltr3Q/k+vlLgqFTC
         v1UTsSO6heDglfkQXMparrIWsE9VR0rwA+f7XNVQB+BgBZ3bid51wBMZvLaOar1SFTA9
         iwHw==
X-Gm-Message-State: AJIora8sq9kkf8ptJ1hcDE8Iuc1Xuj85FFYznvZQEQzb3vThf/VzthjF
        yMIvgKUzs2Q/c6mv313CCmA8dTLdkUIXNw==
X-Google-Smtp-Source: AGRyM1sK4qOyKaZbIItE1duiEeEZCbnTPGEfQHKnqE7VPJVOFEKwmTQqSYeRYqwfx8ZhCfZso8zbxg==
X-Received: by 2002:a05:620a:2552:b0:67b:32e2:2400 with SMTP id s18-20020a05620a255200b0067b32e22400mr1273453qko.768.1656113995455;
        Fri, 24 Jun 2022 16:39:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id bq24-20020a05622a1c1800b00304e95ec0fbsm2151911qtb.89.2022.06.24.16.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 16:39:54 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o4su2-001HtO-0I; Fri, 24 Jun 2022 20:39:54 -0300
Date:   Fri, 24 Jun 2022 20:39:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        Cheng Xu <chengyou@linux.alibaba.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] RDMA/rxe: Fix no completion event issue
Message-ID: <20220624233953.GG23621@ziepe.ca>
References: <20220516015329.445474-1-lizhijian@fujitsu.com>
 <fa9863f0-d42e-f114-5321-108dda270e27@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa9863f0-d42e-f114-5321-108dda270e27@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 07, 2022 at 08:32:40AM +0000, lizhijian@fujitsu.com wrote:
> Hi Json & Yanjun
> 
> 
> I know there are still a few regressions on RXE, but i do wish you
> could take some time to review these *simple and bugfix* patches
> They are not related to the regressions.

I would like someone familiar with rxe to ack the datapath changes - I
have a very limited knowledge about rxe.

If that is not forthcoming from others in the rxe community then I
will accept confirmation directly from you that the pyverbs tests and
the blktests scenarios have been run and pass for your changes.

Jason
