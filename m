Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185D363390E
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Nov 2022 10:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbiKVJvL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Nov 2022 04:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiKVJvE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Nov 2022 04:51:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405CE4FF9D
        for <linux-rdma@vger.kernel.org>; Tue, 22 Nov 2022 01:51:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0144615D2
        for <linux-rdma@vger.kernel.org>; Tue, 22 Nov 2022 09:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957B5C433C1;
        Tue, 22 Nov 2022 09:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669110663;
        bh=evlkC6PHowhfrEmCa4XtLK96vPZL0z4pLyxg1E9XTWc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iHpw8EnNJwqfRS6VDs6EMf3r3PfA1pSRdxk2riD8SCHWx15Z1CeyKG5x2Lfs/UI3h
         hKNiF3wSBFQMjfX6fUdGDGRPhsFT2zX3V14oHpgwbe7d77dPYEJJY01vanDEFQriGm
         4Y7PsJCi/jb7ch+Y7ypqc/k8dPWjLmaPUK+WvSWtaCNsssoGACMHEgzFB5o+2qhiIm
         F+fC8p6W94mm3oQZzo/n8gMQt5X6R4Ob/U8LpqFaFjNV9uFmys9P4F/Js5HYUZ5nLV
         GeDpOEDV1vjUVEPs03aaptoJwSCwkQq9fKmifRZqc/1BHe+nwLktfmRwBKR0gf8eIH
         nqjNNuxgOJ4ew==
From:   Leon Romanovsky <leon@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, mike.marciniszyn@intel.com,
        jgg@ziepe.ca, dennis.dalessandro@cornelisnetworks.com,
        michael.j.ruhl@intel.com
Cc:     yangyingliang@huawei.com, linux-rdma@vger.kernel.org
In-Reply-To: <20221117131546.113280-1-wangxiongfeng2@huawei.com>
References: <20221117131546.113280-1-wangxiongfeng2@huawei.com>
Subject: Re: [PATCH] RDMA/hfi: Decrease PCI device reference count in error path
Message-Id: <166911065877.114550.9519829285189922775.b4-ty@kernel.org>
Date:   Tue, 22 Nov 2022 11:50:58 +0200
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

On Thu, 17 Nov 2022 21:15:46 +0800, Xiongfeng Wang wrote:
> pci_get_device() will increase the reference count for the returned
> pci_dev, and also decrease the reference count for the input parameter
> *from* if it is not NULL.
> 
> If we break out the loop in node_affinity_init() with 'dev' not NULL, we
> need to call pci_dev_put() to decrease the reference count. Add missing
> pci_dev_put() in error path.
> 
> [...]

Applied, thanks!

[1/1] RDMA/hfi: Decrease PCI device reference count in error path
      https://git.kernel.org/rdma/rdma/c/9b51d072da1d27

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
