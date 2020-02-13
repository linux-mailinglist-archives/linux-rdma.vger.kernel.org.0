Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACD315C9DE
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2020 19:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbgBMSDI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Feb 2020 13:03:08 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43416 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMSDI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Feb 2020 13:03:08 -0500
Received: by mail-qk1-f194.google.com with SMTP id p7so6544235qkh.10
        for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2020 10:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=23P7Lla6W8Q6Wgo8sJbEFiuo0ZEVMqJDfMaboX9R9kY=;
        b=De//3GQHzlwJm55eLH3PMivmiKLeBpcI4+scchvyZlJezmVgU0TZmLb58viUAjDnpJ
         78T8508X4gR8HHm/0TC0M+q27v9YNGJ+PoILgz/6AZCWDzBKyeVLWXDeVJ4SosUDxvli
         f6fnTkTCRg+sbDZowQ462JQ1kQDMIDlghNEmV0EBA+GQkW+kdziei24FHfb5CTQMEnul
         ffPkPlvt7/z6noZAOypfCPYxR2a0SQyEJwpdez7aTtfcn4I6B1PDPiyA1hLJP9LJBJjt
         9MnyLM8TwB9KfhRjvuD37W8pn5e3BXZ8ov3GIDBkEUkygjnS1kR8ssTTJd1hgrj6Q8pj
         Rq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=23P7Lla6W8Q6Wgo8sJbEFiuo0ZEVMqJDfMaboX9R9kY=;
        b=A+gvcHp+iocD3bz+fDYEZ/EPgs55rR0aeYMkPvmltfLOkvCtaXWKz+bIb4sN8oBgMM
         P+gaPJJryH+1Pn0GM1sblvWzkiQUqDXSHwDZ9JVwYRdF2hxtP+IjfkWDFHBm8nCDTE9I
         KDFxo+BbYPhTnp/y9sbwFNVNWk2s2NYyzM78s+7xlDZGeDaEb0w2YKa/JvY+7z9OOQz0
         Sy2Mux1zADBpCWBSx96PFx2sBmF18ckWeYaioZkK64SFccpxjQjHeKij/BZPbScawnN1
         papqFJmlxcCC5U0ou+vZlF5GtQYLS6WtVIM+JXny3SyIGLIPAUOz0S2pGo+y1d8c6Sfh
         XzNA==
X-Gm-Message-State: APjAAAXt0EtGXcItYOVxHBFCQz4Ht64fi8v7XOqWjLaj5dAIxSR6Cnt4
        N95h4d3z/iDObLw/j9qU6Aig8A==
X-Google-Smtp-Source: APXvYqzIzqjuU9+qAduqb5z3xuwaI4d12Tc7rx54DMO7ojKepTAYd+5c4C9DfXfsJZzu3PowvTymVw==
X-Received: by 2002:a37:4ce:: with SMTP id 197mr16670258qke.269.1581616986339;
        Thu, 13 Feb 2020 10:03:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d18sm1701057qke.75.2020.02.13.10.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 10:03:05 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j2IpN-0003E5-4y; Thu, 13 Feb 2020 14:03:05 -0400
Date:   Thu, 13 Feb 2020 14:03:05 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Valentine Fatiev <valentinef@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Yonatan Cohen <yonatanc@mellanox.com>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: Re: [PATCH rdma-rc 0/9] Fixes for v5.6
Message-ID: <20200213180305.GA7631@ziepe.ca>
References: <20200212072635.682689-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212072635.682689-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 12, 2020 at 09:26:26AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Hi,
> 
> This pack of small fixes is sent as a patchset simply to simplify their
> tracking. Some of them, like first and second patches were already
> sent to the mailing list. The ucma patch was in our regression for whole
> cycle and we didn't notice any failures related to that change.
> 
> Changelog of second patch:
> 1. Maor added IB_QP_PKEY_INDEX and IB_QP_PORT checks and I rewrote the
> code logic to be less hairy.
> 
> Thanks
> 
> Leon Romanovsky (2):
>   RDMA/ucma: Mask QPN to be 24 bits according to IBTA

I put this one in to for-next

>   RDMA/mlx5: Prevent overflow in mmap offset calculations
> 
> Maor Gottlieb (1):
>   RDMA/core: Fix protection fault in get_pkey_idx_qp_list
> 
> Michael Guralnik (1):
>   RDMA/core: Add missing list deletion on freeing event queue
>  
> Yishai Hadas (1):
>   IB/mlx5: Fix async events cleanup flows
> 
> Yonatan Cohen (1):
>   IB/umad: Fix kernel crash while unloading ib_umad
> 
> Zhu Yanjun (1):
>   RDMA/rxe: Fix soft lockup problem due to using tasklets in softirq

And these to for-rc

> Parav Pandit (1):
>   Revert "RDMA/cma: Simplify rdma_resolve_addr() error flow"
> 
> Valentine Fatiev (1):
>   IB/ipoib: Fix double free of skb in case of multicast traffic in CM
>     mode

These I want to see the discussion on

Thanks,
Jason
