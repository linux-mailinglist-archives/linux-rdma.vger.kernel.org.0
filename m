Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075593A5782
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jun 2021 12:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhFMKOk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Jun 2021 06:14:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231277AbhFMKOk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 13 Jun 2021 06:14:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D988B6124C;
        Sun, 13 Jun 2021 10:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623579159;
        bh=vxEF0q7emP1WZlaczjGF+kqJuzgeKNNCd72MFYG7DYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gd4tzTx3XNy5aEAjIXQ5YdMbl4BKSli+buaptUeKk0wcPyh7VYPID6t/n2WQ1tTHf
         8xiIxYLeuFVRq9tLqanUg9iGerOe8MXV/Mqx10iSuMNEVVCsw7v5PjMNTL0xuga/Lb
         AOWnnUB7OPv6KJfdV9wPqSALhmuSwxm49RzcXflg1Ok51MwesK7uBHQoN2tAWL9UJv
         AwR7HqIdMVWPUlrmriuL3wxJ9+YNX9ojIPwjI3DarTh8r0/hZ1U77gFh3Yv2dUvLkK
         qsM8MxM+pRX4LC4tHlMiAEv8m5pv/BnPEJFCGfW1sUk1aNxmJU8wZoDDhvApyLiKUU
         S+gHLkeQMHTXA==
Date:   Sun, 13 Jun 2021 09:36:50 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, haris.iqbal@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: Re: [PATCHv2 for-next 5/5] RDMA/rtrs: Check device max_qp_wr limit
 when create QP
Message-ID: <YMWngqDD4RjqpZOY@unreal>
References: <20210611121034.48837-1-jinpu.wang@ionos.com>
 <20210611121034.48837-6-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611121034.48837-6-jinpu.wang@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 11, 2021 at 02:10:34PM +0200, Jack Wang wrote:
> Currently we only check device max_qp_wr limit for IO connection,
> but not for service connection. We should check for both.
> 
> So save the max_qp_wr device limit in wr_limit, and use it for both
> IO connections and service connections.
> 
> While at it, also remove an outdated comments.
> 
> Suggested-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 29 +++++++++++++-------------
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 13 ++++--------
>  2 files changed, 19 insertions(+), 23 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
