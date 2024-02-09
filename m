Return-Path: <linux-rdma+bounces-990-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7831C84EFAC
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Feb 2024 05:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A9CEB25434
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Feb 2024 04:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505165394;
	Fri,  9 Feb 2024 04:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hvdfWUaw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E19EFBF3;
	Fri,  9 Feb 2024 04:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707454413; cv=fail; b=dKXkQYxSEHMQRs2rF+7qHULv6objwiBQsZx8bGOj9ix5BOQxT9JRWA1jpeJQfrE1fr/YYfnpBOus+3LSJPLSFAxb/VmBmuhAQvlpL8Oobd+ZOtF8p9MvpwFA60MbomdC177xMzrvZZ2PNDIOTNuUYJ+unNWRX0QpqGkQgQ/yNY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707454413; c=relaxed/simple;
	bh=mdpS98oc0enxEAadPJoPAwbQZZ7Y7gwXBq5LqNHIB1w=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=V+D0N3Tf0L28j0YhlGsQDZIGSOTX7a2Gsm2fGQhtYj/eni2aaxKSEo2fBThV5SKtVRfVX5iVhg42lEq8Ap3kRhkhZydw/uDnDEPCYdNIB64VPOdU4Tr/JjrO0eoiWOVypyI90N9I4yKU8jT3Jm70PFu2AgWaMuCVr4P0vNn/rEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hvdfWUaw; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzqjECsCTx06xPnu+rO18jMAerW/3nvbV4r5NkDf2THieZhZnq5sXn/vNFmY7hlalSMbB1gIprYvPBGFXaNpSYImIC1yydM52yCXk3ruYS6ZzD7iKCVQt75KaCm4fyX6wpqmjwYWkV00J1ZLzRAkhFNtfyXw/vqsvAik8dZdL2v3aPGrEmUh/WG6wE8trT2xmOBi5lWPKlH3gFHbghn8dD2s6fM30Po1jyDCwkQLIDTYePCBx+XP5K2CdZrbz4cn/NT/RFlnUzvMRHpPmog6aHhWRI6jnPJXYwP0xi848fMTzHpLXLBLlFMvOvCd3Utt50rYtm8PUQZeWw3k/OOiTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QacRvJAU444z4GlFNcppefd3bZHzCeC68vCbZWfa2c=;
 b=OPqd5u3nARhcvwOMkOuxpYx0Dy48XZV91k/+fjhF6Fb/MM7dMMXKp9UtLIvjRv5TzMIcnb7t6/DNe88tLIhlbFHtr64OlU0qFLnEF/N10G/UZk+KI5odI6U+dx621kM69zmEEbJ75q/M2wj54XWHm9rYkMgd8TZW/W70JRfYid+pKc6fRKzYqQC9KG4eaKQDEYHPyBLrJYqMJYHaWYuuNYVJMi7i7BYgGaMedyPlgI9KobY92k/8MHbOGpfcBNob6OFG9x+p1lw+QntA1bdeSqFs1kA0fcP6JHNZs+MHy4w6pMMfLz/PdXmECxAZH+lnQUtmmRPzgkFWfvcWk1kCzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QacRvJAU444z4GlFNcppefd3bZHzCeC68vCbZWfa2c=;
 b=hvdfWUawLVqyIzm6zTG5eL7cCH1z4fdxPGxm3mI0mVAZPMly6vy8fDNvwS4P/B3YA7Qp6BSsWYx37/W41QcVMvXp9KKRfOiKeqxKaPue8XaYm0G2ZvEbRPBnLLbT3NCXH5BWAvgmhaKzCCpVuNZp119FWpxvpxDCVr6KQscpFxld+i3xoGcEa7kI3pvSS4szN5bnYtAdwUqO8Y25WAUFE3CVN4i5CjYpfSv7uMBYuhhzzBW/U1rHi63gcw4wis8Qg+aULFtdHwwBS2B/GyXgEWl4QUkz/f1SV1xpCO6kz7xK1tkn6WRmF67mwz/QCrnwuYopz2v+BxwCqtJyux8xXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SA0PR12MB7001.namprd12.prod.outlook.com (2603:10b6:806:2c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Fri, 9 Feb
 2024 04:53:29 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670%7]) with mapi id 15.20.7270.012; Fri, 9 Feb 2024
 04:53:28 +0000
