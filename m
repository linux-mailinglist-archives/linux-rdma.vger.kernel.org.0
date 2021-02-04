Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E619930F230
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 12:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbhBDLav (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 06:30:51 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33756 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbhBDL2s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Feb 2021 06:28:48 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114BP0IA101418;
        Thu, 4 Feb 2021 11:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=6K0sRyhxeE3HiIPaFb+0BqlB2ygCid+dTv1mp9SOamg=;
 b=YAUXsY4WT8vsI6QNiJIrZ3NGiXJgngfXNwvDvNydHb8Ft0ncyqzbJpHQFj/MYdSZLafy
 Xp6U0s2FqmxS+iVI7vWyKQB4GryG1b/G03ntPPq8BzEhK92ZoczrHt56OA3k1nx/nDu8
 YBxQo4aOZA7vnDcr7ydqUx4w2rJhJGRqzb5CyLoY21PO6GB8kdfW1sKrCjPE9Oe1c3wR
 r4xlxPDHTWQM015zcsizh49edZ3/3eLA8chxGaMiFw7+TPTZLNK+rW9WrM4oHDVdFWDx
 e/BylhBZjxxoO925A9v1y0MrYeNWhOuYG4gKwnqR/yFzOROqdJmNJB3F3w5JCYjlquox MQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36cydm4qgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 11:27:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114BLbhl062688;
        Thu, 4 Feb 2021 11:27:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by aserp3030.oracle.com with ESMTP id 36dh1sbq50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 11:27:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GblT9XpbjsYbhLB/p5thPm8aKdxBvlayWciZw916ea+VXBI23sbnAGtmRi54OLQ6Ff+WrTRwzb2bD1qgXL2L/75caXKAzm++3wZfgczouIoe5CzetYGqdnemC6Uo0Pobo8+WYbBQJ63WyHjnsadpmKvanAULbC5V/Pavi7DEF2eHfyrCU0b2tUT1ICG18TvpGBfI1BO6ZafeoV48XAISKWEjdH2iKLO0reVWcUdB+LBSYg2yb/C3JtDWWdTjunH+2MoaqlJaVfn51Zn4hlXAAxtTqztRuFC2zK0wCGprPEf/Ca9JjMjgiNM8nBK0vdURAaXfyXbAeSemS2m7tdSmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6K0sRyhxeE3HiIPaFb+0BqlB2ygCid+dTv1mp9SOamg=;
 b=jyo9tj39QCzMtyg6GEtWlZdL75IEMUR9fSupTrF7jbXeKzlR+HLxtFa/u9N6xmTYw/3Y+80WGSdk/gKM3R3Cx9JoYWOibrUEQ2di1xZuQir0Wg5U4ajmcnl6+nNglvjuE4O4E8dU3ARrrN2Ru9vi248yiEJTwixtdI6KYe9aaYDoT2bI78Jfk+2ZqQvuuBoOISjgORlOy9LtZWp53W4od5/eTnVQgFZgIa6x6UlRaCTuEHu90xCRMTW0WzYttfqr6DBxwSIJINbHIJMYaGMXuFqH9nUcwtDD17+BGQrlwCR0Btbj22Ce6GRG+52dWtC673h93kiOrsFSOFG44BeJYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6K0sRyhxeE3HiIPaFb+0BqlB2ygCid+dTv1mp9SOamg=;
 b=kdmPlOR7WVGyLWWbb+al9Xs8cjV4j6qj9l5IteC9EUBD2MSc2hhUkN+Uq9PtXe23HItDcQOrGc10/XP30vGsIUffZq05JFhHwQYWUZmv+Rj+7pcLnupVNRns6lwuA5aOxSgLIgzmLSGIQRjTNk0wKpdHNTelBTw13fyjtFxmiqM=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BY5PR10MB3970.namprd10.prod.outlook.com (2603:10b6:a03:1ff::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Thu, 4 Feb
 2021 11:27:48 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 11:27:48 +0000
Subject: Re: [PATCH 2/4] mm/gup: decrement head page once for group of
 subpages
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
References: <20210203220025.8568-1-joao.m.martins@oracle.com>
 <20210203220025.8568-3-joao.m.martins@oracle.com>
 <a1f9ba72-67c3-7307-89e6-d995ab782b42@nvidia.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <b7904b60-d7a6-d57b-3bc1-4b5afa92db44@oracle.com>
Date:   Thu, 4 Feb 2021 11:27:40 +0000
In-Reply-To: <a1f9ba72-67c3-7307-89e6-d995ab782b42@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LNXP265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::13) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LNXP265CA0001.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5e::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Thu, 4 Feb 2021 11:27:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a98a080-0ffa-4887-9796-08d8c8ffe65a
X-MS-TrafficTypeDiagnostic: BY5PR10MB3970:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3970AB8D7F2C4B5E9D0AD32EBBB39@BY5PR10MB3970.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Rsy7AufiJdK9oeCvAy8ZLlNcRRGuuN1u4snObIPVQ3T0D08+6Bo/1nByaWBRfkHVUbTmpItYSL7gc2zbOwHv3U+9B9hm/PRMGmNX/dXQ9ry2P2VvW3jmOC96DXs46rCk/QjHR8ZVf9VGKRMsWqS0GGPKKKUr5zcnr2WaK3fvyKPP99kA9EC45uqxmSpxUITBReWwdzKOm2Wv2my98HIjooBKwiUJd18HMm25ugf/FmMx5GBHzNt3z2uEnOrYtAIK7G83CTJlvqSLa00tlKFWPOddGhLznWjf7liWgIsLvbafSsrKdFv3hV944R523wasvR7KmQ1LWj8Gna6jKI41+ggkxO9bnM4HFmQ5+ASQCNYgLIsRAibIBhza8C/J+vIPaZNUcTPbQAxID+uW748wF8vXPdMqtGVbmxUH0vb9o5TI3TZQ8+cUm+xgASdeg6RwRJF73Vxicrpyr9l9VJmBCaI8RxlNZ/isuCFznTUEnpYG2fTmPr2g2gF6rmrDwA8tUDmX2ffsiPrrix3JEFykjqxP4VL+1/rEnSMK4QJ7K1Ul4ShdITmpjLmcuxkdpfZQedRuLwjJBFVwOcpzAZTPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(36756003)(5660300002)(16576012)(6916009)(4326008)(66476007)(66556008)(83380400001)(26005)(66946007)(31686004)(478600001)(186003)(2616005)(956004)(53546011)(2906002)(316002)(31696002)(6666004)(86362001)(8936002)(54906003)(6486002)(8676002)(16526019)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MXJsT1I3RTVFWCtGZ0YzMHJ1OEowcm9yMTZVTXY5bi9mU201SnRRQzg5blJL?=
 =?utf-8?B?UUZCWGlaNVBIMC9EbmZId3dXRC8vSCtWaGxJMXNkajJHYzUxdUVpTzZPTlJO?=
 =?utf-8?B?cDNNQmg1WEVFc2QxRUlaRStoZkpUMkQvVEpzMHVac2wrQUhlMldvTkZ0SU1k?=
 =?utf-8?B?eFdwRjRnTnN3Nm1CcEdESTdxRkFKQ2Q5S2tCYkhxemZidDA3WFBhNzEyY1R2?=
 =?utf-8?B?N3hBWjg2eFBlWnVURy9MUTJlcXorUVJRS3hrLzZrSEUwN1dtZ0FIMjE3bU1Q?=
 =?utf-8?B?MlM1ZE14ck5zRFZkMUJDeXFOUERIblVoOWNxMW5zR0JTNmg5ZmJscE53cG55?=
 =?utf-8?B?VGVWSWR1ZkhSTDB5aEVxMmdwV3BoclduNDlZODBQWE1oTnUwRzkwNnRQV0Ur?=
 =?utf-8?B?eEdhSXFVdGZ5K3lFcWtQSU1oZjViZGNETUlWaHRzcVU3MGVEbGJlR3hEdlRW?=
 =?utf-8?B?czhraHJKSVlkZ21GbWx4c3c2K0laekVVNjErQUtxL09aMUszaVRIaW42RG91?=
 =?utf-8?B?M0N6QjhvYVAweTY2WmJMN1Azdk4rVWFhNUxSOE5VaFNvUi8rUDFLbTQ4Vmpj?=
 =?utf-8?B?bHNiR0Y5RGluUzRHSndYemNXMFpDeE5sYzlwSCt4ZmZsMXhseFUwSUhDVzV2?=
 =?utf-8?B?RzZtM0NOZ0s0V3NYTkV5NXVxeS83ZkxHdmh5b3NUNEZUcFFxRnVzNk80cmRp?=
 =?utf-8?B?d0xONXlQYWpVQ1FGK2JoUXJtUENJTHBoaDNiQlRmYlZYdFQzcW50RXFoa3pU?=
 =?utf-8?B?Ukkxb3BEa2lxRWxHUjJHNTdTLzM4Ymdia0lNWUpHenQrcXREQ0Z2NzZJSFk2?=
 =?utf-8?B?VUpVOGJuc2U5aFFXUFBBSDBmWVQrNll1ZllEZlUyL1lpV1ZKZ1dPRStoMVRO?=
 =?utf-8?B?cG5nWk1xanRON1owc3Vyb21XNVVKN3VCSWwrTEk4K1hzYllwblVKcUp2NXc1?=
 =?utf-8?B?b1Y1S2ZWSmNMS0dHcDV5N2VsbEo0amdzN3RtWGtkSFdWYXZCTmgrdGhOckdO?=
 =?utf-8?B?RHlTaExaODVKb2R2eG9tVnQ1azNRVUdVZXZpVmt0Z2xUMS9KUnFKOHZxWFhk?=
 =?utf-8?B?OTBybzE2Zk9QWnBFSjllL0hydmo1OHFjanRKc2VRWXZWbDFyekE3bSs0bTFD?=
 =?utf-8?B?U2hZb0NUbzBEUEFubXZNdkhSbHpMaEVlTXNxUUZjdzZuRnpueHFZYlp3NFp0?=
 =?utf-8?B?V0RTbW1OWlZxZXBaZ1AvNVNKUitsbDhhNGFVMS9iQ0QrTVU0TmhZdzJlbGFO?=
 =?utf-8?B?RjUzR2tMNjA1RVIxaGFuT0t6LzhFTjhlMnpjbDlCbVRKdGl4TTcrRXhSNWxY?=
 =?utf-8?B?S1JQM3FwVXhIMFVxSnBoZzV4OE9ITWtwRGhCRThQU0JmcEY5UENZcGZBbHpu?=
 =?utf-8?B?Yy9QMlBJZDVybHM4UjdiTGs0WTlTNkU4ajZTZjJETjRwZTFhUzRaeU5IK2kv?=
 =?utf-8?Q?rH55E+Nj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a98a080-0ffa-4887-9796-08d8c8ffe65a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 11:27:48.0857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FuI5ie+tDBeR5ug2uk3pxa5IoZzTO2IycrnXtz6Eg5U3DMVCHiLYyTVFGai1xGyxWon2puoubQBN7g7cwYpOXljQhzE0jargGFCvlWodAdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3970
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040071
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040071
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/3/21 11:28 PM, John Hubbard wrote:
> On 2/3/21 2:00 PM, Joao Martins wrote:
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
>> ---
>>   mm/gup.c | 29 +++++++++++------------------
>>   1 file changed, 11 insertions(+), 18 deletions(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 4f88dcef39f2..971a24b4b73f 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -270,20 +270,15 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
>>   				 bool make_dirty)
>>   {
>>   	unsigned long index;
>> -
>> -	/*
>> -	 * TODO: this can be optimized for huge pages: if a series of pages is
>> -	 * physically contiguous and part of the same compound page, then a
>> -	 * single operation to the head page should suffice.
>> -	 */
> 
> Great to see this TODO (and the related one below) finally done!
> 
> Everything looks correct here.
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> 
Thank you!

	Joao
