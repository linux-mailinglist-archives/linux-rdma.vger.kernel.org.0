Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF9F31EC2B
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Feb 2021 17:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhBRQSi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Feb 2021 11:18:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54018 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbhBRQDH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Feb 2021 11:03:07 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11IFsxwa090548;
        Thu, 18 Feb 2021 16:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=nTz7w5Opw4DmOhfWAocEaDsHyoTqepWVqxAx/g/DeoM=;
 b=t6F58OSzo8VILfR7YsFSPiWiWrvUWxT+YtL6u7aFgMeBh5+o2QfNVG+jiATga6XEwB5g
 7gG5B4enmaBOEVOZswGXWTpSc4T7tO1QgCYoqFfJ+4ArSZGZduitVBumJVr6Ey5qsQ0/
 ijjTVDBdrhuTm3QrbL1uEn5MiiQqljk8H1tsg0VAW9XN/MVWfWVSPvK5vI9XgBSc9uLp
 rOqfjC1NNpcTDi9P/IA141EG6hFaZtKQzUbgEBONY32Um/jrq0bylfJPyj+fIeenh5pG
 zlyhGpcpkQjMSykeN/gKLwQavRcGGzlyiFh8FX3MUKTwlUkbvUwNetpWbKfl54KD93ok ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 36p66r6es2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 16:02:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11IFoSwU115383;
        Thu, 18 Feb 2021 16:02:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 36prbqxdxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 16:02:05 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11IG1wHl014059;
        Thu, 18 Feb 2021 16:01:59 GMT
Received: from [10.175.202.26] (/10.175.202.26)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Feb 2021 08:01:58 -0800
Subject: Re: [PATCH v4 0/4] mm/gup: page unpining improvements
From:   Joao Martins <joao.m.martins@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210212130843.13865-1-joao.m.martins@oracle.com>
 <20210218072432.GA325423@infradead.org>
 <a5f7d591-f3aa-1a54-569c-bd1abcb99334@oracle.com>
Message-ID: <8a93027f-edd4-45e0-8fbd-aac9a31e8644@oracle.com>
Date:   Thu, 18 Feb 2021 16:01:54 +0000
MIME-Version: 1.0
In-Reply-To: <a5f7d591-f3aa-1a54-569c-bd1abcb99334@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9898 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=923 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102180139
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9898 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=937
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102180139
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/18/21 3:33 PM, Joao Martins wrote:
> On 2/18/21 7:24 AM, Christoph Hellwig wrote:
>> On Fri, Feb 12, 2021 at 01:08:39PM +0000, Joao Martins wrote:
>>> Hey,
>>>
>>> This series improves page unpinning, with an eye on improving MR
>>> deregistration for big swaths of memory (which is bound by the page
>>> unpining), particularly:
>>
>> Can you also take a look at the (bdev and iomap) direct I/O code to
>> make use of this?  It should really help there, with a much wieder use
>> than RDMA.
>>
> Perhaps by bdev and iomap direct I/O using this, you were thinking to replace
> bio_release_pages() which operates on bvecs and hence releasing contiguous pages
> in a bvec at once? e.g. something like from this:
> 
>         bio_for_each_segment_all(bvec, bio, iter_all) {
>                 if (mark_dirty && !PageCompound(bvec->bv_page))
>                         set_page_dirty_lock(bvec->bv_page);
>                 put_page(bvec->bv_page);
>         }
> 
> (...) to this instead:
> 
> 	bio_for_each_bvec_all(bvec, bio, i)
> 		unpin_user_page_range_dirty_lock(bvec->bv_page,
> 			DIV_ROUND_UP(bvec->bv_len, PAGE_SIZE),
> 			mark_dirty && !PageCompound(bvec->bv_page));
> 

Quick correction: It should be put_user_page_range_dirty_lock() given that unpin is
specific to FOLL_PIN users.
