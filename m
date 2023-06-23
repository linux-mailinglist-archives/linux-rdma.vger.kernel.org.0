Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7C573BE5B
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 20:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjFWSZo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jun 2023 14:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjFWSZm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Jun 2023 14:25:42 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4D72705
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 11:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2Mwbod9n9AtLg4hDypAdP+Y/XfQsAErFdr6OBfdbDJSPVBcpD27hl9hxLm/4sGFJr/U+vNW1hqey6OJVpcSqWaUUUUqwTkl/dseIjo1E+egNrKmQmxd4Gwz0SafKWmaUy7TLbbNbW2865C5vB2nP8M7jmrfvakyT7UY+5HdgHv4tyGgjZutMvt4IaX2yrNo5Lg6oC4wYhU7kNC7jhi7HZzNTlocJoT2sUB7pEP4Uh/v/wYl8pzb/iboRMQP6Hr1nPjRXT7lZOz1mbZMdsNpiatrSHYD0AQdSrrX+rNNRUZEbT8gsETMRLti10LUcRIAgnALJT4ierrfJ07Q29cvEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVbXD7qVCHkL7bsbV1FGvN9Ou43CMdYof5s+71jij2w=;
 b=H3NTZhljMpabqmHDD83zuNW9ERAmqBfEANiNwZMqyCy/2IYhnJ5+6TCRW22CdP84DPczp6KvuHf+28EFFdhx+ZYI/911Stnf7yMJGxgxvqwz5/8i9xfNQGneS9Od/1aF5oxLKhs5CyCDosFn4DGbenyLQTyFdX5Ny/6czMW4yrZZcV0vEPZAAzdIJ9NgSJUp53mKDcrN1Qp5LJ+fKxPZvYoPRVyYKI3aLUFXxSxXstXvdI8NlHeugfzkCEueJtxn7f8upDvuk+AqW+xV1SMY3DYx09B8fkemFN4pSzn8p3I+msEGWmNIGl14ljtm/ZUAK5PfE+oJ+KUcxartdkYwTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 PH0PR01MB6118.prod.exchangelabs.com (2603:10b6:510:16::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Fri, 23 Jun 2023 18:25:37 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 18:25:37 +0000
Message-ID: <4441d9f4-9df7-4ce0-fab6-0689f15bc88f@talpey.com>
Date:   Fri, 23 Jun 2023 14:25:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/4] RDMA/siw: Fabricate a GID on tun and loopback
 devices
