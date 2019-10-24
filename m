Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66F76E2BBB
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 10:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437997AbfJXIGd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 04:06:33 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:10137 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfJXIGc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Oct 2019 04:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1571904391; x=1603440391;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4ODB4pYnyI759Uof+FiR/5VfbwaqBbOsmcMEn9UkjcU=;
  b=AJb+6tEBAjs/X4/Xcn6gApNymlmPjuX3el4VMNjjGg0aM0jQS+Ch8VTy
   Voi6Y6P+7sHkq4ZfXyO1G8UBsCriCpXRCnEtSfsYbcGHjnKAkWkYNHlNr
   B4MGE/5VWP++o+Dmb/OD0ypGaN0BXGKFkUqPoRzZYJuev1jxqtUzHoILQ
   w=;
X-IronPort-AV: E=Sophos;i="5.68,223,1569283200"; 
   d="scan'208";a="796799428"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 24 Oct 2019 08:06:30 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (Postfix) with ESMTPS id B56DDA222E;
        Thu, 24 Oct 2019 08:06:28 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 24 Oct 2019 08:06:27 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.180) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 24 Oct 2019 08:06:23 +0000
Subject: Re: [PATCH v11 rdma-next 5/7] RDMA/qedr: Use the common mmap API
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "Leybovich, Yossi" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <MN2PR18MB31828BDF43D9CA65A7BF1BC8A1850@MN2PR18MB3182.namprd18.prod.outlook.com>
 <4A66AD43-246B-4256-BA99-B61D3F1D05A8@amazon.com>
 <MN2PR18MB3182999F3ACFC93455B887C8A1840@MN2PR18MB3182.namprd18.prod.outlook.com>
 <f7f91641-6a80-2c06-2d4a-9045b876daff@amazon.com>
 <20191021173349.GH25178@ziepe.ca>
 <215079fa-03bc-1b5b-dfbe-561f6072de94@amazon.com>
 <20191023144124.GM23952@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <512d2f33-8835-102a-1f8b-73acb7061df8@amazon.com>
Date:   Thu, 24 Oct 2019 11:06:18 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023144124.GM23952@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.180]
X-ClientProxiedBy: EX13D15UWA003.ant.amazon.com (10.43.160.182) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 23/10/2019 17:41, Jason Gunthorpe wrote:
> On Wed, Oct 23, 2019 at 09:40:44AM +0300, Gal Pressman wrote:
>>> In the mlx drivers this was done during destruction of the ucontext,
>>> but with this new mmap stuff it could be moved to the mmap_free..
>>
>> Dealloc UAR is currently being called during dealloc_ucontext.
>> The mmap_free callback is per entry, how can dealloc_uar be moved there?
> 
> If it is some global per context uar then sure, it should live till
> dealloc ucontext
> 
> If it is a dynamicly created uar then it should have a shorter
> lifetime.

It's a UAR per ucontext. Created on alloc_ucontext and deallocated on
dealloc_ucontext.
