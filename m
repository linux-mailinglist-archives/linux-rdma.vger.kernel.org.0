Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B625C6809C3
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jan 2023 10:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbjA3JkW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Jan 2023 04:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbjA3JkS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Jan 2023 04:40:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E05EB40
        for <linux-rdma@vger.kernel.org>; Mon, 30 Jan 2023 01:39:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 313D3B80EC0
        for <linux-rdma@vger.kernel.org>; Mon, 30 Jan 2023 09:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171D3C433D2;
        Mon, 30 Jan 2023 09:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675071585;
        bh=vi+Z4hK4tBDwG/xD3H2Zi6q9VM/H0tQYbrOJlQ4BE6U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CFJJhig/3BHIDjL4s7CNEj4u0w5ogHoz9BGViG/ww4ZgR7ReWlzK+lxwYeuI3mwyj
         TKOR+ee5moIxEcYK5nwNgDC3mGwTsC27vxXrSkHtaon5mZwMDy0F4wAkTo+6bcsZtV
         lfMPeJ1sCshE8CZNWUGRNfw7/T1+GA7ITtlL+LnF+B6rBZtbgpo1+/5LRqAyGisJy5
         k1coNGkdsB0cKvtiwcWXuVlEeZLEt2/OC2yqhvb7SO5KcTlpZgDv0moQ0FJf3Ni1fE
         kYwCcI8WxTGEutjgjJZAXVtptW1pPWq/nk5c+6QS/xeaVXM9VDPL7+7j0e7GfjYP8N
         u89FyYdMRuSpg==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     benve@cisco.com, neescoba@cisco.com, jgg@ziepe.ca,
        umalhi@cisco.com, roland@purestorage.com
In-Reply-To: <20230129093757.637354-1-yangyingliang@huawei.com>
References: <20230129093757.637354-1-yangyingliang@huawei.com>
Subject: Re: [PATCH] RDMA/usnic: use iommu_map_atomic() under spin_lock()
Message-Id: <167507158087.744400.14055091849454298048.b4-ty@kernel.org>
Date:   Mon, 30 Jan 2023 11:39:40 +0200
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


On Sun, 29 Jan 2023 17:37:57 +0800, Yang Yingliang wrote:
> usnic_uiom_map_sorted_intervals() is called under spin_lock(), iommu_map()
> might sleep, use iommu_map_atomic() to avoid potential sleep in atomic
> context.
> 
> 

Applied, thanks!

[1/1] RDMA/usnic: use iommu_map_atomic() under spin_lock()
      https://git.kernel.org/rdma/rdma/c/b7e08a5a63a116

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
