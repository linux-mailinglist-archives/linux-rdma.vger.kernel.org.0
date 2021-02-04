Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A529730F266
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 12:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbhBDLgh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 06:36:37 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59178 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbhBDL2S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Feb 2021 06:28:18 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114BOqor054831;
        Thu, 4 Feb 2021 11:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=mNkZs/xKZ7kNjQffXI8q4oh1lHXA34BoyX70feGNRxM=;
 b=MNNGJBg/W8x8gIA/nPmkt7R2lqTA509SydTGPTICKN541WB0z+HBmLyN4ebjVHBXGF5e
 +LQH6S+w9+UBwVZvGn0BIu2TOoOs1rWkyQCmaNhgvfnm2j+aIrkDV7sWrCbgLR27LFe6
 ad0C7+vuDbx4F1h0v16AJ6O3eXtzVl1tq1QnGZvrFlDqIfrfptwE0PH1zkAO+ji/DOzD
 /m0R+K2D/0u2Qzu3ofgDZdhBrT178tzQG+lEQI376mZp2zlhFj2UO4vgznNTqpOcBt5+
 JphkulCR+U/EKbzzJPAcZuhNaUsst7QgZLRR8+DibG3EG9DN7wcUvac41iydgnssOAlB XA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 36cxvr7g7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 11:27:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114BL8DD148584;
        Thu, 4 Feb 2021 11:27:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3020.oracle.com with ESMTP id 36dhc2j6yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 11:27:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9B9DMCN/NtP7YlChK0AAOjP3IKWqC105hkeZxMkw+I4C57dPSYTuY9/kDuBs/5qsKyDEDnoQxcPZhkP7FIxV56B1itgzWVDtj6BvCI6MPgbCd+QWbCIDCBr149MiXTs1IvkcDO3f49KALwocRRyOYRoB3jFBhBFTEn9r0x/g+m4F0xrmWVzhp0gwkUii6NkH/Ts/SXBxbp2q6zxA7WDTbnYYd5wsHEn6WF5KyzOo/QwdKBZq+/dbjcjrxGZFM4lyHrV0Up7dfJwOLearBRlbbbquySOsm+IOgO/0vhJFIIY/GRS5zs3AMVNsKiZPwAjf9NTClK1SnF2eO7M/srd8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNkZs/xKZ7kNjQffXI8q4oh1lHXA34BoyX70feGNRxM=;
 b=ax/iVBvmjdz3B8Dusj2yirLfcBz2s1jNecfeW8ZCKoUkKCZsJPdpcq2Zq6FOThDBRZ0ei73G3TJgZ8AH1q0aLrY7+Bh1OzLeJK0IcTkvf8+Q2TNCjYreFSSsiE7rJwMpDrFgZqmqQu0hDCU/FNHa+Elw/QJWPr7l2ahWS3gh32d3bwufm+NsTjjXKb+p07q2UNr+ht4nDNgehWLD2cekC40FPaGRmMgEQZ9kAi9jhLSHJcqBL3Oq2YUZGTQhLYOcLjv72UuUZ0oUS76eakGQ7rl9oZaRBtbGjk5S4EGKIy6Nmgw92Lf+/qzKTtPDBaSQ06DH5X2nakXH2etQogGy8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNkZs/xKZ7kNjQffXI8q4oh1lHXA34BoyX70feGNRxM=;
 b=QqmHGgFf3V4U38fDisGVOa/LfKmLpytA1Y4t1Qtz6k/5+y0Hm0XjsLQVazwAK392O8Gh5MVpnloXe+iiwuUWspctxf/jg5PlXIaEtI8PAr+anCJoFgqk5SJvkWo08e+Bep0Yd+0TGE7jvif+/AiVmmy8wyThTSI4LsjSJ6FgyZg=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BY5PR10MB3970.namprd10.prod.outlook.com (2603:10b6:a03:1ff::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Thu, 4 Feb
 2021 11:27:20 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 11:27:20 +0000
Subject: Re: [PATCH 1/4] mm/gup: add compound page list iterator
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
References: <20210203220025.8568-1-joao.m.martins@oracle.com>
 <20210203220025.8568-2-joao.m.martins@oracle.com>
 <955dbe68-7302-a8bc-f0b5-e9032d7f190e@nvidia.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <fd4b981c-cf25-dc04-7f10-549ea16bf644@oracle.com>
Date:   Thu, 4 Feb 2021 11:27:12 +0000
In-Reply-To: <955dbe68-7302-a8bc-f0b5-e9032d7f190e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LNXP265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::34) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LNXP265CA0022.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5e::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Thu, 4 Feb 2021 11:27:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0813d52-e220-424a-9864-08d8c8ffd58a
X-MS-TrafficTypeDiagnostic: BY5PR10MB3970:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3970308DFBE837049829ED7EBBB39@BY5PR10MB3970.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WBl5smSlxU2P4Nky1WArsTE3Bb1/ClFX0nj2s851ds1ahKMDzBozr0YmwbZaozXIulFxKHu6Fo+P23jPa4CmTKMw54k9rX7r2ejTm2Q5r4gOTG7I1NgC6z4LObnuSXjI112aDOYS0Pj1Eysmj1XZUV8s3mc3qF//hU8i1g+iojyRG3X8MCr8x9nEhtG151uOA9EyY5DZh/wq2VwXEPEFP6HF5LHutDE573v1PbDlVX5jwpL83edDJ9/QGTC0iKjeY5kLEDw5Iaw+HI4aRh+cQfM5pON437bqlnlwaLNBbQuLYFBF5FYUIELIL0VeGfWJDScLHmlAeHcz/ADvW2r0HbD2+peuFj9NRB37px7EA2vKgr1gCLgOAz0FCCxMNz3o22tkXmYjyg4PEpWqBjz6CS0LsCBHAvRslfS+At3g3QaA7AlLDQMuCpzzFVqCtWrNPeIJDuB/poS6kzqFnPSjTOP5+E/rC2FAMkvMnGSCPCpUbxrEYkJEPkiw1kbt4IvPvjjkAFJBr35rtUBJ5LrQCGViXIw1ZqNYCRoo8rXecX5KPUXg/RfzECOnnqktZ+6tC6IQolfEd1FLFI892PbnxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(36756003)(5660300002)(16576012)(6916009)(4326008)(66476007)(66556008)(83380400001)(26005)(66946007)(31686004)(478600001)(186003)(2616005)(956004)(53546011)(2906002)(316002)(31696002)(6666004)(86362001)(8936002)(54906003)(6486002)(8676002)(16526019)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UWJzc1RqSDRxTWMyOXV1TnN3d3RHQnFGdE5jazh6SnRJZlUzVi9EZ3FIU2Y2?=
 =?utf-8?B?UWc5Zms1RmxRakpuM3F0eEppNFNzM0tjUHg0enAzQTcvdmFRNkExMHBHRFpo?=
 =?utf-8?B?RG1wWDN6d3dScEoxWEk5NDFwazFPQUxnK2pjN2ZFbFhpTmVGVWM4N0J6dTk5?=
 =?utf-8?B?R1FSdUhpK3VxcTdrMFRLb1dZaFNyVjVVUnNMRHZobmN3eExmNDJTY3RLRm5I?=
 =?utf-8?B?SzdjSjIwQkpnUHMwSlRiSWhRNFBFTW1HRXVpUnRVbzM4enhpYmRycWtHQ3ZM?=
 =?utf-8?B?cDJJQjlmbkNQbUMwWXBMWVRzdkVsdFRLWnN0MVRBeWpsVGNKUW50dlhyQUVR?=
 =?utf-8?B?WDkyL0NNTno4NTJLYWI1V3Y3WCtiZy9lTitITWdTeW1VV1dPUmNwUklrZEtl?=
 =?utf-8?B?UHZYVXdpUWxhUUtKYURGTFFEN3h5eFRPQ1A3ckV2cWxlNnE4QUM3Y29WMkgz?=
 =?utf-8?B?cGdJWXZKS2ZVZjJTYjNvQXZoQ3RxSlpXSnFZNkQ0TkZEZHFQZmFuMm92TFNp?=
 =?utf-8?B?NTUreHJtamI4NzZtV0RTRThrWnJtU2pObUUyYW1oWVpWdWhSUEoyRC9Ydjhq?=
 =?utf-8?B?QlpNTWQ5MnVjNzIxeURuNDRMSlBBVFl1Q1ZrMkRHaVdnemQxYzRSNlBPNUZn?=
 =?utf-8?B?TFF5U1BpZDV5YUJiQVU4bldCZjF3c3NDY1FxWmw5bjg0TXJuQWN3Q3B4OWNB?=
 =?utf-8?B?dHhhRzZ4MzdIdjlkNjZGQnZ2T3N6NnhFbDRWdVI1MjRRdi85S1ZBWVFZYVNH?=
 =?utf-8?B?aE5GTzhrWVhydWlvK0xxQ3hzOGVLQzI5NzZXRzhJSkFpSEZXdXpDNnJnMy9K?=
 =?utf-8?B?Ti9jZG9TTDkxc01VSkdIdkdEaWNydFlsMXNOYm5qMWpLc3RUTEdRTEVMMGZG?=
 =?utf-8?B?WVRlQ3BBODc2NnpkQkd6cVlCV3FodzFZS2FuYXpoQkgxMkVuRER6MWVLcFVP?=
 =?utf-8?B?YkcwZThIenAvRWpjanRrY2R2bEhuQkpxVGNYTGRKOWN4RUhGdjNBdDQ1SEE2?=
 =?utf-8?B?M011MnNHbE5WNVZPMVRsRG9KcHVCNWZONkt4T3ZNSFlsa1M1dkdhNmF0bU15?=
 =?utf-8?B?aEFqL1Q5dEJVY29CUGNKQitINWpqVW1zTy8zM1VlRUlUcVF4cGtnRnBIOG9W?=
 =?utf-8?B?TkIzLzRDeWkwbjFSS21RVGpPUThSSDZUTDJXYmpCQ3pkNjFIRnJ6QmhneGRW?=
 =?utf-8?B?MExCYkg5dWpUYStXeUlRUXNTUTd3VVd6ODNQdms0VjYzakxHSWphY2JPZUdR?=
 =?utf-8?B?NVlwWkJQTFVuWW9jNmRZQU9vVkhudi9pVnJvZFQvbTM4Tk9UcHA5Nk1CVjBw?=
 =?utf-8?B?SzR3MDk4d1dzUWlUQTV4ZlR2UzEvSzIvNmlyOHo3bE14c0tHRVJjNFRRcTRt?=
 =?utf-8?B?UktobXZaSmI4SXJ6YUxZSVJRYmIrWWM4L3UzUmFHQWlidmc1ZmQrQklVZC91?=
 =?utf-8?Q?4DDiUgo4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0813d52-e220-424a-9864-08d8c8ffd58a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 11:27:19.9929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Sjxwoo2erZenRJuXuO6GZhlxYC2n+5LnQbAx+XC+RWIyfpl/Of+n/69rTOxqmaWqfH4+Q6w/6afdd1BMHS+tSsaqf+ThNbZQO4SHpwSI+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3970
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040071
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040071
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/3/21 11:00 PM, John Hubbard wrote:
> On 2/3/21 2:00 PM, Joao Martins wrote:
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
>> index d68bcb482b11..4f88dcef39f2 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -215,6 +215,35 @@ void unpin_user_page(struct page *page)
>>   }
>>   EXPORT_SYMBOL(unpin_user_page);
>>   
>> +static inline unsigned int count_ntails(struct page **pages, unsigned long npages)
> 
> Silly naming nit: could we please name this function count_pagetails()? count_ntails
> is a bit redundant, plus slightly less clear.
> 
Hmm, pagetails is also a tiny bit redundant. Perhaps count_subpages() instead?

count_ntails is meant to be 'count number of tails' i.e. to align terminology with head +
tails which was also suggested over the other series.

>> +{
>> +	struct page *head = compound_head(pages[0]);
>> +	unsigned int ntails;
>> +
>> +	for (ntails = 1; ntails < npages; ntails++) {
>> +		if (compound_head(pages[ntails]) != head)
>> +			break;
>> +	}
>> +
>> +	return ntails;
>> +}
>> +
>> +static inline void compound_next(unsigned long i, unsigned long npages,
>> +				 struct page **list, struct page **head,
>> +				 unsigned int *ntails)
>> +{
>> +	if (i >= npages)
>> +		return;
>> +
>> +	*ntails = count_ntails(list + i, npages - i);
>> +	*head = compound_head(list[i]);
>> +}
>> +
>> +#define for_each_compound_head(i, list, npages, head, ntails) \
> 
> When using macros, which are dangerous in general, you have to worry about
> things like name collisions. I really dislike that C has forced this unsafe
> pattern upon us, but of course we are stuck with it, for iterator helpers.
> 
/me nods

> Given that we're stuck, you should probably use names such as __i, __list, etc,
> in the the above #define. Otherwise you could stomp on existing variables.

Will do.

	Joao
