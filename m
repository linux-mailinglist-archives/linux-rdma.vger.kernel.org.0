Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103914334CF
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Oct 2021 13:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhJSLjh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Oct 2021 07:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbhJSLjg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Oct 2021 07:39:36 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4E0C06161C
        for <linux-rdma@vger.kernel.org>; Tue, 19 Oct 2021 04:37:24 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id t2so13430002qtn.12
        for <linux-rdma@vger.kernel.org>; Tue, 19 Oct 2021 04:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q7UTdsJiVBPlgNqDAnnH79fbP2YzwUe0rsB2Hf3+LkE=;
        b=C6DGrwUPcUJDRK63tDjSMwQmEn7NsXPh37QON6PCyL/fxXbl0fAUy9uoBmfUi8gfY1
         T3yvcsHkGIuSaPYiAy3M82cytYCCUJXC88scY+Vo/oIrfG80yADYGTyaaz4CyDLlyNI4
         Tpebb6Jbrei4XU9+0eC32+AHKfUv3wFf27mwlZpWeGhkSdNQiq5yQNpv3QmWjjntOYPB
         eHDh5Ka3BFYKy9mAfDdh8JUFQ6A6+rhoI4brL+zd61rqjrrG2hA1IFdfplZTf2UApdS4
         zCH/WrSp0UFwF6e5jEdDzTy2tqahPUPZE3WlJpbvNgAsRB+3AMJLzRnE9T8WQN5BxCIU
         1NHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q7UTdsJiVBPlgNqDAnnH79fbP2YzwUe0rsB2Hf3+LkE=;
        b=4o1GbABinCX4LoWskHfrAfxU6z9cQJNmZ6iW53wQSvVZ0miof9OGoiM/iAD2Hs/TCy
         IBOa7+1QH62GiPjiJCto5vNhTCqiwoRsHxtle07gCLm4YFiAs2KLSVI5CHGChTodkcWa
         XVFYTmIDzbgOZCES4Fwrmld5rDs3fhvIwJbMi/hjFgte5Ka5quIMu/N1THiRONQ5KZDM
         oxs7fRFg77m7IjyZ12rgUJTO3zhiAPnb3CT3w2IQqATCRoVYsnsD/xpa1USIag+6hspu
         yoQ3eH/0k0N/ct/6FGFp6L9GvuRJBVK+D7F9bn4ncJYsQgECrc36ZlYPJ+JAvvWeYCWD
         nVeA==
X-Gm-Message-State: AOAM533X3mNUrTy/ZOFWMMneC7WffdUUcBijIKDNvtl7dGrhsVVohAU3
        vWrua5TW+aRerzaieEc2AIxCQw==
X-Google-Smtp-Source: ABdhPJxZD4qlEMQXdMruMseWkDE/YzsDjMEWBzuywLP179wLXkYxh3X93dhvX+O7URGzh0DMN0IWyg==
X-Received: by 2002:a05:622a:1992:: with SMTP id u18mr36249097qtc.111.1634643443477;
        Tue, 19 Oct 2021 04:37:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id t19sm7386484qtn.26.2021.10.19.04.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 04:37:23 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mcnQo-00Gg4m-Ek; Tue, 19 Oct 2021 08:37:22 -0300
Date:   Tue, 19 Oct 2021 08:37:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     wangyugui <wangyugui@e16-tech.com>
Cc:     linux-rdma@vger.kernel.org, selvin.xavier@broadcom.com,
        eddie.wai@broadcom.com
Subject: Re: [PATCH] infiniband: change some kmalloc to kvmalloc to support
 CONFIG_PROVE_LOCKING=y
Message-ID: <20211019113722.GG3686969@ziepe.ca>
References: <20211019002656.17745-1-wangyugui@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019002656.17745-1-wangyugui@e16-tech.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 19, 2021 at 08:26:56AM +0800, wangyugui wrote:
> When CONFIG_PROVE_LOCKING=y, one kmalloc of infiniband hit the max alloc size limitation.
> 
> WARNING: CPU: 36 PID: 8 at mm/page_alloc.c:5350 __alloc_pages+0x27e/0x3e0
>  Call Trace:
>   kmalloc_order+0x2a/0xb0
>   kmalloc_order_trace+0x19/0xf0
>   __kmalloc+0x231/0x270
>   ib_setup_port_attrs+0xd8/0x870 [ib_core]
>   ib_register_device+0x419/0x4e0 [ib_core]
>   bnxt_re_task+0x208/0x2d0 [bnxt_re]
> 
> change this kmalloc to kvmalloc to support CONFIG_PROVE_LOCKING=y
> 
> Signed-off-by: wangyugui <wangyugui@e16-tech.com>
> ---
>  drivers/infiniband/core/sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Huh? what causes ib_port to get larger than MAX_ORDER?

The only array is attrs_list and I don't see something that scales
with

Jason
