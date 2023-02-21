Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D7469D7ED
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Feb 2023 02:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjBUBNx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Feb 2023 20:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjBUBNw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Feb 2023 20:13:52 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6C68A57
        for <linux-rdma@vger.kernel.org>; Mon, 20 Feb 2023 17:13:48 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id o3so2727587qvr.1
        for <linux-rdma@vger.kernel.org>; Mon, 20 Feb 2023 17:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ate/nMrZfLJ7NHdB/cD049hX8/45VrN9Sop0+JyKWHE=;
        b=Qyrv+wtkl9JuwkNKqIx0r+kWXC4Q5FDBebFTPA4qI0+RtpoambS35COReQ2b0XFYJR
         o3FSNjEUqX+oW5JIjfczZVGCS38cBvjc1LRAKCxH/DevyG17VR4Bj3Iumdt9ls4Qvg/K
         87qinUFrnR56gK50XiuAyKI12C/VpPyzBNX0Wow2oxgCjy34LHgBPmmTaCI5ECyM5vLE
         gRI5cDrHE7lezja0B29O96Nig8/PAjHMElOlcOwI5SyMOH9JLoc4fp+B8jXFEmTZyFQe
         JK22ndpaWdiMZT4ov+30tS7T+k3nV/d48u8EtNx3Kw6QoPm5HGHf2lOkc7uzwysdn/F5
         HMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ate/nMrZfLJ7NHdB/cD049hX8/45VrN9Sop0+JyKWHE=;
        b=0MF9STAN0+0AzwYebiMNHztejnqfzwI66HRqAgLA0XBlYM8uEuDp1DkZzzOe1oQmeH
         7pnhiM84fGPQnGBwgrbqgqK+XCjkkthpkcP9uhCK/aUSnJAQDbuqv2uHVPJjFujqvfkp
         LGw5x2T3CTDVQwT/rgU/RtDe++keCaxSTlLe8P0k4EFoY0P6uUMrx88AHtYJQsmWprmj
         9rUU9pmcUw76FU8cbsGV8st/AN0urDlunEAZ/J9UMNMwAckSiuhlBJcuJ45th2sshAGl
         n4+oWooOeRECZWvSimi8MztqT5/FkUb2f4xMh4eLyfqXHACnNtWogiDl1pp+pzUh89Mk
         HO4w==
X-Gm-Message-State: AO0yUKUb+99zXSE0thsWCtFLyxzUG5M/1kFlL0cc92DplYwICazVuZMO
        U3AekJ1nrl5Fj5d9U+eDNzuu3Q==
X-Google-Smtp-Source: AK7set9A+ivoXMcK68xjoLyhUzDWklXVzKfOlsopMrQpBnpSmvi48CLirJ3DESSseUDui7n0Q3k9BQ==
X-Received: by 2002:ad4:5c46:0:b0:56e:bb43:a087 with SMTP id a6-20020ad45c46000000b0056ebb43a087mr4457163qva.16.1676942027157;
        Mon, 20 Feb 2023 17:13:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id s75-20020a37a94e000000b0073d873df3fesm3967964qke.30.2023.02.20.17.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 17:13:46 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pUHE1-004oLS-Pc;
        Mon, 20 Feb 2023 21:13:45 -0400
Date:   Mon, 20 Feb 2023 21:13:45 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next 1/2] RDMA/erdma: Use fixed hardware page size
Message-ID: <Y/QayUBR0P7tzde+@ziepe.ca>
References: <20230220102015.43047-1-chengyou@linux.alibaba.com>
 <20230220102015.43047-2-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220102015.43047-2-chengyou@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 20, 2023 at 06:20:14PM +0800, Cheng Xu wrote:
> Hardware page size is 4096, but the kernel's page size may vary. driver
> should use hardware page size to set the parameters to hardware.
> 
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/erdma/erdma_hw.h    |  4 ++++
>  drivers/infiniband/hw/erdma/erdma_verbs.c | 17 +++++++++--------
>  2 files changed, 13 insertions(+), 8 deletions(-)

This should have a fixes line

Jason
