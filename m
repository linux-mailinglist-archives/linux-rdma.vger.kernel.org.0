Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442F1772663
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Aug 2023 15:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjHGNrX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Aug 2023 09:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjHGNrW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Aug 2023 09:47:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A9110D7;
        Mon,  7 Aug 2023 06:47:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD57961BF7;
        Mon,  7 Aug 2023 13:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471FAC433C8;
        Mon,  7 Aug 2023 13:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691416037;
        bh=MLDxAeJUNdxJQ9gnhwfzPeRApj2VilRK9oydVuGGvRk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=m899g3OwsEJ4hKFhS8k/GdvVfOIFIJ9f8Zv0qvmlqomMVOgKgRVif7gJxzthSXCOz
         513NcRg5jEU43hR7KF+Ogp4zvo4nTrVZQgbEZZcFtbwyWQ2pCgpWj3aprQ9sTO5NFH
         q3E3oDOOgUL2oipyyPvCYyGGzatzOnXlVeZqdic2fO7s3xoVKHCm4wc2a6JGjJM1Q7
         eGIpeS/QVyNBfAMnbaJtc0gqS8jvQi06UqEsAZA8w+izU/bS0CD3f07sX9D6AOY5kO
         74VFYwOPTyW6GApmSrlzOM7pe3wh93QwR+XpdtIOS229kU242KxEFy/rXFHJ6zHY7e
         ePO56pQ2iLwzQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230804012711.808069-1-huangjunxian6@hisilicon.com>
References: <20230804012711.808069-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-rc 0/4] Bugfixes for HNS RoCE
Message-Id: <169141603257.94267.11402896495045474220.b4-ty@kernel.org>
Date:   Mon, 07 Aug 2023 16:47:12 +0300
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


On Fri, 04 Aug 2023 09:27:07 +0800, Junxian Huang wrote:
> 1. #1: The first patch fixes port speed error by getting the speed
>        from ethernet instead of using a fixed speed.
> 
> 2. #2: The second patch fixes an error of using direct wqe for wr-list.
> 
> 3. #3: The third patch modifies some inaccurate error label names.
> 
> [...]

Applied, thanks!

[1/4] RDMA/hns: Fix port active speed
      https://git.kernel.org/rdma/rdma/c/df1bcf90a66a10
[2/4] RDMA/hns: Fix incorrect post-send with direct wqe of wr-list
      https://git.kernel.org/rdma/rdma/c/706efac4477cdb
[3/4] RDMA/hns: Fix inaccurate error label name in init instance
      https://git.kernel.org/rdma/rdma/c/c9c0bd3c177d93
[4/4] RDMA/hns: Fix CQ and QP cache affinity
      https://git.kernel.org/rdma/rdma/c/9e03dbea2b0634

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
