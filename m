Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC093188C1
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Feb 2021 11:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhBKKzW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Feb 2021 05:55:22 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45700 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhBKKxF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Feb 2021 05:53:05 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BAnWgC103427;
        Thu, 11 Feb 2021 10:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=SH8On5v4wjAxzI4OncUMpL1AfPWrh5OY/VpmwA55gXw=;
 b=pg5sWYD9WKKawSqFys0qbvdOiylabBHhKDnaXIB9RXnQTau6nyoF2dXDHAPa7y9vRomt
 iGZ5iFBl7DORZ7cMipLGzhVGIF7Akgm7+4LtF01m8c26+2RzQ5y7xllIMjuIQycGgT4i
 wJHmoTAjZHhV0szUbQtbGJfvSpO/Lt5gzA8bbi1UBWBVOFqYu9l5Fcxwu0ndEdtFKUoZ
 3wU1IwdaXxvRwct8eZmLO4xsJq96nLpiAcUWJ0/+wkEg0rafETjdZvjq8Pq1Acq7YHlh
 K+zFTlK5OdMeOB0md+ivigEA3Ap5KK4iYkZ7jOKRi/fd72ecIEkVVBAcsAlOSp3vFWBU RA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36m4upwheg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 10:52:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BAp8Bf112013;
        Thu, 11 Feb 2021 10:52:11 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2059.outbound.protection.outlook.com [104.47.36.59])
        by userp3030.oracle.com with ESMTP id 36j51yv1v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 10:52:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJwZIe1HLEwzML8/yqdEMPmkFzMmiEHbgJAylqLyDwB5OJEsyQSDSWOtwudOnnAJT27DZV1KmNEeju5gs3FrTTb3Q3ev0mpjgW/ptQkGtQne/b2wr3lML0D5CRMzbidJAOaJDfBraHeN3fT+pKWvZrLHyjXT+KJKCU0u0f87+ffkYGFm15XO1DYHpCgBmwWmPra6HKpVRql/a8SB9137pynFiCJOyRF5TTLXYeCxKV51ZUItkzzA/2R6nu8YQVowflYuPTjUWyDAjglXAlXCtYp4rfJHOcFks4d/IH8aVlT3HWm9nqYkhShX52AYtsfTWWvKCSVH+SqEL67q8TkS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SH8On5v4wjAxzI4OncUMpL1AfPWrh5OY/VpmwA55gXw=;
 b=cpadJzMkM/uRuSRygJc7CR/oKcTN58LqyENnCcopd0wQFjQWkOQlovAl920RapbP+qi2udRiQD91KvkXAIcP7qiwJm098P6I9EzyHr7TPqOp6kADgGY21rSPLsRPwRfCp5+6ENbCC6c/uo7NDMgqZJDlsu/bIgZZVIxe9zppJtcLWy/7XN/HbmATi6qq9JLDceSmNit7VITqf5CGF3gwQgI4G7cdU+B/t6/2NBI6v3uNaVvy2sB1Dyy9IPamYybhDsfzkws5ZZDcpZdfXSCI3ymUJymmC3T8Ovwv/L3nuVE9tG43ZlQB7HY/XxN1GQDX2D7OSMYu45hyG0gz+2twXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SH8On5v4wjAxzI4OncUMpL1AfPWrh5OY/VpmwA55gXw=;
 b=f44QwyRm7DowptFdW/17Xa5u6HW3108cpxNRGIXM+BRrQ2Az3DGH0l5j/C1834LV58WqBD73ENhZX4kJ9oXYE8untiRLu1sbxf3LMiWLg8fGjMf+IuZ56+K9QfnzJ4c5hRT7tAQg7n2SXrATnTrwclKReHHBP8ZoqXDtVpHoSHQ=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by SJ0PR10MB4512.namprd10.prod.outlook.com (2603:10b6:a03:2dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Thu, 11 Feb
 2021 10:52:10 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3825.030; Thu, 11 Feb 2021
 10:52:10 +0000
Subject: Re: [PATCH v3 3/4] mm/gup: add a range variant of
 unpin_user_pages_dirty_lock()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
References: <20210205204127.29441-1-joao.m.martins@oracle.com>
 <20210205204127.29441-4-joao.m.martins@oracle.com>
 <6ce67c15-3bb3-3ccb-3c45-edb0efb3a38f@nvidia.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <a457c04d-8e54-eb42-d08b-935cbc7c6448@oracle.com>
Date:   Thu, 11 Feb 2021 10:52:03 +0000
In-Reply-To: <6ce67c15-3bb3-3ccb-3c45-edb0efb3a38f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0386.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::13) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO4P123CA0386.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18f::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Thu, 11 Feb 2021 10:52:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66608f9c-ac47-45a3-6103-08d8ce7b14c7
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4512:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4512A01E89EDC90F692C8795BB8C9@SJ0PR10MB4512.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r4XCTIwYAYyl/mRINQ9o0ORRgVgTYOLcRsaE9+wcqQvKMkXYmdNdq00h28V5gHohWwnXYHuaZ2fvLctDSJ2AQFkF23AJHR8zjudw6n0VtVKQYMkDHF2xmGG9tkiHimJCJiMslnABlc9G4S5gkWyJ2xzltdaqd3vDEcAnYGAV/VwsTmW+ZVEg6bX0wLmhqvLUPCuHq9z1iPg8C3yu8bbT411xVnQfzpSHv4AAPMPnFLFibtuv/Ya181GjLjUSD2qjTlfzziOAyzDqTMw93zG1zOPnEURk1rMmHVzmkrkfE3VHZYqCi2FW6EOZzu4viIoK4Gz/7UprijerfX15mGB40FIJ2fEhNtNgjoW2vgyRm5dJT5iPcbSASygvlJL0fQSvtLjuI0A6KQLwsfjA+3lmF7Vy31oY1jru1HK0nlV0yF34/PJ8ZRFYvRF7IL/4twP4Abj+JwHIKhyxgFjZjkJ7GGU+fdCFCUWd8pP8MeYjpNob0vptnGaeR0LemHd6Uy4Uzrxe/Nan7HmLOsxZukyxqlbsmcvoX3kql1aMaLBkWuVN39Tq3mQv4285wC1vQIzwKaCX3sLByiBBVNfw3RM5A71rmUXw27clB0OVWaPcbXI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(396003)(346002)(39860400002)(4326008)(478600001)(36756003)(66946007)(31686004)(53546011)(83380400001)(86362001)(186003)(16526019)(26005)(6666004)(8936002)(8676002)(31696002)(66556008)(66476007)(2906002)(6916009)(956004)(2616005)(316002)(16576012)(6486002)(54906003)(5660300002)(14143004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?djdaNFdld0N3SUFyZkpoa1dLN0pZMjVERXpFbmhYcXdqOGU0NU0yZTBYMWh3?=
 =?utf-8?B?dzRMVzh0S2c0ajRkWnJVN0dTR1F3S1pZNDZsQllKbTF3RlVJSm1ybXRqdGk1?=
 =?utf-8?B?c0JMRVhHbHFUMWJidXJOamVFV3hhamVaa0xqZ1R1T0o5L2wyZ0V5MmNMYVRT?=
 =?utf-8?B?UTdPd0Erd3UxMGVML2I2MEc5dy9WTTRRQzc3SjgyOWNqRWJ6cUMxSFZybXNC?=
 =?utf-8?B?bHZSdCtFN3BQR2RGRDdsTzc1dVJzK3VZR0FIWlhGTDJtNWl4ck8wSFIyVG5O?=
 =?utf-8?B?UlBVbVkxZXZBbnVIRjNsM2tTcy9NZHdoTHdlRnk0c21ZcHBxK0lTU0tDdzd6?=
 =?utf-8?B?dmtTZ0FEaEg1bzA0Tkg5Q1RKUEJwMjd6ZmxIaXFPVWhpZFd3c3NicnJSYXhD?=
 =?utf-8?B?ZzZxUEZtdUk2aE1SdCsvWXRDaSsrMzVJUTdnVE8vbFl1Rnp6WnVycE0vNzQ4?=
 =?utf-8?B?eEhWaHhsYnY1WjJxa0tqSDNZWktOT3M0ZXVOTUlRWEdqTjJreW1oODV1MGkz?=
 =?utf-8?B?RDRtRTJWdkJEejJxaFhpMmtFdVBmdHBSQnJwSTlGdkJVdnRYZ0MxSzRVZXls?=
 =?utf-8?B?VHBKSmVPY3BEOVVDdkJIcUJNWFp1L01YeThoRkpjVXZlR0JoNFVQK1FCYmQy?=
 =?utf-8?B?WkhCQWU2aWpMNy9SOG9WYmNtUFJVZWQ5WTVkN255VEhxOERCNGVpL1l2M0lV?=
 =?utf-8?B?N0s0WU13cXhGbTNxd0I0QXBidDFnUDNDY01sZGw4c0RDUmZnWGZDUlpZY1Vw?=
 =?utf-8?B?MHlnWkhXdzFIQkpidUhidDNRWHlqUXBCb2VaQzBqeGZDN25TT2k3alcxVlly?=
 =?utf-8?B?SzVCZkxSMHlDOTZnbEtlWjJPY0pVdXdZeHp1Nzg2dWkvMEtnY096Z01FaFBs?=
 =?utf-8?B?Z3htNHl4RGFBby85czFseTdpUFVwSzQvWVZRWklTdkVDSDMrODJqUTY4T0VQ?=
 =?utf-8?B?WXBpc2MzUktlcFg3aXp4dEcrcVNoZE92WEl2UVJLL0pjNS91TzZaSmg3Uzlz?=
 =?utf-8?B?ZXdqbUU0dTVQV1ZOVmRuZE14ZUxJVW40b21KSk84SnF1eHBUQUVCUmpYRFdC?=
 =?utf-8?B?aFNzTnNCeWtNM2w1NnBWVWhiRlE1MWt3OUtrdmNwaFJiZnJNTGZaYUxqcllY?=
 =?utf-8?B?ZUo1YTZ0bzFUeitJQ2xCUDFmeXp0MGR2RUMwaXRuODIrcG5pb0VEUFVldElv?=
 =?utf-8?B?di9YVkNTZ3lJMzgxYmN3UWN4Z2FuenhrTEd2cXlmNUNrUnJLZk1yb255K2NL?=
 =?utf-8?B?Yncvanlzb1d5UTNrU0lLZTAvYUpkdXBBSHl4NjEvVzdkTmUrakgxR3JGc2xF?=
 =?utf-8?B?V3dEMFlRZXFrazlucUtKTWRQWlM2K2kyYlN5K2h5b0dlNXpQbDU2RGhxSzdi?=
 =?utf-8?B?TWFxeE55MWo4bUtsUG01ekEwNm1pOEVmSFVzNUZzbis3QUhEdlBLT21SVktD?=
 =?utf-8?B?bTVKMUkzT21SN3FBeFlyTmsrTm5RNUo2NHRlRzF6aC9KZDBvNnZKejgwVThs?=
 =?utf-8?B?ME1kU1VWTE0vOUJQUkZrcGRIb3JCR2pGYmNCa0FieWVLYlVTQkNWOFdzcUxo?=
 =?utf-8?B?TjRocUJzQ2FNUnlzaGpDYXlyMmlEZmtmc2NlQUtMK0pLQnJBVG05YTZiVHRZ?=
 =?utf-8?B?ZStVUEpWOCtJNUlpbXVPcURXK2o0ZmlGWUpDWUduMVN0Zld0cGxMSVYxU0tV?=
 =?utf-8?B?Y0w0bUl1eTdvelBxRzV6YklSTFlibG5UQzBscnhCR0M5OXU2aG9DNTR2akoz?=
 =?utf-8?Q?WQ5OwIE92m9KiXIzqXH7jn2dxmad463n0Tk4GOI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66608f9c-ac47-45a3-6103-08d8ce7b14c7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 10:52:09.9604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7M4VPoK7E5iYDLj/5KR92c+y+UHgldYPHcmBHn8V+hXpRlklSbfCD7UiETdmrIi05UBaBIkCIUZCzZGxdE5CYnHwceCdUqVmXAjV6CYft3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4512
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110097
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110097
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/10/21 11:19 PM, John Hubbard wrote:
> On 2/5/21 12:41 PM, Joao Martins wrote:
>> Add a unpin_user_page_range_dirty_lock() API which takes a starting page
>> and how many consecutive pages we want to unpin and optionally dirty.
>>
>> To that end, define another iterator for_each_compound_range()
>> that operates in page ranges as opposed to page array.
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
>>   mm/gup.c           | 62 ++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 64 insertions(+)
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
>> index 467a11df216d..938964d31494 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -215,6 +215,32 @@ void unpin_user_page(struct page *page)
>>   }
>>   EXPORT_SYMBOL(unpin_user_page);
>>   
>> +static inline void compound_range_next(unsigned long i, unsigned long npages,
>> +				       struct page **list, struct page **head,
>> +				       unsigned int *ntails)
> 
> Yes, the new names look good, and I have failed to find any logic errors, so:
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> 

Thanks again for all the input!
