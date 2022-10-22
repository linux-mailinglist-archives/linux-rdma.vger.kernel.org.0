Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EF860830C
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Oct 2022 03:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJVBJw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 21:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJVBJv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 21:09:51 -0400
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02932FFC5;
        Fri, 21 Oct 2022 18:09:45 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="93171868"
X-IronPort-AV: E=Sophos;i="5.95,203,1661785200"; 
   d="scan'208";a="93171868"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP; 22 Oct 2022 10:09:43 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 1B135D4332;
        Sat, 22 Oct 2022 10:09:42 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com [192.51.206.12])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4C9E7D9942;
        Sat, 22 Oct 2022 10:09:41 +0900 (JST)
Received: from [10.167.226.45] (unknown [10.167.226.45])
        by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5E0CE2340A4F;
        Sat, 22 Oct 2022 10:09:40 +0900 (JST)
Message-ID: <1846f2e1-ff13-5fa2-240f-fd7749921ce2@fujitsu.com>
Date:   Sat, 22 Oct 2022 09:09:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [for-next PATCH v2 1/2] RDMA/rxe: Remove unnecessary mr testing
Content-Language: en-US
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1666338764-2-1-git-send-email-lizhijian@fujitsu.com>
 <1666338764-2-2-git-send-email-lizhijian@fujitsu.com>
 <CAD=hENeGMKri0nYMtcu98K2j3D+ZBkxO6fFX5cvvyJsEghrrmQ@mail.gmail.com>
From:   Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <CAD=hENeGMKri0nYMtcu98K2j3D+ZBkxO6fFX5cvvyJsEghrrmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27216.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27216.003
X-TMASE-Result: 10--15.594600-10.000000
X-TMASE-MatchedRID: mZljRXDwq+6PvrMjLFD6eK5i3jK3KDOoC/ExpXrHizy+eGAmqR+bQDss
        suIpK9WSfr1jt5raS6thWgNOVfhPTFzsSetYc4qWEhGH3CRdKUV2ZYwNBqM6Ii3euai/vqCsuxW
        P7AlD8NO/6ou3CTYXxvju9Pl12bPveAhnd12HpxeOtWfhyZ77Dn5Lmbb/xUuawLkNMQzGl5B+Kr
        WCPbERP9wZQbxQpGvbrXE1vkBdsJHOErCEPfcsyp4CIKY/Hg3AWQy9YC5qGvwCwwGD+AF1Ue52O
        dZcC6tPIAcCikR3vq8WENZibi59zo1JkjUDAhp4iX5CWPaSNeLN5TTK7oKHbLCAKbbvwUtP
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 21/10/2022 22:39, Zhu Yanjun wrote:
> On Fri, Oct 21, 2022 at 3:53 PM Li Zhijian <lizhijian@fujitsu.com> wrote:
>> Before the testing, we already passed it to rxe_mr_copy() where mr could
>> be dereferenced. so this checking is not exactly correct.
>>
>> I tried to figure out the details how/when mr could be NULL, but failed
>> at last. Add a WARN_ON(!mr) to that path to tell us more when it
>> happends.
> If I get you correctly, you confronted a problem,
Not exactly,  I removed the mr checking since i think this checking is not correct.
the newly added WARN_ON(!mr) is the only once place where the mr can be NULL but not handled correctly.
At least with/without this patch, once WARN_ON(!mr) is triggered, kernel will go something wrong.

so i want to place this  WARN_ON(!mr) to point to the problem.

Thanks
Zhijian

>   but you can not figure it out.
> So you send it upstream as a patch?
>
> I am not sure if it is a good idea.
>
> Zhu Yanjun
>
>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
>> index ed5a09e86417..218c14fb07c6 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>> @@ -778,6 +778,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>          if (res->state == rdatm_res_state_new) {
>>                  if (!res->replay) {
>>                          mr = qp->resp.mr;
>> +                       WARN_ON(!mr);
>>                          qp->resp.mr = NULL;
>>                  } else {
>>                          mr = rxe_recheck_mr(qp, res->read.rkey);
>> @@ -811,8 +812,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>
>>          rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
>>                      payload, RXE_FROM_MR_OBJ);
>> -       if (mr)
>> -               rxe_put(mr);
>> +       rxe_put(mr);
>>
>>          if (bth_pad(&ack_pkt)) {
>>                  u8 *pad = payload_addr(&ack_pkt) + payload;
>> --
>> 2.31.1
>>

