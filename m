Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA05482EE3
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jan 2022 08:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiACH7D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 02:59:03 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58322 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiACH7D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 02:59:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5C0E60FAC;
        Mon,  3 Jan 2022 07:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0B7C36AE9;
        Mon,  3 Jan 2022 07:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641196742;
        bh=kyW/XMXR5lTP3aGxWP55dHobxfaSLE0dq/BDg5eq888=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SIhcNMeZj8G1Kbp2YCY+DaB7jmlU72dcQGI1V6UZ/jQVFL1M7mOIcKiQo68XHB/KW
         OeyQ2AlSfWEF6JlLCYu6WVHzcYxjK+NKb/UpdCSfE5VS8bJGYqt6vJ5en26Asj6Ary
         5ro5Bo6MPBa2ryfMphlordDFpNozOm4hUdSD9PFtaDXYq5lHX0cd3PhyHH4oUxK03O
         ZnpFqYCDfWfbS5y/LI6UfKl0wL9b0xdLf2t5HuUVvuYeYUCQw4XWlvJ/s2Z4iyrP8n
         eHoB516/MOI8yVsSXSnlW05K8V2uDtI5jGcqfGYiQsFqwpQlwSV9dUNJFeWoCqRwpN
         ttcD8/Xro/WlA==
Date:   Mon, 3 Jan 2022 09:58:57 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     cgel.zte@gmail.com
Cc:     jgg@nvidia.com, chi.minghao@zte.com.cn,
        dennis.dalessandro@cornelisnetworks.com,
        devesh.s.sharma@oracle.com, dledford@redhat.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        mbloch@nvidia.com, selvin.xavier@broadcom.com, trix@redhat.com,
        zealci@zte.com.cn
Subject: Re: [PATCH for-next v5] RDMA/ocrdma: remove unneeded variable
Message-ID: <YdKswVT1cjcyaS1S@unreal>
References: <20211214235015.GA969883@nvidia.com>
 <20211215055421.441375-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215055421.441375-1-chi.minghao@zte.com.cn>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 15, 2021 at 05:54:21AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return status directly from function called.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Please don't send vX patches as a reply to previous versions.
It messes the emails thread very badly.

See an output of your previous attempts:
https://lore.kernel.org/all/20211215055421.441375-1-chi.minghao@zte.com.cn/
Thread overview: 10+ messages / expand[flat|nested]  mbox.gz  Atom feed  top
2021-12-09  1:52 [PATCH] drivers:ocrdma:remove " cgel.zte
2021-12-09 13:08 ` Tom Rix
2021-12-10  1:32   ` [PATCHv2] " cgel.zte
2021-12-14  6:45     ` Devesh Sharma
2021-12-14  8:10       ` [PATCH v3 ocrdma-next] drivers: ocrdma: remove " cgel.zte
2021-12-14  8:43         ` [External] : " Devesh Sharma
2021-12-14  9:23           ` [PATCH for-next v4] RDMA/ocrdma: " cgel.zte
2021-12-14 11:12             ` [External] : " Devesh Sharma
2021-12-14 23:50             ` Jason Gunthorpe
2021-12-15  5:54               ` cgel.zte [this message]

Thanks
