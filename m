Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF44972CDAC
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 20:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbjFLSQn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 14:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237415AbjFLSQl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 14:16:41 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C304E73
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 11:16:40 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f9dd2fabe2so1409611cf.3
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 11:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1686593799; x=1689185799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CSNNtD+uLuYv9nmzTpbeMCfqzOJ+jjSwaoJb9/60IFY=;
        b=kMjXibD0dT1WnxLDRNzvxtdFWK18G0ro8YnUhV4611pocZCZnQHVROJEvrtMZWiwuB
         KT7ki2dAQo432XryBydHa9238V3WXuw85jF1aS8kXUvOnkP1/9Apcf4/AVe7TyiEdDfb
         vt+w189CJpY79/WVWRDv4xOv3OOjGNZxmcAMCaO6aEMlmHitWoLkbI6WmeWcK+0j77jj
         aZ5kBoGgN8ZSH6vWYcxrHtpTZo9lT/cDq2okXqGL3UdJBXgF2rEeUSZ0jaFaXO43z8ct
         R0hRJ8gkZLKAJTbi5Dpn1rlVnFECchaGeJ66MGSh/Q05HklJmAg8YW4xhg0RdqZrPvGF
         Ih1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686593799; x=1689185799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSNNtD+uLuYv9nmzTpbeMCfqzOJ+jjSwaoJb9/60IFY=;
        b=TIQ0jd+60WW/nIhID1+zBG628yZLEmjByZG8D+Nt+ik5IHgT9oQEpJklmPIoRu9yAX
         hCqI/1YKshNecErwmCiHZ4Xc8d+z4ip8evrSRvewFtwSFpCPqPHFTWIT5WAvwEJZvesQ
         gLoWwlsYagJ0nfLH9qulMIqiEpN5gSaJL1PreGy3h4n01OGMxGYtXeZlvPAawM+vjor9
         cMleYmE6PahHUShaSbf1Fujzck53m/izpVXFA2DTdzRQKlgElv11n+IqHkEkKWC5dIwU
         FtAciCB6TSfM5Cufvqv1RqGRQh4UOQ0FYkXE/PFRvc3DnX39xofuf9ao1nas5YK6AP0z
         wPig==
X-Gm-Message-State: AC+VfDyoEvsj7E5sRv4u7wq+yLsfvdbQDuLKyfeRRYriSHTec1sJ2tSC
        JuD2CTQuq21I+i3EvG6/qkqhaw==
X-Google-Smtp-Source: ACHHUZ56PLfbA1IsbtQ4tzlNdBNTVPqZZyyRiNfrvp+Ra3DOcBiDzJJB/sLUzltmV2qMRWikkyD4ag==
X-Received: by 2002:a05:622a:1301:b0:3f9:a73b:57a2 with SMTP id v1-20020a05622a130100b003f9a73b57a2mr9983956qtk.26.1686593799273;
        Mon, 12 Jun 2023 11:16:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id a22-20020ac844b6000000b003f6c9f8f0a8sm3559539qto.68.2023.06.12.11.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:16:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q8m5m-004idI-5Q;
        Mon, 12 Jun 2023 15:16:38 -0300
Date:   Mon, 12 Jun 2023 15:16:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Leon Romanovsky <leon@kernel.org>, Wei Hu <weh@microsoft.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>
Subject: Re: [PATCH v2 1/1] RDMA/mana_ib: Add EQ interrupt support to mana ib
 driver.
Message-ID: <ZIdhBtz/++OoyhyR@ziepe.ca>
References: <20230606151747.1649305-1-weh@microsoft.com>
 <20230607213903.470f71ae@kernel.org>
 <SI2P153MB0441DAC4E756A1991A03520FBB54A@SI2P153MB0441.APCP153.PROD.OUTLOOK.COM>
 <20230612061349.GM12152@unreal>
 <20230612102221.2ca726fd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612102221.2ca726fd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 12, 2023 at 10:22:21AM -0700, Jakub Kicinski wrote:
> On Mon, 12 Jun 2023 09:13:49 +0300 Leon Romanovsky wrote:
> > > Thanks for you comment. I am  new to the process. I have a few
> > > questions regarding to this and hope you can help. First of all,
> > > the patch is mostly for IB. Is it possible for the patch to just go
> > > through the RDMA branch, since most of the changes are in RDMA?   
> > 
> > Yes, it can, we (RDMA) will handle it.
> 
> Probably, although it's better to teach them some process sooner
> rather than later?

I've been of the opinion the shared branch process is difficult - we
took a long time to fine tune the process. If you don't fully
understand how to do this with git you can make a real mess of it.

So I would say MS is welcome to use it if they can do it right, but I
wouldn't push them to do so or expect they must to be
successful. Really only Mellanox and Intel seem to have enough churn
to justify it right now.

If they don't use shared branches then they must be responsible to
avoid conflicts, even if that means they have to delay sending patches
for a cycle.

Jason
