Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36C631A760
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Feb 2021 23:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhBLWOv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Feb 2021 17:14:51 -0500
Received: from mail-bn7nam10on2118.outbound.protection.outlook.com ([40.107.92.118]:10880
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229497AbhBLWOt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Feb 2021 17:14:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gG5HmRkRzonPC4rizrWii1oHk5iYPWcHfII10UyNdPE7fhgmXw3cDERNRrtQGR1xG4Cird2Cm7vN5xAX2qco3jU62o9URMZp9Pm1xsq3huySrAytb7sqL/rYOfZwOZ4hRtz0YrkeuO4NDK24F6H5ZPQzaJkipQ4APN22TfXwKheZvq3kVV2BfRM0Q1Py2EGkp3EdeR1K8oG+f2iQ35p/vMku9leSycZZT9D78RGBcOIiVt4QfFLr50AxvrpjrD86rO2Tm9BwIKeZehejOZT0umIoT5V8rYTQweYgHmtbPGO9/5W/wi45fk54rK/0RwremFVLF+TgFHtQClA3l1+i0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6Kn+49vO+E0+2U7zQHyNeyV8hzCQbQDn+nA/waoMlU=;
 b=D163pSeKBxZ+gAqL04CWVwUEC1TjA3CAyqOcWlALhU7BVY0riRVTgQK2oEIe0LPYR4+rz0vnmjL8LypZ04GLumsNDyHIt3bJkX+bWFE9y/EtS/yRgCIng0mBZY8p9mxeQ+RrPgTbuJEyQgSPA/vGYfM7r5zaQ4Q24U4OEjxnN2M7VmJj+t6xFJWIQ4Db8fq0FvGE+BlyjB6Vz8wVBhhrcjI8E3d3fwYXVByxgBVe1+5KVQYw/Udb14TEqRztVuC9JUpZg1S7VzLHD9hBRMua6aGKZsoXojWrBn8m8xn+FSTR4zNTZZRNv5DM0h1gtDrlvmI9Ksq+gIV4sVeOqXebWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6Kn+49vO+E0+2U7zQHyNeyV8hzCQbQDn+nA/waoMlU=;
 b=HO1MjXwc9e3CpdtlWBZoqyUWWPO8s+eVoLJJhiDF+QfUxfq5TvXXV3/Dr8v+lgqYZqqyESEMcxCJpSwvM0KSK/wMkjEiCvOFUNlrWabzhi0ORIN+NwGjs07WvAqXU5BGx9Br4VEHXs2LAydxPQTgCglHKYnoaqhlvtS5OBlsybBJIuKZQLilJIfPu1mErbSeewcprfCezwoa4E+POIjycfVZFqccvQpSwGMB5y7WPt/3RfVAer4WnpkAfV3pWrdhygbGH/3ItQv5vzT/1aW0FgmVKLWu4TL93A4ClOJB3GBmqdi5velCqJgGBBydCjOlfMFQnVF9EpMmbvEwAo66ow==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6246.prod.exchangelabs.com (2603:10b6:510:b::12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.26; Fri, 12 Feb 2021 22:13:54 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::3dd8:bb32:87f3:7e4e]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::3dd8:bb32:87f3:7e4e%6]) with mapi id 15.20.3846.037; Fri, 12 Feb 2021
 22:13:54 +0000
Subject: Re: [PATCH] Fix: Remove racy Subnet Manager sendonly join checks
To:     Jason Gunthorpe <jgg@nvidia.com>, Christoph Lameter <cl@linux.com>
Cc:     linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
References: <alpine.DEB.2.22.394.2101281845160.13303@www.lameter.com>
 <20210209191517.GQ4247@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <fe7ab4a7-db8f-7ad0-23de-7f4d8156ed1f@cornelisnetworks.com>
