Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5CE5FD65D
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Oct 2022 10:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiJMInt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Oct 2022 04:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiJMIns (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Oct 2022 04:43:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD64811C245
        for <linux-rdma@vger.kernel.org>; Thu, 13 Oct 2022 01:43:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EA2D61650
        for <linux-rdma@vger.kernel.org>; Thu, 13 Oct 2022 08:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04ED0C433C1;
        Thu, 13 Oct 2022 08:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665650626;
        bh=LAuHilzhpRx+30a7otEBFQ0jBplpUeRBy5RH919U7Zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lwo0Rii5qQQvEDNWip3jaZS5CRS65qTbST05cdumVlW3KR/Vg+KZEJFhUXn5KhTlr
         ww+eViZj/YKgBfMVcWewHkEfc5CgEJsyv3cTuhQHKa9vjYk2sdBwtZwPPsfrAeHogz
         rVJ0uijxLw+SllctVDWC/yQ6XI58wo6St+Ejqyy3C+pWp6KKRYViOQJinFk+ODqgIJ
         K5rc1QacnqBbDdDieIg0LZ2IUNzf69b2hyRCCMb5N/iVltGKUWR72hzG25zghCaOD2
         0RsGI748GwMcblcWvXi4rLhorfOPg4uNIUaPhXatZ2Va7+t2fZmvOim8waQ00rA3jB
         uB+9x6nShYM/g==
Date:   Thu, 13 Oct 2022 11:43:42 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/cma: Use output interface for net_dev check
Message-ID: <Y0fPvlrpapweqrdA@unreal>
References: <20221012141542.16925-1-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221012141542.16925-1-haakon.bugge@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 12, 2022 at 04:15:42PM +0200, Håkon Bugge wrote:
> Commit 27cfde795a96 ("RDMA/cma: Fix arguments order in net device
> validation") swapped the src and dst addresses in the call to
> validate_net_dev().
> 
> As a consequence, the test in validate_ipv4_net_dev() to see if the
> net_dev is the right one, is incorrect for port 1 <-> 2 communication
> when the ports are on the same sub-net. This is fixed by denoting the
> flowi4_oif as the device instead of the incoming one.
> 
> The bug has not been observed using IPv6 addresses.
> 
> Fixes: 27cfde795a96 ("RDMA/cma: Fix arguments order in net device validation")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/core/cma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
