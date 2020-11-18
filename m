Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F00E2B7836
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Nov 2020 09:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgKRIJz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Nov 2020 03:09:55 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12490 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgKRIJz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Nov 2020 03:09:55 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb4d6c90006>; Wed, 18 Nov 2020 00:09:45 -0800
Received: from [172.27.14.21] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Nov
 2020 08:09:53 +0000
Subject: Re: Issue after 5.4.70->5.4.77 update: mlx5_core: reg_mr_callback:
 async reg mr failed. status -11
To:     <jgg@ziepe.ca>, Timo Rothenpieler <timo@rothenpieler.org>,
        Saeed Mahameed <saeedm@nvidia.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>
References: <53e3f194-fe27-ba79-bcff-6dd1d778ede0@rothenpieler.org>
 <20201117195046.GI244516@ziepe.ca>
From:   Eran Ben Elisha <eranbe@nvidia.com>
Message-ID: <6cf6f99b-7d12-8964-d044-b11a313a4c26@nvidia.com>
Date:   Wed, 18 Nov 2020 10:09:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201117195046.GI244516@ziepe.ca>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605686985; bh=SzqX0hn6SamxsfqDTd92M3D6ECjultJckAsg2RGm838=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=GbGuzm4a01oBMb/X8xkXyF4EcsncahDmQOTy5j6Mee/QB9R1PdjQtdAj/rA8e7Wps
         Z9QjbiaEzw6Cq6AOOTZpYuQUTMMAFInDwpaIjerbfXbNON7sFvIRa+tEssgqtU7XhS
         YgpbVlVJnxRdPMKvMMiP75C3Iz2X4BRtLY1Cp0tPLIrH2CD1DPfZRP37WazYxKYoxe
         +bsAGAezDJ2C1wUFnlBpT60QvSARRkQM7ToRpStb9ywnfS4hgcZmv7pTRDnc8Kvq5f
         Ljuh5dBGcthT/XHG5kfeDPKyNtXRC5DBzzkI5Ky8dbm96XuduSzpFhT5ke7/8tijrp
         or1RW1uegHKXg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11/17/2020 9:50 PM, jgg@ziepe.ca wrote:
> On Tue, Nov 17, 2020 at 04:54:30PM +0100, Timo Rothenpieler wrote:
>> The most likely candidate for this seems to be
>> 0ec52f0194638e2d284ad55eba5a7aff753de1b9(RDMA/mlx5: Disable
>> IB_DEVICE_MEM_MGT_EXTENSIONS if IB_WR_REG_MR can't work)  which was merged
>> in 5.4.73. There were also a lot of mlx5 related changes in 5.4.71 though.
>> Though since this is a production system, I cannot sensibly bisect this.
> 
> It is very unlikely, neither mlx5 or ipoib read that bit.
> 
> That error print is very bad:
> 
>    Nov 17 01:12:58 store01 kernel: mlx5_core 0000:01:00.0: cmd_work_handler:887:(pid 383): failed to allocate command entry
> 
> It really shouldn't happen
> 
> This is more likely the cause:
> 
> commit 073fff8102062cd675170ceb54d90da22fe7e668
> Author: Eran Ben Elisha <eranbe@mellanox.com>
> Date:   Tue Aug 4 10:40:21 2020 +0300
> 
>      net/mlx5: Avoid possible free of command entry while timeout comp handler
>      
>      [ Upstream commit 50b2412b7e7862c5af0cbf4b10d93bc5c712d021 ]
>      
>      Upon command completion timeout, driver simulates a forced command
>      completion. In a rare case where real interrupt for that command arrives
>      simultaneously, it might release the command entry while the forced
>      handler might still access it.
> 
> Most likely it is missing some element.
> 
> Eran, can you check why v5.4.77 is totaly broken?

linux-5.4.y branch is missing the fixes below:

1. 1d5558b1f0de net/mlx5: poll cmd EQ in case of command timeout
2. 410bd754cd73 net/mlx5: Add retry mechanism to the command entry ...

The second fix in particular matches Timo's bug report.
It does not directly fix the offending commit, however the offending 
commit raised the probability to bump with this issue.

Saeed, can you notify about it to stable maintainers? I assume every 
stable branch should have all these 3 commits or non of them.

Eran

> 
> Jason
> 
