Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5FB52A03C
	for <lists+linux-rdma@lfdr.de>; Tue, 17 May 2022 13:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242389AbiEQLRu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 May 2022 07:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345616AbiEQLQy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 May 2022 07:16:54 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA92713D34
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 04:16:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAkJG2JfFaYpwnKmXjJ+c0CSpV80ku/EpcCgdOr80JQlt+r19mVpWB8AmXm8hyjGxnunzmzENTDIrXJ0+fp8MOC3cvvPNIJDwcvVXx3t7t17jOeccHByxZup0KwQrKa7ccDDiq8Hj2qd6wdOGFPj22FSiWepZTp9j2Xr1U3TEOdje33arJsVeidiHzAtZEgDn2RBJbY3JO6T8mO4o8Mh8mUEoMxvKtjyT6tchgZLfDHG6ORe6kW2YWXLpRJymyF14vmyW4Yd5Osqp3lJ338GUAo1i63x/NecJNz3ffwHXBHJc2KZNiJ3HOOtb/gwtj4y7n6cRnZ6WhjhCxgAyyqnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtO1PxXvwu6e341/QuIIy6C+ZgImvMwf5LBqoP7AGTw=;
 b=CK4/GVeVgwkJJopG+lUe7vhKu6IyyMhcuDAR6wVxZviUxfgSL1zaLptv+l6EXWZPrukJWO9swRdPT78Bp5EKMVK7zfmlcEL1xo6+2+TM6+73frKYoUyl0N/Ipse2Yn0bIa5x9MhYQ3iyQrsCFJQrA96fcFxzOJ7/EnLHj17wGwIQJOg7AhfhSUBR5jGgh23SVrs/Q9+0P8P0ky0nMFOxOZM+ddGCndlt1XNZcXYu1gvNCOytJvy2Ww3ykmxDDd8d145jOsW5lkd4PBlD2nNUNoVS1xLxYNVvEc+4YuW+qwDwTf369QA9UJSHQ5OMv3qwBVq4ZpL3wun6FklLEA9P9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtO1PxXvwu6e341/QuIIy6C+ZgImvMwf5LBqoP7AGTw=;
 b=Rcdt2GtCAN38amVW02hIdwR2YGoMBQ/sIcv/8rhmhFVoCTheXQgJs1RNPcxvshScZbPmpxSUF2lFDjMOtEqRV5ST3YlwYZbrM+734aHcZFJH4DNPZVm2KE1wwLvKf11W3EaEHeNuy7zJJqId5gxuJ+zbFg/IUmNcYnUuWj96FyIZFV4gOfp+8Bgy8ACiijxB/RdnsIKo+wMi7Ic6lcrOPQhbIuI4EXyY2yiTafu2Jwe+gAoRp+PC6+rZswk7GdVq52cjXosRMBel24nktSgsfs5G6mzYnChvbQXjYE6A19N8HagC7jkCz27xK8fXjtCmfJWIzY1AlgXTjh1pI3chLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CO6PR12MB5425.namprd12.prod.outlook.com (2603:10b6:303:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 11:16:43 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::b3:bdef:2db6:d64e]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::b3:bdef:2db6:d64e%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 11:16:43 +0000
Message-ID: <920e58ac-6a57-fdb1-a2c7-b6fef388917e@nvidia.com>
Date:   Tue, 17 May 2022 14:16:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Error when running fio against nvme-of rdma target (mlx5 driver)
Content-Language: en-US
To:     Mark Ruijter <mruijter@primelogic.nl>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Kelly Ursenbach <Kelly.Ursenbach@eideticom.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Lee, Jason" <jasonlee@lanl.gov>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Logan Gunthorpe <Logan.Gunthorpe@eideticom.com>
References: <MW3PR19MB42505C41C2BA3F425A5CB606E42D9@MW3PR19MB4250.namprd19.prod.outlook.com>
 <62fd851d-564e-e2f3-1a40-b594810d9f01@nvidia.com>
 <MW3PR19MB4250DFC4E2AEB8184299A4BBE42F9@MW3PR19MB4250.namprd19.prod.outlook.com>
 <a0d3b1f7-986f-591d-2675-8ee753d2e7db@arm.com>
 <3F2D3249-79E4-4CE1-940F-E1E0719EFAF0@primelogic.nl>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <3F2D3249-79E4-4CE1-940F-E1E0719EFAF0@primelogic.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0517.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::20) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26125b37-c92c-499f-d60e-08da37f6b913
