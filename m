Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EC81E106D
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 16:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403994AbgEYOYl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 10:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403968AbgEYOYl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 10:24:41 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBD1C061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 07:24:41 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x29so657767qtv.4
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 07:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gY2b3G7zzjaeKWiOVEf3qZyrUuVH0WOnEyfFY0mYKfM=;
        b=kRFjBeRVtl4XXuqRo69Tnsh3px6MA4AgFQ80oMaivnNZ3++fnmSBpDPCDcsQYLJlQl
         SpBCv4YVJGxAklg1ZojSuaM4mZOruB6TxvH2Jce/Fy5+3LwKNCN8wQVb6PI8qMBeCaOU
         bm1WmgF1gXUdSC7VgMx/P1sOTImVWw8h5LGztIbHDNDFwrYPcJi5c1noXj2i2sKQkGgS
         ZYMrBZWFCSDPmlEBP/slxYiC/zgVXsFuxi0GJFxGp+KhByKWtiR8RAcK26VFVIJBk2Sp
         0DWSsNcoCew1Dq463++bnKYBgWyTH14f41qkPWNQsroUHtlS/1SSE5gjNkoicvL/LW56
         2nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gY2b3G7zzjaeKWiOVEf3qZyrUuVH0WOnEyfFY0mYKfM=;
        b=PyH84s55H2QqCm1isFXdcR3YG5iVpqmw6oymO1RHaoBEIY6nP46MM1LmrdRfbBgrGI
         faVKXIz28zvcSH2Hgn3FfZj9Xoo7ArqG2D+kqudME3DlvruwslRmJg9BfFP5rjzG8itq
         cddzer8ye5IWyWFGIErevXcn5RjGakyXSgH0xCRDCOFFfmcY5q/P/ry6YBCLRDvg+QGW
         9cKS4+M7PpP74BbW5us7lX75+qMz+SJz8lCabi2tHIlORzPpFPq2yeyhumnnwAiFB3cL
         8/EMbpbXR0fd5kFXqCyVn+R2lvMPCtgIyo7y7PS1fVSpyhW/O/TmuVb/GOzlGaTfg4LJ
         upjw==
X-Gm-Message-State: AOAM530QFyEMJ7PRH8qZN4Dk31guG7mZzND3/ExBJWQIvqRv+QYIwAD8
        kk59dl9YVde+al3EmNz5bmNajfBmWvY=
X-Google-Smtp-Source: ABdhPJwQHxbhaiXBRTUEChZJz+ZbZk+SOiPrl37fqQicXJJQDf/qkPYeFHi/XJDU4T/KEsoDMu57LA==
X-Received: by 2002:ac8:326d:: with SMTP id y42mr28154227qta.243.1590416680466;
        Mon, 25 May 2020 07:24:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id v1sm11464263qkb.19.2020.05.25.07.24.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 07:24:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdE1v-0005Ro-Do; Mon, 25 May 2020 11:24:39 -0300
Date:   Mon, 25 May 2020 11:24:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH mlx5-next 01/14] net/mlx5: Export resource dump interface
Message-ID: <20200525142439.GA20904@ziepe.ca>
References: <20200513095034.208385-1-leon@kernel.org>
 <20200513095034.208385-2-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513095034.208385-2-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 13, 2020 at 12:50:21PM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
> 
> Export some of the resource dump API, so it could be
> used by the mlx5_ib driver as well.

This description doesn't really match the patch, is this other stuff
dead code?

Jason