Content-Language: en-US
To:     Chuck Lever <cel@kernel.org>, jgg@nvidia.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        BMT@zurich.ibm.com
References: <168675101993.2279.4985978457935843722.stgit@manet.1015granger.net>
 <168675124033.2279.4244453854641171409.stgit@manet.1015granger.net>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <168675124033.2279.4244453854641171409.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:208:2d::38) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|PH0PR01MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: 000b3327-e3bf-4cea-4947-08db74173d95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lXru392yY4DUBWdshNGLHrjZMeDshlSnsBd8AAFVV2YOdyUB5HxUS4eTsK+vg7QynfEiWZJingVNPADbFsA866YQmxfGsyZLXaNo4GSQVy1gFFWqcOxKlbux0UiKhgnYa9iNqI4Iw2HUfuEKMBMl4EluYGlczn2aWFyKqRwigX17iUvUF2FobBnnga7eLeAzJM7+LxUENG8AOkeQvd9FrBEdBaJ4v57D76BVSuodrWhJsTRaKyWgOsREt36CSzvAAEUglDmP9F/FhGzJ97bJK09Uv4L+EGhwTd0B0n70M77klGi6JLJjgb7IG+UhkmqQfcMSzREnRkZsmiC5P6nfUJKY+xrPfh2Zi8aUB9IXPb05JNZsltpNsX/TTKUOALzOfHCubSaM/uQsXM4vV4PccVMR5z5OxVZXjuTLTSq2xIeROxRzWuGy+7xY4gyrSzZ9OqCqk1Kb+OXGxgTd+SlEkaHSzJ3z+KpZQVOs+icawgKeM/Ooo+ErsfOJw1XikrfJpY3d9Zf3C2Uyymg77hM55CE8yiachul96lHl0Aigj1Kn8dx7JsCWsEfKXj5c8i15w7lvvXvkIEXi5Se2sP27l8eNEAyYg+REc2QqQQp8ZK4cMORMFVwYqsb6kKq4scnmAbHh5Bh+NvoDuiUQ0odTvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(39830400003)(136003)(366004)(451199021)(31686004)(45080400002)(478600001)(66946007)(66476007)(36756003)(66556008)(316002)(53546011)(52116002)(86362001)(31696002)(6486002)(6512007)(966005)(186003)(6506007)(38100700002)(2616005)(38350700002)(83380400001)(26005)(2906002)(8936002)(41300700001)(4326008)(8676002)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjlKYzlBbjJrSVBVY1VKd3ROdmFMbFFlMy9iWVhsM0lPV0RUaS9XOCtOWVhU?=
 =?utf-8?B?RzE2V3hJRnI1d1ltVTZlZjkrcjVoWTlxUjg5amtDRHAxbUtycmhsTnNaeEhB?=
 =?utf-8?B?WXBJS3UveWp1V21pbE5UYlZneXhuRFZpanZ5VFliUmcrMXhXNnlsT1c0S0U4?=
 =?utf-8?B?UlJyTkpWMCtxdkcrWkFyNUI5cnB5MkF5OEVxYk1FN0ZYd1BlYW5Hc2M3NVBL?=
 =?utf-8?B?NlljckdPRWZNTzYraUpSbXVGTGpZaGJGK3Fxb1lVN0V4N3BPaFBZd1pLSlFm?=
 =?utf-8?B?a0gzb2RTZWw4ZzcvOTNpVG5zb25nbTFwMkFkbGVuUDFoWS96VmU1TWp0TW1B?=
 =?utf-8?B?U0lpaGdWYWVtRjVQQjNZZXJCclV3ekZtQU1VZ1k5UlhELzROSUgxUjlKSyt1?=
 =?utf-8?B?bUdSbU1qbXpObGNlNHFVVjVmUjF3elY5enNRUzkzcE5HN3dvY2ExMUFnUU5r?=
 =?utf-8?B?UjA5Mmo1d2hieU5odjFYeStZRUFULzdKeGtYczY4dVZpWTVTV2l3MEZwbWdE?=
 =?utf-8?B?QzJXaDVpN0duZjBhbnNnS3BwMlV4OENlT3BaTzZ1aUdxajh5QjlVK0xNbUtt?=
 =?utf-8?B?NWlxdlE5SkJxbjViTWkyUStQUngrdmZDNi96SHdVcUlieGRxNkU1ZGhQT1Z0?=
 =?utf-8?B?RExsVllESE1ESERIRnljZTRuTzIxQjVsVEJZbll2UGhaVnVDUWxoMm5nd1h4?=
 =?utf-8?B?bHR3Rkpvb0NRL1E1Z3duclZwZ0MzQWl4NFJNVGYzN1MydXNSZHEySUhnZTBD?=
 =?utf-8?B?Qk93VGVZTUJoWURSM3QwVVpKWUZGQlY0d2dUcXpSSm9HZk1GVmVpRVc5QmRr?=
 =?utf-8?B?VWY5emNJYk80VWlPRisrTXR0Y0swSGp1Ty9sOHpha2pzL2hJS0RtWUFtcTls?=
 =?utf-8?B?MzRhMjZhUGhQTmFmZUorajcwM1QyM2l3OEhxejcvLzllYUxGL1M0NnYrZzZu?=
 =?utf-8?B?N2d0a2toVGVLMUJ2eGZHZkZIQzFFcmdZWjYwY08vODFWNUphY3ZUeGdBb1Jp?=
 =?utf-8?B?b0ovT0ZkTGgvS2VvdG5NendkcmVQUS9ibFI0RTR4UWtzTFdYdEpNZVM3SjNz?=
 =?utf-8?B?eXRUNVk4aWdDTzY1cFlJei9ZeE1DZVNHSkpoNDlXeEtudkprWFV2bStiQm0v?=
 =?utf-8?B?cTdHYVB1VGltVFF5WVM0M1ZXRkZhVjBNODV6M3hoMWVaRWhMWW1oWGlXL24r?=
 =?utf-8?B?eHZHa09DMmtaZzJEVUN2djI5YUNCVkJIR3NMcis4bTZJWDJPRm9LR0xqaXlN?=
 =?utf-8?B?Z241VjVQam9kTjRNbHFibTJwQnYva1JXSFBjbzdwTXJkOTl3dStEck1qQ3ND?=
 =?utf-8?B?ckNhaHFnbHQ0K0UwdTZaY1k4WUczZDE2alA4a2wxVHU1S2dMYUF4b2gvL3Bk?=
 =?utf-8?B?eDhrbEcyeFVsOXIzSXlsNTFVMVdlUHlHanBKMmxEMkVDV1FOaW9Jam9zZlE1?=
 =?utf-8?B?ZGFJRXBNOFVWeFM0bXdVeTJsSnlNRUdPTzFFR2JMSEowVThKNGVhRjkzTkRV?=
 =?utf-8?B?QVVTVGpFdHFBVWw4UFVWd2FLSGZlektWZXFtTjZlY0VWS3YvQk05RzhLZVlU?=
 =?utf-8?B?bWtTcVFaM25xQkhiRGJVSlJrM0w3NXJSazYxUk42Nm5nQVRiQmVFSzdCckYz?=
 =?utf-8?B?bEl1T0drZmdCNiswR3N5WnBFbjZ3WmhNL2RsUXVVRUErK2w5VmJCeTVjYTNB?=
 =?utf-8?B?WFd3T1NEVXFPVVpNemNwUXlxY1lCdWxlUGloK0Q5eFlMNmoxNFl5YUtKQWVh?=
 =?utf-8?B?MGROemtFZWxpQ3lGM3VtMWxBVkpsS29IQW9iTHh3WW1XenZKbUhqK2dnWkla?=
 =?utf-8?B?TllIc0lpa1JmREVjWjRMTEoveWpHTHFpSVBqV0IzVFk1T0UxMjI2ZHp5WHox?=
 =?utf-8?B?T3hQYldlNnVSWTJuSWNKZFE4by9DdFR5OWtMNGQxd2FEdDE5ZDJjQ0prTmJU?=
 =?utf-8?B?S1FEU1picVV5MW5HSUFTQW5rUGNJbWg1R2xPYzM5ZzNxWG5NNnF3NmwvQWh3?=
 =?utf-8?B?ekpTWTBPY1lYejcyYVdkV1FTSVZhd1V5ODVqSjUwOTQ1ZThWYVYzWWRRczFj?=
 =?utf-8?B?VWpuU3BDVWVkZXdteUpKVitTLzVJeGVPV1IxakNQSUJsUjN5WkJFak90NU5Z?=
 =?utf-8?Q?k080iLZ8gNAKetbjALOhX3l4t?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 000b3327-e3bf-4cea-4947-08db74173d95
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 18:25:37.1953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MaEKGM3kAnhvPzUd8XjZOtvDQETnnKObA4xtM0m7Z+gb7e8iSTuAapGmLEkXS4XD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6118
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/14/2023 10:00 AM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> LOOPBACK and NONE (tunnel) devices have all-zero MAC addresses.
> Currently, siw_device_create() falls back to copying the IB device's
> name in those cases, because an all-zero MAC address breaks the RDMA
> core address resolution mechanism.
> 
> However, at the point when siw_device_create() constructs a GID, the
> ib_device::name field is uninitialized, leaving the MAC address to
> remain in an all-zero state.
> 
> Fabricate a random artificial GID for such devices, and ensure that
> artificial GID is returned for all device query operations.

