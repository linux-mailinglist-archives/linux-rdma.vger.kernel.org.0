Return-Path: <linux-rdma+bounces-1872-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143D189DB50
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 15:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3719B1C21D36
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 13:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B1313665D;
	Tue,  9 Apr 2024 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y4GwhB7P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2091.outbound.protection.outlook.com [40.107.244.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895327F7CF
	for <linux-rdma@vger.kernel.org>; Tue,  9 Apr 2024 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670672; cv=fail; b=TtmnFXADKb34gSs0YP7sJVzgsgu/6Q0xtsnv4LXXbsE0N0ajysDeA2C6ANJYD2ao/5g290Wj5dNjPv76OiMx23ZNQRpiqN9WvS3YTSmWKmzYgw+9JbbPXsL0H8bgGBj6hDxjeqMH3zWnHviUwLEHSREpReKFYHKRC/A1LZ+qs7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670672; c=relaxed/simple;
	bh=J/SdGLA617jE//FhG7RVJOhGTvGdabKv90mG7HP8V00=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ck8IMBucldgtGBKSZ6ukC1IhIrY72mPcYWBIZ6pagyzbRjGc+ME9bJMtjiVnjEt9fpYQZWt5/+hmLI8AEYLnEvWtg4UVaFTNLHCn14/o6H8shOUd0f5TJYwQ7i4+EzwrAz6GN6dWZGRDhEnqTBLhw8OZSkZ2r9gDKSo7Lf2ksYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y4GwhB7P; arc=fail smtp.client-ip=40.107.244.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTXy2Jl+FN2rqlDgMptqNrHtSkpCf5e2JLMwwKYH1BBoMElu3Cr+4RXfTT7VX3zJAFfbtwo+l8x/RK6pxznWUCi8qIlI7/wpkMcAxoTO4X4ZBbK8FhXVH9nqmPJa7qUYCIHbfHl2XpP9gvYCWF5EYeiNvsif1iUYn/a7y8VCyep+cUbu3/paXA1ZmpVi71xYPaFCadKUWF+dYYpIziL9LNjcLTNoqNcjBcfCgid7GF5unaSUoH9LMz8S3cFoHXdMlVCcW7WGt9XL0Ux9uf6D09sxsCE0xVuQYLieO5x8+Jj5iIOPZnNNyn0ux9ztzlAFpTRqIbRWbraUnS4x9aKH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ez/ysRQDTnf61967VPboR18W1vKwkw4TKooc3sKfBKA=;
 b=WgKnC0oQYaTvOzwsGg9A6sFtzFEveZzfyrtMSXeVmBmxr3BTLEQvEu2C2zsyAC+gu3dmomwZnY370wbRCfgSEXL3OgaTvZ9JmkRUBWzjOlbuFz864KY2/aLd26csfqjfM+Qi55zQaqx838oT1Tq17H2EMZQ+DryKynz5nPKRZDb9mLW/8xb9SpxAU5ov1Snm5Mrp98+l0AAwlt20B76i57iDhW+22uHqbJ3LGhd28UC/GTVvgYxyKkGhnawwwaElfjXTfZ7fy+igWxznEoMtLocXeu/6YjBH9t5Ibvt/7YXdAQwK599BNFrnZrmx8fIBUR02oa8N6MOM3lQeEhoowg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez/ysRQDTnf61967VPboR18W1vKwkw4TKooc3sKfBKA=;
 b=Y4GwhB7P9WXpYid9kNSb9ZRpoxfXiXWqPLDK7Zct74tQzgyfP/o1DaE6i2VwRlC5TzepGfVfASEDbuRHIc+eQHZsvmwdmvTmnbRUe5EQNAnSb2eJ2hnY9s8+2WbYPYnOdg1WxfcTD5iIx65TgYFEM5zdjMe5Ze6Y/IINtdZ0c0yGtt2Geftepe/0DqnDlgAj7QseeYLOXULhjgRLNnVmgUkcRGmYeXFQ00EIWeHv2lf8tYnk55u9CTAq+XAOjflS/OhBt6RIW/rrELipNci7adI1bJvu9qoRgfPC1bdW4YzEChycsojrDYtlz+65XBat9GX3SZvoF5gJC9xZlQLq6A==
Received: from IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11)
 by PH7PR12MB7115.namprd12.prod.outlook.com (2603:10b6:510:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 13:51:06 +0000
Received: from IA1PR12MB7495.namprd12.prod.outlook.com
 ([fe80::2284:af7b:1045:b9d]) by IA1PR12MB7495.namprd12.prod.outlook.com
 ([fe80::2284:af7b:1045:b9d%3]) with mapi id 15.20.7409.049; Tue, 9 Apr 2024
 13:51:06 +0000
Message-ID: <b708a71e-e832-48a3-9467-40939c3e9639@nvidia.com>
Date: Tue, 9 Apr 2024 21:50:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next v1] IB/core: Implement a limit on UMAD receive
 List
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Guralnik <michaelgur@nvidia.com>, linux-rdma@vger.kernel.org
References: <e2262f827f43518e5e3a4d825a3e0514c0f7aa5f.1712668708.git.leonro@nvidia.com>
Content-Language: en-US
From: Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <e2262f827f43518e5e3a4d825a3e0514c0f7aa5f.1712668708.git.leonro@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To IA1PR12MB7495.namprd12.prod.outlook.com
 (2603:10b6:208:419::11)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7495:EE_|PH7PR12MB7115:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k2DK0yaeSg9oaeR2fZrK6oQBSB12Tmuun+4us904U7xg1XJpxlEhFDE6m3lqTG53oImNMGODjvYHEUcnJxEFxTCHCUKuI0FYsoZ0fVPVjtZg8hftn+Oi0PXhqIggBGl1xcYCslnczlqQ3+hxeaStpwrrWq4Y+4hypAKbm8TbNMIL6yMhiABGv3IhKOib0fgesasDAaae0EPcjYxhm+jRS6nESiwHH6MKwuewOK4beR/m7kTZ47wMHMHucOun0c4i6vaNNrQ/71gKLR9mzlEK6NO4VMtP5nlHjGllJ9mfeRRj7wvmKTEAa2E7K2Z/AMosNrslqogMNP0cWJh/ZQSmrBbNab0Z2Z3NYvFPF+/H+YGsur2iDdoDEVB1Y5eIPpTafvhEp/PpZtXXuc34Koj0aLf802U4KcgXemrSdy8bzjP5+HkotgLTK757sBHfXmYJIUjc5Yyx6hhgCXdBanQ+UIXtHq57pD86mZzFgfJdMqxU6ja9qOZq/OEjChytek33KLIGkPyM5UhDIDyr30jCtY0vPLo7Pjv8mf/IPRanCy/p0YVjjmnVH1AFPYkHzt6oS/ERR1POAB5VkKoTi+aYzdp8MC9min4PF2hPcwKXVrF7CxH12wy2uE9Xg8Uu4m/6rmFpUUJv3WlvSpaJ/7UOXXc7+UUI0CHq3OP2AkpzBGA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7495.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OC9Ra0x1Y2g1dGR3OXg0Y0EzaldTT2dsNU1LRWpubCsvdWlCWjU1NUVkanhu?=
 =?utf-8?B?Z0VJVHdTeFRmd3EwbnVJeTJlalRzNXpSUU52Z2sxVGZweHE2L0pJazQ0VkIz?=
 =?utf-8?B?NFZCd1piQloyTXZTZmZ6NDdZZFpRaWJZSnU5UXZjK0t4NVJjb1RJaEVBMytp?=
 =?utf-8?B?d3l1WjJmTXFvYTZKS2paeEppSmpmTkM5RXFTcFNxOGR1M290N0ZqSmZhNy8y?=
 =?utf-8?B?cm9yRVpjK0dVOTM2ZzdoNTRDZGlNVGVVTm5FYWgxYW9xZ1JNRms5Z2hPRE9s?=
 =?utf-8?B?dU42bTVjQUhRL2p2WXNQZkw5cjl3amhoRkFuZ3RqSXBycEhCUWFwd1ZHYmZZ?=
 =?utf-8?B?WFMxUzdhdWRoZWZJYzR1NHNuSG1EOFBZaTgrQ2NGK3l3YmI4bVpDMnU3Z2Y1?=
 =?utf-8?B?UElUNnBwVjIrM1F2YVhaOEQvV3dMd0tmeC9Ocmp4TGN2Nk9rRUd2YVN5cTg5?=
 =?utf-8?B?T01ldHFOQkdqdS9YVlZNRjhFU3llUXEvbHUwaEZHYmRnTXZ2a2FSeDJIdURP?=
 =?utf-8?B?SVJaQkI4ZEFDK3l0Z1BiRjlZb2ExbVZVeUJSWjlzYTdLVHBieGIza3M0clhN?=
 =?utf-8?B?NkgxSXpxVUVVMTlZZ21ySmo4UmVpVWd0eWVQb2JXeGJ4OGtuZXBNWHN4bFZY?=
 =?utf-8?B?YkM5dncyYkpFREZKVVoweUVTN2xNS0daKzR1K0cvdUlJWnNtc0k5WFpNWnJG?=
 =?utf-8?B?S2JxR2ZVV1F6RDFqYjNrNEFSS2o0SE8wdHRwUFA5OU1HSVFtNkl4SXMzREg3?=
 =?utf-8?B?YW1SNE9IY1AxNFNJRnRrbkJTcWptU2FWbmtmWVF1eVdUdjBHenA0bE81VXlQ?=
 =?utf-8?B?WVdwV1lHNkdZanh0WTVjZzNIelE5OU8wTzlQMnoveURaVkVZNVNPZlA3ZVdi?=
 =?utf-8?B?dXZXV29sc1FhWUJFMjRaYTJJc0U5VEw1YURzQ2pGMUJjOTRjbXJBM0tZWG9D?=
 =?utf-8?B?Mi9QaE0vL0cyYWhvWDFjL2VCc3V6cW5HZnFhTmF3UlhFOVB1ODdIb28zWXNV?=
 =?utf-8?B?SVJaMkxBNzI3c3Q3QndvR0o3VlNNSUR5YXJtNGM2Q0tSZWhkNXVBbkwvK3FI?=
 =?utf-8?B?d1YyTzAwSjR6Z1RTSU9qcHdFMmJmNTkzRFZ2YzBZSGtjdUxHRnM1VGhrSHZK?=
 =?utf-8?B?N3pQVXh5aUIweDNvMzFUS2FLN3FJdVhzUmNXa2IwUS9oWDdpQTF5bTR6SHMr?=
 =?utf-8?B?WGJyQU81eVE5WFFKVHlHbWhZd2d3QmdDR2dXQ2xsVHdvem41bGMrSWl3MFRv?=
 =?utf-8?B?REtvdklOVCtGZzFmbWdwbU1QQ3p3dXE3L1luL1ZkR05PbThrL2oyNThRNThu?=
 =?utf-8?B?UEdrWE1Tay9pVFBpNTVjTFpCTFhoSlQvWFFKMW9EdEZ0Zmhkc3M4dlorQTJ5?=
 =?utf-8?B?Ui96R3h0V004MUgyZzFxTDNNSmRtdGdJMVBvUVg5RnlmMHFseHhIT0U1LzUv?=
 =?utf-8?B?eFloNUlRaktHbE5FbnhmY2xIL21mTTBMTmJhZXVUdEpxOXpqejZiOVEwYXcw?=
 =?utf-8?B?d2hva1hnMnEvZm9hcFMvTlhhdTQySk91L1Y0TEdyK2lWK1hCaHdHQ3NlYlMr?=
 =?utf-8?B?a0VVNmpnYVNwK3JEYlpyQXRSeVZjcmFsQ1JiTitzcU5qdUc3dlo3NytIVWtP?=
 =?utf-8?B?TlplSk5FaHFQWkpnb0dCQ0pET0RKdFV5ZFRXa0tmamFyeGZubmtzTkVNR1Bh?=
 =?utf-8?B?NWZpeDlUWnJFUEhCZ1MwUWRES25qdUlOcWFoNlJ6azdYTmxraGx5bWxKcFNw?=
 =?utf-8?B?NmJVYmlHZWRwS1dHdDczZnJrclBzOTkrNWladlBSSHJ4RkVpNUZnLzR2aklX?=
 =?utf-8?B?NSs3a0RnVWxJTVBSNTN1MlJENVJBWk85UDkycXlLYVltTjJBVnl1RGwrVDlh?=
 =?utf-8?B?RmJSa1dPNmFxblFUZE5Ua2NURVNYMEd2U1BCajdDcVB1d3d5U1RKbWJtRDVG?=
 =?utf-8?B?ZFZMVFBkb1RhQ2hIK0ZsNVpTRHQ4Z2tIVkN0aTVsclk4VVRQcmZQR3dpNTQx?=
 =?utf-8?B?U3VIQlBEQW1jNjhZUUQwUTcydzRnd3hFN1F1RE0zNTg2dW5XbE5IZ3JUdUsv?=
 =?utf-8?B?MzBkRHh4eFk4MnBROHovMjBydkpUWlFBSEIzVWYwS1N1V0YvVXpDV2xXcHRT?=
 =?utf-8?Q?SynpH8rdjrM4IWW4pvJoPUY+q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8c2e8a-b7db-4ccb-8b77-08dc589c1a1f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7495.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 13:51:06.0160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmpfgZ1o+VPhsyYleVQx1GljwNoQ5yKWedy8lkMIzMGjZlTsIpA5i7EcQEPMNuxEavzjNrdVbVtvkqcwOVx+zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7115

