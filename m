Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C89352623C
	for <lists+linux-rdma@lfdr.de>; Fri, 13 May 2022 14:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243807AbiEMMqL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 May 2022 08:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbiEMMqJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 May 2022 08:46:09 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C61425EBC
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 05:46:04 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id c8so6557788qvh.10
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 05:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DWaM9OjdKwfaw9hmae0/D9Fi6TSW0/LHzUqdAzswbUs=;
        b=HcA2xKvupPMJ001ENwB9G4cod0MVM+tBBnAntjIG9yTDjALnT3Ugqve0rZA/rt84dB
         I/NW9uQWBEZ5DsGGW9HO9OLlhjGFG+Bs76ABLnuaRPHxOijd8jtSxI1cMYkhle5bnbMu
         HuPQTwMbk+Swx/whSOrJwoYW86AXLMfJzNdFs3AEKP629apNBpDqU5rn4Iah2LPBbRX5
         /zTb+T1PEvOcKZuZwfy9x+XvHYenMtrwSMWIculA0idmwMCr+vFoXKQr4rx8b5vBbUDV
         jO2ogRSnVysYylQsuCwJTx7lTcB+nxJwMyFurY+S7guNsxX3w043vOuGmGMmr0jqPyHl
         Hxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DWaM9OjdKwfaw9hmae0/D9Fi6TSW0/LHzUqdAzswbUs=;
        b=k2V4lGNjHlD9uLuUJvAYKtCwiclDMjkBLGH2o/W9R307d5q3TIV+VsEJn2IXWZpRcX
         V6pr/3r/jVsO0Jv8T7xG5BXJlj5m3hYo4mpaZXwV4D+SKOaF79aLSHbcXnmw1DzVfOiU
         S4lZ3e8apJX1K3eWpUyPQTSOXAhX73GM+QSFJ4eOvDDR8VCTqCNMA56kzUpoBpzTOTHV
         ISsMbc1IEjudMsD7txOUcNvuWYOA2eKwz1HeEHeIkAjumkko9RHAO0Z+lblP+6c1HTnO
         2/VDslb1RSlA3zOxnmDxD2Nxy1zueDs+A5yI7Vqjunm1sJTiRoR6PivGySzL72sbnByc
         TFpg==
X-Gm-Message-State: AOAM531WIcWT5rpix3XFV1Rpxl1d890NNoaYnFiEvukZGqzYkUJ3ZGvb
        T+Ie8cm2GD3LoqAK+3Fib1uUlDMWvCtXNw==
X-Google-Smtp-Source: ABdhPJwSMqf0vkyd0YS4xt8yoaBwSCiiO/Q1m2kKkhcIdIVVD4Z4Be6SOuxVgHyEYFKY9f+7VgFWoQ==
X-Received: by 2002:a05:6214:19c5:b0:45a:e0e5:d37b with SMTP id j5-20020a05621419c500b0045ae0e5d37bmr4236467qvc.100.1652445963796;
        Fri, 13 May 2022 05:46:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id t11-20020ac86a0b000000b002f39b99f66csm1427963qtr.6.2022.05.13.05.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 05:46:03 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1npUgD-00679g-To; Fri, 13 May 2022 09:46:01 -0300
Date:   Fri, 13 May 2022 09:46:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Anand Ashok Khoje <anand.a.khoje@oracle.com>,
        Linux RDMA <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>
Subject: Re: [RFC] Adding private data and private data len as argument to
 rdma_disconnect()
Message-ID: <20220513124601.GD63055@ziepe.ca>
References: <057cdabf-997b-6f4a-6877-0be89254166b@oracle.com>
 <22a2ee27-fe80-fc64-6838-0dd272288c46@oracle.com>
 <BYAPR15MB26310745FFF0D04D6E73822199CA9@BYAPR15MB2631.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR15MB26310745FFF0D04D6E73822199CA9@BYAPR15MB2631.namprd15.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 13, 2022 at 09:39:44AM +0000, Bernard Metzler wrote:

> Not all providers support the transfer of private data in control
> messages after connection establishment -
> rdma_reject()/rdma_accept() being the last opportunity to send
> private data in connections lifetime for e.g.  iWarp
> connections. Maybe that is why it is not exposed at the disconnect
> API call? Would RoCE support it?

RoCE and IB have a place to put it, IB does not.

The lack of support in iWarp is problematic, these APIs are supposed
to be fairly high level things.

We clearly can't just extend the existing rdma_disconnect() due to
this, and some kind of negotiation would be needed so the ULP can
learn if the extra data is supported at all.

Jason
