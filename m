Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52EE7D64AA
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 10:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjJYIOR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 04:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjJYIOQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 04:14:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DB8CE
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 01:14:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F1AC433C8;
        Wed, 25 Oct 2023 08:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698221651;
        bh=3kJo+uMBK6IspUX9ziPN59elgAAynzljeRz79LcWHwQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EUSODjfdAao3k5G1ZB5zclPNO40S/CF0uXZx+jYcgDaWZQhdxyPzg8d/Vn59AnoKB
         xuyQoWhVlsi6PWnlneaAsOPl3vhp67D8Pg/iTbrx3jR+xvkCpdIstnUyOJHKJ1agyu
         Qhv8/7P8Y8PKVy8Vs7LSWOrJABosRQ/hsncFYTGFFvVxT+kNcJ6mgx6ez3vq6k1oN5
         GzK0rp8VsSbxCwfJe5LBLmhLJx5Tim9iN3E/OZmQEaWm0HvKNfxg2pPetYavYi+WOS
         ZN/TryNfZQsMXGisk+VXAis32ywuaNOhfGgk222tumXd0Ud4jhvaRK5Cr2RVVw0/9a
         1MrBSbx5Z71mw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Easwar Hariharan <easwar.hariharan@intel.com>,
        linux-rdma@vger.kernel.org,
        Sebastian Sanchez <sebastian.sanchez@intel.com>,
        Leon Romanovsky <leon@kernel.org>
In-Reply-To: <238fa39a8fd60e87a5ad7e1ca6584fcdf32e9519.1698159993.git.leonro@nvidia.com>
References: <238fa39a8fd60e87a5ad7e1ca6584fcdf32e9519.1698159993.git.leonro@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/hfi1: Workaround truncation compilation error
Message-Id: <169822164718.2970544.7616881804161231471.b4-ty@kernel.org>
Date:   Wed, 25 Oct 2023 11:14:07 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Tue, 24 Oct 2023 18:07:31 +0300, Leon Romanovsky wrote:
> Increase name array to be large enough to overcome the following
> compilation error.
> 
> drivers/infiniband/hw/hfi1/efivar.c: In function ‘read_hfi1_efi_var’:
> drivers/infiniband/hw/hfi1/efivar.c:124:44: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
>   124 |         snprintf(name, sizeof(name), "%s-%s", prefix_name, kind);
>       |                                            ^
> drivers/infiniband/hw/hfi1/efivar.c:124:9: note: ‘snprintf’ output 2 or more bytes (assuming 65) into a destination of size 64
>   124 |         snprintf(name, sizeof(name), "%s-%s", prefix_name, kind);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/infiniband/hw/hfi1/efivar.c:133:52: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
>   133 |                 snprintf(name, sizeof(name), "%s-%s", prefix_name, kind);
>       |                                                    ^
> drivers/infiniband/hw/hfi1/efivar.c:133:17: note: ‘snprintf’ output 2 or more bytes (assuming 65) into a destination of size 64
>   133 |                 snprintf(name, sizeof(name), "%s-%s", prefix_name, kind);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[6]: *** [scripts/Makefile.build:243: drivers/infiniband/hw/hfi1/efivar.o] Error 1
> 
> [...]

Applied, thanks!

[1/1] RDMA/hfi1: Workaround truncation compilation error
      https://git.kernel.org/rdma/rdma/c/d4b2d165714c0c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
