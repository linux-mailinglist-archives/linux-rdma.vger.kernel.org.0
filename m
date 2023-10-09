Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602317BD582
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 10:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345513AbjJIIpC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 04:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345512AbjJIIo6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 04:44:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE4B118;
        Mon,  9 Oct 2023 01:44:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF20C433C8;
        Mon,  9 Oct 2023 08:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696841094;
        bh=BdiL0ogG95EcNukp4NUdQg+5yQVYpVSwTkw1zXb/ZuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MgtUSwKOHf6TKRBuu0opli+JsD3UFrN+Q2EmS2TfaJ/M8Atn3BboGdFVKOLjg0nTf
         m5Q9RhJ3odC8Vx2Vs0zggxNsUzbgvca8Ilc3VHibJsWqEGrbRmiPRCxP3k8DqKNuiQ
         v5nSgUhAZEUw2R0BjL16xjNR8A9qc3GZ12dBfEBrIhp+cJ45vBF+84Keiba6t/R5st
         tJuRseTQ67JJcGjDNGEGdv7JpqHuhYTzxNQzsxxsf0WUYA2FqgkQh61V/U5aHR3QNV
         eM6Lye8/CwwSyZB+Sn9/mTVMpX5d7qYHiGw6HlVgN6NGpeaoA5SLLJXCHEQdpzg2K4
         q29FSnErYRWgQ==
Date:   Mon, 9 Oct 2023 11:44:49 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     jgg@ziepe.ca, dsahern@gmail.com, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH iproute2-next 1/2] rdma: Update uapi headers
Message-ID: <20231009084449.GD5042@unreal>
References: <20231007035855.2273364-1-huangjunxian6@hisilicon.com>
 <20231007035855.2273364-2-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007035855.2273364-2-huangjunxian6@hisilicon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Oct 07, 2023 at 11:58:54AM +0800, Junxian Huang wrote:
> Update rdma_netlink.h file upto kernel commit aebf8145e11a
> ("RDMA/core: Add support to dump SRQ resource in RAW format")
> 
> Signed-off-by: wenglianfa <wenglianfa@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  rdma/include/uapi/rdma/rdma_netlink.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
