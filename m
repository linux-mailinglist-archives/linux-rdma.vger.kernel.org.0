Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC24318821
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Feb 2021 11:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhBKK2G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Feb 2021 05:28:06 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58382 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhBKK0B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Feb 2021 05:26:01 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BAJLSJ055722;
        Thu, 11 Feb 2021 10:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=0eA10JUU+vnzOAK2dr4O81XgTl1ViIyOfiYvDxlbexc=;
 b=laaoKgA8EYjWqOrxjC3aoGWPr9mhluMvvg6x+VdIE5f7Y5toSH5zpeY0BeNX06tSsA74
 lneZCv/r/h8Wj/NTZzOF4ZJo0XAKOPOxjajOhoC+RpLnwHcBhEQ1fPkniALFyx53zIYz
 MY+0NeA+FcI8NbRISxaKCKGVbY5nIm24c6O4MivKyrKIn9F5H7xAhJsAmv65RwldmGWi
 /+CLVmHUoq4l7kYbQcTgYKpJ+OuA5yTIsZ/DJpVA1o48FRiT5LC8pP6n0+hmW5oDiN9I
 6NOkR95sl3GTLhoO4jKA2/2qFkEg5maSNIQCgjLP561lyKEd5m5JSnaCRnmME75DIMhA yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36m4upwf6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 10:25:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BAK2TS148191;
        Thu, 11 Feb 2021 10:25:10 GMT
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2052.outbound.protection.outlook.com [104.47.38.52])
        by aserp3030.oracle.com with ESMTP id 36j4prcqj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 10:25:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UejDlFgI5c2DI1rgdNm1L1DEgAGwQ5MA992yVDdLdFUD2oP6CO29Zwk/TAQGU2+X4l3I6bFEERPXQpTPecWX3SR8FeXnAGCw2/NTA2FlrQm4/bAfmtIAv3vQ7641dP/5Z50ZaQ9Y9Zlnj25gxnRNvLkpcUIe2BMopndfKvdt63fVWNCE8dr1Cj3mnIZLuCBvs2v+rvgTkGg1y06OVZcAn5xnKXoZVwJUjLTXT2UxU3C/e/qlEfo22xJhMHH6KoC4Jl+zwZScBkOoCGo9976W3K/VnYxun5HzKiHcIBDGUtaS8iko333E3jDSYxvpooDhJ2byF86oFKIptkFe5t37yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eA10JUU+vnzOAK2dr4O81XgTl1ViIyOfiYvDxlbexc=;
 b=jJw4DHlzXKH5wUN4YVo/k4bnJklxRoPw/DkrLjea2KM3Qyv8Ef51vsApC/IpfA+Imjqn1aWxODErkdKK9NrJukX6jTI/SeSOgtz2SdZOFFYh6RGTaBMM4mODKMV02x53H7XpuNHRXE8rPhG8+IU72PVVre4KpZvGVTm89OJRVDH5LiZneJyKgv9/wsxckDNijYrx9DBJFL3VqnIs6QNnjsqBk3YDorYz4C6uHB/QhV7gx0YrYqjKYxtmdeWVze4dkh559Lvy2/GnaRhhhPGSVH0yTAyOZsTySoMuJocTb/PJWErHHyEQ5qd+w9aklGiKLWDjXBW9EOM391HqYANSvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eA10JUU+vnzOAK2dr4O81XgTl1ViIyOfiYvDxlbexc=;
 b=Ez6FkfEJzRfIg7bqlPwS/42VANsnL4mXpDBDNzYCmGTOJ9v7/Ng97uG9rbElwBcsBEkDicoc9Z6eF59//153y+j+cfLzBYgIEqG9TWOnDEpqht44fOvwoQf51L39keRe3mIxGMyhj8WktFx3nXUvD0X2F5fQqjmrGpGnFvE4YWw=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB3398.namprd10.prod.outlook.com (2603:10b6:a03:15c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.24; Thu, 11 Feb
 2021 10:25:07 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3825.030; Thu, 11 Feb 2021
 10:25:07 +0000
Subject: Re: [PATCH v3 3/4] mm/gup: add a range variant of
 unpin_user_pages_dirty_lock()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210205204127.29441-1-joao.m.martins@oracle.com>
 <20210205204127.29441-4-joao.m.martins@oracle.com>
 <20210210231519.GR4718@ziepe.ca>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <073406d4-6fcf-e21a-d16b-db129184bcab@oracle.com>