References: <20240208030702.27296-1-jdamato@fastly.com>
 <8c083e6d-5fcd-4557-88dd-0f95acdbc747@gmail.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, tariqt@nvidia.com, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, "open list:MELLANOX MLX5 core VPI driver"
 <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v3] net/mlx5e: link NAPI instances to queues
 and IRQs
Date: Thu, 08 Feb 2024 20:43:57 -0800
In-reply-to: <8c083e6d-5fcd-4557-88dd-0f95acdbc747@gmail.com>
Message-ID: <871q9mz1a0.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::8) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SA0PR12MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 345e77c9-9911-4e45-1710-08dc292b0e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7dB3nuF64fGWb5mgNDOhra0K8FuiCnjNjMYJWzKaVRwHHgH1gTnQC0wpeKnaKSXKg5C+1T+05GlltFTVvYnwAzTr11Junyf+oXiA9u5ltCNLX6xGdQesXwIkTYp3EZ25Hs9zWzr2uu+aQ+v98t890IyJTihMZGQGSXuYzTCoZ5QxQtcS6p0OEeQeI3YgsJWuX5CoV9RyhI7hWsT11Sd8KMZvrMXimPRqhqZKYDpL15wFDazngM5WhhTOv1Z9FQ4OYpvTeM+Q4Q7M1cXT2CFrPsM+pNA21Bb35YprO8g3iSrmQqJpTP4BEsndHcvmEjbsSLBRAJSRvoyfl9eE8OUPEWIHjhbxWETDB7SKj3916Jqa4spbcNTjpK7ui4m5xhcuqi/PbHvMyiyOvzBgsbG//i13yDoguYGwGsv0GuWzv4YXa0OrPhUGwGg+yvC+OqY0UOGQJIDMinWAVHkCnEG2CD/QvXdgHr2673+IMkg6UUnJmwX0JfmT1UJ3n95gJF8ZhfjSzYI0Rl40tZQFoX8xeF4+UAoKe3raaQgyKixRxqWgF2Xav98wAHxk92sfsfAKWnII2xt6PE8pDs594dv2sMvMkIHG9Ovj5kA71Utg+40=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(478600001)(2616005)(53546011)(6506007)(36756003)(6666004)(38100700002)(83380400001)(26005)(41300700001)(86362001)(6512007)(966005)(6486002)(8936002)(8676002)(4326008)(2906002)(7416002)(5660300002)(66476007)(66556008)(66946007)(54906003)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8yQzByVPiVsIITYBtLD6lwVEEst5TPocAE5LNm6OJ3uFrZAsiPbT4RpNMw0g?=
 =?us-ascii?Q?GUpI/zSAfFv0P83jeVRkdEoGtiaLNT6VRAIzh9N7RRfighjuXnUkmQu20Zi1?=
 =?us-ascii?Q?jQnM31Dc/hnF/Hu13LgIqolHQrf2kaXkPl0tev5wyRo42RuQwOiSC2ArJwbX?=
 =?us-ascii?Q?oxDPrIaQ3nzoSpGUGmBXbT1QkhEpOv1NLpkd7mS5D7bbY7GPwT14NBToSaUp?=
 =?us-ascii?Q?RoThRpR1RNbtSr+DpWsiaB4IOPcc7KCVVaASCeVcDk7AWKp9c4MZAMjsEqs+?=
 =?us-ascii?Q?kODItgwDs0b/2bO/8N8jOQWbkoy0Y/eXd1nYHxNMSdAIRWeJaz7l97mc6H5c?=
 =?us-ascii?Q?t2iWngXPRDjCZ5K+j2tt1K3r/SXM+yvvxivBRz1L7XIq9QhrlxzLAjkI1rmA?=
 =?us-ascii?Q?SqA7LUeD5MFfUyyld9sOe4y3NGCkBoETGL+vAHWhxyqF1/G62Mo0Edv3lwrm?=
 =?us-ascii?Q?q3xCxSQti/482SvzQnFOJMgEWDsDrh7ArUHl4Dh7S6QQuQTl2HKhQ7YqBG15?=
 =?us-ascii?Q?qgqyZJV/2SeD+ZAIsWno4pSJeLm0B3/npyN7xR1O1ITiFMBo7VIsxaTXNFD8?=
 =?us-ascii?Q?gPSnAJqn0uzANMMq9xLh6JNtEbKWRyU5cRQjjckCLWkE0rlteDsB+pw4yv5f?=
 =?us-ascii?Q?r7w1SBvf62nz/1QKcefcjIPcsmXBErDMzcm29d7n/I0Oy53nWPetj36BMlTG?=
 =?us-ascii?Q?v/ED7s31MCjJHKxsj9l2GHcEQOmBDE5sCZ2pQDviVTKpnQewLul/0wpi2lT7?=
 =?us-ascii?Q?Ds2hTLmKdx0ROuuIgBpZysG+a0xtm9ZgYFiAAOR0AyMgGJdCPsRAU/b/lCMW?=
 =?us-ascii?Q?vVLwiWzPWGHZZCceHZMXYI96L5a7n0DjTN0NHg3Pg+dg87zxM/w7H/Fz8nc8?=
 =?us-ascii?Q?l+HzS5SeO1jB4ZGnrHHljudFnB8Ghj2MLrAz1+9FAV+t9E46ri5Kf56zDjrA?=
 =?us-ascii?Q?Qx0DpytogwoatQtDBg1+aZ5kQQQ5QcPYP+WYZgQ9TZE8yv9psGwdnpAVOTRK?=
 =?us-ascii?Q?bISgam+5x0eY/UOvHutb3zBq9pxRljxLaJw6peHYDoNalxJ1X5nVImYnrGAp?=
 =?us-ascii?Q?KIGYD8vIItl91OEFJ9KuDEyC04TH5e4LIoEE/8mcANNXL5Rl1wxp6gyFm/Ay?=
 =?us-ascii?Q?V4D2Rzxz+XqSCjTdfXyr0rqn6hP+WOKY2OGsnlVw/c1GAG4RL9v2vNKYeciG?=
 =?us-ascii?Q?v4X0KQgtC3BhbSdST0MrqqYDOopuUVYgcitqeu0e8gask7RyEl3NxnFWEWdh?=
 =?us-ascii?Q?1vR/f4rox4mv6T/JwOxkc9+Ar1bpGBDU6rIYSZ2LL6bTBG9MJprFX0XTyYZK?=
 =?us-ascii?Q?BgcklyaiYNbCh/Gi2rj0SG+S1WEe0NnmTG0GhTDq1gtvwoyXEKLtKDS2Jwb5?=
 =?us-ascii?Q?Z2EBqxNSrVM8K5L+b1LQ1vvYX5sidFvtzvG2Ooi3cSv/6JNJFXXJhfFhgqPS?=
 =?us-ascii?Q?lshq0zbjgitH1h+46QJqVK9inoJRV0qaNZ/UXbSz4+ktD/hT0ascdsErzDDe?=
 =?us-ascii?Q?evB82oR8PwDMSbHhMnyMfL5H/9NiPb9o0d5HzTSGDaru6f4kpAQO5h5OdUaT?=
 =?us-ascii?Q?dcwAp2oQsZyiY93hbut3Vc3FyjKMW2GrGUElp377MoUv6/6/bQilLhyc4Uvc?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345e77c9-9911-4e45-1710-08dc292b0e77
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 04:53:28.4329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWAZTkFI2WGPtWXpSNxo7WAleHkhiZOlV2RYWZUSXtCYwYRYw+lhxT6K6C5s4HL3QNUcSQ/Kq7NpJTCYjzdtjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7001

