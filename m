Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27043400413
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Sep 2021 19:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhICRZt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Sep 2021 13:25:49 -0400
Received: from mail-bn8nam11on2132.outbound.protection.outlook.com ([40.107.236.132]:55777
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229831AbhICRZt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 3 Sep 2021 13:25:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YF7B+jbcg3xO/1eyGSO+zcIwBSuvTQ9Xd5fbqs65N7Tf5lqsQ0gBrUwqafGEZLcOQmqoO2E7PdTE4Bhr0zoh5+xdpKPLDD2lMqxkVR/4NRHZMO6EsLWKYfkDh9RjJdtyfl5qUFgpmwfaMxE5wsqnai0s0fy5B1guk28d5mFv2VuwUp/P7sqKJS8XqjuYxrublsjZoH44Ye3sV23F1ETBBUjyvzxnO1SgcCNSJ3yTvaNwKz9YqF39juQ3U9Tic7bkAIhTpihVHbi96CyXwQaCPrk0zI1FbiZiltfZPOk3DWRbmryyR105KnddIWFoJirVyLg3e5KxHMRRaXDD6UiAkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+pgjjJTRD4LMkyPkOgHy+8FEkJ/JnSZ2oc6TXUHaPSc=;
 b=QFL4OYTqnegtwRiYNnQhaXKEYkyDYhKQPxhw8IpLTppD94LMyLJ7IiDS7MkiesvYU7bddmw3YKQ/vkGEUgqxm399Zi/46C1C7rOnO/6HJY16hRUa5oHWvVMdJ1Xi5dm85nHhL0EFdpao3N9DqoX7KGX4H1tUI4bFyN/BoQG6IA0/wNfquX8KpulZ4IAHZJIwevE6ZYV6jqX1rFveN3I3FgzPiiL0lZpG9kbd5BsKjDCHCTFAFvHlmIgsZGRf327RHE85+NBLDPuid3IREgcS8mZgD8XFdkJHycH9hGC6o/x8mOGmq3baBgHo5ZJl0KpQBmFZBBL0H3DOKVPWYAlrLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pgjjJTRD4LMkyPkOgHy+8FEkJ/JnSZ2oc6TXUHaPSc=;
 b=GkJTMqq3QcvulTtAespvM7uWBYn+v9/NKbVaXl+5tEEZLNqrHx+DuBMIk4oQwSCasHU4MToZvmenhE6B7dnDfrT/pyd8fGJIgZD41gqTLx5dYEpMBVJ4z2q/gXPUDzyenK2Qy/AqqhVESKJvyIbmNy7LhzDZJTykKxyBMV1Sdxvh7KXIArekYKr34/1wXgC92nIteIf1bOVqzfe6nI5/sjG+T4bDNveZPUZ0A47oqh1MNlDLTZNnH3ZYq+9YZ4Jo58CzFJJwX1PhFUoZMYq0dJTLwdsu9zfWYp014y8B8KfmO8ILxnRnXjlv4jsg9bfEc1zDB/X1IEJQGMQUWJczlQ==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6732.prod.exchangelabs.com (2603:10b6:510:93::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.17; Fri, 3 Sep 2021 17:24:45 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::5c02:2146:2b1:f1eb]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::5c02:2146:2b1:f1eb%7]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 17:24:45 +0000
