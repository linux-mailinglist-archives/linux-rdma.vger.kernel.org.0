Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32BE788E31
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Aug 2023 20:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjHYSCe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Aug 2023 14:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjHYSCK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Aug 2023 14:02:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74899E54
        for <linux-rdma@vger.kernel.org>; Fri, 25 Aug 2023 11:02:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F7D164C74
        for <linux-rdma@vger.kernel.org>; Fri, 25 Aug 2023 18:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640FFC433C7;
        Fri, 25 Aug 2023 18:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692986527;
        bh=Z8/p6jdYhLhN7qSwwsCH2vmc8kBxtzCwuJWP9hrCynw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L1tt1tRlVym9NiFysPOJ8OoK+R3A+lnRWID+aXQYmXJ11t4i0Hs6cqOiQ2vbdtVIU
         nSMvpyXCgDyeisx55OzfoipqCc5QJFQB2cCg5nArvGJ2XC8cD8UP0BdEg1Krl+NjPd
         sddiDD7chKmF30diIJST1Tg0Lu9Y1AICUlIKpb9IgluoILExErUbWTdNbqS8nYnpJK
         gQuAE3yCf+pvOLmU/aBNI9ICD7OUIrBvWVN2sOM8AakWrGdwLmLZtB+nIMWL3poUzG
         F2A6c2P/CDfNH0iTW/U7+vQYd3rwYr6LvBtmm6d50eOwqwv7cdw0iG4wWcrDMc4VnR
         8Gp0vSiCcUf9w==
Date:   Fri, 25 Aug 2023 11:02:05 -0700
From:   Saeed Mahameed <saeed@kernel.org>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net/mlx5: Use PTR_ERR_OR_ZERO() to simplify code
Message-ID: <ZOjsnUu+MMBazNan@x130>
References: <20230822062312.3982963-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230822062312.3982963-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 22 Aug 14:23, Jinjie Ruan wrote:
>Return PTR_ERR_OR_ZERO() instead of return 0 or PTR_ERR() to
>simplify code.
>
>Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Applied to net-next-mlx5

