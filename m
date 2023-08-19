Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827DA781941
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Aug 2023 13:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjHSLdQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Aug 2023 07:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjHSLdP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Aug 2023 07:33:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8351298B3;
        Sat, 19 Aug 2023 04:32:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 425ED601D6;
        Sat, 19 Aug 2023 11:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A84C433C7;
        Sat, 19 Aug 2023 11:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692444736;
        bh=qrtuBmtxDNsszJLC+08ru8fHK7ByU4Gy2MUIXGRXStQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bv54ObWEJlkGhqQJjuVD/IY904TbOr2HTD7anN50P5nWIUkFwLepqh+VbLcdCW4EI
         JGEVrHDdyesjH8kK8bP7dS0Pzi1hjGTXUXP7hXzduYIGi9VgoJaJmWH/IOtzIkmbXN
         9a60/CnjlNThzHudwiHpYzNsOANKESx0INEuKsCjxZRngW8Oxt5PQgJygnpCiluHRi
         aiuwnxXKP9sY8YltTs93PCVP6jxzPBL3mQdikyejKkqb9CiVyLwMTXI7V9HnpE0wb4
         wHYLVWiRfbzNey8hu6up2HNPE09Xd68uQrONpGDQUlpzhhQw3LY1PsfnYa2MWqbAxU
         H5r4Cmfz9y4xg==
Date:   Sat, 19 Aug 2023 14:32:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next 0/3] RDMA/hns: Add more debugging information
 for rdma-tool
Message-ID: <20230819113212.GN22185@unreal>
References: <20230816091812.2899366-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230816091812.2899366-1-huangjunxian6@hisilicon.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 16, 2023 at 05:18:09PM +0800, Junxian Huang wrote:
> 1. #1: The first patch supports dumping QP/CQ/MR context entirely in raw
>        data with rdma-tool.
> 
> 2. #2: The second patch supports query of HW stats with rdma-tool.
> 
> 3. #3: The last patch supports query of SW stats with rdma-tool.
> 
> Chengchang Tang (3):
>   RDMA/hns: Dump whole QP/CQ/MR resource in raw
>   RDMA/hns: Support hns HW stats

These two patches generate static analyzer warnings.
➜  kernel git:(wip/leon-for-next) mkt ci --rev 0a68261bbbe5
0a68261bbbe5 (HEAD -> build) RDMA/hns: Dump whole QP/CQ/MR resource in raw
WARNING: 'informations' may be misspelled - perhaps 'information'?
#7:
rdma-tool, but these informations are not enough. It is very
                     ^^^^^^^^^^^^
➜  kernel git:(wip/leon-for-next) mkt ci
5a87279591a1 (HEAD -> build) RDMA/hns: Support hns HW stats
drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1651:35: warning: restricted __le16 degrades to integer

>   RDMA/hns: Support hns SW stats

This is not support SW stats, but actually implementation of SW
statistics which you exposed through rdmatool. That tool is
not right place for such information and debugfs will be better
fit.

Thanks

> 
>  drivers/infiniband/hw/hns/hns_roce_ah.c       |   6 +-
>  drivers/infiniband/hw/hns/hns_roce_cmd.c      |  19 ++-
>  drivers/infiniband/hw/hns/hns_roce_cq.c       |  15 +-
>  drivers/infiniband/hw/hns/hns_roce_device.h   |  50 ++++++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c    |  59 +++++++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h    |   1 +
>  drivers/infiniband/hw/hns/hns_roce_main.c     | 152 +++++++++++++++++-
>  drivers/infiniband/hw/hns/hns_roce_mr.c       |  26 ++-
>  drivers/infiniband/hw/hns/hns_roce_pd.c       |  10 +-
>  drivers/infiniband/hw/hns/hns_roce_qp.c       |   8 +-
>  drivers/infiniband/hw/hns/hns_roce_restrack.c |  75 +--------
>  drivers/infiniband/hw/hns/hns_roce_srq.c      |   6 +-
>  12 files changed, 325 insertions(+), 102 deletions(-)
> 
> --
> 2.30.0
> 