Subject: Re: [PATCH] IB/qib: Fix null pointer subtraction compiler warning
To:     Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        kernel test robot <lkp@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <0-v1-43ae3c759177+65-qib_type_jgg@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <fae8ef94-0684-bce5-ce3a-c25cfb5820df@cornelisnetworks.com>
Date:   Fri, 3 Sep 2021 13:24:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <0-v1-43ae3c759177+65-qib_type_jgg@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::12) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
Received: from Denniss-MacBook-Pro.local (24.154.216.5) by BL1P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Fri, 3 Sep 2021 17:24:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 595bbc75-6fa7-4e5a-fe30-08d96effb8f1
X-MS-TrafficTypeDiagnostic: PH0PR01MB6732:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB6732228337E98FE2031E5B8CF4CF9@PH0PR01MB6732.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:158;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rLKU0mvUQbuk7EpIumgGr1Zg+31N8Ootrr4INeBOD5Be/oKJC+IARss8fug269LA4TMu9RSAx25IZKO5uDVfajBm61fIFxy74+ZXTsG+b3ORmwRML5NBwsS6IdP/20aLeDEnr+OD7w3rSHdqF3YnN0EeGXYUlRT0gBuLluMxvXGxbq2THLkhgk6N+n4c55Ub80hPmm8cVwp7T1fxTzsao6m4tZ/5gtTlDON2ydM+gBdnFWO/OzHyminqX27eGuK1WAwZFXh9g8dmuxliIuy6cWxqtXpAtOZAYdVmsGYY6BRLOh7BoXcZSnGRwJ1bNR/jkLGONtuIe2AJucD5Qplvxd3Pkri0IEOlY0ffm9R9CZGPuR5s2pJUf2bWGqGxhWVC6lvYS5zTchddsUNAFL7/ccX4PElQNqDJCQ3OL9iDmOVrBxdPy1zXNsKfDTLeowc0dXdIsCYiD7m4pWIgUZnDiH5W5PHvBLREgWhcNi10pJNtFoOzfV8XfyaSPhkqZEGcrCrkmNNd9Qdbl2F/cEE74doARoV+HFpbHJx6HGkwMidQvbnXaV1J1WI/jCLkMveo0OEllHw8z0sZJU3ib0kMnwipn7KVtZd0ae6fmj0x+YRfLfNsyqFlaJyUYCqd/OcKkCY+FY3A5eb/EqJBjsorqde20MSyVTMpIyZXywV6pRRHdEvSSZIg+eSEJueLhj32ZqGKH6AIeWANj4zAciTsp/QC7kZSZCAQdRKXqJdZUoE/ZjhBMvbUvJDc4MGC/4AnuiJFv6lJzYL0kzc7YAIJBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(366004)(39840400004)(376002)(31686004)(36756003)(478600001)(26005)(6512007)(31696002)(6486002)(66946007)(316002)(66556008)(44832011)(66476007)(5660300002)(52116002)(956004)(2616005)(4326008)(86362001)(38350700002)(53546011)(8936002)(2906002)(6506007)(38100700002)(186003)(83380400001)(54906003)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3B0eGFWR0xqd1l4UVpkUUYwSlRLQzE2OEtIb3J1bjk2bXdBb3RMdGN5aE5r?=
 =?utf-8?B?ZGJSMFVlUHJVd3RWZmNwczArUGVhQVdhbWxpM3dyVklQUFN3TVRoN2ZqV25z?=
 =?utf-8?B?aUZTZjVXNlY3NVdac04vcXZrQ294UG45NkJyeGlHOG9CblJaczJzQzhJdWxD?=
 =?utf-8?B?bDkxK21TQlp3L05uYWhWcXlwVElpblpTLzFOMGFMVFdnc0dtNkcvVEtMQkpi?=
 =?utf-8?B?OUFpWTBGL1h0L3JoOWtadFFaRG8yUDFJT0ZYY0R5OWR1TXJraUtnTnU2bXVB?=
 =?utf-8?B?bGxaejVKcTIxMVAvMzY5ajFWRTlGajVjU09sZUlGdFI1VXYyTXVWVmlndnRm?=
 =?utf-8?B?cVVqd1FiRWJkQzY5c21ZVEY0YUhsVnhrM3Z3b0IrL05oc1Rnb1hGRE1XZE53?=
 =?utf-8?B?R0VMc2FGQzZxcHYrbzM4NDFiUmZvWm45L21teHA1V1BrM2pyWGllTE9TcCtO?=
 =?utf-8?B?L0t4OSt5Z2RZbnpsOUo4cEVjV1lsN0ZUMXJTMTNmcjY2cmd2YllWTWplQVps?=
 =?utf-8?B?cjA1T0FneUNGT1N5WUwwRjFiR21JZVh2cVJHS3VNNGtlWlZiM3VSdEUyUEtP?=
 =?utf-8?B?S3BVa0thV1NYZWZ3a1VOc2U4ajhDaWlaRHIrY1Jpc2RmQVg5OGxOcm5KSEF0?=
 =?utf-8?B?SnZVcTBqVzZPSGNaU2x6SkFsUVpDYjFlZUE1c043S1pNbTdQOHhmdVFxTFV3?=
 =?utf-8?B?NEN4RE04VnVMQlB3eG84ckJ4d3hRSkY5SS9Fa3hrV1pBS2pmUHBpUEhDeWt2?=
 =?utf-8?B?MGhibkdvSlZDOWNyQWY4NXA2UzBqRGRHY3djcktaRnZKNy9lelBOZkkzNEgv?=
 =?utf-8?B?QWk2RnRZN0RNRVZMM0pJNHFlVzVXeUZaTmlMcWFFQ3N2SmNmOVN1d3AwRDFG?=
 =?utf-8?B?bmJ1V3NadXdtOGJoK0xtMzZqSmFoR3NENjVlM3grMTYrSSsvSTl1bjdZMnI2?=
 =?utf-8?B?MTIvY0c4VEUxQ3BMdVlxWDJyaXBIQi9LWUk5UEVjRlRFYU9iZmNVeEdPUnR3?=
 =?utf-8?B?aUZ3M0JzVDF0dGtYTk45N0FuWkk4V2ZKdmZuVjFUN3FXT2JYd0hrc3BIZlhO?=
 =?utf-8?B?YnJQWVFHdUIxTzZyT3VIVVV1Z05na2hZYWRtZit3YmFYSE1MWHgyV3pCRlRP?=
 =?utf-8?B?ZzBCWnlNVnovTUFLUU1hK0ptL0tzU0I2eW5URTNZRjRFeVY3Tlc0bVZhZ005?=
 =?utf-8?B?S0g4MjVqempFSGlZUUJSVjFxazVxbDdsVTd2YVZSN2U1aVN3c1ZKK3BYZ3FY?=
 =?utf-8?B?OGw2dE9TYWNBc0M5REsyL1ZuZ2lqSVRXbkJlZ20xUXVJOHdycEdVQWJHNytF?=
 =?utf-8?B?cDluVy82Y0FGcTZqUjM4VHEwdGdaZXVWWjdMNnVIMlZkenBsWHA2YjlJd2V3?=
 =?utf-8?B?SHBRbk9nSTBybk1zNVF2MEZzTFUzeXBLL055aGhUaFBZYU96aERXWDhpcHB0?=
 =?utf-8?B?bUY1Q1BLVStBWjVhUGIwRkFzV0F5MkhpbXlXbzJaWUFRVDE2K01BT1BkSkg4?=
 =?utf-8?B?RFVxQUxJN2crbHo1MXQ2bmVqL0NjTHhGRmsybVRad3VOOUdHOUQ3ZlVPejE4?=
 =?utf-8?B?eXdvcEJhWi93VUtUcXhleWFib0VHUVlhLzduWVNhOUJWMXBLK2VFNVgxMXQw?=
 =?utf-8?B?YWJuei9SNkJiQ0h6YUg4djRWSzJKTHhlb1hzeHU2QWV6Skc5czZ5cjhkUFVW?=
 =?utf-8?B?elo0bHVESFovWXgrTEVnbUVMK2c2ZGE5MlhSdlBlcTJGY0JsUjlDb1R2OHlj?=
 =?utf-8?Q?9IhUWk3ZduZ0SzAcCRrOs5ibACr/EkKt9nXlIJl?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 595bbc75-6fa7-4e5a-fe30-08d96effb8f1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 17:24:45.0667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkF8w4HthUWc5k1Glln9pmiQ4WCczBoXkEZ4at4IA3DcgTByHjJw05omaS9QqrCyaHXUUq0rJhHjT8FCcZt7rcKVc/D/76W8+xJRXTY3FOq4kbaNE+1yr6UCFlOaBCq1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6732
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/3/21 9:07 AM, Jason Gunthorpe wrote:
>>> drivers/infiniband/hw/qib/qib_sysfs.c:411:1: warning: performing pointer subtraction with a null pointer has undefined behavior
> +[-Wnull-pointer-subtraction]
>    QIB_DIAGC_ATTR(rc_resends);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/infiniband/hw/qib/qib_sysfs.c:408:51: note: expanded from macro 'QIB_DIAGC_ATTR'
>                    .counter = &((struct qib_ibport *)0)->rvp.n_##N - (u64 *)0,    \
> 
> Use offsetof and accomplish the type check using static_assert.
> 
> Fixes: 4a7aaf88c89f ("RDMA/qib: Use attributes for the port sysfs")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/qib/qib_sysfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/qib/qib_sysfs.c b/drivers/infiniband/hw/qib/qib_sysfs.c
> index d57e49de6650be..452e2355d24eeb 100644
> --- a/drivers/infiniband/hw/qib/qib_sysfs.c
> +++ b/drivers/infiniband/hw/qib/qib_sysfs.c
> @@ -403,9 +403,11 @@ static ssize_t diagc_attr_store(struct ib_device *ibdev, u32 port_num,
>  }
>  
>  #define QIB_DIAGC_ATTR(N)                                                      \
> +	static_assert(&((struct qib_ibport *)0)->rvp.n_##N != (u64 *)NULL);    \
>  	static struct qib_diagc_attr qib_diagc_attr_##N = {                    \
>  		.attr = __ATTR(N, 0664, diagc_attr_show, diagc_attr_store),    \
> -		.counter = &((struct qib_ibport *)0)->rvp.n_##N - (u64 *)0,    \
> +		.counter =                                                     \
> +			offsetof(struct qib_ibport, rvp.n_##N) / sizeof(u64)   \
>  	}
>  
>  QIB_DIAGC_ATTR(rc_resends);
> 
> base-commit: 6a217437f9f5482a3f6f2dc5fcd27cf0f62409ac
> 

Looks fine.

Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
