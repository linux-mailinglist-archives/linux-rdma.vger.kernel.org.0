Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C86C310AC5
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 12:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhBEL7Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 06:59:16 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34704 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbhBEL5E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 06:57:04 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115BsOxK195252;
        Fri, 5 Feb 2021 11:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=1Jm2JQE+3y7/rNCr/P3uu9iGPRhA9UjgU3j1vXoz5Bo=;
 b=MjH+wfJLLIYnpj69mbgRhHnZFm1FmL3aGdwclkmggcMSHFbUKoQPCtyZ7U4zxX9sPQr1
 dGLjcEDS/6R/A/bTRN3ZGGSMmNLDuzSS+e/VffBiph3INRJni5WEs1E4TW0No9ZmvRD5
 uJs0Roo4PnXnMWl6/1Q/zxdwMTJpI4Drpvv1LFvyIBWJaT/YE+tyb8lB8w6Y8aFnnfCa
 mmMtcP7bico4yZO935vkS0jcXAlMjDsP1tbLexw6jBXfmTbs3Alpu56XoyZE6DKLd/Zx
 xY6Ua7acX82+X2/09p8HyKY3KUGkxoGG8L6lLqORUHJPSyUb4Jjje3ialJQn8zOTZJOs AA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 36cvyb9mss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 11:56:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115Bojx9100534;
        Fri, 5 Feb 2021 11:56:09 GMT
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2057.outbound.protection.outlook.com [104.47.37.57])
        by userp3030.oracle.com with ESMTP id 36dhd2tbrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 11:56:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iq/RvCk69KXiCmaKz8h7fI7oqph1wndeMykHmvs87ft4Whcp+dvykaNwA4/NR9krWhWgpkCawZGLas1MzbcbEjvikUiVIzsyAJscVCX3/HaYw/LtWqfs6zKN2Fb/H64st99+Y7srflY3HMZhBRwF/SnGGl27Wo4woeRD40xBx9Cgp5WYTti3ZObtQtd9s321DKAsrmaIqqETWxW1nEcegufrmLv9xB5jf7+F4Vpaah0fVuQf3M8YmeIxgIuB4DYHc8CfnQFdCXuCqV2jZb/pbQN8H8qrhHAM+ERWxbo3x084CqvA6r7zjyxfjPYR3coujjsOd68zHXtfR1QrJW8m/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Jm2JQE+3y7/rNCr/P3uu9iGPRhA9UjgU3j1vXoz5Bo=;
 b=NI29AeNlvURZ1rNuR2EcLA5xAPQWCholXIgqiP582DpA2tKrZ5dxrteRWHWYnCnzA1kWXTfQZPKoOL+CjAAo4XCH3DOMNlquR/neB3g8oceCe2vK5vRtzEOK+CuT9uh3rKn1E2lhb+reuUo6DoVtYJu4hr9Pgh1WKzUnHBIegelJ/6/cUb3u62TQ7pZWTvSTPynBZ4zCcd8C6Nljfe0PMUKgJAImG+IYmDe6SATLydbfQT6wrQOXnD7GqgITQBlqL/2jIJiMVaI8QsXK1Det5ORRkfTuhvYb0Cq34f3zk6LUEyfgKnfcU8wVv50rtFw7jhi+12KOGeAByaJJogF2WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Jm2JQE+3y7/rNCr/P3uu9iGPRhA9UjgU3j1vXoz5Bo=;
 b=gnpG0fhXXfuiWLfKwVL97vNrbF5FwoY0g94tOUTnlNDdJPSJjGA9vN01xIn3Cae4yZyDxCfwwHuPzzQewswNSpVqQHFetIbm64w5/dOSRBaAOII+g4o7mW8W946DgDDWqtpZjrY0tUQUPKaAeZl1AIALgvMro2p3Pj/rpFCgDlA=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB3592.namprd10.prod.outlook.com (2603:10b6:a03:11f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 5 Feb
 2021 11:56:07 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Fri, 5 Feb 2021
 11:56:07 +0000
Subject: Re: [PATCH v2 3/4] mm/gup: add a range variant of
 unpin_user_pages_dirty_lock()
To:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210204202500.26474-1-joao.m.martins@oracle.com>
 <20210204202500.26474-4-joao.m.martins@oracle.com>
 <6376e151-06fc-1e1b-0b30-1592972353ea@nvidia.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <3493bfba-c570-6630-62df-1bfd16be7156@oracle.com>
Date:   Fri, 5 Feb 2021 11:56:00 +0000
In-Reply-To: <6376e151-06fc-1e1b-0b30-1592972353ea@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0253.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::6) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO4P123CA0253.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:194::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Fri, 5 Feb 2021 11:56:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c95af1d3-4042-4062-5bd3-08d8c9cd05c4
X-MS-TrafficTypeDiagnostic: BYAPR10MB3592:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3592EC700060C396C32185D2BBB29@BYAPR10MB3592.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F8I0hf0bEtgXXN+cXMR9TCM5VPMprYojMfcLMTb3vg6mbktI5jn56BwT6BhdpDvolQ6rpBQuC9zn8k4S4FhRArhiuy/H6/nBPdktM6hLB6TmG+AdyKN2qeLu0pYhyBWi/eAgcyBx0Sfarue6gcAWNvnalFDegbsU6q1gM1naqHC4Axsk9o4CAABSo0rj9xVz7fQNOP8r2/3V1v1D+j3cChSodA0o/iJkHUi3PyGZz/NBRiKGkgo2NT2zYsirCcU26xWYnbuD9tZwYXN6TpZoiO0vpCiYK5xa7fihEqt5FffhDAaw23tVSbn11qgQ0RAapBZTMSwsPrIqBlcLAFklwn+JHQZIvpEGihGanWQIEYCXb1ZuaS7uFSw25eHWtu9BRg4Hgd92DOb27UVqQqZYWRTRwDRuZESKxFZZ+/EegVVIb3UPHtfCNLxu7SPR34J6DSzdPZbOHkDNrV/ZT5oLpZCkoDCFatQUKHv1Ny5D7nGdS9RHxLy0VZ71oVX+q4RqxOzO6kHteFY+k25L/FpSpAIUVwfyq/bYjLWcnPaW4IKgQQ9FNyml6BUoqF29miriIoX8yvwseUKtxbm7p+BneD76g6lsuXH6z1AOsfxIgb4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(376002)(366004)(346002)(2616005)(186003)(66556008)(316002)(6666004)(86362001)(31696002)(8936002)(53546011)(956004)(16526019)(66476007)(4326008)(66946007)(5660300002)(6486002)(16576012)(31686004)(83380400001)(478600001)(36756003)(26005)(54906003)(8676002)(2906002)(14143004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cTl0QUtxN25XdjBiMG04dWc3dldnS2gxZGxGN29SUFN2a0xMZHM5OVBGK2gy?=
 =?utf-8?B?SldoRkd0Q0loL0ovb2FQU3hOaCtPTGp0WUV5VVUvSURma3hQK0xNOXVwQ3Fx?=
 =?utf-8?B?eWV0VDQxb2szMmp4K0dFbktyTHFLL3BJZnVzN3BOVXUraHV4MGluRlk1YjFo?=
 =?utf-8?B?UnRHc1VrYkxIQ3ZXVi9LdjFDWkw3T2lwOXlFQ2dRU3VNVHlGcEhkSWNHL1NS?=
 =?utf-8?B?OGZRUDJJd2I5YnZBMmVydTltZkI1RHlhR21OSE04YXUyNWlDSmlMZGdXWGVF?=
 =?utf-8?B?WHRWVlFDOXhzem1Cd2xtbWFYZzR5VjJ2TmxPb250dDRmL3orZ0VPS2s4WHBN?=
 =?utf-8?B?a3g3WnRBTnl0ZUNPOTAxWmYybWd0OWFxYUdRWTdubXFYQXBVamlwSTYrdlhY?=
 =?utf-8?B?aW1ZQVhBNHYrREdQNDkxc0lZdCtkREVhcGJFYWM3a1N1M1o0ZTlJNEN5U2th?=
 =?utf-8?B?dmNVTHJ1aUhrS3JqZ01hZnZ2ZnlabzBkWS9EWTBmVGlJN0t5RnJYZUdqWVIv?=
 =?utf-8?B?dGJIQ2JPVzMrd09BREhTWUMxZ2MwbXFuYXh2Z25tN3FFMUk0cW00MXBrU00v?=
 =?utf-8?B?ZHNwVUFORWpUWXNIeG8wVjRvVHZTaGZRYWIzTytNK25FYkZUUFpXWlF1TkJD?=
 =?utf-8?B?dTh4T2FrR3ZPS1V2VStOUE12clUwNVdObVNCZ0YrN0ZSYmpvQTZkc2VRZ3Rl?=
 =?utf-8?B?Nnc1MHFpcS9Lc2lpMWE3WDJLMHoxZVlxc2xHbUZJc1V5a1p4M1pURFVHMU9h?=
 =?utf-8?B?ZEc5dnVST2hNVkp2SVpzTnRKdENUYlhGK1M3SXYrYTNVQzBDUENOcWoydGhZ?=
 =?utf-8?B?aDI4Z3dKUFU2RmoyL3FhMmNrcHNjQk5JUFdIVFRsaTgzWnp6K0lYWWt4bExm?=
 =?utf-8?B?eDVZVGZ4a3djMnZjbUlKTWJLWU5rN1NFc0tabzhqY2xvYi9KMHQ2allsZGFC?=
 =?utf-8?B?cHNZbExvSThVbDdtMEh0dlVSQmN5dWhGSGhoVG0wdjI1WFcwQmUwVFRUeUl2?=
 =?utf-8?B?RzE4MEs3TUNnTzFvRVNzTFdxcUY0dloyUGx2emgybUtFZ3dIYlpRYlN5cFdr?=
 =?utf-8?B?TTFHZWZ5VFVNbW04MWNSOXUrTFkwUEhoWmtzTGhYS2MwSUV6Qy9JYXozS1Ir?=
 =?utf-8?B?eml0eWVCc2lBc1c1UnNmaGRCQUhTSUtZSERtMUY2dVdmV1MyQ1FVMEhscE5T?=
 =?utf-8?B?M1FrR2FMc3dXbHU2Q1R2SlJwSUhCNENETnVtYUVobHE1b1RuWVpuVkRONDU3?=
 =?utf-8?B?SWg4Um1oQlhCenhrT1ZlSEptY0YwanA3MG5PUDUrS3dvVEU1bFlhNmZrUFZV?=
 =?utf-8?B?b0xpWXUrQk5oRTZLT0xJZlJQckRNd0trajB2cDRXMTVyamtHem9sWFFuTUV2?=
 =?utf-8?B?VWZNZG5KcTlFdjNwVml2anpoZHQ3WHExNjFuYnkzN3BLWldCbitNNVppK0FP?=
 =?utf-8?B?SXZYUGd3MmZkVmNzNkZLTG1zVUFRUWFLRkREc2hTRWZ6WXhLMVlLd09Id2d6?=
 =?utf-8?B?VFJDV1UzRkNhTndtNGFlVU1VM1cwdlJtdXA5TWM3VVE2OTJKUHpVa0l4a1Yz?=
 =?utf-8?B?NmpIQ3UwY2dNayt4MlFsUHltZC9jc0dNcVZSeWVsVmJVSk9rS1EzWGptb1hH?=
 =?utf-8?B?VlNtOUpPUlllYjJuRmJEZ01PSFdUK0p4RnN2SW5HMlpscFJhMFRaV2tOejFN?=
 =?utf-8?B?V1dXQUs0d1RFRTJIREVhTnZocUJHeWNWb2g5cm8vUVlXcG14M3hIeVROelNY?=
 =?utf-8?Q?DG5it3YrtAaRv0WKuFF9qUZYnLPJDu/IRlTQcC7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95af1d3-4042-4062-5bd3-08d8c9cd05c4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 11:56:07.6897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6WJM148OQ5vUQPmsMqUvbpCZDbPKnFRXPJz9pJBSm3WODOgDNbv+jQXdcS5BcYPZ8kgrjqyzvkb0LecLacPK7Xy6kt6VdaPzHONRyxl53g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3592
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050079
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050079
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/5/21 4:49 AM, John Hubbard wrote:
> On 2/4/21 12:24 PM, Joao Martins wrote:
>> Add a unpin_user_page_range_dirty_lock() API which takes a starting page
>> and how many consecutive pages we want to unpin and optionally dirty.
>>
>> Given that we won't be iterating on a list of changes, change
>> compound_next() to receive a bool, whether to calculate from the starting
> 
> Thankfully, that claim is stale and can now be removed from this commit
> description.
> 
Yes, I'll delete it.

>> page, or walk the page array. Finally add a separate iterator,
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
>>   mm/gup.c           | 64 ++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 66 insertions(+)
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
>> index 5a3dd235017a..3426736a01b2 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -215,6 +215,34 @@ void unpin_user_page(struct page *page)
>>   }
>>   EXPORT_SYMBOL(unpin_user_page);
>>   
>> +static inline void range_next(unsigned long i, unsigned long npages,
>> +			      struct page **list, struct page **head,
>> +			      unsigned int *ntails)
> 
> Would compound_range_next() be a better name?
> 
Yeah, will change to that instead. range_next() might actually get confused for operations
done on struct range *.

