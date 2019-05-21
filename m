Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58DCD257FB
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 21:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfEUTGE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 15:06:04 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:29026 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbfEUTGE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 May 2019 15:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1558465563; x=1590001563;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=VAnyiDFpZW39W3KXGQ8YwrLESsfmV/bFwQRgrJzprCY=;
  b=crtjBs59L2qeVX3YDV+W5aOPZAezH9UvNZTnn78PqYhnLhaOW5T/AqMM
   NKQsd5d4Me8aEpOlwndzcIhqNzc0ewei5ZXiIcJ1TArLWLvurhcStYn/Z
   r+sK/drauMzHz4vvhb5lDMTAEEItjhJmL88/JJ1rW9TMOqgA6II6sFT61
   I=;
X-IronPort-AV: E=Sophos;i="5.60,496,1549929600"; 
   d="scan'208";a="403119338"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 May 2019 19:06:01 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x4LJ5vRT060335
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 21 May 2019 19:06:00 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 21 May 2019 19:05:59 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.38) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 21 May 2019 19:05:55 +0000
Subject: Re: [PATCH rdma-next 04/15] RDMA/efa: Remove check that prevents
 destroy of resources in error flows
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
References: <20190520065433.8734-1-leon@kernel.org>
 <20190520065433.8734-5-leon@kernel.org>
 <a3358e40-9be4-0a7c-dab5-96573b646ded@amazon.com>
 <20190520131000.GJ4573@mtr-leonro.mtl.com>
 <161ad83d-cb50-d02a-8511-938b2b3b7156@amazon.com>
 <20190521173514.GH2907@mellanox.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <3e957c76-5959-2b6a-f29e-09a4e2436258@amazon.com>
Date:   Tue, 21 May 2019 22:05:44 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521173514.GH2907@mellanox.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.38]
X-ClientProxiedBy: EX13D16UWB003.ant.amazon.com (10.43.161.194) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 21/05/2019 20:35, Jason Gunthorpe wrote:
> On Mon, May 20, 2019 at 05:24:43PM +0300, Gal Pressman wrote:
> 
>>>>> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>>>>>  drivers/infiniband/hw/efa/efa_verbs.c | 24 ------------------------
>>>>>  1 file changed, 24 deletions(-)
>>>>>
>>>>> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
>>>>> index 6d6886c9009f..4999a74cee24 100644
>>>>> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
>>>>> @@ -436,12 +436,6 @@ void efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
>>>>>  	struct efa_dev *dev = to_edev(ibpd->device);
>>>>>  	struct efa_pd *pd = to_epd(ibpd);
>>>>>
>>>>> -	if (udata->inlen &&
>>>>> -	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
>>>>> -		ibdev_dbg(&dev->ibdev, "Incompatible ABI params\n");
>>>>> -		return;
>>>>> -	}
> 
> Regardless of the issue of udata validity, these checks still cannot
> be here.
> 
> We are moving the whole core to not return error codes from driver
> object destroy - because destroy is not allowed to fail in many flows.

What is the reason for that?

> 
> So, drivers do not have the option to validate the udata and fail
> destroy at this point. If it ever comes up, then we will need to split
> validation into another step on the uapi path that is done before
> invoking the actual destroy function.

Is it really necessary? The udata in these flows is new, so there's no reason
any driver won't be able to work with a cleared udata and fail the validations,
even if it expands it in the future.

> 
> Generally speaking this means a driver should never use a classical
> udata for destroy.
> 
> Instead its provider should call destroy via the new-style ioctl API
> and the kernel should define a proper schema that is checked before we
> even reach the driver.

Sounds good, agree that the checks should be removed for now.

Thanks Leon,
Acked-by: Gal Pressman <galpress@amazon.com>
