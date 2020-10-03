Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC4728243B
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Oct 2020 15:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgJCNMc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Oct 2020 09:12:32 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13197 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgJCNMb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 3 Oct 2020 09:12:31 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7878560003>; Sat, 03 Oct 2020 06:10:46 -0700
Received: from [10.21.38.85] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 3 Oct
 2020 13:12:24 +0000
Subject: Re: reduce iSERT Max IO size
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     <linux-rdma@vger.kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Max Gurtovoy <maxg@mellanox.com>
References: <20200922104424.GA18887@chelsio.com>
 <07e53835-8389-3e07-6976-505edbd94f2a@grimberg.me>
 <20201002171007.GA16636@chelsio.com>
 <4d0b1a3f-2980-c7ed-ef9a-0ed6a9c87a69@grimberg.me>
 <20201003033644.GA19516@chelsio.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <79d59e36-246b-45b7-788c-4f156890339d@nvidia.com>
Date:   Sat, 3 Oct 2020 16:12:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201003033644.GA19516@chelsio.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601730646; bh=tyMdwJVUyogJSRwI6MDQBsjuLfezJKOwxvKWvF0j+dY=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=EJmmcWWoCjYGqeKVE7Crndli5APsyeNHr3SQk53s2o265yNTWUm/2CUgEPXLYcKn6
         roCsrv0IBV/Y5G02dU5qaqz5sS931NjDoRRhMY36eZ1/nVs4YjEARv3peu5/gV8FsN
         9oyxoO62iAaU2MJW+yB7zCvgLV6BRV+2oI+Nf4OP9xgksWnhYzc/FmijodSzbaw9f8
         rMAJVuzcmag0qzas+UhZaSOUbtCjkYEoTYsStBx3zHfdcZyhkewI/5t4zLt6+f48WR
         qN3EfnnS/kZUKRWn3vrvH/gsSc6QYKFsVsj1RUdzMvkkGVKd3YtJh+Jp+MACLYBx6o
         0jOQDEJMbcI7w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 10/3/2020 6:36 AM, Krishnamraju Eraparaju wrote:
> On Friday, October 10/02/20, 2020 at 13:29:30 -0700, Sagi Grimberg wrote:
>>> Hi Sagi & Max,
>>>
>>> Any update on this?
>>> Please change the max IO size to 1MiB(256 pages).
>> I think that the reason why this was changed to handle the worst case
>> was in case there are different capabilities on the initiator and the
>> target with respect to number of pages per MR. There is no handshake
>> that aligns expectations.
> But, the max pages per MR supported by most adapters is around 256 pages
> only.

Not sure you're right.

> And I think only those iSER initiators, whose max pages per MR is 4096,
> could send 16MiB sized IOs, am I correct?

If the initiator can send 16MiB, we must make sure the target is capable 
to receive it.

>
>> If we revert that it would restore the issue that you reported in the
>> first place:
>>
>> --
>> IB/isert: allocate RW ctxs according to max IO size
> I don't see the reported issue after reducing the IO size to 256
> pages(keeping all other changes of this patch intact).
> That is, "attr.cap.max_rdma_ctxs" is now getting filled properly with
> "rdma_rw_mr_factor()" related changes, I think.
>
> Before this change "attr.cap.max_rdma_ctxs" was hardcoded with
> 128(ISCSI_DEF_XMIT_CMDS_MAX) pages, which is very low for single target
> and muli-luns case.
>
> So reverting only ISCSI_ISER_MAX_SG_TABLESIZE macro to 256 doesn't cause the
> reported issue.
>
> Thanks,
> Krishnam Raju.
>> Current iSER target code allocates MR pool budget based on queue size.
>> Since there is no handshake between iSER initiator and target on max IO
>> size, we'll set the iSER target to support upto 16MiB IO operations and
>> allocate the correct number of RDMA ctxs according to the factor of MR's
>> per IO operation. This would guaranty sufficient size of the MR pool for
>> the required IO queue depth and IO size.
>>
>> Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
>> Tested-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>> --
>>
>>>
>>> Thanks,
>>> Krishnam Raju.
>>> On Wednesday, September 09/23/20, 2020 at 01:57:47 -0700, Sagi Grimberg wrote:
>>>>> Hi,
>>>>>
>>>>> Please reduce the Max IO size to 1MiB(256 pages), at iSER Target.
>>>>> The PBL memory consumption has increased significantly after increasing
>>>>> the Max IO size to 16MiB(with commit:317000b926b07c).
>>>>> Due to the large MR pool, the max no.of iSER connections(On one variant
>>>>> of Chelsio cards) came down to 9, before it was 250.
>>>>> NVMe-RDMA target also uses 1MiB max IO size.
>>>> Max, remind me what was the point to support 16M? Did this resolve
>>>> an issue?
