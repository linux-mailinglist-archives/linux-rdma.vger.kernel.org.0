Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBDD689C19
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Feb 2023 15:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjBCOoS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Feb 2023 09:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjBCOoR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Feb 2023 09:44:17 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347259EE19
        for <linux-rdma@vger.kernel.org>; Fri,  3 Feb 2023 06:44:12 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id g7so5600534qto.11
        for <linux-rdma@vger.kernel.org>; Fri, 03 Feb 2023 06:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iB3tI2+N9F2REljMdJ+knWCcyYIg8YTZr/IyyWC2wDE=;
        b=ojiqolLBROgj8GcZznGGLsIE8QnMSk6djuYWhZnmwVbOHVFNfz5m3jWQZ+vGBPQUlt
         P2SGhoLSbozv8VdF17fc/3q8uofEM97w41fkfTxzcUHU2tlFWplcFbRcDnQ4kUo0V5Kx
         cHMrsjhC/8EWgEVxCUwqcwkmVT/0DUEyuhr34XDeBMg9VfOvWteRzVFD6T34AiGLzzR1
         4LsLFZNf+3tLfifa1NMFcNd09tGCq499jN8qyNMkj1h5563q306MpG5hhPLyR2XOuW2L
         psFxjE+UvypO2lWWcUpcjyXJzxGvmaWDWUv46xfkAALHDcaKCvpMxU454pOqQU/NSDOa
         3v5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iB3tI2+N9F2REljMdJ+knWCcyYIg8YTZr/IyyWC2wDE=;
        b=6x3lSf4FAYUagB91XK2AAPsA9LMKK8rg5Uej3beiSUTz5u012VtkslNWUloC7/v0GK
         8H6+4GW/Nt78xJX3Ho0riNwct++TmTn9u+3CXjVMGz7mT0Z912tOJLFoMB5nfSjwrqhX
         LCubHDKGp+h+A0uk1qL1Z3fEpi/Y9ytQ01llZh3Gs6SRNQPAO1eoZCg0kB6TAJ2xpKto
         ZscS16e+zoN/WgkDv4WRNa8b1vwqhII47zrGSuYBHJUvHMzgUb5+9yAeb6Ce0Mb9kcOz
         6S9SNl4dSTSEoWkocOLI3sQODpS+VrkNbxykLkozzOwg7KTEvZyqBkMKUGIwXKlXrYuz
         IqeA==
X-Gm-Message-State: AO0yUKVuYm7Qk2i9gDs4EbhEU2JOpLM6546Uqq/+jM23gt62S4dZxU+o
        TSCEkOvkaxG+sxn3o9ocRWw/gA==
X-Google-Smtp-Source: AK7set86aAwVVlRleiwoQ5W5JA7bZvzYdyH2TizWi+XxEXXshuEU7MJAXMNBgKrQ78j/BAnAbqHjvA==
X-Received: by 2002:ac8:4e81:0:b0:3b8:5a02:eb43 with SMTP id 1-20020ac84e81000000b003b85a02eb43mr20271979qtp.64.1675435451227;
        Fri, 03 Feb 2023 06:44:11 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-167-59-176.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.59.176])
        by smtp.gmail.com with ESMTPSA id r144-20020a37a896000000b0070638ad5986sm1888064qke.85.2023.02.03.06.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 06:44:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pNxIP-0035Eb-Le;
        Fri, 03 Feb 2023 10:44:09 -0400
Date:   Fri, 3 Feb 2023 10:44:09 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Vogel <jack.vogel@oracle.com>,
        "mustafa.ismail@intel.com" <mustafa.ismail@intel.com>,
        "shiraz.saleem@intel.com" <shiraz.saleem@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/irdma: Move variable into switch case
Message-ID: <Y90duSmdXMo4dR85@ziepe.ca>
References: <20230201012823.105150-1-jack.vogel@oracle.com>
 <Y9o6xnalM+R4DE3D@unreal>
 <997C66D5-3298-4F64-8784-3FDAA438C66C@oracle.com>
 <Y9ttN4tB1mwB6bSU@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9ttN4tB1mwB6bSU@unreal>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 02, 2023 at 09:58:47AM +0200, Leon Romanovsky wrote:
> On Thu, Feb 02, 2023 at 12:09:50AM +0000, Jack Vogel wrote:
> > Hey Leon,
> > 
> > Oracle switched to GCC11 in our UEK7/OL9 releases recently, leading up to that release we added the ALL_ZERO config option, and then ran into some warnings, our build treats warnings as errors and would fail. For instance this thread: 
> > 
> > https://lkml.iu.edu/hypermail/linux/kernel/2202.1/05558.html
> > 
> > A number of changes were made in the mainline code by Kees Cook and even made it into the linux-5.15.y branch, but a couple of them we have carried as specials for the past year, I was recently prodded about the matter again by an internal group, so I thought I would submit these patches upstream. 
> > 
> > I must apologize though, for unbeknownst to me, our tools team actually back ported the fix from gcc12 regarding these warnings and forgot to tell the UEK group about it :) It wasn’t until you asked about the warnings, I reverted the commits and did a build to capture them, then I discovered they no longer occur. So, sorry about the noise. I will be reverting our own changes as unnecessary now.
> 
> Glad to hear.

Regardless, it is really weird coding style to have a variable
block immediately after the switch statement

Jason
