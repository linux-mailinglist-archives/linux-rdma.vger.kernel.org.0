Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DF5344D06
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 18:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhCVRPW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 13:15:22 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:55730 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbhCVROw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Mar 2021 13:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1616433292; x=1647969292;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=uoJ5tCRsm5qDjdt9ANICn2DwrHa4Z1Z30wYC+wX8RfM=;
  b=MbR+WdKCKXAPnrh17/C06q78U6k3WcN4tS7lbBZ0H2ToI2MRXzQWuaKL
   zB2WAePCCjSChMFmDx/uWAf+n8vll2LRZaITrZwqizAlit9IITDTMA3CE
   1DMBIZt+3VLb0W20P7k1KFm41Jcx8yELmC3+JeaxKLMC6XULtjrqgL1Tp
   0=;
X-IronPort-AV: E=Sophos;i="5.81,269,1610409600"; 
   d="scan'208";a="122261733"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 22 Mar 2021 17:14:45 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 3F7AE240ABA;
        Mon, 22 Mar 2021 17:14:43 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.160.27) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 22 Mar 2021 17:14:40 +0000
Subject: Re: [PATCH for-next] RDMA/efa: Use strscpy instead of strlcpy
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20210316132416.83578-1-galpress@amazon.com>
 <20210322130131.GC247894@nvidia.com>
 <fd35f82a-abd8-ff53-d8d2-0e401ec92ea0@amazon.com>
 <20210322165546.GX2356281@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <382540a1-248f-878f-0e1a-4caaa6839a6a@amazon.com>
Date:   Mon, 22 Mar 2021 19:14:35 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210322165546.GX2356281@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.27]
X-ClientProxiedBy: EX13D08UWC002.ant.amazon.com (10.43.162.168) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 22/03/2021 18:55, Jason Gunthorpe wrote:
> On Mon, Mar 22, 2021 at 03:11:33PM +0200, Gal Pressman wrote:
>>
>> On 22/03/2021 15:01, Jason Gunthorpe wrote:
>>> On Tue, Mar 16, 2021 at 03:24:16PM +0200, Gal Pressman wrote:
>>>> The strlcpy function doesn't limit the source length, use the preferred
>>>> strscpy function instead.
>>>
>>> Why do we need to limit the source length here? Either this is a bug
>>> because the source string is no NULL terminated or it is OK as is?
>>
>> It's not a bug as is, but it addresses checkpatch's warning:
>> WARNING: Prefer strscpy over strlcpy - see: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
> 
> Okay.. but why is it so weird:
> 
>         strscpy(hinf->kernel_ver_str, utsname()->version,
>                 min(sizeof(hinf->kernel_ver_str), sizeof(utsname()->version)));
> 
> ?
> 
> utsname()->version is null terminated, yes? Why does it need to be
> min'd?

The size of the kernel buffer is different than the device buffer (65B vs 32B),
the min() is there to prevent overflow regardless of the NULL termination.
A NULL terminated 60 bytes utsname would be truncated to 32 bytes.
