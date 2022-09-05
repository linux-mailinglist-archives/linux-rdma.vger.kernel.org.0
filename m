Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437F15AD329
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Sep 2022 14:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbiIEMmB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Sep 2022 08:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236959AbiIEMlp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Sep 2022 08:41:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CF45EDE8
        for <linux-rdma@vger.kernel.org>; Mon,  5 Sep 2022 05:35:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FA796126C
        for <linux-rdma@vger.kernel.org>; Mon,  5 Sep 2022 12:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9CEC433C1;
        Mon,  5 Sep 2022 12:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662381349;
        bh=OOXwBjkP7kqK2b0loYIGf0B6/MPyKlTjSrRCeBut/hY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6550iTWSZk1Swo6sJpaUuzlTRewho0D2YnyWi7h34faE09VENdrqiPGL2h/JNyud
         aVkj+LJ/xo+ug9dqDcskz92UWzFhJHvJ1V5bEFbdBdunX7H7Gsd7R2d6LWEDBc1Oz+
         5Y/GnBjj4JuzpL+TO42cMWf/Q9jFgfN6wkijfHmKpJJNIrVn96mVT8dzegW0/WUkHj
         g91V7T4005A1lg9VzeXlBd5y3eihAJOVS0HxbCWGKFcSHidpeeEod4MLmAyKUqwNwy
         eOdsdNCSeS8Jxk//rQY7wwJz7owGsTcUgL9q82EoBAN/uGc0FNcXDQNZao/dynljjc
         WojGhnXdpYTsQ==
Date:   Mon, 5 Sep 2022 15:35:44 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next] MAINTAINERS: Update maintainers of HiSilicon
 RoCE
Message-ID: <YxXtIEDcxFM6Eqf7@unreal>
References: <20220905023815.1477684-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905023815.1477684-1-liangwenpeng@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 05, 2022 at 10:38:15AM +0800, Wenpeng Liang wrote:
> Weihang has moved to work in other technical areas, and Haoyue will
> maintain this module instead of him.
> 
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks, applied to -rc.
