Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E6C7843E5
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 16:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbjHVOWk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 10:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236584AbjHVOWh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 10:22:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B6ED7
        for <linux-rdma@vger.kernel.org>; Tue, 22 Aug 2023 07:22:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EEA965734
        for <linux-rdma@vger.kernel.org>; Tue, 22 Aug 2023 14:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49837C433C7;
        Tue, 22 Aug 2023 14:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692714154;
        bh=XhVsW2fiKm1iUfdL7er2jantFClYo1XnSs0UeRcR9vs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PqlPJg4wVmw1wWfpFI8x7chxztwsjX0I2MDUhg8NeVi9v1FBExSukCWIPMHRF+Vnp
         SKSoceP0S0ciAYrBby2lHeOF5s9rBtL+/Qra8mkO4tSEUDRf3SYG0QkVgDEdfXSkRP
         d61L8aGICkCbzvrKQgT4gxY1rmJ8yXfG2GOAu48W7wO4MzhcV4lRxyl9FLN2T3y7iy
         bcHEXRCH+PmGuMfdSEqjWzVDIVz6bldbIzRyGs/zCvTwe85fQAjVN/8wyOIxAWdNES
         oB2rzrbPOzcMhWwnyRoO8ytjWKE2g+Yi1Oqdzkw+YZqtahOW/S81ieTTaTaYWE+SpJ
         T1qSZo+NzHKQg==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        ynachum@amazon.com
Cc:     sleybo@amazon.com, matua@amazon.com,
        Michael Margolin <mrgolin@amazon.com>
In-Reply-To: <20230822082725.31719-1-ynachum@amazon.com>
References: <20230822082725.31719-1-ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Fix wrong resources deallocation order
Message-Id: <169271415103.36380.6438440724245904765.b4-ty@kernel.org>
Date:   Tue, 22 Aug 2023 17:22:31 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Tue, 22 Aug 2023 08:27:25 +0000, ynachum@amazon.com wrote:
> When trying to destroy QP or CQ, we first decrease the refcount and
> potentially free memory regions allocated for the object and then
> request the device to destroy the object. If the device fails, the
> object isn't fully destroyed so the user/IB core can try to destroy the
> object again which will lead to underflow when trying to decrease an
> already zeroed refcount.
> Deallocate resources in reverse order of allocating them to safely free
> them.
> 
> [...]

Applied, thanks!

[1/1] RDMA/efa: Fix wrong resources deallocation order
      https://git.kernel.org/rdma/rdma/c/dc202c57e9a142

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