One other thing about my naming is that unpin_user_page_range_dirty_lock() is *huge*. But
it seems to adhere to the rest of unpin_* family of functions naming. Couldn't find a
better alternative :/

>> +{
>> +	struct page *next, *page;
>> +	unsigned int nr = 1;
>> +
>> +	if (i >= npages)
>> +		return;
>> +
>> +	npages -= i;

I will remove this @npages subtraction into the min_t() calculation as it's the only
placed that's used.

>> +	next = *list + i;
>> +
>> +	page = compound_head(next);
>> +	if (PageCompound(page) && compound_order(page) > 1)

I am not handling compound_order == 1 so will change to >= in the condition above.
@compound_nr is placed on the second page.

>> +		nr = min_t(unsigned int,
>> +			   page + compound_nr(page) - next, npages);
> 
> This pointer arithmetic will involve division. Which may be unnecessarily
> expensive, if there is a way to calculate this with indices instead of
> pointer arithmetic. I'm not sure if there is, off hand, but thought it
> worth mentioning because the point is sometimes overlooked.
> 
Sadly, can't think of :( hence had to adhere to what seems to be the pattern today.

Any conversion to PFNs (page_to_pfn) will do same said arithmetic, and
I don't think we can reliably use page_index (and even that is only available on the
head page).

