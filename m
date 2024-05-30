Return-Path: <linux-rdma+bounces-2679-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B922F8D46C0
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 10:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D690286E8E
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 08:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145221474DA;
	Thu, 30 May 2024 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dedpxjUe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0C4148841;
	Thu, 30 May 2024 08:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717056581; cv=fail; b=ol7MwdleXp2+u6a5dj67EZcGWmyPIONqmJtU1BURtzUxNIBd3ETigVeNz/8UobvGuHpiXnVZC1iFH0R7yRBux7LFtu2eVGLXVGX4DvSm0XYJS8aLyJGeZMypDt1onySBRgTvAINEoysaAYty67555s0r6GQVBIjrB3KCSyHDbRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717056581; c=relaxed/simple;
	bh=9mf9k5Fr6pl1PnJb31jKnnZrmhpo0tz9QiFkm2C6Gic=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T3VG+Ul13GXsM6mBT9qF80W+g2nvogdYw+u3b0+EPO3FeNPlyqsuXlgqDU7PtXEYhVKxDB4ALFevQBAowdlWz/FWxIMG30dpBALkEnLOzL13NJZwlAVEW6d2rctXCRGfA9w25XrhP1+0vqe+asOwZ3oS/+xRfsRn4aB2XjuOWxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dedpxjUe; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLldP1cD8ttgCMa68r/PbqeycOxJSoq1KaAW7elA7meNfj27jwwVf21tCtDQO3lHjqjny/6KXJ760IYUhk6KRhhhjSKu91M0elZP5YeLCcEULRwePQZ6E+PvbWByaXehsGucYIRi5MO2KLEVuujyrJv5aAinNe6eL9OJuB5+4RFGhyOsdwkBcRD2B6Y5ul3uW4prZ2/LzOBhxRS4bSzQY1+dL1y3KfS0sOxTLUWMBcNbZxuRgxa4n7U4zGe5x8tnce1KAzH07ds/bzEGRcyFtYbxYTPryqXLacaNzVw/Z47/r8Gv969vYH0SNGd5hI4UAU+KMgQTC82vJAi53celrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QAt15n/mjAyunx9KltJ61oYjBP3KwfoqSRZemXSq1o=;
 b=LE+LjJf51Dc7sMbIm0F+iXGRR9sDdQ+ceziAtHw0XIu9KVX02J5rEMUW+qU6CjM1thLwmmoKqSzFkCw9Q1DixAHA2P+HDYB65/Zt0tqHzq49CfCGxaUv+KHzfyYOjpbSzL+SkXXlQjifrIjIKP4GnfDKobROsgboVa4y5luCBr11SOxF0jWazFy9sA3X0UO+MUiolQDu81kt3db/UheWHgmGTVjm1rhB8CX8q1xHWP4T546UsTx2nDYG1NM9ozGXl5n4e2l0bvqp9B/xHoEEpQcLmJnGZzfKFvYq2K20OgJjGOc85yvIX7wcVff9+HyBLPbyiHnqphf3yCpCumJX2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QAt15n/mjAyunx9KltJ61oYjBP3KwfoqSRZemXSq1o=;
 b=dedpxjUejWUu8dO88VK0u7uBYOuTfGL6Owu+KZToXwyVeLjvdjfLXatqVeIkSO7tmr5Nra6TafPYXaNH3BoV/Lpq7Yn/XiBED9J2ecetXpkJpObUOqpAg2MGiAYaC6nQuShZR3kMiVUItARt/Qwgayp4XhycHMHc7+L5U5FLAJ1uTI1bPNmp2uIuw28Nx9QEvoOteb8Cu2IP+mjSBMasEE4GkCPiLyrAgLJnUj8OE7OZw7hYEYw5uelUck2lhuJLV2T6baq+e1H80fst/nRoeVKWA6I/VF8PxJpF35oFnwmEAGqIiCR/2DN7j/WXwSkjbLD6SF2CoNSYYXg7xHgrgw==
