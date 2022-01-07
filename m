Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C64487528
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jan 2022 11:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346549AbiAGKDg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jan 2022 05:03:36 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17333 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbiAGKDf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jan 2022 05:03:35 -0500
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JVf0Q1RNhz9s2f;
        Fri,  7 Jan 2022 18:02:30 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 18:03:34 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 7 Jan
 2022 18:03:33 +0800
Subject: Re: [PATCH v3 2/4] RDMA/hns: Replace get_udp_sport with
 rdma_get_udp_sport
To:     <yanjun.zhu@linux.dev>, <jgg@ziepe.ca>, <mustafa.ismail@intel.com>,
        <shiraz.saleem@intel.com>, <zyjzyj2000@gmail.com>,
        <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>
References: <20220106180359.2915060-1-yanjun.zhu@linux.dev>
 <20220106180359.2915060-3-yanjun.zhu@linux.dev>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <3326b471-d4e4-b82e-22af-9b4845584fbc@huawei.com>
Date:   Fri, 7 Jan 2022 18:03:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220106180359.2915060-3-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/1/7 2:03, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Several drivers have the same function xxx_get_udp_sport. So this
> function is moved to ib_verbs.h.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

Thanks

Acked-by: Wenpeng Liang <liangwenpeng@huawei.com>
