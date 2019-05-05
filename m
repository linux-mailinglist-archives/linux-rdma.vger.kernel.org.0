Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18CB213E32
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2019 09:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfEEHgy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 May 2019 03:36:54 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:25968 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfEEHgy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 May 2019 03:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1557041813; x=1588577813;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=kbjMTMymfZmO1XlpYagXj+hGyul0HPM2n2oxgyDXYLU=;
  b=KZvm+dS1SRUtVZY6BYKjV6zaU49CG0VUlJ76DlOeQXMdfzQA2JTAJzKu
   ZB6vav8gZFypr8WXTHM3rxIKLDKtNUCF8/MUFbPC+hPXwxKRpcAClKdcv
   SzXxj9TSLMf3FTy6boqeB5gS0tzdFZ3zrMTKgusPHtdm+LcBy0jUvp6qu
   E=;
X-IronPort-AV: E=Sophos;i="5.60,431,1549929600"; 
   d="scan'208";a="395210085"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 May 2019 07:36:51 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x457aiWX091560
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 5 May 2019 07:36:50 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 5 May 2019 07:36:49 +0000
Received: from [10.218.62.21] (10.43.162.53) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 5 May
 2019 07:36:41 +0000
Subject: Re: [PATCH for-next v6 10/12] RDMA/efa: Add EFA verbs implementation
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Sean Hefty <sean.hefty@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-11-git-send-email-galpress@amazon.com>
 <20190501164020.GA18128@mellanox.com>
 <75f5ded6-ba85-bd67-1a2f-92525f7a6e28@amazon.com>
 <20190502084600.GQ7676@mtr-leonro.mtl.com>
 <20190502174722.GD27871@mellanox.com>
 <f77f2b44-27d7-f8e2-311e-57b5a89d3ed2@amazon.com>
 <20190503122114.GD13315@mellanox.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <b803ae84-669f-62e5-f230-d671becdac85@amazon.com>
Date:   Sun, 5 May 2019 10:36:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503122114.GD13315@mellanox.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.53]
X-ClientProxiedBy: EX13D16UWB004.ant.amazon.com (10.43.161.170) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 03-May-19 15:21, Jason Gunthorpe wrote:
> On Fri, May 03, 2019 at 12:32:58PM +0300, Gal Pressman wrote:
>> On 02-May-19 20:47, Jason Gunthorpe wrote:
>>> On Thu, May 02, 2019 at 11:46:00AM +0300, Leon Romanovsky wrote:
>>>> On Thu, May 02, 2019 at 11:28:40AM +0300, Gal Pressman wrote:
>>>>> On 01-May-19 19:40, Jason Gunthorpe wrote:
>>>>>> On Wed, May 01, 2019 at 01:48:22PM +0300, Gal Pressman wrote:
>>>>>>
>>>>>>> +int efa_mmap(struct ib_ucontext *ibucontext,
>>>>>>> +	     struct vm_area_struct *vma)
>>>>>>> +{
>>>>>>> +	struct efa_ucontext *ucontext = to_eucontext(ibucontext);
>>>>>>> +	struct efa_dev *dev = to_edev(ibucontext->device);
>>>>>>> +	u64 length = vma->vm_end - vma->vm_start;
>>>>>>> +	u64 key = vma->vm_pgoff << PAGE_SHIFT;
>>>>>>> +	struct efa_mmap_entry *entry;
>>>>>>> +
>>>>>>> +	ibdev_dbg(&dev->ibdev,
>>>>>>> +		  "start %#lx, end %#lx, length = %#llx, key = %#llx\n",
>>>>>>> +		  vma->vm_start, vma->vm_end, length, key);
>>>>>>> +
>>>>>>> +	if (length % PAGE_SIZE != 0 || !(vma->vm_flags & VM_SHARED)) {
>>>>>>> +		ibdev_dbg(&dev->ibdev,
>>>>>>> +			  "length[%#llx] is not page size aligned[%#lx] or VM_SHARED is not set [%#lx]\n",
>>>>>>> +			  length, PAGE_SIZE, vma->vm_flags);
>>>>>>> +		return -EINVAL;
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	if (vma->vm_flags & VM_EXEC) {
>>>>>>> +		ibdev_dbg(&dev->ibdev, "Mapping executable pages is not permitted\n");
>>>>>>> +		return -EPERM;
>>>>>>> +	}
>>>>>>> +	vma->vm_flags &= ~VM_MAYEXEC;
>>>>>>
>>>>>> Also we dropped the MAYEXEC stuff
>>>>>
>>>>> Latest commit that had any MAYEXEC changes is 4eb6ab13b991 ("RDMA: Remove
>>>>> rdma_user_mmap_page"), where MAYEXEC is added not removed.
>>>>> Am I missing a followup patch?
>>>>
>>>> I'm not aware of any.
>>>
>>> It was a mistake it wasn't removed from that commit too.
>>
>> Can you explain please?
> 
> We dropped all the MAYEXEC stuff and that case got missed - it should
> have been dropped too

Why is MAYEXEC not needed?