X-MS-TrafficTypeDiagnostic: CO6PR12MB5425:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB54257300E4B6E17BE590B0D4DECE9@CO6PR12MB5425.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rEdenpqKuAYNe5Mbwke0w/hrIlIJJN8MKy/n+N+AQ0TYulRY2eINGqztNfYIAW0uVCqvxNwyzBumUMQs4cF21aRf/W7ZJvWTjTOIhIfQfXw+2DnSh7p3tixXex4gdg8B4O2CI0ACXTRvjTOHYty5qTD5nI36Gvmok+SJNGd5SIaIQoBckQs/qx02EMkOxTBjFVz3gS+Ei/+CB4ATIh1nDnWH/BBjA4mmSAoI6rK+nbDdWbXNUkGuI+lLpqN/oIq68anBRrNOoYXzHmCajPNOrb5hON0sKGXd51poJvm039TRGAzn0GCTjYYU8Ne/YT1MhYeYLTitsh16ubnsgBM6Cgh/OHT75JtTqUicX/j8bbuULcaQvGQ15mzi/EI+FPicrxCaTWCltne6kNZpQxD+K+Z99PHyX2y1ladpCwYAjGnl17PeCvlz1AukzLguc7m/R/Xzp8oJqsS0YJZvMgXzdQ1INi8argr9yAfZ+DdsvOu8ShJcklji40WCCuhpYej2ruN09xKCKHi8kCB60GYzdlzzOFeDEMCACKAmVJZBLoNcV5DRPlUoI+lG068r4IgL5M25/qmBgDAtzNooSGywuJ6jT0PJ7GAljil1lAE9PXVg9kHMImM46ZwfCFI1FKfHRddsle6Lwx/Sf98H0nWn5HiMK93HMEDQFg+tfXceKKeqEvlUlXCn4P1aEFyiC3SzVmb8kNbNbgApPD3dZUvijVOFcFMgKiwPHSPXekJvGh3TaPGk+wvl2lCg5VYgr/ZDWVVPjb+4lmpKwKG9Jcu8WA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(2906002)(186003)(2616005)(508600001)(5660300002)(31686004)(8936002)(36756003)(8676002)(83380400001)(6666004)(316002)(110136005)(26005)(6506007)(86362001)(54906003)(31696002)(4326008)(6512007)(66946007)(38100700002)(6636002)(53546011)(66556008)(66476007)(45980500001)(43740500002)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0NqMXhwSVZpYkVqVURBT1puZnh0Z2xtN1BKZ25FSStxQ3dwQUJjRWdMNUYr?=
 =?utf-8?B?VERESFVOejJxdTRGQnM0dTBVNW4rNXVMRThHaU5TaGEyd0VIdmRBREkya2Fx?=
 =?utf-8?B?NUF1RlBJb1dIbTl5cE13WTUyakxXWUVaN1dLNmNwQXFEZTkzcjRtUnRaWGJw?=
 =?utf-8?B?QlJoRU92aWxLU2FHQnZqOEVwSVU5VU9kVUhKbHlYTTRYWlBmMGwwU29jWkoy?=
 =?utf-8?B?UDVxdEc1dUwxc2lzUmllNmZpN0VaSmZwYmUyZDl6dWF2SSsrY1llRDBGcXhR?=
 =?utf-8?B?K1RzSGszQ250UTRmR1BPN1ZyNWZpb3p1Z3RWWU1ueXVGNzlUUXdQWk9LNkVO?=
 =?utf-8?B?UW5FY2dKVUp3OU1uSUlpeEFydjV5VXJKL2xEYjBkL3dlbkU2Um40ZDhvSzNO?=
 =?utf-8?B?WmI3b3p3TmI1RDRBWEZOWjhzN3VsZnVKTCtYZXd0SkJXZXNaeGtHWmNYRVpr?=
 =?utf-8?B?SWRmd0J2U0d1eUlkaUlxbTBjTVZKaVQxeDgvQTlITnU1UzMxTTViczF6Vm82?=
 =?utf-8?B?eHVsS3lJZjZlYU04eFlSTWl6bkN6cTFiQ3Jvc2ZIaUtBdnBuNUNkTUNxQmpB?=
 =?utf-8?B?RCtrc2xLZnd0alFFR3hzWFR4UStJWXRtNmFGWCtwVi9SQ0RWK0xhWElIQWVN?=
 =?utf-8?B?T1o4UXVvUldXRUlhUjRkbzNIakJpREhPWmNDbjlrVW9ERUhWRXdTcEROVUor?=
 =?utf-8?B?TDVrQmZhcnB0OXZ4YWNPV1lidlJLSE56OG11d0pOMEtZTjF1dW03TWVhWERl?=
 =?utf-8?B?WU5HblBPWUkrZGdIeGhuMDdZc3h1TEs3bWhRbkMxbE5SOXM3YUJjZUVBME5B?=
 =?utf-8?B?MHlIanNqamlpNXF0eWZQcFpCWW5oN2lBdEUydUVEVS9RaXpVN293ZG9hdnB3?=
 =?utf-8?B?SWxXTDF5eHpFeWZ6akMyNS9kUjNGQ29CcUVSZzNCdzA2cXNNWmo2UVRRWDVl?=
 =?utf-8?B?WjRBV2o5YU1HdXB3TE9CZDhQWFl1OE4wL1d1L082R08rb01oUkFpV3k4RFF3?=
 =?utf-8?B?OVR4aHhySEkrdWhUTFFKU1JtUGR2MTR5bTVSaG9EOW52NGNDcFozSUNjUm9z?=
 =?utf-8?B?cytsSDhEVStGV0w1ZExxandxMWZ0UTRNK3prZVZqOVZFNUQxUjQzZ3VUUExs?=
 =?utf-8?B?ZHk0QnRqMmwvR1hGRUIrMlRGNDhmTUUvVTFNNW9QWG1mam9zU0FOSFNPMGhW?=
 =?utf-8?B?Q2FqWHFaL2FtOFgyNFVST0FHZ0tzNkRWbGJ4YUtjS2ErT1FQcGJaVmtvQ0xr?=
 =?utf-8?B?bWJMTE42UVhIVDNwZWZPemR1cHFEM2hycVk1elV3czJaai9TNkxRTVBsMlQ2?=
 =?utf-8?B?d2UyTEVXUzl6MURmTmJMWXRrUzBrcWRlc3NVcWdqUXgramRvMDV0b2NzWml0?=
 =?utf-8?B?YTUwQi9iU0NCT1NYOUIvaGZsQUNveTU5UWRYUjN6VjdweHV0blE0QlZwZ01x?=
 =?utf-8?B?bVdmL2pIRkwvTUsvZlNoaE1QWmluaCtEdGdweGM2bTZKTTBCaklvcUczeTUx?=
 =?utf-8?B?K2MvSys1dk9KUHZsSHJtNXhTdUw2S3l0LzA4R0RENnlWdjZNNGc5OFVucXcr?=
 =?utf-8?B?N0txdU8wNEtEUndQUCt0YUlqV1IvckMyTVNvcmQ0WCtleWRYMWJWZG9oZ3oz?=
 =?utf-8?B?UzBiYm1SalFod2JERHR1L2FTNC8rMDRCdVlwUFlBaU9mU0M3Nit0eDcxZmQ1?=
 =?utf-8?B?d1JMWXFHRjNVVUFjdWwvTk4yTC91Z3krZldkMjFONDE0MHVHQVN0Q0xHU1Rp?=
 =?utf-8?B?TmdpR0hhNFEzWkM0cVN4ZHdSays0RHVQY0thTzYvZ0ROS0tuajU2LzdaU3RU?=
 =?utf-8?B?bFZLUktQQTZsR2YralNoblBlLzBpZ3hnWFNFSkVlK3ZQRUErRHFDeTkyOHlr?=
 =?utf-8?B?U0I3VFpZNk91U2p4dlRUbE9SZUM4QzNIc2t1SXFmYzFZakVZYVAyNXVuK0E0?=
 =?utf-8?B?TmFCVFFhSjUzWHZXZkJGTStXYURpSGgzTXI5SjQ1RjEwYkhEU3pqVFAvS0JO?=
 =?utf-8?B?TnNoeWpGTVY4Yy9oeE02aENkOEoweTh5S1pyVjZHUTJTbzRGNDJIa1hnZ05Z?=
 =?utf-8?B?QjVncm0xY1JPNEJ4U3d5QlNXTGdLaUIvaHNpRENCZUNMMkdLSzdnM05DWU5O?=
 =?utf-8?B?dUczSUpNblFRbUcrWmQ3UzRMcU12ZUZiOFlrTkE3ZTgrVVN3aXc2MkoyUjFE?=
 =?utf-8?B?MmtIME1nR2JvRkZQOFVyMm9xaHVKTW16cmxROUw2cFhBSG1RR2pUeUR2U3E0?=
 =?utf-8?B?ajRaMStvVk9SbVZwVW91ZHFIYUJGcjJ0eGZja3psM3RFU0xPd2JVZkdPQW8x?=
 =?utf-8?B?dFBvUFI5ZXNSWHlrM3V2R255UVNNOTE1YWlxRXRNYVB1MXBtY3djWGlHS2F0?=
 =?utf-8?Q?aeyAO41ZLlLATr68=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26125b37-c92c-499f-d60e-08da37f6b913
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 11:16:43.4319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3M2dL2q/CqW7DXyYR9C4EPfLm9puBnL2QHaRvfiBoGLJFLQs9bXuD2dkJ5VNpDbT6CIbNLi7Cg11FSF2A7lCbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5425
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

