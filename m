Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62857C9854
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Oct 2023 10:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjJOIPC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Oct 2023 04:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbjJOIPB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Oct 2023 04:15:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AB9D8;
        Sun, 15 Oct 2023 01:15:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B029EC433C8;
        Sun, 15 Oct 2023 08:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697357700;
        bh=Qy3H3n+ebGcSxm6wqtM0xJech7O0PnKT9MlWPvzGbPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o/hTz3pVaEgnklnkt43BnIuqemZvLp1juOTiNMV8lA5T8OsVbUh0mvQEnhWKd0kQk
         8fxYul5QTFbWoWhBWU7svN2QS3GRz2kuRmGQmgsHp1mNPtX8skm/NASXhOwhC6DHbi
         VemHIezE9Q2yftfyrmNOXay4I9dUCfJtiYxWObNJdcAi/mgpeTjZPiUY0H+WMXJQ5D
         Ub0y9shnTpCOT0XOxTY1ldYUI0bPT3i4Q1a7yuf9aIynwxTCO4JM9pGWHTxHMqg8lZ
         MNPtTQKlGJSNSmAKpuNM6geDH5sEVqCkFHewoZuSqB/nhzClJ40dy9wcBsOatEYbJ+
         KOuJv7a0jpPow==
Date:   Sun, 15 Oct 2023 11:14:55 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     jgg@ziepe.ca, dsahern@gmail.com, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 iproute2-next 1/2] rdma: Update uapi headers
Message-ID: <20231015081455.GA25776@unreal>
References: <20231010075526.3860869-1-huangjunxian6@hisilicon.com>
 <20231010075526.3860869-2-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010075526.3860869-2-huangjunxian6@hisilicon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 10, 2023 at 03:55:25PM +0800, Junxian Huang wrote:
> Update rdma_netlink.h file upto kernel commit aebf8145e11a
> ("RDMA/core: Add support to dump SRQ resource in RAW format")
> 
> Signed-off-by: wenglianfa <wenglianfa@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  rdma/include/uapi/rdma/rdma_netlink.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
