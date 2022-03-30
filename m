Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240624EBFA3
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Mar 2022 13:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343554AbiC3LQA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Mar 2022 07:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343552AbiC3LP6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Mar 2022 07:15:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A14A8EF2
        for <linux-rdma@vger.kernel.org>; Wed, 30 Mar 2022 04:14:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 970776140F
        for <linux-rdma@vger.kernel.org>; Wed, 30 Mar 2022 11:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A78DC340EC;
        Wed, 30 Mar 2022 11:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648638852;
        bh=824fHp8UzsjxsEwPtsjT21yijJTAwVqn6Gd6EwB5FIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BM5Al/34fDjEC/YbcaYFM+ifffXV6GMnHOBT54gYiDxC2uQakGJy5dIknnXvWALhw
         GOHdWiQjNSCWAkzZHC2wRiwMDSPtTM/3ztx4NlnpMGoDq+yOBMd8PgD+yDtZ/GPRiI
         6GehFOVPR1S1BGVfjYnGnFmq46MthObks0VE4tZErYfXJdMLnmrpbJe1h6AXBSxx/x
         FPZoyfH7pUKYEyQFV99aHTqWvOFpVv9Cf+nnauEiT5SD2gFHA/C3ep8BBrV4dV0P5J
         dCpbkHe/Dek9D6kj4yjGlCJS5ATMNub1c/DQqd1XsA/UCm+mqVg9VilsDZ2araQBrc
         LnkOwlhd+MNXg==
Date:   Wed, 30 Mar 2022 14:14:08 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, jgg@nvidia.com
Subject: Re: [PATCH v3 2/2] IB/uverbs: Move part of enum ib_device_cap_flags
 to uapi
Message-ID: <YkQ7gO5hneFIvDw5@unreal>
References: <20220328154511.305319-1-yangx.jy@fujitsu.com>
 <20220328154511.305319-2-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328154511.305319-2-yangx.jy@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 28, 2022 at 11:45:11PM +0800, Xiao Yang wrote:
> 1) Part of enum ib_device_cap_flags are used by ibv_query_device(3)
>    or ibv_query_device_ex(3), so we define them in
>    include/uapi/rdma/ib_user_verbs.h and only expose them to userspace.
> 
> 2) Reformat enum ib_device_cap_flags by removing the indent before '='.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/core/uverbs_cmd.c |   6 +-
>  include/rdma/ib_verbs.h              | 104 +++++++++++++++++----------
>  include/uapi/rdma/ib_user_verbs.h    |  31 ++++++++
>  3 files changed, 101 insertions(+), 40 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
