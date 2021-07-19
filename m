Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C198D3CCE0A
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jul 2021 08:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbhGSGnJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jul 2021 02:43:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233048AbhGSGnJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Jul 2021 02:43:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81EE661166;
        Mon, 19 Jul 2021 06:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626676810;
        bh=PLhWDAfOi4XTMRGXfe3gd5G0uRCleXXWpyA73q/XsbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=chxeUPwtbuX/k9qLGUPJTsJBWLeWswr8fXLE7sr3onKKovzeJ00kjs0n/A3ZOsQh8
         S60Ma2Z01GFedblSe3sdva3b2pxe7dg+CB2xS630u4ypmfZwSMPb2tUDx/MVka6Lsn
         88CD4sd/T99AG0/vq7iDM/ZkaxJj2vP/Q48cknQMshGKafGcLL/t9hmy/TWkeTRDk3
         s4GDX30ZxUs/ctD7SRf+W9LigMulZn30hJ4MMYvZF6R2koiBXDL8fXuoxvFLqcrdzT
         nfsjyzgsdFfChfTEpMs+Q/frSFbfDvvWVAKtptLDa4a2LhW0/ZXGZZSIFwqaLrM2gR
         /+sSyOVLc5Djg==
Date:   Mon, 19 Jul 2021 09:40:07 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Chesnokov Gleb <Chesnokov.G@raidix.com>
Cc:     "lanevdenoche@gmail.com" <lanevdenoche@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: Re: [PATCH 1/1] iser-target: Fix handling of
 RDMA_CV_EVENT_ADDR_CHANGE
Message-ID: <YPUeR9h6Zf6nGe6e@unreal>
References: <20210714182646.112181-1-Chesnokov.G@raidix.com>
 <YPPrY1MW51aFRSVb@unreal>
 <9e97e113abb64952a22430462310ca83@raidix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e97e113abb64952a22430462310ca83@raidix.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 18, 2021 at 06:24:26PM +0000, Chesnokov Gleb wrote:
> Hi Leon,

Please don't use top-posting format. Thanks

> 
> 
> isert_cma_handler() is called from cma_work_handler(), which holds id_priv->handler_mutex.
> The call of rdma_destroy_id() from isert_cma_handler() will cause recursive acquisition of the mutex, leading to a deadlock.
> 
> -- cma_work_handler()
> ---- mutex_lock(&id_priv->handler_mutex)
> ---- isert_cma_handler()
> ------ rmda_destroy_id()
> -------- mutex_lock(&id_priv->handler_mutex)

This answers why you needed workqueue.

> 
> Therefore, you cannot directly call isert_np_reinit_id().

I would expect rdma-cm to be changed to support such flow.
However it is probably overkill.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
