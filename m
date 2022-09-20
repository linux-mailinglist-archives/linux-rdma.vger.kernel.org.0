Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92205BEBB2
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Sep 2022 19:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiITROr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Sep 2022 13:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiITROq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Sep 2022 13:14:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B66D102
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 10:14:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FF9662193
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 17:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE982C433D7;
        Tue, 20 Sep 2022 17:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663694083;
        bh=uKcvv8E0HrFxLL1OzBOcO055rsR0wTnMxAcyWo/RP0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lIlI5uWAzedH2m8eiwM1n492OwTrRoLXPOpzyzod0+dgQlOblSjq9CsRKa9YD5mcw
         Uz3JORHK9vbIz52g6J4T26zvM2AgEZMvjSrTiMCxm4fSMoYjJioMowGWpfhx4tCsxO
         iYhwsC/oGi1czZDKu3WqUGweFu2ET6txqMr/20fIlV1Wq3ncmedxQZADsA1d4iXEYk
         MyoWGUhv3IzT8FcS3IJv3JkEnwB8LV73U5qcoA7S6/P2GEQE+Oa1UhUR8I2s7Xqpzm
         p68hsmNoEeDaKOcdtg24OfZsIuTuMBc2fRuzZg7ZDJaOeBNhvF/XPtLOpAopfEOlMG
         VhXH+2bitehXw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>,
        dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        mike.marciniszyn@intel.com
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH] IB/hfi1: remove rc_only_opcode and uc_only_opcode declarations
Date:   Tue, 20 Sep 2022 20:14:37 +0300
Message-Id: <166369406938.310545.4058889562883620574.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220911092325.3216513-1-cuigaosheng1@huawei.com>
References: <20220911092325.3216513-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, 11 Sep 2022 17:23:25 +0800, Gaosheng Cui wrote:
> rc_only_opcode and uc_only_opcode have been removed since
> commit b374e060cc2a ("IB/hfi1: Consolidate pio control masks
> into single definition"), so remove them.
> 
> 

Applied, thanks!

[1/1] IB/hfi1: remove rc_only_opcode and uc_only_opcode declarations
      https://git.kernel.org/rdma/rdma/c/0227f4d0d15433

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
