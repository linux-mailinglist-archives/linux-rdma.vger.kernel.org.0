Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DE168771F
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 09:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBBISR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 03:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjBBISB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 03:18:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5772125;
        Thu,  2 Feb 2023 00:17:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0E8861262;
        Thu,  2 Feb 2023 08:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26A6C433EF;
        Thu,  2 Feb 2023 08:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675325878;
        bh=VL4fAkecV4GQl3WJ8gbv7uvwm7Jw16xjo0h4lh1ehZk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iTepDxk69Uth1kyoxJo/FnfP66C4TiRa2TgFfxmqKA97KKteDCj60+UDY3QssMNMz
         MEtzf6+/ZOrwBqX89NvDoYLBHE5oz9HSMQZZo0cLNZCO8WvMenbrQVtyDAkOV7cHU5
         8NFl3pj5DhqXGjNg4/60F3dGM8e/ODZlytkPE+qKvGfs6Wrtb84nwlcchqlyfip6aE
         wQXF0wXx1ksozat4v6ZGHJ73d6JXKdro6IFtkY8aYTsMlasGa8MmLMcYWLY30Jtf6d
         AE9pskDl9N3vB+8DIg8GxkEljxN9+0hDzhuJ6gwddtQFfri+6xTdh5Nuz+P0n9uGnu
         kwzK2naH+bfCg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Roland Dreier <roland@purestorage.com>,
        Vipul Pandya <vipul@chelsio.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
In-Reply-To: <20230201172103.17261-1-n.zhandarovich@fintech.ru>
References: <20230201172103.17261-1-n.zhandarovich@fintech.ru>
Subject: Re: [PATCH] RDMA/cxgb4: add null-ptr-check after ip_dev_find()
Message-Id: <167532587398.1948948.4522751668670208427.b4-ty@kernel.org>
Date:   Thu, 02 Feb 2023 10:17:53 +0200
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


On Wed, 01 Feb 2023 09:21:03 -0800, Nikita Zhandarovich wrote:
> ip_dev_find() may return NULL and assign it to pdev which is
> dereferenced later.
> Fix this by checking the return value of ip_dev_find() for NULL
> similar to the way it is done with other instances of said function.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [...]

Applied, thanks!

[1/1] RDMA/cxgb4: add null-ptr-check after ip_dev_find()
      https://git.kernel.org/rdma/rdma/c/ef42520240aacf

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
