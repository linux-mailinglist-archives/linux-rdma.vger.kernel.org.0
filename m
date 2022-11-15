Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697246292D7
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Nov 2022 09:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbiKOIAK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 03:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbiKOIAG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 03:00:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F2220BF8
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 00:00:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FE176155A
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 08:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A769DC433D6;
        Tue, 15 Nov 2022 08:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668499203;
        bh=vGN0wc3/Zy4hU2dtVZ3CMyF+TZbFgN9UpnwC6jTD6XU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=F1dpMI4Fc1GPjRU9rVBzs6AYMDaM7dAkOdM4mhKulmNLVZo3yIvafM3qI5rljxbYf
         1VWtYagUxanwvtjSA7K9KgxmF0GwBHqB1MU2V5bA25IkxI+VGbKMly039NO4N/7NYQ
         5ETsXFvHShNwZeJdgY/Hxdikia4ujIzirj1+t2BhBw9FdVmsMSjUQAhL3icU4Pb8oa
         GxM+JPNuhgyjhW01gU7Jk24v4+jI7YPaWjlwo4YV+/KGouiq0uIK3GNM79DBaAdjEk
         vICGjcWQ7JIVPfNvl0B0x+NarK1DzB3u4LNqMVrD9uVPFRnpgm41pC4jnbEw6VZHCg
         nmwzs+b+kIqiw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leon@kernel.org>,
        Or Har-Toov <ohartoov@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
In-Reply-To: <cover.1667810736.git.leonro@nvidia.com>
References: <cover.1667810736.git.leonro@nvidia.com>
Subject: Re: (subset) [PATCH rdma-next 0/4] Various core fixes
Message-Id: <166849919902.1678454.2660618832632169740.b4-ty@kernel.org>
Date:   Tue, 15 Nov 2022 09:59:59 +0200
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

On Mon, 7 Nov 2022 10:51:32 +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Batch unrelated fixes.
> 
> Mark Zhang (3):
>   RDMA/restrack: Release MR restrack when delete
>   RDMA/core: Make sure "ib_port" is valid when access sysfs node
>   RDMA/nldev: Return "-EAGAIN" if the cm_id isn't from expected port
> 
> [...]

Applied, thanks!

[2/4] RDMA/restrack: Release MR restrack when delete
      https://git.kernel.org/rdma/rdma/c/dac153f2802db1
[3/4] RDMA/core: Make sure "ib_port" is valid when access sysfs node
      https://git.kernel.org/rdma/rdma/c/5e15ff29b156bb
[4/4] RDMA/nldev: Return "-EAGAIN" if the cm_id isn't from expected port
      https://git.kernel.org/rdma/rdma/c/ecacb3751f2545

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
