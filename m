Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F281755A4D2
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jun 2022 01:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiFXX2N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jun 2022 19:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiFXX1v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jun 2022 19:27:51 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D3287D6A
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jun 2022 16:27:47 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id n15so6709985qvh.12
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jun 2022 16:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VexWYgSVrFnuR+Sk5ZCMwJ5dN4uE09gwny1KOadJJG8=;
        b=m0AQ+exknTteqJoGLRzq62e94PREFqoMq/C+eq5hfK5MO8uOvu7dYDi3DnRuOg3elC
         7yQEzNtCL6oYvTBvB2TFzGaBWMv52zrvkCvMLPVmUQFtC+djxpsk02ciU4sTnqL8bENH
         rLTcRa1Bvrdm8GEqETONt98C08iQg3U01p1vOZk5MZaOJCvLPTwuLxIlD1+Fu/6dE4E5
         5JH6vmRG5S+Ds0Lmsh0gL/qeeSims9UM2e7wCpdGRQxq7/rQPZUf199pFt1pGTupBHhv
         1kiVRTqWDWZ8u5hQhOPJhl3gB5OF5OuO9Wg3SFiG2rGW+aBMF8QKDolqTKkuHKOIW5al
         3SWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VexWYgSVrFnuR+Sk5ZCMwJ5dN4uE09gwny1KOadJJG8=;
        b=6Knc6lSr8+YIgxrbIki2xwZwDojBWme5dItqJqfPAMVCM+OUG8gsQ9sQz4cs+twSIN
         A7AHPxYeXu3WH0wgJKj/zr0WfMurMnFqq1etDouSfbkWUqKWpaofIdWqudIkorwlTS5T
         hqeS5jVX67rGlfUgbJr+aDklG91sxTElWel6COFU+D0WAZtqTs7yNu3HdOg9l6W+WTMh
         ApGZTeg+sXveslP4adod0+wCxcE24B/Yp5Q3C+UPyFOnyifLKC0XCNDg0RUimwDLnb5G
         3sv4mqA8no+9nbZin3K2bJhokKBsNa0ggvtsIlR/KcFMCLJalrS4SRFrl2kzYfJYuTto
         XZ/w==
X-Gm-Message-State: AJIora/rSVWqaLCS+cCJI94lN8bv9lH7wxoM1pOU7pUie9laEM6eJ3Pb
        yKa2wgwniX+ELI4beIZFHkRXDw==
X-Google-Smtp-Source: AGRyM1uXZKTN9VPepTsjj14RATmh/4wD63ZnXUnoL7ktAUdkiL0It3E6kzRrGErJOpLr4gGnhNbjGg==
X-Received: by 2002:ac8:5dc6:0:b0:304:fd1b:3368 with SMTP id e6-20020ac85dc6000000b00304fd1b3368mr1322993qtx.320.1656113267122;
        Fri, 24 Jun 2022 16:27:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id s7-20020a05620a254700b006a65c58db99sm2985530qko.64.2022.06.24.16.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 16:27:46 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o4siH-001HcK-VW; Fri, 24 Jun 2022 20:27:45 -0300
Date:   Fri, 24 Jun 2022 20:27:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     haris iqbal <haris.phnx@gmail.com>
Cc:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "aleksei.marov@ionos.com" <aleksei.marov@ionos.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Split rxe_invalidate_mr into local and remote
 versions
Message-ID: <20220624232745.GF23621@ziepe.ca>
References: <20220609120322.144315-1-haris.phnx@gmail.com>
 <d4223faa-0ac4-707a-1323-3d3ad769706b@fujitsu.com>
 <CAE_WKMy-rGgh_6_=OY_77pXNmV73tmww18eb4+XLpp_DtyASdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE_WKMy-rGgh_6_=OY_77pXNmV73tmww18eb4+XLpp_DtyASdA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 13, 2022 at 04:20:36PM +0200, haris iqbal wrote:
> > On 09/06/2022 20:03, Md Haris Iqbal wrote:
> > > Currently rxe_invalidate_mr does invalidate for both local ops, and remote
> > > ones. This means that MR being invalidated is compared with rkey for both,
> > > which is incorrect. For local invalidate, comparison should happen with
> > > lkey,
> > Just checked that IBTA SPEC ”10.6.5“ says that consumer *must* L_Key, R_Key ...
> > Not sure whether we should concern these.

I agree, 10.6.5 is quite clear that the ULP must present all of the
three options and the HCA can choose any of them.

So, rxe cannot have a bug if it always uses the rkey ?

> There are multiple things to consider here.. Since the wr for
> invalidate can have only one invalidate_rkey, there is probably no way
> to send lkey and rkey both as mentioned in the spec.

In general what this reflects is that in Linux that we don't really
completely support the optional idea in IBA that the HCA can have a
different key space for l and r keys.

> One way to make this work (mlx does this maybe?) is to always make
> rkey and lkey same and NOT make this dependent on access. Whether an
> MR is open for RDMA operations or not can be checked through the
> access permissions. I am guessing this is how it was working before.

Yes, no driver in Linux suports a disjoint key space.

So, I'm revoking my 'this makes sense to me' - the commit message does
not explain how the IBA requires the use of a lkey for a local
invalidate.

Jason
