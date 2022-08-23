Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A313959D983
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Aug 2022 12:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350616AbiHWJd4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Aug 2022 05:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350581AbiHWJcZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Aug 2022 05:32:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1896282D0E
        for <linux-rdma@vger.kernel.org>; Tue, 23 Aug 2022 01:38:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB95C614E7
        for <linux-rdma@vger.kernel.org>; Tue, 23 Aug 2022 08:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C2AC433D7;
        Tue, 23 Aug 2022 08:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661243872;
        bh=zECkTBrSGQsbl4FfI2vT1sRuuhHYdh7HCsOAYBV26Eo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SV5L8QS/yCxETsfqVRoIT0vC/srz8mhFUJS3mA3x3Lm5hPkjiPQAe4xLhwloL2St6
         FS0pOno86X4od3+A11R4Ononnx0Tde2eOLbEdxQvVxG4eegfqgIi7vCMxs7BvuM9rh
         b/GVjm4q7v6mZCBKK1jHbxTFI1s6o3KY01dIFpN4/ofFaxXtU4AN9rt6CMPq5weWTe
         prIdzFamkBqu+NUHiTckIEoop8oFlmtw2OttEJnLkETadaN5SE86bHp3D+b0JmKhE4
         jXQjMe4KXM3qmKTENsksPJasSG7y9ZcBJOi/U8LPuaWLabDHiE+JvF826INuSI5uNT
         CPMy6eBJvxxlw==
Date:   Tue, 23 Aug 2022 11:37:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 0/7] RDMA/hns: Add more restrack attributes
 to hns driver
Message-ID: <YwSR2+ySMJ4BP+dj@unreal>
References: <20220822104455.2311053-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822104455.2311053-1-liangwenpeng@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 22, 2022 at 06:44:48PM +0800, Wenpeng Liang wrote:
> The hns driver already supports CQ's restrack ops. Therefore, this patchset
> supports QP/MR's restrack ops and CQ/QP/MR's restrack raw ops. Among them,
> restrack ops dump the queue information maintained by the driver, and
> restrack raw ops dump the queue context maintained by ROCEE.
> 
> Changes since v1:
> * Add support for restrack raw ops.
> * Add the result dumped by rdmatool in the commit message.
> * v1 Link: https://patchwork.kernel.org/project/linux-rdma/cover/20220124124624.55352-1-liangwenpeng@huawei.com/

https://lore.kernel.org/all/20220124124624.55352-1-liangwenpeng@huawei.com/

> 
> Wenpeng Liang (7):
>   RDMA/hns: Remove redundant DFX file and DFX ops structure
>   RDMA/hns: Add or remove CQ's restrack attributes
>   RDMA/hns: Support CQ's restrack raw ops for hns driver
>   RDMA/hns: Support QP's restrack ops for hns driver
>   RDMA/hns: Support QP's restrack raw ops for hns driver
>   RDMA/hns: Support MR's restrack ops for hns driver
>   RDMA/hns: Support MR's restrack raw ops for hns driver
> 

Thanks, applied.
