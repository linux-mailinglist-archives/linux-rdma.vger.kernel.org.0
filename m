Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69E350EC80
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Apr 2022 01:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiDYXT4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Apr 2022 19:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiDYXTz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Apr 2022 19:19:55 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDAC19C1B
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 16:16:50 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id x21so2034771qtr.12
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 16:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=K/uLq/CezghcIjmwWwFdZNpMyZctJP1Pkey47cRrUic=;
        b=h9YcBUButrGiMr4N2DW12g9zwKd9vEPe+g+YQkdQhQCMolXfzn2F7WRffuS/Pd2S9T
         kdgFkgJLJHZOn4hwF6uS3IOvOvQRAPmIZcGmsmr3xfpZqd2K7qIBy5EjMjwwixFawvKZ
         v6sWaMJbLTImVCPSmXb0Z818BXW7ydJo7vZ5kFxXl/ix38tvU/VU4iTxr4srR6sZ+UrI
         GuCp8GNXVOpI83llbLHCmMHVfhjhvxTgpyAkXAwdIhtwu0ObC2LSvcWXNq1tuR/rtWi3
         qPYHrVucxvG1zSrGr6OsuLr7FGbXaoMd04Zbs6VxmQec0MCnBwe35AFFTXrYh9CToNFl
         czPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=K/uLq/CezghcIjmwWwFdZNpMyZctJP1Pkey47cRrUic=;
        b=QZkeEw03bYGq7YT9MqlriWrVXfFVYcNdgtbI3/gbTutNO79oTyLc1MGTqgq4oP20Ac
         8t7L4gKJRNBmAQSkRQXoQRUMRXJlUiUeNPEzNoWj6u86L8bFbSKHRfWUV7j/QYaFnVFc
         kj59MVgnp15g21ApHQ7j3am7e5Hvk6b7xVv+6fS1K1RF9T95RXdLtlYpY8NjLAt0keL6
         3xKQAddWX5VHRi5jGGW8qhRMMrdBZG+eNjZ/sF+xAiCvrHGVrLJ+1tAviSdf/pX9jaSz
         c5bEAIL5RHLRoRWWaeGVb2lWmJREeVN1eVsO3t3MFCwLexg4Vety0IK6IguFs5RSCiBJ
         GM7A==
X-Gm-Message-State: AOAM531XP8OgiRO1RW2Vm+0GHxVuPo57HYvBywaYx1adQtLf7bq5YVl8
        RmT87VNjE8bb8ePlJobzw9XVi+VPqEzT5w==
X-Google-Smtp-Source: ABdhPJyQaGRUl72V5P1t+Zt7o6UK9Hlt53aKfuBU58zlr0orBCjrF30tpoNlrXB2mWnTQFPA86juDQ==
X-Received: by 2002:a05:622a:13cf:b0:2f3:6168:13c0 with SMTP id p15-20020a05622a13cf00b002f3616813c0mr8579436qtk.144.1650928609312;
        Mon, 25 Apr 2022 16:16:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id x20-20020ac85f14000000b002e1ee1c56c3sm6886225qta.76.2022.04.25.16.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 16:16:48 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nj7wm-009VtS-5X; Mon, 25 Apr 2022 20:16:48 -0300
Date:   Mon, 25 Apr 2022 20:16:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCHv6 1/4] RDMA/rxe: Fix dead lock caused by
 __rxe_add_to_pool interrupted by rxe_pool_get_index
Message-ID: <20220425231648.GZ64706@ziepe.ca>
References: <20220422194416.983549-1-yanjun.zhu@linux.dev>
 <MW4PR84MB23078B439AE048978D67F42EBCF79@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
 <79753213-60cc-87bf-b0e6-b9c6a29209a3@linux.dev>
 <20220425190227.GX64706@ziepe.ca>
 <8d8413e4-d30c-9e65-914e-231cc8e9784a@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d8413e4-d30c-9e65-914e-231cc8e9784a@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 26, 2022 at 06:01:51AM +0800, Yanjun Zhu wrote:
> 
> 在 2022/4/26 3:02, Jason Gunthorpe 写道:
> > On Mon, Apr 25, 2022 at 07:47:23AM +0800, Yanjun Zhu wrote:
> > > 在 2022/4/22 23:57, Pearson, Robert B 写道:
> > > > Use of rcu_read_lock solves this problem. Rcu_read_lock and spinlock on same data can
> > > > Co-exist at the same time. That is the whole point. All this is going away soon.
> > > This is based on your unproved assumption.
> > No, Bob is right, RCU avoids the need for a BH lock on this XA, the
> > only remaining issue is the AH creation atomic call path.
> 
> If RCU is used, the similar issues like AH creation atomic call path will
> become more.

AH creation is unique, there will not be more cases like it.

Jason
