Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA40B79B0EE
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Sep 2023 01:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357846AbjIKWGd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Sep 2023 18:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237313AbjIKMcj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Sep 2023 08:32:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7251B9;
        Mon, 11 Sep 2023 05:32:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCC9C433C8;
        Mon, 11 Sep 2023 12:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694435555;
        bh=12rjUtL5HEALdRFSuOzsv77FTRX5QNcc0RqwVBBnWoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O0oZM60k7f/1FvtAP/Ch5Zd8Hfm3Xgwn+THG3BoogI5AgzXnPyRefUfmSWU09ik8A
         TjWeOmQtJUaGvclbftnB0myTWnZOfU4E0v/geoSc5dHl+qjJck3yp82c1VF6z+eMcg
         IMUaPBuwBfLv+wB0L71t5HU0xuMqIhkklhWrn+vaqw0+d1DcX8H/Npal9P+gHu51PB
         74EpqWF55XGa7jtfWunCE0I/aQK5qa4VV2KdOYsxbm5Vvgh5GQdHnDxq3Crh5zP5xa
         bJKIeSBoyJoRiwSVgu7JwcWtgi3+UtN2eVz53UJHonDrH+z3LONWVk50xDwz8dwR/D
         fo6CFpLC5Ks3g==
Date:   Mon, 11 Sep 2023 15:32:31 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     sharmaajay@linuxonhyperv.com
Cc:     Long Li <longli@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-rdma@vger.kernel.org,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ajay Sharma <sharmaajay@microsoft.com>
Subject: Re: [Patch v5 0/5] RDMA/mana_ib
Message-ID: <20230911123231.GB19469@unreal>
References: <1694105559-9465-1-git-send-email-sharmaajay@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1694105559-9465-1-git-send-email-sharmaajay@linuxonhyperv.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 07, 2023 at 09:52:34AM -0700, sharmaajay@linuxonhyperv.com wrote:
> From: Ajay Sharma <sharmaajay@microsoft.com>
> 
> Change from v4:
> Send qp fatal error event to the context that
> created the qp. Add lookup table for qp.
> 
> Ajay Sharma (5):
>   RDMA/mana_ib : Rename all mana_ib_dev type variables to mib_dev
>   RDMA/mana_ib : Register Mana IB  device with Management SW
>   RDMA/mana_ib : Create adapter and Add error eq
>   RDMA/mana_ib : Query adapter capabilities
>   RDMA/mana_ib : Send event to qp

I didn't look very deep into the series and has three very initial comments.
1. Please do git log drivers/infiniband/hw/mana/ and use same format for
commit messages.
2. Don't invent your own index-to-qp query mechanism in last patch and use xarray.
3. Once you decided to export mana_gd_register_device, it hinted me that
it is time to move to auxbus infrastructure.

Thanks

> 
>  drivers/infiniband/hw/mana/cq.c               |  12 +-
>  drivers/infiniband/hw/mana/device.c           |  81 +++--
>  drivers/infiniband/hw/mana/main.c             | 288 +++++++++++++-----
>  drivers/infiniband/hw/mana/mana_ib.h          | 102 ++++++-
>  drivers/infiniband/hw/mana/mr.c               |  42 ++-
>  drivers/infiniband/hw/mana/qp.c               |  86 +++---
>  drivers/infiniband/hw/mana/wq.c               |  21 +-
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 152 +++++----
>  drivers/net/ethernet/microsoft/mana/mana_en.c |   3 +
>  include/net/mana/gdma.h                       |  16 +-
>  10 files changed, 545 insertions(+), 258 deletions(-)
> 
> -- 
> 2.25.1
> 
