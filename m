Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC5A411567
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Sep 2021 15:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbhITNU6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Sep 2021 09:20:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233770AbhITNU6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Sep 2021 09:20:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0358360EB6;
        Mon, 20 Sep 2021 13:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632143971;
        bh=YWwpJ6GdOtb6FvbH6VGrRbz+SxIszfnSPHL8mrjIXfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZPyvg5ddQHULU1ePzSqHaQadoYcdvoEpjqFz1xtfqjhMUuwEGQ9+6Ml24xqD/wdft
         n4vXbySJTW+f3RRF+Or/M6IQ978AxmFHFEk8R4dYiEC3nsedg+Y89G0+gv0pJdkuKj
         SRxQ+/qda3gvIsHdM9/yXQrDklrkShxnO0UCi9FPoDmkO7LEzLVLq+oZ12AGOZiFF3
         /xUne9EnIylEj5YiZS1gPE5lyRgWgN5pvYlFILTwnlvaaziQtHI8HUJOcjoI09+XlB
         JdzQQb76LP8gDmuPD0hWbNqA/shCE+FnvY1+l/2VTC+DvlfMiYRzdpyJY4l4J6VbY9
         p5UpCF/ZY2waA==
Date:   Mon, 20 Sep 2021 16:19:28 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 09/12] RDMA/bnxt_re: Use GFP_KERNEL in non
 atomic context
Message-ID: <YUiKYESLcUjfvWgC@unreal>
References: <1631709163-2287-1-git-send-email-selvin.xavier@broadcom.com>
 <1631709163-2287-10-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631709163-2287-10-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 15, 2021 at 05:32:40AM -0700, Selvin Xavier wrote:
> Use GFP_KERNEL instead of GFP_ATOMIC while allocating
> control path structures which will be only called from
> non atomic context
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
> v1->v2:
> 	Using GFP_KERNEL in bnxt_re_netdev_event also
>  drivers/infiniband/hw/bnxt_re/main.c       | 2 +-
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
