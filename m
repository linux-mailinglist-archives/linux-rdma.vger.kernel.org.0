Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019B733F840
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Mar 2021 19:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhCQSj0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Mar 2021 14:39:26 -0400
Received: from p3plsmtpa09-06.prod.phx3.secureserver.net ([173.201.193.235]:36171
        "EHLO p3plsmtpa09-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232600AbhCQSjR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Mar 2021 14:39:17 -0400
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id Mb4dlJTICYxqlMb4dlAlkd; Wed, 17 Mar 2021 11:39:16 -0700
X-CMAE-Analysis: v=2.4 cv=Aal0o1bG c=1 sm=1 tr=0 ts=60524cd4
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=yPCof4ZbAAAA:8 a=6zzXpc6B5H19Jh9abQgA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: FastLinQ: possible duplicate flush of FastReg and LocalInv
To:     Chuck Lever III <chuck.lever@oracle.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <73EEB368-3E02-4BDD-BE16-4AA9A87A3919@oracle.com>
 <039DFCA1-84BE-4043-8136-423055A12796@oracle.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <b2114710-10d7-eadc-01dd-94d1f862a99e@talpey.com>
Date:   Wed, 17 Mar 2021 14:39:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <039DFCA1-84BE-4043-8136-423055A12796@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMPeUAqGSQuPw7/hXr9p/YvFnOE9G6c9/dXQp3EP4VN6dTzspMilou7WC6ukWWn4w34nmnEB8/wX7YMOYnor7aLCwOIGXNAEmnEozOwgfCyBujLFcISL
 /4QZx/Do9QVuw4L9Cxc1C+vRUjR2uYe2pIJS792kvO1N9vyrT2l/jhTLocsrrUiTkZQwj0PK1mFa1yq4k2ZZuyEhpE0HcSDztFwWiGExHWDLhShAORjAPl+3
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/17/2021 11:14 AM, Chuck Lever III wrote:
> 
>> On Mar 16, 2021, at 3:58 PM, Chuck Lever III <chuck.lever@oracle.com> wrote:
>>
>> Hi-
>>
>> I've been trying to track down some crashes when running NFS/RDMA
>> tests over FastLinQ devices in iWARP mode. To make it stressful,
>> I've enabled disconnect injection, where rpcrdma injects a
>> connection disconnect every so often.
>>
>> As part of a disconnect event, the Receive and Send queues are
>> drained. Sometimes I see a duplicate flush for one or more of
>> memory registration ops. This is not a big deal for FastReq
>> because its completion handler is basically a no-op.
>>
>> But for LocalInv this is a problem. On a flushed completion, the
>> MR is destroyed. If the completion occurs again, of course, all
>> kinds of badness happens because we're DMA-unmapping twice,
>> touching memory that has already been freed, and deleting from a
>> list_head that is poisonous.
>>
>> The last straw is that wc_localinv_done calls the generic RPC layer
>> to indicate that an RPC Reply is ready. The duplicate flush
>> dereferences one or more NULL pointers.
> 
> So this looked to me like a Queue wrap. After sleeping on it, I
> decided to try disabling xprtrdma's Send signal batching. Setting
> ep_send_batch to zero causes every Send WR to be signaled, and
> that makes the problem go away.
> 
> This is a little surprising. Every LocalInv chain is signaled. The
> only possible accounting error might be that ep_send_count does
> not count FastReg WRs, which are always unsignaled.

Well, perhaps you're posting several WRs, and the connection is being
dropped before you post them all. Therefore, you bail out with the
last one you did post being unsignaled. You had better hope that last
one is flushed, because if it completed successfully, you may have a
missing interrupt.

It's really tricky to get unsignaled right, when errors occur. It
might still be the provider, but there are possibilities on both
sides of the API.

> More investigation needed.

Indeed, and good hunting!

Tom.

>> Doesn't the verbs API contract stipulate that every posted WR gets
>> exactly one completion? I don't see this behavior with other
>> providers.
>>
>> Thanks for any advice.
> 
> 
> --
> Chuck Lever
> 
> 
> 
> 
