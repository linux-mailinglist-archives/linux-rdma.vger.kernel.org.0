Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CCA30F331
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 13:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbhBDMcr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 07:32:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48334 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbhBDMcq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Feb 2021 07:32:46 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114CKKjo190054;
        Thu, 4 Feb 2021 12:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=7HmTubL+66+B+1Mi6HTMJgiYq2vQ6AQhu/jUeGpiJfU=;
 b=El1+p6Cb/KUA/di3pd64UeOmuBjTcTeMEYIquVm1g1CjJcRnHYXOkt+mjS0oQWTVdkUw
 nh+thEymqGZrDrTaMKS0+if4yD5/4DCJLs5LyhHWQkiJ4x5EHTYoxNi5yR208ysg+hI8
 MbtGgoL+ubO0mjUMNLU5vQQXv4bukCbf9X3iEYGVFz4+loo4r2U0XAmHC7vi3e/zvcyS
 iigKbTdUQw7Rg6RVSuyZ+GSJzvXAs8jlkFEkc48XXoZT6yve91+eh7pxcjoWt5Yv3yC+
 Jl6h8y1izVuQCMURZoTr3IbEMOVOT9fNoDVNt+A+efaaY7zu1wCPd3n17rZGmlIt92Dz NQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 36cxvr7pqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 12:31:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114CTabs083569;
        Thu, 4 Feb 2021 12:29:54 GMT
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2056.outbound.protection.outlook.com [104.47.37.56])
        by aserp3030.oracle.com with ESMTP id 36dh1sdppp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 12:29:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5xMDz632gR5C4Gs6nfrhMtnSwPdPEIP6RxbVN5eEXHF0pozQ31zD+ltEKJyuyN2MNXXzfcfopMvKNXoeqVhoKEHdHr0UMuQpvLGaSp29di2PFTHduxkrxUmdppWAEtdYXqqWdPvSBFmykxBMSI2cRS4AmkHQFQAUqDUVO4nVEX8Gzm0Z+KrPGrfmaQ7AGVB00HwhxlmBYTII3Uc4E0LWyTShRYqU2bgpafBuW4Fh4nFuFZmjNNPvw/SrS9Jn4BCbdbgN8Pd38oM5pyp26q96f/EtxFfj3e6i1nR1yd0uldyJTX/z5evkXenfsMlr3d2cgLTdzm3httLTR/CViR4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HmTubL+66+B+1Mi6HTMJgiYq2vQ6AQhu/jUeGpiJfU=;
 b=dVPt1mzE3hdH+wNVi3pxv21f9rWCMjGj7InrZFpJ7A4xoFAJniJRyxOxTpqu4CJy1YyruCsKJhZs4QAs+WUFnE6xDsgiAY6lbz92NInr7aJD54xdketuLobnxv+fdFcSv92VeC8IVbSUfGEVzxSkCjIfyPNz+hEvmw/dmD+6NA1M2nTgfSi/ZwLvxq7J8KObPRwX8/2pGxMxb/op8HRasUDL8HCjPjGNAMyNcFFpGyb4+SU+Z2ilphvp93kFOW7+pbl8kf7TpyRZKFVkPv8L59iDxrCQPEPL2UHS5guatjD/zGyVZBjGwJa5BWdssUa/Be1Yl64glRt9Wkto+y+FQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HmTubL+66+B+1Mi6HTMJgiYq2vQ6AQhu/jUeGpiJfU=;
 b=xsnDxtubKMvIK1OBbTPBIj85t3YQaXX+jP6GxxZDWDYNrIO0hhjIf8XI34eN+5fpiXjw39nqhpb5kUiA4XDwT5ihjkrqlZEUpQ3QQRLC351CA0xQQR/aAX9fvTkya1M0PS0M0XLvUGdDhYlIe7hpJ87c5BXtvuBJC/LmZxFaaTA=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB3734.namprd10.prod.outlook.com (2603:10b6:a03:127::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Thu, 4 Feb
 2021 12:29:52 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 12:29:52 +0000
Subject: Re: [PATCH 4/4] RDMA/umem: batch page unpin in __ib_mem_release()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
References: <20210203220025.8568-1-joao.m.martins@oracle.com>
 <20210203220025.8568-5-joao.m.martins@oracle.com>
 <4ed92932-8cf2-97ab-7296-6efee51fc555@nvidia.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <7342098a-347d-a393-86c6-404a1540711a@oracle.com>
Date:   Thu, 4 Feb 2021 12:29:44 +0000
In-Reply-To: <4ed92932-8cf2-97ab-7296-6efee51fc555@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0337.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::18) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO4P123CA0337.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18c::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Thu, 4 Feb 2021 12:29:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdf1bd73-2195-4cc3-154e-08d8c90891eb
X-MS-TrafficTypeDiagnostic: BYAPR10MB3734:
X-Microsoft-Antispam-PRVS: <BYAPR10MB37341F123C42E01A2915BBD2BBB39@BYAPR10MB3734.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BWfmnZeFuEAmLfH5be6ntgAWB04dUTS8Ndt4oqT20wT0aUEyB3b1q96wc8o/SAwi2tyeRJLzBOloZb5kBw0/Q4mtQsEV8knvJGat/F4asiQDyIYkI4FjSAPqxk9v1wqJNFtvHp/xUotBwlaAR6MTgbm+VjeLJq6uMNPrUYf9em4krKTh/FnwSjcFWW1hMTwVA9seZiXqb9rSq5QQODXOcVIpHGL2/QJMxl+QLkAGU0Ku81bcuaO/2RHzUsjRBpR7+OEmfh10Zz5hlKCV17ZOXNRMcEUUjJ/s8R5t/bbAMOCn0WbjzXby2ZVFsaqfNeZpwKE4YFiHIFdjzOg+BlQaFnFag1gczRFiBudHS5V1vP/Hdiy3lJ3RGdn7vTw89JoFJOjUIPIeo/Ys/ESR+WKAzq8NVHUWC8nEaS1Je9NxCki6kqy7TjvSPmbxcy06JPj2pZizJh8+Jfo0vRZ9MvS8QS6v/0mTOnkKvkspzuSpo4zpHwwfRorgUbPouZwjN2rx3PFneDfsvI/Yv9+vxGPgtyShtMNnK1zqqwc+uGedrXUlh9bk9KyaOQbxFEyEG30/gs3CCK53kuoYEmkdT3XflA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(376002)(396003)(346002)(31686004)(66556008)(26005)(4326008)(2906002)(2616005)(31696002)(83380400001)(6666004)(956004)(54906003)(6486002)(86362001)(16526019)(53546011)(186003)(16576012)(478600001)(36756003)(5660300002)(8676002)(66476007)(6916009)(316002)(8936002)(66946007)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VGhzcHN2YjVaT0x4RnpISFN1ODNYN2hYb0VDdUtlOVAwUTJNWGVnSWxTMFUv?=
 =?utf-8?B?RUlsWmZNczlKMTQ3b21FU3dvanJHaGRCZXdHNExZZDJ0MlZPR0E3RzRlTmNW?=
 =?utf-8?B?VEZ1bjZrYmQwd3IveGdYbkdFU3FsYmJ6VHFMaW9lRC9nOHRuTDVxNXZXaHpr?=
 =?utf-8?B?ZEVKckxPTW5Tdm12dzNISWxFT05ZU01YMUMxdWo1RlViTThLOWxHWVIvOW9M?=
 =?utf-8?B?VEhMcG82dGRtOFVMWnRJRHI0NmVYNUtTNTN0MmhGS1dadVRHbDNPT2RTNXMy?=
 =?utf-8?B?cTdybzgxS21sRzZFRlBsa3hrZFNlNkN0SXc2dm9scGpvajllMWlPcXY4MHM1?=
 =?utf-8?B?eUQrMklmNG5iK0xvWC9iRlpxVzVhTkIxL1NzNkxLNThBUXNKWHVDblYrY0Vz?=
 =?utf-8?B?L3JFQTBCTDBkTW5pUGQybUszc1lLTjYrN2tlVXNQSmtzUU56bjBPUEwxLzlK?=
 =?utf-8?B?UEphU3hJeVFaYnBYWnRyOWlLUk95Y2tkTU1yVng5bitZYTlBRmxROWlEd3Br?=
 =?utf-8?B?RnNnY0R5cVVOd1F1SnBqTDgyd2V4TzE5VzVLTStnZ1dnTkhMdEZKZHROamNL?=
 =?utf-8?B?N0NNTTRielVpME9IMVVSYXNoNWtVN091c1JWUjFhcFgzNmVSUS9pTThmODJh?=
 =?utf-8?B?VFFPV0JYVlYzUHZZaUFWcEtKVW85bmdVYmRCSEIrZmdLMG9rZk1WSFp1Mkk5?=
 =?utf-8?B?Y3U4d1hpY2phNWhhSWhzdHNXdHBsTU5FczZGR3Erb0pwNm56d2pjcjU2UDJu?=
 =?utf-8?B?Y3RBdjBzR3RSdlc2cUp0UGZIWlY3MG1yMm9pWUg3ejhIWTJ5U0NydHF4S0sz?=
 =?utf-8?B?SDUyWEdlQWdqbm9pdTdaMEdSUEoxN0gwSmh0V011WnR2MGlsM0xua1NMYnBW?=
 =?utf-8?B?UGYwczJOZS92ZmVxY0FUcmdyYU94Q3N5aGgvek82UnExc1NzbFhoaEV5NWtj?=
 =?utf-8?B?NklYYmwzZnAxdFgzMkNJbnVGUHFmcWhMSWFvMUpEMlRRMkZQc2JhWmZrT3ZO?=
 =?utf-8?B?ZmdSZnhLdWxHaGlseFNub21vZHI0SXF3bnhoeU1QUGFLTGdSUDNaYjd0SVE0?=
 =?utf-8?B?TlRQT1FCSFdCUW12YnhINUpzMlVmb3EzbFBQdjM3aFdJOHUrYzZHaXczQ1hn?=
 =?utf-8?B?WGdxSFRyeUVnY25uRFRYc0tnTGJFT0Q2LytHdVhiUVc4cWt1WXRzY0NvcXM4?=
 =?utf-8?B?a05kTWQzNkNlMytYdlNVZEcvRzVEdmplNUQ3T01KNHNWR3FzNDlRZ3k1Z0VS?=
 =?utf-8?B?RG9iTGtHWGR6a3NrbTU5bnhSVU1yZEhvcC9DR09ZNXVRejV6Tk5EemxERUtI?=
 =?utf-8?B?aEhWYlFVWnpFMDJodWhTN0k5cnJkODEyVyszVG9rd09sL3BGTlQ3OWpOaVY1?=
 =?utf-8?B?MS81Q1c3d2lMd2pIRnZ6WXkrSmtBQjJHUU5lTzZVY2FENkM5aTFxOE5WdytS?=
 =?utf-8?Q?X/eZRUAP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf1bd73-2195-4cc3-154e-08d8c90891eb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 12:29:52.0547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzyH2cJSDFKsieA1jj20FIMDKOHHmvAYqp8W43z8b5rnt5486RIv0dHslXakKJPO8syG0PLAy8zVFFtL+KRCBteyyVu5HMJ6PGYVmSbwndQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3734
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040080
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040079
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/4/21 12:15 AM, John Hubbard wrote:
> On 2/3/21 2:00 PM, Joao Martins wrote:
>> Use the newly added unpin_user_page_range_dirty_lock()
>> for more quickly unpinning a consecutive range of pages
>> represented as compound pages. This will also calculate
>> number of pages to unpin (for the tail pages which matching
>> head page) and thus batch the refcount update.
>>
>> Running a test program which calls mr reg/unreg on a 1G in size
>> and measures cost of both operations together (in a guest using rxe)
>> with THP and hugetlbfs:
> 
> In the patch subject line:
> 
>     s/__ib_mem_release/__ib_umem_release/
> 
Ah, yes.

