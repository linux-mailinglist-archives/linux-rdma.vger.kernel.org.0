Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FB45BF7CC
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Sep 2022 09:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiIUHgC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Sep 2022 03:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiIUHgB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Sep 2022 03:36:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ED983BD4
        for <linux-rdma@vger.kernel.org>; Wed, 21 Sep 2022 00:36:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A364262F92
        for <linux-rdma@vger.kernel.org>; Wed, 21 Sep 2022 07:36:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F20C433D7;
        Wed, 21 Sep 2022 07:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663745760;
        bh=7qve/Pa4mSoh4l/jO/2p/CCRRvU3Px/ZW9nT44guToM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GU7ZvAWPSPbnEr5Kg87dgb/161EGGrRDlbjtv0fSri2+dJEO+liuVVHao3GI+xYcl
         Ub5WyY/rJTh3+vaN4KnFQmdSY7Nd48g9GSApjkEZwtLp17Z+8Rl9iMFFGFuELOwjoD
         QhRQuVzQVowchO56p93dD6xIS8UFtAIx4B+DMEXXkH0kaE2u8RGNtdsi/GcQzBuW8k
         gDckgJR+P0Ys9qBSSKoqr6lFHQVZL4FjHQUf/6wx8azHyQotdQAEchsQXhDrxHOovD
         uROtB+03QdbB7mHzHcLQVG0j4cXnZQE50A9y6m2NKK43uSQbFakeO/56RPvDppthSI
         jAyS8lFliZSJQ==
Date:   Wed, 21 Sep 2022 10:35:55 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next 4/4] RDMA/erdma: Support dynamic mtu
Message-ID: <Yyq+24CUolthp2lo@unreal>
References: <20220909093822.33868-1-chengyou@linux.alibaba.com>
 <20220909093822.33868-5-chengyou@linux.alibaba.com>
 <YymkwSPZa3B0oTKk@unreal>
 <4f2425e1-4326-c337-5bc5-06400a6cce62@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f2425e1-4326-c337-5bc5-06400a6cce62@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 21, 2022 at 10:28:57AM +0800, Cheng Xu wrote:
> 
> 
> On 9/20/22 7:32 PM, Leon Romanovsky wrote:
> > On Fri, Sep 09, 2022 at 05:38:22PM +0800, Cheng Xu wrote:
> >> Hardware now support jumbo frame for RDMA. So we introduce a new CMDQ
> >> message to support mtu change notification.
> >>
> <...>
> > 
> > I don't see any backward compatibility here. How can you make sure that
> > new code that supports MTU change works correctly on old FW/device?
> > 
> 
> In this case, driver needn't to consider backward compatibility.
> 
> ERDMA hardware is programmable part of our iaas infrastructure, and can be
> hot-update without BMs/VMs awareness.Before I submitted this patch, all the
> FWs has been updated, and support this feature, no old FWs exist.

I'm not big fan of such answers, but ok, applied.

> 
> Thanks,
> Cheng Xu
> 
> 