Date:   Thu, 11 Feb 2021 10:24:59 +0000
In-Reply-To: <20210210231519.GR4718@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0465.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::20) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO4P123CA0465.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1aa::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Thu, 11 Feb 2021 10:25:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6e8eb34-ed31-44c6-eac2-08d8ce774d9f
X-MS-TrafficTypeDiagnostic: BYAPR10MB3398:
X-Microsoft-Antispam-PRVS: <BYAPR10MB33984CA66699D45F7D57D564BB8C9@BYAPR10MB3398.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xizj0qbAsBia/1onjYEQnu9NvPiXnYRTUgw7PYHCdSwi8qDdhnqGRKNteaShovldNm5IAfOva3gewHWjfD905VuAyeaHTuWU6uGQDYq6ASE+8W78zMM7xRe7O1UDh0Cso/mwjiZbvCDxPkiVxUZLMIJug6SkUQ2dv/pS7YdajvXnrftPTcasv+pviboXjsGMWDiaRSixE0UFsECJDb1y2nKh52bykFX/Crj79FlHcXPbfBWTNnMadpXpEsFc+QMUeWWG9eWG5vhMqgh5A/MMm461kdxoMV9xvdMqNQ32Zq3oGuymiM+5QZIsXRcPTzPMUuIIYq4ORMdQZI8YdFUWNAZuD5yflt0tsh9zzqlMvH8i0egVC06y0Ek3XT3BJlwrrHy31vxRmDWxyXVtnvQ45CLt8eEjFaslQ4kGizm092o0emzend+4insSM0TsgygKBhl9yVCJPv1RBJvd+nxEs3aYaKyV7aTg/YJlhle1mDYe1Hq7w9XQD4uScQMjPXVGd7PTjYwKXU6EwAn2CPys9NEgMfIixAlnDlXUAwVfX8hDylyaU0BJcRPndlqkfG4BmvMlSRChKdfHOHMFIPHXOS7XQfryDjKMzoA7+2rwtI8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(366004)(396003)(346002)(6486002)(8676002)(186003)(5660300002)(2906002)(2616005)(36756003)(956004)(16526019)(26005)(31686004)(6916009)(66556008)(8936002)(66946007)(4326008)(478600001)(316002)(54906003)(16576012)(66476007)(83380400001)(6666004)(86362001)(31696002)(53546011)(14143004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a1daWjZ5M3VsdUxTNFFSUXdHRFA5TkdXV2Z5dnEwd1cxd0s5bGVUY1RuUWgx?=
 =?utf-8?B?UDhaU1h2b2xBNThXbWkveDJBRXBsbWF1UEV4bXhvdlB3amxCN1JuV3AyS3dI?=
 =?utf-8?B?Z0NMY2NhZlBvNE9LNWtGRGdKeVNLVVVrL2xhS3QrUWpSN3drdHlUalRPdk8z?=
 =?utf-8?B?YVgrUGRnQ0M0MnFpOUVpa0ZzMzJDZGpCek9SVEt5NXI4RzhjK0ZQVnY0dUZC?=
 =?utf-8?B?SENGNW9qT2pJVFl2NGJLdkFmU24weGVNUEwwc0FIWUJ4RDVqdm9nbjBjeGJD?=
 =?utf-8?B?akl6Skl0dnZWbTlVUjlCdllYQnNrL1lra1Q0dk9lUXViNFJaQ3lWQXNTUVFm?=
 =?utf-8?B?THR5Z1ppODZaOUhmU2hyWCtiVzJJK1lacmVRTWVLS1MxaGNURmFEc3QxczAr?=
 =?utf-8?B?dnVBZTNnT2RzY1BScU5Fcm05YkRMY2F4M3pERXFUNDk5SU56cUhodkpOeG50?=
 =?utf-8?B?SjhsWlJUV2Q3SXF2cGE4YVhDdHEwRUNQbTAxSDVmUTl2UnpZZVJXaHJPdjZz?=
 =?utf-8?B?WitDb0tnK01GeXIvZzZJa21WZ1Q3ZTJEWDBWQy8yWHNTSmQ3ck41elVYV3BM?=
 =?utf-8?B?aTNacE9sN0Z5K0VubG1RVGpQR0lXcnF6OTNtUmIzV25kZHZJbDVNZXIvb2Zz?=
 =?utf-8?B?K3ExbmJOZGpZRlk4NGxmM3dXNVpiVlhvQ2RNSWY4emxCMVk1QjNRZ0pXaHM0?=
 =?utf-8?B?UG1tNC81YlFnUEdWMExFZngvRUZLNG85am5pQjRFZ3lnNXFjY1NMUTA4bmJq?=
 =?utf-8?B?cWpQZkxRQzZvdkd2eENRZlNiZnBCdVhnamkwNXFHbEhNZ0hRdmFQSFl6RkRZ?=
 =?utf-8?B?MXE5dFllbGVxR01GVjJvUzFwT3lSOFRwUVFoRnBNeHFCbGtGdENtRmcxOE12?=
 =?utf-8?B?N1o3ZlNrV1dBeXZyYkFYSnJNTDkzb0JvTmozK2RkY1ZZQThzTnJjYllwSWxh?=
 =?utf-8?B?SmJVK1o5VlhHajJJT25maVBJbndqY2RSR0ZZcVFyZU9hL2hrMS94djk1dzhl?=
 =?utf-8?B?OUFSQzJjRW12Q2VNRmZjaTF6Z0VBdnphU3VlOS83Tk92UTVDbFp0WG1tNnNV?=
 =?utf-8?B?OEhvenZwMWNOa3dzQU9abSs1SzZXZ2FRSUlSNVk5dnMxZHA4SXBpR1dCVDhW?=
 =?utf-8?B?eStZREF2MEZadzh4NnJjV21yeXU2Qm1SdUI0bDJJazlFRXg5OUxVd2RpajFr?=
 =?utf-8?B?ZzBuTHVNR3lLa2FpWXREaTBVemZua2dRczhkQlh0c045WkFpVXJRcnpxUjc5?=
 =?utf-8?B?dU9ySklEZ0ViMWw2VnFBSVd6bHdTZkNTdStZSGllMjN1L2M1WjhnWTh2eEx6?=
 =?utf-8?B?NTVycDU5OVZMRjMzdzBuUG9iNDJqeEM0cVpoSHRBUko0djcvN3ZMVkg0aUZy?=
 =?utf-8?B?MjFCVzZOd0lFR1ltcVhWNnhDZVpUTEE4c1k5dy9GaURxSmVYR09vaThGY3kv?=
 =?utf-8?B?RXh6d1RLYkdXdWtNNml5LzRMNXJRcStjVG52QzQvZ1d5K3BCRU9qa3ZUN25S?=
 =?utf-8?B?cVlOZTFNT1RqdzRrY0NzZWRHNmM2eXlTN29DVjJBKzRTNlJIR3R2d09YWEdX?=
 =?utf-8?B?aEk2MzFkekxqRTUybnZ4K0lLV3BLbmJXSEY1MXl5dENlT3BMcU50RGVLYVN3?=
 =?utf-8?B?STZ2TkVGNEpGMTRodG8xSGRhM1dsUUtmMFptMk9GNjBZbUZhbUJ5dVg0NVkz?=
 =?utf-8?B?Wngvd2tDVVl1NnlVV0ZLNVZQc3JFMmpsVmh5SGtjZWdSTlE5eENEM1JtOE54?=
 =?utf-8?Q?vOFZITKBw75DW/c379jPvLgi1sHu2rr5iurAvM2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e8eb34-ed31-44c6-eac2-08d8ce774d9f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 10:25:07.5019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: es9Y6U9/eZpj9q1e7YyctxhPjRhzf7qWxYG962ZoIAlmlPqKr5rsE5okjL3Z1w8T2pQviY32GaadcGIpLrtW+Rsgb4BWmLuxej4678yAEhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3398
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110092
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110091
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/10/21 11:15 PM, Jason Gunthorpe wrote:
> On Fri, Feb 05, 2021 at 08:41:26PM +0000, Joao Martins wrote:
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
>>  include/linux/mm.h |  2 ++
>>  mm/gup.c           | 62 ++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 64 insertions(+)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
Thanks!

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
> 
> Tidy this language though, this only works with the pin_user_pages
> variants because it hardwires FOLL_PIN
> 
Yes, I can respin a v4 with that adjustment.
