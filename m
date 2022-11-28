Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C07D63A776
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Nov 2022 12:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiK1L56 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Nov 2022 06:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiK1L55 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Nov 2022 06:57:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5C1F69;
        Mon, 28 Nov 2022 03:57:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47B68B80D62;
        Mon, 28 Nov 2022 11:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0AAC433C1;
        Mon, 28 Nov 2022 11:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669636674;
        bh=EaiB9AQEdbtOk+z8FYH5LGKBWEmmhGfBJcPP24eTV+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVwpuLAfvmuJU5ukOfrWrPE8mzIg2Afs84BctQy6zk5hoZUp/hHWN1IXIjQ8WfSJI
         +lN0orkDrFYqLrv5Q5f2gcGvXN4QHQ5hVxZOs2LeFPlI+RLOLFzay1ZUyEMaZVaTSV
         QxO3tFNo90AzdB2sN5wtvHMa4+61lyilhb9M5yavjjiQpBPrzVUvx44Ib6AQsMYQh+
         Z46jwImsrtbi4LGSKYvtbBhgq+UHDQDl0z9Y/r+k1Qcv7aWM5d+ZO0o031K73ICW4I
         UgiXJuG7+udbxYq7AKLsQ1NQkJXlaDMxeYRSGqYajWOKUprJZzXXgsCjK8FYGnuRaB
         uE79YLMFRwZ8g==
Date:   Mon, 28 Nov 2022 13:57:49 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     bvanassche@acm.org, jgg@ziepe.ca,
        dennis.dalessandro@cornelisnetworks.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, bart.vanassche@wdc.com,
        easwar.hariharan@intel.com
Subject: Re: [PATCH v3 1/2] RDMA/hfi1: Fix error return code in
 parse_platform_config()
Message-ID: <Y4SiPfXbMoSc1E6M@unreal>
References: <1669470654-45828-1-git-send-email-wangyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669470654-45828-1-git-send-email-wangyufen@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Nov 26, 2022 at 09:50:53PM +0800, Wang Yufen wrote:
> In the previous while loop, "ret" may be assigned zero, so the error
> return code may be incorrectly set to 0 instead of -EINVAL.
> Add bail_with_einval goto label and covert all "goto bail;" to "goto
> bail_with_einval:" where it's appropriate. Add dropping some duplicative
> "ret = -EINVAL;" lines, as Andy suggessted.
> 
> Fixes: 97167e813415 ("staging/rdma/hfi1: Tune for unknown channel if configuration file is absent")
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/infiniband/hw/hfi1/firmware.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)

<...>


> +bail_with_einval:
> +	ret = -EINVAL;

Sorry for being late, but no. It can be seen as anti-pattern as it
causes to the situations where unrelated code changes can potentially
overwrite return value. Please set valid return code before calling to
goto.

Thanks

>  bail:
>  	memset(pcfgcache, 0, sizeof(struct platform_config_cache));
>  	return ret;
> -- 
> 1.8.3.1
> 
