Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E518361EC0F
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 08:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiKGH2q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Nov 2022 02:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiKGH2o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Nov 2022 02:28:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4FF13E29
        for <linux-rdma@vger.kernel.org>; Sun,  6 Nov 2022 23:27:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE9AA60EF7
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 07:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CD4C433D7;
        Mon,  7 Nov 2022 07:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667806059;
        bh=oeG7c6bL6taC/pWZRuyOGvvk1mbD59/yfCa2x7cNXkM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oc28xneDQtKLWpRM0sWTKMkPfsuFR1iGGi4u0ZyjuMO4r0cRnz1/xRcW0sNO0abb9
         fGupnf5BmH58kDn2muaOa+j9mehiFJFrAuRxRXs9r4zMxltHms7KQIxpZe1gycJh9O
         ms7tnO0kK/Py9C23RIOw3zoYMdFJqVDQESLcvO3BnEe0PD1X3akA4+gS1fxUDlMPaM
         /8SRuBA1+Jy0O4o5rA79KNwxl3rh4+xml3IVeuDAQkFiZlf+QdsfR7j73T0tdTIbzw
         msE21urq1/TSkTNr0/AHw0tntFlHWNH/YAI/t5Qvw2qG0qTJgkHwJf/oygLymxMjfE
         bhQbrC5BdYToA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     linux-rdma@vger.kernel.org, Kamal Heib <kamalheib1@gmail.com>
In-Reply-To: <20221104234957.1135-1-shiraz.saleem@intel.com>
References: <20221104234957.1135-1-shiraz.saleem@intel.com>
Subject: Re: [PATCH for-rc] irdma: Report the correct link speed
Message-Id: <166780605467.100300.13653932766991792893.b4-ty@kernel.org>
Date:   Mon, 07 Nov 2022 09:27:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 4 Nov 2022 18:49:57 -0500, Shiraz Saleem wrote:
> The active link speed is currently hard-coded in irdma_query_port due
> to which the port rate in ibstatus does reflect the active link speed.
> 
> Call ib_get_eth_speed in irdma_query_port to get the active link speed.
> 
> 

Applied, thanks!

[1/1] irdma: Report the correct link speed
      https://git.kernel.org/rdma/rdma/c/4eace75e085327

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
