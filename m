Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EA9311FE7
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Feb 2021 21:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhBFUVl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 6 Feb 2021 15:21:41 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19998 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBFUVk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 6 Feb 2021 15:21:40 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601efa2b0000>; Sat, 06 Feb 2021 12:20:59 -0800
Received: from [172.27.0.22] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 6 Feb
 2021 20:20:58 +0000
Subject: Re: [bug report] net/mlx5: DR, Add STEv1 setters and getters
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <linux-rdma@vger.kernel.org>
References: <YB1B/iHMlHHnOWCh@mwanda>
From:   Yevgeny Kliteynik <kliteyn@nvidia.com>
Message-ID: <35cbffa9-58bc-c2be-2ec7-12339d12547e@nvidia.com>
Date:   Sat, 6 Feb 2021 22:20:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YB1B/iHMlHHnOWCh@mwanda>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612642859; bh=ygsHRKlsdVh1ZbHyntZhTYmXpAk1GS8gL02U5y4K880=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=COMAGuq5j5q2dkB5GHRerDDaalftqeYNblQtr+BbNqOAZUG7YQlcWX3CkMRkLqXAo
         SN6tj+nXdRRrlZxtCMy7QolAwRycP+RhN7ulS1KZpHpguVcGqpCCFE0IxW7ldgc9dE
         +FUBt6WEINzxMJtbly6nqDcJw3b7quv11MEsGNkWIOc3Xvtlhx5yHIhmqlRj6cnal4
         hCenLz8JaZ0nakY5ahq2KAU8oDOk8U+FvuSCp9Ff9VbKYP3MsbDf5CEHLdhLC4NOuT
         NJAfNuEuIVwdIwAj6OnxjcA9nnuy/htLMS+2jz+YfonpCQH+j/Ha5WKk7E3zfad3Cn
         d4bG0uHMgWczg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 05-Feb-21 15:02, Dan Carpenter wrote:
> 
> Hello Yevgeny Kliteynik,
> 
> The patch a6098129c781: "net/mlx5: DR, Add STEv1 setters and getters"
> from Sep 22, 2020, leads to the following static checker warning:
> 
>          drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v1.c:268 dr_ste_v1_get_miss_addr()
>          warn: potential shift truncation.  '0xff (0-255) << 26'
> 
> drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v1.c
>     264  static u64 dr_ste_v1_get_miss_addr(u8 *hw_ste_p)
>     265  {
>     266          u64 index =
>     267                  (MLX5_GET(ste_match_bwc_v1, hw_ste_p, miss_address_31_6) |
>                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     268                   MLX5_GET(ste_match_bwc_v1, hw_ste_p, miss_address_39_32) << 26);
>                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> index is a u64 but the right side is a two u32s.  The << 26 can shift
> wrap potentially according to Smatch.

Thanks Dan, will send a fix shortly.

-- YK

>     269
>     270          return index << 6;
>     271  }
> 
> regards,
> dan carpenter
> 
