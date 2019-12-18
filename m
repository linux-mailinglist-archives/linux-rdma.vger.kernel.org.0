Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F126123F57
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2019 07:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfLRGAn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Dec 2019 01:00:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:46724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfLRGAm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Dec 2019 01:00:42 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B997421582;
        Wed, 18 Dec 2019 06:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576648842;
        bh=CSCE8RPyOF1ZSD20G/PLB+Iaew03qd0fJdcLm1v7ek0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vfDl/e/0kTj9r46LiIZQfuTKDdCoUFleucrxBNqAABtEoH1+9/F53gwX6bCGJCagR
         GoZNCfKZJiITVyS0nvy1H72wmn4V4F+HHri+hBu3ZKBdNCRI1tSknOoWMCz+XoWKi4
         Wji0w+e5QpPe2vrj0CdvtYx3DhmfkYd0uKcWolfk=
Date:   Wed, 18 Dec 2019 08:00:38 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Prabhath Sajeepa <psajeepa@purestorage.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, roland@purestorage.com
Subject: Re: [PATCH] IB/mlx5: Fix outstanding_pi index for GSI qps
Message-ID: <20191218060038.GL66555@unreal>
References: <1576195889-23527-1-git-send-email-psajeepa@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576195889-23527-1-git-send-email-psajeepa@purestorage.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 12, 2019 at 05:11:29PM -0700, Prabhath Sajeepa wrote:
> b0ffeb537f3a changed the way how outstanding WRs are tracked for GSI QP. But the
> fix did not cover the case when a call to ib_post_send fails and index
> to track outstanding WRs need to be updated correctly.
>
> Fixes: b0ffeb537f3a ('IB/mlx5: Fix iteration overrun in GSI qps ')
> Signed-off-by: Prabhath Sajeepa <psajeepa@purestorage.com>
> ---
>  drivers/infiniband/hw/mlx5/gsi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

The description of this patch is better to be updated to include the
fact that outstanding_ci holds unwrapped version of outstanding_pi and
current code will generate wrong loop inside generate_completions(), due
to breaking assumption that outstanding_ci < outstanding_pi:

 79         for (index = gsi->outstanding_ci; index != gsi->outstanding_pi;
 80              index++) {

Thanks,
Acked-by: Leon Romanovsky <leonro@mellanox.com>
