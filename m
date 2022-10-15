Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788625FF809
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Oct 2022 04:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJOCcy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Oct 2022 22:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJOCcy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Oct 2022 22:32:54 -0400
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3DC6F573
        for <linux-rdma@vger.kernel.org>; Fri, 14 Oct 2022 19:32:52 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="92321910"
X-IronPort-AV: E=Sophos;i="5.95,185,1661785200"; 
   d="scan'208";a="92321910"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 15 Oct 2022 11:32:51 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id AA76CD63B9
        for <linux-rdma@vger.kernel.org>; Sat, 15 Oct 2022 11:32:49 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id D14FDD9947
        for <linux-rdma@vger.kernel.org>; Sat, 15 Oct 2022 11:32:48 +0900 (JST)
Received: from [10.167.226.45] (unknown [10.167.226.45])
        by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 03BF21140BF3;
        Sat, 15 Oct 2022 11:32:47 +0900 (JST)
Message-ID: <897a692c-89f8-7a14-4031-c4ac4f0c7a9b@fujitsu.com>
Date:   Sat, 15 Oct 2022 10:32:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] RDMA/rxe: Handle remote errors in the midst of a Read
 reply sequence
Content-Language: en-US
To:     =?UTF-8?B?TWF0c3VkYSwgRGFpc3VrZS/mnb7nlLAg5aSn6LyU?= 
        <matsuda-daisuke@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
References: <20221013014724.3786212-1-matsuda-daisuke@fujitsu.com>
 <20221013014724.3786212-2-matsuda-daisuke@fujitsu.com>
 <bd695f2f-b2d2-02ef-bc4d-ba64e5cc59f9@fujitsu.com>
 <TYCPR01MB8455D4422E8BC3D53ADE32C3E5249@TYCPR01MB8455.jpnprd01.prod.outlook.com>
From:   Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <TYCPR01MB8455D4422E8BC3D53ADE32C3E5249@TYCPR01MB8455.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27202.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27202.004
X-TMASE-Result: 10--21.178400-10.000000
X-TMASE-MatchedRID: qA30kLX4rkePvrMjLFD6eK5i3jK3KDOot3aeg7g/usC5IifwYL1+qxmE
        2Lk72Kw+BHGj1qouCqsuP7aUpb/kCC+3xqQ44pFWIuN48JyY3bkJKBFX4vuNlH7zXMne3nXuDJ9
        d5gU5UUdEilqyAMpqsuaffHI8kAmiHY/bzRmIaZHknMSTG9lH+ARryDXHx6oXPnZ8FlI6TJoEFi
        2mbQuRNtNUOK7OXJVWqP+enlh2glOonpzqWq1NCr3+Qwz7LRxRkYC3rjkUXRLe6dEbvIyrxe8bn
        aofKD1d5ftoiaDwCD3aiOLUKEt9x6ShtiT3ljCYeeUYPMgkiWufmd9HsjZ0U8guLSFFidm5K8Bd
        2Q/AYyfK7A+F0xO3x5osT/QkpuSDHodpx3o6GrsOWDFvyz6vQNHfa6Fe1HbGmyiLZetSf8kir3k
        OMJmHTIvKensr4XFRv79FIUygvZzEQdG7H66TyKsQd9qPXhnJ/4rWvpj9UcgD/dHyT/Xh7Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 14/10/2022 10:35, Matsuda, Daisuke/松田 大輔 wrote:
> On Thu, Oct 13, 2022 2:36 PM Li Zhijian wrote:
>> On 13/10/2022 09:47, Daisuke Matsuda wrote:
>>> Requesting nodes do not handle a reported error correctly if it is
>>> generated in the middle of multi-packet Read responses, and the node tries
>>> to resend the request endlessly. Let completer terminate the connection in
>>> that case.
>>>
>>> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
>>> ---
>>> FOR REVIEWERS:
>>>     I referred to IB Specification Vol 1-Revision-1.5 to make this patch.
>>>     Please see Ch.9.9.2.2, Ch.9.9.2.4.2 and Table 59.
>>>
>>>    drivers/infiniband/sw/rxe/rxe_comp.c | 8 ++++++++
>>>    1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
>>> index fb0c008af78c..c9170dd99f3a 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
>>> @@ -200,6 +200,10 @@ static inline enum comp_state check_psn(struct rxe_qp *qp,
>>>    		 */
>>>    		if (pkt->psn == wqe->last_psn)
>>>    			return COMPST_COMP_ACK;
>>> +		else if (pkt->opcode == IB_OPCODE_RC_ACKNOWLEDGE &&
>>> +			 (qp->comp.opcode == IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST ||
>>> +			  qp->comp.opcode == IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE))
> Hi Zhijian,
> Thank you for taking a look.
>
>> When IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST or IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE will
>> be assigned to qp->comp.opcode ?
> This happens in rxe_completer(). Upon receiving a Read reply, 'state' is changed in the following order:
> [  101.215593] rdma_rxe: qp#17 state = GET ACK
> [  101.216174] rdma_rxe: qp#17 state = GET WQE
> [  101.216776] rdma_rxe: qp#17 state = CHECK PSN
> [  101.217384] rdma_rxe: qp#17 state = CHECK ACK
> [  101.218008] rdma_rxe: qp#17 state = READ
> [  101.218556] rdma_rxe: qp#17 state = UPDATE COMP
> [  101.219188] rdma_rxe: qp#17 state = DONE
> 'qp->comp.opcode' is filled at COMPST_UPDATE_COMP, and the value is retained
> until it is overridden by the next incoming reply.
Thanks for your explanation.


>
>> I wonder if "(pkt->opcode == IB_OPCODE_RC_ACKNOWLEDGE) "  is enough ?
> I am not very sure if it is better. I agree your suggestion is correct within the
> IB transport layer, but RoCEv2 traffic is encapsulated in UDP/IP headers.
> We may need to take it into consideration that UDP does not guarantee ordered
> delivery of packets.
>
> For example, responder can return coalesced ACKs for RDMA Write requests.
> If ACK packets are swapped in the course of delivery, a packet with older psn can
> arrive later, and probably it is to be discarded by returning COMPST_DONE here.
>
> If we just put "(pkt->opcode == IB_OPCODE_RC_ACKNOWLEDGE) ",
> I am afraid the swapped ACKs may go into wrong path. This is based on my
> speculation, so please let me know if it is wrong.
Well, you current changes are quite fit to your patch subject :)

Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>



>
> Thanks,
> Daisuke
>
>> Thanks
>> Zhijian
>>
>>
>>> +			return COMPST_CHECK_ACK;
>>>    		else
>>>    			return COMPST_DONE;
>>>    	} else if ((diff > 0) && (wqe->mask & WR_ATOMIC_OR_READ_MASK)) {
>>> @@ -228,6 +232,10 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
>>>
>>>    	case IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST:
>>>    	case IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE:
>>> +		/* Check NAK code to handle a remote error */
>>> +		if (pkt->opcode == IB_OPCODE_RC_ACKNOWLEDGE)
>>> +			break;
>>> +
>>>    		if (pkt->opcode != IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE &&
>>>    		    pkt->opcode != IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST) {
>>>    			/* read retries of partial data may restart from