On Thu, 08 Feb, 2024 21:13:25 +0200 Tariq Toukan <ttoukan.linux@gmail.com> wrote:
> On 08/02/2024 5:07, Joe Damato wrote:
>> Make mlx5 compatible with the newly added netlink queue GET APIs.
>> Signed-off-by: Joe Damato <jdamato@fastly.com>
>> ---

Just came back from testing this code. Let me make one cosmetic point
here. I noticed this patch has a line that is past 90 characters. Would
be nice to get it wrapped in the next version. We use 90 instead of 80
characters for the line wrap in the mlx5 driver because of firmware
command interface related code would lead to very hard to read lines if
wrapped at 80.

  https://patchwork.kernel.org/project/netdevbpf/patch/20240208030702.27296-1-jdamato@fastly.com/

>> v2 -> v3:
>>    - Fix commit message subject
>>    - call netif_queue_set_napi in mlx5e_ptp_activate_channel and
>>      mlx5e_ptp_deactivate_channel to enable/disable NETDEV_QUEUE_TYPE_RX for
>>      the PTP channel.
>>    - Modify mlx5e_activate_txqsq and mlx5e_deactivate_txqsq to set
>>      NETDEV_QUEUE_TYPE_TX which should take care of all TX queues including
>>      QoS/HTB and PTP.
>>    - Rearrange mlx5e_activate_channel and mlx5e_deactivate_channel for
>>      better ordering when setting and unsetting NETDEV_QUEUE_TYPE_RX NAPI
>>      structs
>> v1 -> v2:
>>    - Move netlink NULL code to mlx5e_deactivate_channel
>>    - Move netif_napi_set_irq to mlx5e_open_channel and avoid storing the
>>      irq, after netif_napi_add which itself sets the IRQ to -1
>>   drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c  | 3 +++
>>   drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 7 +++++++
>>   2 files changed, 10 insertions(+)
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
>> b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
>> index 078f56a3cbb2..fbbc287d924d 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
>> @@ -927,6 +927,8 @@ void mlx5e_ptp_activate_channel(struct mlx5e_ptp *c)
>>   	int tc;
>>     	napi_enable(&c->napi);
>> +	netif_queue_set_napi(c->netdev, c->rq.ix, NETDEV_QUEUE_TYPE_RX,
>> +			     &c->napi);

