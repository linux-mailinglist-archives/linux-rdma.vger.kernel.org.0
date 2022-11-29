Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C7763BC3F
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Nov 2022 09:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiK2I4S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Nov 2022 03:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiK2I4R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Nov 2022 03:56:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFB5192;
        Tue, 29 Nov 2022 00:56:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 855BA615DE;
        Tue, 29 Nov 2022 08:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A49C433C1;
        Tue, 29 Nov 2022 08:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669712175;
        bh=BDn4TK2lUq1QvxSoU8J//ptBTZU55v00YFLf7E35vaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fpc0RuNhfDznAhfHnqLHdxyX4Dbq5WoCV9zJ386MNphPsEfGFl0nn8jP1QIp9ev6E
         jY2Rd2r1ZS2lJfMhqXNisul8oEzQPNRu1f7qn/MYvZq56iG3VrXVXxC2RZ0luHTfaw
         FzB8UzhePO/arliSUCuxnif2xhiQnQ9D9K96t+0Dvlmyj7yR5rsV/gQcyEh1dADAOo
         zaZ3dGpxnkFYOkw0eHPMXLN2F0Va89/LO/Nkhlmf1O2HP6FGJt/NPaq4++RjwINfdW
         R/wRXwVm5O6ncT0QFTt9RGFdfyf31sdSCOdmAel57KMW6cwxhzpuzqFhNpe6jC688E
         vR8PhH/fICRfQ==
Date:   Tue, 29 Nov 2022 10:56:11 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Wang Yufen <wangyufen@huawei.com>,
        dennis.dalessandro@cornelisnetworks.com
Cc:     bvanassche@acm.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        easwar.hariharan@intel.com
Subject: Re: [PATCH v4 1/2] RDMA/hfi1: Fix error return code in
 parse_platform_config()
Message-ID: <Y4XJK1wvpxrIeUS2@unreal>
References: <1669687459-14180-1-git-send-email-wangyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669687459-14180-1-git-send-email-wangyufen@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 29, 2022 at 10:04:18AM +0800, Wang Yufen wrote:
> In the previous while loop, "ret" may be assigned zero, so the error
> return code may be incorrectly set to 0 instead of -EINVAL.
> 
> Fixes: 97167e813415 ("staging/rdma/hfi1: Tune for unknown channel if configuration file is absent")
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> ---
>  drivers/infiniband/hw/hfi1/firmware.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Thanks, LGTM.

@Dennis?
