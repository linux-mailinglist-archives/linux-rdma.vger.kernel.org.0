Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1A730F26D
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 12:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbhBDLhQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 06:37:16 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38374 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbhBDLgA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Feb 2021 06:36:00 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114BZ0Gc122034;
        Thu, 4 Feb 2021 11:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=cakbKR0TcW+1Vx8NE8okKLeFZ0uy7Owo5vb2Y+8IIiE=;
 b=C20dALgi6YibhgtUfEgqrF7TmkABqHZfHFe1h5hrj4YRqFXCnH7/vn35lTOBWfPzdlzz
 5f+/ZZJn/G2gr9zilJ2JG6bwzlkputVbsj4OORQb9JjqducK+d2j69SRBxTStXb3tfGI
 z8njlEWjRMmDjMn7C2fcGXiK7ymhL6c/nadnnEMyPzXhp2w8I7DEsL6AGl+gOK7JogUB
 fssWBuxL5hDx7HmYfccFPV/SSIzvJNcpppthNvd4MX8fKp3y9GUVfcWuZnmVqYpJ16A+
 PfprCjKnvbD0KafbzWjNIFvuHkcsLEpgjDR/fRS6ipkv3jD08BoKV7CjfeFTfkjB78YC Zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36cydm4r67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 11:35:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114BZ67j187862;
        Thu, 4 Feb 2021 11:35:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3020.oracle.com with ESMTP id 36dhc2jedg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 11:35:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLcvh7QFDt7UMqUvFt74V2hC3h3Xt4oWVxlZE5qm5EPdZQTsg6SR+4klz0Y1+OaUbwbymm/dWaxwnp1PGAm3klPpPzc+3bvbFJs4A0JAA3gxsIG1PekpqJWxmfNie5KevXYQhy92lXEHmyWOk3s6FuaouIRzj1BLCqSevR3HHd6Ln+gDi2WZeG2jo2A4ZxlfuC/Ca1ruZ+MfyHoCUeRcFYt/Z4rs86Ljx52GQwIka4x9UnmTWhWdbPIG95TV718yrJI8ZtLXvhU7n8k6Uy4yWhUzsVfe60nfJei8Ic5yBq0LVe4muSdvMKHTShi2v2vPMkaM8LVYhBOpB0qgC994OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cakbKR0TcW+1Vx8NE8okKLeFZ0uy7Owo5vb2Y+8IIiE=;
 b=UL5xyZ8P6n1p2pQLHVq5FSmRhVWqfQJAkFuMCDBfMzyIZr4hdvjhVEBM29VfIGRXDY3s5ucbjvDCKb3uButdl2oK40rN9E/FJFcHYso6ZbhkoZlNcjcduyEJton3yzr01JyjAYkZZo1o1MpMCAmOSSh7VzDpOuxYdcLgdlk2ijFKRHmKA+tDAKX3eFEUsun2NPVs4tytH8nUtNAHvP0/DmU/gOKNdwt+PsXPAw/AZozHiXbhM7JpNTr4wQZJdCMGb+RGJXSLbeXASY2GvAgeCoOsHgSzejnNlozMr9XEHMhzcPmG/9vXu3Ltja0JgkRoXFz100njANObUECW0iOzqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cakbKR0TcW+1Vx8NE8okKLeFZ0uy7Owo5vb2Y+8IIiE=;
 b=AEW3Mv0LQDhmREcLGw9BviOwU2EXD7sjjaOpX7QJV5ygRcoDphQG8PGz1T1Mm8OAf5xbZue+sQEC9vLtvz2gTz/v/9ZEfvkAJ5eOVYNaOONNiTVo4Uw6p3iBKHe6cMHZReW7idXN6HRqkpPmc9g23k0TtTfZRmhy8XFVSlEIwXE=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB3591.namprd10.prod.outlook.com (2603:10b6:a03:124::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Thu, 4 Feb
 2021 11:35:09 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 11:35:09 +0000
Subject: Re: [PATCH 3/4] mm/gup: add a range variant of
 unpin_user_pages_dirty_lock()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
References: <20210203220025.8568-1-joao.m.martins@oracle.com>
 <20210203220025.8568-4-joao.m.martins@oracle.com>
 <5e372e25-7202-e0b6-0763-d267698db5b6@nvidia.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <99b410dd-5e18-92a7-9ddf-009a671c2894@oracle.com>
Date:   Thu, 4 Feb 2021 11:35:02 +0000
In-Reply-To: <5e372e25-7202-e0b6-0763-d267698db5b6@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0337.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::18) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO4P123CA0337.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18c::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Thu, 4 Feb 2021 11:35:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 986d13db-06a6-4e97-a3bc-08d8c900ed1e
X-MS-TrafficTypeDiagnostic: BYAPR10MB3591:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3591F7540CFA2C240E2FBEEEBBB39@BYAPR10MB3591.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BS69RwLcKxR4qmyOzmN5/zYPvPvltPoVR6djwFcSFPMgZPeM0qRVLpoAU7nGFDj8Hrov3OD1QbKXJaUVqKG2CvYX2R9Xw4AtEtpTYrr/D3ekMMzGJCpgax5kx8Fn8i6Xd0NFObRh7RbLQq+Rpet70IixktllToRq+qw8RHmVOBAM3mQK7fKerPqr2iPFztBqMb5WgGoORQYGEXABjp0XUgkNPDTzYDmVo5Is7ZVdYdsWIR6tRDnyCxVxT27M4x4HwfdpDCMXwbNJrzIEq0fDLi18Nu7hmWDFJldBiwTltvdIC9OlEyk/02qXngzAEIomb6AZWWltIdl1l/E/Si64f9I/jJGtuNVJEdYj/ka3kz1a2vFwZvjOdYcHGgDboynesOyotnuDM2lDsYhK3vUebrj9icX0U5uTYq331I5ULJ0nt8Jf0Nw3TNPQgeBKuplOOttOl5Ceso9ru0idw9pSwrKtRDa8KVplDm5F6vMVViwoc0VuMEBIA1js/qb3ZQwflyq6UMtEtkbiqr0jEAib4VdPf14kFCNjeoBkCDr06XG4Q7VKrJGoR+ViHloIisFoA4D/vzUCDM7H27Hx/iarHlagAAvDQZk4zJmlCLfJCoQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(366004)(376002)(136003)(54906003)(6916009)(66476007)(4326008)(86362001)(6486002)(5660300002)(316002)(2616005)(26005)(16526019)(956004)(478600001)(53546011)(31696002)(8936002)(36756003)(186003)(83380400001)(8676002)(2906002)(66556008)(16576012)(6666004)(31686004)(66946007)(14143004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d0VESTByQ1BoU29FcmpVdGVQN0s2dWw4eFFsN1NMRjFMcTRrV0crTlhVOHhk?=
 =?utf-8?B?a05TT0MybmJiVzRkQ3B6ellYMUdQZFcyZW5qLyswNnRDcVhXSTNBNGVWSFla?=
 =?utf-8?B?K005VlpNa3BGRHhlY2NsTTVucEViQlJNTGxacVhHV0g1Y0I1OEMzRzBQS1RV?=
 =?utf-8?B?akdFakgwMmhnRFJ4YVZCaDAxdnQrRXI0YWhYN3NJNGsrdnVkbWc3RmVwWjZv?=
 =?utf-8?B?RFRZK05Cd29selk5L2pKUHdCOElreHUvYnNNc3RrdFBZeVZFQXFuMmY1NmZC?=
 =?utf-8?B?UzMwcUl6M3E5aUsyaVlXaHJ5Q3g0UUFNWjIyNzVwRUY3Q0dCYWdPbnpzSVUx?=
 =?utf-8?B?a3oxWis4dFVUd3VkMitKOTltbzJuNzRBLzMvUmU1RngxNjFJelJrWndFTjUw?=
 =?utf-8?B?a0wxTVlnRFlid1dzYmpCd1QxUzV6TUUxdE1qTFdXbXNZSHdxelQ5K0hXbEVO?=
 =?utf-8?B?dVlEcDl2NjNHdHhvZzNYL0hYNmZ4ZDAxSncvVEx1ZFpuOXRkYUxJaFZ1RWov?=
 =?utf-8?B?WVFibHl5dVVHQ2hnY08xSzluOGtNbkxHYWRPNGpmRVNEaVFxY0tHcHd5RFRZ?=
 =?utf-8?B?Y1cvRG1Sb2xULzlDUWtJNDBpdnQyeFp1aXBqN1pPc2VETUJSNEV0OS9acTN4?=
 =?utf-8?B?TlRHRkNycUlvNGh0U2NHMWV6MlZxYXcwUzFpK0tyRGhkR1VlNitud2U4eFh2?=
 =?utf-8?B?V1E0a01WenZtRVNIWngzV0VoVDJEbEN2ZVBFY2hiYU9ZeTZmcVE5cElSL3lT?=
 =?utf-8?B?bWtabnlTTDJnZGdNY2VKZW1aak9WWXAyeDRqL3lid05GaVllQnc2ZTVZL3lM?=
 =?utf-8?B?bDRHUEFSQzZmWFgxZDB2N29Rd290c29CT2RoWC82WU9GNUJtQzFKUXlxcWdG?=
 =?utf-8?B?OS9PRkFtWU5TM09VQVNFQWpnTE9CcXJXNzJjK3J0Uy9zRm1JTTE3dlFZNVM0?=
 =?utf-8?B?K1JwdWNTMUVPUm1pVGVsU1RmSHpVSU1VcnVkejBLSk9qeUV1MmQrbVFwTWpq?=
 =?utf-8?B?Tk91NnlTZ2w5SGthczNlY05HMURRMHVoLytka1dMczdmU2tpQ3Nmb2JkMkV2?=
 =?utf-8?B?dVgvL3RFaitsVndFR2tabjYzeWtSeVRjSUUyMGZsaWhmTENLbmpDak9sWWp1?=
 =?utf-8?B?b1kwdkNKSjloVjgyb21zUHVsTEMvM21lM2M4QVc5Q1RVOElHa3R5NzJkM3JI?=
 =?utf-8?B?WjR4TzAvcERGSmZMengrSkNXWS80bkxTWjVyYW9kL29qbVdSS0NpT3BBNkJ5?=
 =?utf-8?B?dmt4NXNVZXdBcE1zN2xpY0xvTld3aDY5MGtVZGhMQ2lUa0krZSt5V3g3RlZU?=
 =?utf-8?B?c012MmtoekhnZzJUSzhqcjFXemxYNzZ2R1JRamt3TVNrekxBVjZmVktYWmtJ?=
 =?utf-8?B?UnNTL0FPSWIrNzYvOWg2eXk2R0tVeWgzcHJnVDlKRjVKNGZqRGpxSFJncnlU?=
 =?utf-8?Q?6ALcwPDV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 986d13db-06a6-4e97-a3bc-08d8c900ed1e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 11:35:08.9355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgv2fng7mLk2a5vcicyIV5ZkJ67NeHxgeQdQSug0MkGmlzKK20LeFe/dgQNaT2YzuDG/mWz2S6XZEoJZ7QF1SNmeQRPx/BSqQvjM6lizXZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3591
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040073
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040073
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/3/21 11:37 PM, John Hubbard wrote:
> On 2/3/21 2:00 PM, Joao Martins wrote:
>> Add a unpin_user_page_range() API which takes a starting page
>> and how many consecutive pages we want to dirty.
>>
>> Given that we won't be iterating on a list of changes, change
>> compound_next() to receive a bool, whether to calculate from the starting
>> page, or walk the page array. Finally add a separate iterator,
> 
> A bool arg is sometimes, but not always, a hint that you really just want
> a separate set of routines. Below...
> 
Yes.

I was definitely wrestling back and forth a lot about having separate routines for two
different iterators helpers i.e. compound_next_head()or having it all merged into one
compound_next() / count_ntails().

>> for_each_compound_range() that just operate in page ranges as opposed
>> to page array.
>>
>> For users (like RDMA mr_dereg) where each sg represents a
>> contiguous set of pages, we're able to more efficiently unpin
>> pages without having to supply an array of pages much of what
>> happens today with unpin_user_pages().
>>
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   include/linux/mm.h |  2 ++
>>   mm/gup.c           | 48 ++++++++++++++++++++++++++++++++++++++--------
>>   2 files changed, 42 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index a608feb0d42e..b76063f7f18a 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1265,6 +1265,8 @@ static inline void put_page(struct page *page)
>>   void unpin_user_page(struct page *page);
>>   void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
>>   				 bool make_dirty);
>> +void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
>> +				      bool make_dirty);
>>   void unpin_user_pages(struct page **pages, unsigned long npages);
>>   
>>   /**
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 971a24b4b73f..1b57355d5033 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -215,11 +215,16 @@ void unpin_user_page(struct page *page)
>>   }
>>   EXPORT_SYMBOL(unpin_user_page);
>>   
>> -static inline unsigned int count_ntails(struct page **pages, unsigned long npages)
>> +static inline unsigned int count_ntails(struct page **pages,
>> +					unsigned long npages, bool range)
>>   {
>> -	struct page *head = compound_head(pages[0]);
>> +	struct page *page = pages[0], *head = compound_head(page);
>>   	unsigned int ntails;
>>   
>> +	if (range)
>> +		return (!PageCompound(head) || compound_order(head) <= 1) ? 1 :
>> +		   min_t(unsigned int, (head + compound_nr(head) - page), npages);
> 
> Here, you clearly should use a separate set of _range routines. Because you're basically
> creating two different routines here! Keep it simple.
> 
> Once you're in a separate routine, you might feel more comfortable expanding that to
> a more readable form, too:
> 
> 	if (!PageCompound(head) || compound_order(head) <= 1)
> 		return 1;
> 
> 	return min_t(unsigned int, (head + compound_nr(head) - page), npages);
> 
Yes.

Let me also try instead to put move everything into two sole iterator helper routines,
compound_next() and compound_next_range(), and thus get rid of this count_ntails(). It
should also help in removing a compound_head() call which should save cycles.

	Joao
