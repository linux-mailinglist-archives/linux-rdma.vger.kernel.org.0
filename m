Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9C512EB01
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2020 22:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgABVDx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 16:03:53 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37771 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgABVDw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jan 2020 16:03:52 -0500
Received: by mail-qt1-f196.google.com with SMTP id w47so35553980qtk.4
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jan 2020 13:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u/1QWs2jPVwxNcjpbkDfisWtGO+dg+9ohdYz7wriUQg=;
        b=V7cncm3blLDxWy8NZTHL6buNa8Y4NzotMofdHicMcndR64BhDiE8zzfb474TpkISje
         mk9WX4kbXnmBRZ/KtwE80IXw/SL7BtRQsVuRCNawEtSdDc5vYf73nNmWnIApTNFxgqs6
         Ec8+FHWTiuEldubJi6FhCN7abg8qxLGXusXxOpqvUVipmoNPdf+ead2oohOvVFlnMljo
         6KjMQaXVT5rxl0pyDqhtyEqkJqtWttAtCmRJ9ef7dEP/2Ex7RynZb7qPkX3/o7+V+ZPQ
         sMyvqTCpieAPwQYhfQsj7UXT5sTP/ZCeLzccOOacYloNzgD7hpdnav532lRWa+Uy3w1e
         bYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u/1QWs2jPVwxNcjpbkDfisWtGO+dg+9ohdYz7wriUQg=;
        b=d7FbTXx4Uc4D1wCzQ6I+V5mzzTnTEKWz5fbaI5gVLTBQgClNb26t87WR89cJeJdP16
         wqVFm/s1IYeou7z8SjPSr8XjHM3FJGh3XnWTxVXzezuDvsUb6JmP1x7KZl8P2zbltnEv
         xONpBsUFBHW90bIwCoLOadetUGWXr/keDe/9MDb22PHbCXBK2Rx0m0Q/bFUezrFyRCye
         S8P7/jbZJuREJG0CUCEIG8QKd1pjKRR9XTKsxZFLooM8zZxMTJzfkaFQ0rqa6SIY0w04
         8bGuX9xRabq5WCwgIm4XlRcDX4iNCD0LDvOFKR76V2dAkSJlt/d6kWdpVqlE5a5z+zl7
         NDQw==
X-Gm-Message-State: APjAAAWn+z4xkRgXY8oGLzew60KFjHthviwbM7XWZUxIaKSBZilUCdWG
        /Dzr7STpsNUN3ycV3szptl9EgQ==
X-Google-Smtp-Source: APXvYqwWqT5eZ7AlBRxNxepchCjTvseU5D/TZ7TNk6KwRFCca7889MZHa7T4dk+whnabtltR2zc78w==
X-Received: by 2002:ac8:1198:: with SMTP id d24mr61150163qtj.105.1577999032232;
        Thu, 02 Jan 2020 13:03:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id z4sm15357996qkz.62.2020.01.02.13.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jan 2020 13:03:51 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1in7dH-00008j-9E; Thu, 02 Jan 2020 17:03:51 -0400
Date:   Thu, 2 Jan 2020 17:03:51 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@hisilicon.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Add support for extended atomic
Message-ID: <20200102210351.GA398@ziepe.ca>
References: <1573781966-45800-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573781966-45800-1-git-send-email-liweihang@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 15, 2019 at 09:39:26AM +0800, Weihang Li wrote:
> From: Jiaran Zhang <zhangjiaran@huawei.com>
> 
> Support extended atomic operations including cmp & swap and fetch & add
> of 8 bytes, 16 bytes, 32 bytes, 64 bytes on hip08.
> 
> Signed-off-by: Jiaran Zhang <zhangjiaran@huawei.com>
> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 100 ++++++++++++++++++++++++-----
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |   8 +++
>  2 files changed, 93 insertions(+), 15 deletions(-)

How is this related to the userspace patch:

https://github.com/linux-rdma/rdma-core/pull/640

?

Under what conditions would the kernel part be needed?

Confused because we have no kernel users of extended atomic.

Jason
