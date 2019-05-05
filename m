Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B97313E66
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2019 10:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfEEINS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 May 2019 04:13:18 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:9149 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfEEINS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 May 2019 04:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1557043997; x=1588579997;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=2aIpqsKSSkmZj9eWDZlzZVWQQI8Jv1LfP4DrKn+YWDU=;
  b=enD7jDWlxNIhIwY6pHaXkvLVLsfKfjifS07SxrDNxsSocsYUf5Fx23id
   WF8cgyWihMH8KebA4hCz5wgXqIHF7ht1+XqfV8vofpVWsBrnsD4f7DkR6
   GhFhGtKnIEAmM0VDM16km5V4g+VSGM1scU+YbxwTIccBfUirOi+wWokrD
   0=;
X-IronPort-AV: E=Sophos;i="5.60,433,1549929600"; 
   d="scan'208";a="395211259"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 May 2019 08:13:15 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x458DBwD084396
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 5 May 2019 08:13:14 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 5 May 2019 08:13:13 +0000
Received: from [10.218.62.21] (10.43.162.53) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 5 May
 2019 08:13:06 +0000
Subject: Re: [PATCH for-next v6 10/12] RDMA/efa: Add EFA verbs implementation
To:     Jason Gunthorpe <jgg@mellanox.com>
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
 <20190502181425.GA28282@mellanox.com>
 <7de52e1f-7d4a-354f-a0f6-b8f7eb13ce35@amazon.com>
 <20190503121947.GB13315@mellanox.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <ed36cf91-7420-2533-9202-fa1126bd467b@amazon.com>
Date:   Sun, 5 May 2019 11:13:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503121947.GB13315@mellanox.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.53]
X-ClientProxiedBy: EX13D13UWB003.ant.amazon.com (10.43.161.233) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 03-May-19 15:19, Jason Gunthorpe wrote:
> On Fri, May 03, 2019 at 12:53:55PM +0300, Gal Pressman wrote:
>> On 02-May-19 21:14, Jason Gunthorpe wrote:
>>> On Wed, May 01, 2019 at 01:48:22PM +0300, Gal Pressman wrote:
>>>
>>>> +/* create a page buffer list from a mapped user memory region */
>>>> +static int pbl_create(struct efa_dev *dev,
>>>> +		      struct pbl_context *pbl,
>>>> +		      struct ib_umem *umem,
>>>> +		      int hp_cnt,
>>>> +		      u8 hp_shift)
>>>> +{
>>>> +	int err;
>>>> +
>>>> +	pbl->pbl_buf_size_in_bytes = hp_cnt * EFA_CHUNK_PAYLOAD_PTR_SIZE;
>>>> +	pbl->pbl_buf = kzalloc(pbl->pbl_buf_size_in_bytes,
>>>> +			       GFP_KERNEL | __GFP_NOWARN);
>>>> +	if (pbl->pbl_buf) {
>>>> +		pbl->physically_continuous = 1;
>>>> +		err = umem_to_page_list(dev, umem, pbl->pbl_buf, hp_cnt,
>>>> +					hp_shift);
>>>> +		if (err)
>>>> +			goto err_continuous;
>>>> +		err = pbl_continuous_initialize(dev, pbl);
>>>> +		if (err)
>>>> +			goto err_continuous;
>>>> +	} else {
>>>> +		pbl->physically_continuous = 0;
>>>> +		pbl->pbl_buf = vzalloc(pbl->pbl_buf_size_in_bytes);
>>>> +		if (!pbl->pbl_buf)
>>>> +			return -ENOMEM;
>>>
>>> This way to fallback seems ugly, I think you should just call kvzalloc
>>> and check for continuity during the umem_to_page_list
>>
>> I've considered using kvzalloc, but it doesn't really fit this use case.
> 
> It does, you just check for continuity when building the pbl instead
> of assuming it based on how it was created. It isn't hard, and drivers
> shouldn't abuse APIs like this

This is by no means abusing the API..

I honestly can't see how calling kvzalloc and trying to figure out whether the
buffer is continuous or not is better than a clear flow that asks for a
continuous buffer and falls back when it's not possible.
It would work, but there's no need to over complicate simple things.