This should only be set if MLX5E_PTP_STATE_RX is set. Otherwise, the rq
is not initialized. The following callgraph should help illustrate this.

   mlx5e_ptp_open
    |_ mlx5e_ptp_open_queues
       |_ mlx5e_ptp_open_rq
          |_ mlx5e_open_rq

>>     	if (test_bit(MLX5E_PTP_STATE_TX, c->state)) {
>>   		for (tc = 0; tc < c->num_tc; tc++)
>> @@ -951,6 +953,7 @@ void mlx5e_ptp_deactivate_channel(struct mlx5e_ptp *c)
>>   			mlx5e_deactivate_txqsq(&c->ptpsq[tc].txqsq);
>>   	}
>>   +	netif_queue_set_napi(c->netdev, c->rq.ix, NETDEV_QUEUE_TYPE_RX, NULL);

I believe it would be best to tie this to whether MLX5E_PTP_STATE_RX is
set or not.

>>   	napi_disable(&c->napi);
>>   }
>>   diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> index c8e8f512803e..2f1792854dd5 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> @@ -1806,6 +1806,7 @@ void mlx5e_activate_txqsq(struct mlx5e_txqsq *sq)
>>   	set_bit(MLX5E_SQ_STATE_ENABLED, &sq->state);
>>   	netdev_tx_reset_queue(sq->txq);
>>   	netif_tx_start_queue(sq->txq);
>> +	netif_queue_set_napi(sq->channel->netdev, sq->txq_ix, NETDEV_QUEUE_TYPE_TX, &sq->channel->napi);
>
> Might be called with channel==NULL.
> For example for PTP.
>
> Prefer sq->netdev and sq->cq.napi.
>
>>   }
>>     void mlx5e_tx_disable_queue(struct netdev_queue *txq)
>> @@ -1819,6 +1820,7 @@ void mlx5e_deactivate_txqsq(struct mlx5e_txqsq *sq)
>>   {
>>   	struct mlx5_wq_cyc *wq = &sq->wq;
>>   +	netif_queue_set_napi(sq->channel->netdev, sq->txq_ix,
>> NETDEV_QUEUE_TYPE_TX, NULL);
>
> Same here.
>
>>   	clear_bit(MLX5E_SQ_STATE_ENABLED, &sq->state);
>>   	synchronize_net(); /* Sync with NAPI to prevent netif_tx_wake_queue. */
>>   @@ -2560,6 +2562,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv,
>> int ix,
>>   	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
>>     	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
>> +	netif_napi_set_irq(&c->napi, irq);
>>     	err = mlx5e_open_queues(c, params, cparam);
>>   	if (unlikely(err))
>> @@ -2602,12 +2605,16 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
>>   		mlx5e_activate_xsk(c);
>>   	else
>>   		mlx5e_activate_rq(&c->rq);
>> +
>> +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, &c->napi);
>>   }
>>     static void mlx5e_deactivate_channel(struct mlx5e_channel *c)
>>   {
>>   	int tc;
>>   +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, NULL);
>> +
>>   	if (test_bit(MLX5E_CHANNEL_STATE_XSK, c->state))
>>   		mlx5e_deactivate_xsk(c);
>>   	else

--
Thanks,

Rahul Rameshbabu