>> +
>> +	*head = page;
>> +	*ntails = nr;
>> +}
>> +
>> +#define for_each_compound_range(__i, __list, __npages, __head, __ntails) \
>> +	for (__i = 0, \
>> +	     range_next(__i, __npages, __list, &(__head), &(__ntails)); \
>> +	     __i < __npages; __i += __ntails, \
>> +	     range_next(__i, __npages, __list, &(__head), &(__ntails)))
>> +
>>   static inline void compound_next(unsigned long i, unsigned long npages,
>>   				 struct page **list, struct page **head,
>>   				 unsigned int *ntails)
>> @@ -306,6 +334,42 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
>>   }
>>   EXPORT_SYMBOL(unpin_user_pages_dirty_lock);
>>   
>> +/**
>> + * unpin_user_page_range_dirty_lock() - release and optionally dirty
>> + * gup-pinned page range
>> + *
>> + * @page:  the starting page of a range maybe marked dirty, and definitely released.
>> + * @npages: number of consecutive pages to release.
>> + * @make_dirty: whether to mark the pages dirty
>> + *
>> + * "gup-pinned page range" refers to a range of pages that has had one of the
>> + * get_user_pages() variants called on that page.
>> + *
>> + * For the page ranges defined by [page .. page+npages], make that range (or
>> + * its head pages, if a compound page) dirty, if @make_dirty is true, and if the
>> + * page range was previously listed as clean.
>> + *
>> + * set_page_dirty_lock() is used internally. If instead, set_page_dirty() is
>> + * required, then the caller should a) verify that this is really correct,
>> + * because _lock() is usually required, and b) hand code it:
>> + * set_page_dirty_lock(), unpin_user_page().
>> + *
>> + */
>> +void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
>> +				      bool make_dirty)
>> +{
>> +	unsigned long index;
>> +	struct page *head;
>> +	unsigned int ntails;
>> +
>> +	for_each_compound_range(index, &page, npages, head, ntails) {
>> +		if (make_dirty && !PageDirty(head))
>> +			set_page_dirty_lock(head);
>> +		put_compound_head(head, ntails, FOLL_PIN);
>> +	}
>> +}
>> +EXPORT_SYMBOL(unpin_user_page_range_dirty_lock);
>> +
>>   /**
>>    * unpin_user_pages() - release an array of gup-pinned pages.
>>    * @pages:  array of pages to be marked dirty and released.
>>
> 
> Didn't spot any actual problems with how this works.

/me nods
