Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880C1482F28
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jan 2022 09:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiACI6z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 03:58:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58358 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiACI6z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 03:58:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 447F7B80DB9
        for <linux-rdma@vger.kernel.org>; Mon,  3 Jan 2022 08:58:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABAEC36AEE;
        Mon,  3 Jan 2022 08:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641200332;
        bh=wC3FEffEUxjq8UbQZ/qhRvwMy3jVmWSbcK31jG0Z14E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g6pZTnLKeKmZ55gy2noTfgcDoKcL+SNmNCqiTbJ9jflAs0dp5jtoVvlmpOEzWf8Gz
         pDE1Y1Dl/CbHQxvl49TePJXzydijRoWSJUDBbInQb5T6o7Chxy5FlR7uO7BJUNCjTv
         pxn8o+qZ+g0f8U7Q4ZqfnqDvQllwzKoCymIP/Fhsi+jfW3KpfBQibC2Rhji2syvmAH
         bk31X4EueMfGMztjBx3dknRdD/6/bSVboBKvqOTHzpT5P3nsXraBETWLd4BTUPEHSI
         eoSjZWJ6WxbI/K6Mjacyt7xYY3Oy1pmnjG+lTz8agsLVZaKMrP0S9VgM8/+uj0wIaS
         VqqOcxwXyKGQw==
Date:   Mon, 3 Jan 2022 10:58:48 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-next] RDMA/cxgb4: Set queue pair state when being
 queried
Message-ID: <YdK6yDSdsEw+HbgV@unreal>
References: <20211220152530.60399-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220152530.60399-1-kamalheib1@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 20, 2021 at 05:25:30PM +0200, Kamal Heib wrote:
> The API for ib_query_qp requires the driver to set
> cur_qp_state on return, add the missing set.
> 
> Fixes: 67bbc05512d8 ("RDMA/cxgb4: Add query_qp support")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/cxgb4/qp.c | 1 +
>  1 file changed, 1 insertion(+)

I wonder if this is last error of such type.
The bnxt_re had same error 53839b51a767 ("RDMA/bnxt_re: Set queue pair state when being queried")

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
