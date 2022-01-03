Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F24482EE7
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jan 2022 09:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiACICo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 03:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiACICo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 03:02:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60329C061761
        for <linux-rdma@vger.kernel.org>; Mon,  3 Jan 2022 00:02:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E4E660FA9
        for <linux-rdma@vger.kernel.org>; Mon,  3 Jan 2022 08:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415FCC36AEE;
        Mon,  3 Jan 2022 08:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641196963;
        bh=GZVHfYygLWnZSA1CQDbZayPr8qTD+ewsRJoCLSYE4hE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gEWpWkEoP+Ylasrz4J1ojRlurH7A2VrMskj719v46j+3RrymFhxf27eNy5Nnr8wVu
         zECnbCfI3yoV761ZiWUr8MaHfBs/NDJcwkq/lZBjZywb6e+S3K9fsea2WobwbN2ase
         FJp1o1vsTmoS+ELVMN8eDToKsHx2tkucHvdt/2bW+RDxbLHt7hxb0Zl3+Mag/DXGbW
         4zj0tcJk/EEYGOzG/GkGRM2NegnUgLocsb9rIr4SMgXGcDufhlT4UN0k6s57y+LMiH
         pqoxjgSBJtJDN+uu+Xe/BYjCaJp1O28vhQTQBQGFJR4wnT+920JKBIyXc/gefEmwaW
         Ji8+S+0XxB48Q==
Date:   Mon, 3 Jan 2022 10:02:38 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     yanjun.zhu@linux.dev
Cc:     zyjzyj2000@gmail.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/rxe: Remove the unused variable
Message-ID: <YdKtnv0SSUXySxd1@unreal>
References: <20211216054842.1099428-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216054842.1099428-1-yanjun.zhu@linux.dev>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 16, 2021 at 12:48:42AM -0500, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> The member variable xmit_errors can be replaced with
> rxe_counter_inc(rxe, RXE_CNT_SEND_ERR) totally. So
> remove it.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_net.c   | 1 -
>  drivers/infiniband/sw/rxe/rxe_verbs.h | 2 --
>  2 files changed, 3 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
