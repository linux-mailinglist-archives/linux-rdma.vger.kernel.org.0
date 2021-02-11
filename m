Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84319318896
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Feb 2021 11:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhBKKsu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Feb 2021 05:48:50 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44026 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhBKKqp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Feb 2021 05:46:45 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BAj1YT095339;
        Thu, 11 Feb 2021 10:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nLdVgqoEKD3spJevou/jucsReCvnDUfKyY6SA8oHz5g=;
 b=GoyGf2hYzsQyhibpPqtE+HJxKASVmAXR/YO34p9d9zBzNZq1Kum0enG0Van2j0490yCX
 uGo8BeTyjPsnAPpjcZK/yzkw1dhrwufVTwRsjzRHLg30JQH6HNFrQgU6BLL0sMcH5GlC
 zVgv+7Dnnh+f+IvfI6HU/0wCIx2NbnTg7fgdwLdkn3pJVudQIPZKW3N8WjuZRFmCvp1I
 JWnYD+etCbDdZI6xpwD+4aTsKL333C9vdQmJHkYnearuQntIKaZX9xjNsccTY1WZWvGd
 IQyS2asKKv2z+RVLeDWExwDu3oQFN46YbCGb771/vmVfAvPPtcebeLVuSvSCuBDeRXdN mw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36mv9ds665-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 10:45:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BAj7HH095715;
        Thu, 11 Feb 2021 10:45:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3030.oracle.com with ESMTP id 36j51yuuk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 10:45:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juUsjFEwvH76ttKhyTLESE3t+jRAp+wNUVusTCjmMO6BcBWu4FHtdR7HzmPbokeuID5y6+svRNq7IYTxo5iuD0Tdn5j2EqD9yie/NSBZwl8ESEcSG7jR/NptMQlh4ltV4CKRNN8COormlhebvJBW5R2PgyGXET8DeV+Cc8PEF++1YE3OeHQhhKpb651qc/trAXnokmi2AmLVv9EM9ibKAPK37ONbnLrJsXu2BXWlxjCujrBkTABZhpu+CeVQJ2jD4POt72rqwPF1fMcwN0Z+PrKuU1iLKnKYCQtxw6IPjgBygvcBRJTJELsphFOoDUZTB/weCsQr9HjbRJsD8iQsQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLdVgqoEKD3spJevou/jucsReCvnDUfKyY6SA8oHz5g=;
 b=Uoxe78Y9J0W5REhHynURaPnGpjWPNQIqIAxfOYUsucVfS6XfppZfAIJ7tyXJQaMAkxwdzJJy78N9sxmXNqZRWI13CrWpdyRkU2ZumhFwGJpDRThWFS2kFKciwp0ot0uR3ksSq2K+XmUwzgEhg1UMsu51yGgeHDfp9AMgAkF5oKYsnzKGPkx6B89C/IyYnxInRU4y7eyoJQ20kC1rFEXdeGQ9o3RbMom6C3/CKp2qSVsRNyerHTh5e3sOif2stvU5PRyN1irUuRTO8fTrc6tAdFykRm7f9AEQStrYVCpCIGSnSvHTOsWliXXqanYODGWZQMMD3OGFPhw8kjicuo61oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLdVgqoEKD3spJevou/jucsReCvnDUfKyY6SA8oHz5g=;
 b=aIKOqZQjYNXJpkVNZ7UCyj8ueryRd2RWrt9vLoTewjf4gdiB6RApfqxeOSmMFH3tJTCr953AU8CoZI7/Ba4abgh83C+aFkipCGMzGKbMLCwGtjfzM9SwIFknU8DGpq3hfObEDF92wnGjb67J2X3Mf8ctrCU+Q3QqmvDSrpTWhrk=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB2552.namprd10.prod.outlook.com (2603:10b6:a02:ad::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Thu, 11 Feb
 2021 10:45:09 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3825.030; Thu, 11 Feb 2021
 10:45:09 +0000
Subject: Re: [PATCH v3 1/4] mm/gup: add compound page list iterator
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210205204127.29441-1-joao.m.martins@oracle.com>
 <20210205204127.29441-2-joao.m.martins@oracle.com>
 <20210210232010.GT4718@ziepe.ca>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <87b7f24d-0065-9f55-5c96-e7853b2e8068@oracle.com>
Date:   Thu, 11 Feb 2021 10:45:02 +0000
In-Reply-To: <20210210232010.GT4718@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0226.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::15) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO4P123CA0226.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1a6::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Thu, 11 Feb 2021 10:45:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b453d9c5-f02a-4a27-0011-08d8ce7a19cb
X-MS-TrafficTypeDiagnostic: BYAPR10MB2552:
X-Microsoft-Antispam-PRVS: <BYAPR10MB25529D068C59683D23C3F8E9BB8C9@BYAPR10MB2552.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHLO7jPU/cK+rAobE02cZd4f/KUFDJJaC1s7rx3nHvPnEOK9TUIqFob1r2INvVfD6kVlx+XK18Xqin3yLfwDmQ5w3GdNhYe5/8ErsX5n04uXXl0zY0DUj54UpJE6HAT20bUNqAipafyxPMDeJXwRWQoq+LfWIjsspn1USaudoxZOU30Hvc50d8/kR2eF2DffhTzsufzAQteGFyQrTwNX1xG5PdlYUVjdQ3UpyrCXZC3gopJtVsBhnoR7AwNOLJwE6ztlJPcS/k+fyhP0vs4G8E6AdqLVu7GTfguP6ZcFQOS/PuplS78PnB0vlgiO+EZNtIBaYLYqjfDWyqy9Mg2mNKdoh3iCMitAI/ApUL4Ru9VLovUTxgdBLEcjlTpb7tLtLaZpb3k2czQg0Aey3fk6l+df0iE+10fu7BZGPWPbCRvlkapqOuSCP2B91FWzjklHqM2IxvwZAktcrp23fBJ/PvfgNah7Kq5gXErwWx1iegTfWMTw4YEJsqAmcVcdL96HKaxoA04Snsq14bFa0E7VP/VKubOQo7ChhxfKcoGzhA7kK6IJHnvZKsIfGugHq1FueEY3uiBAjHhwgXyu1+T82w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(39860400002)(376002)(346002)(478600001)(26005)(86362001)(5660300002)(956004)(2616005)(6916009)(186003)(36756003)(31696002)(6486002)(8936002)(66946007)(16576012)(316002)(31686004)(53546011)(4326008)(8676002)(2906002)(6666004)(16526019)(66556008)(54906003)(66476007)(83380400001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VnVpS2g5Qm5TVE4wcSt6dU5rbU9GREZ1dlI0OVVmbVlZRFU4Zi9Gd0dSMTJQ?=
 =?utf-8?B?RDZkcUVDeUNxVEZicmxGcFBaMzhpUUdTdExPNmw3UENSSkd5VGpXWWRLZk1S?=
 =?utf-8?B?MjRaWkxaRlEwSUVXQU0wNGVzZ0toTUJtZmlxY1hrVEIzbU16dTZzSUU5Q0xs?=
 =?utf-8?B?bXJ3Nnh0a3pqNnYzOGIyWTVxa1hoeG92Y0pTYjlGRU9mK042YjNNRVFJV2tj?=
 =?utf-8?B?bTlYc1dMeE5yUnpzVytBVS9PQVBPYmRldVpWOGp0V3BnaEdUOU5XUE1nV1FK?=
 =?utf-8?B?Nzk2bU5CSHVRb1NGbXFUTVlocFBpcmkwTDZNVWhaNEEwdWVLUHV2R3NSNEFU?=
 =?utf-8?B?QzRmUnUvbVJBdUlTVHNVN1dHdU95SDhIaVFxK3ZQVUVldEtVbDU2b1Q4eWE3?=
 =?utf-8?B?QTRvemFOZHNsOEZHVTdDclMrQzdiZElVVjRvQ2szaHV0UmRaK3JsSytDSmp2?=
 =?utf-8?B?b0VhNGVid1pMVkU5OWtvM0V3WkdIRkdPaDh4VDVUbkYrOHRJSE1OZmZlTXJI?=
 =?utf-8?B?ZVc0RFU1cXk4M3lDRW45UUFmR1hreUNmdmxhTlR1L1pLcHk1d1N2d1FsOCtH?=
 =?utf-8?B?Zm1IVXU3SVJVaU9ZMlBaUDA1TU9XK0hMNTdQS2JPSVNyRldzMXlDeEh6NkU3?=
 =?utf-8?B?S01jQkFCQytiQUxndDgwejZHM0RKV3V4S2ZsQ2thVkI5TmtrZVU1a2p3bXRK?=
 =?utf-8?B?NTNtc2NNSEQ4R3BDeGxXQ0dGOWdvVEFNN0I4VnpEbWpPem11TnpTL2JsRE44?=
 =?utf-8?B?NU1Jd0poZEVYTGxHb2R2Rzc4VGpOSlg3U01nVWZNMnN0ZjR2Ukh6Q1FIMEtC?=
 =?utf-8?B?bEI0OEViTDVTaEFxZEFNN2xrOTVnTkljcExlelRFU0VicWlMeTZkQnVvNDhX?=
 =?utf-8?B?SkV6ekN1aXVJZW90dkVKN3ByaFVSeHcwcjJxQzVMNGRwRldXTi81QlRVR3Vz?=
 =?utf-8?B?ZEY2UzJkVkg0WmpCZm1XN2lZWmJxQ2pJRWhOQVU1a3I0bnZTUGlBa2VpVE9v?=
 =?utf-8?B?SE9wMVl2OUViem1qUWlOTHRmODhtMGFJWEl4ZWJ1eGtBejlOdG1FdVp2OHUy?=
 =?utf-8?B?YXJDQlR1TEZ6V09zQkxaWFF4QUo3VDlBSTNWakdNY21oS1dyVy9qQko1L3l2?=
 =?utf-8?B?Z0pxS1d2Z0hQSEozTkdjenVwamswUnd5cG1aT0wxS0dCOThoVWtBNTRpUHpa?=
 =?utf-8?B?RjZNeThqM1N4UzgybzNJOGp0Z2hmR1RsZGp5b0l6Nm8vblU4WVBRWWxOVGxn?=
 =?utf-8?B?YnU5c1lIdkp1MEpqN210NlBqOXhRTHZQcDJ2d2tSVkFJcG1udlJxM2lCNlFV?=
 =?utf-8?B?SGdZQnhadDR3QlpOcE5keVgwWnpNbzlkR1VvUVVIYWEyWGl0RzJOMVRKSi9C?=
 =?utf-8?B?RmZvUVlxR2ppM294aHBSaE9HbXRaeFVSTERvQ0lZZlNSUXU1T2RvbE5KZHZK?=
 =?utf-8?B?VFlDaGs2YWdlMURkWUttM3lMMGxRd3pxWllpc2lrN1NRaS9qQkcxdzdKU3hR?=
 =?utf-8?B?K1RwRnd2dzR3STQ3am5mMEJMdUcvSXVoN0lGc0FvVDN0cFRXNTFlNFdnVG9N?=
 =?utf-8?B?UjJJRkpSN0xPRGRidnFUSkF6QjlSQ3Uvc1FWU1Y3ZmU2RXJqdzZwanlmaWpW?=
 =?utf-8?B?emIyMlluLzNSYkpEeTJxbjNMVFhabC8weHFBQkNSM01DcGQwd0lYdnV0Qnc5?=
 =?utf-8?B?dFUwYVFocG83ZjRHLzNWdGMzMUhRUkhLNTBVL25LWktLRXdZNS9zMURYQUht?=
 =?utf-8?Q?ZogHvwOGj4+ByRJLIpJimne9HAbe3B7qWJB1ac9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b453d9c5-f02a-4a27-0011-08d8ce7a19cb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 10:45:08.8900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sa/sxXPrlhaheBVnUYMizegjzikwNh2FHc9GCwbtGX0W3QAqhoWBo2Tm+nk6moMQb1DiOEc2ssHkv3ajQqs0oBEh70udgVxQ1u+MxRR/krQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2552
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110096
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110096
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/10/21 11:20 PM, Jason Gunthorpe wrote:
> On Fri, Feb 05, 2021 at 08:41:24PM +0000, Joao Martins wrote:
>> Add an helper that iterates over head pages in a list of pages. It
>> essentially counts the tails until the next page to process has a
>> different head that the current. This is going to be used by
>> unpin_user_pages() family of functions, to batch the head page refcount
>> updates once for all passed consecutive tail pages.
>>
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>  mm/gup.c | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
Thanks!

> This can be used for check_and_migrate_cma_pages() too (there is a
> series around to change this logic though, not sure if it is landed
> yet)

It got unqueued AFAIUI.

It makes sense for most users today except hugetlb pages, which are also
the fastest page pinner today. And unilaterally using this iterator makes
all page types pay the added cost. So either keeping the current loop having
the exception to PageHuge() head pages, or doing it correctly with that
split logic we were talking on the other thread.

	Joao
