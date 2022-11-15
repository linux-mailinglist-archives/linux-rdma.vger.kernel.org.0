Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D276292D2
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Nov 2022 08:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiKOH7o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 02:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbiKOH7k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 02:59:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B153BB4B5
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 23:59:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DDEBB816E3
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 07:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983CBC433D6;
        Tue, 15 Nov 2022 07:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668499177;
        bh=i78YKaD56DBby1rt/zSNia6NZPsXJdpUKrMTOEPcnSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aCArKKJcXC9b2IQ/85mOrXRb0gl8q8Qx4psa8On6Kzopsm87ClloyrZpFlEHOeZ4s
         lBIx7/aQUky5ZdFVsVt8n5iP+1olVr025H/vsCFSRD+1NHIRw894NTi0i+QAR3Vufq
         rm3Z0lqb+/VdAkcTeTZKO7RYXvATNtRWpIKlcvXkoVPLepfq55XAtYs3Vx6tQuyRqJ
         dttOBQiNcafyPg95nysolA5VN044bwtCNLYU12FI3he7IH9IecV/yLXaj/+lXDVn+p
         8VDCAfV+jAV3mXGoqzV/lkV4v8gQf2lM+KfHo95zB0i/3nBBjvynaVEOZPSVFK+b9N
         kJCMSwD8yJm0w==
Date:   Tue, 15 Nov 2022 09:59:27 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Or Har-Toov <ohartoov@nvidia.com>
Subject: Re: [PATCH rdma-next 0/4] Various core fixes
Message-ID: <Y3NG3zMxSFbmTYFk@unreal>
References: <cover.1667810736.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667810736.git.leonro@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 07, 2022 at 10:51:32AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Batch unrelated fixes.
> 
> Mark Zhang (3):
>   RDMA/restrack: Release MR restrack when delete
>   RDMA/core: Make sure "ib_port" is valid when access sysfs node
>   RDMA/nldev: Return "-EAGAIN" if the cm_id isn't from expected port

I took these three.

> 
> Or Har-Toov (1):
>   RDMA/nldev: Use __nlmsg_put instead nlmsg_put

This is not ready yet.

Thanks

> 
>  drivers/infiniband/core/nldev.c    | 110 ++++++++++++++---------------
>  drivers/infiniband/core/restrack.c |   2 -
>  drivers/infiniband/core/sysfs.c    |  17 +++--
>  3 files changed, 64 insertions(+), 65 deletions(-)
> 
> -- 
> 2.38.1
> 