Received: from BL1PR13CA0129.namprd13.prod.outlook.com (2603:10b6:208:2bb::14)
 by SJ2PR12MB8882.namprd12.prod.outlook.com (2603:10b6:a03:537::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 08:09:36 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:2bb:cafe::1f) by BL1PR13CA0129.outlook.office365.com
 (2603:10b6:208:2bb::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.7 via Frontend
 Transport; Thu, 30 May 2024 08:09:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7656.0 via Frontend Transport; Thu, 30 May 2024 08:09:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 30 May
 2024 01:09:20 -0700
Received: from [172.27.34.245] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 30 May
 2024 01:09:18 -0700
Message-ID: <ba2adb79-7783-45cc-9597-a99d25c5db62@nvidia.com>
Date: Thu, 30 May 2024 11:09:17 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel panic triggered while removing mlx5_core devices from the
 pci bus
To: "Berger, Michal" <michal.berger@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "moshe@nvidia.com" <moshe@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	<phaddad@nvidia.com>
References: <PH0PR11MB515991D1E1AB73AFB7DCBD03E6F52@PH0PR11MB5159.namprd11.prod.outlook.com>
 <c51bef25-e8c5-492d-bb80-965b7f8542f7@nvidia.com>
 <PH0PR11MB515990257791E24CF6E0E51CE6F12@PH0PR11MB5159.namprd11.prod.outlook.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <PH0PR11MB515990257791E24CF6E0E51CE6F12@PH0PR11MB5159.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|SJ2PR12MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6ba3bb-b85e-45da-4602-08dc807fd7ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmxZYU5DdkU1NmNBdkhlR0k1Q29EdWdJTmhUbXBqRUd5UGtMZ3VxNXFLSnA0?=
 =?utf-8?B?c1V4YVVsdTZvRHJ0WUMzRURRcDhkT1F2VzJyeTgvZjdBa3hONEMxQkFaZHk1?=
 =?utf-8?B?WUZZRlhTVjRtOHoxYjhkZ0I2dnVURmM2RGpRS2ZSTEJBUTdBa2VsNTZzVGhx?=
 =?utf-8?B?SFI3cVIrM2lmVUIvUHRPeGZrV3F6L0IvTDBza284U3hpUUg5YlpPZkQyMTI5?=
 =?utf-8?B?bnFJbUVKdFEvM2xvRHJTbTE1ME12MGJ0NzZ5SVl5QStHVktnNFp6UEN0a285?=
 =?utf-8?B?YjcwbzdoTmtrQk5TSkt0V0kwc1RrVHU4OHdrZnFGZTB5elV3dGRkK2dFR2VN?=
 =?utf-8?B?b3lLMVV3TlI0V3F2aE9CWHVxczhwUHRjdzd4SGlseXZhN0FLY0RZL0U4TTZh?=
 =?utf-8?B?RWE1Rms2VWRDdzE4TVgxWDh2NG4wdDZwRjNCK3FTa05iY3o1M1R5TDRaWTBF?=
 =?utf-8?B?dzY3TWszam80SVF1TkhET1R3UG8xc3ZJWk1Oc05XZG1vbUdmV1cyODFuNlZR?=
 =?utf-8?B?czZma2tWaGdRQms2c0xPK3dHb1VNYXl0RDAxTUxVdnlnV3d1TWxsRkh4bkp4?=
 =?utf-8?B?NkxmQ01SYXd5T250dFp0SmM3dSsvNWhZVytmMjl0aENXU0pnRXA4NTNpNTJR?=
 =?utf-8?B?dVdFRE1ieGk1VWJtZkdSc1lSd0gvMWI1anV2QUdBb1FuLy9Vd01sNm92aE1U?=
 =?utf-8?B?eFduamRhaVdWZlN4T1FYSjZNeGU0bG5HK0tOajFPK2JDQWpVcWo3YjRYN0kr?=
 =?utf-8?B?dDlDVHBCTE1jOC81eXMyWWhJWHFiMmtwQmNKN2kwNFM0T3BZR2cwckZ1UXJv?=
 =?utf-8?B?eUNSeWdJT0V4d3hndDY3VjJmSlU3QlVhbDF5Mml2TXNjcVlyNm1iUzFONjVk?=
 =?utf-8?B?Wm83UHh4NjJDZVVMNkJDaE02a2ZJbTh5a0E1b2l4ZXRBRmF1bnllejFDd2do?=
 =?utf-8?B?VlQyam0yMzNybFJBR1pyd2JWVXNSbnJkWDJua2NoQXVnZnNGSGtKMW5qRklo?=
 =?utf-8?B?QmVoWTJJMlBzcHRSbnlhMGdlWllMblFSWi9namp0MjNOT1labkcrWmhPNnBY?=
 =?utf-8?B?aENsSTJiNEdwSktkTERjY2VUR0M2a2RqU0gwWDdCZXVSek9IcjR2VmhqeG1C?=
 =?utf-8?B?RXBNeHRCcXV0UTQ5VEVlVGFYSXBERGRTNHFCd092Z2doaUh3dTNWL3czWVFX?=
 =?utf-8?B?aTIvMThVbnoxME9Pd2x1UkxKWmkvbzhmKzRuR1ZIQ1dDQjZPTFc2ZEYrb003?=
 =?utf-8?B?NlRVRkQvSk9qNmpDbG04QThjSm82NjdBWHNBUkY1cDVLaVU3N0w0bHVSZ01x?=
 =?utf-8?B?T0RlMGMvbDMydUJudittMGQrOWhRcTZZc2hST2dDYzEwT2FqWiszV3J5a0F6?=
 =?utf-8?B?TFZUUnVHYUw2djd1TkhHNW5JUlUzelVMckdjS2VvdlNsaFArRzZKZkF3NkQ0?=
 =?utf-8?B?c0tKNjB5TTFDUkJwbUJwRENSelh6b1ZKYTdnbXJlVVluNUtuRVhVMUxOdk1h?=
 =?utf-8?B?a1NxcE5KU0FjU3Zja29hTERlU0psT2RDQmE3WXRScTVhNDV2WG5QT240QThQ?=
 =?utf-8?B?ZS93WXhvRG1EbThlOHZzK0tPVkY1NjNCSXBiLzR0cjUzdGE0WldYMnNNWksz?=
 =?utf-8?B?TkZsNTg0NnZyUytnNkFFeFVzVS9xamF6QWNyQjl4d3hSQmh1Z3BxUjVjN0Fk?=
 =?utf-8?B?WnM2TExkQy9iMlBhSHRvVHJnYVlUd24vZWhOVWRuZUhXbVhSOFgwM2JpazAr?=
 =?utf-8?B?UkRuK2wxYjdPLzExTzlrYXhyN0x0L2xQcFd4TDZNYy8xOFJKY3lFVWRPaGVY?=
 =?utf-8?B?NUV3aDFWUy9lME5GUnNPNGg2TE85elVQNVh3dXRBVXFNRW4wbWx2aEx0Y2VF?=
 =?utf-8?Q?kzhDVLiDGR3NE?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 08:09:34.9721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6ba3bb-b85e-45da-4602-08dc807fd7ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8882

Hi Michal

can you please try the bellow change[1]?
In addition, the bug/trace is in mlx5_ib driver code, so I CC rdma ML
(linux-rdma@vger.kernel.org).

thanks
Shay Drory

[1]
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -614,7 +614,6 @@ int mlx5_ib_poll_cq(struct ib_cq *ibcq, int 
num_entries, struct ib_wc *wc)
         int soft_polled = 0;
         int npolled;
-       spin_lock_irqsave(&cq->lock, flags);
         if (mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR) {
                 /* make sure no soft wqe's are waiting */
                 if (unlikely(!list_empty(&cq->wc_list)))
@@ -625,6 +624,7 @@ int mlx5_ib_poll_cq(struct ib_cq *ibcq, int 
num_entries, struct ib_wc *wc)
                 goto out;
         }
+       spin_lock_irqsave(&cq->lock, flags);
         if (unlikely(!list_empty(&cq->wc_list)))
                 soft_polled = poll_soft_wc(cq, num_entries, wc, false);
@@ -635,9 +635,9 @@ int mlx5_ib_poll_cq(struct ib_cq *ibcq, int 
num_entries, struct ib_wc *wc)
         if (npolled)
                 mlx5_cq_set_ci(&cq->mcq);
-out:
         spin_unlock_irqrestore(&cq->lock, flags);
+out:
         return soft_polled + npolled;
}


