Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0108472B8F1
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 09:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbjFLHnu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 03:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbjFLHnp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 03:43:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF942173A
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 00:43:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D041F61198
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 07:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D08C4339B;
        Mon, 12 Jun 2023 07:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686553650;
        bh=hDOdrUVsiFKT4C+s+l6wl40gbyWzeXDJnT7poMSSApc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pG8z54y08n9iVZNcZ7V+mCsrufgHH09ypz7nSPYzAo8ovyjZfeLEdh/X6BuantDiC
         SUphMaaceRomBO3sV1z2oBeFVwf9iNmpuSYM/ouWj/GOiEZxubaQN1tDTOsZQ0hxKf
         +aeYbZArhWH4Jxo98DeBSAs+jD/bVILdbrGGt3BMckdwfL7Ydn7LUmNMNyBjNQHmYW
         alEXJIvkRUMJWjNfBfryK017Z1yv4EpQQRmdGIINZz3VYxrw9/B+JpbAoW/FC2Yvbm
         cnLs+qp+5yMtPt26byLqRq8PddMengduCW5ps/sxAgKHlVkV/cnuG+VdJCGeyr5RBd
         iPG4pgCrHuN7w==
Date:   Mon, 12 Jun 2023 10:07:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com, kashyap.desai@broadcom.com
Subject: Re: [PATCH v2 for-next 10/17] RDMA/bnxt_re: handle command
 completions after driver detect a timedout
Message-ID: <20230612070726.GP12152@unreal>
References: <1686308514-11996-1-git-send-email-selvin.xavier@broadcom.com>
 <1686308514-11996-11-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686308514-11996-11-git-send-email-selvin.xavier@broadcom.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 09, 2023 at 04:01:47AM -0700, Selvin Xavier wrote:
> From: Kashyap Desai <kashyap.desai@broadcom.com>
> 
> If calling context detect command timeout, associated memory stored on
> stack will not be valid. If firmware complete the same command later,
> this causes incorrect memory access by driver.
> 
> Added is_waiter_alive to handle delayed completion by firmware.
> is_waiter_alive is set and reset under command queue lock.
> 
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 59 +++++++++++++++++-------------
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  1 +
>  2 files changed, 34 insertions(+), 26 deletions(-)

<...>

>  		/* Non zero means command completed */

This comment is not valid anymore.

> -		ret = wait_event_timeout(cmdq->waitq,
> -					 !test_bit(cbit, cmdq->cmdq_bitmap),
> -					 msecs_to_jiffies(10000));
> +		wait_event_timeout(cmdq->waitq,
> +				   !test_bit(cbit, cmdq->cmdq_bitmap),
> +				   msecs_to_jiffies(10000));

Thanks
