Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC0C25290C
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Aug 2020 10:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgHZIRk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Aug 2020 04:17:40 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:36740 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgHZIRj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Aug 2020 04:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598429859; x=1629965859;
  h=to:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding:subject;
  bh=dP/44Ptio5v+MlzD3Sxrb/NH7qz/VulxLR1D88rDzdk=;
  b=RBxy6/AMRajPfBLgMqWn2RA6Kj/kZXtgVRSD6O+kstXbj6cRNMaX4ZiL
   eONaUejds+73cNjuhk/UwdCWpF8v0t67/RpUdA70pKV0FqDzrospysBKt
   pLLM0k0l5Dag0O9kqmELTvJihDkYVCknUGxhBr4jgbYxhci6SYgojCpta
   k=;
X-IronPort-AV: E=Sophos;i="5.76,354,1592870400"; 
   d="scan'208";a="69797875"
Subject: Re: [PATCH rdma-next 12/14] RDMA/restrack: Support all QP types
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 26 Aug 2020 08:17:34 +0000
Received: from EX13D19EUB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id 45CD1A17B3;
        Wed, 26 Aug 2020 08:17:33 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.85) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 26 Aug 2020 08:17:28 +0000
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        Mark Zhang <markz@nvidia.com>
References: <20200824104415.1090901-1-leon@kernel.org>
 <20200824104415.1090901-13-leon@kernel.org>
 <14ac653e-fc64-589c-e202-09fba6b39020@amazon.com>
 <20200826081324.GJ1362631@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <c1a5c0be-2481-2c88-f197-339e4344d3f0@amazon.com>
Date:   Wed, 26 Aug 2020 11:17:23 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826081324.GJ1362631@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.85]
X-ClientProxiedBy: EX13D35UWB001.ant.amazon.com (10.43.161.47) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 26/08/2020 11:13, Leon Romanovsky wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On Wed, Aug 26, 2020 at 11:03:18AM +0300, Gal Pressman wrote:
>> On 24/08/2020 13:44, Leon Romanovsky wrote:
>>>  /**
>>> - * ib_create_qp - Creates a kernel QP associated with the specified protection
>>> + * ib_create_named_qp - Creates a kernel QP associated with the specified protection
>>>   *   domain.
>>>   * @pd: The protection domain associated with the QP.
>>>   * @qp_init_attr: A list of initial attributes required to create the
>>> @@ -1204,8 +1204,9 @@ static struct ib_qp *create_xrc_qp_user(struct ib_qp *qp,
>>>   *
>>>   * NOTE: for user qp use ib_create_qp_user with valid udata!
>>>   */
>>> -struct ib_qp *ib_create_qp(struct ib_pd *pd,
>>> -                      struct ib_qp_init_attr *qp_init_attr)
>>> +struct ib_qp *ib_create_named_qp(struct ib_pd *pd,
>>> +                            struct ib_qp_init_attr *qp_init_attr,
>>> +                            const char *caller)
>>
>> This function can be static.
>> Also, caller parameter missing from doc.
> 
> This function is referenced from ib_verbs.h. How can it be static?
> 
>>
>>>  {
>>>     struct ib_device *device = pd ? pd->device : qp_init_attr->xrcd->device;
>>>     struct ib_qp *qp;
>>> @@ -1230,7 +1231,7 @@ struct ib_qp *ib_create_qp(struct ib_pd *pd,
>>>     if (qp_init_attr->cap.max_rdma_ctxs)
>>>             rdma_rw_init_qp(device, qp_init_attr);
>>>
>>> -   qp = _ib_create_qp(device, pd, qp_init_attr, NULL, NULL);
>>> +   qp = _ib_create_qp(device, pd, qp_init_attr, NULL, NULL, caller);
>>>     if (IS_ERR(qp))
>>>             return qp;
>>>
>>> @@ -1299,7 +1300,7 @@ struct ib_qp *ib_create_qp(struct ib_pd *pd,
>>>     return ERR_PTR(ret);
>>>
>>>  }
>>> -EXPORT_SYMBOL(ib_create_qp);
>>> +EXPORT_SYMBOL(ib_create_named_qp);
>>
>> Shouldn't ib_create_qp be exported instead?
> 
> Not, ib_create_qp is declared as inline function, so callers need to see
> function referenced in that inline body. The ib_create_named_qp() should
> be exported.

Thought it was the same file for some reason, you're right, makes sense.
