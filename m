Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570DF60F67C
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 13:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbiJ0Ls1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 07:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbiJ0LsZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 07:48:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6866F575;
        Thu, 27 Oct 2022 04:48:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B640462289;
        Thu, 27 Oct 2022 11:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD1EC433C1;
        Thu, 27 Oct 2022 11:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666871304;
        bh=s/KauLMKAD6uWTxe+fV8RZL3j/8Lst1jzS6ezNfuxGs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qLDT0mOZsPae7Fwh8JIAVy2mw+C0kClpjVg3AMWheLt1K3dOIgYI32nlVAstVK9Ui
         ntd5JuZkMF39INtq2Yp2Md9jdElGbnHfl8JDQW28rXGA7LofatLXuEAdR53MfGf9bf
         yZCMlBp4Pv+4HItPxmT72HJvvpiBiIDozl6CfIPTZZoJCSO8PyUR0u31i33d1PaVQB
         96EEfYPzlp+q5pMYnFKXwAzl27EGLO0tK6FpFb1COpMUHoyb3kOdiCOz1zgRAdTE0R
         0rzlv/fgJibQu+aeAs9HsIja+8AwyN0q9o4dcbkX7XONfa14NSfiIzTmkZ4Jp0QrwZ
         MZwb3KH9LE9Uw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Michal Kalderon <mkalderon@marvell.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ram Amrani <Ram.Amrani@cavium.com>,
        kernel-janitors@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>
In-Reply-To: <Y1gBkDucQhhWj5YM@kili>
References: <Y1gBkDucQhhWj5YM@kili>
Subject: Re: [PATCH] RDMA/qedr: clean up work queue on failure in qedr_alloc_resources()
Message-Id: <166687129991.306571.17052575958640789335.b4-ty@kernel.org>
Date:   Thu, 27 Oct 2022 14:48:19 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 25 Oct 2022 18:32:32 +0300, Dan Carpenter wrote:
> Add a check for if create_singlethread_workqueue() fails and also destroy
> the work queue on failure paths.
> 
> 

Applied, thanks!

[1/1] RDMA/qedr: clean up work queue on failure in qedr_alloc_resources()
      https://git.kernel.org/rdma/rdma/c/569ab362c3073a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
