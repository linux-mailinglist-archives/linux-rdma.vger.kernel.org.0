Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47CF35423D
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Apr 2021 15:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbhDENKE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Apr 2021 09:10:04 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:44314 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbhDENKE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Apr 2021 09:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1617628199; x=1649164199;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=frEQ7nWUGSpGa2tk3ue7d909+LnYmI8drPXibq4qsL4=;
  b=erCxdfL5+g2BlhnYHEWFDoEqDO9Ngr+mgxjRmGuUmNLZK+oMwkph9Wgr
   8ROmnW5IErijDG2Gsho2DE3WQZFYvlti0eDK9ArC2tSiN0ZPtZfXu7cVK
   y3fSIOeDXPNro0EoB7PG5vAsvHlvcGo8taVEu5xcjhOEjIFjN1NfH8C8n
   E=;
X-IronPort-AV: E=Sophos;i="5.81,306,1610409600"; 
   d="scan'208";a="99183340"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 05 Apr 2021 13:09:51 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id 48EA7A2271;
        Mon,  5 Apr 2021 13:09:48 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.86) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 5 Apr 2021 13:09:45 +0000
Subject: Re: [PATCH for-next] RDMA/nldev: Add copy-on-fork attribute to get
 sys command
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20210405114722.98904-1-galpress@amazon.com>
 <YGr7EajqXvSGyZfy@unreal> <d8ec4f81-25a6-7243-12c4-af4f5b64a27f@amazon.com>
 <YGsFHWU8Hqd5LADT@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <9c4cda63-f4bb-2e32-d370-983c5722bd12@amazon.com>
Date:   Mon, 5 Apr 2021 16:09:39 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YGsFHWU8Hqd5LADT@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.86]
X-ClientProxiedBy: EX13D08UWC002.ant.amazon.com (10.43.162.168) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 05/04/2021 15:39, Leon Romanovsky wrote:
> On Mon, Apr 05, 2021 at 03:15:18PM +0300, Gal Pressman wrote:
>> On 05/04/2021 14:57, Leon Romanovsky wrote:
>>> On Mon, Apr 05, 2021 at 02:47:21PM +0300, Gal Pressman wrote:
>>>> The new attribute indicates that the kernel copies DMA pages on fork,
>>>> hence libibverbs' fork support through madvise and MADV_DONTFORK is not
>>>> needed.
>>>>
>>>> The introduced attribute is always reported as supported since the
>>>> kernel has the patch that added the copy-on-fork behavior. This allows
>>>> the userspace library to identify older vs newer kernel versions.
>>>> Extra care should be taken when backporting this patch as it relies on
>>>> the fact that the copy-on-fork patch is merged, hence no check for
>>>> support is added.
>>>
>>> Please be more specific, add SHA-1 of that patch and wrote the same
>>> comment near "err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK,
>>> 1);" line.
>>>
>>> Thanks
>>
>> Should I put the original commit here? There were quite a lot of bug fixes and
>> followups that are required.
> 
> IMHO, the last commit SHA will be enough, the one that has working
> functionality from your POV.

OK, so that would be:
4eae4efa2c29 ("hugetlb: do early cow when page pinned on src mm")

Which I now realize for-next isn't rebased on top of it yet, so these patches
should be applied after rebasing to v5.12-rc5.
