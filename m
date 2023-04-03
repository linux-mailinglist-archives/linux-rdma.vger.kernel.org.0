Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C726D4496
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Apr 2023 14:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjDCMkX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Apr 2023 08:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjDCMkX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Apr 2023 08:40:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E307685
        for <linux-rdma@vger.kernel.org>; Mon,  3 Apr 2023 05:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E45DCB819CB
        for <linux-rdma@vger.kernel.org>; Mon,  3 Apr 2023 12:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C58C433D2;
        Mon,  3 Apr 2023 12:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680525619;
        bh=jdbLvzUEX3tzbYSJcP6utY2hU23PZ0C67Kkmc6mCUqk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dsLP1K9K4E1Q/90O+R1oyQMnlkwWy6V52NTeI3kV4VBrIWPBTmNZAZlf6/4CRJzWm
         apDwswsZddUNpZagGbXjV81iqvoDjM6mShxj3bfdx7v6tCrH00yYNE9gncqRYn4Wqu
         BVaKVTDUMhOXQnVjU6inC5LGcXq2Z0hOr12Rqm7D8ISNpJBKKInlkDcB8D4R+oICpd
         usCsVB5Wt8+tHGDzy9m4E3F4CQqmm/+9jaKptM+j7f4P7FZgYRiUL08YzY9OiLMonV
         /vfyhiudVAGXcjrOaIOgEjdwsY2XVrasD7olJiPtyzMeyZdcjnMzrWdkTt8JJlC9RK
         gmGXCgv5wf6PQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     sagi@grimberg.me, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     israelr@nvidia.com, oren@nvidia.com, sergeygo@nvidia.com
In-Reply-To: <20230330131333.37900-1-mgurtovoy@nvidia.com>
References: <20230330131333.37900-1-mgurtovoy@nvidia.com>
Subject: Re: [PATCH 1/3] IB/iser: remove unused macros
Message-Id: <168052561618.175957.10886078005080789036.b4-ty@kernel.org>
Date:   Mon, 03 Apr 2023 15:40:16 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Thu, 30 Mar 2023 16:13:31 +0300, Max Gurtovoy wrote:
> The removed macros are old leftovers.
> 
> 

Applied, thanks!

[1/3] IB/iser: remove unused macros
      https://git.kernel.org/rdma/rdma/c/b7727e231dad51
[2/3] IB/iser: centralize setting desc type and done callback
      https://git.kernel.org/rdma/rdma/c/92363895b6c31b
[3/3] IB/iser: remove redundant new line
      https://git.kernel.org/rdma/rdma/c/070fc1c0e272a0

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
