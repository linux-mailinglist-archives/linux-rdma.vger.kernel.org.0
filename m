Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC255FD7F0
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Oct 2022 12:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJMKtq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Oct 2022 06:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiJMKtp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Oct 2022 06:49:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35883A1A2
        for <linux-rdma@vger.kernel.org>; Thu, 13 Oct 2022 03:49:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 361D76177B
        for <linux-rdma@vger.kernel.org>; Thu, 13 Oct 2022 10:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103B2C433D6;
        Thu, 13 Oct 2022 10:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665658182;
        bh=xgJUIoH3QGNw0fuX3cYjk3VdMddQBwAljIZvFG8xmKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Udviwxs8nNwmUnQgADvfftYlVcgGKK13cwPEJZd5DfTN/luglqgksCeE7wrXjXaAK
         4XFnbwYAfC+ysWhg+VGMWC7iQU5P66PSgcQxMrh2hUJlmoG44Z0saMl6zBIzf4f2gJ
         gwtY632kFKj7XUk8O7P9yr6DQ5xiPJxL6AguJ5o0I+9BL+beMmFdCFwIoBzuFY8NAk
         PBWTV8+4kcoKS7Ok1umQ4IKlYrb23KKC0xphULqAF+sBhe/c68M0EoR9bSNscJWfmb
         e0HibOod8QUJC9Kz0jOEZMgkbVxQ5pIfEYbLlH9iLYzlrWFI2nzQSXBuIg/1WUodC0
         81Z+RHf27F6+Q==
Date:   Thu, 13 Oct 2022 13:49:38 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-rc] RDMA/cma: Use output interface for net_dev check
Message-ID: <Y0ftQidCuDwbiT3m@unreal>
References: <20221012141542.16925-1-haakon.bugge@oracle.com>
 <Y0fPvlrpapweqrdA@unreal>
 <6068AC23-108C-47B2-ACC2-8664040D4C8B@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6068AC23-108C-47B2-ACC2-8664040D4C8B@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 13, 2022 at 10:31:55AM +0000, Haakon Bugge wrote:
> 
> 
> > On 13 Oct 2022, at 10:43, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > On Wed, Oct 12, 2022 at 04:15:42PM +0200, Håkon Bugge wrote:
> >> Commit 27cfde795a96 ("RDMA/cma: Fix arguments order in net device
> >> validation") swapped the src and dst addresses in the call to
> >> validate_net_dev().
> >> 
> >> As a consequence, the test in validate_ipv4_net_dev() to see if the
> >> net_dev is the right one, is incorrect for port 1 <-> 2 communication
> >> when the ports are on the same sub-net. This is fixed by denoting the
> >> flowi4_oif as the device instead of the incoming one.
> >> 
> >> The bug has not been observed using IPv6 addresses.
> >> 
> >> Fixes: 27cfde795a96 ("RDMA/cma: Fix arguments order in net device validation")
> >> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> >> ---
> >> drivers/infiniband/core/cma.c | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> > 
> > Thanks,
> > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> 
> Thank you for your quick review Leon!

Sure, just as a note. We won't take any patches before -rc1.

Thanks

> 
> 
> Håkon
> 
> 
