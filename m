Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0C35B0882
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 17:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiIGPYz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 11:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiIGPYe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 11:24:34 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B098E01
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 08:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBk6eXi4JZmNmbXILN/DEWXeyI1PNLn1Cm7DJUJ0tFUhHfjpGeTM4RfvYv4BTRz9E3zaeP89OBuhPWW/ylNQU6MryCnjw3mJeFdsYz+BglS6T6AiLZzChzi9gOUiLZtCRmBGdMlwyGHof2iWPvoU/Kj+Rjk6qeu/LnGQUYyiUvQeXaGb1gRcYKkKaS2hw1iVe8QQ9PZTUEl8g+0+G3t9sugX7AUjf/JKfb5owXjP5Bia1+Scd4wc3mKxMrsYf32wCeHtzQc4QlhXbn0h0DqhLL0Y5K8w8eFxbXpHzBX+ofwXUOmepI+78o+iqxy0ubDqT0NVUHabc6L5ZurHkAFiSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ht+7yCSpEup2MUed2M/sSo0Owvw1UyWnWIwiOdY5yCM=;
 b=hbYOJt5izBGLOthbSM8WONkZe1USsOTX5x35UqhhuhSXz/gPci779JXukMh8ndv2u7BvS7Ly5AjgtcPwo3jteLWxhjLBAoh9hJlbbiJy2BS/5h5UHZ1ShU779rA91ou59seO1d7T+IyAmON2CY923l2Wb6vx2GyEw50/pxkVhGT0QsIkYSFO3FW9j9yGkrPODWVKUCWz0I9HjXhD80+HyPPrKKYqWqO7+8O6XXFs2OnAk1UQQi12NkixGIgOVPT7y58zs3nmiuFh/gqWzP5gjLninJF4aqZWlFk3VGz2OaHmz9WjkW/6MOV8gBga2cn+4o2qwf+P2pr9en87Kc3QEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 MWHPR01MB2463.prod.exchangelabs.com (2603:10b6:300:3d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.17; Wed, 7 Sep 2022 15:24:20 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::701d:e406:dcfa:118b]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::701d:e406:dcfa:118b%4]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 15:24:19 +0000
Message-ID: <3a9fed9c-2ac5-dd78-a63c-5d9dd61d3c7a@talpey.com>
Date:   Wed, 7 Sep 2022 11:24:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] Add missing ib_uverbs dependency from SoftiWARP
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <4e7574d7-960f-9f92-e92f-630287f1903f@talpey.com>
 <Yxih3M3rym7Abt0P@nvidia.com>
 <0b035368-5da3-73c6-4d6f-1e22bcc70ecb@talpey.com>
 <YxilUf2HbA6PAo59@nvidia.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <YxilUf2HbA6PAo59@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0053.namprd02.prod.outlook.com
 (2603:10b6:207:3d::30) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32b9ec6c-bbe5-4e90-483c-08da90e508e4
