Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2741F189D7A
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 14:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgCRN7M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 09:59:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbgCRN7M (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Mar 2020 09:59:12 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C499120767;
        Wed, 18 Mar 2020 13:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584539951;
        bh=t2zFtJIr7b4K9W5WBhzNvBMh8EhfnyjBu9cVHqoODRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ve3Kf7c7z07d3ZcU3MheHKGfFFAW1j+zQsKOIZ5DhuB+6SuFW2wsec2G2TOsGTfoI
         Ny9xwUx7i0Etfl6Bh8KIp0tNmPCyaAl6a37FlD1AbAb/nCmW3MLAOP/6F+xZ0Aazb9
         5yxAzQ2AGz/YN//jJ04gOBStrpbzNPPU1uof+KXE=
Date:   Wed, 18 Mar 2020 15:59:08 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Insure security pkey modify is not lost
Message-ID: <20200318135908.GB126497@unreal>
References: <20200313124704.14982.55907.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313124704.14982.55907.stgit@awfm-01.aw.intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 13, 2020 at 08:47:05AM -0400, Mike Marciniszyn wrote:
> The following modify sequence (loosely based on ipoib) will
> lose a pkey modifcation:
>
> - Modify (pkey index, port)
> - Modify (new pkey index, NO port)
>
> After the first modify, the qp_pps list will have saved the pkey and the
> unit on the main list.
>
> During the second modify, get_new_pps() will fetch the port from qp_pps
> and read the new pkey index from qp_attr->pkey_index.  The state will
> still be zero, or IB_PORT_PKEY_NOT_VALID. Because of the invalid state,
> the new values will never replace the one in the qp pps list, losing
> the new pkey.
>
> This happens because the following if statements will never correct the
> state because the first term will be false. If the code had been executed,
> it would incorrectly overwrite valid values.
>
> if ((qp_attr_mask & IB_QP_PKEY_INDEX) && (qp_attr_mask & IB_QP_PORT))
> 	new_pps->main.state = IB_PORT_PKEY_VALID;
>
>
> if (!(qp_attr_mask & (IB_QP_PKEY_INDEX | IB_QP_PORT)) && qp_pps) {
> 	new_pps->main.port_num = qp_pps->main.port_num;
> 	new_pps->main.pkey_index = qp_pps->main.pkey_index;
> 	if (qp_pps->main.state != IB_PORT_PKEY_NOT_VALID)
> 		new_pps->main.state = IB_PORT_PKEY_VALID;
> }
>
> Fix by joining the two if statements with an or test to see if qp_pps
> is non-NULL and in the correct state.
>
> Fixes: 1dd017882e01 ("RDMA/core: Fix protection fault in get_pkey_idx_qp_list")
> Reviewed-by: Kaike Wan <kaike.wan@intel.com>
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> ---
>  drivers/infiniband/core/security.c |   11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
