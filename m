Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A68C40899C
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 12:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238710AbhIMK6c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 06:58:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234958AbhIMK6b (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Sep 2021 06:58:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B689B61004;
        Mon, 13 Sep 2021 10:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631530636;
        bh=otu7enRDsNjQxipwMsrwmLGKcC2VXEBR1nqPoix2y+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RnkW5v0UWFzC18CyUSlIGeAvjnwhLd9xFcmf30dfmUWkmSafQuaOwCtyohaWLF8lJ
         J5Ar5S024yqqyV+H7kGw6WUft5lVbHYoFCXeJKQKZIMlPKG+4Kj4tISLO0ht+KH5Sf
         vnofElZxnYt3P9Ef1wHaAh95owibfj4brKrZ8NFITjZLW9cOPyvSsu+x6dpsuyM0Ak
         5u8oa07sJSTmgyKzTpM0jpxylJujZTA5q2zaJOTHOXMJDSBXMHUPGdfuu/1Yzu2u6P
         /Om6rX+4P8Dh2oZTfyfbyqG1hNFnMAMJHIw0l5rdrCp4Ikp2rAWjRcycV/DOLc/mSu
         BFTqkv5eTQzFA==
Date:   Mon, 13 Sep 2021 13:57:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 08/12] RDMA/bnxt_re: Fix FRMR issue with single
 page MR allocation
Message-ID: <YT8uiBFv+2BZgtcO@unreal>
References: <1631470526-22228-1-git-send-email-selvin.xavier@broadcom.com>
 <1631470526-22228-9-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631470526-22228-9-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 12, 2021 at 11:15:22AM -0700, Selvin Xavier wrote:
> When the FRMR is allocated with single page, driver is
> attempting to create a level 0 HWQ and not allocating any page
> because the nopte field is set. This causes the crash during post_send
> as the pbl is not populated.
> 
> To avoid this crash, check for the nopte bit during HWQ
> creation with single page and create a level 1 page table
> and populate the pbl address correctly.
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_res.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
