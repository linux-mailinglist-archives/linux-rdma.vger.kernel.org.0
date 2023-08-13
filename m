Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3288E77A581
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Aug 2023 10:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjHMIBe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Aug 2023 04:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHMIBe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Aug 2023 04:01:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D294B1709
        for <linux-rdma@vger.kernel.org>; Sun, 13 Aug 2023 01:01:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 690E261FE5
        for <linux-rdma@vger.kernel.org>; Sun, 13 Aug 2023 08:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BC4C433C8;
        Sun, 13 Aug 2023 08:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691913695;
        bh=QVkueeGKRXD/BYsS2ajgRATh4BEeSmw8C8NN50A24bA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DSoZeOfFhdI0C01FDDub+yRCsn95UYaVc1cNJfuxt4NAPgppODmvJKGsUg4QeNKAH
         iuEQ4wfCy1p7gjRb6uLAPskAxvhnXi9ygw/Be/74AZ/OH45HTbz9ahBFG97C0roZNY
         T+ENgL+yn1VrHMVpTz4rqiuJ5S/QnIEC2rxpJZZ6EZgblnUntFcY+LfqZxQmE0KNUj
         XpW0SPBV6QElPOiPP5S4Z5/AuDM8vu1WS9iAUo2FHSd9UOeA61cu4rf+LGCi+RyLcw
         Wx5fvFnZmqI9dKR4xRtyV6gASIygptutqWg0IoFVKic/q39U3RrTgii9yVZBZXO3BO
         EULJcCE3of5NA==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
In-Reply-To: <1690966823-8159-1-git-send-email-selvin.xavier@broadcom.com>
References: <1690966823-8159-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next v2] IB/core: Add more speed parsing in
 ib_get_width_and_speed()
Message-Id: <169191369180.132435.6892241924784835568.b4-ty@kernel.org>
Date:   Sun, 13 Aug 2023 11:01:31 +0300
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


On Wed, 02 Aug 2023 02:00:23 -0700, Selvin Xavier wrote:
> When the Ethernet driver does not provide the number of lanes
> in the __ethtool_get_link_ksettings() response, the function
> ib_get_width_and_speed() does not take consideration of 50G,
> 100G and 200G speeds while calculating the IB width and speed.
> Update the width and speed for the above netdev speeds.
> 
> 
> [...]

Applied, thanks!

[1/1] IB/core: Add more speed parsing in ib_get_width_and_speed()
      https://git.kernel.org/rdma/rdma/c/ca60fd116c7ee1

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
