Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 699FF9806A
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 18:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfHUQmM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 12:42:12 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33857 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfHUQmM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 12:42:12 -0400
Received: by mail-qt1-f196.google.com with SMTP id q4so3840221qtp.1
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2019 09:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RSPc35hGp2T1zvcnMgnXAGItLsyBcY9rgfDFxsi3ldw=;
        b=RaKt9n3h096o2OXTPpOrBL2gY2S24DfoiSDIMUHzC+ZMoI0D3JxbZd2X4c7AahcUI1
         f7ioXc7raLRIuW/FNYVd3SSq0/1/wMF+PN2mHarDRtFICWO6KktciDjlyRx+hBHcDu2A
         sAaBAxKltvklOVAU1ZTDQiDUmAceHWQL+LC/2MTXIEveOqsEGNGsuQTrQEFcNF1Za4Wa
         NrOWDSX717eweXsw4BrAepYUCodNLDNue5RfWSgWhdXeyOAwzRrjEhZOMpkzqVBqTWOX
         x3NcpeUIemnIREUone+IC1u9qopsa5qWn1TZFl7fnmzR2bucTc0rsLxBl7aCDYmDf+/C
         osiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RSPc35hGp2T1zvcnMgnXAGItLsyBcY9rgfDFxsi3ldw=;
        b=fUpvSG2TjCVF0gevN6rpEMLB64eryWATlK1Gnm//mlWwtYGslZk0OZqs42PqmH98cT
         3qSXZJEORLjiXwJWiX2ihH+2MzJEGszMiF9YuyGA+B6faGQ6X8YNNhiLeFS8SS1WY9hc
         2FzNhjwf4/bYVgSEMSEmqnn934GWXvkxXEBCN5sau76ylNq0Ht++jDxmn0hUVWOviWY9
         YC5JkJ5eeivONAZBF9gswNISnassdwnP95ZuGxZ8vXDb2YG5wzJPiAA5pQ6SNE+KS+kw
         4v8F4Zo+O6YqDBzjveCm969ufwzW0p+Csgr3R23wLobBYP7/dpK7Y0cQqg+SjQoh0udl
         s+zw==
X-Gm-Message-State: APjAAAXnyvfBRIERFvLCkV9sHrGHCVA3jNxx5wOptxzRhV4/JT6vgc//
        Q8ScJOTh+1gEtLLdJSeoy0mcpw==
X-Google-Smtp-Source: APXvYqyyIvgX6DhFVjRnhAONNfnPNfd+8YYHyuEMQK0ev/roP0LCIf5mZD8IYUK1OQq1qS515WE4Nw==
X-Received: by 2002:ac8:7158:: with SMTP id h24mr20152304qtp.73.1566405731223;
        Wed, 21 Aug 2019 09:42:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id r19sm9923791qtm.44.2019.08.21.09.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 09:42:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i0TgY-0001s0-Ck; Wed, 21 Aug 2019 13:42:10 -0300
Date:   Wed, 21 Aug 2019 13:42:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Moni Shoua <monis@mellanox.com>
Subject: Re: [PATCH rdma-next 00/12] Improvements for ODP
Message-ID: <20190821164210.GA1389@ziepe.ca>
References: <20190819111710.18440-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819111710.18440-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 19, 2019 at 02:16:58PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Hi,
> 
> This series from Jason is a collection of general cleanups for
> ODP to clarify some of the flows around umem creation and use
> of the interval tree.
> 
> It is based on patch "RDMA/mlx5: Fix MR npages calculation for
> IB_ACCESS_HUGETLB"
> https://lore.kernel.org/linux-rdma/20190815083834.9245-5-leon@kernel.org
> 
> Thanks
> 
> Jason Gunthorpe (11):
>   RDMA/odp: Use the common interval tree library instead of generic
>   RDMA/odp: Iterate over the whole rbtree directly
>   RDMA/odp: Make it clearer when a umem is an implicit ODP umem
>   RMDA/odp: Consolidate umem_odp initialization
>   RDMA/odp: Make the three ways to create a umem_odp clear
>   RDMA/odp: Split creating a umem_odp from ib_umem_get
>   RDMA/odp: Provide ib_umem_odp_release() to undo the allocs
>   RDMA/odp: Check for overflow when computing the umem_odp end
>   RDMA/odp: Use kvcalloc for the dma_list and page_list
>   RDMA/mlx5: Use ib_umem_start instead of umem.address
>   RDMA/mlx5: Use odp instead of mr->umem in pagefault_mr
> 
> Moni Shoua (1):
>   RDMA/core: Make invalidate_range a device operation

Applied to for-next, thanks

Jason
