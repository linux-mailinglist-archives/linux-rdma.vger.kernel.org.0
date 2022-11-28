Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3811D63A779
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Nov 2022 12:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiK1L6m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Nov 2022 06:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiK1L6l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Nov 2022 06:58:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CF610FD1;
        Mon, 28 Nov 2022 03:58:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 175586112E;
        Mon, 28 Nov 2022 11:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED63C433D6;
        Mon, 28 Nov 2022 11:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669636718;
        bh=g0CyFU4AmxgB5ca38CTRgs5/VPoXCC8E4s7YNFf4BMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WAZ1hteQHz/nJ+bYkH2mXPLF+D3peKEbSGzctcmxjBoDWzLJ4Bbvwaq0cSZNfZCzi
         tWso7EM/gL5H9xiMkG+MZM4oOHTjwyYWKqV1FWzf6Xeal76XYURjfzrniyMjhfrg/2
         EafBd3OUk+6R4zTeBpk3Q2mg4rkFAosME5AFeY3WBCWjTs0IhoKdFGckp3elQccXev
         mlxbXmaITJ9z4ZOl5NA04PjERru2z+ttUHkVfPW5iFnZJzR4SbdZgDrMpZbSYMgqCk
         ueGNqlCLs6xno2Q3DFOHyxVg85BdoqzIoT0L7ss7zQ4yjhn0++XYWZ1V3fuluFaQuS
         a/8TKEvM+SmHg==
Date:   Mon, 28 Nov 2022 13:58:34 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     bvanassche@acm.org, jgg@ziepe.ca,
        dennis.dalessandro@cornelisnetworks.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, bart.vanassche@wdc.com,
        easwar.hariharan@intel.com
Subject: Re: [PATCH v3 2/2] RDMA/srp: Fix error return code in
 srp_parse_options()
Message-ID: <Y4SiaoUl1PMWDMcG@unreal>
References: <1669470654-45828-1-git-send-email-wangyufen@huawei.com>
 <1669470654-45828-2-git-send-email-wangyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669470654-45828-2-git-send-email-wangyufen@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Nov 26, 2022 at 09:50:54PM +0800, Wang Yufen wrote:
> In the previous while loop, "ret" may be assigned zero, , so the error
> return code may be incorrectly set to 0 instead of -EINVAL.
> Add out_with_einval goto label and covert all "goto out;" to "goto
> out_with_einval:" where it's appropriate, alse investigate each case
> separately as Andy suggessted.
> 
> Fixes: e711f968c49c ("IB/srp: replace custom implementation of hex2bin()")
> Fixes: 2a174df0c602 ("IB/srp: Use kstrtoull() instead of simple_strtoull()")
> Fixes: 19f313438c77 ("IB/srp: Add RDMA/CM support")
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> ---
>  drivers/infiniband/ulp/srp/ib_srp.c | 86 ++++++++++++++++++++++++++-----------
>  1 file changed, 60 insertions(+), 26 deletions(-)

<...>

> @@ -3623,6 +3653,10 @@ static int srp_parse_options(struct net *net, const char *buf,
>  out:
>  	kfree(options);
>  	return ret;
> +
> +out_with_einval:

It needs to be changed back.

Thanks

> +	ret = -EINVAL;
> +	goto out;
>  }
>  
>  static ssize_t add_target_store(struct device *dev,
> -- 
> 1.8.3.1
> 
