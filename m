Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8793556AB
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 16:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239306AbhDFOcE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 10:32:04 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:65007 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239052AbhDFOcE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 10:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1617719517; x=1649255517;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=yQb19qdmE0mEOgsfKCO/Tb4O9lH70K+gYvtGCZDMLO0=;
  b=BvG67HWS3M5pDfSSRbBLGkX4rT3QHHWXvF4zSgNMgqDHQC8GSWRg+Fmy
   T8LyxaRyt81u/CvEE2spj1QZUgiHooaXUvMvIrTsD1WMuCknc71eRVPyM
   oqdxWj/uFw+x1eUTD9psBi065/Y7rX7GVMEdeOkFt1qU5nXzIN+lIQixs
   8=;
X-IronPort-AV: E=Sophos;i="5.81,309,1610409600"; 
   d="scan'208";a="105466884"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-397e131e.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 06 Apr 2021 14:31:50 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-397e131e.us-west-2.amazon.com (Postfix) with ESMTPS id EE14CA01FE;
        Tue,  6 Apr 2021 14:31:48 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.207) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 6 Apr 2021 14:31:45 +0000
Subject: Re: [PATCH for-next] RDMA/nldev: Add copy-on-fork attribute to get
 sys command
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20210405114722.98904-1-galpress@amazon.com>
 <YGr7EajqXvSGyZfy@unreal> <d8ec4f81-25a6-7243-12c4-af4f5b64a27f@amazon.com>
 <YGsFHWU8Hqd5LADT@unreal> <9c4cda63-f4bb-2e32-d370-983c5722bd12@amazon.com>
 <20210405221532.GC7721@ziepe.ca> <YGwDQNg3poUONNkv@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <59404383-87bd-aeb9-0816-d0846c4b4862@amazon.com>
Date:   Tue, 6 Apr 2021 17:31:38 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YGwDQNg3poUONNkv@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.207]
X-ClientProxiedBy: EX13D37UWC002.ant.amazon.com (10.43.162.123) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 06/04/2021 9:44, Leon Romanovsky wrote:
> On Mon, Apr 05, 2021 at 07:15:32PM -0300, Jason Gunthorpe wrote:
>> On Mon, Apr 05, 2021 at 04:09:39PM +0300, Gal Pressman wrote:
>>> On 05/04/2021 15:39, Leon Romanovsky wrote:
>>>> On Mon, Apr 05, 2021 at 03:15:18PM +0300, Gal Pressman wrote:
>>>>> On 05/04/2021 14:57, Leon Romanovsky wrote:
>>>>>> On Mon, Apr 05, 2021 at 02:47:21PM +0300, Gal Pressman wrote:
>>>>>>> The new attribute indicates that the kernel copies DMA pages on fork,
>>>>>>> hence libibverbs' fork support through madvise and MADV_DONTFORK is not
>>>>>>> needed.
>>>>>>>
>>>>>>> The introduced attribute is always reported as supported since the
>>>>>>> kernel has the patch that added the copy-on-fork behavior. This allows
>>>>>>> the userspace library to identify older vs newer kernel versions.
>>>>>>> Extra care should be taken when backporting this patch as it relies on
>>>>>>> the fact that the copy-on-fork patch is merged, hence no check for
>>>>>>> support is added.
>>>>>>
>>>>>> Please be more specific, add SHA-1 of that patch and wrote the same
>>>>>> comment near "err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK,
>>>>>> 1);" line.
>>>>>>
>>>>>> Thanks
>>>>>
>>>>> Should I put the original commit here? There were quite a lot of bug fixes and
>>>>> followups that are required.
>>>>
>>>> IMHO, the last commit SHA will be enough, the one that has working
>>>> functionality from your POV.
>>>
>>> OK, so that would be:
>>> 4eae4efa2c29 ("hugetlb: do early cow when page pinned on src mm")
>>
>> No, lets put them all
> 
> The more data the better chance that it will be missed.
> It is much saner to add last commit.

I can gather a list of commits, but I'm not sure I'm aware of every single
commit that's needed to make this work properly, there's a chance some will be
missed.
