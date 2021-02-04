Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9AB30F7FC
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 17:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238062AbhBDQbg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 11:31:36 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43996 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237981AbhBDQbD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Feb 2021 11:31:03 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114GEHh6033384;
        Thu, 4 Feb 2021 16:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=MuLVVv5SgSuo1joacCjKos3KyNDdmdVfxSZ+s7NWwsE=;
 b=wNjAfBB0ZHOTRVTn5KnwAsAYs32OQv6UU6uMMqtDxpvSijpIuEx+zDbcGYj7S9HosQ0Z
 9ZCdj1WJpYvUWs18yERYRZ2B1b4cgyZ91Owg4CIcFLsnmULRwa99K8tKtz2pC2jifWTq
 AvyGP8oBL1NL8RU7qwlxtCEXndPwXmc5XGGEbN4/AetM1xH1N+y+9jVeWeWmWCxDRSy0
 28Y+eSdmbwlOI6El2VW8hfeufDkBrUn2FTFdvqYeE/nEESUunhPq4fGDPdpjvPWR/57D
 JVlf2r9zo2TwMSGs/oMwEWrnlC0ykaJQ5kjYkEW0dJkw8nZsSO8h/ScTIy5W09pjScx0 qw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36cxvr8tn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 16:30:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114GEh5I192819;
        Thu, 4 Feb 2021 16:30:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 36dhd1k4v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 16:30:09 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 114GU6qV004009;
        Thu, 4 Feb 2021 16:30:06 GMT
Received: from [10.175.182.162] (/10.175.182.162)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Feb 2021 08:30:06 -0800
Subject: Re: [PATCH 3/4] mm/gup: add a range variant of
 unpin_user_pages_dirty_lock()
From:   Joao Martins <joao.m.martins@oracle.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
References: <20210203220025.8568-1-joao.m.martins@oracle.com>
 <20210203220025.8568-4-joao.m.martins@oracle.com>
 <5e372e25-7202-e0b6-0763-d267698db5b6@nvidia.com>
 <99b410dd-5e18-92a7-9ddf-009a671c2894@oracle.com>
Message-ID: <781583d3-b4d4-2cb0-8e6f-0875f4ba4624@oracle.com>
Date:   Thu, 4 Feb 2021 16:30:03 +0000
MIME-Version: 1.0
In-Reply-To: <99b410dd-5e18-92a7-9ddf-009a671c2894@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040101
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040101
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/4/21 11:35 AM, Joao Martins wrote:
> On 2/3/21 11:37 PM, John Hubbard wrote:
>> On 2/3/21 2:00 PM, Joao Martins wrote:
>>> -static inline unsigned int count_ntails(struct page **pages, unsigned long npages)
>>> +static inline unsigned int count_ntails(struct page **pages,
>>> +					unsigned long npages, bool range)
>>>   {
>>> -	struct page *head = compound_head(pages[0]);
>>> +	struct page *page = pages[0], *head = compound_head(page);
>>>   	unsigned int ntails;
>>>   
>>> +	if (range)
>>> +		return (!PageCompound(head) || compound_order(head) <= 1) ? 1 :
>>> +		   min_t(unsigned int, (head + compound_nr(head) - page), npages);
>>
>> Here, you clearly should use a separate set of _range routines. Because you're basically
>> creating two different routines here! Keep it simple.
>>
>> Once you're in a separate routine, you might feel more comfortable expanding that to
>> a more readable form, too:
>>
>> 	if (!PageCompound(head) || compound_order(head) <= 1)
>> 		return 1;
>>
>> 	return min_t(unsigned int, (head + compound_nr(head) - page), npages);
>>
> Yes.
> 
> Let me also try instead to put move everything into two sole iterator helper routines,
> compound_next() and compound_next_range(), and thus get rid of this count_ntails(). It
> should also help in removing a compound_head() call which should save cycles.
> 

As mentioned earlier, I got rid of count_ntails and the ugly boolean. Plus addressed the
missing docs -- fwiw, I borrowed unpin_user_pages_dirty_lock() docs and modified a bit.

Partial diff below, hopefully it is looking better now:

diff --git a/mm/gup.c b/mm/gup.c
index 5a3dd235017a..4ef36c8990e3 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -215,6 +215,34 @@ void unpin_user_page(struct page *page)
 }
 EXPORT_SYMBOL(unpin_user_page);

+static inline void range_next(unsigned long i, unsigned long npages,
+                             struct page **list, struct page **head,
+                             unsigned int *ntails)
+{
+       struct page *next, *page;
+       unsigned int nr = 1;
+
+       if (i >= npages)
+               return;
+
+       npages -= i;
+       next = *list + i;
+
+       page = compound_head(next);
+       if (PageCompound(page) && compound_order(page) > 1)
+               nr = min_t(unsigned int,
+                          page + compound_nr(page) - next, npages);
+
+       *head = page;
+       *ntails = nr;
+}
+
+#define for_each_compound_range(__i, __list, __npages, __head, __ntails) \
+       for (__i = 0, \
+            range_next(__i, __npages, __list, &(__head), &(__ntails)); \
+            __i < __npages; __i += __ntails, \
+            range_next(__i, __npages, __list, &(__head), &(__ntails)))
+
 static inline void compound_next(unsigned long i, unsigned long npages,
                                 struct page **list, struct page **head,
                                 unsigned int *ntails)
@@ -306,6 +334,42 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long
npages,
 }
 EXPORT_SYMBOL(unpin_user_pages_dirty_lock);

+/**
+ * unpin_user_page_range_dirty_lock() - release and optionally dirty
+ * gup-pinned page range
+ *
+ * @page:  the starting page of a range maybe marked dirty, and definitely released.
+ * @npages: number of consecutive pages to release.
+ * @make_dirty: whether to mark the pages dirty
+ *
+ * "gup-pinned page range" refers to a range of pages that has had one of the
+ * get_user_pages() variants called on that page.
+ *
+ * For the page ranges defined by [page .. page+npages], make that range (or
+ * its head pages, if a compound page) dirty, if @make_dirty is true, and if the
+ * page range was previously listed as clean.
+ *
+ * set_page_dirty_lock() is used internally. If instead, set_page_dirty() is
+ * required, then the caller should a) verify that this is really correct,
+ * because _lock() is usually required, and b) hand code it:
+ * set_page_dirty_lock(), unpin_user_page().
+ *
+ */
+void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
+                                     bool make_dirty)
+{
+       unsigned long index;
+       struct page *head;
+       unsigned int ntails;
+
+       for_each_compound_range(index, &page, npages, head, ntails) {
+               if (make_dirty && !PageDirty(head))
+                       set_page_dirty_lock(head);
+               put_compound_head(head, ntails, FOLL_PIN);
+       }
+}
+EXPORT_SYMBOL(unpin_user_page_range_dirty_lock);
+
