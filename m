Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE29595D70
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Aug 2022 15:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiHPNcT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Aug 2022 09:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbiHPNcS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Aug 2022 09:32:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A014BB9416
        for <linux-rdma@vger.kernel.org>; Tue, 16 Aug 2022 06:32:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40C57B819C9
        for <linux-rdma@vger.kernel.org>; Tue, 16 Aug 2022 13:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7503EC433C1;
        Tue, 16 Aug 2022 13:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660656735;
        bh=UbuRqM+mGfiu1vAkl9lQd7LVK0lqllIHzBcI+v/mfCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sXNlDb3jHHcMe66hdHGiPXC2pb+yjO14hYrj8Qp53AcXTlaSPunOR7R+YTCyXP5Q8
         IpgBLmnzmQjxjotNeWhAzX9EWo1urk5enWv42sa2wmrL80aIvQU5SaTucwh0bERBGl
         Z82X9MwgBoRGzynrb4lP7l1fBmU8ijuzWNLGmk+AllhOaantVxzYBLvy4IWL5M8fj8
         9GGU9nB93fBEhi1vMeRjPR1T2EyHXz7wcIH8PNFbW7JLb218SErVV8qalxD86d42IZ
         xqTcEV6bXeMzusFbkmhMTxdr8aqZnEJN9QzVbN/ssxjwavzveDqaZOwTBcr1gn2BVu
         nmAb/T50r4REA==
Date:   Tue, 16 Aug 2022 16:32:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-rc] RDMA/erdma: Correct the max_qp and max_cq
 capacities of the device
Message-ID: <YvucWrCLUYjljcTj@unreal>
References: <20220810014320.88026-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810014320.88026-1-chengyou@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 10, 2022 at 09:43:19AM +0800, Cheng Xu wrote:
> QP0 in HW is used for CMDQ, and the rest is for RDMA QPs. So the actual
> max_qp capacity reported to core should be max_qp (reported by HW) - 1.
> So does max_cq.
> 
> Fixes: 155055771704 ("RDMA/erdma: Add verbs implementation")
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/erdma/erdma_verbs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Thanks, applied both patches to -rc.

As a note, please group the patches properly and not as a reply.
Or send them separately, or use cover letter.

Thanks
