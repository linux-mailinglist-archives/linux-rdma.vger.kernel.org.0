Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625513187ED
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Feb 2021 11:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhBKKQm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Feb 2021 05:16:42 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52282 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhBKKQM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Feb 2021 05:16:12 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BA9crl035428;
        Thu, 11 Feb 2021 10:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=qKy6nN8F15oPxfqbPuHkNlV/pcWZwy/iL95lgGdhD1s=;
 b=gt6pFHdvOJQ3oEhred9svGNvbMC0jHJPmgVZ2hLEJOh1Uw0du8+VWkg3d2Nrsj0w/bPS
 hBtLIN8cgfdQ6xWXPEGFp1jr71CNVFbUxZXVnEquYWZe9JxxzIKofvQWR8qypMgWlyyJ
 nN4sKrrnmNWPPHGt60joRlrbdO4InJxxg806qooO6A+eyBRYKD5MB0VWzmKUuNU8nmvk
 TNftiZ/N6lvtX8cGtRlDfZeoq36JRUsP9+XRrcV7/9lDMPwY3n+cawzITtGESFmcBntJ
 w+0lDSqp2TXOm63WpiTV9amorVoqQLk5tGvG8EqJF+4en5rt25T/HXzqbov/+HDNBI0x YQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36m4upwe9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 10:15:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BAEkrm007692;
        Thu, 11 Feb 2021 10:15:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by userp3020.oracle.com with ESMTP id 36j4vu29x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 10:15:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SObQWha3pCO0+vWRRzCn58wAYKDcWd8IUjoj9fKJCcryxG0yN65DX+KidLX3Uqcjnye80wBzfH4/ahDuS+yE9KqJfrfbtOnflTIlyCLWe2LeLPuTCx4ylc9YIWG8T8zu+Dlqu3OPIDG66Y/UjZThiWasb0ypCxPaf/RWI8PQ3KNQmWXTvr3ZaDlcgX2xfcfwPjQ9W+Y9/j0OjA9KpSV5kHkfno6raNV+ThFaBCtmtUqodNlS4FBe/WyuJcRBZzUcpMDAHlESZk9Bc2vxRVSBKlDMTA6cNCIQ33w99bbOimzza8krDovS+0Pp3ccNIiCr1GkGbswVkQoeZpCNRuxE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKy6nN8F15oPxfqbPuHkNlV/pcWZwy/iL95lgGdhD1s=;
 b=gzYSRovTeQDkEVZerfcaEDqRycISZGbTfXtGTE+lVJnRl7kVynyzgVE0kt1iVRplK0qcHYrxwjD9jc7S27KdMLWQ2OktHssUDDg7Z1LsnRBmuwgkaFGq23NsbOIY39UwqHrc0S1VML6ub+ebtkI1FuDdgpTEzORZGFoqsDZ2Bmzbf3XApZLFiN1akRXx5HuzGF2L0xsB+eVuqchYRGqd2FJ/BHr/Gl+9WgnvI0nhPkPkJiZHuMaURdFGnsiaGOTdxvVcrfyz08MNYcvEDgWb6uBhPhihhGJMGClwNDOFrABkbJ2jBbB8yiUpa9x/SzRWipJn/C4o08fuOzWobcTh1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKy6nN8F15oPxfqbPuHkNlV/pcWZwy/iL95lgGdhD1s=;
 b=yO+J32Q4l7eO4PD9Yqs137OblgImQVebtymA8kfwd39jrkVi9ARQif2RctVnlOgoQxePTLKpXrSJKgZnm1Cm6FldgFv2vwnu6JQhADKGEiuFb4SuA4BeTIlPFzByB1U787Nd9+kLbC9NpE99oiZNSzBmmfRNBE0IyFoZVzjDpWY=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by SJ0PR10MB4590.namprd10.prod.outlook.com (2603:10b6:a03:2d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Thu, 11 Feb
 2021 10:15:07 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3825.030; Thu, 11 Feb 2021
 10:15:07 +0000
Subject: Re: [PATCH v3 2/4] mm/gup: decrement head page once for group of
 subpages
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210205204127.29441-1-joao.m.martins@oracle.com>
 <20210205204127.29441-3-joao.m.martins@oracle.com>
 <20210210210242.GQ4718@ziepe.ca>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <10989552-b759-bd5c-985c-fbb1753731a2@oracle.com>
Date:   Thu, 11 Feb 2021 10:14:59 +0000
In-Reply-To: <20210210210242.GQ4718@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0460.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::15) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO4P123CA0460.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1aa::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Thu, 11 Feb 2021 10:15:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b9f6042-71db-436c-e2e8-08d8ce75e7bf
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4590:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4590565A90682382CE65DE24BB8C9@SJ0PR10MB4590.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sDf+7immBxbu6ETjzNvAXRibXXVePZAY0Fi+hklrWz12VlyGdw8sSpXg784+rpPbPSl3Z2duqSSdEg2qaYTxMjSdzsOl51gs8/E03et2sXrPWkFdfwElwxqR+Hv6Z4nALt1mvBAfx/lKm+CAUWVxKmmdHJ63ZrkrXukIob/Rk2NmuQJH4Wx1PgzHIPHGJRJ2TKUfH/sylo0tt3LdQjuUXg8W1VHNXU8badzP7yZRUcGXmRgusPzRD3PM9bp7xXJhJTuUOrzUvVSY0BzbFNNa9XIbJFBUufJ6PPqGbhStvMj9LEmj8PJiAhsYV+vaM64mDSxvcRvUiL/jqACUhCNS8zgsAmJwiMR56VzPfXCaMAvf8WMpaivrCzXvn4h8HHUxPG8RZoffWEo8ob0xFDT8yEYKGgJphdE0JIyT3kFw1xPxVNj9Hd4rQ5vEYUV2d+GXhxCr+RGaeIlOm//BgX4ZcwLNDqXV0KXiqFj+wS+Watie+lU8mkwezVJxDew/pA4iLL3HRxsHRTlezwu6fEx3sXSQImoafsD1jjm4teN5/F0M+VimlTgvqem/YT7/XwXHFHvGYQyljs7eOirO49W1zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(136003)(39860400002)(396003)(86362001)(36756003)(66946007)(54906003)(66476007)(66556008)(8936002)(5660300002)(8676002)(478600001)(316002)(31696002)(16576012)(6916009)(26005)(4326008)(6486002)(83380400001)(53546011)(186003)(31686004)(16526019)(2616005)(6666004)(2906002)(956004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aDArMlNBcmdJclIyV2tRbE0zWHRHRDVRbUxuNExXTzRKdEVvUkNBME1VTjN3?=
 =?utf-8?B?d1cxelkwM05JRm5CU1FJZjZyNHZ6eDlGbGZOci9WUkZXYWxTUFRHelg4RHdX?=
 =?utf-8?B?Z0JqTm8xc0dpUSthcHhZN0ptWlhBV3R6UVp4VnNOMS84YVhUWjRUYzhiek9J?=
 =?utf-8?B?TVhkZXovL1lIak10b1ovOE5jR2hqbG5seEc1SDJFb3RkdURERExnb1dQaUp1?=
 =?utf-8?B?NGZwb1B5aWw2emhYcHJKZWp2SzgzcWJONzlzSllja2ZVODM3TXFSaWRZcytD?=
 =?utf-8?B?Tloza0VGVnpDVkMzanFNYWd4SkJpVzFQUXlWalJ6K2hpeFRmc3YzNFZXM0lI?=
 =?utf-8?B?b3VkUlUvK2JkdWxuRlJrbWcwK3Vkd21Tc1dtNmhGeG1SOUp5YWRlVVJFQXNK?=
 =?utf-8?B?RXJ3RForWUpvZkZjaC9HMVJGQVhvdHhhcndjYmQ5TXpzTkw2dlVPclExb2d2?=
 =?utf-8?B?VzRUSFkzSmZvdjFrRTRrcWVYN1BuaitzaWxDTnFRZTlpd3BSdGVscGgzcjRu?=
 =?utf-8?B?YVJkOVJRK0VGdHJOTGtKNUdYZk81REdYdWVLWHdIRm53VkhXK3U1MTZZZHlr?=
 =?utf-8?B?ZjdCNVBnTk5uUkFuSzhTSGNWei9hZEhKSnZFcC84VkN4Y3dDZllPcHdscDNh?=
 =?utf-8?B?eEpiemxoY29iWDNGZHVFaU5ySVZKeFRiWkJBb0Qvd3h3cUliNmhiVmlCem1J?=
 =?utf-8?B?RzhHVi8ydjVXK2xNLzlLSzBoVlpUWmU4TUdFSTV5YTVBYzc0d3N0K1VEWWRU?=
 =?utf-8?B?RGY3MkhCc2xHeHRRTjRjNGhXWXZDOXprZE1yaEhidzdISGdTUDdWZDJpS25l?=
 =?utf-8?B?eWNYNTc3SGdzb3JJUkZ6SWNTNms2NXAyRHZtQzlHemlrUXloY3B3N2lraFNB?=
 =?utf-8?B?VkM0T0h5bWowYk1zMGpSZ1VmOVo2TDhuaVBGU0VxVWk0QVFuWkYwOHIrSWtF?=
 =?utf-8?B?b0ZwKzBlRDh2Y0tqT3FXSlNremkyQnJ5VkZqcEg0V244RmtxclRJRFJMN1oy?=
 =?utf-8?B?NkdWNlNVNWRFd1FUZ2ZOYUxLNzlFRDFCZUsvdW5veG5wVXo2RHF1d2J6dWc0?=
 =?utf-8?B?d0kyWC9tc2tudUJtam9KdVRzQWsveWVOWGc2RHlKSTViZUJobkYxSkhUeFE1?=
 =?utf-8?B?WFFpWGQvVU91bTVhMzN2S3hjdDI2QUhaSTcyVWdqMEJvcGJ6T0xXZHY3Zkdl?=
 =?utf-8?B?MHl6aGtyd3pNa04zYWFacmtPRzZSY2V3T2VvYWhHWUFzNElsbmhYbks2QnVO?=
 =?utf-8?B?ZUxRUkxvUTBFeWJIT2RwakthMURmN2hGS2pDTWttMlovM1FKT3V0VmFFQWVt?=
 =?utf-8?B?bmNFWG1SclcybndNMWhsV1ozd3lMVTByKzhJb1kvZ2g1c3RscXZsMC9vc295?=
 =?utf-8?B?OE4vdHZPVndJdmcvZEswc3pHU3Y2NWxCWmE5MjBDOUNvblZxQVB2UllZNjgz?=
 =?utf-8?B?V2NLaG9sT3BwR1pOWjBtaWcwQ204K2JQWHR6YkdlMWNGc3pQZjBRazBtaU81?=
 =?utf-8?B?eVdxbnVXZXpnNHk4OUNyTkEvVmNISFdwanFFT2ZKVlB4QkUvRjBOUDVMRkVY?=
 =?utf-8?B?ZVp2QXlyZ2JCM1JPVUJ1d3JnalRNZlk4RStwckxWbW5WUTRqOHhVTTFCak90?=
 =?utf-8?B?QUtGSUdCbXNhZXdQcUxlTXZVZTIwSGVCVWlWTjQ1bkVhSzZ3cFRSVHhYb3FU?=
 =?utf-8?B?V3I4NVpTNjNTTm54L1JMODNaTkJzbkJ1dFljNkxFNmN2Y0tRNEJ2YitHUUUy?=
 =?utf-8?Q?AeqYvYenloPi7lHQbfjFHuHv8n0se+VEpu7SPjo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9f6042-71db-436c-e2e8-08d8ce75e7bf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 10:15:07.1200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skzuFjEcYMkpv/yfLRjTzxOSjwTwc8zvvx5LbB5Lr2p8wZ6A6jmiZyECeiWxyM9vSEGsva3wcMSh2uBJRbhFMHuBjDG4rvvvskuz8FUud6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4590
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110091
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110090
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/10/21 9:02 PM, Jason Gunthorpe wrote:
> On Fri, Feb 05, 2021 at 08:41:25PM +0000, Joao Martins wrote:
>> Rather than decrementing the head page refcount one by one, we
>> walk the page array and checking which belong to the same
>> compound_head. Later on we decrement the calculated amount
>> of references in a single write to the head page. To that
>> end switch to for_each_compound_head() does most of the work.
>>
>> set_page_dirty() needs no adjustment as it's a nop for
>> non-dirty head pages and it doesn't operate on tail pages.
>>
>> This considerably improves unpinning of pages with THP and
>> hugetlbfs:
>>
>> - THP
>> gup_test -t -m 16384 -r 10 [-L|-a] -S -n 512 -w
>> PIN_LONGTERM_BENCHMARK (put values): ~87.6k us -> ~23.2k us
>>
>> - 16G with 1G huge page size
>> gup_test -f /mnt/huge/file -m 16384 -r 10 [-L|-a] -S -n 512 -w
>> PIN_LONGTERM_BENCHMARK: (put values): ~87.6k us -> ~27.5k us
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>  mm/gup.c | 29 +++++++++++------------------
>>  1 file changed, 11 insertions(+), 18 deletions(-)
> 
> Looks fine
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
Thanks!

> I was wondering why this only touches the FOLL_PIN path, 

That's just because I was looking at pinning mostly.

> it would make
> sense to also use this same logic for release_pages()

Yeah, indeed -- any place tearing potentially consecutive sets of pages
are candidates.

> 
>         for (i = 0; i < nr; i++) {
>                 struct page *page = pages[i];
>                 page = compound_head(page);
>                 if (is_huge_zero_page(page))
>                         continue; 
> 
> Jason
> 
