Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398C446AEA7
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 00:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377669AbhLFX4C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 18:56:02 -0500
Received: from mail-bn8nam12on2075.outbound.protection.outlook.com ([40.107.237.75]:63201
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1377676AbhLFXz4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Dec 2021 18:55:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmfNfYHyUbiF5rEaTdRrC6G4hmSRgG/Dxe8uGoXX4l6Lc2kJO3g1PwxXtAA5xP8juUM7LvGbEjt0I1ml7iG4xnfhiTW+6sQ5kf2bjioJMTquXtNaHDpGugcuanMCpO/2M/jI05vSTPpmkDXy2Mf3Hl92Z0TaNMBJcZrTkTqAQ6FaLysFGnJrBiwKAeZW3edtepvDciAo3Hpns+Er0G7ce5ssThWiGixmpojCHaQD6ENkulKgeqB6RlRhBml8+k7Ok4ELz1X8UZdag0nTK3rH2Ksqv8a7haBNUrJ+PBJ8eRZXrdtKS+/Irc7MStphkHgg1R/6KLxuhjFMSqQEfEUBQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNe/68KVpvoO+DEaHPbez40pm1scP5FNuZ3yLrmeI+c=;
 b=eyi070mEqWgSSBX5XvJjggN+eBQhaGzAP+PmHLsetXF+asRrEbbvKhTJurSikZ26d+ZTWFjJuS4p9rDemmYndiLXPj3TE5PXdjdsP0mXmuwmR5UC/oxIwD4i7GeyAwcyj9uaKWDlg2SmZ7KZNEJOQCSWyDL4qk/oDRJa7InIugz+1SY9U8r1lsmgQ+ZqtZZnr1cMgrrWwHA25Ak5oaId1gzxnaPhChEY8ull3pxspAxPoicTWHzWR4J6uZi1KnvN+KHcs3wgaaGgqEVvKTDnVg/puhYKHNlsG5KVB4mqfZpfDxhpqL0+XC9VdOlzGmHGzQcYC8pXpe5SyjakNiFfRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNe/68KVpvoO+DEaHPbez40pm1scP5FNuZ3yLrmeI+c=;
 b=PA4IiXdkwaVDYN1GuYCFm5CBxsFlaDW/8KCQHTdBi/xD7NKhMJljgZkeukYTRECR7FpeN1FSQMBxlzOy0cfhcI6yFSodSPDBWUGWg8zKZCi4MDEoLraB3Qw35HYEoKB9ZLBqb6KbhVefuLvDRkibGErAc4Oi7KckXZ2uJS7TJxaEu9fA9pOULDXQsxSCCCTCv0d0MpGhnvtRqWg3ikt2KwrSVzzAojyIy6XpDR9Dn9YHbVoasdSACvi5dXdKGFQbOUDithtqbZzzoLGdXjueq+Fx6H4is4xf66JeQR6gqHgh33jUZvcJQAQ/jI9Bekqq+2wMcnbwVgfEZDNB+Vs9ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 23:52:26 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 23:52:26 +0000
Date:   Mon, 6 Dec 2021 19:52:24 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     yanjun.zhu@linux.dev
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH 1/1] RDMA/uverbs: remove the unnecessary assignment
Message-ID: <20211206235224.GC2170341@nvidia.com>
References: <20211207064607.541695-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211207064607.541695-1-yanjun.zhu@linux.dev>
X-ClientProxiedBy: MN2PR20CA0053.namprd20.prod.outlook.com
 (2603:10b6:208:235::22) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR20CA0053.namprd20.prod.outlook.com (2603:10b6:208:235::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Mon, 6 Dec 2021 23:52:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1muNmS-0096dG-WA; Mon, 06 Dec 2021 19:52:25 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46ceb5c2-392a-4a4a-0b0f-08d9b913747c
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB55059E0FB4045F03605EA869C26D9@BL0PR12MB5505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l9BWp+eNLxQLYLmFfPAb5/PY1YXLHDS7lw2uoL2OzM4coisPK9qKUPnsc7Xv7lT0diRUmTmmZxbwgMz3nEKYS5MD/gL4XLAys7+tBGNKJGS+zy7cm1KVsHb6ABnU6J+vpAtIbK4EkG4uvztfXdzc29oTBg0genRgGdiWQcv4UajcnpK7PF/8xcgwUP1lZREjizGn0CyDdDJCtAaIFValB4AiM+WxYq4jERXqRBCSE0VkFe78VdBbpMRh9zwmuyl6ebnYF87HeAraLo3sEKCyakQOfgmIwUtASvRljzBJH+oNeTi7SRuoNnkbX9k/YmHOzJdgvc8FRtInLvDTEYVYXTVHXN+H20BVPq2pW97hDzcx6YXXPbdQUYE9EuYS6TEcMturjhYtP7R5V4OEExcU65bb2khaCSMXB9HpFGNbphS9MmsVmLq7nnbvoQpifKLOlqoUvq+hz+oCT8fSL8DHcnfJu8HRqwT7J9p4NSf4tK8fMYTSDI8kC8oTrmv5eSM2N4URALFlaJNJ9nRp3C7gXkbCSsEm279P5Gq+9gFbhrPSAk4CvDHbNb874MtuJlCkKQ5lQ0gmAZkI4C1WJrOGXQZ/raa2Mc9QnFNStfCTKMDXqjshbxfsuBvr8TBqvKsLXtfkzC33VXuDcW+AB5C13g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(426003)(38100700002)(186003)(5660300002)(6916009)(83380400001)(2616005)(33656002)(4326008)(8676002)(26005)(36756003)(316002)(66556008)(66476007)(66946007)(9746002)(508600001)(4744005)(86362001)(66574015)(9786002)(2906002)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3p0Ni9tU2l3S2RjVTlTOTlSZ0lBdVA1RXoxNmt5a2c0MU5KTUNqRGpVZENQ?=
 =?utf-8?B?TEM0ZFBoU1lCOW1DTkRXS3BMSXMzRXdBa3BFbFdsVjRnUVZuWHNZUFJGdEtL?=
 =?utf-8?B?c1l1RGthVjNLVWUvKzA2aDhsek5Kd29SRUdsRHZnd3dCK0VTdE5lNFN1Z2NQ?=
 =?utf-8?B?OVhZTXlJaE4xUUR6V0RVUGVmbHphY0VoTFJvakVCekpYOE90ajRMMTdQZm1k?=
 =?utf-8?B?Y3JaTHZQekFHS2VpVDM5eFdFWHl2Rnk1MlpINWVWNk9neU54RlMrU01oUmRh?=
 =?utf-8?B?cFB2dXFrdUc5UFpIanVqaFI0SldVeWw3R2pqTVRLdXJOK2gyK3RQL1RiMldP?=
 =?utf-8?B?R01LTFJXMmwwNGp3dHdtTkhKMzVTUUFxaE9SQnRmTVptOGJwdi9OSTBlRFJH?=
 =?utf-8?B?SU9EcHVGSmJiekNXakpPUlorN3B4cUVFSk5NNkduY28xWEY5SWdHWG4wMzMv?=
 =?utf-8?B?Z01XeEc1R2JNUmozUTVNOCtRKzhzUEs1Q0h0b2FnQlFUYTgwd1pSSTRoNWxE?=
 =?utf-8?B?RnJWM2kxN2FOd1F0SitQL3NxZUtublNQUlBIbWdOalE3WGVRVDdrYy9QeUtX?=
 =?utf-8?B?RkpibXZ4cTloUDhKMHY3U2lkbFBFYWhmQjNJZ3dUT1J0dUtPSTkvSmYvTlU0?=
 =?utf-8?B?TFlmYnJwaGZaTWtDY2dsbmNvQjR3RFRQamxteGF6UXJuV3NQajJRaGdkTXhE?=
 =?utf-8?B?d0RLNjJyMmt0RW9kOVcyUFdoUHpkOVNCTThwMGFsc09lL2hXSXBWUmVXNlQz?=
 =?utf-8?B?TGtNOFhwNFZGZWdFZDU5WEJkaDlpQjVTSkxaRGZPTXpGODV5VlR6TDQyamRE?=
 =?utf-8?B?N0htaFk1UlFiL2RkN01ZMEdKOVV0OXdPQzlQOENpVDU4YlNhbHlmdE5ITlMx?=
 =?utf-8?B?SnV1d2hCaEdjcEl4ckZiVlJ5eFQ4MThyR2ErNlY5VEg0b1UxQVBhUVJZM3Nt?=
 =?utf-8?B?UWR3ZEpmR29hMTFzV1FTRi85UFR4SGRFRjVPN1BsSzJzQ242N25kbC9SWEtF?=
 =?utf-8?B?T1ZjUVBNMDNSU2FnVytvYkQwSUd0KzZULzBZNTRtbklnVHB5RWt2bEh1K1lk?=
 =?utf-8?B?anRkaVNYWDJ5WmFTWFIzdlg5ZDNUUWI5M0hjSTM5dXVNYjVRNG1qaUNhbVdp?=
 =?utf-8?B?VFRaNXNsQXRQUlFndmxuSStCMEZYZXIxQjVBeVF6SHlkVGE2aWFSdEZhdDRW?=
 =?utf-8?B?bmtma09COUNpK3JMSE5UajFaOWZGL2NWSzVvUXF3K3VsNWZvYmprN3FZdG12?=
 =?utf-8?B?dGo4M1IzY2VUTXNhclpxSU5hU1BLQUgyL3Jkb2JybEJDOXlsUmdWb2dRYzhO?=
 =?utf-8?B?WXZxalF5VXNuMmJBQXJHVlA0U1o3OGhjYTY2dEpOeW5aaVZJczFXaGMvbEsr?=
 =?utf-8?B?NGhOYlJleUxlTVdFcFBIYUNrVWdFY1BRWFRlV2xCOXh5L3poK0VzRVk4UHAz?=
 =?utf-8?B?cnlkZlBDeEVUdVZCQ0txbmVtSDhXMkRDNGZYellaNkxsRjZQMzM1aTZkR0JS?=
 =?utf-8?B?UStQMFpQK1NDN2hzUHh6dzVMQ1UzTytSbCtERDVrVlpDclMzMFdMczFQazZO?=
 =?utf-8?B?WFl2cUNFdnc2MjBQTWdMNEUzTnRRbEVLb1F6bEZvUGx2ZTdYNTlRMHByTXBr?=
 =?utf-8?B?b21jV0lQYmppOUFXanhBT251aXFsTncrSU1EVG1jQkx2YTlEdUNWNEZoSHhC?=
 =?utf-8?B?dzNwY3FqSFVCUUliSnVxUFBZWUdVa05maWJrWW03TVBDNmx0VnhNRVE0Qys4?=
 =?utf-8?B?K0tyNFJyVU5LMlBiSmgvUlhmNTZsdStpUUpnMnFRMXB4WGJlSVZKclVwdGFp?=
 =?utf-8?B?aDY3VkZUNUpCdTZZMVQrZjJLYTJRMlZLQUsrQVdpMjRwVUw5Wk5MRlRESkZv?=
 =?utf-8?B?UkJ0WE9UWWp6NlEzaTVTSElNYzdEZUdlZEtjSmVVVkdjSEFscFZ2N0hHOE9w?=
 =?utf-8?B?dU1LcUdwTGtEcnVzdWQzUnlGbTRTaDZGdXRyTllvRVBKMW5vMkdGVzlKaFdk?=
 =?utf-8?B?dGkwMkNKZUlsekNxeTFSQnArcy9RdmJzUDJzOEthL21LSzV5RlpxL0NLdXI1?=
 =?utf-8?B?d0ZLYi9HTkJ6M1pWOFB6TWZiK2NLYnpxQkpaTkJPaGUyc1F4N0hmRGV4OW5n?=
 =?utf-8?Q?irH8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ceb5c2-392a-4a4a-0b0f-08d9b913747c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 23:52:26.0845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxcSJIv5JeCJGbq/yoIKJ3riDyg0w6VOg/lAIF7bK+SRbNcE1CFoIyOUxUfN6MZy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5505
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 07, 2021 at 01:46:07AM -0500, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> The struct member variable create_flags are assigned twice.
> Remove the unnecessary assignment.
> 
> Fixes: ece9ca97ccdc8 ("RDMA/uverbs: Do not check the input length on create_cq/qp paths")
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Reviewed-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/core/uverbs_cmd.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next, thanks

Jason
