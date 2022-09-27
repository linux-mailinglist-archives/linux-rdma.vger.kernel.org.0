Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF185EBFD8
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Sep 2022 12:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiI0KfJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Sep 2022 06:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiI0Ke5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Sep 2022 06:34:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F3374DEA
        for <linux-rdma@vger.kernel.org>; Tue, 27 Sep 2022 03:34:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F173EB81AE8
        for <linux-rdma@vger.kernel.org>; Tue, 27 Sep 2022 10:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA68C433C1;
        Tue, 27 Sep 2022 10:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664274883;
        bh=bj6tHt/h+IYVpp7oPThWYSqxya4uuycMPXZ4YJCNHfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jUKvJm4C9FWLseZ1U9SjrOh1I4JLAj+HT9dqYCVlefnWAUHkC5QgHJopP5qxfeb9x
         SFU5mJ8dUERL4fEQhb79zqozHDJksyD5x4Cdui3p2EXO5xN8AtskV+jGXhw9CMsXUm
         raFJCWaxcmUW8yBWfLoZufXa2R0UdCLwL6iOqIjI7ZzESDnnyyn2TGBrOw70Uffupf
         1WtYjTj4eL84x8wDA6qBeJfQBq7B+PXUkNHS42rs3wMIe0FBzcG3yv4KV2Bs6gDn2k
         WY1a74BrsZpqaa1pW2U2/J4M4DZ9Xm/BmOYZcOft5fKgM505h0ffB2/CdXcqcat+x5
         +8z8OJR9lXYwg==
Date:   Tue, 27 Sep 2022 13:34:39 +0300
From:   Leon Romanovsky <leo@kernel.org>
To:     yanjun.zhu@linux.dev
Cc:     linux-rdma@vger.kernel.org, jgg@nvidia.com
Subject: Re: [PATCH] rdma: not display the rdma link in other net namespace
Message-ID: <YzLRvzAH9MqqtSGk@unreal>
References: <20220926024033.284341-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926024033.284341-1-yanjun.zhu@linux.dev>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 25, 2022 at 10:40:33PM -0400, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> When the net devices are moved to another net namespace, the command
> "rdma link" should not dispaly the rdma link about this net device.
> 
> For example, when the net device eno12399 is moved to net namespace net0
> from init_net, the rdma link of eno12399 should not display in init_net.
> 
> Before this change:
> 
> Init_net:
> 
> link roceo12399/1 state DOWN physical_state DISABLED  <---should not display
> link roceo12409/1 state DOWN physical_state DISABLED netdev eno12409
> link rocep202s0f0/1 state DOWN physical_state DISABLED netdev ens7f0
> link rocep202s0f1/1 state ACTIVE physical_state LINK_UP netdev ens7f1
> 
> net0:
> 
> link roceo12399/1 state DOWN physical_state DISABLED netdev eno12399
> link roceo12409/1 state DOWN physical_state DISABLED <---should not display
> link rocep202s0f0/1 state DOWN physical_state DISABLED <---should not display
> link rocep202s0f1/1 state ACTIVE physical_state LINK_UP <---should not display
> 
> After this change
> 
> Init_net:
> 
> link roceo12409/1 state DOWN physical_state DISABLED netdev eno12409
> link rocep202s0f0/1 state DOWN physical_state DISABLED netdev ens7f0
> link rocep202s0f1/1 state ACTIVE physical_state LINK_UP netdev ens7f1
> 
> net0:
> 
> link roceo12399/1 state DOWN physical_state DISABLED netdev eno12399
> 
> Fixes: da990ab40a92 ("rdma: Add link object")
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  rdma/link.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/rdma/link.c b/rdma/link.c
> index bf24b849..449a7636 100644
> --- a/rdma/link.c
> +++ b/rdma/link.c
> @@ -238,6 +238,9 @@ static int link_parse_cb(const struct nlmsghdr *nlh, void *data)
>  		return MNL_CB_ERROR;
>  	}
>  
> +	if (!tb[RDMA_NLDEV_ATTR_NDEV_NAME] || !tb[RDMA_NLDEV_ATTR_NDEV_INDEX])
> +		return MNL_CB_OK;
> +

Regarding your question where it should go in addition to RDMA, the answer
is netdev ML. The rdmatool is part of iproute2 and the relevant maintainers
should be CCed.

Regarding the change, I don't think that it is right. User space tool is
a simple viewer of data returned from the kernel. It is not a mistake to
return device without netdev.

Thanks
