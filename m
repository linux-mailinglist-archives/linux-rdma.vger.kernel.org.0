Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446FD3DD0D1
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 08:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbhHBGx0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 02:53:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231410AbhHBGxZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Aug 2021 02:53:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21C8060F5A;
        Mon,  2 Aug 2021 06:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627887196;
        bh=tLQN/VsiIUDDCNHj0txvRatfHkroeo3DVsxYMQyLaXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YKcWWIG7LieUTbcaRq9lOWAsVXoigww3zLt/jWE9EYS3zYn+m5ph0k3G67gBSNHgv
         0JMiPvccdCH2OWDw50z8D7FlKV3BDsfZKUKll+ddu1sK8a2iM4ESP0dfDfpwSZt+b1
         7levhMhHUuk6B443+4RiH05t0kili07pkvomt+c+cPxjIanCfDd/OgfY/KZqpinxXj
         vy70IxYko75QFYPx8xjawcgNZYNKZ3hQ3m3/1BYbF+nccdY1MgeV8XN3OeQIGMrkYz
         kAP/MFGY8ptI+yQ5GubWDj9msmE9OR7w0DTDbvi3ytEItRpH19X5zqG/xSdcodo8uH
         wYW8JrIW6hctA==
Date:   Mon, 2 Aug 2021 09:53:13 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, haris.iqbal@ionos.com
Subject: Re: [PATCH for-next 04/10] RDMA/rtrs: Remove unused functions
Message-ID: <YQeWWcU5tBvHC1ec@unreal>
References: <20210730131832.118865-1-jinpu.wang@ionos.com>
 <20210730131832.118865-5-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730131832.118865-5-jinpu.wang@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 30, 2021 at 03:18:26PM +0200, Jack Wang wrote:
> The two functions are unused, so just remove them.
> 
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.h | 5 +----
>  drivers/infiniband/ulp/rtrs/rtrs-srv.h | 4 ----
>  2 files changed, 1 insertion(+), 8 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
