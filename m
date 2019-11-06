Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAD3FF10F2
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2019 09:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbfKFIUr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Nov 2019 03:20:47 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:57265 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729878AbfKFIUq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Nov 2019 03:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1573028446; x=1604564446;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=c6JLHtMDfUxOlHxpjILN4ncXyL7snPqOXd1qQEyjAqY=;
  b=tbhuw9yV8G7XUl9LHo2JEq0J6qYbrUCebCKNnpOGpcbNIAtIxSy0qpeG
   ImwTP27oEDJyv9YkKz20SWbRuzot1y0Gz7MHRXLFZH/wo9znSVKvL1xGn
   JyU4xnxmtoAjBYBVqCfXpiegCN0J24sAFk9ihIAsLnk6BWoZyYOys56eS
   c=;
IronPort-SDR: 6861ZAdidjfQw2VHzUPAN7nv+Ty3oydc77P5QYYf5XuQtRqhgGnZeZnAcxkSfUM2icrVDepslh
 rxID4UStXUtw==
X-IronPort-AV: E=Sophos;i="5.68,274,1569283200"; 
   d="scan'208";a="4333277"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 06 Nov 2019 08:20:43 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id B04CAA2713;
        Wed,  6 Nov 2019 08:20:40 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 6 Nov 2019 08:20:39 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.217) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 6 Nov 2019 08:20:35 +0000
Subject: Re: [PATCH v12 rdma-next 4/8] RDMA/efa: Use the common mmap_xa
 helpers
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <michal.kalderon@marvell.com>
CC:     <ariel.elior@marvell.com>, <dledford@redhat.com>,
        <yishaih@mellanox.com>, <bmt@zurich.ibm.com>,
        <linux-rdma@vger.kernel.org>, <sleybo@amazon.com>
References: <20191030094417.16866-1-michal.kalderon@marvell.com>
 <20191030094417.16866-5-michal.kalderon@marvell.com>
 <20191105195459.GA19938@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <a27c98c0-1d18-3090-01cb-3175d2a8f116@amazon.com>
Date:   Wed, 6 Nov 2019 10:20:30 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105195459.GA19938@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.217]
X-ClientProxiedBy: EX13D31UWA001.ant.amazon.com (10.43.160.57) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 05/11/2019 21:54, Jason Gunthorpe wrote:
>>  static int qp_mmap_entries_setup(struct efa_qp *qp,
>>  				 struct efa_dev *dev,
>>  				 struct efa_ucontext *ucontext,
>>  				 struct efa_com_create_qp_params *params,
>>  				 struct efa_ibv_create_qp_resp *resp)
>>  {
>> -	/*
>> -	 * Once an entry is inserted it might be mmapped, hence cannot be
>> -	 * cleaned up until dealloc_ucontext.
>> -	 */
>> -	resp->sq_db_mmap_key =
>> -		mmap_entry_insert(dev, ucontext, qp,
>> -				  dev->db_bar_addr + resp->sq_db_offset,
>> -				  PAGE_SIZE, EFA_MMAP_IO_NC);
>> -	if (resp->sq_db_mmap_key == EFA_MMAP_INVALID)
>> +	size_t length;
>> +	u64 address;
>> +
>> +	address = dev->db_bar_addr + resp->sq_db_offset;
>> +	qp->sq_db_mmap_entry =
>> +		efa_user_mmap_entry_insert(&ucontext->ibucontext,
>> +					   address,
>> +					   PAGE_SIZE, EFA_MMAP_IO_NC,
>> +					   &resp->sq_db_mmap_key);
> 
> I'm still confused how this is OK for the lifetime, 'sq_db_offset'
> comes from the device, does the device prevent re-use of the same
> db_offset until the ucontext is closed? If so that deserves a comment
> in here.

The device prevents reuse of the DB offset until the UAR is deallocated (during
ucontext close). Same applies for the RQ DB and LLQ offset.
