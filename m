Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6FE599181
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Aug 2022 01:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245581AbiHRXwd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Aug 2022 19:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiHRXwc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Aug 2022 19:52:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B27D2772
        for <linux-rdma@vger.kernel.org>; Thu, 18 Aug 2022 16:52:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAVPu4KYHsPaplRCzhco3580JwsCfk5caHuLDoLt9QjypXXAn1/QY8jd0q3+fkjlcjuAmblyaRKCLGvd3hCUvKg4DZp5vGGfJq2Y8OS3IgmH3Et0lVxYMYy0O5MJv9Ck8GDM43q3+sx/S6DHFay0dzZCR3MTqVIjwUZE7lGBWk8tKvJ1WIc6w80pjsWsyaF1SHbEEp1NMVJoKQhB6x+gZo0fP1tpmY3TgD4M6vM57ON0PvV+AehHr/8esSijI5fGWMndlSa6GkzHFY4n/1Ss0k5juxYXlOuXH5/aORtTemtk3wJckXTFTpYDDd6fCt9RgufwG6cQgCKgEOLFG62C7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=copHK53c9n5BJCius2MIDv63bHGNu+YWcodowARmfF4=;
 b=MaznxzTehOXiHZQjHSRwdrf5xKgJRJX5ES3Ba7CYTJhoNwTxpnPCqKjQ9dn+Egz1l9NXJpSrfcqrm+JVRAPYPEB3CGkwRK5xIPtVjUEGaNPhE4ggLCsIkHSjawMHSdI42t2Nt4HUkWHn4cfYnLQ+a9uvvh+przFsyxqS1BK1EK+hVWWpN+D67pF93+oR3pVWchRH6S9wkZ15MtDonja1MSszs6X7vzMHydZ1niENpoaoYaWGZpcnD4WI+yIK/bkuHqZ6gLzNUqd6D56qDKb8PlSX73SUBuooIfL+bWosWMnP1y+7vmKYblDWpx7Pqk2w4DZzlDy2uKLr/Pxuumizkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=copHK53c9n5BJCius2MIDv63bHGNu+YWcodowARmfF4=;
 b=kfJkythiGefGYyNGr9i/6GnKGxr5cLYYGx6LU0V3Odq7Hp72Ov4zks1mNZKaQLn9hTKgbC6RkLnCpjJKK9ypLQ0C1XVBCPbt5RzHCBlsBFgsbVDnaBNYYUuKoWYYtocorQpe8Yg+zUnHOsoPgShumDJJzFz7rcMErUgYriCvvxDgQHnQncknZ4a/wqeE+D458V4dody9vzKVoPkMo6iEFvQXxAWnUNoXeh74g0ypn0KDpY6GzZEerojkGTmV+GmZi5oyv4P2u7MUXJVGvbygtcfRQBJ5gq+lCQBzZa72XmUEukfKBpJQBADYPwO3hfhst+FBOBdLzH9AUNy1QXreMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL0PR12MB2337.namprd12.prod.outlook.com (2603:10b6:207:45::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Thu, 18 Aug
 2022 23:52:29 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%6]) with mapi id 15.20.5525.019; Thu, 18 Aug 2022
 23:52:29 +0000
Date:   Thu, 18 Aug 2022 20:52:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, leonro@nvidia.com,
        selvin.xavier@broadcom.com, andrew.gospodarek@broadcom.com
Subject: Re: [PATCH  rdma-rc v1] RDMA/core: fix sg_to_page mapping for
 boundary condition
