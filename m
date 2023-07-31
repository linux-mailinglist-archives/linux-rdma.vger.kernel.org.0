Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55392769596
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 14:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjGaMHX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 08:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjGaMHW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 08:07:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6219110DE
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 05:07:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA10661072
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 12:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1BBC433C8;
        Mon, 31 Jul 2023 12:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690805240;
        bh=DQduUiffsvs5QDAGaxkX5TU7m6h6/oHr4Rhu19bTxo4=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=IAg59IOBGYOx/o/WXYARxFBkueVXE5HrVJYTZ9xLXIpwbKwyhjKzU4NfoNvv5PizR
         i8vSSd2zMMTLpZyanria36OvoI/mYGWr5xrp8gpFF8181w1Y5HUfCnafJ6P8gSVrHk
         F3zeRD1GUerBGVLbIia0bG9xhaYhpWZ3CnnlIlAh3+GHD92fLWovPLM0EsyDRiMwHB
         k+9kBct0+/Q6GmUppuGtqYuMHm/8zYgGcs7ABMvYrHTgN9iXH/3F7Z6H5YtKnSvvTH
         2AZ9YPXI7fNiZg0SUfUR0x86UzE9+jBLZqfkGYDD76ElxukkIgeRrHZRPAdKuP7JRg
         O/HcZ6C1+vFRQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, selvin.xavier@broadcom.com, mkalderon@marvell.com,
        aelior@marvell.com, trix@redhat.com, linux-rdma@vger.kernel.org,
        Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230731085118.394443-1-ruanjinjie@huawei.com>
References: <20230731085118.394443-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next] RDMA: Remove unnecessary ternary operators
Message-Id: <169080523710.272129.14917805079629213253.b4-ty@kernel.org>
Date:   Mon, 31 Jul 2023 15:07:17 +0300
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


On Mon, 31 Jul 2023 16:51:18 +0800, Ruan Jinjie wrote:
> Ther are a little ternary operators, the true or false judgement
> of which is unnecessary in C language semantics.
> 
> 

Applied, thanks!

[1/1] RDMA: Remove unnecessary ternary operators
      https://git.kernel.org/rdma/rdma/c/9c78c819580733

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
