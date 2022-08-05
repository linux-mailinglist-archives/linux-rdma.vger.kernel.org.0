Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F9958AA8F
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Aug 2022 14:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240659AbiHEMMF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Aug 2022 08:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237402AbiHEMMF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Aug 2022 08:12:05 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53DE1CB11
        for <linux-rdma@vger.kernel.org>; Fri,  5 Aug 2022 05:12:03 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id c24so1679215qkm.4
        for <linux-rdma@vger.kernel.org>; Fri, 05 Aug 2022 05:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=NLuM7OZKOz5FFjWijTo8ZvMN/Xtj0gh5NxFFZEJ2Cy4=;
        b=KPUIiM4FfxE3Lm8aI3URA7SHJE+Xq3v/CvFkZnB3q+3roQJ3Iffj/hlr9GE+L5SCaL
         xRokJZqSsN3dRUJlW+eUtvGe0NEiwQDudwOQTuHXYH4/UV/ijWSOpBjcIkN9GdVY1YFU
         /BcPIaS9oOANXQYzzYDlqGexAeP+S9sQAMnT1PqlTDBmCcLtD+uJgjCOnekvbfO3Vd/s
         eRT4bO5c6ljhM7jOgpfHvxelqsB0mnbugc8x1cqkDW7YXE/Z7T2lGm1CIFZSRco9YAWu
         IkegWDwYIvKUeG6d+E62BgPWB+HX8YIeXuO/LNOI04dgAC9ZPa57c3fvGU6fKeNbs8Cg
         GmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=NLuM7OZKOz5FFjWijTo8ZvMN/Xtj0gh5NxFFZEJ2Cy4=;
        b=cOlOaK5YI5+5LtKv7+3cZk+6MGvwYkxPGH4CD+1gBtBiX72A0/Q68LoMyE+r3/L2nA
         erxLyTsxZCgZcw7sFz8vBLzbAJjJh9yMaVX1cCMkkbgReQk5HkHDFGZrfKAaaUGPynSl
         dZdxEgH103Jbwy4WnKz/yubDSlh4FbsjZQuoxmNHrWKh2MjsspcwUaPAcW+f2bYi1Hov
         VKbWo9i790lvPbjPkdz93hSKOBMeEyuOU/unncAnTCiMqzVitnuuFBcE5P+swQzvA3/2
         Sq4vrhJ27TPrAUhHS9CK/KKOe75hVVc+Y10C/mwUfUPOJYeqcK7GNwZjG8WvYGy6CpLo
         UFZw==
X-Gm-Message-State: ACgBeo0GqsYGpzaRG9G6XLaULJkr+hGdFM7gvvLpqg9ojvpBpq9u3ZAS
        56X6/1uCQuvyzk1Ba8qyao0uCw==
X-Google-Smtp-Source: AA6agR5UAYF2kzhSY+o8fjC/L53MzOBkaNyYqXvnGRAIaYG1QUNVycy0uOqjYouWgKMm/xxqG4m8KA==
X-Received: by 2002:a05:620a:10a3:b0:6b9:6b0:404f with SMTP id h3-20020a05620a10a300b006b906b0404fmr4786307qkk.469.1659701522998;
        Fri, 05 Aug 2022 05:12:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id s187-20020a37a9c4000000b006ab935c1563sm2494292qke.8.2022.08.05.05.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 05:12:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oJwBM-004G0W-Ei;
        Fri, 05 Aug 2022 09:12:00 -0300
Date:   Fri, 5 Aug 2022 09:12:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rxe: fix xa_alloc_cycle() error return value check again
Message-ID: <Yu0JEAbEyZ1UwSaQ@ziepe.ca>
References: <20220609070656.1446121-1-dzm91@hust.edu.cn>
 <YqrwibTkaDig+QfI@unreal>
 <46D857DC-26BB-44F4-954C-A42416B474EB@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46D857DC-26BB-44F4-954C-A42416B474EB@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 05, 2022 at 11:21:53AM +0000, William Kucharski wrote:
> I erroneously sent a duplicate of this patch last week because I didn't see the fix in the 5.19 kernel as of yet.
> 
> Do we know when it might be pulled into Linus' tree?

Yesterday

Jason
