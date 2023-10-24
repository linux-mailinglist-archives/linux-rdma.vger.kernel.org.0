Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41CF7D53AE
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Oct 2023 16:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbjJXOL7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Oct 2023 10:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbjJXOL7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Oct 2023 10:11:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB5DB6
        for <linux-rdma@vger.kernel.org>; Tue, 24 Oct 2023 07:11:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855BBC433C7;
        Tue, 24 Oct 2023 14:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698156717;
        bh=Ci1mer3xDWKxljPfg2u9H87RegMYb5DZIyq530bVAjk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rEqam1npcEU9qg9aTAQSfbzYodf0GCE9DcnXD91zwxlbuojZoMDAoT0GAo4D85Epw
         MMmZ6FVY4iu7UO0qLfPD53VkZ4xGvsZ1MDASr2o95PnOUVFozsrEZjm++PQMKOUJY6
         FOQlDXu8AIYjJSEYfheY606vniMTEypW82xGPCh/ozerXiYsMaEkdS1SMmT6j6yzQt
         /JoYNgvdjYlDpF/tu4YhW4OhRPHF9HRC/aC7VYZp+mWvCGwjT6M0xmTue9APCXE9lw
         5oipvzL9tqiy020vLSZG8YWR47fyvrRV+eSVNSzuK9n0t6Qy0p84/IxBhDbNcBxRd3
         /RHhelxlPTRmA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <ac7e66357d963fc68d7a419515180212c96d137d.1697705185.git.leon@kernel.org>
References: <ac7e66357d963fc68d7a419515180212c96d137d.1697705185.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Change the key being sent for MPV
 device affiliation
Message-Id: <169815671305.2085608.6922730759808951618.b4-ty@kernel.org>
Date:   Tue, 24 Oct 2023 17:11:53 +0300
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


On Thu, 19 Oct 2023 11:47:05 +0300, Leon Romanovsky wrote:
> Change the key that we send from IB driver to EN driver regarding the
> MPV device affiliation, since at that stage the IB device is not yet
> initialized, so its index would be zero for different IB devices and
> cause wrong associations between unrelated master and slave devices.
> 
> Instead use a unique value from inside the core device which is already
> initialized at this stage.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Change the key being sent for MPV device affiliation
      https://git.kernel.org/rdma/rdma/c/02e7d139e5e24a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
