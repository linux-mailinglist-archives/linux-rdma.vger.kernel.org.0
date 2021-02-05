Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E0A311169
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 20:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbhBEPWe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 10:22:34 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60096 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhBEPTv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 10:19:51 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115GwMlN053134;
        Fri, 5 Feb 2021 17:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=MG2nygN/8qGzD+jJYqPs13C0VosgDKTK834/dm3lk/k=;
 b=GqSE8bKk7RBKej5vq1SCo+k3pys2jQzcK2G6Wqw64KD4HsZPbu6fiZ8y3ZSD0XIgWlia
 +4Mj4wfgC7dcN51Jc/f9aDkGEo9mXWbV532PRIhmcJEwZqfDDLfwSY5yfbgftnvUdDIT
 oBosCDIYz+3qGLC7LDOlrxeqvaYFE/3tRHm///Bt3ax3e+Qd4nLuUJjrg0TDZeIDAu7E
 rdQTnrueF76o8zb5mnh0tZInKb7gPcf56lN+uuYc+Sb+gm1aiCaiJII55zogUgNdfic0
 0UZGq7M4y89MrLhYwqagXppvuFPu1xeyj+un1YgoIfPuk0Pnew3tmcnjCeAIETui607n /g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 36cxvrd6g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 17:00:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115GtfM7042017;
        Fri, 5 Feb 2021 17:00:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3030.oracle.com with ESMTP id 36dh1u6r1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 17:00:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVVZAEieauchBPSXJ72D15ekycZHz1Y9faF/NhtTl2iOE5/DY1kbZeyLoPE2TZf/dfTL3IjwSC1aWpOHAep+RuG4hNZ8W4F7ItzBZ6BDjc1zm5E0GFtxbNjQD9rGXtcHTaEQFiB1o4Jhh45qQ1R5X5CMUoSqJ5DKT7D6Qk50Ju+UgftvHwON4GMGBHZhXcCnk92zpLTnAI5d7p9sC58QpdENttCmZT87x3LXM6s4YFJ6sbIWDjMZdJT3piWdRyGtUhHGS5XBQkp4ylO1/U74oDx/Z+Ey3n7HW5SnYVAbwkOUdzi/j35LEtZMrDA83fYCttwDy6nGN0hqrKWxoMt2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MG2nygN/8qGzD+jJYqPs13C0VosgDKTK834/dm3lk/k=;
 b=cUp2rmnTBYe3/d2TrnGl+Fy7u0RxPlXCzW5YdRWqf3mjL2ZQQ1L6mMt3fP42g2tj7ElbvLfTkaYSMSSc/l2yH+zaSxXkV43/hutWn6ILxz8YwRiXZl4nZhNnjyg/SdXnUdq6svqW4U83G8K6jZH4jVpFfBnc4ZvkjH4CNuFUb1cypZWijKacRkAbU7MRLWHwGCqH8IngtLKP9DWwBtHwGTtW6rDxMSNZCkV9tOjk0TSeY/JhbgFzzuAuN8f7VqBfrBPSlQhjlUP3j3AmXvPC2ktkyg3Qld2Yg5O0bi7eMj7alLf32ymoqBEjEBY8oJCpCHEbc15qbiXGo0PQVaPaPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MG2nygN/8qGzD+jJYqPs13C0VosgDKTK834/dm3lk/k=;
 b=rDbM7ghuW92LiEMc7JqTrHqSDtJeM0othjhgeZ1YjRjgDWlNqiwr1O7N1BdAZWzV+LRoCvNWSEvLI85iEwGTwdBBdn4DCFUHJSh5MSSAUtEk/QtoGX8kw5Os81rqi8DzNoTaS+A2bOywN63l2Katrj2y/b/yyHmnrIt72ZUPSzE=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB3590.namprd10.prod.outlook.com (2603:10b6:a03:11a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Fri, 5 Feb
 2021 17:00:48 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Fri, 5 Feb 2021
 17:00:48 +0000
Subject: Re: [PATCH 4/4] RDMA/umem: batch page unpin in __ib_mem_release()
To:     Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210203220025.8568-1-joao.m.martins@oracle.com>
 <20210203220025.8568-5-joao.m.martins@oracle.com>
 <4ed92932-8cf2-97ab-7296-6efee51fc555@nvidia.com>
 <20210204200026.GP4247@nvidia.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <e1674236-c584-662c-d077-fb8c8c98507e@oracle.com>
Date:   Fri, 5 Feb 2021 17:00:37 +0000
In-Reply-To: <20210204200026.GP4247@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0041.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::10) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO4P123CA0041.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:152::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Fri, 5 Feb 2021 17:00:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc51489e-5d4c-41f3-9a53-08d8c9f79614
X-MS-TrafficTypeDiagnostic: BYAPR10MB3590:
X-Microsoft-Antispam-PRVS: <BYAPR10MB35904554CE5FA6E169DC2505BBB29@BYAPR10MB3590.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sfcf9xZMEcnPgftwixuuR6iswIksYSFyo7kHVVfKyWMkcJdfBbU+GcIy8x1jToAtRC8pe6qPpApwbnQTfOsue7pEbmvRPonV9/+8aS0tNUKsqiiCBypJ0BEfCDS/uKTA3ZO/CQzohNXqGLbUWjEnalFe0DdKQAhvSSGg3IPuhuYydbzdHrc/6ZMY2Z2EqsPrLsIuXqMh+5pGILRUnbh4pJ2BPIiVaDBZTleauSdMoizVtSAzDoaJXqT4YWzaUeNmY/2jzQRVkX8QZggoXd4Pzqha31TfYaw+MSN2h5zCgy9BxOYhuYJBCqie08SO9Qo0MVUqDBqYspBLAUeYA5Q8qn3g48jsGYFnWI2HvVvQDrVov1SKZ24BNMgHNPGK9Bart7qk70kbSw0FhTG+XKMgJZLf1L+FEeyfdc11/Fu7BANVNrNTDDw4GhCLIJ5MJVEoDVTcXCAixrgR3W8W2EwekDsU7whYNaY8tm9SBSGX1jIkD6D5k6RWlTxPV3mw2ktk7OmkQcFT6JjT/oDPJv+fMBUTedUsbzaGGNVvZJLe8QycLXcXRkQ3vvDWYYGn/o4EEPLzHw80e0zwn8jTeDLMaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(136003)(39860400002)(83380400001)(66556008)(31696002)(31686004)(4326008)(26005)(66946007)(66476007)(2906002)(16526019)(86362001)(8936002)(8676002)(316002)(186003)(956004)(2616005)(110136005)(6666004)(53546011)(478600001)(5660300002)(36756003)(16576012)(54906003)(6486002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?THRDTDlSOFlieXZrSElKb2hXMm1UTVFMd2ZKeXFzWVl2T1B6dGlIVHdDRWRM?=
 =?utf-8?B?ajZjeTNkUjVCK2lnamdmb3pPNkFSelkwV1hRNmwrRlIvQy8xR2ZVSUo5ZW94?=
 =?utf-8?B?TWRUVmVhNUlMSmtUZmhIK1BvSEVVYXF2ZEhjdkd6K1F5SUNJQ1lrNUxsNElT?=
 =?utf-8?B?RlFkeHhUZnhJdEFqYWJUWlRSTkV1Mk1aSU9pVUFhbTM4MVk5RE0wSTZXVklT?=
 =?utf-8?B?cDV3NHZqbkJHaUJ3NHlSbVhQYklVTjJySmFmTG5CZkdxaFZNbTNLWEJmQ2FU?=
 =?utf-8?B?VDlldkZWbnR4SExzSjdZcTVWTDl0VkZPYnpZTWdFZ1RjZDFoZjNwc0kvZTcr?=
 =?utf-8?B?aEJIc0Z6RmVYVVlWdnN2blQ1UFNjR05qMTJBeEZhZ1RYV2FIZGFtK2wyWTdt?=
 =?utf-8?B?MzdFNlFjNUtlK05YWG9aU0pGaGZaUW5pSEFiYXVRNHJqQTk0RDFqMEg0ajI5?=
 =?utf-8?B?SVhLNXZuY1hOam5DYmV4NmhvMFRMcUVyb0x1dFdWYzl2YVNvOGs4aXlrNnRI?=
 =?utf-8?B?aUNjVlk3dEZwQ25Yd1Q3YWpBbXlTVmpyVFdvNVN3SFNFNDdNOVZYU05RTXh4?=
 =?utf-8?B?MFRIbWhNRkVQekxoK0I5QU51MlFCa1lCc2FvRldSbEd2dGtEMTR6MFhvd28y?=
 =?utf-8?B?VzJVN1RZZFVMQ0V3STMrYjR5UmpzVm9IbHBDSFRveHFWZVV2WFcvYm1Pak1T?=
 =?utf-8?B?dkJ2aUU5RkdwOGl4WW5idUVjY1dtcDhHRVoreklYck43eXE4RGN6T004UDlQ?=
 =?utf-8?B?WHBNY3BoeHdLK0RCdWYzcWxibVNFSkJhakkrejZXbFM3KzRNbThHcmdYbE5M?=
 =?utf-8?B?MWI5RTVWbUI0QTZ2bGNtWWJ0K3MvTFRSV0NsVmVjSXk3ZzhCQlFBK2FpWHFo?=
 =?utf-8?B?eVZHTkdKNkh5cmljaEF4eVZwLzRlU1YrYkJRQzBHM0RqZHN2QkhUNTMyRjNP?=
 =?utf-8?B?K0JaOXlLNTRxejl1UjZGWEdyY3hmN1NSdEFqNXU0N2hQM2tKNE1jamNIVjND?=
 =?utf-8?B?VHlobk43bXNyc0hKMDhHM2pYZ09WTUFqTG9vU1lFN1cwWUhPMi9rZGVuczVI?=
 =?utf-8?B?RXVnM0grSlQrUnM0aHp5UE9kaUE4VlIwS0d2MFA3a055TER5SmkxczdZVm5J?=
 =?utf-8?B?ZjdmS1E1TnBMTkdTT3ZPNXVJeGZSS0tXdGNBNzRYNkRwelFEOVlCb3JnK3dj?=
 =?utf-8?B?MlI5ZGVmMjhDMVdacVUvTzMxVys0amk5YWxCelB1Mlo3eWxmWHBTSTJDRmxJ?=
 =?utf-8?B?NEkyTE9DS01hek9RK2R1OWhnUTkyTmltaHR6aEpoSER3d3ZEdWtsUldIeDlq?=
 =?utf-8?B?MjRKS0E2RUpyRlhqekswVE9VdkxZVUdMZkd4OTgralVoRDhjYUJzUXRFMlN4?=
 =?utf-8?B?UldOWXNKS0FBS2lXSlA0T2pZem1rK0hZdVBaYXcvcnFUeitWNWJ3OW9kYXdR?=
 =?utf-8?B?enVMM21IMGUzekJVdVl3TDhGaHFFc0N0citoeTB5d25DdDkrM0FFdWQ4U3VW?=
 =?utf-8?B?cFp4Q2pkTXI2WFc3WUt0VG9SZ2pVSjhRUm9jQWJNUitQajhHZlBhL1Vpc283?=
 =?utf-8?B?S2NCTXdkVWM2TTcyNG9hSUV0dzVRTzR5dnpjMXpKRGZ5OW4vSnNDamF4b1FW?=
 =?utf-8?B?clZZV3doQlZkWVZ1K3BuR2pVNVBudGhZSk9hSHZsSTVsRCs3WW16TzdySnZo?=
 =?utf-8?B?ek12ZXFudnlVY2R0ZFZBNFhZQUxkVUhmVldwVnQ1dWIwc3F4K3lDR2JpSEVX?=
 =?utf-8?Q?QORzDDGxZSbxiZdVy0nTxE6XrrTppWUQG80JOgA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc51489e-5d4c-41f3-9a53-08d8c9f79614
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 17:00:48.7291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+XZaZLCDvirbucW8Ktj0PuDcG2Z4DgPskFEcE52wbm9tYt/6+Ri1gMyd4RyulrupuzwoTZNexz/bxQylcbQZ0hj8qmm4+6CnF2e6xJPyu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3590
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050107
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050107
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/4/21 8:00 PM, Jason Gunthorpe wrote:
> On Wed, Feb 03, 2021 at 04:15:53PM -0800, John Hubbard wrote:
>>> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
>>> index 2dde99a9ba07..ea4ebb3261d9 100644
>>> +++ b/drivers/infiniband/core/umem.c
>>> @@ -47,17 +47,17 @@
>>>   static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int dirty)
>>>   {
>>> -	struct sg_page_iter sg_iter;
>>> -	struct page *page;
>>> +	bool make_dirty = umem->writable && dirty;
>>> +	struct scatterlist *sg;
>>> +	int i;
>>
>> Maybe unsigned int is better, so as to perfectly match the scatterlist.length.
> 
> Yes please
> 
Fixed in v2.

>>>   	if (umem->nmap > 0)
>>>   		ib_dma_unmap_sg(dev, umem->sg_head.sgl, umem->sg_nents,
>>>   				DMA_BIDIRECTIONAL);
>>> -	for_each_sg_page(umem->sg_head.sgl, &sg_iter, umem->sg_nents, 0) {
>>> -		page = sg_page_iter_page(&sg_iter);
>>> -		unpin_user_pages_dirty_lock(&page, 1, umem->writable && dirty);
>>> -	}
>>> +	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, i)
>>
>> The change from umem->sg_nents to umem->nmap looks OK, although we should get
>> IB people to verify that there is not some odd bug or reason to leave it as is.
> 
> No, nmap wouldn't be right here. nmap is the number of dma mapped SGLs
> in the list and should only be used by things doing sg_dma* stuff.
> 
> umem->sg_nents is the number of CPU SGL entries and is the correct
> thing here.
> 

And this was fixed in v2 as well.
