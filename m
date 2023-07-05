Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93BB747E3F
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jul 2023 09:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjGEHaU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jul 2023 03:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjGEHaU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jul 2023 03:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D624D197
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jul 2023 00:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 613CD61458
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jul 2023 07:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D38C433CA;
        Wed,  5 Jul 2023 07:30:16 +0000 (UTC)
From:   Leon Romanovsky <leonro@nvidia.com>
To:     linux-rdma@vger.kernel.org, Daniel Vacek <neelx@redhat.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Rogerio Moraes <rogerio@cadence.com>
In-Reply-To: <20230613131931.738436-1-neelx@redhat.com>
References: <20230609153147.667674-1-neelx@redhat.com>
 <20230613131931.738436-1-neelx@redhat.com>
Subject: Re: [PATCH v2] verbs: fix compilation warning with C++20
Message-Id: <168854221298.91294.7240817458366723584.b4-ty@nvidia.com>
Date:   Wed, 05 Jul 2023 10:30:12 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Tue, 13 Jun 2023 15:19:31 +0200, Daniel Vacek wrote:
> Our customer reported the below warning whe using Clang v16.0.4 and C++20,
> on a code that includes the header "/usr/include/infiniband/verbs.h":
> 
> error: bitwise operation between different enumeration types ('ibv_access_flags' and
> 'ib_uverbs_access_flags') is deprecated [-Werror,-Wdeprecated-enum-enum-conversion]
>                 mem->mr = ibv_reg_mr(dev->pd, (void*)start, len, IBV_ACCESS_LOCAL_WRITE);
>                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/include/infiniband/verbs.h:2514:19: note: expanded from macro 'ibv_reg_mr'
>                              ((access) & IBV_ACCESS_OPTIONAL_RANGE) == 0))
>                               ~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
> 
> [...]

Applied, thanks!

[1/1] verbs: fix compilation warning with C++20
      https://git.kernel.org/rdma/rdma/c/9e5ccbfdd208a1

Best regards,
-- 
Leon Romanovsky <leonro@nvidia.com>