Message-ID: <Yv7QvMADD7g3yPWh@nvidia.com>
References: <20220816081153.1580612-1-kashyap.desai@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220816081153.1580612-1-kashyap.desai@broadcom.com>
X-ClientProxiedBy: BL0PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:207:3c::27) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3599aa27-8b27-445f-019f-08da8174b5ef
X-MS-TrafficTypeDiagnostic: BL0PR12MB2337:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wc2Eq2MXf/mefqiAOElSM2CqQn4q8s5Cu+fh5uMZdpxpRvZ5JjldRXPT35rgru8518lD5+BJ/xo/vDbeDYfqd0xTJUaj1DvcdeC3cedmMt+cN7SxKRunwI/djnssk3UQwqMemHgldgQBVRU1sRlT3pKJm8SY8rnt7wuOUPSqd513HRTrpO4+XFuJRa4m7pzTNU5sEtetmHSljg5V8+IO4i/18VyaffWenoc8wxCk0esLQotMc6YcbDgmqbFs8SAyYre343dryWdde2LoBNvtGOjOcWni6KNGaHn8TaR+ln9xedSeWYvnOFBf7dqjgSraVJD7KC0fw75R9jayGa+5Dq4G5J08nlFMr45DSplaiUau0qAiRd1rTMQMB2A/NguV0BjkqSoaZ9C63dnFJjkl3Vp9Ct3hu8ZA1DDx8x9Ly3LNe9CMzy9+cAzR6ECgLu99ADX2IaU7uFQbCk3zlToEPsUKzK1fN+ULeW34/914lo+5lA6644zWOVqnqs/uC6gjPS1pWDIMVHu4DEScLICr6n7oscrZvU0ZwrgIyai+/hXwJT/j5VCCAuljY+065s1o22c14HLnxuN945ABwNgoTtyvd9ZzTOpTYmoz5D7BRlg3rn0/0YnBNNE/i074r7gs8wF+ct5fJEzr0x2jMu81ZUK5fiYUN0cA/l4YqEDNf2ILKrTneFMFvLs/0cp2rGjvF5nemrBnf0PGJZGmSLrQDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(316002)(66946007)(6916009)(4326008)(8676002)(66476007)(66556008)(86362001)(2616005)(6506007)(41300700001)(38100700002)(186003)(83380400001)(26005)(478600001)(8936002)(2906002)(6486002)(6512007)(36756003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dndLcW5LUHZjTStMUHJEVDl4MytQTTFpc0xxWWNpWCtpakwzVFRrd1doWkxB?=
 =?utf-8?B?a2hYc3pKL1ByRlFiQ3VScVdWb1NxVkFXbVpKYTdFKzJ2akp4OXJhN25NOW1v?=
 =?utf-8?B?UDNnM3FoQ2xVV2RFSk1iNm44djE1SzVtaFg0ZHk2WnZ4d1MxL25XRVdxeDlG?=
 =?utf-8?B?aEJabFJaVTNEOE11RDZrZEl4dzFSVVUvRkFpenkwOHh5cVdLTkNXYU5LdWN2?=
 =?utf-8?B?V2p3Q1hJc2RlMjNzcXZVU0VlY2o1WmdOdk84M2JWVzI4MFhERE1SN1NsR0w3?=
 =?utf-8?B?R3Nmd2F5ai9lY1BvbTduQWhXZ1pVaTFuem1DVGJDektST2Q3QmE4dmU4RnlR?=
 =?utf-8?B?dkxNSE9rOWtqUkVZa3g3cVNsb2c0WnBSN25FZ2RXNG5IcTcwRHNvVGtBYjhX?=
 =?utf-8?B?eTNYNlJPdWNQQVg3dmxYQ1FDLzlRN1Byay9hTjlyd2tJZGVpNXEvbW53L2hv?=
 =?utf-8?B?QVJDMFB4QnNtRGdlNGtOalJMT3p0eWk1d1gzbkw1Y0lpU29WbEJEOGpjazMy?=
 =?utf-8?B?N0x3dENoV2JxU1lEVFpJMVlrRXc3OEZKUHdOdGYwV0huZ3IvUEJQa2JlTUt0?=
 =?utf-8?B?RHl5UWF3bEY4VmZxU09jTDN4UVdDalJDRi9NMTZ0ckZWbTY1MzhESG94L2dW?=
 =?utf-8?B?azZ1ckowVGRsTkppMlJERERlbU1UOGcwVlBXanFRZUVRMHFxdmIzYk5pOVVE?=
 =?utf-8?B?cXlhQVZLdE1zQ1BkajdHWVdub3dWOWg3dU5hTkNjZ2FwZWU2YjdxbkVzenhB?=
 =?utf-8?B?THFuSUtFZjRZZS9ncENhZlYzNXFJKzczTVdFNXRLUjRDeTdWbUtSRndHU2Jj?=
 =?utf-8?B?VS9Md1VpSFpENURyQ204T3BDcTR0T1d2Q3Y1Y29GNW01OUhCNyt1Qy9MSDZK?=
 =?utf-8?B?eDhQSEIvcWhTK3dvMHhaQzdTVHAzU2RnYUNVZ2lLZEpuV21aWHpNMWRhdnZR?=
 =?utf-8?B?TmJGUnlmeWh4RVY4WXJVWE1jODczVHRSSFZ5SWlPa29HUUsyN2kzVGNzOFlQ?=
 =?utf-8?B?UnZrQkc3SUZmU01GRm91WC9hVDdkWU5IbUNVY3pMTjI3dXBFQUFHazZTaHRo?=
 =?utf-8?B?LzVkRlROamJka1V1ZmlqdCtRM01aZzdPbUxNWEhXenVpK0RIYlZNQUZTSUVr?=
 =?utf-8?B?Zm54Ujl1Qk11dGx0MldMMzE5amZrWlN3K0VQbkdnL3hlUEsvYW1SM2RHUk9M?=
 =?utf-8?B?aE5jZTJnQ0lXVXBnQy8yNnRmcGF1RFJDTWVBN2tBbGtDdTk5TUxySzllRkRn?=
 =?utf-8?B?cGs0K0l4NkY4VXV0S3N3dmxqa3lJa1dOejJmMU1mUFZSR0RYUlZIRk05S3Jh?=
 =?utf-8?B?Ymdrdjg1NlR2dno4VnpjZ0RPOUNvb0pPY3Y0U2NTVm9iQnVKeEgxNVoweGdG?=
 =?utf-8?B?bUNoNU1uNHlvQlVlK1hlZjNTcHFaYi9YeHNkS0Y4dWdCSWRxR0dkLzBQQnds?=
 =?utf-8?B?V2MyRFVKQ1pwUzUrVCtUbGxwSTgzWUNPTXBwTTkrVjIzUXlIL2dpclNoL2ox?=
 =?utf-8?B?N0w1TXY2Sm5KbCt5cm0vcXJBa1Ixb3VleWQ1bWxrcVBmWUprQzFIbnZsbVAy?=
 =?utf-8?B?THR5ZWpwT053OHJ0QzBBd01ucERMV3cyVGc2amp3NnhrdU1jR3JrMU0va2Fa?=
 =?utf-8?B?VXRuTjlXUXlua20yWHRqMFJlM0RMSS9paUVSaUpFMUtlQnVER0FYMnhVQUhK?=
 =?utf-8?B?SUs1MXlxRG5iQkE2NmN2MlQrQlhwLzZJV3paMkFaQXdXdmhOdHBTeVNmWXZQ?=
 =?utf-8?B?V1BrdE8rREQ4cDBMc3FGc2w5RFZ2VWk0MEdYYzhNa3pFb1g0RVpGTUprZ3h0?=
 =?utf-8?B?d283VkJ1SHdHUm9kWUN2Qjl1eEVDQWdpQUxObjVZWnVVUnpxaTUvd2RyRzVo?=
 =?utf-8?B?cVJqREZWMUxCRnJ6VVVGS1c5R2JhdncrMFk0OFQvOGZlcmFsd0FreU03NU50?=
 =?utf-8?B?MDlVeWpkTG9nTEpGc2hKMFMydkwrd2VUdjBkeEpjR0xxZW1BVUF3cnIwcnNQ?=
 =?utf-8?B?NUlQL2t4L1M0M25WNHVFSDdwYytzVzN6eHNUanZFNGVlb0xGQ2RrclhvRmlk?=
 =?utf-8?B?V3F5bmtaUm5uRnJiRi9zSHpMMnhQMHBQWk85VG5zZUVtL3JMYVpHUjhnaHA2?=
 =?utf-8?Q?O5CoRFcjrPbg3NRYNK/7tG5EW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3599aa27-8b27-445f-019f-08da8174b5ef
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 23:52:29.5825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8xKwl+3bHhEsQTtDb+p8nY5mUJ2BxGmv1zRt7ee1e7JMOtk207EbX/3/Ehx/yAfX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2337
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 16, 2022 at 01:41:53PM +0530, Kashyap Desai wrote:
> This issue frequently hits if AMD IOMMU is enabled.
> 
> In case of 1MB data transfer, ib core is supposed to set 256 entries of
> 4K page size in MR page table. Because of the defect in ib_sg_to_pages,
> it breaks just after setting one entry.
> Memory region page table entries may find stale entries (or NULL if
> address is memset). Something like this -
> 
> crash> x/32a 0xffff9cd9f7f84000
> <<< -This looks like stale entries. Only first entry is valid ->>>
> 0xffff9cd9f7f84000:     0xfffffffffff00000      0x68d31000
> 0xffff9cd9f7f84010:     0x68d32000      0x68d33000
> 0xffff9cd9f7f84020:     0x68d34000      0x975c5000
> 0xffff9cd9f7f84030:     0x975c6000      0x975c7000
> 0xffff9cd9f7f84040:     0x975c8000      0x975c9000
> 0xffff9cd9f7f84050:     0x975ca000      0x975cb000
> 0xffff9cd9f7f84060:     0x975cc000      0x975cd000
> 0xffff9cd9f7f84070:     0x975ce000      0x975cf000
> 0xffff9cd9f7f84080:     0x0     0x0
> 0xffff9cd9f7f84090:     0x0     0x0
> 0xffff9cd9f7f840a0:     0x0     0x0
> 0xffff9cd9f7f840b0:     0x0     0x0
> 0xffff9cd9f7f840c0:     0x0     0x0
> 0xffff9cd9f7f840d0:     0x0     0x0
> 0xffff9cd9f7f840e0:     0x0     0x0
> 0xffff9cd9f7f840f0:     0x0     0x0
> 
> All addresses other than 0xfffffffffff00000 are stale entries.
> Once this kind of incorrect page entries are passed to the RDMA h/w,
> AMD IOMMU module detects the page fault whenever h/w tries to access
> addresses which are not actually populated by the ib stack correctly.
> Below prints are logged whenever this issue hits.

I don't understand this. AFAIK on AMD platforms you can't create an
IOVA mapping at -1 like you are saying above, so how is
0xfffffffffff00000 a valid DMA address?

Or, if the AMD IOMMU HW can actually do this, then I would say it is a
bug in the IOMM DMA API to allow the aperture used for DMA mapping to
get to the end of ULONG_MAX, it is just asking for overflow bugs.

And if we have to tolerate these addreses then the code should be
designed to avoid the overflow in the first place ie 'end_dma_addr'
should be changed to 'last_dma_addr = dma_addr + (dma_len - 1)' which
does not overflow, and all the logics carefully organized so none of
the math overflows.

Jason
