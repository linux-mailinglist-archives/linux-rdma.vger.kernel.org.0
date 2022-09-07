Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4765B0445
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 14:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiIGMva (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 08:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiIGMv0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 08:51:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF997CB65
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 05:51:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 757B3B81CC0
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 12:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9835CC4347C;
        Wed,  7 Sep 2022 12:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662555081;
        bh=kX1fEdgbpgeA+Uc8I3t0B7Xx7X2EuMPL087s9UV+c7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HmX93yQ3sFuVa9lihJ3zpYeGa2Muqh+3fFQSPlD2KcVAEhHe8AFjBA1VEAPJEk2ia
         xoC7f6RppiO/J/MbLdYKRwtqxvM67F8ftQao6oTLgGvQrCjrNZ/jX9GCBCy4aVOal3
         qJL7kOvw2UldC8IzXCdX4Ctq5F6MS5r6WtLLZ93tShOzif7qvL/DQX0bqf9Iuv4amC
         hcOOrlXAujne6TQ31ua31CGohwIpLVjKxx3kL3Eunv/egjGwp85ynV0vBgvhBmZOeI
         2jY+U6kr3c9ZANudMeJ4fKqAmNNKt3P6iL17vZcpzDPWTj/L9nZLVNN4hEMNYgC8f/
         ioWq7NA3tU/NA==
Date:   Wed, 7 Sep 2022 15:51:16 +0300
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
Message-ID: <YxiTxJvDWPaB9iMf@unreal>
References: <20220907113800.22182-1-phaddad@nvidia.com>
 <20220907113800.22182-5-phaddad@nvidia.com>
 <facc31c4-955e-c82e-191b-150313e73f6a@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <facc31c4-955e-c82e-191b-150313e73f6a@grimberg.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 07, 2022 at 03:34:21PM +0300, Sagi Grimberg wrote:
> 
> > From: Israel Rukshin <israelr@nvidia.com>
> > 
> > Add debug prints for fatal QP events that are helpful for finding the
> > root cause of the errors. The ib_get_qp_err_syndrome is called at
> > a work queue since the QP event callback is running on an
> > interrupt context that can't sleep.
> > 
> > Signed-off-by: Israel Rukshin <israelr@nvidia.com>
> > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> 
> What makes nvme-rdma special here? Why do you get this in
> nvme-rdma and not srp/iser/nfs-rdma/rds/smc/ipoib etc?
> 
> This entire code needs to move to the rdma core instead
> of being leaked to ulps.

We can move, but you will lose connection between queue number,
caller and error itself.

As I answered to Christoph, we will need to execute query QP command
in a workqueue outside of event handler.

So you will get a print about queue in error state and later you will
see parsed error print somewhere in the dmesg.

Thanks
