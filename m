Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BC363A811
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Nov 2022 13:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiK1MUf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Nov 2022 07:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiK1MUM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Nov 2022 07:20:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BE312774;
        Mon, 28 Nov 2022 04:13:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D9E4B80ABE;
        Mon, 28 Nov 2022 12:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4D0C433C1;
        Mon, 28 Nov 2022 12:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669637587;
        bh=M4dM+HhK2pKx09FXlcWB2yVvlNalhN5jRoOLB8cHF5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rM3lwLhtw7SgapRd3xWjSx1gqcDJ3GfeBfVL2T30VI/Kkkm+dPrleyxwUVv2tjW8T
         rcLuHIGTl1kE8CbvNf5nFB+pR0cAgUB9ffxUuecjy3cebv2mQP7Z1vBny4hqvYBLy1
         E8ZwG+F/skkz5WZBy8Ba7xiwDjq0VQ1kVogsq4C9gtl/Usp76zh3TmgSJiUomkiQlX
         /7/h60JhrUPTIA8yTE7lMInuLJucNVQ5i4J7vG4kb7iz/XZpf6dmifQrHi5qdYykap
         cII4pN2PsJrRriJxb1w8qihvB5H2B0RmF6aev2jWxO1XjipaFUxFOmt31Swy0BSEsi
         U0PCAr/uJdd4w==
Date:   Mon, 28 Nov 2022 14:13:03 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     zhang.songyi@zte.com.cn
Cc:     yishaih@nvidia.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] RDMA/mlx4: remove NULL check before dev_{put,
 hold}
Message-ID: <Y4Slz8XC5/m+TZef@unreal>
References: <202211282000293202417@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211282000293202417@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 28, 2022 at 08:00:29PM +0800, zhang.songyi@zte.com.cn wrote:
> From: zhang songyi <zhang.songyi@zte.com.cn>
> 
> The call netdev_{put, hold} of dev_{put, hold} will check NULL,
> so there is no need to check before using dev_{put, hold}.
> 
> Fix the following coccicheck warnings:
> /drivers/infiniband/hw/mlx4/main.c:1311:2-10: WARNING:
> WARNING  NULL check before dev_{put, hold} functions is not needed.
> 
> /drivers/infiniband/hw/mlx4/main.c:148:2-10: WARNING:
> WARNING  NULL check before dev_{put, hold} functions is not needed.
> 
> /drivers/infiniband/hw/mlx4/main.c:1959:3-11: WARNING:
> WARNING  NULL check before dev_{put, hold} functions is not needed.
> 
> /drivers/infiniband/hw/mlx4/main.c:1962:3-10: WARNING:
> WARNING  NULL check before dev_{put, hold} functions is not needed.
> 
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
> ---
>  drivers/infiniband/hw/mlx4/main.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 

The patch needs to be based on this repository:
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/
branch: for-next

Thanks
