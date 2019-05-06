Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5396714482
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 08:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfEFGjN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 02:39:13 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:24441 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfEFGjN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 02:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1557124752; x=1588660752;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=KpimV79S1ihoqlAfPwTRtdxT1sDfsOPzVoD5VbCEces=;
  b=A5KpCyXtfErH9TAGQ3M0irc1x+DufmFmCi2Wzk8SImbSWvNgel8d3cSa
   4KUfbhPsvQOKuzMpr0c0AAUHdkCGv62KIAapyQwkeKioGpcHn7KMmacZ5
   Bvgdwo7Db3bK/bT12qft0cz71uxL3Np1N5ZyEeRH2H7N5ey5qkBm/b+dZ
   w=;
X-IronPort-AV: E=Sophos;i="5.60,437,1549929600"; 
   d="scan'208";a="672765084"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-8549039f.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 May 2019 06:39:10 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-8549039f.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x466d4BR032731
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 6 May 2019 06:39:08 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 6 May 2019 06:39:08 +0000
Received: from [10.218.62.23] (10.43.161.10) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 6 May
 2019 06:39:00 +0000
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
 <ed36cf91-7420-2533-9202-fa1126bd467b@amazon.com>
 <20190505123500.GA30659@mellanox.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <b471d491-99bf-fbae-7859-05e7b652de2c@amazon.com>
Date:   Mon, 6 May 2019 09:38:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190505123500.GA30659@mellanox.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.10]
X-ClientProxiedBy: EX13D17UWC001.ant.amazon.com (10.43.162.188) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 05-May-19 15:35, Jason Gunthorpe wrote:
> On Sun, May 05, 2019 at 11:13:01AM +0300, Gal Pressman wrote:
>> On 03-May-19 15:19, Jason Gunthorpe wrote:
>>> On Fri, May 03, 2019 at 12:53:55PM +0300, Gal Pressman wrote:
>>>> On 02-May-19 21:14, Jason Gunthorpe wrote:
>>>>> On Wed, May 01, 2019 at 01:48:22PM +0300, Gal Pressman wrote:
>>>>>
>>>>>> +/* create a page buffer list from a mapped user memory region */
>>>>>> +static int pbl_create(struct efa_dev *dev,
>>>>>> +		      struct pbl_context *pbl,
>>>>>> +		      struct ib_umem *umem,
>>>>>> +		      int hp_cnt,
>>>>>> +		      u8 hp_shift)
>>>>>> +{
>>>>>> +	int err;
>>>>>> +
>>>>>> +	pbl->pbl_buf_size_in_bytes = hp_cnt * EFA_CHUNK_PAYLOAD_PTR_SIZE;
>>>>>> +	pbl->pbl_buf = kzalloc(pbl->pbl_buf_size_in_bytes,
>>>>>> +			       GFP_KERNEL | __GFP_NOWARN);
>>>>>> +	if (pbl->pbl_buf) {
>>>>>> +		pbl->physically_continuous = 1;
>>>>>> +		err = umem_to_page_list(dev, umem, pbl->pbl_buf, hp_cnt,
>>>>>> +					hp_shift);
>>>>>> +		if (err)
>>>>>> +			goto err_continuous;
>>>>>> +		err = pbl_continuous_initialize(dev, pbl);
>>>>>> +		if (err)
>>>>>> +			goto err_continuous;
>>>>>> +	} else {
>>>>>> +		pbl->physically_continuous = 0;
>>>>>> +		pbl->pbl_buf = vzalloc(pbl->pbl_buf_size_in_bytes);
>>>>>> +		if (!pbl->pbl_buf)
>>>>>> +			return -ENOMEM;
>>>>>
>>>>> This way to fallback seems ugly, I think you should just call kvzalloc
>>>>> and check for continuity during the umem_to_page_list
>>>>
>>>> I've considered using kvzalloc, but it doesn't really fit this use case.
>>>
>>> It does, you just check for continuity when building the pbl instead
>>> of assuming it based on how it was created. It isn't hard, and drivers
>>> shouldn't abuse APIs like this
>>
>> This is by no means abusing the API..
> 
> It is, vzalloc isn't just kzalloc followed by vzalloc and you
> shouldn't expec the two to be the same. Most likely the above has bad
> behavior if it triggers reclaim.

Is it OK to call kvzalloc and test for is_vmalloc_addr?
