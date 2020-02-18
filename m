Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D139162AAC
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 17:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgBRQdW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 11:33:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:57304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbgBRQdV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Feb 2020 11:33:21 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEB062067D;
        Tue, 18 Feb 2020 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582043601;
        bh=HyLaakMiytwEmlMkhq3o1ByMSVCE+aCVPSCs3zYMhvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r2Z6PIhbEFsFRehw6B0xk2B+nup/evUATk2H3EVGOfR8up3gT6/C2Y0MSVEp2CgeO
         h8gGOaNpi9VVM6r3VmHUeN2ZHH5/IRbuHfzYKAAJzxsG76bXmjI69qKNS1jTKEZ6DT
         iSV8VmxFYZs4vJMhyyZFtSpBaNH/AaK7Kmvw7Rpo=
Date:   Tue, 18 Feb 2020 18:33:16 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] RDMA/core: Fix use of logical OR in get_new_pps
Message-ID: <20200218163316.GA11536@unreal>
References: <20200217204318.13609-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217204318.13609-1-natechancellor@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 17, 2020 at 01:43:18PM -0700, Nathan Chancellor wrote:
> Clang warns:
>
> ../drivers/infiniband/core/security.c:351:41: warning: converting the
> enum constant to a boolean [-Wint-in-bool-context]
>         if (!(qp_attr_mask & (IB_QP_PKEY_INDEX || IB_QP_PORT)) && qp_pps) {
>                                                ^
> 1 warning generated.
>
> A bitwise OR should have been used instead.
>
> Fixes: 1dd017882e01 ("RDMA/core: Fix protection fault in get_pkey_idx_qp_list")
> Link: https://github.com/ClangBuiltLinux/linux/issues/889
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/infiniband/core/security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
