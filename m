Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A863B603A0E
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Oct 2022 08:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiJSGrY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Oct 2022 02:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiJSGrQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Oct 2022 02:47:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1ED73C35;
        Tue, 18 Oct 2022 23:47:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD45DB8207D;
        Wed, 19 Oct 2022 06:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13ECC433D6;
        Wed, 19 Oct 2022 06:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666162030;
        bh=Qgrg0tE1sW3nU0GHEiMvxFTxFToh70PIZ69txsxxn74=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JOBae1UUq18zstzZ55/oLCPEq+Qd1SF5gDR4J3yZExp/lhJxRoDiHREs+58dHDG6l
         Tz8haq7x+oPXLrdOgZ4E6sH5oIAbipZtEN84dl46boXMRTavAD20snqUbpYZuzlz7G
         2ziq2JYNP+Zrj3XtLUJ8tzxz+ZhqccMXB6TMDIov4rjeq4G2U4gZUDsc96Y5yF1D2M
         ueltoSasoH+reqywZvEiwvga7VHuMRQ3w+1CnbFpGd2KcINiHNMYEGIi8zdfhLZKt8
         pyZhj5h1j6x0G4AkhKKijZaKSozWekAbqUwTYkOEhtG8UxM5LrhRFdU7tELab7Kk4y
         Ykfhvt/uDEUdw==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Deming Wang <wangdeming@inspur.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221006161456.2998-1-wangdeming@inspur.com>
References: <20221006161456.2998-1-wangdeming@inspur.com>
Subject: Re: [PATCH] IB/uverbs: fix the typo of optional
Message-Id: <166616202618.236928.1454709697586956622.b4-ty@kernel.org>
Date:   Wed, 19 Oct 2022 09:47:06 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 6 Oct 2022 12:14:56 -0400, Deming Wang wrote:
> Fix the typo of optional in the function of UVERBS_HANDLER.
> 
> 

Applied, thanks!

[1/1] IB/uverbs: fix the typo of optional
      https://git.kernel.org/rdma/rdma/c/26312973bfbc1d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
