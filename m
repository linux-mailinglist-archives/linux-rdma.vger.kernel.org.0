Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2368616508
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Nov 2022 15:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiKBOY1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Nov 2022 10:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBOY0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Nov 2022 10:24:26 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FF32A711
        for <linux-rdma@vger.kernel.org>; Wed,  2 Nov 2022 07:24:22 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id fz10so5688857qtb.3
        for <linux-rdma@vger.kernel.org>; Wed, 02 Nov 2022 07:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bxiGofDlX2KGYzeGhMkmo9GnT8evcwu0hDx9c1JV3Fo=;
        b=AIlROVS+H4vUqaWlV/szpH96oacWrPO+bucJiE7tTDquYlCvFTSCKjlPCVIBxXj5rq
         qc2FFhzNhV3NWi+NPhJhiv5MAwQgBAHHRSXKTlsM9UBtpqUC9wYj2jat2zKlCKELI1Pr
         eybSpvbw7/L4daFGr/emeu+C7r+0Dyyq3ev87eYSyIfhUyZ4XxRPfD2QHj/jXs/5Woms
         b02lnpCxHIFkTW/c+/H58JB78yADmWgMojnkSeJZQq//tWZZHNgclm8zMMN2oatI8AIV
         dbq6wd663x4BEQt0G6Puz2JZ8zPOMUmk06VXCmaVYAif3cyNsfVzkUQDZ3qmIgwGmgZ1
         0Lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxiGofDlX2KGYzeGhMkmo9GnT8evcwu0hDx9c1JV3Fo=;
        b=7HlkIodPU7ZpZ4/PcfjHJMg1R9qWG0xzdBFKfvsCodvaVtIm2Iro8mhFYhC4h+/BHh
         mET4yN/nmqLpjY/p6Z4vFkPr5QhRZFWGjgCCnzJqZdE1XttWzwAu8kBYbI+W7JW5c1zr
         WMdEQLir8f7dTI9ZaSI3FrlH3tBzgYAbXZlYO0ox5NL4kRJahfxUfKHwAX6Esa5OWW2P
         DPuuAeTHrWSqVJFW2+jmebGW4wk3CuWZtjuBM18a/rvqdUUXHP7uPS+ERmEfUorML/ES
         Eg9XYwgcAjVLRWEtZPi/+NgjsNj/SeWwgsho8djQSaOnJCNGPouJDks4s05/O7XNJARO
         l7tQ==
X-Gm-Message-State: ACrzQf36bVbq7JElqxYROBAImYnvvz63yVJzCWjQDFlFutOSHPf9PDo4
        cKXJALJeAITtbirJTbM9ZqHYtw==
X-Google-Smtp-Source: AMsMyM6OfydI4eRa5AYz6l7b+M4kZXqIWDFl+jWkWAeFKau2jbX3W8Uf0h/EHys5b+vYCYGY8VnaVg==
X-Received: by 2002:ac8:568f:0:b0:3a5:3ec4:d3d6 with SMTP id h15-20020ac8568f000000b003a53ec4d3d6mr5883956qta.51.1667399061433;
        Wed, 02 Nov 2022 07:24:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id x13-20020ac86b4d000000b003988b3d5280sm6606501qts.70.2022.11.02.07.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:24:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oqEfE-004fRZ-4b;
        Wed, 02 Nov 2022 11:24:20 -0300
Date:   Wed, 2 Nov 2022 11:24:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Leonid Ravich <leonid.ravich@toganetworks.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yigal Korman <yigal.korman@toganetworks.com>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        Leon Ravich <lravich@gmail.com>
Subject: Re: BUG:  ib_mad ftrace event unsupported migration
Message-ID: <Y2J9lAqBvjjPUmJf@ziepe.ca>
References: <VI1PR02MB623706DA8A01842834FC191089399@VI1PR02MB6237.eurprd02.prod.outlook.com>
 <20221102074457.08f538a8@rorschach.local.home>
 <Y2JqX3vC1mG/JDex@ziepe.ca>
 <VI1PR02MB623731066685B6E249F71A3189399@VI1PR02MB6237.eurprd02.prod.outlook.com>
 <Y2J4/NQMhRORqnZ0@ziepe.ca>
 <20221102101719.6cbcca6b@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102101719.6cbcca6b@rorschach.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 02, 2022 at 10:17:19AM -0400, Steven Rostedt wrote:
> On Wed, 2 Nov 2022 11:04:44 -0300
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > So this tracepoint is just wrong, you can't call a sleepable function
> > from a tracepoint like that?
> > 
> > Presumably lockdep would/should warn about this?
> 
> Why didn't it trigger a "scheduling while atomic" bug? That should
> happen if you call a sleeping function while preemption is disabled. Or
> does this function explicitly enable preemption? Which nothing checks
> if you enable preemption while recording to the ring buffer. I guess we
> could add that check, but this is not something that commonly happens
> enough to bother.

No, it doesn't muck with preemption, it will have some sleeping lock,
eg mlx5_ib_query_pkey() does a memory allocation as the first thing

It seems like a bug that calling kmalloc(GFP_KERNEL)/might_sleep()
from within a tracepoint doesn't trigger a warning?

Jason
