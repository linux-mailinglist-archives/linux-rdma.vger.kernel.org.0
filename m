Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D58172B8A9
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 09:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbjFLHeX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 03:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjFLHeW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 03:34:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE6B1BC1
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 00:29:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C20446103C
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 07:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6847C433D2;
        Mon, 12 Jun 2023 07:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686553957;
        bh=HG1g8kaMX+IDbgnF39u7ma7cuDqQCxCvUw4nAHPrWHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kL8ocS7nhQ4k+GKHlL9AZb0WyM5QOQy4oGa40XK3xy573EEla3lOIZQwqFKfoubxC
         SxUa1bCNrlUBRp8hcYohvUfndC1CNvPwcUmPtCmKNjt5fZF+RGpH+3KgoQfm0Bxsnm
         CShL9MmRltjLkXJ1L6eFVaRGeY7QcF7qEM6O4M9RPV1g6iMpu97tN5L3wABjxuizdH
         cP6a85ziRyzjJO1VBcRPRBtFkFJ0FRv1MWZM7xbQZT5iXdhfR9GV5W4O1R3T1BCPHV
         KSiWgXS/3XRUfKdcwIvlPaR/xECxA99C32jqUg936wQsAWSbV1E8aHBBwR/VpRkW7W
         b3pHiW11Ei9Jg==
Date:   Mon, 12 Jun 2023 10:12:32 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com, kashyap.desai@broadcom.com
Subject: Re: [PATCH v2 for-next 00/17] RDMA/bnxt_re: Control path updates
Message-ID: <20230612071232.GQ12152@unreal>
References: <1686308514-11996-1-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686308514-11996-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 09, 2023 at 04:01:37AM -0700, Selvin Xavier wrote:
> This patch series from Kashyap includes code refactoring and some
> optimizations in the FW control path of the driver. It also address
> some of the issues seen as we scale up the HW resources.
> It also includes few bug fixes in the control path.
> 
> Please review and apply.
> 
> Thanks,
> Selvin Xavier
> 
> v1 -> v2:
>  - Fix the warning reported by kbuild test robot in patch 10 about
>    variables set and not used. Rebased the other patches based on
>    the modified patch.
>  - Reported-by: kernel test robot <lkp@intel.com>
> 
> Kashyap Desai (17):
>   RDMA/bnxt_re: wraparound mbox producer index
>   RDMA/bnxt_re: Avoid calling wake_up threads from spin_lock context
>   RDMA/bnxt_re: remove virt_func check while creating RoCE FW channel
>   RDMA/bnxt_re: set fixed command queue depth
>   RDMA/bnxt_re: Enhance the existing functions that wait for FW
>     responses
>   RDMA/bnxt_re: Avoid the command wait if firmware is inactive
>   RDMA/bnxt_re: use shadow qd while posting non blocking rcfw command
>   RDMA/bnxt_re: Simplify the function that sends the FW commands
>   RDMA/bnxt_re: add helper function __poll_for_resp
>   RDMA/bnxt_re: handle command completions after driver detect a
>     timedout
>   RDMA/bnxt_re: Add firmware stall check detection
>   RDMA/bnxt_re: post destroy_ah for delayed completion of AH creation
>   RDMA/bnxt_re: consider timeout of destroy ah as success.
>   RDMA/bnxt_re: cancel all control path command waiters upon error.
>   RDMA/bnxt_re: use firmware provided max request timeout
>   RDMA/bnxt_re: remove redundant cmdq_bitmap
>   RDMA/bnxt_re: optimize the parameters passed to helper functions

I applied whole series as is. It looks good enough, but please address
my concern about atomit_t.

Thanks

> 
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h    |   2 +
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c   |  16 +-
>  drivers/infiniband/hw/bnxt_re/main.c       |  11 +-
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 627 ++++++++++++++++++++++-------
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  51 ++-
>  drivers/infiniband/hw/bnxt_re/qplib_res.h  |   1 +
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c   |   8 +-
>  drivers/infiniband/hw/bnxt_re/qplib_sp.h   |   4 +-
>  8 files changed, 557 insertions(+), 163 deletions(-)

> 
> -- 
> 2.5.5
> 


