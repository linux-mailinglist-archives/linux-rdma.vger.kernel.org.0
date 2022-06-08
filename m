Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C1A54299A
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jun 2022 10:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiFHIkD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jun 2022 04:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiFHIi7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jun 2022 04:38:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A4819C776;
        Wed,  8 Jun 2022 00:58:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A8F25CE22A7;
        Wed,  8 Jun 2022 07:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34578C34116;
        Wed,  8 Jun 2022 07:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654675121;
        bh=bZaPM/mp8RwxLub9IsiDeiMNZrdMKtTn/10ONtEPgn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iRATOqTt4wElTcC/t7EM2XzGan5sgHLjWqOgBTvpjnvA8m++8Em4matDpmE0dBNID
         aL5IKO6/DaZYDqbTCfVYTYP2M1WNYfR5Vljlw0WpQIQTraD8QbUBKKl2I5z31Gk8Em
         w08iZ/TTyoByF4YxhY5iecjY7StOx9r6ISI9Pzn5K6lmVBRE595UsJ06vzq1B1xZr8
         /NwhVs7lC4BvrN7/L6x2kyuYWX5yFxqNrKtkZ5Zx25ewiyPPzc5ZGzqONC3wFZu9l3
         nX2K+WsWiUTJVujtsz0Gn1+mZUTWe+So1aPBeCjR6u9TuJHHRGaqFCyvf2d2ygtCrk
         t2yML2xFHH61g==
Date:   Wed, 8 Jun 2022 10:58:37 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, kaishen@linux.alibaba.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] RDMA/erdma: remove unneeded semicolon
Message-ID: <YqBWrU27/wNsLU/u@unreal>
References: <20220608005534.76789-1-yang.lee@linux.alibaba.com>
 <ef94d5de-da12-a894-8ff3-af7ecf9d568a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef94d5de-da12-a894-8ff3-af7ecf9d568a@linux.alibaba.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 08, 2022 at 11:36:07AM +0800, Cheng Xu wrote:
> 
> 
> On 6/8/22 8:55 AM, Yang Li wrote:
> > Eliminate the following coccicheck warning:
> > ./drivers/infiniband/hw/erdma/erdma_qp.c:254:3-4: Unneeded semicolon
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> 
> Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
> 
> Thanks.
> 
> 
> Jason,
> 
> BTW, are this and other two patches for erdma posted today parts of
> the static checker reports which you mentioned in [1] ? If so, I think I
> should re-post the v10 patches including the fixes ?

Yes, the fixes need to be squashed into the relevant patches.

Thanks

> 
> Thanks,
> Cheng Xu
> 
> [1] https://lore.kernel.org/linux-rdma/20220606154754.GA645238@nvidia.com/
