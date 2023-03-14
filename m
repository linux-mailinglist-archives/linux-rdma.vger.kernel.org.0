Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A11E6B8EA8
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Mar 2023 10:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjCNJ0X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Mar 2023 05:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCNJ0U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Mar 2023 05:26:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4859498EB7;
        Tue, 14 Mar 2023 02:26:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB921B8188B;
        Tue, 14 Mar 2023 09:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA51C433D2;
        Tue, 14 Mar 2023 09:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678785975;
        bh=nKcnH3dAbuU50LjnqkSpZo76hkf6dd3qaa+edu0Q/CU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EWvyW/PEYfwXXy/sUp6ymdaD4vKbqD0KCJZ5zaXUio1OvoybKT+avCh8KQuCFt6Kq
         FTmkILQ+Pox52VQhVN35HRwJiQMquszBdVMWwie8sZaHpsQX0qlHC40qTmsh3nb9el
         357PZYipW0Flu8avnOWghHmDTlwHtmhKL4MpROUQ0B6lmI6NWCDhisn9QMEX21Sylw
         Y5ibERgvMwYwwj8fJ39ObyuCIzIFjD12mtwaZdCqszuazxPx5jl9K4fWaT115QL4pG
         HbsEtl7lS06H+B0AmZNBTeGxNCN3L4Nl+BFY9tUMmFrv0OZdeX7hV5mfaj5BkyZeqW
         lJm7nNlH0Bqgw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Natalia Petrova <n.petrova@fintech.ru>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
In-Reply-To: <20230303124408.16685-1-n.petrova@fintech.ru>
References: <20230303124408.16685-1-n.petrova@fintech.ru>
Subject: Re: [PATCH v2] rdmavt: delete unnecessary NULL check
Message-Id: <167878596798.47051.3381152453876603271.b4-ty@kernel.org>
Date:   Tue, 14 Mar 2023 11:26:07 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Fri, 03 Mar 2023 15:44:08 +0300, Natalia Petrova wrote:
> There is no need to check 'rdi->qp_dev' for NULL. The field 'qp_dev'
> is created in rvt_register_device() which will fail if the 'qp_dev'
> allocation fails in rvt_driver_qp_init(). Overwise this pointer
> doesn't changed and passed to rvt_qp_exit() by the next step.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [...]

Applied, thanks!

[1/1] rdmavt: delete unnecessary NULL check
      https://git.kernel.org/rdma/rdma/c/9b3366ec12f0d7

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
