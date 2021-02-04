Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBAF30F754
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 17:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbhBDQLg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 11:11:36 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:38594 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbhBDQLF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Feb 2021 11:11:05 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114FTq47074760;
        Thu, 4 Feb 2021 16:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=xZf+hDqYfmhTpcrvofd4NDvRcZvCYzc3fW3t/ZTJ/kQ=;
 b=B7g5g7eH/pZXhhCkqJFU3keNmkk2okupptP+DzVHjFwbQxTCpcA5Tt06Z8gmFbVFeyjp
 JjAcSfDqXY6XCb0/RVpJe7B8ACzHnzqWcdGSf1p9yCGwUpdfrY+2P0vnvkjYqLj9iMxj
 0htApneNJ3NTbJAESxfW6uVZV7qu+kZOM0qfo/g841ISez1KUAmGd3yvlVuKkYNgv6Wr
 EFdHtFvMpUZIhGWg0a36w0CUts7MDShJy4RoA3ZTYB7qyjBWBjUAsiwTW9wwDp3i4ln6
 IEOpZy44nPt+M0OIp8AhSBKjXvck0jvF6jdQYBCadki1iiwgZbrF2ulLgPJn16tcLaUe 7g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36cvyb654d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 16:10:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114FVMLC021136;
        Thu, 4 Feb 2021 16:10:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 36dhc2vdjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 16:10:09 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 114G9xD3027544;
        Thu, 4 Feb 2021 16:10:00 GMT
Received: from [10.175.182.162] (/10.175.182.162)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Feb 2021 08:09:59 -0800
Subject: Re: [PATCH 1/4] mm/gup: add compound page list iterator
From:   Joao Martins <joao.m.martins@oracle.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
References: <20210203220025.8568-1-joao.m.martins@oracle.com>
 <20210203220025.8568-2-joao.m.martins@oracle.com>
 <955dbe68-7302-a8bc-f0b5-e9032d7f190e@nvidia.com>
 <fd4b981c-cf25-dc04-7f10-549ea16bf644@oracle.com>
Message-ID: <82fe62c0-f746-cf9d-a784-6384946d94a1@oracle.com>
Date:   Thu, 4 Feb 2021 16:09:56 +0000
MIME-Version: 1.0
In-Reply-To: <fd4b981c-cf25-dc04-7f10-549ea16bf644@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040100
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040100
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/4/21 11:27 AM, Joao Martins wrote:
> On 2/3/21 11:00 PM, John Hubbard wrote:
>> On 2/3/21 2:00 PM, Joao Martins wrote:
>>> Add an helper that iterates over head pages in a list of pages. It
>>> essentially counts the tails until the next page to process has a
>>> different head that the current. This is going to be used by
>>> unpin_user_pages() family of functions, to batch the head page refcount
>>> updates once for all passed consecutive tail pages.
>>>
>>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> ---
>>>   mm/gup.c | 29 +++++++++++++++++++++++++++++
>>>   1 file changed, 29 insertions(+)
>>>
>>> diff --git a/mm/gup.c b/mm/gup.c
>>> index d68bcb482b11..4f88dcef39f2 100644
>>> --- a/mm/gup.c
>>> +++ b/mm/gup.c
>>> @@ -215,6 +215,35 @@ void unpin_user_page(struct page *page)
>>>   }
>>>   EXPORT_SYMBOL(unpin_user_page);
>>>   
>>> +static inline unsigned int count_ntails(struct page **pages, unsigned long npages)
>>
>> Silly naming nit: could we please name this function count_pagetails()? count_ntails
>> is a bit redundant, plus slightly less clear.
>>
> Hmm, pagetails is also a tiny bit redundant. Perhaps count_subpages() instead?
> 
> count_ntails is meant to be 'count number of tails' i.e. to align terminology with head +
> tails which was also suggested over the other series.
> 
Given your comment on the third patch, I reworked a bit and got rid of the count_ntails.

So it's looking like this, also the macro arguments renaming as well):

diff --git a/mm/gup.c b/mm/gup.c
index d68bcb482b11..d1549c61c2f6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -215,6 +215,35 @@ void unpin_user_page(struct page *page)
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
+       list += i;
+       npages -= i;
+       page = compound_head(*list);
+
+       for (nr = 1; nr < npages; nr++) {
+               if (compound_head(list[nr]) != page)
+                       break;
+       }
+
+       *head = page;
+       *ntails = nr;
+}
+
+#define for_each_compound_head(__i, __list, __npages, __head, __ntails) \
+       for (__i = 0, \
+            compound_next(__i, __npages, __list, &(__head), &(__ntails)); \
+            __i < __npages; __i += __ntails, \
+            compound_next(__i, __npages, __list, &(__head), &(__ntails)))
+
 /**
  * unpin_user_pages_dirty_lock() - release and optionally dirty gup-pinned pages
  * @pages:  array of pages to be maybe marked dirty, and definitely released.

