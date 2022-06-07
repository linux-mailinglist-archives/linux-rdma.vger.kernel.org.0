Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DF853F8F2
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jun 2022 11:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiFGJA7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jun 2022 05:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbiFGJAz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jun 2022 05:00:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86700AF334;
        Tue,  7 Jun 2022 02:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3249DB81DCB;
        Tue,  7 Jun 2022 09:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A92C34115;
        Tue,  7 Jun 2022 09:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654592451;
        bh=pmlO+X9G5fB4iURqv/soASLUerVZkAVaKoDfbeOgnQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lw7dISykKX5Q4K4MeDO5dEIyVPcSBHj2Y0wRVrBNn1YWPYVyPRGSw4Lxr1dzC7G9T
         oU40k/e8xQ6GVN3PkR/bWMVRQl6qBgOib6aP2NFFsAXlx5YoM4FQOlgxWtZC2hE7+1
         a8r37i5/YD1/5Ep7qg9BSQVJcToDxHMlvJ3PRPGOpODE2hByfz3Rj5yw3MwD9ggPH8
         G+XrBzV+fByRFWAoAmb+mu3ISS/Wqs2L8m1G3pad0eW4k0OS3k3lOSGBq8eIl6kM9m
         C6o14yzI9PPPQ+cXkd73F1LKtK+wkl6D1bcUjCZquodGZDjQmE8FzGuKcDCw9WezGw
         r10wfUisZXcDg==
Date:   Tue, 7 Jun 2022 12:00:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/hw/hfi1/pio_copy: Fix typo in comment
Message-ID: <Yp8Tv3l/V4TWjDqx@unreal>
References: <20220606123419.29109-1-wangxiang@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606123419.29109-1-wangxiang@cdjrlc.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 06, 2022 at 08:34:19PM +0800, Xiang wangx wrote:
> Delete the redundant word 'and'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
> 
> Changes since v1
> *Change commit log
> 
>  drivers/infiniband/hw/hfi1/pio_copy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks, fixed the title and applied to rdma-next.
