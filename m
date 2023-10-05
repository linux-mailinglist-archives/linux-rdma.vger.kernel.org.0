Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CFC7BA7F3
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Oct 2023 19:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjJER1A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Oct 2023 13:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjJER0a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Oct 2023 13:26:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06562118
        for <linux-rdma@vger.kernel.org>; Thu,  5 Oct 2023 10:02:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E5DC433C7;
        Thu,  5 Oct 2023 17:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696525351;
        bh=MI0D30DBo79y/gboValMzxC7ZDcUTotAiY0j2GHxHHE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rcVc50ePA3pcvXLruvCOofoP+DvR0trqCzj3U4JH9q1TjFsIPojeio+ltBXrhiunJ
         12E/KVnhZdM45KjXvPk02MrLduLQf0jN6XqAVnInJF3JZFmZqpnyq/g5YdnjHSGKp8
         qwAb1f2l1sVEBoEQJEj4aQOHv+f4Ybfw/gz5hUjKQY86q9zRTsD+VHaXwr+wCbXxlU
         4CkD0JRr8J1rf92uR9fgmvqfCZy0TMI/XLFHXmBD4bWi/XouehFJVWiXwSkx4Kvc4b
         nJliIcwnQ6WRA95fGiPORyKhccBcREobZKWO3b6b8I0wDSgXKRixH8iloNJQdFrNXn
         7tvdxNLLn6y6Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>
In-Reply-To: <75d329fdd7381b52cbdf87910bef16c9965abb1f.1696443438.git.leon@kernel.org>
References: <75d329fdd7381b52cbdf87910bef16c9965abb1f.1696443438.git.leon@kernel.org>
Subject: Re: [PATCH rdma-rc] RDMA/core: Require admin capabilities to set
 system parameters
Message-Id: <169652534275.2464982.2946034988612988347.b4-ty@kernel.org>
Date:   Thu, 05 Oct 2023 20:02:22 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Wed, 04 Oct 2023 21:17:49 +0300, Leon Romanovsky wrote:
> Like any other set command, require admin permissions to do it.
> 
> 

Applied, thanks!

[1/1] RDMA/core: Require admin capabilities to set system parameters
      https://git.kernel.org/rdma/rdma/c/c38d23a54445f9

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
