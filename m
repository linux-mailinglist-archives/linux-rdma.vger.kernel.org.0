Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFD35B0B7F
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 19:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiIGRaF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 13:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIGRaE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 13:30:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821093E744
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 10:30:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F0ED619C0
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 17:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B781FC433D6;
        Wed,  7 Sep 2022 17:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662571802;
        bh=HcpuT1k8vIRFDlu19npUOail7FyeszHBKFkYe1UKWHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ot52I5qoqmjJaG9iItngoInoRS5pxivCftukAq9o7AMz4EFyNU8NHZ4MyjtVVAf85
         BSw98jzK4qcKQcGrj8blEeiCfKkkZ7dfAoBaLUDLl5KzdzMtkwg1pu6lS6hVoSsp6H
         ua03PZEMBScgqVIWHwxXDSf+JakopcCBPjRnHkPRq+2VX+/dRo6g7bqvg2LuiA7+QR
         TzKdEGvX/m4WgYHL6GILUnwBrmEBSrDYr54mL6UKeqlF2t6ReUjLAS2KkRW3SZzNPw
         XizAfy0Q9W1kB6Q+yUYNdbpDaufuMpBfIS0eHXhGA2Pan8dRMtXzh8Scwaagnv4xUR
         UfHuMDi6reuLA==
Date:   Wed, 7 Sep 2022 20:29:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Patrisious Haddad <phaddad@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Israel Rukshin <israelr@nvidia.com>,
        Linux-nvme <linux-nvme@lists.infradead.org>,
        linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH rdma-next 4/4] nvme-rdma: add more error details when a
 QP moves to an error state
Message-ID: <YxjVFZYMLh19vwNR@unreal>
References: <20220907113800.22182-1-phaddad@nvidia.com>
 <20220907113800.22182-5-phaddad@nvidia.com>
 <facc31c4-955e-c82e-191b-150313e73f6a@grimberg.me>
 <YxiTxJvDWPaB9iMf@unreal>
 <ac268c86-c013-5cc5-5e1c-71ee90111d8f@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac268c86-c013-5cc5-5e1c-71ee90111d8f@grimberg.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 07, 2022 at 06:16:05PM +0300, Sagi Grimberg wrote:
> 
> > > > From: Israel Rukshin <israelr@nvidia.com>
> > > > 
> > > > Add debug prints for fatal QP events that are helpful for finding the
> > > > root cause of the errors. The ib_get_qp_err_syndrome is called at
> > > > a work queue since the QP event callback is running on an
> > > > interrupt context that can't sleep.
> > > > 
> > > > Signed-off-by: Israel Rukshin <israelr@nvidia.com>
> > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > What makes nvme-rdma special here? Why do you get this in
> > > nvme-rdma and not srp/iser/nfs-rdma/rds/smc/ipoib etc?
> > > 
> > > This entire code needs to move to the rdma core instead
> > > of being leaked to ulps.
> > 
> > We can move, but you will lose connection between queue number,
> > caller and error itself.
> 
> That still doesn't explain why nvme-rdma is special.

It was important for us to get proper review from at least one ULP,
nvme-rdma is not special at all.

> 
> In any event, the ulp can log the qpn so the context can be interrogated
> if that is important.

ok