Just one wording suggestion on the above:

"Fabricate a random artificial GID for such devices, and ensure that
  the same artificial GID is returned for all device query operations."

Reviewed-by: Tom Talpey <tom@talpey.com>


> Reported-by: Tom Talpey <tom@talpey.com>
> Link: https://lore.kernel.org/linux-rdma/SA0PR15MB391986C07C4D41E107E79659994FA@SA0PR15MB3919.namprd15.prod.outlook.com/T/#t
> Fixes: a2d36b02c15d ("RDMA/siw: Enable siw on tunnel devices")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   drivers/infiniband/sw/siw/siw.h       |    1 +
>   drivers/infiniband/sw/siw/siw_main.c  |   22 ++++++++--------------
>   drivers/infiniband/sw/siw/siw_verbs.c |    4 ++--
>   3 files changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
> index 2f3a9cda3850..8b4a710b82bc 100644
> --- a/drivers/infiniband/sw/siw/siw.h
> +++ b/drivers/infiniband/sw/siw/siw.h
> @@ -74,6 +74,7 @@ struct siw_device {
>   
>   	u32 vendor_part_id;
>   	int numa_node;
> +	char raw_gid[ETH_ALEN];
>   
>   	/* physical port state (only one port per device) */
>   	enum ib_port_state state;
> diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
> index 65b5cda5457b..f45600d169ae 100644
> --- a/drivers/infiniband/sw/siw/siw_main.c
> +++ b/drivers/infiniband/sw/siw/siw_main.c
> @@ -75,8 +75,7 @@ static int siw_device_register(struct siw_device *sdev, const char *name)
>   		return rv;
>   	}
>   
> -	siw_dbg(base_dev, "HWaddr=%pM\n", sdev->netdev->dev_addr);
> -
> +	siw_dbg(base_dev, "HWaddr=%pM\n", sdev->raw_gid);
>   	return 0;
>   }
>   
> @@ -313,24 +312,19 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
>   		return NULL;
>   
>   	base_dev = &sdev->base_dev;
> -
>   	sdev->netdev = netdev;
>   
> -	if (netdev->type != ARPHRD_LOOPBACK && netdev->type != ARPHRD_NONE) {
> -		addrconf_addr_eui48((unsigned char *)&base_dev->node_guid,
> -				    netdev->dev_addr);
> +	if (netdev->addr_len) {
> +		memcpy(sdev->raw_gid, netdev->dev_addr,
> +		       min_t(unsigned int, netdev->addr_len, ETH_ALEN));
>   	} else {
>   		/*
> -		 * This device does not have a HW address,
> -		 * but connection mangagement lib expects gid != 0
> +		 * This device does not have a HW address, but
> +		 * connection mangagement requires a unique gid.
>   		 */
> -		size_t len = min_t(size_t, strlen(base_dev->name), 6);
> -		char addr[6] = { };
> -
> -		memcpy(addr, base_dev->name, len);
> -		addrconf_addr_eui48((unsigned char *)&base_dev->node_guid,
> -				    addr);
> +		eth_random_addr(sdev->raw_gid);
>   	}
> +	addrconf_addr_eui48((u8 *)&base_dev->node_guid, sdev->raw_gid);
>   
>   	base_dev->uverbs_cmd_mask |= BIT_ULL(IB_USER_VERBS_CMD_POST_SEND);
>   
> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
> index 398ec13db624..32b0befd25e2 100644
> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> @@ -157,7 +157,7 @@ int siw_query_device(struct ib_device *base_dev, struct ib_device_attr *attr,
>   	attr->vendor_part_id = sdev->vendor_part_id;
>   
>   	addrconf_addr_eui48((u8 *)&attr->sys_image_guid,
> -			    sdev->netdev->dev_addr);
> +			    sdev->raw_gid);
>   
>   	return 0;
>   }
> @@ -218,7 +218,7 @@ int siw_query_gid(struct ib_device *base_dev, u32 port, int idx,
>   
>   	/* subnet_prefix == interface_id == 0; */
>   	memset(gid, 0, sizeof(*gid));
> -	memcpy(&gid->raw[0], sdev->netdev->dev_addr, 6);
> +	memcpy(gid->raw, sdev->raw_gid, ETH_ALEN);
>   
>   	return 0;
>   }
> 
> 
> 
