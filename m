Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C1025B79C
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 02:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgICAct (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 20:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgICAcq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Sep 2020 20:32:46 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B548C061245
        for <linux-rdma@vger.kernel.org>; Wed,  2 Sep 2020 17:32:45 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id g3so652346qtq.10
        for <linux-rdma@vger.kernel.org>; Wed, 02 Sep 2020 17:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hzENZHHDagYkre5YmeQJF9VEGAF2lTzkp/c1bdh2+UM=;
        b=dmlFEhn+Ayo3tZ9GtT6vUzqpnrbmFB1gKVk0X4k7lm4hoPRQiIxAPKFnm/k6vPRA6/
         6r3AcZ+TUAwFJudCNPdYXM/riwzqY27zAzwSgriZdDWGfrO4284ublC4MUN/raTSDxz5
         4OuuKypmHv55w//+HmFFICIgGE3MUvHyWySXMkupUdNVMaeMejCRrdQ9LL9f37M0z8hW
         0imCFioGxYQNR66RkTNzkfb0Bi8GPXX/218PD02sX/iN/kYkSb/LYgRv+XqPp9WztFuv
         FIIaPX/CCee4ORcABHiQotgBvVWNb9O/FODqrlGsckUA15PlA9Ct+eaCo/WDAEF1DvSG
         piWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hzENZHHDagYkre5YmeQJF9VEGAF2lTzkp/c1bdh2+UM=;
        b=BIlxwDBXhsClx6NCfuG9At/g1WrX0MucpXYR0xv2PI8GI6tGBkIc4LjkWGsyeTJNHY
         PlP/o2HNkcdZi0LNinJgSgdYfM17VKpQ9/YWl7verBk9AkzIb0wPDqxsLWhFUW6oFV8G
         QHEIjEXZ/gXQ6iVcwCxizIa0EsubJ6pRrghL9Av3itbhpfQh2X/5PuNG8mU6+QzYkhrD
         cwYX7Z3+xH5gjklgU83dDilzNq7J0cRSmyx4WcT2CoderKudIDWVAwx53asNlgg47fyI
         BsJywcy7iMqWW9gopa6mHbrpiUwrQW9H44eg9DyW7rkDZmJ0+EVhQ4uHgLMz5o+znPOB
         eDdw==
X-Gm-Message-State: AOAM532pzfMa2QfzwM1L+/A444k7E2kWv4VFbzD00gj5p26L+Rn8M/TV
        VaJa3QtSDaBb95c1d3RRe+RBZQ==
X-Google-Smtp-Source: ABdhPJxdr7LJ5pYizsEZNIiuFOiBUBQxtCT3pf8bfpk4WqcCoVCAFEhYysLMdxkhcdHIfKWeu2I3CQ==
X-Received: by 2002:aed:2b63:: with SMTP id p90mr848170qtd.71.1599093164265;
        Wed, 02 Sep 2020 17:32:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 196sm987777qkm.49.2020.09.02.17.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 17:32:43 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kDdBC-006Dty-Mv; Wed, 02 Sep 2020 21:32:42 -0300
Date:   Wed, 2 Sep 2020 21:32:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/ucma: Fix resource leak on error path
Message-ID: <20200903003242.GL24045@ziepe.ca>
References: <20200902162454.332828-1-alex.dewar90@gmail.com>
 <83132be0-a33b-ab7a-0da9-cc5c9398d0d4@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83132be0-a33b-ab7a-0da9-cc5c9398d0d4@embeddedor.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 02, 2020 at 07:34:26PM -0500, Gustavo A. R. Silva wrote:
> Hi Alex,
> 
> On 9/2/20 11:24, Alex Dewar wrote:
> > In ucma_process_join(), if the call to xa_alloc() fails, the function
> > will return without freeing mc. Fix this by jumping to the correct line.
> > 
> > In the process I renamed the jump labels to something more memorable for
> > extra clarity.
> > 
> > Addresses-Coverity: ("Resource leak")
> 
> If you are using a public Coverity scan, please also include the Coverity ID.
> In this case ID 1496814, something like:
> 
> Addresses-Coverity-ID: 1496814 ("Resource leak")

Thanks, I fixed it up

Jason
