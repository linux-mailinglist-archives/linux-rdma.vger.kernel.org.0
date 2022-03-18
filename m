Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594864DE0DF
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 19:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237852AbiCRSTJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Mar 2022 14:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240003AbiCRSTI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Mar 2022 14:19:08 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8647812759E
        for <linux-rdma@vger.kernel.org>; Fri, 18 Mar 2022 11:17:49 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id f3so1391709qvz.10
        for <linux-rdma@vger.kernel.org>; Fri, 18 Mar 2022 11:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FF1nWsq3IZi+WR3lcVWxhsMf8SeNQz9esF5jPtx1jUg=;
        b=OaBbUKAbBjdBt95hFYDrtUPh1v62i7OJ28Z5/URLO+ka8KSw5g6QUtgfe+IvFJc2Yl
         9s0EpwR/BLRlHjLGsvG/rokmOhk/1JD+hF0Lu0YEJlcKrrnGhq73VMz3ssDBYPZ0PKM7
         RHKW52kfpO344Q2NBcrnqpPBQRPaayEBU5s2LTjb1ZH14Lu/jZ04WQeNrmquNcssW5Ir
         CV//B/5o7PTTIGOILpcAd+sFAOScmVcsNEHq5+ldhCwwNc3TH9xx1/yUYqAZmjYyltSE
         taZ3ueb8hKKEPivnvlZP0S9dGCN8ruN3lxpY+XacLNfqZKfInDcgqJVfRlDZ/TjGSgy0
         DMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FF1nWsq3IZi+WR3lcVWxhsMf8SeNQz9esF5jPtx1jUg=;
        b=wXsEtrVo8bK9C3wdffDdoByvCxNd2PGpZ+KkPvv4CRWXxjsJj5zL1k3VhutXFmPkot
         0zHhrxahFbyYUOCVldbv3r+jmcEuldYx1lGZnvIAKS263PqQpNVqCznnM4TMX2/ZNJbU
         ijQO81jT/060rIjxg/ohNXq2ervKJmulcIdjhwFrlYRnXi77UjR2nsodNDVE8n+M2Ghd
         g/I40yA4hXZIW4bFzS9/g4+0B6MavtHFlrez1WbvxqFx8kmhO12ZtEUSyKe0VrRHQQ9W
         bfeTI9+1GhvT+nzVhtLIAof8D6JwmXbhs1NSLwq9HRUM/wRyPpfIu6Ey8HJpzbUuHEi4
         0aSg==
X-Gm-Message-State: AOAM531qDsBSbJX8ZfHdbjk22mk28TDhiAsI+Eu2ChAiRTmUWN91ZyIq
        FdKtRsObs41aRliTzF0OyTAtxg==
X-Google-Smtp-Source: ABdhPJzk4CHn7a/6vMk/8PlbqHU9ZQ8Nsw2J/ZNdAvIcWAfiQt9wUO+vCJJFDlTC3s0rWahTHXpGyg==
X-Received: by 2002:ad4:5de9:0:b0:43d:b3d3:79f3 with SMTP id jn9-20020ad45de9000000b0043db3d379f3mr8080112qvb.126.1647627468740;
        Fri, 18 Mar 2022 11:17:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id w17-20020ac857d1000000b002e19feda592sm5964212qta.85.2022.03.18.11.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 11:17:47 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nVHAY-002lcC-Th; Fri, 18 Mar 2022 15:17:46 -0300
Date:   Fri, 18 Mar 2022 15:17:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     Cheng Xu <chengyou@linux.alibaba.com>, dledford@redhat.com,
        leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
Subject: Re: [PATCH for-next v4 05/12] RDMA/erdma: Add cmdq implementation
Message-ID: <20220318181746.GF64706@ziepe.ca>
References: <20220314064739.81647-1-chengyou@linux.alibaba.com>
 <20220314064739.81647-6-chengyou@linux.alibaba.com>
 <ed329d4d-c3e8-ea4b-f599-577d16de4be0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed329d4d-c3e8-ea4b-f599-577d16de4be0@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 18, 2022 at 07:16:08PM +0800, Wenpeng Liang wrote:
> On 2022/3/14 14:47, Cheng Xu wrote:
> <...>
> > +int erdma_cmdq_init(struct erdma_dev *dev)
> > +{
> > +	int err, i;
> > +	struct erdma_cmdq *cmdq = &dev->cmdq;
> > +	u32 status, ctrl;
> 
> Hi, Jason and Leon
> 
> Defining and initializing variables in the form of an inverted triangle at
> the head of the function can make the code clearer. The kernel's coding-style
> does not specify this behavior, and the various kernel subsystems do not seem
> to have formed a unified opinion. Does our RDMA subsystem recommend this?
> 
> struct erdma_cmdq *cmdq = &dev->cmdq;
> u32 status, ctrl;
> int err, i;

This is often called reverse christmas tree style

It is common in RDMA, but I would not insist on it.

Thanks,
Jason
