Return-Path: <linux-rdma+bounces-14874-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAC8CA1A34
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Dec 2025 22:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52E803029BB9
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Dec 2025 21:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6F02FFDED;
	Wed,  3 Dec 2025 21:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kB3tUIJJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD072BEFF8;
	Wed,  3 Dec 2025 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796264; cv=none; b=do5K38jPvJsJwAoR0tUeVUG4C/89MlYsRUhNbKKleSok3V08YhC63fjFgioKANEEATvG3cZturcpRfRyCaLUO6TReIJ6PQ3NlLQEm3fQeknhWHyy7JbMnY7KWaAAGWVoHe3iISbYPrFk+B0p1/vzi6zeUrNFP47BnLy/44ZUgnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796264; c=relaxed/simple;
	bh=Q6sWGYGkcwYts/hsIwMe2M/sMlNUfkl6KmWW3KtmlRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdVNX+VZUaLorJX8LN7KVv4eSkwm1sc6+uzM+KqyxtNpcE4gF0TZhGq422383uzydXHcFwkxk2pn08PXXgcqU3hEZXyEwqSfk5o4RynCQiyU0y9YMBoYQyqzVqCWjve270e4c6Iv3Xg5hwliXisl6XnPK0NVsip4Be87y/Tw3Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kB3tUIJJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3BQdUE027938;
	Wed, 3 Dec 2025 21:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Kd2jnT
	FMo7gN7FkcM0/S9BS/yQRj1i3TA3o6LPb130Q=; b=kB3tUIJJ8kZIkh96/IhFuo
	iqC4wJ5KKAJGiaH+VwcNr00PHhxO8rhrxNBx7Kkk7gCRPPND03dKGF+NEdhMl9ws
	BM/kNmQKNPjZBi3F1R7X0r2YCdC8JwTZd9HTE4k4r8rA3mGMb7fBJ/QjEKoa316d
	N+LwY2gcWYTIH79u5T/2274R3aF7f7M5NMEiDURkXDPB5aGGGx58FnBCE9MbgtG9
	yU9WdhdZC+uCDEvxPx+ugLiWF3jI1D5+LeVYbnDeYLIQdBivU8mb7OHQt0C8ONyf
	BTBfY8Jr2j5Q8VaoZ35MhRnCUGUyea5pDaC4QOWgbp1DZeb0EaW6R0RKCGwS0HDQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrj9w2tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 21:10:47 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B3L2OU4001364;
	Wed, 3 Dec 2025 21:10:47 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrj9w2tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 21:10:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3Kgo9Q003891;
	Wed, 3 Dec 2025 21:10:46 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardcjv64m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 21:10:46 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B3LAiXH29688386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Dec 2025 21:10:45 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF36758054;
	Wed,  3 Dec 2025 21:10:44 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8B2A5803F;
	Wed,  3 Dec 2025 21:10:42 +0000 (GMT)
Received: from [9.61.253.252] (unknown [9.61.253.252])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Dec 2025 21:10:42 +0000 (GMT)
Message-ID: <99db437a-be91-4e85-a201-ec3a890900c8@linux.ibm.com>
Date: Wed, 3 Dec 2025 13:10:40 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Fix double unregister of HCA_PORTS
 component
To: Gerd Bayer <gbayer@linux.ibm.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
        Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shay Drory <shayd@nvidia.com>,
        Simon Horman <horms@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
References: <20251202-fix_lag-v1-1-59e8177ffce0@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20251202-fix_lag-v1-1-59e8177ffce0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B65ZY5li7B7M1GisuSwfk7z_iWSEgMeX
X-Proofpoint-ORIG-GUID: _-Zpt6WH2RjJJs55qScsek2unczQ750f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX77omxQPAvsuX
 IZJtox3l76hxwbzTk2KE8Q26LIokZZ67/c/iPk9Mxz9JiisDdC4qQrgQ7RG6IaqrRDbdGanNb6C
 rrYQ3P2eJBRWWX2CtkRe1ztNIbY4vWwB6vUf85AG6fJK/7j5qb7w4vpBUbchf3b1GEgPfg2dEyn
 jIzqwga+oDaa9W48j3RwqtXi2AU4R1CbjVu87wgkjyKcCFfNdZwpCeZwnAROAdTqpTn8sgaLusC
 VokCKTm0IHE6fJT4ydAiFPLhxXybJDo66Xetbner4STzoLgeUCKZANPUx9PWow7bugPEQW2Ckvm
 CUjbzbm78e5Fsjm4zVxfISETLjrn9cYC+iKAduGYsecE/MTKmVgp7bIZAlvN2yx0lV9nO38LBnE
 Jw14iBxLqQKfyX7ab+zwoWRg9U6GeA==
X-Authority-Analysis: v=2.4 cv=dYGNHHXe c=1 sm=1 tr=0 ts=6930a757 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=4VxT3ec_VtVgvZ1WTZIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020


