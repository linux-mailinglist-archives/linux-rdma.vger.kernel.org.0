Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C07483079
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jan 2022 12:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiACL1p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 06:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiACL1p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 06:27:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2230C061761;
        Mon,  3 Jan 2022 03:27:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD0BCB80E3D;
        Mon,  3 Jan 2022 11:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90ECC36AEF;
        Mon,  3 Jan 2022 11:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641209262;
        bh=+EVpLkyYj9fkNOwn0xZwXYmQneH7qq8wmfAIwuWZXAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Peq7Yi3vrboFFMEc5c5bGHUGpTXva8v2qMVBOnAvNh1/aI2/dKvUXpBXFIdSRDVJ9
         jHuBvf6lH1faBVkUFyVmoGyj+2BsjhlGA9nfXE44s64S3hMS6QVtn5ixtF9T1Rf0Ej
         IshGlWbEyrN/u7ZJmWNM2b7qF20ubjHWUcw85ClvBB7KFh/+PmsjdkKXsxar0whECT
         LQ2YR6brMwX3dPbhRvNJxQJ16oYH4o17za5hvjuTcPcYGphVjqOZEXQovxMVP/7H9l
         P3pgpIgeu81Jb037X5lLLyzim5M0sd9mOL/52gM0UPgCyH10UZYgAl5aKsPC0MZgZP
         v9WEtiJh/WDlg==
Date:   Mon, 3 Jan 2022 13:27:38 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dust Li <dust.li@linux.alibaba.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: print wc status on CQE error and
 dump needed
Message-ID: <YdLdqgBs+KkUtCVT@unreal>
References: <20211227123806.47530-1-dust.li@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227123806.47530-1-dust.li@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 27, 2021 at 08:38:06PM +0800, Dust Li wrote:
> mlx5_handle_error_cqe() only dump the content of the CQE
> which is raw hex data, and not straighforward for debug.
> Print WC status message when we got CQE error and dump is
> need.
> 
> Here is an example of how the dmesg log looks like with this:
> [166755.330649] infiniband mlx5_0: mlx5_handle_error_cqe:333:(pid 0): WC error: 10, message: remote access error
> [166755.332323] infiniband mlx5_0: dump_cqe:272:(pid 0): dump error cqe
> [166755.332944] 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [166755.333574] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [166755.334202] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [166755.334837] 00000030: 00 00 00 00 00 00 88 13 08 03 61 b3 1e a1 42 d3
> 
> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/mlx5/cq.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Thanks,
Acked-by: Leon Romanovsky <leonro@nvidia.com>