On 28/05/2024 9:18, Berger, Michal wrote:
> *External email: Use caution opening links or attachments*
> 
> 
> Hi Shay,
> 
> Appreciate your feedback. I applied the suggested change on top of our 
> 6.8.9 kernel build, but I am afraid it didn't solve the problem. 
> Granted, the stacktrace doesn't point at the mlx5_health* anymore, but 
> the panic happens exactly at the same time - it takes couple dozen of 
> tries to trigger it, but it's still there. Attaching latest trace.
> 
> Michal Berger
> 
> 
> Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk
> 
> KRS 101882
> 
> NIP 957-07-52-316
> 
> ------------------------------------------------------------------------
> *From:* Shay Drori <shayd@nvidia.com>
> *Sent:* Sunday, May 26, 2024 2:35 PM
> *To:* Berger, Michal <michal.berger@intel.com>; netdev@vger.kernel.org 
> <netdev@vger.kernel.org>; moshe@nvidia.com <moshe@nvidia.com>
> *Subject:* Re: Kernel panic triggered while removing mlx5_core devices 
> from the pci bus
> Hi Michal.
> 
> can you please try the bellow change[1]?
> we try it locally and it seems to solve the issue.
> 
> thanks
> Shay Drory
> 
> [1]
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> index 6574c145dc1e..459a836a5d9c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> @@ -1298,6 +1298,9 @@ static int mlx5_function_teardown(struct
> mlx5_core_dev *dev, bool boot)
>           if (!err)
>                   mlx5_function_disable(dev, boot);
> +       else
> +               mlx5_stop_health_poll(dev, boot);
> +
>           return err;
> }
> 
> 
> 
> On 24/05/2024 11:07, Berger, Michal wrote:
>> Kernel: 6.7.0, 6.8.8 (fedora builds)
>> Devices: MT27710 Family [ConnectX-4 Lx] (0x1015), fw_ver: 14.23.1020
>> rdma-core: 44.0
>> 
>> We have a small test which performs a somewhat controlled hotplug of the net device on the pci bus (via sysfs). The affected device is part of the nvmf-rdma setup running in SPDK context (i.e. https://github.com/spdk/spdk/blob/master/test/nvmf/target/device_removal.sh) <https://github.com/spdk/spdk/blob/master/test/nvmf/target/device_removal.sh)>  Sometimes (it's not reproducible at each run unfortunately) when the device is removed, kernel hits
>> Oops - with our panic setup it's then followed by a kernel reboot, but if we allow the kernel to continue it eventually deadlocks itself.
>> 
>> This happens across different systems using the same set of NICs. Example of these oops attached.
>> 
>> Just to note, we previously had the same issue under older kernels (e.g. 6.1), all reported here  https://bugzilla.kernel.org/show_bug.cgi?id=218288 
> <https://bugzilla.kernel.org/show_bug.cgi?id=218288>. Bump to 6.7.0 
> helped to reduce the frequency
>> of this issue but unfortunately it's still there.
>> 
>> Any hints on how to tackle this issue would be appreciated.
>> 
>> Regards,
>> Michal
>> ---------------------------------------------------------------------
>> Intel Technology Poland sp. z o.o.
>> ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
>> Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.
>> 
>> Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie  jest zabronione.
>> This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

