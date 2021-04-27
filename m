Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB2036BEA4
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Apr 2021 06:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhD0EwP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Apr 2021 00:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhD0EwO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Apr 2021 00:52:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 738F0613B3;
        Tue, 27 Apr 2021 04:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619499092;
        bh=3gBAzoIll1p89OyvYWwNxI5cs0m/I/82n5G1OFW5s9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e9iDy69cnP5nWbi5k2k/p3ad3SvZwXavXZwlCyzRe4mzqzzhjOD+qtWUtLolwmEr4
         eAdsL9DWxkc4y0kFde9h8ZTD/Ecz7BEhbrWE/cSOoeyXzymy3FECOAEMYoGf07dGgk
         /BHKDA5XZr91dDIyYTwLmwZmXU+O6wFt6Jyw/U4L2y+ICWkadRveHr7XKOhXMo9yOA
         Uo7SepR/E60UstxCdw1BJzwgw38skBFceH0jpytt0AFvDjS5BmwxHXvzNInBbLEveX
         OnYdYuXZ0+6ThhFLY/P7Zy5q4vTRwIxZku0Mh77L4xePs+vdtdWB1pzn+DOtJ+S2Gv
         JZWZF84pIEBwg==
Date:   Tue, 27 Apr 2021 07:51:28 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com,
        nareshkumar.pbs@broadcom.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/bnxt_re/qplib_res: Fix a double free in
 bnxt_qplib_alloc_res
Message-ID: <YIeYUD5iWv/TI3PH@unreal>
References: <20210426140614.6722-1-lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426140614.6722-1-lyl2019@mail.ustc.edu.cn>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 26, 2021 at 07:06:14AM -0700, Lv Yunlong wrote:
> In bnxt_qplib_alloc_res, it calls bnxt_qplib_alloc_dpi_tbl().
> Inside bnxt_qplib_alloc_dpi_tbl, dpit->dbr_bar_reg_iomem is freed via
> pci_iounmap() in unmap_io error branch. After the callee returns err code,
> bnxt_qplib_alloc_res calls bnxt_qplib_free_res()->bnxt_qplib_free_dpi_tbl()
> in fail branch. Then dpit->dbr_bar_reg_iomem is freed in the second time by
> pci_iounmap().
> 
> My patch set dpit->dbr_bar_reg_iomem to NULL after it is freed by pci_iounmap()
> in the first time, to avoid the double free.
> 
> Fixes: 1ac5a40479752 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_res.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
