Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A085411564
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Sep 2021 15:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbhITNUf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Sep 2021 09:20:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233770AbhITNUe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Sep 2021 09:20:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BA7A604E9;
        Mon, 20 Sep 2021 13:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632143948;
        bh=vXavtGYjT6ye7/n+m86Qfal8WejUtWeImRaZy1pTD0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bkf+uJEZ0gf5JehEZHRaS18BHvV29+lMbILsGT+Q2I6dA13oblMv3dPxvldmU15VQ
         wAm3tlvWXH/wm6eRt8C4TqtKq7BucBwSQuGZ4ffd1y5t8sBIapVoZ45d4eTuBexaDi
         iEczYs1eOB4lzWEfajy6KKOmMdyIpqEyEm9IhJGv0l4Rgb5ogTMa7Md8sLFu6dkKLa
         GUCbMJUhGiX6fOz+VqWXUtmVzlm9eCQlmPiZMa+Qbtii3zXFaqvFJjC0e8zc6gOytn
         RWNQq3SxigAu6/VXUn4i96zzalNP/uwctBFQkV57DQsjtBkhbf5SsqUSYR+Hegam43
         oOwG2lIZcD7Pg==
Date:   Mon, 20 Sep 2021 16:19:04 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 07/12] RDMA/bnxt_re: Fix query SRQ failure
Message-ID: <YUiKSJEPxcT0Erv5@unreal>
References: <1631709163-2287-1-git-send-email-selvin.xavier@broadcom.com>
 <1631709163-2287-8-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631709163-2287-8-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 15, 2021 at 05:32:38AM -0700, Selvin Xavier wrote:
> Fill the missing parameters for the FW command while
> querying SRQ.
> 
> Fixes: 37cb11acf1f7 ("RDMA/bnxt_re: Add SRQ support for Broadcom adapters")
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
> v1->v2:
> 	Removed the duplicate line while populating srq->id
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
