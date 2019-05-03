Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16BE312A9E
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2019 11:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfECJd1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 May 2019 05:33:27 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:44050 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfECJdZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 May 2019 05:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1556876004; x=1588412004;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=YHvFAAP/2wUklpBKl0LXRtjY4c25y/1Q84TFmkOK2Bs=;
  b=D2/jYDRUq8FpUWwdZUln888BB7bYPSBVLY9quz4BWqactbYPo1nE3frC
   qrXIMYdEIM+3AHoak67igevbk72JeRgBQ97NkIRBeHcZjQNG1eVpMC0pr
   a1Xe0EWOaVdvQRz5O+kMtCDFfl70Hde0WFWwS8Z5i1ri5N3lWo0lGK9uT
   0=;
X-IronPort-AV: E=Sophos;i="5.60,425,1549929600"; 
   d="scan'208";a="672395528"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 May 2019 09:33:21 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x439XHVT002578
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 3 May 2019 09:33:18 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 3 May 2019 09:33:17 +0000
Received: from [10.95.88.5] (10.43.161.192) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 3 May
 2019 09:33:09 +0000
Subject: Re: [PATCH for-next v6 10/12] RDMA/efa: Add EFA verbs implementation
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
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
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <f77f2b44-27d7-f8e2-311e-57b5a89d3ed2@amazon.com>
Date:   Fri, 3 May 2019 12:32:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502174722.GD27871@mellanox.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.192]
X-ClientProxiedBy: EX13D01UWA003.ant.amazon.com (10.43.160.107) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 02-May-19 20:47, Jason Gunthorpe wrote:
> On Thu, May 02, 2019 at 11:46:00AM +0300, Leon Romanovsky wrote:
>> On Thu, May 02, 2019 at 11:28:40AM +0300, Gal Pressman wrote:
>>> On 01-May-19 19:40, Jason Gunthorpe wrote:
>>>> On Wed, May 01, 2019 at 01:48:22PM +0300, Gal Pressman wrote:
>>>>
>>>>> +int efa_mmap(struct ib_ucontext *ibucontext,
>>>>> +	     struct vm_area_struct *vma)
>>>>> +{
>>>>> +	struct efa_ucontext *ucontext = to_eucontext(ibucontext);
>>>>> +	struct efa_dev *dev = to_edev(ibucontext->device);
>>>>> +	u64 length = vma->vm_end - vma->vm_start;
>>>>> +	u64 key = vma->vm_pgoff << PAGE_SHIFT;
>>>>> +	struct efa_mmap_entry *entry;
>>>>> +
>>>>> +	ibdev_dbg(&dev->ibdev,
>>>>> +		  "start %#lx, end %#lx, length = %#llx, key = %#llx\n",
>>>>> +		  vma->vm_start, vma->vm_end, length, key);
>>>>> +
>>>>> +	if (length % PAGE_SIZE != 0 || !(vma->vm_flags & VM_SHARED)) {
>>>>> +		ibdev_dbg(&dev->ibdev,
>>>>> +			  "length[%#llx] is not page size aligned[%#lx] or VM_SHARED is not set [%#lx]\n",
>>>>> +			  length, PAGE_SIZE, vma->vm_flags);
>>>>> +		return -EINVAL;
>>>>> +	}
>>>>> +
>>>>> +	if (vma->vm_flags & VM_EXEC) {
>>>>> +		ibdev_dbg(&dev->ibdev, "Mapping executable pages is not permitted\n");
>>>>> +		return -EPERM;
>>>>> +	}
>>>>> +	vma->vm_flags &= ~VM_MAYEXEC;
>>>>
>>>> Also we dropped the MAYEXEC stuff
>>>
>>> Latest commit that had any MAYEXEC changes is 4eb6ab13b991 ("RDMA: Remove
>>> rdma_user_mmap_page"), where MAYEXEC is added not removed.
>>> Am I missing a followup patch?
>>
>> I'm not aware of any.
> 
> It was a mistake it wasn't removed from that commit too.

Can you explain please?
