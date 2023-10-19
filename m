Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D267CF024
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Oct 2023 08:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjJSGha (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Oct 2023 02:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjJSGh3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Oct 2023 02:37:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E8DA4;
        Wed, 18 Oct 2023 23:37:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15ECCC433C9;
        Thu, 19 Oct 2023 06:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697697447;
        bh=Y3hYUjPnYSdEpl04Dd6goNmE7HdP1OIA87Z6D8VoM6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p382420D05s74IJRLfvRTylYPf9zQa3pHT+Fn5897b1XY3V6fP0ZnQaLzl0cKxJwV
         vD2liDu+NXz5BNHjYgmZ3Hi39YDpBbUFsl3xJUFanniwnSCzTa2KUuqqNRhyzblzOx
         Z5CpnJu/xRZcxVDKZxpaog0+sgRnLfeXtdsAx/5/zy/0U/UnCGiieKVxRd64U4pyHt
         BU38Cbg6QRF1ER48IKV0vhUMSPtAi/KENwClVG+W9am8wzuBupF+NOJRYulQXOEGyQ
         QHBKSfH4hzUPSYbdl6ZbEjGNPOSi14sY/NOO13pCa938KOSokatmJYq/LKCiaaQb/O
         2Xpb/+n/ZYqmQ==
Date:   Thu, 19 Oct 2023 09:37:23 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Patrisious Haddad <phaddad@nvidia.com>
Cc:     jgg@ziepe.ca, dsahern@gmail.com, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        huangjunxian6@hisilicon.com, michaelgur@nvidia.com
Subject: Re: [RFC iproute2-next 0/3] Add support to set privileged qkey
 parameter
Message-ID: <20231019063723.GJ5392@unreal>
References: <20231016063103.19872-1-phaddad@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016063103.19872-1-phaddad@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 16, 2023 at 09:31:00AM +0300, Patrisious Haddad wrote:
> This patchset adds support to enable or disable privileged QKEY.
> When enabled, non-privileged users will be allowed to specify a controlled QKEY.
> The corresponding kernel commit is yet to be merged so currently there
> is no hash but the commit name is
> ("RDMA/core: Add support to set privileged qkey parameter")
> 
> All the information regarding the added parameter and its usage are included
> in the commits below and the edited man page.
> 
> Patrisious Haddad (3):
>   rdma: update uapi headers

Kernel patch was accepted https://lore.kernel.org/all/169769714759.2016184.7321591466660624597.b4-ty@kernel.org/
Please resend the series with right "rdma: update uapi headers" patch.

Thanks
