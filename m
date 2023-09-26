Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F4A7AEB9D
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 13:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjIZLlT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 07:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjIZLlT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 07:41:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A101127;
        Tue, 26 Sep 2023 04:41:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0700C433C8;
        Tue, 26 Sep 2023 11:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695728471;
        bh=xayddD/UkGvMFL+wjIXW7FBKA1JN27wJEBHqp+aZGc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pD2rkyKidfdtF/GsiBFXYbwt5HP0gHPAGz4mexcij7dv0gTpQ3Eh9ZokjHii72WOJ
         dxf6FVK18gYzSBkS7CPt+hctajmRYIuUd/2z9HvY6Rag6l70skrZCL57kApl/+afsj
         V8SXRPJvt/v957XRfnojIoznopkeHvFbm8xU6aMOoFrR8pgn62jZ4gCYYEdluO48iP
         rsC5m1j6pwv5Rak1ZNOUHOwXKE/CHdMCNFVJVdk/E8xP1sEl5f+U2Y/mg4UB4uWZTk
         YqYU1RYkFPK8y93ClqRko9awFHAfWZ0VKGnhNjzKOnj5LgvIFtec4Fr1BUjVCRvFju
         2NYjMZpT/aBmQ==
Date:   Tue, 26 Sep 2023 14:41:04 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Alexandra Winter <wintera@linux.ibm.com>
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
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
Message-ID: <20230926114104.GL1642130@unreal>
References: <20230925023546.9964-1-huangjie.albert@bytedance.com>
 <20230926104831.GJ1642130@unreal>
 <76a74084-a900-d559-1f63-deff84e5848a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76a74084-a900-d559-1f63-deff84e5848a@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 26, 2023 at 01:14:04PM +0200, Alexandra Winter wrote:
> 
> 
> On 26.09.23 12:48, Leon Romanovsky wrote:
> > This patch made me wonder, why doesn't SMC use RDMA-CM like all other
> > in-kernel ULPs which work over RDMA?
> > 
> > Thanks
> 
> The idea behind SMC is that it should look an feel to the applications
> like TCP sockets. So for connection management it uses TCP over IP;
> RDMA is just used for the data transfer.

I think that it is not different from other ULPs. For example, RDS works
over sockets and doesn't touch or reimplement GID management logic.

Thanks