>>
>> Before:
>> 590 rounds in 5.003 sec: 8480.335 usec / round
>> 6898 rounds in 60.001 sec: 8698.367 usec / round
>>
>> After:
>> 2631 rounds in 5.001 sec: 1900.618 usec / round
>> 31625 rounds in 60.001 sec: 1897.267 usec / round
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   drivers/infiniband/core/umem.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
>> index 2dde99a9ba07..ea4ebb3261d9 100644
>> --- a/drivers/infiniband/core/umem.c
>> +++ b/drivers/infiniband/core/umem.c
>> @@ -47,17 +47,17 @@
>>   
>>   static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int dirty)
>>   {
>> -	struct sg_page_iter sg_iter;
>> -	struct page *page;
>> +	bool make_dirty = umem->writable && dirty;
>> +	struct scatterlist *sg;
>> +	int i;
> 
> Maybe unsigned int is better, so as to perfectly match the scatterlist.length.
> 
Will fix.

>>   
>>   	if (umem->nmap > 0)
>>   		ib_dma_unmap_sg(dev, umem->sg_head.sgl, umem->sg_nents,
>>   				DMA_BIDIRECTIONAL);
>>   
>> -	for_each_sg_page(umem->sg_head.sgl, &sg_iter, umem->sg_nents, 0) {
>> -		page = sg_page_iter_page(&sg_iter);
>> -		unpin_user_pages_dirty_lock(&page, 1, umem->writable && dirty);
>> -	}
>> +	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, i)
> 
> The change from umem->sg_nents to umem->nmap looks OK, although we should get
> IB people to verify that there is not some odd bug or reason to leave it as is.
> 
/me nods

