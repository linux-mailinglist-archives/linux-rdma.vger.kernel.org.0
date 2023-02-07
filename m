Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B00A68D2C0
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Feb 2023 10:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjBGJ0S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Feb 2023 04:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjBGJ0M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Feb 2023 04:26:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE84A24D;
        Tue,  7 Feb 2023 01:26:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C81B6125F;
        Tue,  7 Feb 2023 09:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BF7C433D2;
        Tue,  7 Feb 2023 09:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675761969;
        bh=5jFv+840F4Pb5m9IGqVRAw02S+Dv0KzQFHn+vQGt0HM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YaBEVaE5zAghqGkvg745LTVWOmzI/xb5HlPgDZNjGdhIuMzxrC6nqJrPWkwSIvpuw
         fi9tihVBfDoemRSBaO3wjVpjh6rqr6Le6+uMcrSg8amLLbSOSyhUVfLd3Nxq8M2ut4
         BY1gLdrgrboolj7KXaVsrDJutdhiK6NR4B1qneZp7E337W/mF+h/BJXi2GkWtC9Rcw
         mA7TuhVQ15O3D2tUVKvMI7yBWh+yXS+0oImIqygivTH6Fbl+6CS67/hYv1GFvx11cH
         eYcQPeIhujaihWAMlcLZsleUTzeh6qr730o/9KqJ7adWmPOZshbpHTJaBjllJ8R/E2
         EHxg4n4bBAZJg==
From:   Leon Romanovsky <leon@kernel.org>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        linux-rdma@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Cc:     jgg@ziepe.ca, guoqing.jiang@linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <1675332721-2-1-git-send-email-lizhijian@fujitsu.com>
References: <1675332721-2-1-git-send-email-lizhijian@fujitsu.com>
Subject: Re: [PATCH v2] RDMA/rtrs: Don't call kobject_del for srv_path->kobj
Message-Id: <167576196499.83620.12430957379549447590.b4-ty@kernel.org>
Date:   Tue, 07 Feb 2023 11:26:04 +0200
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


On Thu, 02 Feb 2023 10:12:01 +0000, Li Zhijian wrote:
> As the mention in commmit f7452a7e96c1 ("RDMA/rtrs-srv: fix memory leak by missing kobject free"),
> it was intended to remove the kobject_del for srv_path->kobj.
> 
> f7452a7e96c1 said:
> >This patch moves kobject_del() into free_sess() so that the kobject of
> >    rtrs_srv_sess can be freed.
> 
> [...]

Applied, thanks!

[1/1] RDMA/rtrs: Don't call kobject_del for srv_path->kobj
      https://git.kernel.org/rdma/rdma/c/2de49fb1c9bb8b

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
