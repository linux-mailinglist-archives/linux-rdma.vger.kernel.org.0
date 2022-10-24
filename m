Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B656098A2
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 05:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiJXDS5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Oct 2022 23:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiJXDSW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Oct 2022 23:18:22 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CADA7993D;
        Sun, 23 Oct 2022 20:15:45 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="81414405"
X-IronPort-AV: E=Sophos;i="5.95,207,1661785200"; 
   d="scan'208";a="81414405"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 24 Oct 2022 12:15:30 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 964F5D66A2;
        Mon, 24 Oct 2022 12:15:29 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id DCB11CFAC8;
        Mon, 24 Oct 2022 12:15:28 +0900 (JST)
Received: from [10.167.226.45] (unknown [10.167.226.45])
        by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 737B51147173;
        Mon, 24 Oct 2022 12:15:23 +0900 (JST)
Message-ID: <1dd7e09f-e22d-0c32-e084-21cac2489d10@fujitsu.com>
Date:   Mon, 24 Oct 2022 11:15:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [for-next PATCH v2 1/2] RDMA/rxe: Remove unnecessary mr testing
Content-Language: en-US
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1666338764-2-1-git-send-email-lizhijian@fujitsu.com>
 <1666338764-2-2-git-send-email-lizhijian@fujitsu.com>
 <CAD=hENeGMKri0nYMtcu98K2j3D+ZBkxO6fFX5cvvyJsEghrrmQ@mail.gmail.com>
 <1846f2e1-ff13-5fa2-240f-fd7749921ce2@fujitsu.com>
 <30ff25c4-ce66-eac4-eaa2-64c0db203a19@gmail.com>
 <CAD=hENeTnLGN5KKi_Cwni6FDb77prijHVjCjfdvhrjXdp7bdjQ@mail.gmail.com>
From:   Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <CAD=hENeTnLGN5KKi_Cwni6FDb77prijHVjCjfdvhrjXdp7bdjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27220.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27220.004
X-TMASE-Result: 10--13.135600-10.000000
X-TMASE-MatchedRID: U43YD7H1LvyPvrMjLFD6eK5i3jK3KDOoC/ExpXrHizz2apmI5+Nrz7/E
        Sxz77lNODzcc9hL6UiDwHaxbrlr+4VJVOThx4FfxbMGKOuLn5FV67Qg632Xv9Jnwlv7Cw6NQuVE
        MmUBpYss7GaZ377N7sIdoMqZEd4BXWViv3bGKIdVIcJTn2HkqsW6Pap1MPdtH5n20seAUtXpMMJ
        z48nnCV/rEqD3S8QO1aNJIgyTLPUxeUmqJNf32Qp4CIKY/Hg3AnCGS1WQEGtD8V77yhJRgo/sf6
        FkrLr8rC24oEZ6SpSkj80Za3RRg8CWXa9UzJWOcgJXsBvOOBJACMVyASlE/Kh8KP6yOHJd0hjCk
        DqIMOGg=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 24/10/2022 10:25, Zhu Yanjun wrote:
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>>>>> @@ -778,6 +778,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>>>>           if (res->state == rdatm_res_state_new) {
>>>>>                   if (!res->replay) {
>>>>>                           mr = qp->resp.mr;
>>>>> +                       WARN_ON(!mr);
>>>>>                           qp->resp.mr = NULL;
>>>>>                   } else {
>>>>>                           mr = rxe_recheck_mr(qp, res->read.rkey);
>>>>> @@ -811,8 +812,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>>>>
>>>>>           rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
>>>>>                       payload, RXE_FROM_MR_OBJ);
>>>>> -       if (mr)
>>>>> -               rxe_put(mr);
>>>>> +       rxe_put(mr);
>>>>>
>>>>>           if (bth_pad(&ack_pkt)) {
>>>>>                   u8 *pad = payload_addr(&ack_pkt) + payload
>>>>> --
>>>>> 2.31.1
>>>>>
>> Li is correct that the only way mr could be NULL is if qp->resp.mr == NULL. So the
> What I am concerned about is if "WARN_ON(!mr);" should be added or not.
> IMO, if the root cause remains unclear, this should be a problem.
> Currently this problem is not fixed. It is useless to send a debug
> statement to the maillist.

As per Bob's explanation,  no 'WARN_ON(!mr)' is needed.
I will update the patch soon.

> Zhu Yanjun
>
>> 'if (mr)' is not needed if that is the case. The read_reply subroutine is reached
>> from a new rdma read operation after going through check_rkey or from a previous
>> rdma read operations from get_req if qp->resp.res != NULL or from a duplicate request
>> where the previous responder resource is found. In all these cases the mr is set.
>> Initially in check_rkey where if it can't find the mr it causes an RKEY_VIOLATION.
>> Thereafter the rkey is stored in the responder resources and looked up for each
>> packet to get an mr or cause an RKEY_VIOLATION. So the mr can't be NULL. I think
>> you can leave out the WARN and just drop the if (mr).
Very thanks for your explanation

Thanks
Zhijian

>>
>> Bob
>>

