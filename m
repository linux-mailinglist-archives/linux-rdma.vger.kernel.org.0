Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE66D5A44E4
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 10:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiH2IVP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 04:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiH2IVO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 04:21:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3294C622
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 01:21:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57417B80D82
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 08:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95838C433C1;
        Mon, 29 Aug 2022 08:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661761271;
        bh=XHuZMQDQqYJkXffcZdMMfZb+6h1l8GH9MdgmFENZm1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f8rkLVZk2/xjO3nS/RtxNsyQ/panPV8RNESPMEvZiHrjw9Os+hLbzpzSDh5vkFG3q
         RCQvLTTBBhFqY+GDdJ8AkYA/+qZ3wOmwmP1eeuzg9qxFlE/uFEtRPEO3sgSL4Iqf9i
         3b6B24yT4hQngKDL/kdKrUBxoVl+/0HkKbqht3+Snd71kbbPCVsz7lulArYitkrB+F
         Lavdntnp+3F3tgw4nK3V+Uq6IUFQ7ve6CX+VI4IhSf7xAIrFkR/j58BlTb5pHQqMGm
         oflXbbLdqbEDplrr9P19SGdZVh4I8vyYwIYAIPtrZjggRWyFIeWHpDNM8N4a0tvxU5
         XvR+HfqwdP6Rw==
Date:   Mon, 29 Aug 2022 11:21:06 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Mark Zhang <markzhang@nvidia.com>
Cc:     jgg@nvidia.com, dledford@redhat.com,
        jiapeng.chong@linux.alibaba.com, cgel.zte@gmail.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 0/3] IB/cm refactors
Message-ID: <Ywx28s1unjnB19RT@unreal>
References: <20220819090859.957943-1-markzhang@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819090859.957943-1-markzhang@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 19, 2022 at 12:08:56PM +0300, Mark Zhang wrote:
> Hi,
> 
> This series provides 2 IB/cm refactors:
> - The first 2 patches remove the usage of service_mask, as it is
>   always -1 so it doesn't help;
> - The third one refines cm_insert_listen() and cm_find_listen().
> 
> Link: https://lore.kernel.org/lkml/20220624201733.GA284068@nvidia.com/t/
> 
> Thanks.
> 
> Mark Zhang (3):
>   IB/cm: Remove the service_mask parameter from ib_cm_listen()
>   IB/cm: remove cm_id_priv->id.service_mask and service_mask parameter
>     of cm_init_listen()
>   IB/cm: Refactor cm_insert_listen() and cm_find_listen()
> 

Thanks, applied.
