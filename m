Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54E9295E36
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Oct 2020 14:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898033AbgJVMTQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Oct 2020 08:19:16 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:27559 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898032AbgJVMTP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Oct 2020 08:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1603369155; x=1634905155;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=utkkQ8UoFPUL/rGolphwe3w7VDsA87OBcDA8J+gnehc=;
  b=jxmEEAXI4ZP5BAPNVm/eHu2VL3HuplqOdjLWp/duxatf0VrVjcN0T/mE
   iDgicxGuoTLwh2K0wKD2JPswT/cSVcrQJViGw/kwqo+bgurLGOOPeBcBE
   yRQmUp2//AmM5k6DV6ovZLYw3ToDkWLOh9+n718xLOW64rCg+7b7cyoT9
   s=;
X-IronPort-AV: E=Sophos;i="5.77,404,1596499200"; 
   d="scan'208";a="79195543"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 22 Oct 2020 12:19:09 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id 28907A1E65;
        Thu, 22 Oct 2020 12:16:05 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.35) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 22 Oct 2020 12:16:01 +0000
Subject: Re: New GID query API broke EFA
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>
CC:     Avihai Horon <avihaih@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        "Leybovich, Yossi" <sleybo@amazon.com>
References: <3e956560-3c76-5f4b-b8fa-ad96483cd042@amazon.com>
 <20201022112100.GE2611066@unreal> <20201022121035.GX6219@nvidia.com>
 <460e8221-6837-0428-7401-52d2ef5d8a4c@amazon.com>
Message-ID: <40b69829-e02d-a67a-b98a-a6d34ee62e54@amazon.com>
Date:   Thu, 22 Oct 2020 15:15:55 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <460e8221-6837-0428-7401-52d2ef5d8a4c@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.35]
X-ClientProxiedBy: EX13D32UWB004.ant.amazon.com (10.43.161.36) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 22/10/2020 15:12, Gal Pressman wrote:
> On 22/10/2020 15:10, Jason Gunthorpe wrote:
>> On Thu, Oct 22, 2020 at 02:21:00PM +0300, Leon Romanovsky wrote:
>>> On Thu, Oct 22, 2020 at 01:58:29PM +0300, Gal Pressman wrote:
>>>> Hi all,
>>>>
>>>> The new IOCTL query GID API 9f85cbe50aa0 ("RDMA/uverbs: Expose the new GID query
>>>> API to user space") currently breaks EFA, as ibv_query_gid() no longer works.
>>>>
>>>> The problem is that the IOCTL call checks for:
>>>>     if (!rdma_ib_or_roce(ib_dev, port_num))
>>>>             return -EOPNOTSUPP;
>>>>
>>>> EFA is neither of these, but it uses GIDs.
>>>>
>>>> Any objections to remove the check? Any other solutions come to mind?
>>>
>>> We added this check to protect access to rdma_get_gid_attr() for devices
>>> without GID table.
>>>  1234         table = rdma_gid_table(device, port_num);
>>>  1235         if (index < 0 || index >= table->sz)
>>>  1236                 return ERR_PTR(-EINVAL);
>>>
>>> So you can extend that function to return for table == NULL an error and
>>> remove rdma_ib_or_roce()
>>
>> How does table == NULL ever?
> 
> A driver with gid_tbl_len == 0 would make the allocation return NULL, no?

Nevermind, we don't really allocate with gid_tbl_len as the size, and any
allocation failure will fail ib_register_device().
So I guess there is no way for it to be NULL.