X-MS-TrafficTypeDiagnostic: MWHPR01MB2463:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qgdkquI2gYtVrSueIK72UF5bzWE03vqA01tcKezGmAed86LzXe5YEliDl+3FYid5GokCxBlWCl2GI8VtXl8vgqPiBDWMZBK7bWPZE/yEUxs1s1aSk3Tq3FSbfIN2QrOz5T3d/ipW9Aacw20ADhsJcd6oqv3zSZMuzRyi5NirOnG+8JB25p4XhXMMi0j5NJJtnLpgjt9jYyUsg1xwGhBOjO4hro/fuakshg5TtIzNun0u5XmgjPpycz6fE5qEg2dMVOcmMgqU5PiFB23uQDernBZCu6ZaRQto/bbLCWfPoXPWBUdxfP8JS2vCHpV8onnF7vGr6fvG0rFXeQpvK1wY3dHQ7x6Z2edkW0BD5TlXIh0yjVyDUV95tRbx0lBg1SgU5pZBP35UuLp/TCsUAiEgb7NcRK5yof9pkI4IsXUvmXWNz3ZEiMMPkDHyKJttHm6ZUt6ONZSjVi7yglRa9qdVAQR4+Ti7ZoXNr3KrMp7+hTXZ6YsojdcBYTVTQ3skagaWo0MlJsjV3iIK3ME7fNyYIS1Tjpc8kVkckCax7MSq5oM+n+G14mS/927TWh7t1QNzPPM5BV+ofPYLh3/Isn6I88q+/UgdeWGklzacqONUCJMlfVlvmB8+evbKXA9VziHxDUlqPkuJz+HOzLH9k8+nNtJie9h6Zck1HtmHwLVOUpSv6yYmJCEr1RAe03ruTEMApqQCg/c+x9cHO4jTOAIHM61v/Y32xwjWynaX2mhrCCyPKKKBI7cnaX8Kfjh+gpZ3je2+nqvKNK+y12HcXeW55Za43pP/ZguPh0HyKolaCjU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(346002)(39830400003)(366004)(136003)(31686004)(6486002)(2906002)(31696002)(36756003)(8936002)(8676002)(86362001)(5660300002)(41300700001)(66946007)(66556008)(4326008)(6916009)(316002)(54906003)(38350700002)(38100700002)(186003)(66476007)(478600001)(26005)(2616005)(52116002)(6512007)(53546011)(6506007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzVmOEF5a3RNV2poOGcrVlRrMGZHUVNWTThnaURDRE9GUG1vY2FpWXRsMmVH?=
 =?utf-8?B?Nk8vZEJaK0ZkVE9zWnBoRjIzQWo1Sk9qL1ZxR0ZXaHFKY2VrQ2JrOGNjVjFz?=
 =?utf-8?B?eGhxejhMc0ZMaVR2MkU2NFJyT3Z5aEYySXM1Tk1IeEZTRVVxQnU4c2FleUFh?=
 =?utf-8?B?dGhyNzEyRS9WZCtScE50N09ZSFpVcHRHT0VkTSs3S2NQaDVBYjNqY3FjV3FT?=
 =?utf-8?B?NnE2SU1EYkdLSWNYMHJ3alE4SVcxQjFyeE9ONGVLcHJ0NTdKa1dyUHhab0lh?=
 =?utf-8?B?c2QyS0Fxa0p1WHB3UkdKV0N4WlZCQW92aGNiMExMOVZpK0dYMEI2cjFMUWlh?=
 =?utf-8?B?RU9zWDF6ZlJtTUJ0eXZab2JkajBXYWlJL1JXSWVjTlNmODZZYWE1WFF5dG1L?=
 =?utf-8?B?UkFDcGZ2RG9FdEp4MjllTFFURE1ubkZVTVRGRjhUWEJ3djRjejhEelZ1SjB1?=
 =?utf-8?B?aVZaQ3c4dHFMQmoyd2FMRUIyZWRjOFlWZFh5dUx0ZitYRXBjZlliV3V0VDY3?=
 =?utf-8?B?bTYxV1N6SVNEVFo1K0owa3krUTk2NmtNYzVyQy90RGtDSUxURkNwdlF1Z2VR?=
 =?utf-8?B?bklQYy8vcTNUVU1hUnRwNVJZNEVTajFwelFzSmxKSUI3elYybUdpT0VwTUIy?=
 =?utf-8?B?ZXAvQzE3cnhvWTRrOVExT2R1Umk2SlQ0SmJBa0IySDlWNEJnTmN5eUQ2Zi83?=
 =?utf-8?B?Z3Q3WVNyMXg4bVBVYlhBSWtYOXRqYTc2VWFvcFJQazJPd0VKcEsvbEdJQm96?=
 =?utf-8?B?c1A1NlJXRlVwMnM1UUdBTjVESk9tZ1YraVFVeFk3dDRSY3RrUEw2NXlHRTdC?=
 =?utf-8?B?UnViWXpBM0ZiR3Q2QXBQUFd2dUV3c1h4TUhQZ0dpcmNSR0JOQ0IrUTQ4QnRK?=
 =?utf-8?B?dDRPaUVxTElTa05pUmcxMGRoazV2VSs4U3ZvWnQ1MkJncU0zZUdXTzJPeWVK?=
 =?utf-8?B?bWk5QW9UQXZxQjBjMlVQU3VvWUFHYTh3K3NpaEtYN0t5Mk1DQ2lPZG0rL1pn?=
 =?utf-8?B?cnZlb1VnWFRGOVZhTm1sdE9UOXYrcjQ5b0Y4UkxMN1VRNEhiMVlZdUxaMmhq?=
 =?utf-8?B?RHczUlV3d1FpSndUaytNMHdzVXF6d1UzUTB3aFVrS3lVNTRaSnNrWDY5TVMv?=
 =?utf-8?B?VDZWRXYvbnZTU2RJaGdZYlFrUnpJMG1oYmxqU2ZTdDNPOXB0WjhwYU92UjU5?=
 =?utf-8?B?VHEyTkcrZmE4ckVmdWZNaWo0dnY1TGdvd2hUbVAwcUZMemFzSnlOZENEVDhV?=
 =?utf-8?B?N0I0bDdvdUQ4RVFCSTlOYjVSZVhPcmljT1ZYOG1yNEI4Yk9tWnhEVjh3c1kv?=
 =?utf-8?B?MUwzWnd3VUZzM2d0ZHUycWJ5THlxNjNnSHVHaW4zYTNhNHNMNnI4RGx3T2RH?=
 =?utf-8?B?OEZBSmVKbnRwdm5qSTRZM3U0ejVoZ25hVlQ0cGxiblNuTzNVZGxhNnJ3RCtq?=
 =?utf-8?B?dW1CMmhHd2wxeDVPVkxPc001MjZQMDEraTZHRlJjYzc3VnVtVlRaeC8vU1VK?=
 =?utf-8?B?VDBRVzdKK1A0YzN5NkJSNzRtZ0JMcDAxNURQVWpEN0cxbGNMdVRiWHN2Y0xX?=
 =?utf-8?B?clVVNUlOcDgyNmQ1ZkEvS3ZIeTY4cm1JdjVOTmtzTEVHeVE3L0o0STV3d2Y1?=
 =?utf-8?B?QjdFY2FVZE1WT29qbnZVc3orTEI0SE9hOGlSZ1NJYWp1WVJkaENCb0l0R1hu?=
 =?utf-8?B?QmVjN21CZkRKZHE3V09uV2NZdlI4eHR0c1c5QnllZitzclA0dk93VVc5TXNK?=
 =?utf-8?B?YW1LNWlrWmpFNTU2ME9yK0tNd3o0bHI4aHNTL1ZQZXlyS3F0aGdjV2NCR1g1?=
 =?utf-8?B?Ty9OT3pUV1B4b3BWY1V1emNJaWhBcGlZdmlReENQQ3JxYWxva2RyTWhKMVBT?=
 =?utf-8?B?SDlucTIzZklBVW0waGdLbWIwQUFQVlE5d1E4eTRTNUJRYk0vUkNUKzdjYy8y?=
 =?utf-8?B?SjdJRW9BVldSeXVrTnN1RXcxRjdob2w0NEU1aTJmMG5CblhJeE9zNHdNUXJM?=
 =?utf-8?B?amY1bEJPRTAxYU1GSnlUVUx2azRNYitwUzBrMHcrWnJMNzk3eDM1VnJBNTBP?=
 =?utf-8?B?ZkoyYWlDSWR6bVNOQ3BWYUdkVWVpWURGamtNYjhBb1dXMnlleEl2KzN1bGZC?=
 =?utf-8?Q?7WUrQYvAWOYT0oNHexRt66uPE?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b9ec6c-bbe5-4e90-483c-08da90e508e4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 15:24:19.8841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yd6RNCW5mnmh4d0W4Iv5cxY1SZnrf4wjaHnWEX4a501f9qb/ExRbtHv3Vpj2E/Zf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB2463
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 9/7/2022 10:06 AM, Jason Gunthorpe wrote:
> On Wed, Sep 07, 2022 at 09:57:43AM -0400, Tom Talpey wrote:
> 
>> You can test it easily, just load siw on a laptop without any
>> other RDMA provider. The ib_uverbs module will not be loaded,
>> and the siw provider won't be seen, rping -s will run but peers
>> cannot connect for example.
> 
> Perhaps there is something funky with rping, it works fine in simpler cases:
> 
> $ rdma link show
> link siw0/1 state ACTIVE physical_state LINK_UP netdev enp0s31f6
> $ sudo rmmod ib_uverbs
> $ build/bin/ibv_devinfo
> hca_id:	siw0
> 	transport:			iWARP (1)
> 	fw_ver:				0.0.0
> 	node_guid:			7686:e2ff:fe28:63fc
> 	sys_image_guid:			7486:e228:63fc:0000
> 	vendor_id:			0x626d74
> 	vendor_part_id:			1
> 	hw_ver:				0x0
> 	phys_port_cnt:			1
> 		port:	1
> 			state:			PORT_ACTIVE (4)
> 			max_mtu:		1024 (3)
> 			active_mtu:		1024 (3)
> 			sm_lid:			0
> 			port_lid:		0
> 			port_lmc:		0x00
> 			link_layer:		Ethernet
> $ lsmod | grep -i uverb
> ib_uverbs             163840  0
> ib_core               393216  2 ib_uverbs,siw


That's odd - your ib_uverbs "Used by" list is empty. Did some
module dependency cache force-load it? On my system, it doesn't
load at all. With the proposed siw softdep, it does.

Tom.

> 
> Jason
> 
> 
