Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44954E32D7
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Mar 2022 23:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiCUWqg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Mar 2022 18:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiCUWqf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Mar 2022 18:46:35 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC9C3A146D
        for <linux-rdma@vger.kernel.org>; Mon, 21 Mar 2022 15:25:12 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id gi14so1668025qvb.0
        for <linux-rdma@vger.kernel.org>; Mon, 21 Mar 2022 15:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YtRmm8kJ+/thE8TyU1V/lUU2qIc7RwMgSZSRcqu5JcU=;
        b=f27va3fNaO0hXSbUNRWDlcNqcArItQ5FawbX2FhK5c8XLsJ9JZfBHtgHt2OMEFHgZ5
         QpZ9dG/ZQAaVbG93yfggI4vBiK1GIULUxWt+I+OSG2cg3mdPP65e/3g95kVpl9e4j/Xr
         MaWFMljZRHQvolasRnhtiOxlYrIyBpNU3qPeTOyhMUu5ccNrMKigD0GlCQfB9ZmxNkhZ
         mBPwyz+K4GD3hHfWeC4MItjlQF+SDt/GGtc3qDznkYNs0Q0ZVJa+ZOfRjRyljC3pa+D3
         8MS8JXtBDrWn7U88VifukI6ljfGNlhJ6zSd1/nP3Q2LCIhCEvCcRlzBeQ6kovKRj2cVL
         XHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YtRmm8kJ+/thE8TyU1V/lUU2qIc7RwMgSZSRcqu5JcU=;
        b=5QTwsqwdnwDja6c098Qjh8UPaWSeJ/D06Qkv45QFyqGbXDcNkuIIDr9elDvACmujkn
         AvZoAs08Z73umcLCN8dCoJf7nvVEljgOoqBhsqw/s9pofLEcm3FgY4vThR/kb4afWYoi
         bKP1YAbFn3d3mBlFD8H0YpxYqnC4GtYJu/SBScTz1+Ng47SYAD5hUCDfTc8xyYaJXcgK
         ThAy8ZotowH7nv9bkcp1L12Ae9ogjkYja65pZcNIZWQ5gAOinwv0CT7yFbzMuR6eXHq/
         UV5Yph3mRLBtvhDJvtWXAe7H+Qgd4+R28t9XfpPJ03th5Mp4+diCXkZvjeYFqtzlb6Pa
         TsLA==
X-Gm-Message-State: AOAM530/Ln3+/t4d0PtTg6K1Dd3KxdPZapbcNnR1wECoc9cmewao2Anx
        J5l44Guwo6gVrwaw/r4k3msRJHhP6XCoGA==
X-Google-Smtp-Source: ABdhPJzHHjBbfS4WzxCUg6+9KgLc2yBIwvG1+QUzxGw9F764mD/1pqK1y018aExmnkXL+JgFbATprQ==
X-Received: by 2002:ad4:5bcd:0:b0:439:365c:55b4 with SMTP id t13-20020ad45bcd000000b00439365c55b4mr17655649qvt.23.1647901396940;
        Mon, 21 Mar 2022 15:23:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id i18-20020ac85c12000000b002e1ce74f1a8sm12546856qti.27.2022.03.21.15.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:23:15 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nWQQk-0041yK-DU; Mon, 21 Mar 2022 19:23:14 -0300
Date:   Mon, 21 Mar 2022 19:23:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     Wenpeng Liang <liangwenpeng@huawei.com>, dledford@redhat.com,
        leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
Subject: Re: [PATCH for-next v4 06/12] RDMA/erdma: Add event queue
 implementation
Message-ID: <20220321222314.GH64706@ziepe.ca>
References: <20220314064739.81647-1-chengyou@linux.alibaba.com>
 <20220314064739.81647-7-chengyou@linux.alibaba.com>
 <57cd0171-5964-228f-b004-06cec1e4daae@huawei.com>
 <20220318181850.GG64706@ziepe.ca>
 <95ff44f2-e442-4e99-990d-2ef2fc9c1178@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95ff44f2-e442-4e99-990d-2ef2fc9c1178@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 19, 2022 at 05:43:16PM +0800, Cheng Xu wrote:
> 
> 
> On 3/19/22 2:18 AM, Jason Gunthorpe wrote:
> > On Fri, Mar 18, 2022 at 07:43:21PM +0800, Wenpeng Liang wrote:
> > 
> > > > +static int erdma_set_ceq_irq(struct erdma_dev *dev, u16 ceqn)
> > > > +{
> > > > +	struct erdma_eq_cb *eqc = &dev->ceqs[ceqn];
> > > > +	cpumask_t affinity_hint_mask;
> > > > +	u32 cpu;
> > > > +	int err;
> > > > +
> > > > +	snprintf(eqc->irq_name, ERDMA_IRQNAME_SIZE, "erdma-ceq%u@pci:%s",
> > > > +		ceqn, pci_name(dev->pdev));
> > > 
> > > Parameters in parentheses are not vertically aligned, a space is missing before "ceqn".
> > 
> > Generally I will recommend such a large amount of code be run through
> > clang-format and the good things it changes be merged. Most of what it
> > suggests is good kernel style
> > 
> > Jason
> 
> Thanks, Jason. We already use clang-format since you recommended it last
> time.
> 
> We review the changes made by clang-format case by case, and merge most
> of the changes. With a few cases, we handle them manually.
> 
> For this case, clang-format put the ceqn at the first line, making it too
> long (80 chars), and then the two lines of snprintf look like not
> balance. So, I put the ceqn to the second line and broke the alignment
> by mistake.

That sounds strange, clang-format never makes lines too long unless
strings are invovled...

Jason
