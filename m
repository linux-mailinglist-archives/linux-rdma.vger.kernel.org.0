Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD5840894F
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 12:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239032AbhIMKq5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 06:46:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238997AbhIMKq4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Sep 2021 06:46:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 870A261004;
        Mon, 13 Sep 2021 10:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631529941;
        bh=0btrJIHkciDvxqYnkZtARaeiufoMQOYXN/2OqbEpK+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pr7cMs59UoXJ4sF80+hHbZ/Las6iRijhAJqgKHKDXkiNGkZVSkze4ARF7HXV4GCCM
         m5pRnwCp3lJQij2Xfgz+RfoF8/PWUAo9YxK9oGIAlokIUWohbK1LERmZ8yL5Bd2Twu
         +fokWPQmbjmUPAQqbSTjQ2oDYBf9b0JR7gI4eNfDqFlxXZzaceDA23GiQJ7Px9GTxs
         dqiuJ9HxaneJi4FIxmHTvFU/Aru3kAWkKH2uMZBTxZHOijZTujX33Y+XI4NU/zaOtA
         LLg1fgNG6lO8LKexni3mVzjXOwCnftetoCYoE6t79ddkj4YymWCzFf1YSi83gqynTu
         X+URYYBwigigA==
Date:   Mon, 13 Sep 2021 13:45:37 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 02/12] RDMA/bnxt_re: Update statistics counter
 name
Message-ID: <YT8r0dl4yE2SJah8@unreal>
References: <1631470526-22228-1-git-send-email-selvin.xavier@broadcom.com>
 <1631470526-22228-3-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631470526-22228-3-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 12, 2021 at 11:15:16AM -0700, Selvin Xavier wrote:
> Update a statistics counter name as the interface
> structure got updated.
> 
> Fixes: 9d6b648c3112 ("bnxt_en: Update firmware interface spec to 1.10.1.65.")
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/hw_counters.c | 4 ++--
>  drivers/infiniband/hw/bnxt_re/hw_counters.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