fwiw this was suggested by Jason :) as the way I had done was unnecessarily allocating a
page to unpin pages.

>> +		unpin_user_page_range_dirty_lock(sg_page(sg),
>> +			DIV_ROUND_UP(sg->length, PAGE_SIZE), make_dirty);
> 
> Is it really OK to refer directly to sg->length? The scatterlist library goes
> to some effort to avoid having callers directly access the struct member variables.
> 
> Actually, the for_each_sg() code and its behavior with sg->length and sg_page(sg)
> confuses me because I'm new to it, and I don't quite understand how this works.

So IIUC this can be done given how ib_umem_get allocates scatterlists (i.e. see the call
to __sg_alloc_table_from_pages()). It builds a scatterlist with a segment size in device
DMA max segment size  (e.g. 64K, 2G or etc depending on what the device sets it to) and
after created each scatterlist I am iterating represents a contiguous range of PFNs with a
starting page. And if you keep pinning contiguous amounts of memory, it keeps coalescing
this to the previously allocated sgl.

> Especially with SG_CHAIN. I'm assuming that you've monitored /proc/vmstat for
> nr_foll_pin* ?
> 
Yeap I did. I see no pages left unpinned.

>>   
>>   	sg_free_table(&umem->sg_head);
>>   }
>>
> 
> thanks,
> 
