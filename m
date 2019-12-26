Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C60C312AD18
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2019 15:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfLZOkN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Dec 2019 09:40:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfLZOkM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Dec 2019 09:40:12 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA329206CB;
        Thu, 26 Dec 2019 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577371212;
        bh=efzHL22HYUz5k2qQqJeuKntAGwLxVj4J6991uGsCWa0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rhu1Xm7Qbnh3tsvHXsjFnBoL58hSlI3bI6l15ImeRcmEyfGYXoT7ijYxWUe07+D9e
         cQETXFj7xvA8aAtZ3YjZ42UEGKabsv0JtXhdG51bBwQIR3RiSM9+1hHNVg69ziQ6ft
         VcgavZDqLHw77ruj3OLTdRxbWtJ5hjTSXvpUsM0w=
Date:   Thu, 26 Dec 2019 16:40:09 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     xiyuyang19@fudan.edu.cn
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xin Tan <tanxin.ctf@gmail.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] infiniband: i40iw: fix a potential NULL pointer
 dereference
Message-ID: <20191226144009.GE6285@unreal>
References: <1577366516-19556-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577366516-19556-1-git-send-email-xiyuyang19@fudan.edu.cn>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 26, 2019 at 09:21:56PM +0800, xiyuyang19@fudan.edu.cn wrote:
> From: Xiyu Yang <xiyuyang19@fudan.edu.cn>
>
> in_dev_get may return a NULL object. The fix handles the situation
> by adding a check to avoid NULL pointer dereference on idev,
> as pick_local_ipaddrs does.
>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
> Changes in v2:
> - Release rtnl lock when in_dev_get return NULL
> Changes in v3:
> - Continue the next loop when in_dev_get return NULL
>
>  drivers/infiniband/hw/i40iw/i40iw_main.c | 2 ++
>  1 file changed, 2 insertions(+)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
