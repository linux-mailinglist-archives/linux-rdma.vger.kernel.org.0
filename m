Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEA530839C
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Jan 2021 03:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhA2CPY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jan 2021 21:15:24 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:39072 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229819AbhA2CPX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jan 2021 21:15:23 -0500
X-IronPort-AV: E=Sophos;i="5.79,384,1602518400"; 
   d="scan'208";a="103962996"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Jan 2021 10:14:35 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 9F2114CE67AB;
        Fri, 29 Jan 2021 10:14:35 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 29 Jan 2021 10:14:35 +0800
Message-ID: <60136F89.4070402@cn.fujitsu.com>
Date:   Fri, 29 Jan 2021 10:14:33 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Leon Romanovsky <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>
Subject: Re: [RFC PATCH] RDMA/rxe: Export imm_data to WC when the related
 WR with imm_data finished on SQ
References: <20210127082431.2637863-1-yangx.jy@cn.fujitsu.com> <20210127120427.GJ1053290@unreal> <601259D7.1040207@cn.fujitsu.com> <20210128125421.GC5097@unreal>
In-Reply-To: <20210128125421.GC5097@unreal>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 9F2114CE67AB.AB564
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/1/28 20:54, Leon Romanovsky wrote:
> On Thu, Jan 28, 2021 at 02:29:43PM +0800, Xiao Yang wrote:
>> On 2021/1/27 20:04, Leon Romanovsky wrote:
>>> On Wed, Jan 27, 2021 at 04:24:31PM +0800, Xiao Yang wrote:
>>>> Even if we enable sq_sig_all or IBV_SEND_SIGNALED, current rxe
>>>> module cannot set imm_data in WC when the related WR with imm_data
>>>> finished on SQ.
>>>>
>>>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>>>> ---
>>>>
>>>> Current rxe module and other rdma modules(e.g. mlx5) only set
>>>> imm_data in WC when the related WR with imm_data finished on RQ.
>>>> I am not sure if it is a expected behavior.
>>> This is IBTA behavior.
>>>
>>> 5.2.11 IMMEDIATE DATA EXTENDED TRANSPORT HEADER (ImmDt) - 4 BYTES
>>> "Immediate Data (ImmDt) contains data that is placed in the receive
>>>    Completion Queue Element (CQE). The ImmDt is only allowed in SEND or
>>>    RDMA WRITE packets with Immediate Data."
>>>
>>> If I understand the spec, you shouldn't set imm_data in SQ.
>> Hi Leon,
>>
>> About the behavior, I have another question:
>> For send operation with imm_data, we can verify if the delivered imm_data is
>> correct by CQE on RQ.
>> For rdma write operation with imm_data, how to verify if the delivered
>> imm_data is correct? :-)
> Probably that I didn't understand the question, but the RDMA WRITE is
> marked with special opcode in the BTH that indicates imm_data.
Hi Leon,

The quesion is about how to get the imm_data in applications(programs in 
user space)
1) If client program does send operation with imm_data, server program 
can get the delivered imm_data by calling ibv_poll_cq(&wc)
2) If client program does rdma write operation with imm_data, server 
program cannot get the delivered imm_data by calling ibv_poll_cq(&wc).
     In this case, how does server program get the delivered imm_data?

Best Regards,
Xiao Yang
> Thanks
>
>> Best Regards,
>> Xiao Yang
>>> Thanks
>>>
>>>
>>> .
>>>
>>
>>
>
> .
>



