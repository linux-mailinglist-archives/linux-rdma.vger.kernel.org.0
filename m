Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92D8214CB4
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 15:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgGENXZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jul 2020 09:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbgGENXY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 5 Jul 2020 09:23:24 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C35BB2073E;
        Sun,  5 Jul 2020 13:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593955404;
        bh=HCZIb3AhCUesjyNLr2VfAe55/TvJp8WRlJmAs3aCZvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p+O7dzhQBUYwUIvxDHvwOj0F0bJgjdUW72Idfha/AQwTRM45vVUjorvvg62YTN1BF
         Go5vjEXTV2UJhhIyBihLQuXIWvP7r3PvZXd+I6lpXEVIIT5vVp3fuiHxE1Pk+jl8Gm
         6ySFsVJ9pyd9w6+j5iySnHXYs8i0tbUNFpHtSlno=
Date:   Sun, 5 Jul 2020 16:23:20 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Clean up tracepoint headers
Message-ID: <20200705132320.GH5149@unreal>
References: <20200702141946.3775.51943.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702141946.3775.51943.stgit@klimt.1015granger.net>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 02, 2020 at 10:19:46AM -0400, Chuck Lever wrote:
> There's no need for core/trace.c to include rdma/ib_verbs.h twice.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  drivers/infiniband/core/trace.c |    2 --
>  1 file changed, 2 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

Off-topic,
we have total mess of includes ... in drivers/infiniband/*.