Can you please send the original scenario, setup details and dumps ?

I can't find it in my mailbox.

you can send it directly to me to avoid spam.

-Max.

On 5/17/2022 11:26 AM, Mark Ruijter wrote:
> Hi Robin,
>
> I ran into the exact same problem while testing with 4 connect-x6 cards, kernel 5.18-rc6.
>
> [ 4878.273016] nvme nvme0: Successfully reconnected (3 attempts)
> [ 4879.122015] nvme nvme0: starting error recovery
> [ 4879.122028] infiniband mlx5_4: mlx5_handle_error_cqe:332:(pid 0): WC error: 4, Message: local protection error
> [ 4879.122035] infiniband mlx5_4: dump_cqe:272:(pid 0): dump error cqe
> [ 4879.122037] 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [ 4879.122039] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [ 4879.122040] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [ 4879.122040] 00000030: 00 00 00 00 a9 00 56 04 00 00 00 ed 0d da ff e2
> [ 4881.085547] nvme nvme3: Reconnecting in 10 seconds...
>
> I assume this means that the problem has still not been resolved?
> If so, I'll try to diagnose the problem.
>
> Thanks,
>
> --Mark
>
> ﻿On 11/02/2022, 12:35, "Linux-nvme on behalf of Robin Murphy" <linux-nvme-bounces@lists.infradead.org on behalf of robin.murphy@arm.com> wrote:
>
>      On 2022-02-10 23:58, Martin Oliveira wrote:
>      > On 2/9/22 1:41 AM, Chaitanya Kulkarni wrote:
>      >> On 2/8/22 6:50 PM, Martin Oliveira wrote:
>      >>> Hello,
>      >>>
>      >>> We have been hitting an error when running IO over our nvme-of setup, using the mlx5 driver and we are wondering if anyone has seen anything similar/has any suggestions.
>      >>>
>      >>> Both initiator and target are AMD EPYC 7502 machines connected over RDMA using a Mellanox MT28908. Target has 12 NVMe SSDs which are exposed as a single NVMe fabrics device, one physical SSD per namespace.
>      >>>
>      >>
>      >> Thanks for reporting this, if you can bisect the problem on your setup
>      >> it will help others to help you better.
>      >>
>      >> -ck
>      >
>      > Hi Chaitanya,
>      >
>      > I went back to a kernel as old as 4.15 and the problem was still there, so I don't know of a good commit to start from.
>      >
>      > I also learned that I can reproduce this with as little as 3 cards and I updated the firmware on the Mellanox cards to the latest version.
>      >
>      > I'd be happy to try any tests if someone has any suggestions.
>
>      The IOMMU is probably your friend here - one thing that might be worth
>      trying is capturing the iommu:map and iommu:unmap tracepoints to see if
>      the address reported in subsequent IOMMU faults was previously mapped as
>      a valid DMA address (be warned that there will likely be a *lot* of
>      trace generated). With 5.13 or newer, booting with "iommu.forcedac=1"
>      should also make it easier to tell real DMA IOVAs from rogue physical
>      addresses or other nonsense, as real DMA addresses should then look more
>      like 0xffff24d08000.
>
>      That could at least help narrow down whether it's some kind of
>      use-after-free race or a completely bogus address creeping in somehow.
>
>      Robin.
>
>
