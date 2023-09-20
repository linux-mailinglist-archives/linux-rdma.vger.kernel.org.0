Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0CB7A74E5
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 09:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjITHwz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 03:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjITHwy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 03:52:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C797CC9;
        Wed, 20 Sep 2023 00:52:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E780FC433C8;
        Wed, 20 Sep 2023 07:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695196368;
        bh=62u1kHdA3u+5f2DiPIhwFBsdAm8AqpipOVWTjK2Fneo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Cl5JYjK307JpileWUpHlV4alwiR1ADbOoAdNBNvZOcRfh2lGuYxjN5z69popgM4Og
         zqX4+OpQFyV9wFPBQEnyFNgjor23iuNfuDg3gon0TY6qe9YU1cXl3nzCzCzR/eL77k
         E9WG2m9LjBVuxb0ZNhlJipmwce8K+ap6LjNdjLk4uSGFIri1fb5WiybQVeXA+BJJ82
         uUka6oY9QyeogxzXMsG78dz8YsM/DtVeCTHkEAR8HxShalPxi/Nee0fU06PZ1XEgjc
         OySKGZzBYeIFP5sG6WKv8bX13hxcgwUld3M4XCZPjwYi1LuJUINz1y4J5Q3yYXsbGp
         49F4r4dOcctyg==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230918131110.3987498-1-huangjunxian6@hisilicon.com>
References: <20230918131110.3987498-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH RFC for-next 0/3] Add more resource dumping to rdmatool for SRQ
Message-Id: <169519636442.1045255.875566554954028245.b4-ty@kernel.org>
Date:   Wed, 20 Sep 2023 10:52:44 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Mon, 18 Sep 2023 21:11:07 +0800, Junxian Huang wrote:
> Add more resource dumping to rdmatool for SRQ.
> 
> wenglianfa (3):
>   RDMA/core: Add dedicated SRQ resource tracker function
>   RDMA/core: Add support to dump SRQ resource in RAW format
>   RDMA/hns: Support SRQ restrack ops for hns driver
> 
> [...]

Applied, thanks!

[1/3] RDMA/core: Add dedicated SRQ resource tracker function
      https://git.kernel.org/rdma/rdma/c/0e32d7d43b0b2d
[2/3] RDMA/core: Add support to dump SRQ resource in RAW format
      https://git.kernel.org/rdma/rdma/c/aebf8145e11a29
[3/3] RDMA/hns: Support SRQ restrack ops for hns driver
      https://git.kernel.org/rdma/rdma/c/58c49c097fbf5a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
