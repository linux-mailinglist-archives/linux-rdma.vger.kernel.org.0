Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2450672EA88
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jun 2023 20:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjFMSH4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jun 2023 14:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjFMSHy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Jun 2023 14:07:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42EC19A7
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 11:07:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEC6F631F9
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 18:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A650EC433F0;
        Tue, 13 Jun 2023 18:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686679672;
        bh=bStpZzGOwnNjgB7buL3AsENNwCNpQ59qPTJrDmTXhMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OYmmxkOPcLl/S5RBi3m56MtconN9iSMRL9SFJzzuIQWtQYQDeOWzWHM189VfXnQaG
         uUVBMDL5GNwuopc/Pb8MvCLGIepqRPlAhE8fa12iplkZ/FKBolzallBEaZ+2zVrTGj
         XLK4s73Sxwgg/mTfPwhNjHldzOuVSfye2buISCZCnaEuGRtximGLWzQGid/jMF0ziw
         I8nsJFkSzxcK7Qv20LDikTZ2IGYdVaQqmpoaMgOpCEhgnOvNcYDAjwz6CrIxVkHprE
         Rdbuot3bD1yQEj9TDqjloqlHVAW3wKuM7b2bkvRW/3bH/4HPGtjbef7D0Xi8ktBUML
         8Wzf0zctEqBwg==
Date:   Tue, 13 Jun 2023 21:07:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2] RDMA/cma: prevent rdma id destroy during
 cma_iw_handler
Message-ID: <20230613180747.GB12152@unreal>
References: <20230612054237.1855292-1-shinichiro.kawasaki@wdc.com>
 <ZIcpHbV3oqsjuwfz@ziepe.ca>
 <3x4kcccwy5s2yhni5t26brhgejj24kxyk7bnlabp5zw2js26eb@kjwyilm5d4wc>
 <ZIhvfdVOMsN2cXEX@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIhvfdVOMsN2cXEX@ziepe.ca>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 13, 2023 at 10:30:37AM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 13, 2023 at 01:43:43AM +0000, Shinichiro Kawasaki wrote:
> > > I think there is likely some much larger issue with the IW CM if the
> > > cm_id can be destroyed while the iwcm_id is in use? It is weird that
> > > there are two id memories for this :\
> > 
> > My understanding about the call chain to rdma id destroy is as follows. I guess
> > _destory_id calls iw_destory_cm_id before destroying the rdma id, but not sure
> > why it does not wait for cm_id deref by cm_work_handler.
> > 
> > nvme_rdma_teardown_io_queueus
> >  nvme_rdma_stop_io_queues -> chained to cma_iw_handler
> >  nvme_rdma_free_io_queues
> >   nvme_rdma_free_queue
> >    rdma_destroy_id
> >     mutex_lock(&id_priv->handler_mutex)
> >     destroy_id_handler_unlock
> >      mutex_unlock(&id_priv->handler_mutex)
> >      _destory_id
> >        iw_destroy_cm_id
> >        wait_for_completiion(&id_priv->comp)
> >        kfree(id_priv)
> 
> Once a destroy_cm_id() has returned that layer is no longer
> permitted to run or be running in its handlers. The iw cm is broken if
> it allows this, and that is the cause of the bug.
> 
> Taking more refs within handlers that are already not allowed to be
> running is just racy.

So we need to revert that patch from our rdma-rc.

Thanks

> 
> Jason
