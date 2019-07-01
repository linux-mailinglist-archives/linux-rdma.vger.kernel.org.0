Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97E2B5C2AB
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2019 20:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfGASKQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Jul 2019 14:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbfGASKQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 1 Jul 2019 14:10:16 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20AF420B7C;
        Mon,  1 Jul 2019 18:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562004615;
        bh=aFs3dZtKsOgme/Nb0YlnmfRyZ6V+Kc8lnJZNVc5Ll+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t5YcNxJa8T07pWUWpydyD3KUOVt2hOp9+0D2hbnEO/RmTfjJhZj29Ys4U1JGallII
         LWI2crXvyLksDwzQHjKWiJvLX600SLCSlCTcrc3Iemue5VcZs3odTC19plOtPB43+s
         lJA8+TGyN7wY3eVgJjUmdXGOfk3g304gKicz6rTE=
Date:   Mon, 1 Jul 2019 21:09:46 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Liu, Changcheng" <changcheng.liu@intel.com>
Cc:     shiraz.saleem@intel.com, faisal.latif@intel.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/i40iw: Return the QP state when being queried
Message-ID: <20190701180946.GL4727@mtr-leonro.mtl.com>
References: <20190701165641.GA14149@jerryopenix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701165641.GA14149@jerryopenix>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 02, 2019 at 12:56:41AM +0800, Liu, Changcheng wrote:
> i40iw_query_qp does not return current QP state when QP attributes are
> queried.
> Return qp_state and cur_qp_state correctly in the QP attributes struct.
>
> Fixes: d37498417947 ("i40iw: add files for iwarp interface")
> Signed-off-by: Changcheng Liu <changcheng.liu@intel.com>
> Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
> v1 -> v2:
>    * Correct patch format with '---' under Signed-off-by.
>    * Refine commit message with 1) why need the change 2) solution.
>    * Add "Fixes" to show the original patch introduced the problem.
>    * Change patch title.
> ---
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c | 2 ++
>  1 file changed, 2 insertions(+)
>

Thanks, a lot.
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