On 4/9/2024 9:26 PM, Leon Romanovsky wrote:
> External email: Use caution opening links or attachments
> 
> 
> From: Michael Guralnik <michaelgur@nvidia.com>
> 
> The existing behavior of ib_umad, which maintains received MAD
> packets in an unbounded list, poses a risk of uncontrolled growth.
> As user-space applications extract packets from this list, the rate
> of extraction may not match the rate of incoming packets, leading
> to potential list overflow.
> 
> To address this, we introduce a limit to the size of the list. After
> considering typical scenarios, such as OpenSM processing, which can
> handle approximately 100k packets per second, and the 1-second retry
> timeout for most packets, we set the list size limit to 200k. Packets
> received beyond this limit are dropped, assuming they are likely timed
> out by the time they are handled by user-space.
> 
> Notably, packets queued on the receive list due to reasons like
> timed-out sends are preserved even when the list is full.
> 
> Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Changelog:
> v1:
>   * Changed sysfs entry to hard coded value.
>   * Rewrote the commit message.
> v0: https://lore.kernel.org/all/70029b5f256fbad6efbb98458deb9c46baa2c4b3.1712051390.git.leon@kernel.org
> ---
>   drivers/infiniband/core/user_mad.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
> index f5feca7fa9b9..40756b573017 100644
> --- a/drivers/infiniband/core/user_mad.c
> +++ b/drivers/infiniband/core/user_mad.c
> @@ -63,6 +63,8 @@ MODULE_AUTHOR("Roland Dreier");
>   MODULE_DESCRIPTION("InfiniBand userspace MAD packet access");
>   MODULE_LICENSE("Dual BSD/GPL");
> 
> +#define MAX_UMAD_RECV_LIST_SIZE 200000
> +
>   enum {
>          IB_UMAD_MAX_PORTS  = RDMA_MAX_PORTS,
>          IB_UMAD_MAX_AGENTS = 32,
> @@ -113,6 +115,7 @@ struct ib_umad_file {
>          struct mutex            mutex;
>          struct ib_umad_port    *port;
>          struct list_head        recv_list;
> +       atomic_t                recv_list_size;
>          struct list_head        send_list;
>          struct list_head        port_list;
>          spinlock_t              send_lock;
> @@ -182,7 +185,8 @@ static struct ib_mad_agent *__get_agent(struct ib_umad_file *file, int id)
> 
>   static int queue_packet(struct ib_umad_file *file,
>                          struct ib_mad_agent *agent,
> -                       struct ib_umad_packet *packet)
> +                       struct ib_umad_packet *packet,
> +                       bool is_send_mad)
>   {
>          int ret = 1;
> 
> @@ -192,7 +196,11 @@ static int queue_packet(struct ib_umad_file *file,
>               packet->mad.hdr.id < IB_UMAD_MAX_AGENTS;
>               packet->mad.hdr.id++)
>                  if (agent == __get_agent(file, packet->mad.hdr.id)) {
> +                       if (is_send_mad || atomic_read(&file->recv_list_size) >
> +                                                  MAX_UMAD_RECV_LIST_SIZE)

Should it be:

if (!is_send_mad &&
      atomic_read(&file->recv_list_size) > MAX_UMAD_RECV_LIST_SIZE))

Or maybe:

if (is_recv_mad &&
      atomic_read(&file->recv_list_size) > MAX_UMAD_RECV_LIST_SIZE))

> +                               break;
>                          list_add_tail(&packet->list, &file->recv_list);
> +                       atomic_inc(&file->recv_list_size);
>                          wake_up_interruptible(&file->recv_wait);
>                          ret = 0;
>                          break;
> @@ -224,7 +232,7 @@ static void send_handler(struct ib_mad_agent *agent,
>          if (send_wc->status == IB_WC_RESP_TIMEOUT_ERR) {
>                  packet->length = IB_MGMT_MAD_HDR;
>                  packet->mad.hdr.status = ETIMEDOUT;
> -               if (!queue_packet(file, agent, packet))
> +               if (!queue_packet(file, agent, packet, true))
>                          return;
>          }
>          kfree(packet);
> @@ -284,7 +292,7 @@ static void recv_handler(struct ib_mad_agent *agent,
>                  rdma_destroy_ah_attr(&ah_attr);
>          }
> 
> -       if (queue_packet(file, agent, packet))
> +       if (queue_packet(file, agent, packet, false))
>                  goto err2;
>          return;
> 
> @@ -409,6 +417,7 @@ static ssize_t ib_umad_read(struct file *filp, char __user *buf,
> 
>          packet = list_entry(file->recv_list.next, struct ib_umad_packet, list);
>          list_del(&packet->list);
> +       atomic_dec(&file->recv_list_size);
> 
>          mutex_unlock(&file->mutex);
> 
> @@ -421,6 +430,7 @@ static ssize_t ib_umad_read(struct file *filp, char __user *buf,
>                  /* Requeue packet */
>                  mutex_lock(&file->mutex);
>                  list_add(&packet->list, &file->recv_list);
> +               atomic_inc(&file->recv_list_size);
>                  mutex_unlock(&file->mutex);
>          } else {
>                  if (packet->recv_wc)
> --
> 2.44.0
> 
> 


