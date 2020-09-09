Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D194F262A01
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 10:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgIIITJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Sep 2020 04:19:09 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:52582 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgIIITI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Sep 2020 04:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1599639548; x=1631175548;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=45BC4yv5wtqiUn4+pxh9kj3t1j8pD0yFkt5hA7y3I8M=;
  b=u6XnoI6Y6AqoY6dWOx66z/HJaGCTngo/kyNsiPlGC70rzTzOzweUs8he
   oNJJMEfmi15SIip6JOfqHFvdkryLb/wT8CmiqK2bxaThHoirDuO2aykWE
   AlU4pFTE/SYYtJLKSewD+JhXcrr6kT7oX4+eyBo206eqbZ41wWaO2xWgY
   4=;
X-IronPort-AV: E=Sophos;i="5.76,409,1592870400"; 
   d="scan'208";a="73496428"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 09 Sep 2020 08:19:01 +0000
Received: from EX13D19EUB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS id 230C3A0647;
        Wed,  9 Sep 2020 08:19:00 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.167) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 9 Sep 2020 08:18:54 +0000
Subject: Re: [PATCH v2 07/17] RDMA/efa: Use ib_umem_num_dma_pages()
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        Firas JahJah <firasj@amazon.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <7-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
 <d9cb7f02-86d0-25d6-1314-cc048fd1ebae@amazon.com>
 <20200908134852.GE9166@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <b1b96707-59f8-5c5d-d529-6f6d9ed16d9f@amazon.com>
Date:   Wed, 9 Sep 2020 11:18:49 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200908134852.GE9166@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.167]
X-ClientProxiedBy: EX13D34UWA003.ant.amazon.com (10.43.160.69) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 08/09/2020 16:48, Jason Gunthorpe wrote:
> On Mon, Sep 07, 2020 at 03:19:54PM +0300, Gal Pressman wrote:
>> On 05/09/2020 1:41, Jason Gunthorpe wrote:
>>> If ib_umem_find_best_pgsz() returns > PAGE_SIZE then the equation here is
>>> not correct. 'start' should be 'virt'. Change it to use the core code for
>>> page_num and the canonical calculation of page_shift.
>>
>> Should I submit a fix for stable changing start to virt?
> 
> I suspect EFA users never use ibv_reg_mr_iova() so won't have an
> actual bug?

That's still a driver bug though, regardless of the userspace so I'd rather fix it.
Should I submit a patch to for-rc? It would conflict with the for-next one.
