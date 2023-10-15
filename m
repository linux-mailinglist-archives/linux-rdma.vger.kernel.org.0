Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CCF7C9858
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Oct 2023 10:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjJOIPO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Oct 2023 04:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbjJOIPO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Oct 2023 04:15:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A374E4;
        Sun, 15 Oct 2023 01:15:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3517AC43395;
        Sun, 15 Oct 2023 08:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697357711;
        bh=jt5hQedCcw87t+vMPrrY68DJg6v3/zL7YyUGJol01WA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AjbdxBQ6bkom7FjtqyTD+uNU6MByuiwS5zesLfgwK8Z0aL8kGbvzQi311guozIadg
         cDj+yea2MYbiIKUpT6eDfrrD4qqfG3bxsk5S4lXG10zhC2HxeU1ZI35ueLrUKK6kwd
         L6bRsUJRdF8dfhK2MzGf152BSEiaSgJlkmv0Z4UvJLCoYePoMMf0XIxTBXMN8Qsf9s
         iuAU5rliSCRCqKFcPLAUP7ObtKBvdT/2TPAPVRtOZuyHSIe6CKmPKEgx6qQl2cqOM/
         x6rQ7AN27aHLaIRqjSHTAiu0PfAR8aaGOhidGb4g+aPdDC9Es8di0FOSuu64wubMpX
         EhCZbYelG/NRg==
Date:   Sun, 15 Oct 2023 11:15:07 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     jgg@ziepe.ca, dsahern@gmail.com, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 iproute2-next 2/2] rdma: Add support to dump SRQ
 resource in raw format
Message-ID: <20231015081507.GB25776@unreal>
References: <20231010075526.3860869-1-huangjunxian6@hisilicon.com>
 <20231010075526.3860869-3-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010075526.3860869-3-huangjunxian6@hisilicon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 10, 2023 at 03:55:26PM +0800, Junxian Huang wrote:
> From: wenglianfa <wenglianfa@huawei.com>
> 
> Add support to dump SRQ resource in raw format.
> 
> This patch relies on the corresponding kernel commit aebf8145e11a
> ("RDMA/core: Add support to dump SRQ resource in RAW format")
> 
> Example:
> $ rdma res show srq -r
> dev hns3 149000...
> 
> $ rdma res show srq -j -r
> [{"ifindex":0,"ifname":"hns3","data":[149,0,0,...]}]
> 
> Signed-off-by: wenglianfa <wenglianfa@huawei.com>
> ---
>  rdma/res-srq.c | 20 ++++++++++++++++++--
>  rdma/res.h     |  2 ++
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
