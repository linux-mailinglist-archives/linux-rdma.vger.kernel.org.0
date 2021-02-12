Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A519131A554
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Feb 2021 20:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhBLTYw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Feb 2021 14:24:52 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5924 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhBLTYh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Feb 2021 14:24:37 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6026d5cb0001>; Fri, 12 Feb 2021 11:23:55 -0800
Received: from reg-r-vrt-018-180.nvidia.com (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 12 Feb 2021 19:23:53 +0000
References: <YCOep5XDMt5IM/PV@mwanda>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Vlad Buslov <vladbu@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <linux-rdma@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [bug report] net/mlx5e: E-Switch, Maintain vhca_id to vport_num
 mapping
In-Reply-To: <YCOep5XDMt5IM/PV@mwanda>
Date:   Fri, 12 Feb 2021 21:23:50 +0200
Message-ID: <ygnh5z2xrsxl.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1613157835; bh=Sy33DEe4gutokGmUtwcS85jrhrr9RtjisU9H8pyFnmw=;
        h=References:User-agent:From:To:CC:Subject:In-Reply-To:Date:
         Message-ID:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=ouPuvYTBo/1wi+YNYisgBsEsKE6cL96Wkn/qOv0USCMhdXKuI8zcM5SsVs5T92JkN
         LGRwOgfquFsyCabeRjmzsB0X6+uDtNSiy4OS5y1yM/Ik1OHJMAyR7xk0SZMwxsns8q
         rggcLCxP33cRnfh4fAir1sd3SHg/EtN+i+7GaInZ+C3pifzy9iPbnIJGw4n1ESnxZg
         rDDmDnvWwlyI2nVsn4NxDBd6qV6NaSR/xxgr0caQIcbyEeKDlpvWVk4WvklTfcgt1D
         yptrZTDwGbcjk31GPhfbV0yzCqfCitvDQwnB9nX1UPqJSa2yTSzuFfavyW4yipOHfI
         lVWrHEDa7V5zA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed 10 Feb 2021 at 10:51, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Hello Vlad Buslov,
>
> The patch 84ae9c1f29c0: "net/mlx5e: E-Switch, Maintain vhca_id to
> vport_num mapping" from Sep 23, 2020, leads to the following static
> checker warning:
>
> 	drivers/net/ethernet/mellanox/mlx5/core/vport.c:1170 mlx5_vport_get_other_func_cap()
> 	warn: odd binop '0x0 & 0x1'
>
> drivers/net/ethernet/mellanox/mlx5/core/vport.c
>   1168  int mlx5_vport_get_other_func_cap(struct mlx5_core_dev *dev, u16 function_id, void *out)
>   1169  {
>   1170          u16 opmod = (MLX5_CAP_GENERAL << 1) | (HCA_CAP_OPMOD_GET_MAX & 0x01);
>
> HCA_CAP_OPMOD_GET_MAX is zero.  The 0x01 is a magical number.

Hi Dan,

Thanks for reporting and sorry for the late reply. Adding Saeed, we will
handle the issue.

Regards,
Vlad

[...]


