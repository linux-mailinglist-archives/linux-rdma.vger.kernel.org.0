Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1A173BF1A
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 00:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389429AbfFJWEL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 18:04:11 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11391 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389083AbfFJWEL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jun 2019 18:04:11 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfed3da0008>; Mon, 10 Jun 2019 15:04:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 10 Jun 2019 15:04:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 10 Jun 2019 15:04:10 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 10 Jun
 2019 22:03:42 +0000
Subject: Re: [PATCH v2 hmm 11/11] mm/hmm: Remove confusing comment and logic
 from hmm_release
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-12-jgg@ziepe.ca>
 <61ea869d-43d2-d1e5-dc00-cf5e3e139169@nvidia.com>
 <20190610160252.GH18446@mellanox.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <fc1487f0-f11d-8cfa-b843-f2463f3856cb@nvidia.com>
Date:   Mon, 10 Jun 2019 15:03:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190610160252.GH18446@mellanox.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560204251; bh=m0vRLgBt6dZ1z6MC9oHbfkHDtIvOUNsxY1buK+WfrXI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=MK+2nS/lbaNrPz4iFJRfwJz5s4DfaMEYqsiXsGoXHqCxfcGZ/c6Y39e+9nDa6+UtB
         jJaZ82XgncVUF58p4TxaZa2GVqE9wiPvMqe++vyh9odW/s9YHt3Dzt5HffMciwdyHK
         cZ07IuuWfngqG3FKSghgPh1Q5YRRphYqYJrlaOqamBbUyKJGe+iYBsia5cX3iOYmlH
         rVeyOcEQTYjPdpyYTzp+7S7HmcJDJVkE2XognFHTfxchFahTDLbSgtZsttIcyzGN2n
         wiZ/ygt4ODCDB5+mRry4PM3VUSDeqcPhvhLhLjKCbUOnxrpb+Oszoj8fGW2ZBwqFgD
         zEGxzmqRGVrLA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/10/19 9:02 AM, Jason Gunthorpe wrote:
> On Fri, Jun 07, 2019 at 02:37:07PM -0700, Ralph Campbell wrote:
>>
>> On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
>>> From: Jason Gunthorpe <jgg@mellanox.com>
>>>
>>> hmm_release() is called exactly once per hmm. ops->release() cannot
>>> accidentally trigger any action that would recurse back onto
>>> hmm->mirrors_sem.
>>>
>>> This fixes a use after-free race of the form:
>>>
>>>          CPU0                                   CPU1
>>>                                              hmm_release()
>>>                                                up_write(&hmm->mirrors_sem);
>>>    hmm_mirror_unregister(mirror)
>>>     down_write(&hmm->mirrors_sem);
>>>     up_write(&hmm->mirrors_sem);
>>>     kfree(mirror)
>>>                                                mirror->ops->release(mirror)
>>>
>>> The only user we have today for ops->release is an empty function, so this
>>> is unambiguously safe.
>>>
>>> As a consequence of plugging this race drivers are not allowed to
>>> register/unregister mirrors from within a release op.
>>>
>>> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>>
>> I agree with the analysis above but I'm not sure that release() will
>> always be an empty function. It might be more efficient to write back
>> all data migrated to a device "in one pass" instead of relying
>> on unmap_vmas() calling hmm_start_range_invalidate() per VMA.
> 
> I think we have to focus on the *current* kernel - and we have two
> users of release, nouveau_svm.c is empty and amdgpu_mn.c does
> schedule_work() - so I believe we should go ahead with this simple
> solution to the actual race today that both of those will suffer from.
> 
> If we find a need for a more complex version then it can be debated
> and justified with proper context...
> 
> Ok?
> 
> Jason

OK.
I guess we have enough on the plate already :-)
