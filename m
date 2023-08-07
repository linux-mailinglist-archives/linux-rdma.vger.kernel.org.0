Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E6377268B
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Aug 2023 15:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbjHGNuu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Aug 2023 09:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbjHGNus (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Aug 2023 09:50:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F47310D5
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 06:50:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B6E361C2A
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 13:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DE3C433C8;
        Mon,  7 Aug 2023 13:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691416246;
        bh=IiaPfiXYd0AUXHLQFBjJkkq3d1xVWXohSryY1YDxbt0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ag3UZBXpOh+mdyedt/XGbLErAqO78iGNI7+//BE93flMYI0T2+18N6DssMW8CPz8v
         CBJ9K643ApO02UyQ/FwLx/D2D/qA6dcM2HjSOaGO+ztxpOWwkviqIUNj+Mzk+pfp5p
         VGuwcWzs/EXkL92OBY/tvTNlG8/dlmgS6b7i9KLPNiToCbkNX0rsWkrAz9xtGHCSEG
         Dd5gSA+cxMUCeEkk4Tw80QXHCeEtZS1HoxhpdfrWu1DO3vtTCDdJw6erBWLjcoQQv/
         InCVO4h3ATInloR7/rsXmvHojJG/1EYoP6PkKn8pqVN18+wQttE4G9QkrdTp/i39IG
         MjtzzDxf9BNNw==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, yishaih@mellanox.com, raeds@mellanox.com,
        Xiang Yang <xiangyang3@huawei.com>
Cc:     linux-rdma@vger.kernel.org
In-Reply-To: <20230804022525.1916766-1-xiangyang3@huawei.com>
References: <20230804022525.1916766-1-xiangyang3@huawei.com>
Subject: Re: [PATCH -next] IB/uverbs: fix an potential error pointer dereference
Message-Id: <169141624247.96916.412970222122242780.b4-ty@kernel.org>
Date:   Mon, 07 Aug 2023 16:50:42 +0300
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


On Fri, 04 Aug 2023 10:25:25 +0800, Xiang Yang wrote:
> Smatch reports the warning below:
> drivers/infiniband/core/uverbs_std_types_counters.c:110
> ib_uverbs_handler_UVERBS_METHOD_COUNTERS_READ() error: 'uattr'
> dereferencing possible ERR_PTR()
> 
> the return value of uattr maybe ERR_PTR(-ENOENT), fix this by checking
> the value of uattr before using it.
> 
> [...]

Applied, thanks!

[1/1] IB/uverbs: fix an potential error pointer dereference
      https://git.kernel.org/rdma/rdma/c/26b7d1a27167e7

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
