Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F140F77BD1A
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Aug 2023 17:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjHNPcr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Aug 2023 11:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjHNPc2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Aug 2023 11:32:28 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D313130
        for <linux-rdma@vger.kernel.org>; Mon, 14 Aug 2023 08:32:27 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-6418c819c3cso18324006d6.3
        for <linux-rdma@vger.kernel.org>; Mon, 14 Aug 2023 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692027146; x=1692631946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lt2LDf4ezJBvzN1GI+fqdOxS/5lneMAAmBS5PIk0aoU=;
        b=kwhbTP7wSPUg56HNlDQMtiyqgO5U42AYCBru5X7uXIJT4beinqGSpKn39gORPKbs3e
         J2jRHxlPU4y8bF+MHicD6TCfNK9XwzOazF9TCFR3CLdrdnbqZnkc1W9MojmffQ9tm1fb
         RB75zhbw4SrZrWZyYJjL3JbR8pQayzJH2WZTfFMC7exzVnizLij0eqnmzaa8KSFVS7/r
         cyJQmK0WImKE4NyaBJbB7TPOukOJcZaudJ0fqpEIGDiCZWUJDA0+RqfyzcSTvmkYWRwz
         vbfsauk52iRfBUJ/vjrN13q4+otwY/oUJmjdXXYBazm5h5uNqvgAwpniMu+IEV6Pk7Cn
         yGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692027146; x=1692631946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lt2LDf4ezJBvzN1GI+fqdOxS/5lneMAAmBS5PIk0aoU=;
        b=f6RZhPSETKxDO6ntsOVjrw1PZJ3XmLnFb8QWYRgjw8bx3oV9ToBfQFeor5G2jF487M
         DgfveoqsAWu7o1jAc0ZxXsx9B5ZuAk5/Fhv/kx4RiI7lyqhPYe3vFjrsBd7pirQT01Be
         0DVG8XhqXZW2APfLFfPl3qsLfy8tdQ65kRed2Hf/1RBAldfpUmfEK//di3OXoIzxVmGH
         UWxc8aF9X/4FKQrfg5Q1bZHp3VCDTPuAtjuPFg9TtVdKye8V2/5Zf/NUK6v34kZlEinH
         QC3QK0a5JNMJHTmPFpIkUh/yyqx2xUQzLqxak93fYXY1jY7jENXzKBOoHO57cuz+iTbx
         +9Cg==
X-Gm-Message-State: AOJu0YyjxsB4Siz/BzAS1UmoRj5GJYOrZUE7mRAAKyBZZAiR5bDcl0vl
        T7WrGPLIGAA4GdxmugfZS6bWzw==
X-Google-Smtp-Source: AGHT+IEBmDzptxdvEPD3rf48yXpUWmW3K9VSBofLslCtyTBXHaPVYSAQVUC1PwjUeCimAdzCqFQetw==
X-Received: by 2002:a0c:e0cc:0:b0:647:1230:ef7c with SMTP id x12-20020a0ce0cc000000b006471230ef7cmr6285793qvk.35.1692027146520;
        Mon, 14 Aug 2023 08:32:26 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id r2-20020a0cb282000000b00637abbfaac9sm3490007qve.98.2023.08.14.08.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 08:32:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qVZYO-006Vb0-Mm;
        Mon, 14 Aug 2023 12:32:24 -0300
Date:   Mon, 14 Aug 2023 12:32:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "St Savage, Shane" <Shane@axiomdatascience.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: infiniband-diags can't be installed in Fedora CoreOS due to perl
 dependency
Message-ID: <ZNpJCGSi7Ei1IN0A@ziepe.ca>
References: <MW5PR07MB93324BACD6F70B9679E996F9D211A@MW5PR07MB9332.namprd07.prod.outlook.com>
 <20230813103305.GJ7707@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813103305.GJ7707@unreal>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 13, 2023 at 01:33:05PM +0300, Leon Romanovsky wrote:
> On Sat, Aug 12, 2023 at 04:40:57PM +0000, St Savage, Shane wrote:
> > Hi all,
> > 
> > Just wanted to report that infiniband-diags cannot currently be installed in Fedora CoreOS because the perl dependency is explicitly forbidden.
> > 
> > https://github.com/coreos/fedora-coreos-config/blob/testing-devel/manifests/fedora-coreos.yaml#L170
> > 
> > This is a bit unfortunate because it also prevents usage of all the non-perl utilities (ibstat, etc) included in infiniband-diags.
> > 
> > Would it make sense to split the perl utilities to a separate package infiniband-diags-perl so that the C and shell utilities in infiniband-diags can be installed without the perl dependency?
> 
> I suggest to remove perl dependency from rdma--core.spec and install
> perl-dependant scripts only if perl is found on the system.

That is not how packaging is supposed to work

Everything should be installed always

This is really a Fedora question, we just follow what they
decide. Most likely the right answer is to put this kind of stuff in a
container and not run on the minimal coreos image.

Jason
