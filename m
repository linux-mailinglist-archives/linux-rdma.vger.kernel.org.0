Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C1B577EA8
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 11:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiGRJ3c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 05:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiGRJ3b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 05:29:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3288F19C3C
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 02:29:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C4E6614D2
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 09:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8578C341C0;
        Mon, 18 Jul 2022 09:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658136568;
        bh=jYliLvo0ELIhESLKKDhiyaM8o1PzJ4FBJGQ1Od8RGeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F/sVEOIdZvCTRxd33xh1C84guCkwO2hf/E3b264aZLHpUwfmjUfXRQKSPlj2deRPT
         FoFvzPR2FV0OiAdkMrUSiBBFEvn16oxjB/ayPN9djEATqYCZAHH9NTp5zXOWzEwhzf
         PLfr6EKFUkn5bD2EWsy3IUAlUi3UCIlnPVj1LvlmGso2rfuyXGX83Wzj7gNUX4dTzt
         aDBS2tcBjTEj5eGQQIH6wGmOzIleJsNmgm6oqcfT0WXcA8ve/PxBaSyZ2cjI99oeIj
         m3PSR3R2vz5vj2ZPmjeYwl2Z7QwynKdGKWDEdKUMsHoMIDMURBRGi5ixMZc1W8eOfv
         5CXlnHZpdXd5g==
Date:   Mon, 18 Jul 2022 12:29:17 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Md Haris Iqbal <haris.iqbal@ionos.com>
Cc:     linux-rdma@vger.kernel.org, jgg@ziepe.ca, jinpu.wang@ionos.com
Subject: Re: [PATCH v2 for-next 0/5] Misc patches for RTRS
Message-ID: <YtUn7YcUNIviWgH5@unreal>
References: <20220712103113.617754-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712103113.617754-1-haris.iqbal@ionos.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 12, 2022 at 12:31:08PM +0200, Md Haris Iqbal wrote:
> Hi Jason, hi Leon,
> 
> Please consider to include following changes to the next merge window.
> 
> The patchset is organized as follows:
> 1: change to make stringify work for a module param
> 2: a change to avoid disable/enable of preemption
> 3: replace normal stats structure with percpu version
> 4: Fixes some checkpatch warnings
> 5: removes allocation and usage of mempool
> 
> Jack Wang (2):
>   RDMA/rtrs-srv: Fix modinfo output for stringify
>   RDMA/rtrs-srv: Do not use mempool for page allocation
> 
> Md Haris Iqbal (1):
>   RDMA/rtrs-clt: Replace list_next_or_null_rr_rcu with an inline
>     function
> 
> Santosh Kumar Pradhan (2):
>   RDMA/rtrs-clt: Use this_cpu_ API for stats
>   RDMA/rtrs-srv: Use per-cpu variables for rdma stats
> 
>  drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 14 ++------
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 35 +++++++++-----------
>  drivers/infiniband/ulp/rtrs/rtrs-pri.h       | 21 ++++++------
>  drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c | 32 +++++++++++++-----
>  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |  2 ++
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 32 ++++++++----------
>  drivers/infiniband/ulp/rtrs/rtrs-srv.h       | 15 +++++----
>  7 files changed, 78 insertions(+), 73 deletions(-)

I took the patches, but please next time do not use vertical space
alignment for new code.

Thanks

> 
> -- 
> 2.25.1
> 
