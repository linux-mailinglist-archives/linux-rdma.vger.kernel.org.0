Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1024DAD39
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 10:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242595AbiCPJKP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Mar 2022 05:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiCPJKO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Mar 2022 05:10:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A2F5BD2D;
        Wed, 16 Mar 2022 02:09:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA50B61582;
        Wed, 16 Mar 2022 09:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDA8C340E9;
        Wed, 16 Mar 2022 09:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647421705;
        bh=rPQpV9Lw/eMshhljsz2yvsSqLDbzQaQMWnQQeOMi9vE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=krhQjgx9rU6Eb4MiqdCu4Zd0+Ggw4nBA+QiiwaVAN6F60rnCpOcihsW9Gj2F/fFj6
         Im+iN4N2qvESzTG2Bae2lh6eMYTG54TlrcblXfUXxjLsKxvfddIijTYTfO8vvrraFO
         B0kekjLOgW9nGIueuPck03pmkXgoCNR4OsYlK/7SXcDQ8O+qH6im76BCkeVOQKAtUc
         L7vX+0xHjXPv2oNG481fij/HjvZOgFwSALCECe7QygGHddhrb/XnPhvWW2T390A+Dl
         TsHlr+oN5bBok/VsZyKMN5regO2pm/8VSSKEV9Fj+X73IwNTb0jFxok3fT/FxVERsG
         OkQY3C4JgcpnA==
Date:   Wed, 16 Mar 2022 11:08:20 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Aharon Landau <aharonl@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Neta Ostrovsky <netao@nvidia.com>,
        Gal Pressman <galpress@amazon.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/nldev: prevent underflow in
 nldev_stat_set_counter_dynamic_doit()
Message-ID: <YjGpBOCMPOwMBwgg@unreal>
References: <20220316083948.GC30941@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316083948.GC30941@kili>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 16, 2022 at 11:39:48AM +0300, Dan Carpenter wrote:
> This code checks "index" for an upper bound but it does not check for
> negatives.  Change the type to unsigned to prevent underflows.
> 
> Fixes: 3c3c1f141639 ("RDMA/nldev: Allow optional-counter status configuration through RDMA netlink")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Could we not use a nldev_policy[] to tighten the bounds checking even
> more?

We are doing it, when calling to nlmsg_parse() at the beginning of nldev_stat_set_doit().
The entry_attr, which used as input to index, is tb[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_INDEX].

However it is not enough and we still need your change, because input
can be large enough to be casted to negative value.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
