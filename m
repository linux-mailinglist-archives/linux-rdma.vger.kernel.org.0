Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E04A389702
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 21:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhESTu7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 15:50:59 -0400
Received: from mail-bn7nam10on2098.outbound.protection.outlook.com ([40.107.92.98]:7232
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232212AbhESTu6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 15:50:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIj+43p+3B1lLShOLzEwANkqBNrrEFQaeYDHn94+Cr61zwzdZwm0qG//OIOBIlUiD196GUVLIOWjEsV7ppE6P+L2Xd7rqLdLuMO912sN053mnOGU42m2Z+NTcGJm5C2t04WAWq5qcHeBspvdaytURfCJVr1GkBzPe4Bd0jcH9miM4PNCJlVxSDXUEPMVyCoDoXL+/P4sTLLubscWf60cyqMTBAd6PLtUa4aJkyv3AVucIquCxBNtN/nkR/Uv5wFE4Nfc+YjaF1LhDoQ9Sozxk8k78vcDEHh2zOPXb+tG/5MKQ5Ab8useB9ct69Zh2Ntt9hsWRmFGw9E6YbV+d42AHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stNzeLGzdlGRzz9VQV8bVWY5wpoq9KgEOYFAgOHNtfk=;
 b=VW0a1IFWbJD3KSw32uOj4RTbfhHdWCbXgJTTCg/iyhtIBzLuSlA7vWSig3w3CYY806CoUakeUDrgCPGPddnuw6rkIHynOA3chAd0G49jaiUli/bTvN1U3veVbdH2YFEOIo9ZmdiHc224vlca1cl6WN/sqoWaA22SSeHOflEfWh4e1wvgEOi+SnxgmfDw0Zf7sAX62OJpvfnwi20+lP1lVsQuzv1K2gcdv5vNgDgSiLKL6O3Z1dRucoLWKblhrVoPeJY7qS7tcQH6fF5o1xMjo9CYk2ND7o/mlEcMon1R0YeWpt6cDCd2SUKv9ie1gDWXUcQb/45r8ShqOqh7xQUbNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stNzeLGzdlGRzz9VQV8bVWY5wpoq9KgEOYFAgOHNtfk=;
 b=fHjQdWOxItzYcjZndRLu+tX28KNfprkXCPd7bPh3+bumUw7P9uKs1EMroFvAi+zFh2oNI1VqGdmzQ8JLIa+q3txeQ0AYJw6/5tUK0VIgsDoOif6m4xip90Wr3t0ATNHRtRpdcK3ImFzTq9pRBlo/6Dh5sIlMqhRmjTKFGTM7huyvJpeUugMcBwE4IT5+DkiZfuNIFK3TICYtndB+/qF//4E9xoUGzs523OdZLt3IXKfK6ljVNuAmZZYdYbvy0rwB+0zAqxt4E5dwAQxLjcFMDBTSEkXs6+Ga4BDN1mJXZ1T5ug9ypfq5VOLo0iV/Ih9+bPqTT3dmjvrzGyLwrxHAWA==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6360.prod.exchangelabs.com (2603:10b6:510:d::19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Wed, 19 May 2021 19:49:35 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::b43d:7749:62fa:2488]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::b43d:7749:62fa:2488%7]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 19:49:34 +0000
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <7e7c411b-572b-6080-e991-deb324e3d0e2@cornelisnetworks.com>
 <20210513191551.GT1002214@nvidia.com>
 <4237ab8a-a851-ecdf-ec41-4e798a2da156@cornelisnetworks.com>
 <20210514130247.GA1002214@nvidia.com>
 <47acc7ec-a37f-fa20-ea67-b546c6050279@cornelisnetworks.com>
 <20210514143516.GG1002214@nvidia.com>
 <CH0PR01MB71533DE9DBEEAEC7C250F8F8F2509@CH0PR01MB7153.prod.exchangelabs.com>
 <20210514150237.GJ1002214@nvidia.com> <YKTDPm6j29jziSxT@unreal>
 <0b3cc247-b67b-6151-2a32-e4682ff9af22@cornelisnetworks.com>
 <20210519182941.GQ1002214@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <1ceb34ec-eafb-697e-672c-17f9febb2e82@cornelisnetworks.com>
Date:   Wed, 19 May 2021 15:49:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <20210519182941.GQ1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: MN2PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:208:239::28) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Denniss-MacBook-Pro.local (24.154.216.5) by MN2PR08CA0023.namprd08.prod.outlook.com (2603:10b6:208:239::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.32 via Frontend Transport; Wed, 19 May 2021 19:49:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c0bb6aa-f1c8-4e6c-a1cd-08d91aff39ed
X-MS-TrafficTypeDiagnostic: PH0PR01MB6360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB6360E158E125FBEE4EEAB6C0F42B9@PH0PR01MB6360.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QUwdSjRTaM4w69wTpPWjnWLiDbP65vnhTLAbeQH/KtH/wwAKcyVWolpqpBrsix4RWvXKJoTsl61WQ2XT8b5PAwclh/OLC8A2NufkKsEQIOewcr2ksKMp528AjCOQUuiax+Q/WQqSkteBm9Zt2Zm80pdw0ad+hcqg6SBelCSjqgKCwq77uPPvOczffysanL9kIMyGqNyRRfDD5j09lXsG5CVHC7/ffKrIbBZlr59JQmVxbKOidzEfQyzj4tycdghLH6AK1NfgTc8wC2CmNit98+0IhgSlhOkNgDYmF68xfrzIxTR3R65VTLPe1ruSf6qiWlPWLD1cm5lINcEv26U2CWZ2TMb+IvY/IjRrRe6Qmir6nCFX8ZIjDGMJt7brnTNSXp27azlQKgHb8LXTQoBjPe76lA2W5UvJlf31InJlxTfsZ0XVJeo/Tu5bfGt/7VcpaVIN9AVqoEP8x1NGmptR6y0Nqzf5sIH/mFRbncFZhdwiiOYleJwcWRYch9JOj18+BG5OMVbZGQm09E4MT9jhCpuV9wOGtIbYvjwhdBkiBmbWM3A3h5TaWaSlrQ0Nee1mn8R9UqlP7n3unIUlDHL/tQl9g5JFewqS5zsrHfMYJ7pzIi+YB++/wlnT3oO2CRXsGCSDPXGooD4oUKshi7dy8ZJaXi82rQx6icePHQLQny52rtHRHfl/Rjwg3G2ClBM3SBFyZEk9EABjS73zG85lhG0KSyH5pmbdBGaxrTMV6ns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39830400003)(366004)(346002)(136003)(66946007)(6916009)(316002)(66556008)(52116002)(66476007)(54906003)(6486002)(2616005)(956004)(44832011)(6506007)(478600001)(186003)(8676002)(4326008)(26005)(4744005)(16526019)(6512007)(2906002)(8936002)(31686004)(86362001)(38350700002)(38100700002)(5660300002)(31696002)(53546011)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?blY0N3lQc1RVL2FPQ0NHanI3Rno5VVN5RnM1d3dXSmFzTVdPYTlaNDhZTVRU?=
 =?utf-8?B?TzRCbENEeEFpN0wyenR2TDlLSUFKYzNjQnlMcDBUNm54THMvcDVKK3VHMUxk?=
 =?utf-8?B?b09QUmlRbHdWSmZLRGFSU0g2MjVVR0VlcVExQzNacm1jZGNlYkZZcDZNY1pr?=
 =?utf-8?B?bkpCWFdjSkQxbXRaQzh6RDc3QW5Rdk1HODVXbzZQVWdlOHBEMk1lR0NBTGlX?=
 =?utf-8?B?Z3o3b1ptSDVycUdQck5vdjRhUnhwOU1VL0tPZElxWFExNjhjT3RtZmVCZHVV?=
 =?utf-8?B?NUZJWmo2cEtyaW9DMG5pUUFZVmdadmIxaGJlbDVJVVlrc0pHa2dJdnR3UVRx?=
 =?utf-8?B?dnNKNTlFN0h3bWlVWUt1WTV2RjZZVTMxTnBWb2JmZGV6blRGMmdsQVhLOGtw?=
 =?utf-8?B?cE9iZ0lmT0RVQ1ZNNVV2QkFETURWRkc3WGhtYTRlNVRnYWw5ZTIyVG5QWk90?=
 =?utf-8?B?OHQwSTBWL05TVUpVN0x4QnhPQUV5VVJBTWVDdjFsUWErTUZQeWd0WHJPUUVV?=
 =?utf-8?B?VEtCK3hacFc5S0t4ditKd0Q1U1F5TCtyQm4xMWFVaUVpUzY3d1lrc2NYZVhh?=
 =?utf-8?B?c2RHUWtMb1VzV1d4dG81V3dDYWg3ZU5KOE5kd0xmNHhtMkZBVXFzYVdzd1pT?=
 =?utf-8?B?NVpjUSsxR2E4VVNkcFZIanVjVXYxUGxnY3l5djBadTZ2MTduODVTNG50KzhF?=
 =?utf-8?B?YmRoeHNJR1FkTGdyY3liWXZaTEdrdUU4dVRmNmFteC9pMmgzNlQ1Y3NZWnJx?=
 =?utf-8?B?SkNKbWRVRkR3Uk9ZVDc4Z1B0TUxiSFVGY1R2cUdDbnVaS0V3L0Q0a1F4dmlv?=
 =?utf-8?B?RG9qbXJOVnladG5hMGpORUlNYnI5elhLNXNqdkx2VHIyQzVjK2VKZG9oNENo?=
 =?utf-8?B?QkNvOXd5alNwdWJKS3dGRjJZVys0SUxZVFQvVkNJdnVkQkRVT1VNeVpYYVZQ?=
 =?utf-8?B?UFRvWDI2SHBuRHRjSW9oQklCKytLWEJ1WTEyQ09hMm9ybktRNllKUnRhaGVI?=
 =?utf-8?B?N2JTb3pyNDdwOUtaSzBjODQwaVZnK09UOWhTRElERkQrYWhtZGVEOG1DWGlt?=
 =?utf-8?B?NnZtU1FjTWtKdkVIamhRVHNydzRFZnVRU1djZjVTRWp3R2UvVVRkdDF0bXVv?=
 =?utf-8?B?NC9ZajVWWm0vN1IyUWE2cDdrUENWZDNzRHNMdTNqeEFJSHpJZC80clBDQnV5?=
 =?utf-8?B?bnZPTE9NQXYxWVFEcmVaTUdLc0F2dDVXYUFkRzdTOGh4T2NhajFheDFQL2Fa?=
 =?utf-8?B?RUxIRmozNktqRDFjK0J6d0FJYkNpeGdTKzZLdnhsTnJvdXduL0E0cDljemdG?=
 =?utf-8?B?WS9iSEw5RCsvNEprWmZnWXhrbVdkSU9rcXhkZ3lDbWlNQmJBbUxkT1Q1OGRS?=
 =?utf-8?B?N25TdTR1SEM4T21vZC9uN25FV0ZzT08zd0RlOGxmTGd0eTBCWndOZlZsNVBL?=
 =?utf-8?B?V0c0TEhNWmd0TkJFQkdKWUVLV1BQaTF0eTRrbWRsNkx1RkJDaXAxc1FoUVoy?=
 =?utf-8?B?YlFKTHhpeWFGN3Z5Mkk3WlNPdmowalg1bHBTaUM4Smk0ZkNtazB4UkhlSnM4?=
 =?utf-8?B?bkhReGR5M1R4b01CVDVyejFWR3J1RXVNSkMwdUZObHl0VDFFTWNZWWRmZnRw?=
 =?utf-8?B?VWQwUWlHdVhGY2JuU2RYREVIeEV1Ti9nemJqRjVOUTJqN1RKL3RYU295ZjAr?=
 =?utf-8?B?THNMdWlZQmVLdXRBWnVFVzdwcDVOOFdEVFdDMjNycFVwMVpFVk5KU2MyUUYr?=
 =?utf-8?Q?9aSAWD4UPivArHfnYibWWnjmWZzpszmZDfrTFF+?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0bb6aa-f1c8-4e6c-a1cd-08d91aff39ed
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 19:49:34.5222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0RhtAU29PcggMVos6YUaph7CHKdE8H+1iJs4b4S2joaCBREsplielr+tzEi1HlUMb/eR9Bi+ivYMpcl0N77okkltjJu8/OJS6euv50zTfP8TexEDXYLygn5ukpuNBKr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6360
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/19/21 2:29 PM, Jason Gunthorpe wrote:
> On Wed, May 19, 2021 at 07:56:32AM -0400, Dennis Dalessandro wrote:
> 
>> Perhaps the code can be enhanced to move more stuff into the driver's own
>> structs as Jason points out, but that should happen first. For now I still
>> don't understand why the core can't optionally make the allocation per node.
> 
> Because I think it is wrong in the general case to assign all
> allocations to a single node?

If by general case you mean for all drivers, sure, totally agree. We 
aren't talking about all drivers though, just the particular case of rdmavt.

-Denny
