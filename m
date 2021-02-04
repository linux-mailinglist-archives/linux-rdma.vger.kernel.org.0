Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741AF30F2AE
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 12:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbhBDLs7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 06:48:59 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53562 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbhBDLs6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Feb 2021 06:48:58 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114Biie6090280;
        Thu, 4 Feb 2021 11:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=p5ntBnNg67bcyBWi/8mf9YXV2kk0CMPDjMJ7wGtcWnE=;
 b=DUP7ecPhmuuGQlounCcoZcpfKKJtSjFtGjNzp6r7WeYQBGm7pcND0NoA/HAD3XLI3eSY
 iH5aV9+ZJ3/hCWscfkPorfphp0urk0LaqLryo1ZiAhbbEQqnHVXwsjHzEu0iNNm1Jne2
 J7vAUUAxfTw8dv1PuNrVfB0htKTn8lsG9wJ2qpLhfNik1zEg0Ab2RBAL6Zu5YVOl0u8X
 GUW8FJUN6R3edDAyne8WVgK/oXWSO6Nst4HcvmnmwRgvxZclpt66jeDhiYhbymbsvHLl
 UUFGwl9abI3tuURjrIJRdTFJyBbuilKXqlkzZ69zWTw+wxn84NlLHTjZShxKFmUlKolr nQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36cxvr7j18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 11:48:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114BifGd167003;
        Thu, 4 Feb 2021 11:48:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by userp3030.oracle.com with ESMTP id 36dhd18sa2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 11:48:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbzU/XX8WTziPUaSoExvKv7xY72Mmc+d6FzYoxeoMhiqr8H8/TDVYtBFbD0dizSPs0eJzYOaQTz8+NsJ28UQnts3GXiVqPYQIOj517Zc4ttAEU7jlNfQGXfBC0werX/ipZ/6LHAWBwFc4O8XSyHESR8G59GxEjEjHW7HY6OIEBZn3+l2g4jswt/PG+JYWIIAQ9bBrYaR9tS81ZxxvpVFHiArtEsEULxtvJ98uB33LMee7SAIdeEZkNT4sQgGDYzPUUqZU57bT67dQJbRCeoVSRPbm8qbu5CiUIJBt4RsgDK/4lUX5XI4D/jqK3ESf0vBiMyc4WcodvWP6VccRjC2ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5ntBnNg67bcyBWi/8mf9YXV2kk0CMPDjMJ7wGtcWnE=;
 b=T/7k0yBDHKZJ3/vwztUfr8sF9FiktXvK1B2w74DGcUFwuALo3wCcUSwXp8G80Le83nnjcKSX5/NQYLe0nyBTKTnFAR0lAgQy2GXKnyHLBPUgZei9DFXrnLic5VUhJHvVFQO5XpHMAZyvo7sbYTQ1jWHO6BH44frszWzR/NEloQgvI6VvpMh/YBXkTadvFkNJF6VtAyuhTSPc/Q9Ocu7AJ3dbo45xcLiCyHw4Qobz51r4nUDfCw++Yk1LdoVsF/jFPyEGCeJfKpflmehWT0hkrxGKqJkOwc/ItE+aNaX3I+gDTWm4CpPw1sJKr+6pwgMGHG0Z8E31dBvdojWX3njfkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5ntBnNg67bcyBWi/8mf9YXV2kk0CMPDjMJ7wGtcWnE=;
 b=DkEmPfnS/NYpb5f6p+oln2C/wD9gQEur7pDyB8bf/b2sQu0wSoSI7M+mvcn1NfvTUAVi70gtDs2LWyA0onWkiFS15tW5zZbbloYu/AptTSkV2BU2Wh8Kfc4vm+ysvzZlCHTadkv3bzR6GBODr4+Xe/ajgPPrwvtsIuV47ouuXAk=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BY5PR10MB3763.namprd10.prod.outlook.com (2603:10b6:a03:1f5::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 4 Feb
 2021 11:48:04 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 11:47:57 +0000
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
 <b6ab15a7-7cee-34e8-f680-7c4cc0d9bc56@nvidia.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <9e70bd93-783f-3d0d-c53f-ec32480477d6@oracle.com>
Date:   Thu, 4 Feb 2021 11:47:51 +0000
In-Reply-To: <b6ab15a7-7cee-34e8-f680-7c4cc0d9bc56@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0209.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::16) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO4P123CA0209.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1a5::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Thu, 4 Feb 2021 11:47:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43abb65a-b8a4-42a5-7a40-08d8c902b750
X-MS-TrafficTypeDiagnostic: BY5PR10MB3763:
X-Microsoft-Antispam-PRVS: <BY5PR10MB376316CE3AF05FB9D8CD530ABBB39@BY5PR10MB3763.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rF6ng/D826hc1XljvYIcRt56+7MtKgXsqHedlBFNPu1mw/8MnQMohm5Vsj3ofZt5FIQZEyLLIuyd6pF8wKAdEpv068KR2h8AVd3CDfJlB0KsnZ9h57LY9g3ox1l+u5KUk3IySu2d/eHsqNTblPYKK9ikHPkzK3jfxBgjsOJGc/pG3lhuFWCxCCfGEGQ7xIOs8ws84r/HYkc/nnJmidz0DqoIkGC6abMAhE6OcaGA3gS8dX3W7BfWfDATPJVLzhvc43U/hh0+0u0Jc4yiO94ql3HoezNqjtiiURQ5sYJdln9C5WSBeY+6bGxiijEFcflaAIIQ2pidbsIOavVCUP1zqvIeZfKkj9jEakIQAV7fUNPhGngfp35eBGG8axDfFGtyLVttQWLVwaWruTTkpQjfJTYEr9go7Xy+JChrsCHmzW8dRtiibk0//GDc2QVGI9Rm3gqZcV8kDC4cxIrwUrkYUdSwnJDSK5FkcQoClabuzu+SWW0+umLSRggxMGub0S13H9GL14snWPZ6B/VOyOoTLwXqVSDH9jvHxqZFZ9g1/yA4M5Y8wLENmJGw21emWGAfs6l5chffzgCIz5uXWQxzQOlOE2hWyhe70Yoru+5OnPA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(376002)(136003)(396003)(2906002)(26005)(316002)(66946007)(66476007)(5660300002)(6486002)(478600001)(6916009)(31696002)(956004)(53546011)(86362001)(4326008)(16576012)(8936002)(2616005)(54906003)(186003)(36756003)(8676002)(6666004)(83380400001)(31686004)(16526019)(66556008)(14143004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VkVLeTEzRVA3RWlHeXkyR0REQWpkcHJFM3RVUU5GZ2UrZHJwcExKMURvRFlY?=
 =?utf-8?B?U1FUNkZpQ25ybWdMZEcrTUpYOG55aUR5MFBSTHdCOE9tcGtVaE8xRGFOejFJ?=
 =?utf-8?B?VVlEN2RmL0xKamhSR2hTY2JuZmJzcTNld1dadU1JcDA4dFZ0cjNJUnl3bUdr?=
 =?utf-8?B?K3JWK0JlcWVjQlZ3YVloRm91S29wOUJibGlpOXBrSDlFVWVlek9FaHRqY1R4?=
 =?utf-8?B?QjZYRHA5MmVHY2p2YWo1TmJVUEQ3anFkNnFENlZwVEZCQ3dNRTUydDR4aGdC?=
 =?utf-8?B?T0txZytDME5taEZ2R1dDbkNLTmdPbnlXaG1OcDJmbVVpcHR1dTY0NXllNGZx?=
 =?utf-8?B?djdZTXF3LzBkTnVkZTU2OTJuSmdEQ2ZMSlZoeUI0WXBvSUxFV2lQazdNa1dQ?=
 =?utf-8?B?WHFWQjE3OG54L05qVGt6TWxkbzNNei9yMjFpMXorZVIvL2ZPOW9aaVc0dGRH?=
 =?utf-8?B?am9SK0JNUndKSlkrekh2aTlURk1sUmRtRDMyODIwcDB3VzIxQVVtUEEvQzhi?=
 =?utf-8?B?Y0pYUFcyWWwrSm1BWEJQaTVNMThoRXU5bWNRWU8xZlV5TmlCUEV0R2RPMXNF?=
 =?utf-8?B?WTBmM29XUzl6cks2ZlJYam5HcUx0NkVKZEc2eGdvakRDTU5vRGQxL2ZNcEt0?=
 =?utf-8?B?clJvWHh0b3NXSHFTRVBMem1vRVI4clMySWxYam1kK1dac2pZV01LOFNtWGhx?=
 =?utf-8?B?K0w4eForcnV0T0tGS2gvWjdXKzZvQXVEeVNGM2Q4NERHblBFa0NGRDZBWHZJ?=
 =?utf-8?B?T2ZyZkcySTlmZUtaaW1GaUxMUWU1cHR0dS9lZ0FTSnNvS0s3NVlxK1NjNG50?=
 =?utf-8?B?YXRUbFlzUkdaQVkzbDcvMXMxOHFMNUc1d09tNGlkdDhZNWVKTjZJYllKWFJY?=
 =?utf-8?B?L3VVUkRYQm02QlV1bnl5T2ZHT1lBMHlyZnNXbVlDUDUzTHM3NWlPNFBaRXhO?=
 =?utf-8?B?NVlCTXRjMUNGalRLdGpyVWNJaU8rMVBHeUtiRjdIN0VhdllKVS9UdUZoRTBH?=
 =?utf-8?B?dTluYW0vTkw2SGRkMVA2WHZLZ2R0TWVFd3RwZjlGSUNOT2s0a2pOcXArZFlC?=
 =?utf-8?B?MUNweTFsTTlzdDQxQXBFdjdBdDAxaHk0ZXpaaUY1MnYvU29yUnVkK1VqaGRR?=
 =?utf-8?B?OU13UEdiQ3lPUUNHUDNlKzArenpSaGhNYjBGV3VjQk1oR3Q5TExIamdoRC93?=
 =?utf-8?B?Qll6VGhWazJBdVI0UmlCM1lUWTF0bEF0Y1BDTlEzZTErYzRvTnVpMXJKM0VW?=
 =?utf-8?B?dVk2aDVWK2Q5dnBjb2JOc3E0Z1p3NkY1bkNQcGRQVGN0VWowUjRXcDdtd0VT?=
 =?utf-8?B?enJnenc3eGRUZkhRcVBNNzFPTUV6MTZWaWRVRG5EenJqdHY3YlNLcUJiSHI5?=
 =?utf-8?B?WTZ4b3k5amRFRWxDbFZycXZ2Um1UNXBycFZ4NS9DNzAvQ0puNWNGNWtKUDkv?=
 =?utf-8?Q?qYwuppSH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43abb65a-b8a4-42a5-7a40-08d8c902b750
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 11:47:57.6686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUUWUUX3CnVXRtV71yLwHdAjwqxJMuf8meitgwywTAqWxK2wOylJjUc8NWHNVN/j7fontOPbSg1tov9LzXXe1b5wJehH9DQM4WP97H6Jzu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3763
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040074
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040074
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/4/21 12:11 AM, John Hubbard wrote:
> On 2/3/21 2:00 PM, Joao Martins wrote:
> ...
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
> 
> Also, looking at this again while trying to verify the sg diffs in patch #4, I noticed
> that the name is tricky. Usually a "range" would not have a single struct page* as the
> argument. So in this case, perhaps a comment above the function would help, something
> approximately like this:
> 
> /*
>   * The "range" in the function name refers to the fact that the page may be a
>   * compound page. If so, then that compound page will be treated as one or more
>   * ranges of contiguous tail pages.
>   */
> 
> ...I guess. Or maybe the name is just wrong (a comment block explaining a name is
> always a bad sign). 

Naming aside, a comment is probably worth nonetheless to explain what the function does.

> Perhaps we should rename it to something like:
> 
> 	unpin_user_compound_page_dirty_lock()
> 
> ?

The thing though, is that it doesn't *only* unpin a compound page. It unpins a contiguous
range of pages (hence page_range) *and* if these are compound pages it further accelerates
things.

Albeit, your name suggestion then probably hints the caller that you should be passing a
compound page anyways, so your suggestion does have a ring to it.

	Joao
