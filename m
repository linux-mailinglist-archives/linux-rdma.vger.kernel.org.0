Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3732D1156C
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 10:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfEBI3B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 04:29:01 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:17665 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfEBI3B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 May 2019 04:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1556785740; x=1588321740;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=5PwnBg3HmEgeKaaKyqDfbdoFGryAt534P0EMWl9w9B0=;
  b=ZP2nA7VNr8zJcrrUIdKxzLoF3Vm0Iqk1QyFwEE8OLEvUXRTZRa4vvwfa
   xqTc2TAwlVAsZaXzlcDXMX52oeKqIBxIEsAAH1f4sjzbM+c1mJpjsMf72
   poJ5t0jEJesWJrs+0xPLgkBWYcLGtcXARnGSlew2n/HNaPa1s4wA8QB4Q
   I=;
X-IronPort-AV: E=Sophos;i="5.60,421,1549929600"; 
   d="scan'208";a="802436712"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 02 May 2019 08:28:57 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x428SrXS019448
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 2 May 2019 08:28:54 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 May 2019 08:28:53 +0000
Received: from [10.218.62.21] (10.43.160.48) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 2 May
 2019 08:28:45 +0000
Subject: Re: [PATCH for-next v6 10/12] RDMA/efa: Add EFA verbs implementation
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Sean Hefty <sean.hefty@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Steve Wise" <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-11-git-send-email-galpress@amazon.com>
 <20190501164020.GA18128@mellanox.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <75f5ded6-ba85-bd67-1a2f-92525f7a6e28@amazon.com>
Date:   Thu, 2 May 2019 11:28:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501164020.GA18128@mellanox.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.48]
X-ClientProxiedBy: EX13D01UWA002.ant.amazon.com (10.43.160.74) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 01-May-19 19:40, Jason Gunthorpe wrote:
> On Wed, May 01, 2019 at 01:48:22PM +0300, Gal Pressman wrote:
> 
>> +int efa_mmap(struct ib_ucontext *ibucontext,
>> +	     struct vm_area_struct *vma)
>> +{
>> +	struct efa_ucontext *ucontext = to_eucontext(ibucontext);
>> +	struct efa_dev *dev = to_edev(ibucontext->device);
>> +	u64 length = vma->vm_end - vma->vm_start;
>> +	u64 key = vma->vm_pgoff << PAGE_SHIFT;
>> +	struct efa_mmap_entry *entry;
>> +
>> +	ibdev_dbg(&dev->ibdev,
>> +		  "start %#lx, end %#lx, length = %#llx, key = %#llx\n",
>> +		  vma->vm_start, vma->vm_end, length, key);
>> +
>> +	if (length % PAGE_SIZE != 0 || !(vma->vm_flags & VM_SHARED)) {
>> +		ibdev_dbg(&dev->ibdev,
>> +			  "length[%#llx] is not page size aligned[%#lx] or VM_SHARED is not set [%#lx]\n",
>> +			  length, PAGE_SIZE, vma->vm_flags);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (vma->vm_flags & VM_EXEC) {
>> +		ibdev_dbg(&dev->ibdev, "Mapping executable pages is not permitted\n");
>> +		return -EPERM;
>> +	}
>> +	vma->vm_flags &= ~VM_MAYEXEC;
> 
> Also we dropped the MAYEXEC stuff

Latest commit that had any MAYEXEC changes is 4eb6ab13b991 ("RDMA: Remove
rdma_user_mmap_page"), where MAYEXEC is added not removed.
Am I missing a followup patch?
