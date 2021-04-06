Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B418355418
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 14:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344147AbhDFMmD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 08:42:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344145AbhDFMmD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Apr 2021 08:42:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0FEA61380;
        Tue,  6 Apr 2021 12:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617712915;
        bh=LjryR5JqPho95Lb3MS+aL2CshXvqE9eCAjkLgqR8RIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kk1+Pm+zH8sHzdgsYbILAz2yku8ysa2qainS6h78SElK4LmCIE3xobf6FaSCk7na3
         tZdKCxDIiLDtFwKCzymb1Qm4uhnM90YFFKFRcBCulUzfHckJwooRxDf/w0UXahMmB7
         UDW0xQ7QpSPqoUGeZQE1JMPDeykfPcaVG5v38nMGsBFSD7uHzQxC8vrrkrHASP4upA
         LYI4qIh6enMk01n3ntPggqBzVLprALo+BP3sdgzmaXSn1/Q2htyk8a0cSmuxFmN06B
         WCOcVFdxF6f7gVNf/C8odh773Yss/55vwlVePbEbHVL5B7twnO09x3pYzXh+3eFQvT
         Uqepu0sF2XIiw==
Date:   Tue, 6 Apr 2021 15:41:51 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: Re: [PATCHv2 for-next 1/3] RDMA/rtrs-clt: Print more info when an
 error happens
Message-ID: <YGxXD/TODlXHp2sK@unreal>
References: <20210406123639.202899-1-gi-oh.kim@ionos.com>
 <20210406123639.202899-2-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406123639.202899-2-gi-oh.kim@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 06, 2021 at 02:36:37PM +0200, Gioh Kim wrote:
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> 
> Client prints only error value and it is not enough for debugging.
> 
> 1. When client receives an error from server:
> the client does not only print the error value but also
> more information of server connection.
> 
> 2. When client failes to send IO:
> the client gets an error from RDMA layer. It also
> print more information of server connection.
> 
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 33 ++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 5062328ac577..a534b2b09e13 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -437,6 +437,11 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
>  	req->in_use = false;
>  	req->con = NULL;
>  
> +	if (unlikely(errno)) {

I'm sorry, but all your patches are full of these likely/unlikely cargo
cult. Can you please provide supportive performance data or delete all
likely/unlikely in all rtrs code?

Thanks
