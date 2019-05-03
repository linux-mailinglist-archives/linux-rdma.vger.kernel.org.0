Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A414312B1C
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2019 11:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfECJyZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 May 2019 05:54:25 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:15991 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfECJyY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 May 2019 05:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1556877263; x=1588413263;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=U4jv0jSSwtN9WsSJkzC2xSqFCIflHnvKCV1WEWiHwK8=;
  b=PEps44/a8oDbKmdz3GElM8E7BjIbS44Ll5I147Ikcfk7sNTsp9HZZq9b
   BgrxdpjyDVtfi1YwKwhorTi5v53peFeqBUT2NIKVY187Kh41cDo9uc86h
   F/hRlOtVbEXOHqTqQ2DPpAZkrBtuv+0yybWD/jR+0t9LI4QlWZ8wV+owy
   4=;
X-IronPort-AV: E=Sophos;i="5.60,425,1549929600"; 
   d="scan'208";a="400650214"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 May 2019 09:54:21 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x439sGft053488
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 3 May 2019 09:54:20 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 3 May 2019 09:54:20 +0000
Received: from [10.95.88.5] (10.43.161.192) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 3 May
 2019 09:54:00 +0000
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
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <7de52e1f-7d4a-354f-a0f6-b8f7eb13ce35@amazon.com>
Date:   Fri, 3 May 2019 12:53:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502181425.GA28282@mellanox.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.192]
X-ClientProxiedBy: EX13D25UWB001.ant.amazon.com (10.43.161.245) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 02-May-19 21:14, Jason Gunthorpe wrote:
> On Wed, May 01, 2019 at 01:48:22PM +0300, Gal Pressman wrote:
> 
>> +/* create a page buffer list from a mapped user memory region */
>> +static int pbl_create(struct efa_dev *dev,
>> +		      struct pbl_context *pbl,
>> +		      struct ib_umem *umem,
>> +		      int hp_cnt,
>> +		      u8 hp_shift)
>> +{
>> +	int err;
>> +
>> +	pbl->pbl_buf_size_in_bytes = hp_cnt * EFA_CHUNK_PAYLOAD_PTR_SIZE;
>> +	pbl->pbl_buf = kzalloc(pbl->pbl_buf_size_in_bytes,
>> +			       GFP_KERNEL | __GFP_NOWARN);
>> +	if (pbl->pbl_buf) {
>> +		pbl->physically_continuous = 1;
>> +		err = umem_to_page_list(dev, umem, pbl->pbl_buf, hp_cnt,
>> +					hp_shift);
>> +		if (err)
>> +			goto err_continuous;
>> +		err = pbl_continuous_initialize(dev, pbl);
>> +		if (err)
>> +			goto err_continuous;
>> +	} else {
>> +		pbl->physically_continuous = 0;
>> +		pbl->pbl_buf = vzalloc(pbl->pbl_buf_size_in_bytes);
>> +		if (!pbl->pbl_buf)
>> +			return -ENOMEM;
> 
> This way to fallback seems ugly, I think you should just call kvzalloc
> and check for continuity during the umem_to_page_list

I've considered using kvzalloc, but it doesn't really fit this use case.

The pbl buffer is not related to the umem continuity, it's a buffer which
describes the MR pages in case the number of pages exceeds the inline size.

In order to use the device "continuous" MR registration mode, we need the pbl
buffer to be physically continuous. Otherwise, the indirect registration mode
should be used, regardless of the umem continuity.
