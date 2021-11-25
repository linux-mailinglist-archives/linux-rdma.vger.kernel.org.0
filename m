Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2C845D954
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 12:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhKYLkZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Nov 2021 06:40:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:54040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237218AbhKYLiY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Nov 2021 06:38:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BAC860F12;
        Thu, 25 Nov 2021 11:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637840113;
        bh=oS427/y07tDHWhR+wjXkzJYAqLUSfEGp46TTMpPDERI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aWGh+GCux2DvjkBq88jqX96T1VpQGOB+FnRD87o4q7uBmCJScAX7jYolJtGLK/ZcM
         xEGZLEOaV7EbicexsFZAiix579vRIWUIkdqAMQgI9h23Qdj83IUFe3JuyYq7G8vX/1
         +cn74WjO0lTa+weYlCNSSgd29ndzwoxe4wvZGW/O+6Kq8D5LJbzP7Qac3fUVOwT4V8
         9TNsDaBc6eZD7LvHJOo5Fan9oHUJ1VGCXYCNHTibaW8RocjdSxjlftaCRAJOYH/v5f
         muAu5R1GirTRmDb59SkxQ3hOsp3zEVGU3QyWgqvrecd9S2EsWjaFuQc8oAq1HP1Nyk
         fB52G1s/pL8jg==
Date:   Thu, 25 Nov 2021 13:35:07 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-rc v2] RDMA/cma: Remove open coding of overflow
 checking for private_data_len
Message-ID: <YZ9068DjutjBON/I@unreal>
References: <1637661978-18770-1-git-send-email-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1637661978-18770-1-git-send-email-haakon.bugge@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 23, 2021 at 11:06:18AM +0100, Håkon Bugge wrote:
> The existing tests are a little hard to comprehend. Use
> check_add_overflow() instead.
> 
> Fixes: 04ded1672402 ("RDMA/cma: Verify private data length")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> 
> ---
> 
> v1 -> v2:
> 
>    * Also fixed same issue in cma_resolve_ib_udp() as pointed out
>      by Leon
> ---
>  drivers/infiniband/core/cma.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
