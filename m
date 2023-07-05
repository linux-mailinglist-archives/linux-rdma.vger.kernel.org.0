Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83725747FDE
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jul 2023 10:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjGEIkZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jul 2023 04:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjGEIkX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jul 2023 04:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C07CA
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jul 2023 01:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5733C614A0
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jul 2023 08:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7C7C433C7;
        Wed,  5 Jul 2023 08:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688546421;
        bh=YZEPVJbe8eBR6f/rYmrqxfd49CIPBEevX1RCUX4xzFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SYlRlnGTrO/c7y09oOTCsksd1EpdeLoSeY9YxCB8vFtoC/cGq28Pbh3UYn+ikhkLB
         ZNw6UK+D77vpi1cHrddlfdMsjvgfB6Kmhn85YXQ/bMjLycH0C2QLaBLUMIukXZss98
         1XYPj0Oave7kAHae+CV2bSrBCTugJJwCAx04cEjsFe/E+6UC33G0uwaPx1HOGDRA8a
         8vfUOiJ2eP1tDPUq8Gq2bqQN5J/b1lkS7f3d6Z20UUSVmGBusnfU0VVSkAtFWjTfNP
         zDTHNJJVobIg4f2lEmP64XFVv/s1UePCr+onJL+NAJrgIYigwDE44+tsx51q8S5syv
         QsFlsHDCLNPvQ==
Date:   Wed, 5 Jul 2023 11:40:17 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org, Daniel Vacek <neelx@redhat.com>
Cc:     Rogerio Moraes <rogerio@cadence.com>
Subject: Re: [PATCH v2] verbs: fix compilation warning with C++20
Message-ID: <20230705084017.GK6455@unreal>
References: <20230609153147.667674-1-neelx@redhat.com>
 <20230613131931.738436-1-neelx@redhat.com>
 <168854221298.91294.7240817458366723584.b4-ty@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168854221298.91294.7240817458366723584.b4-ty@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 05, 2023 at 10:30:12AM +0300, Leon Romanovsky wrote:
> 
> On Tue, 13 Jun 2023 15:19:31 +0200, Daniel Vacek wrote:
> > Our customer reported the below warning whe using Clang v16.0.4 and C++20,
> > on a code that includes the header "/usr/include/infiniband/verbs.h":
> > 
> > error: bitwise operation between different enumeration types ('ibv_access_flags' and
> > 'ib_uverbs_access_flags') is deprecated [-Werror,-Wdeprecated-enum-enum-conversion]
> >                 mem->mr = ibv_reg_mr(dev->pd, (void*)start, len, IBV_ACCESS_LOCAL_WRITE);
> >                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /usr/include/infiniband/verbs.h:2514:19: note: expanded from macro 'ibv_reg_mr'
> >                              ((access) & IBV_ACCESS_OPTIONAL_RANGE) == 0))
> >                               ~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
> > 1 error generated.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] verbs: fix compilation warning with C++20
>       https://git.kernel.org/rdma/rdma/c/9e5ccbfdd208a1

The more accurate link is https://github.com/linux-rdma/rdma-core/pull/1367

Thanks

> 
> Best regards,
> -- 
> Leon Romanovsky <leonro@nvidia.com>