On 12/2/2025 3:12 AM, Gerd Bayer wrote:
> Clear hca_devcom_comp in device's private data after unregistering it in
> LAG teardown. Otherwise a slightly lagging second pass through
> mlx5_unload_one() might try to unregister it again and trip over
> use-after-free.
>
> On s390 almost all PCI level recovery events trigger two passes through
> mxl5_unload_one() - one through the poll_health() method and one through
> mlx5_pci_err_detected() as callback from generic PCI error recovery.
> While testing PCI error recovery paths with more kernel debug features
> enabled, this issue reproducibly led to kernel panics with the following
> call chain:
>
>   Unable to handle kernel pointer dereference in virtual kernel address space
>   Failing address: 6b6b6b6b6b6b6000 TEID: 6b6b6b6b6b6b6803 ESOP-2 FSI
>   Fault in home space mode while using kernel ASCE.
>   AS:00000000705c4007 R3:0000000000000024
>   Oops: 0038 ilc:3 [#1]SMP
>
>   CPU: 14 UID: 0 PID: 156 Comm: kmcheck Kdump: loaded Not tainted
>        6.18.0-20251130.rc7.git0.16131a59cab1.300.fc43.s390x+debug #1 PREEMPT
>
>   Krnl PSW : 0404e00180000000 0000020fc86aa1dc (__lock_acquire+0x5c/0x15f0)
>              R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
>   Krnl GPRS: 0000000000000000 0000020f00000001 6b6b6b6b6b6b6c33 0000000000000000
>              0000000000000000 0000000000000000 0000000000000001 0000000000000000
>              0000000000000000 0000020fca28b820 0000000000000000 0000010a1ced8100
>              0000010a1ced8100 0000020fc9775068 0000018fce14f8b8 0000018fce14f7f8
>   Krnl Code: 0000020fc86aa1cc: e3b003400004        lg      %r11,832
>              0000020fc86aa1d2: a7840211           brc     8,0000020fc86aa5f4
>             *0000020fc86aa1d6: c09000df0b25       larl    %r9,0000020fca28b820
>             >0000020fc86aa1dc: d50790002000       clc     0(8,%r9),0(%r2)
>              0000020fc86aa1e2: a7840209           brc     8,0000020fc86aa5f4
>              0000020fc86aa1e6: c0e001100401       larl    %r14,0000020fca8aa9e8
>              0000020fc86aa1ec: c01000e25a00       larl    %r1,0000020fca2f55ec
>              0000020fc86aa1f2: a7eb00e8           aghi    %r14,232
>
>   Call Trace:
>    __lock_acquire+0x5c/0x15f0
>    lock_acquire.part.0+0xf8/0x270
>    lock_acquire+0xb0/0x1b0
>    down_write+0x5a/0x250
>    mlx5_detach_device+0x42/0x110 [mlx5_core]
>    mlx5_unload_one_devl_locked+0x50/0xc0 [mlx5_core]
>    mlx5_unload_one+0x42/0x60 [mlx5_core]
>    mlx5_pci_err_detected+0x94/0x150 [mlx5_core]
>    zpci_event_attempt_error_recovery+0xcc/0x388
>
> Fixes: 5a977b5833b7 ("net/mlx5: Lag, move devcom registration to LAG layer")
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
> Hi Shay et al,
>
> while checking for potential regressions by Lukas Wunner's recent work
> on pci_save/restore_state() for the recoverability of mlx5 functions I
> consistently hit this bug. (Bjorn has queued this up for 6.19, according
> to [0] and [1])
>
> Apparently, the issue is unrelated to Lukas' work but can be reproduced
> with master. It appears to be timing-sensitive, since it shows up only
> when I use s390's debug_defconfig, but I think needs fixing anyhow, as
> timing can change for other reasons, too.
>
> I've spotted two additional places where the devcom reference is not
> cleared after calling mlx5_devcom_unregister_component() in
> drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c that I have not
> addressed with a patch, since I'm unclear about how to test these
> paths.
>
> Thanks,
> Gerd
>
> [0] https://lore.kernel.org/all/cover.1760274044.git.lukas@wunner.de/
> [1] https://lore.kernel.org/linux-pci/cover.1763483367.git.lukas@wunner.de/
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> index 3db0387bf6dcb727a65df9d0253f242554af06db..8ec04a5f434dd4f717d6d556649fcc2a584db847 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> @@ -1413,6 +1413,7 @@ static int __mlx5_lag_dev_add_mdev(struct mlx5_core_dev *dev)
>   static void mlx5_lag_unregister_hca_devcom_comp(struct mlx5_core_dev *dev)
>   {
>   	mlx5_devcom_unregister_component(dev->priv.hca_devcom_comp);
> +	dev->priv.hca_devcom_comp = NULL;
>   }

Though this fix looks correct to me in freeing hca_devcom_comp (not too 
familiar with mlx5 internals), I wonder if it would be better to just 
set devcom = NULL in devcom_free_comp_dev() after the kfree? This would 
also take care of other places where devcom is not set to NULL?

Thanks

Farhan


