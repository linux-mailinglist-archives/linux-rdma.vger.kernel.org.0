Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6E9214CAE
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 15:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgGENUP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jul 2020 09:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbgGENUO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 5 Jul 2020 09:20:14 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5F282073E;
        Sun,  5 Jul 2020 13:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593955214;
        bh=M4/Ha3Hr3Nfi1qwoRvl9S+A/jQC4GZli/ClXFruhBb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T1BvB4S06HUq6GV2M40D+lNoTvw0/pCPlmn3nTxCSOzDrxmNOQbTzCjavdFvlFHqo
         IZQH6RBL5sqyW4efPQAALTy+I9k0i8qz6JKR80jIibz6P4pNixSzaxCNKkLiqRUYYa
         b2nzWGEjRSYK+gsNLpu5T4FfMG5iWNc8oj6qUopw=
Date:   Sun, 5 Jul 2020 16:20:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: Re: [PATCH for-next v1 1/4] RDMA/rxe: Drop pointless checks in
 rxe_init_ports
Message-ID: <20200705132010.GD5149@unreal>
References: <20200705104313.283034-1-kamalheib1@gmail.com>
 <20200705104313.283034-2-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200705104313.283034-2-kamalheib1@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 05, 2020 at 01:43:10PM +0300, Kamal Heib wrote:
> Both pkey_tbl_len and gid_tbl_len are set in rxe_init_port_param() - so
> no need to check if they aren't set.
>
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c | 3 ---
>  1 file changed, 3 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
