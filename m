Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCDD657658
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Dec 2022 13:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiL1MVX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Dec 2022 07:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiL1MVH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Dec 2022 07:21:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C0F398;
        Wed, 28 Dec 2022 04:20:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A313E61314;
        Wed, 28 Dec 2022 12:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6D4C433EF;
        Wed, 28 Dec 2022 12:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672230057;
        bh=C7T4NVQ1zeuRB/WdHZAnJLTd1TxXdCWI5njfycxmT7A=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=TGL9rU32ZfsEbz4HQbyF34AC+5SUyfnoWadKg1SThfxBmQvBnQiiMV6EUzMqDxyk/
         JcLnnRhQ2UxKWdRLX4tWGfkoAyoisOreEjGGG80cybzGYT5bugjDJHrwhIKBpECkVr
         algkesya59d1CUUtWj8QSfxvQWpCJchdSllyUCqNb6q4G4wtycIG/aTP/FzyWnXHID
         R8M794CFrFyIab542aEAU2QNTJsvnyUw6ibSgUk/2OjpPgCVEEUIBhCnNPGLKlAheB
         /4Teig5DSLWi4u0HOEPeu0eO6v23pzbdjbN88YjRb/pjg07zpJA0hf4e4mn2eDCH4a
         u1aosxqMhLo/w==
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>,
        Yixing Liu <liuyixing1@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Haoyue Xu <xuhaoyue1@hisilicon.com>
In-Reply-To: <20221223072900.802728-1-linmq006@gmail.com>
References: <20221223072900.802728-1-linmq006@gmail.com>
Subject: Re: [PATCH v2] RDMA/hns: Fix refcount leak in hns_roce_mmap
Message-Id: <167223005274.61198.7536575567109139092.b4-ty@kernel.org>
Date:   Wed, 28 Dec 2022 14:20:52 +0200
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

On Fri, 23 Dec 2022 11:29:00 +0400, Miaoqian Lin wrote:
> rdma_user_mmap_entry_get_pgoff() takes the reference.
> Add missing rdma_user_mmap_entry_put() to release the reference.
> 
> 

Applied, thanks!

[1/1] RDMA/hns: Fix refcount leak in hns_roce_mmap
      https://git.kernel.org/rdma/rdma/c/cf6a05c8494a8a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
