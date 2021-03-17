Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C111333F533
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Mar 2021 17:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhCQQMT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Mar 2021 12:12:19 -0400
Received: from p3plsmtpa06-06.prod.phx3.secureserver.net ([173.201.192.107]:38999
        "EHLO p3plsmtpa06-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231954AbhCQQL7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Mar 2021 12:11:59 -0400
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id MXlslSiWXEYmdMXltlCAty; Wed, 17 Mar 2021 08:07:41 -0700
X-CMAE-Analysis: v=2.4 cv=adukITkt c=1 sm=1 tr=0 ts=60521b3d
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=uRI6DqEH897CDaSaUxwA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: FastLinQ: possible duplicate flush of FastReg and LocalInv
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
References: <73EEB368-3E02-4BDD-BE16-4AA9A87A3919@oracle.com>
 <OFEAF169BA.A8545B4F-ON0025869B.002EFC4D-0025869B.0030ECF0@notes.na.collabserv.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <0d502080-bf39-1873-4d48-b98206ef9080@talpey.com>
Date:   Wed, 17 Mar 2021 11:07:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <OFEAF169BA.A8545B4F-ON0025869B.002EFC4D-0025869B.0030ECF0@notes.na.collabserv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMk6kIXOSxF5kCHWQqSEztnzhkiSLMUdcvvU71KevVGcJrnzDhb1NVS+6aOwhfXPO/n+8b0nZ6uZa6droxSO2caxLuMQuA6dsCW5OoLxnSauc2QTHLzn
 M0hZloxyEEYDx26wtWWwqa8zKUmtdASEahw2L1DReMSBmBM/z1HA0L/POByIzfHjdhSBhnmAAB/bNHcC0tMi6gwSuOdZTc+3VoIJSeAOScV3NltlbQOhjM5q
 MJUdcQEBBwYmDMjvQ68aCg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/17/2021 4:54 AM, Bernard Metzler wrote:
> -----"Chuck Lever III" <chuck.lever@oracle.com> wrote: -----
> 
>> To: "linux-rdma" <linux-rdma@vger.kernel.org>
>> From: "Chuck Lever III" <chuck.lever@oracle.com>
>> Date: 03/16/2021 08:59PM
>> Subject: [EXTERNAL] FastLinQ: possible duplicate flush of FastReg and
>> LocalInv
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
>>
>> Doesn't the verbs API contract stipulate that every posted WR gets
>> exactly one completion? I don't see this behavior with other
>> providers.
>>
> Indeed. Nothing else is defined and applications obviously
> rely on correctness in that respect.

Totally agree - any WR successfully posted must be completed, exactly
once. A missing or multiple completion is a provider bug.

Chuck, you might verify that every ib_post_send() call return code
is being checked. If you missed an error, that would allow for a
missed completion. But never a double completion, that's on the
provider.

Tom.
