Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B4E7CD630
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Oct 2023 10:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjJRIRB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Oct 2023 04:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjJRIRA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Oct 2023 04:17:00 -0400
Received: from out-199.mta0.migadu.com (out-199.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFF3B0
        for <linux-rdma@vger.kernel.org>; Wed, 18 Oct 2023 01:16:55 -0700 (PDT)
Message-ID: <2a5e1fb6-6c73-4d25-b29a-4ccdbf2c5678@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697617014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3bQEjPXiHHLTebOYkrYW4EJTly3aDO83LJe8sSOMjPc=;
        b=X1VMcJ7fputuUF9CLL7/Yf+ZsZbS/weac66CDri+8uH7kkSx5JY8Dw+/7NEdLjPDZ3Z8ZK
        WQkA9pW6u3XXAxzANN6786COQzq2vGqZZFc3U9v/epGhLGCeIOEefPgDVasMlotUigjC1x
        NOSwotrQS3KIzhZQYkEnlQY6Skm5Lto=
Date:   Wed, 18 Oct 2023 16:16:45 +0800
MIME-Version: 1.0
Subject: Re: [bug report] blktests srp/002 hang
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Bart Van Assche' <bvanassche@acm.org>,
        'Rain River' <rain.1986.08.12@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <f50beb15-2cab-dfb9-3b58-ea66e7f114a6@gmail.com>
 <fe61fdc5-ca8f-2efc-975d-46b99d66c6f5@linux.dev>
 <afc98035-1bb8-f75c-451a-8e3e39fb74aa@gmail.com>
 <6fc3b524-af7d-43ce-aa05-5c44ec850b9b@acm.org>
 <b728f4db-bafa-dd0f-e288-7e3f56e6eae8@gmail.com>
 <02d7cbf2-b17b-488a-b6e9-ebb728b51c94@acm.org>
 <b80dae29-3a7c-f039-bc35-08c6e9f91197@gmail.com>
 <CAJr_XRAy4EHueAP-10=WSEa46j2aQBArdzYsq7OqSqR93Ue+ug@mail.gmail.com>
 <8aff9124-85c0-8e3b-dc35-1017b1540037@gmail.com>
 <3c84da83-cdbb-3326-b3f0-b2dee5f014e0@linux.dev>
 <4e7aac82-f006-aaa7-6769-d1c9691a0cec@gmail.com>
 <CAJr_XRCFuv_XO3Zk+pfq6C73CgDsnaJT4-G-jq1ds3bdg76iEA@mail.gmail.com>
 <OS7PR01MB1180450455E624D5CD977C461E5FCA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <29c5de53-cc61-4efc-8e8d-690e27756a16@acm.org>
 <OS7PR01MB118045AD711E93D223DCD6F17E5C3A@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <a3be5e98-e783-4108-a690-acc8a5cc5981@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <a3be5e98-e783-4108-a690-acc8a5cc5981@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/10/18 1:09, Bob Pearson 写道:
> On 9/25/23 20:17, Daisuke Matsuda (Fujitsu) wrote:
>> On Tue, Sep 26, 2023 12:01 AM Bart Van Assche:
>>> On 9/24/23 21:47, Daisuke Matsuda (Fujitsu) wrote:
>>>> As Bob wrote above, nobody has found any logical failure in rxe
>>>> driver.
>>> That's wrong. In case you would not yet have noticed my latest email in
>>> this thread, please take a look at
>>> https://lore.kernel.org/linux-rdma/e8b76fae-780a-470e-8ec4-c6b650793d10@leemhuis.info/T/#m0fd8ea8a4cbc27b37
>>> b042ae4f8e9b024f1871a73.
>>> I think the report in that email is a 100% proof that there is a
>>> use-after-free issue in the rdma_rxe driver. Use-after-free issues have
>>> security implications and also can cause data corruption. I propose to
>>> revert the commit that introduced the rdma_rxe use-after-free unless
>>> someone comes up with a fix for the rdma_rxe driver.
>>>
>>> Bart.
>> Thank you for the clarification. I see your intention.
>> I hope the hang issue will be resolved by addressing this.
>>
>> Thanks,
>> Daisuke
>>
> I have made some progress in understanding the cause of the srp/002 etc. hang.
>
> The two attached files are traces of activity for two qp's qp#151 and qp#167. In my runs of srp/002
> All the qp's pass before 167 and all fail after 167 which is the first to fail.
>
> It turns out that all the passing qp's call srp_post_send() some number of times and also call
> srp_send_done() the same number of times. Starting at qp#167 the last call to srp_send_done() does
> not take place leaving the srp driver waiting for the final completion and causing the hang I believe.

Thanks, Bob

I will delve into your findings and the source code to find the root cause.

BTW, what linux distribution are you using to find this? Ubuntu, Fedora 
or Debian?

 From the above, sometings this problem is difficult to reproduce on 
Ubuntu. But it can be reproduced in Ubuntu and Debian.

So can you let me know what linux distribution you are using?

Thanks

Zhu Yanjun

>
> There are four cq's involved in each pair of qp's in the srp test. Two in ib_srp and two in ib_srpt
> for the two qp's. Three of them execute completion processing in a soft irq context so the code in
> core/cq.c gathers the completions and calls back to the srp drivers. The send side cq in srp uses
> cq_direct which requires srp to call ib_process_direct() in order to collect the completions. This
> happens in __srp_get_tx_iu() which is called in several places in the srp driver. But only as a side effect
> since the purpose of this routine is to get an iu to start a new command.
>
> In the attached files for qp#151 the final call to srp_post_send is followed by the rxe requester and
> completer work queues processing the send packet and the ack before a final call to __srp_get_rx_iu()
> which gathers the final send side completion and success.
>
> For qp#167 the call to srp_post_send() is followed by the rxe driver processing the send operation and
> generating a work completion which is posted to the send cq but there is never a following call to
> __srp_get_rx_iu() so the cqe is not received by srp and failure.
>
> I don't yet understand the logic of the srp driver to fix this but the problem is not in the rxe driver
> as far as I can tell.
>
> Bob
