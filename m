Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF31484EE0
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 08:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238221AbiAEHuM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 02:50:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38218 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238212AbiAEHuL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 02:50:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4C98B81964
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jan 2022 07:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B60C36AE3;
        Wed,  5 Jan 2022 07:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641369009;
        bh=QbmYltI5R36+WqvDa1Jt3UCf99xRWFHF6vryJUQXbvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R13ukVsNtuANFhjDnx/lv7syxdLI4wTp9uP7Ukxgs+q9zSUGDc/9K4Z7bPfRblXc8
         eDnEHc4Tq2ayoXofoRnDnIaMiHQABrG2Ktr1tcZgwVA5PhjSXNpfV2Jaju7HhifF2X
         EYG9ZiPI0m/Pq4uNilUIz99QSZMF/DReoKfu5SCUP7gH648G7OwGK/17/r4KIRDtZl
         JI7nRKpjgOP3j9nh+w6qiVIanZzjlz+zKZBOj2AkacFLPQvO+D6OQiuTv1A5JVOdKH
         bIM3/y2npq8cOYakpKRKi+nf1RaKC62YmqHZfjX61odTY1KA/ujLo9BdzIPUqTt4L6
         Qnd2rY58U55pA==
Date:   Wed, 5 Jan 2022 09:50:05 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     yanjun.zhu@linux.dev
Cc:     liangwenpeng@huawei.com, jgg@ziepe.ca, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 3/5] RDMA/irdma: Make the source udp port vary
Message-ID: <YdVNrWarZMPVuzVe@unreal>
References: <20220105221237.2659462-1-yanjun.zhu@linux.dev>
 <20220105221237.2659462-4-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105221237.2659462-4-yanjun.zhu@linux.dev>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 05, 2022 at 05:12:35PM -0500, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Get the source udp port number for a QP based on the grh.flow_label or
> lqpn/rqrpn. This provides a better spread of traffic across NIC RX queues.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
