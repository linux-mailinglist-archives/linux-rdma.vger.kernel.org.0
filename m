Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592867635C0
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jul 2023 13:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjGZL7j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jul 2023 07:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjGZL7j (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jul 2023 07:59:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D57EE7E
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jul 2023 04:59:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F4CB61AA0
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jul 2023 11:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CEFC433C8;
        Wed, 26 Jul 2023 11:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690372775;
        bh=ub3R78Sm0oHyBWc5qwaZH1BXPqlk/myA+/ZK3TApuuM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TWlqgU+Ihp6JIHnnoHiJh0pvNJPssnepEvZuGaLBMzhXjKIlWA2bFmAOei7XD9Mnq
         ptzaPpo1+KmMBVQYMNWfuLflgNVqO9YnXn/HPU5tmRwWR4l2cBa5r2/GWM0hkMQoJE
         L1imyBJ4QSo4J6+C4ybUQ2pEmZQdFg0K05F2PjPDvThn6/xu8qZ7umZkMHMH628Kyq
         C8v3qFLAFhqwlOuDsn5uePochpIVyPJrlV9ArmFKay6aJ+ArJNhJuv5EZuFITmYM0M
         UUo2twEDcqiqfUikQgf6jJMPKml9cvfTGMK2dYaL+XV1YxGoM95MJW9jnaLMqNnHLZ
         9mHJ4TIEG2NrA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     linux-rdma@vger.kernel.org, Sindhu Devale <sindhu.devale@intel.com>
In-Reply-To: <20230725155439.1057-1-shiraz.saleem@intel.com>
References: <20230725155439.1057-1-shiraz.saleem@intel.com>
Subject: Re: [PATCH for-rc 1/2] RDMA/irdma: Fix op_type reporting in CQEs
Message-Id: <169037277175.1727878.6697146134360497292.b4-ty@kernel.org>
Date:   Wed, 26 Jul 2023 14:59:31 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Tue, 25 Jul 2023 10:54:37 -0500, Shiraz Saleem wrote:
> The op_type field CQ poll info structure is incorrectly
> filled in with the queue type as opposed to the op_type
> received in the CQEs. The wrong opcode could be decoded
> and returned to the ULP.
> 
> Copy the op_type field received in the CQE in the CQ poll
> info structure.
> 
> [...]

Applied, thanks!

[1/2] RDMA/irdma: Fix op_type reporting in CQEs
      https://git.kernel.org/rdma/rdma/c/3bfb25fa2b5bb9
[2/2] RDMA/irdma: Report correct WC error
      https://git.kernel.org/rdma/rdma/c/ae463563b7a1b7

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