Date:   Fri, 12 Feb 2021 17:13:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210209191517.GQ4247@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: MN2PR15CA0042.namprd15.prod.outlook.com
 (2603:10b6:208:237::11) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.40.159] (24.154.216.5) by MN2PR15CA0042.namprd15.prod.outlook.com (2603:10b6:208:237::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Fri, 12 Feb 2021 22:13:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d619dca4-ff16-4b87-9cf8-08d8cfa37c4d
X-MS-TrafficTypeDiagnostic: PH0PR01MB6246:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB6246807FC9F4105C627447F9F48B9@PH0PR01MB6246.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VnkEiDaFPktu02lZTHxB23Z1toRi0YjWZX046+CTf0iPq3gFHo0onCTHoo5B4IclzJVsm4+dO5whNIPKUfVXAp3cuOlaEEwYH9pRKHE5PKqn/H9zY90yo7bpAStZ/7tQ/GDGHqKoGCtDemVn8dVXGIlO1a1iPoIsw31h4JFnOvc8KJBixuCeHzd7ecUHtSljr7Pzituoy1ZF4132Q9bj7mJq+9chBGYRbuLSzaphhRbOwSWBorjdxk0FAmT5E1N7KxHhdvXYceuK5HC2blnYbbbBXRsud8FpEKKWgc590Tv5ihgSmjFCxnL/sxYGly9lcrTrdqPzigkSYhavQ5oLbjHvgKNw8QhwOxbr2W3q3HP0AC8lJrY/PVpQ3DVZ24v60YA1ZQS4jJhzwhDO31SRxMqE0vm5IfZ6AsiRyGcDX7uExeZDp2YSRVT7AShFO6CFe4VAyk2qqiIPfSt9wJ5ShU7LxKIPIHI8zbd7VDxsye1tY2hAueA+0nzMM3TSV4sgMa1zdWIn6O98klcQVRZx6n40MzeOSDHIzSAooMoV3fmZShTudqmjKH3NI3BgNTbMDfsG4y6heOqnUdN7LxCGwqfjd4zMns20H4vDVLFieMM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39840400004)(346002)(366004)(396003)(66476007)(66946007)(66556008)(316002)(5660300002)(52116002)(31696002)(8676002)(110136005)(86362001)(2906002)(4326008)(6486002)(31686004)(186003)(16576012)(26005)(6666004)(83380400001)(8936002)(956004)(478600001)(2616005)(36756003)(44832011)(16526019)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aHhsRzlucUF0ck42UGgzTlc2Ly9VTnFxN3hPNlhiRzNEYWRrWVM2RjJ6QUpn?=
 =?utf-8?B?eThoc3E0bnE1akFLelQwZHUxWmdqSG1PY1JGaUNBSHFyQmtFOW9RSkVsVnB1?=
 =?utf-8?B?VGJ0R2hrN3B1UjRYTitBUlVBT1B4dGtramNyQmdqd0x1d01ybnUyeDJELzg3?=
 =?utf-8?B?eGhoUllEMHRZdHNQd3c0MWtybzZISVU2UHM5U0xKLys0TUZSYXF2UVBjS1hV?=
 =?utf-8?B?VzVZVzFyc002b2tvTS9wYjd2M01veGswenR3d2tmUlFXcE5PbU5aeVAvR1dI?=
 =?utf-8?B?UlNscU1VNGJOQ2FMY0tlUlBMZXJoRzJnM200aHhobWhZQ05uTHpzN0RhWWVa?=
 =?utf-8?B?VHk2bDJlVldmcEdCV3NuUHdwQjhhaE14anhLNmxTTEFlMk1Hb2k2YWJ2WkVI?=
 =?utf-8?B?SjBOUG5yM1ByaGRIZEwvYlh0d1l5ZDN0SEJ3bVlVWVYzRFlvTHRQYlJoWXNv?=
 =?utf-8?B?MmtINzJNcytEZnE5dmsxWHAzcW5yVVNDK3pHRHRLS09laWVQQ0s1Vk55ZkdH?=
 =?utf-8?B?dExZM0M5VkFKL0o2d0VYZlpXME8xTzRsUlhabm9Vc215M1ZzR091dTZPMlZz?=
 =?utf-8?B?YUpOeVVERGh6NUhoOUFJQ1IvZkt6UFRnejVxTHUxUWtLd05wZ09NZkNPblFo?=
 =?utf-8?B?SXZXbHNDcUJuNm5ya2laY0tZWE9rWndFNUoxQ1I4cnRad0dLSXB0NzJINGRa?=
 =?utf-8?B?UjJOZ2wvOG4raE0wbm95NWE5L3FnWlJsWGdYVjFwVmNYRjY0MTR5RkhIZDBr?=
 =?utf-8?B?bFhTU2JickJ3VFRxQ3FGWXZtdy9nVHlwdzBSdkxYWFlqelVjcVMvVkZlOHRx?=
 =?utf-8?B?S25SU2VHdFpCSVo1Y05NVDY1ZUlFTjM2akgwZnVXZW01aEJ4dE9RYUlXUS96?=
 =?utf-8?B?R2tXKzYwemNQQWxWK0pzZjJGQlBSQkEzS0tSSkk4Z004TncrZjMwNWVkVy9v?=
 =?utf-8?B?VVpjWFlXNEhZeVpqMGpkWmhpekxGYzBJQlZsS2lsNnVvQ2FvSzZXREU5dm9Y?=
 =?utf-8?B?NlE4SXVOWUFHWWlqQlQveDBrRXQyL01NNFB6ajNMSkVBMExtRGZuei9sOTMv?=
 =?utf-8?B?YlFoV2xzMllXOUE0Q3NPeVJ2NXZYSWlkYWhvMm5UUk16WjV5WERFNzVQc2JG?=
 =?utf-8?B?Y3VUTG9wVFJxc295bjVYMmVXTkRrc3JES2pMa3VObHZ5VmxRbHowdS92QlA3?=
 =?utf-8?B?d1VTSWM3TnBKMHdzNDJpM3Bic0JrUWJiWjRxYnc1WTA4U1NZeWM4QVFYczky?=
 =?utf-8?B?OXRjZjEvRGRNNzNmckllVVo5RmlOT3IyVzlFeHlQdmdZWGV6UkFyR2VrOVFt?=
 =?utf-8?B?MTdqU1lqajF1K0lqMklEQmN1MUFVdk1VV1pMTi8zNXptcHVEMHJVWXdQSENN?=
 =?utf-8?B?ZzlGK0M2cWRYemk5NVVMbVFFNFNqNkdmL04rQ0VTVVRxUGkxcm0xZlRIeVFW?=
 =?utf-8?B?QVM0NjN6RnFoeW9xQW4xVUtScDl4d09OS3lrZE95dTI2YW42aWxrUHNSS25t?=
 =?utf-8?B?blRPUWhLYUs5RDlWL0JjV2lQMkpqdFFZSWw5WEkxYkdWUUN6SXlySTR6L2du?=
 =?utf-8?B?RlEwRFB1MFVzazh5Y0V6eG5YOVpQWHU3ZWxlVnhQYy9VcGNnaEZZNHNZYzdo?=
 =?utf-8?B?cjJ6aDZNZEJPZXdqK2RPNXppOVRnWW9Wa2cyWGFPc0RTRDBHYUF6Z3RTb2VR?=
 =?utf-8?B?T3lVcklHaVh1MWlLOTArZkNBdHZ1YiswTHVmZTRReHJzYTYzVXEyeWpvaUFh?=
 =?utf-8?Q?AHO7najfw+gQu/NSu94VWBmy0oNmSoMxtNabO7O?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d619dca4-ff16-4b87-9cf8-08d8cfa37c4d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 22:13:54.6120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rnqJejW7RwnddmqFgU8xP0YrS520gCn4/NhpGsNkDtLIw/mhuhyRh2X8XuP5B/tSwdX7fQFdycOBuapPhOjQk3tkgNq3T33cITYz9Ut/J0ZI6Hc9vtHcBWaLLGbPCS1M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6246
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/9/2021 2:15 PM, Jason Gunthorpe wrote:
> On Thu, Jan 28, 2021 at 06:46:47PM +0000, Christoph Lameter wrote:
>>  From 64e734c38f509d591073fc1e1db3caa42be3b874 Mon Sep 17 00:00:00 2001
>> From: Christoph Lameter <cl@linux.com>
>> Date: Thu, 28 Jan 2021 14:55:36 +0000
>> Subject: [PATCH] Fix: Remove racy Subnet Manager sendonly join checks
>>
>> When a system receives a REREG event from the SM, then the SM information in
>> the kernel is marked as invalid and a request is sent to the SM to update
>> the information. The SM information is invalid in that time period.
>>
>> However, receiving a REREG also occurs simultaneously in user space
>> applications that are now trying to rejoin the multicast groups. Some of those
>> may be sendonly multicast groups which are then failing.
>>
>> If the SM information is invalid then ib_sa_sendonly_fullmem_support()
>> returns false. That is wrong because it just means that we do not know
>> yet if the potentially new SM supports sendonly joins.
>>
>> Sendonly join was introduced in 2015 and all the Subnet managers have
>> supported it ever since. So there is no point in checking if a subnet
>> manager supports it.
>>
>> Should an old opensm get a request for a sendonly join then the request
>> will fail. The code that is removed here accomodated that situation
>> and fell back to a full join.
>>
>> Falling back to a full join is problematic in itself. The reason to
>> use the sendonly join was to reduce the traffic on the Infiniband
>> fabric otherwise one could have just stayed with the regular join.
>> So this patch may cause users of very old opensms to discover that
>> lots of traffic needlessly crosses their IB fabrics.
>>
>> Signed-off-by: Christoph Lameter <cl@linux.com>
>> ---
>>   drivers/infiniband/core/cma.c                 | 11 ---------
>>   drivers/infiniband/core/sa_query.c            | 24 -------------------
>>   drivers/infiniband/ulp/ipoib/ipoib.h          |  1 -
>>   drivers/infiniband/ulp/ipoib/ipoib_main.c     |  2 --
>>   .../infiniband/ulp/ipoib/ipoib_multicast.c    | 13 +---------
>>   5 files changed, 1 insertion(+), 50 deletions(-)
> 
> This one got spam filtered and didn't make it to the list:
> 
> Received-SPF: SoftFail (hqemgatev14.nvidia.com: domain of
>          cl@linux.com is inclined to not designate 3.19.106.255 as
>          permitted sender) identity=mailfrom; client-ip=3.19.106.255;
>          receiver=hqemgatev14.nvidia.com;
>          envelope-from="cl@linux.com"; x-sender="cl@linux.com";
>          x-conformance=spf_only; x-record-type="v=spf1"
> 
> Also the extra From/Date/Subject ended up in the commit message
> 
> I fixed it all up, applied to for-next
> 
> It looks like OPA will also suffer this race (opa_pr_query_possible),
> maybe it is a little less likely since it will be driven by PR queries
> not broadcast joins.
> 
> But the same logic is likely true there, I'd be surprised if OPA
> fabrics are not running a capable OPA SM at this point.

OPA supports SENDONLY joins.

-Denny
