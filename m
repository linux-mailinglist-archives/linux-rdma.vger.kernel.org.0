Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41C87AF1C4
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 19:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbjIZRaS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 13:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbjIZRaR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 13:30:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A435124;
        Tue, 26 Sep 2023 10:30:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C84C433C8;
        Tue, 26 Sep 2023 17:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695749410;
        bh=4BCR5+ia34bKjgZ3WQ5jOW0HdAcDUewCNvoaxlZIikg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pxTD8f9RFgHUxrpUlPk3ZJXa9TAqzdd3SLKBcMb0ooRvgr9o3kknjmYA96UZpArs1
         LTIXntUVgKRlOTp+yshSgN680kRTkJLGLH7d9DEeCMec4v3cKy0yInZwDZmnwUW4z3
         LpcHkNDg5WaY8Xn053Vn/43gHTuP1DAloEtIqw4gIZL/ci8MIdve7WSREPTcJDT4Uo
         frAcf2Vhf/pLCbKztN2kGy+PFRWjfQQv/YVrkW5Yt/y8kru9GTHATd08dIT5JekphW
         uPmJT3Kxavr6RO1McwcNjAW478UC3tUYsKKNX1RObSMDBVhssk/dYRtvCfzYspZByL
         FI5VE1kDNVxQg==
Date:   Tue, 26 Sep 2023 20:30:06 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dust Li <dust.li@linux.alibaba.com>
Cc:     Alexandra Winter <wintera@linux.ibm.com>,
        Albert Huang <huangjie.albert@bytedance.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH net-next] net/smc: add support for netdevice in
 containers.
Message-ID: <20230926173006.GN1642130@unreal>
References: <20230925023546.9964-1-huangjie.albert@bytedance.com>
 <20230926104831.GJ1642130@unreal>
 <76a74084-a900-d559-1f63-deff84e5848a@linux.ibm.com>
 <20230926114104.GL1642130@unreal>
 <20230926120903.GD92403@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926120903.GD92403@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 26, 2023 at 08:09:03PM +0800, Dust Li wrote:
> On Tue, Sep 26, 2023 at 02:41:04PM +0300, Leon Romanovsky wrote:
> >On Tue, Sep 26, 2023 at 01:14:04PM +0200, Alexandra Winter wrote:
> >> 
> >> 
> >> On 26.09.23 12:48, Leon Romanovsky wrote:
> >> > This patch made me wonder, why doesn't SMC use RDMA-CM like all other
> >> > in-kernel ULPs which work over RDMA?
> >> > 
> >> > Thanks
> >> 
> >> The idea behind SMC is that it should look an feel to the applications
> >> like TCP sockets. So for connection management it uses TCP over IP;
> >> RDMA is just used for the data transfer.
> >
> >I think that it is not different from other ULPs. For example, RDS works
> >over sockets and doesn't touch or reimplement GID management logic.
> 
> I think the difference is SMC socket need to be compatible with TCP
> socket, so it need a tcp socket to fallback when something is not working.
> 
> If SMC works with rdmacm, it still need a fallback-to-tcp socket, and
> the tcp connection has to be established for each SMC socket before the
> SMC socket got established, that would make rdmacm meaningless.

You still need to perform device-GID-route translations [1], which sounds
to me very RDMA-CM. I'm not asking you to rewrite the code, but trying
to get rationale behind reimplementing part of RDMA subsystem.

Thanks

[1] 24fb68111d45 ("net/smc: retrieve v2 gid from IB device")

> 
> Best regards,
> Dust
> 
> >
> >Thanks
