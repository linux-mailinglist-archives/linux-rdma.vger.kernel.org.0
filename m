Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C2C31097D
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 11:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhBEKtg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 05:49:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40386 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhBEKrY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 05:47:24 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115Ad6Kq194879;
        Fri, 5 Feb 2021 10:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=aAsO89c7ulTcpFANCNy2WSkUjdul+CTitEXHfMfFwrg=;
 b=D2OEtBC16VLtDVmOkh60VOCTjH1ZQG2gc5BICDRyQY/iISM3qX9VWFW3dKZQlLJMyHLl
 7CBk8SqDD1a8K/8qmKkSUyzOsrufQ3iv7NyIvyAXCrL05DFl0juxmBqAwngCmxkLItI6
 DPEXbuQPsU7Ho5cvgMf2My3hLciH4FsclggSUE0GT7pNhZPmRq5AOzBbQNQ9LXraCwqm
 7RzQ6e6X/bGQeqXPz8E6q7NVJh0R2Cf+mWWP+eA+Pnr1DuvD8/MeMUJeKgMvrXiVCFrZ
 8ua7nC0Kr9cWrthq0VtLB7h4PzH+/CVHzlFvxL84KpIjGdDhcrs7AGI+7DT9SYp4lqbG Xw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36cydm9903-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 10:46:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115Aeiwu089355;
        Fri, 5 Feb 2021 10:46:24 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by userp3030.oracle.com with ESMTP id 36dhd2r40r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 10:46:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbHVDt7iSOJCPQ4kkInkvnghIBAYCEJuL4oV+k7wr5zy7BhhqRmW3p7qIud0mJQii9KuP4DmXXMueTqhyA99nuaoISYDLQDDyx2Yi3L6Iyfmk83NuwppzqUykbqJU8rAFL+zLB6+FnXhL7WQ1L2CNDM92qfzxGnCRk5c3gen+o510nth+jZ0dwjFsM79g8N94l2HfMeVFYIMK9DKPFhktf6++CFpmT5IdFEuOEWGPdUJjJKTKIcoyZdD0wv6ZavTBU3g5gdK+/aKRHP1fX6yQQz0a5VW5bc9irXevYnAi4ZZINgYZCle381iIXlmHI0gOUNwqe0IIPvt+3IztFgyoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAsO89c7ulTcpFANCNy2WSkUjdul+CTitEXHfMfFwrg=;
 b=kAvID3O7FFPdd5pveM9NKcOI8axkgPN1S7p9jUaNAaE61NBFG6mVZRuUEzbij/Si7VMWt9iL52JG5vlBGVwsDCpveFdVQgRfw0LLdA+K6m1nqrsJ5FxHd/I2c3/jW++Fy53sQbavibmOeKv2KGG30T1atagZZBTfv7e8Qn2Bx5hKx190er3Hj3nlg7joSDEanpunubS+hnPbJNkxiUCl0oKkOMlZYMVhd5JHvk260nlULPWVHGd4sX/arfpx6D4/bfnfGnFWBJKH3MZ8jsAxls01qNDKHy8voCBTlvU4kzv41NJWHgeh44wReseZ/2JRkI7EUf6lGS45e1sja1BmKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAsO89c7ulTcpFANCNy2WSkUjdul+CTitEXHfMfFwrg=;
 b=f+ra+rGOWGaKkCGigCF0s4eb4lyqclbiZ2nCodTsTAbIi5H+CZJhMOBboQK8h1ui8Mm6R5W+C4XnPJqezXSvfXJa5wKMmAEsxptYrJGH029wMcZWDPpaM8K+B9qQMiykEfSuzYHXJD5Gl1k0bqa8LLUL7wy6VHBD1LlOznn1XS0=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BY5PR10MB4353.namprd10.prod.outlook.com (2603:10b6:a03:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 5 Feb
 2021 10:46:22 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Fri, 5 Feb 2021
 10:46:22 +0000
Subject: Re: [PATCH v2 1/4] mm/gup: add compound page list iterator
To:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210204202500.26474-1-joao.m.martins@oracle.com>
 <20210204202500.26474-2-joao.m.martins@oracle.com>
 <74edd971-a80c-78b6-7ab2-5c1f6ba4ade9@nvidia.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <c274a794-94c8-3bd1-0b9d-670212279e52@oracle.com>
Date:   Fri, 5 Feb 2021 10:46:14 +0000
In-Reply-To: <74edd971-a80c-78b6-7ab2-5c1f6ba4ade9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0483.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::8) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO2P265CA0483.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13a::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Fri, 5 Feb 2021 10:46:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1d09913-2199-43ad-9d4c-08d8c9c34721
X-MS-TrafficTypeDiagnostic: BY5PR10MB4353:
X-Microsoft-Antispam-PRVS: <BY5PR10MB43534EFB6CEDF3029E22C6FFBBB29@BY5PR10MB4353.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rU2XlgQ/lcWZHkjPixnBO54uVl/3mL6HEhsdBgWc6mtaGCGrRZjPCpQV2BzMejJ3m02aDPjOPYWB0X6OYLOGB57UcE3WzprhTI9RUfcBPKWHKPtLU5SzjxvvTeFwbn6rW8FdNMFmMRLpNtLjuIXELtHkd2OPN5cqE/5DZCplXsiDlxaxBzQi9YP0MuQlk9LdlU5lNEK5a1I22392S98ZLSdNrbIQynV4dRC4RXjy1nNddPNRUcypi1f5nMTajHFHHq3VSr6An0IQxuuOXcltAFND011a8pVUi6UWpfcCZ9qOXN574/R4ogmFaS8lKIlsYyG/ULT4Bl4R3GUiUsyUDkLMuMcXfiVej+pXc7eCWF2Moa9RJ3fhDJS1sqT53bgGkByL1KMc+5bfxafF5d79Ghc95ypzF1bk64Ym7T0SVOnftVUjJr7CCuc+4WOtL59yST8PFDO8+Bd5KAiVmUzi3kM0mqWl6UrbsQ29/hBO8965jqm2Y3fZ3JXnDfNTR92ze0MD0GecqAwOtbAmpi4cXyroCssLJJYZFJMwETrpXKr6f1wN9j9cbvVwo9N/JRsdliPeHMNY6q8W6BGSikUjag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39860400002)(366004)(396003)(66556008)(66476007)(6486002)(186003)(8936002)(66946007)(26005)(316002)(5660300002)(4326008)(478600001)(31686004)(83380400001)(31696002)(16576012)(6666004)(54906003)(86362001)(8676002)(956004)(36756003)(2906002)(53546011)(2616005)(16526019)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UTRjcTRwbWxJWFFha3k1MDRjemRNTTJBdjBiS292ZUpXNWVpTk9FU1MrQS9y?=
 =?utf-8?B?OUF2akx0cmxvVjJVck5nancwNFprVXNMeFMzb3dHRzhGcndQSkNTemRUOThj?=
 =?utf-8?B?Tnh0cExTSWhYaUJvTEZnU0RiRklXK25SbStzeG84cHhZak9oSUtBb3JHMWF3?=
 =?utf-8?B?bERMTHpwV1VsczAwd2JrT3Z4R3hYYVh3M0xQOXhsOXkzYUxiZFNvZjF2enFa?=
 =?utf-8?B?TFJqY3hyUC9Ba1V1a1JaNll5ZlYzOGtrdmUxd2FTZEFuOC91dHYrSGMzdURP?=
 =?utf-8?B?V1BiS1lQWFdpZ3IzdWthVkRDSjNsaXUrZGtDVS9pSmM5ZVAyOVJ2aHBKUzd1?=
 =?utf-8?B?aVZHWEhSTGliU2xYRWY0ZjNxSCtydStCWjBkcUVYaFplY3V6Tms1VitNbEg2?=
 =?utf-8?B?OVNGRllxeEhZTWh1ZjY2bzJtYnFleDBFOEZRS3BNNnN2ZlB2RmVtcTN0L3BC?=
 =?utf-8?B?ZkEveUlWQzFwNjNyS1ZBOXJqVXljY0trMmhxamZxcS9IWVN1aWxSanNVeHZ4?=
 =?utf-8?B?TE53ZzN1bXhveUxBMGFKSmU3UWZQamRlZ0JRV0FVQlROMFRLRTVxMjJPdmxu?=
 =?utf-8?B?d1pidFk1a3djakxRcWJZdTduNnA3VjFUOERaeFBLVlhOK2VYdmdpYmg0UURS?=
 =?utf-8?B?OUZYdjA4aS8vNGxGUE5ETGZSUmkreWZhT2hqeng5VC81bE9IV3hEdnJlM2ln?=
 =?utf-8?B?UGVtWUwzc1h5K254U29wbFVZb2ZwWWVTVU56aVJrczdNNnNYNWpaOHNDUElM?=
 =?utf-8?B?MWErbHRmK1Vsd0NXVWN1aEFBRFVHMzNmSTJQMnNJcDJQbXFoMWhNdS9CZmVZ?=
 =?utf-8?B?ZVJRTk51Z1BnblNOVldmaFZPOFJKTTcvTmdlTVlQbDBZUTBlcUl4RFl3YTda?=
 =?utf-8?B?K0xUZ2NEWTQyN1ZTU0oyaGtXSUszOXdzY0FTWUdmbTZrVlBlUUl1bTBNRnJK?=
 =?utf-8?B?dHpGZG4rUVhPdlp1RHVpTTNnbkxzaWgrVXl1N1RFTVJQQXZYWXh0S0thVCtX?=
 =?utf-8?B?NW84MjAxSW55b3lrVkhhZkZPODZjUENBVTdla2Q2SVlmelhkbU1ndnB0U3F1?=
 =?utf-8?B?dTBwRFQ4YWZDVUQ4dnlvUmN1UnhlMXFwZWhSWkFPUFF6TE9RNXZidUZUbU9v?=
 =?utf-8?B?TjI1MnphUFlLanN5cUs5Y2UvLytpRzhOa1Z5UUYwcWRBN1JxMGtORStiSk5p?=
 =?utf-8?B?VDRJSGwwNUFFRkEyOE5MVXJCOFNjU0FqWWM3NUtoeTYyMXpVaWIrWjNMY0xX?=
 =?utf-8?B?N3N5dHFubEMyZnpwRXNBQ2xIVlVGT3RGVDF0eDd6SGRvbVdzRE5FN0FYMnhR?=
 =?utf-8?B?bzdxeEpLaVZwYVdLUWVKL0Npbm9vZDNLSFVGOHFnNzBSVzAvRnJ4Y0ZBRFhx?=
 =?utf-8?B?eVB6SmR4d0t3ZGx3aXVML0xuWk5BNk9HdkM1M1pKakZGM3RLWE4zem1raDB6?=
 =?utf-8?B?Q2pjVGRaQmRDZlpBTW9kZGo1VWZPcWZ3Tjd5dmdmTzF0MkVQR2ZhRGZ4VW9K?=
 =?utf-8?B?NGFiRGY3TWFJcmxNTXZwOTI3ZFdlYjEzL3hEVU5xcFAva3g5NW1HczFOSnVu?=
 =?utf-8?B?b0NQTjV5cnFpcC83QkJ0c3I3RFpJVThwWkJ6cXVuZGpXb2IrM2tQTUh2d0Zt?=
 =?utf-8?B?aExvbWczbG9jV2lWVEV6N0loL2NoSzRERElGb2l4V28yOVlveGRJbEtZcy9R?=
 =?utf-8?B?d3ZvaWgyd0ZBS3VmRGVyZURYUlZmaFNsWFJpSjBGcGU4cmJadzA3c283Snla?=
 =?utf-8?Q?hhSbPT0nPriFeKVA+pUWX6E8dk6G7cvh9vIWG/l?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d09913-2199-43ad-9d4c-08d8c9c34721
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 10:46:22.3715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3oW48nYiuO1IngldmkeyxcD6BVWTkwsadOObjpTM7FkDnUX2ipMNJJcEeyogb1s62ldY8WQuB4IEhIdZVZnhAQSUSXbcAKEOkwdGz0CuZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4353
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050071
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050071
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/5/21 4:11 AM, John Hubbard wrote:
> On 2/4/21 12:24 PM, Joao Martins wrote:
>> Add an helper that iterates over head pages in a list of pages. It
>> essentially counts the tails until the next page to process has a
>> different head that the current. This is going to be used by
>> unpin_user_pages() family of functions, to batch the head page refcount
>> updates once for all passed consecutive tail pages.
>>
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   mm/gup.c | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index d68bcb482b11..d1549c61c2f6 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -215,6 +215,35 @@ void unpin_user_page(struct page *page)
>>   }
>>   EXPORT_SYMBOL(unpin_user_page);
>>   
>> +static inline void compound_next(unsigned long i, unsigned long npages,
>> +				 struct page **list, struct page **head,
>> +				 unsigned int *ntails)
>> +{
>> +	struct page *page;
>> +	unsigned int nr;
>> +
>> +	if (i >= npages)
>> +		return;
>> +
>> +	list += i;
>> +	npages -= i;
> 
> It is worth noting that this is slightly more complex to read than it needs to be.
> You are changing both endpoints of a loop at once. That's hard to read for a human.
> And you're only doing it in order to gain the small benefit of being able to
> use nr directly at the end of the routine.
> 
> If instead you keep npages constant like it naturally wants to be, you could
> just do a "(*ntails)++" in the loop, to take care of *ntails.
> 
I didn't do it as such as I would need to deref @ntails per iteration, so
it felt more efficient to do as above. On a second thought, I could alternatively do the
following below, thoughts?

diff --git a/mm/gup.c b/mm/gup.c
index d68bcb482b11..8defe4f670d5 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -215,6 +215,32 @@ void unpin_user_page(struct page *page)
 }
 EXPORT_SYMBOL(unpin_user_page);

+static inline void compound_next(unsigned long i, unsigned long npages,
+                                struct page **list, struct page **head,
+                                unsigned int *ntails)
+{
+       struct page *page;
+       unsigned int nr;
+
+       if (i >= npages)
+               return;
+
+       page = compound_head(list[i]);
+       for (nr = i + 1; nr < npages; nr++) {
+               if (compound_head(list[nr]) != page)
+                       break;
+       }
+
+       *head = page;
+       *ntails = nr - i;
+}
+

> However, given that the patch is correct and works as-is, the above is really just
> an optional idea, so please feel free to add:
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> 
> 
Thanks!

Hopefully I can retain that if the snippet above is preferred?

	Joao
