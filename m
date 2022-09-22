Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430D15E61A6
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Sep 2022 13:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiIVLrC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Sep 2022 07:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiIVLqq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Sep 2022 07:46:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0220C1C126;
        Thu, 22 Sep 2022 04:46:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 933EA6136D;
        Thu, 22 Sep 2022 11:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C425C433C1;
        Thu, 22 Sep 2022 11:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663847180;
        bh=b7c+A4GlpKjd6kliQxtoZ5NLZR0MUMKVn8IUy5NbX3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cEzFrJ6+fI88SAjbY3fU2B7EfHVe3NANi6PLJhNRZzFdrMF17ZixWh5FRWNOBXztC
         ecT7WweClkwCQFfYkiixhAeDfRxkviJkJvKCm+ZjjaCw3qjed7ZDkmuGleMWNsHvh9
         4byPXHQe4Krigq9YkesS508ReJLTyWz5m5MvJblzCLMvOw1tSeSY9g20LXnxr5a/c/
         aRxrZRNFy/Uf00dSP849K4cI5zv80w/q9YKKQn0X5EsVGTT5eB0lqO9tgnb68nPNbq
         uhlM804k1C2DfAtuVdoee6iWJNbsp/qx6yNtsf7jaEtw41T08163xzfUFIXzRVN0oz
         mu+lAFj0c+BiA==
Date:   Thu, 22 Sep 2022 14:46:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     ruanjinjie <ruanjinjie@huawei.com>
Cc:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] IB/hfi1,PCI: Fix missing pci_disable_device() in
 probe and remove
Message-ID: <YyxLCNxM+MY4QXqU@unreal>
References: <20220922024601.3643622-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922024601.3643622-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 22, 2022 at 10:46:01AM +0800, ruanjinjie wrote:
> Replace pci_enable_device() with pcim_enable_device(),
> pci_disable_device() and pci_release_regions() will be
> called in release automatically.
> 
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> ---
>  drivers/infiniband/hw/hfi1/pcie.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

This driver doesn't use devres model and manages all resources by
itself. IMHO, it is much more saner than using automatic resource
release.

Thanks
