Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7BE3537CB
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Apr 2021 12:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhDDKiD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Apr 2021 06:38:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229678AbhDDKiD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 4 Apr 2021 06:38:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2770C61364;
        Sun,  4 Apr 2021 10:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617532678;
        bh=V25n7n438uf2ugxUDPB9a9+bPTmE0/0C8xQOOxJ6MLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PGxH1Xr/PROEzkwiePjXMtzq0P7Xofq23LiqAY1u4+sacaRIjrBOxwwk+Mnpzlh5C
         yBYat4y2a1iVTJaciM32lz/ni12N3V6y/8x3yhgmTfXzTIsNebN+8WfPhezZgeXGt/
         5WRYy/zi5/NmNKsFgZ+PEmY/9WW53pFCeiabfjYWwdPZvvoFqWIK/Xt1EFKhnLOpAI
         T0cvjUUruahAvmrAo/dQPAaqwRbQK7483uD3vUmGZLM191yl5O7sSpyqsp+Io1b/T8
         1Jpy2dl01lxDUkxjaiwGKdiA51Pfu7ktRbvhq5C0kC/LWAI8o6l3ppWu7HDJrTzTHV
         6G2iJ6jzak8gw==
Date:   Sun, 4 Apr 2021 13:37:55 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        rajesh.sivaramasubramaniom@oracle.com,
        rama.nichanamatlu@oracle.com, aruna.ramakrishna@oracle.com,
        jeffery.yoder@oracle.com
Subject: Re: [PATCH v3] IB/mlx5: Reduce max order of memory allocated for xlt
 update
Message-ID: <YGmXAyANXwRGosIe@unreal>
References: <1617425635-35631-1-git-send-email-praveen.kannoju@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617425635-35631-1-git-send-email-praveen.kannoju@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Apr 03, 2021 at 04:53:55AM +0000, Praveen Kumar Kannoju wrote:
> To update xlt (during mlx5_ib_reg_user_mr()), the driver can request up to
> 1 MB (order-8) memory, depending on the size of the MR. This costly
> allocation can sometimes take very long to return (a few seconds). This
> causes the calling application to hang for a long time, especially when the
> system is fragmented.  To avoid these long latency spikes, the calls the
> higher order allocations need to fail faster in case they are not
> available. In order to acheive this we need __GFP_NORETRY flag in the
> gfp_mask before during fetching the free pages. This patch adds this flag
> to the mask.
> 
> Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
> ---
>  drivers/infiniband/hw/mlx5/mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks a lot,
Acked-by: Leon Romanovsky <leonro@nvidia.com>
