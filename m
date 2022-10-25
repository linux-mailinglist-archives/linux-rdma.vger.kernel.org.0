Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C244D60C102
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Oct 2022 03:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJYB3R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 21:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiJYB2v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 21:28:51 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66290B6024;
        Mon, 24 Oct 2022 18:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1666659935; i=@fujitsu.com;
        bh=Cj7Dw3iBahw64xjeRZzqlINSjK0FkwGPzDAEv4Mhb3Q=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=rHcujE610TfpvRiaMqDM/21gop28wGFAxstZ5Wr1xRlIG/50aL3ciz0J1pHnaQwf+
         5KvsymehXEUv78DDRWWtrnWRtTfSVJgBVnE5+j2I5/7ngVAeLCJ58rg60EFyD18uA9
         Qwms3+D5x+ZEuWgIGvAtwFINHQzRlrAkqA2fpKehUbLB3s3WJYXSq1RpR+DkeAD0+n
         GCaPI52cFpiITC/NBP/CyFbm94+fRbsXgLQ4aDEtD5U8rILyq4udTVhz+RfRHyydiM
         7sMhA5tU6NG2JH22jv2+At0BLH/mHJqd5TgFDUxas1VAr5FE1FLaJaQpaXy6lVm7HX
         u67ZOZ3bQUaCQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRWlGSWpSXmKPExsViZ8OxWTfeLDz
  ZYKK4xZV/exgtpvxaymxxedccNotnh3pZLL5MncZscf5YP7sDm8fOWXfZPTat6mTz6G1+x+bx
  eZNcAEsUa2ZeUn5FAmvGw3VrGAs+8lZ8esvRwPiOu4uRi0NIYCOjxO7V85ghnCVMEk+WdTFBO
  NsYJe6vnA+U4eTgFbCTaD/7mQXEZhFQlXjR0cwCEReUODnzCZgtKhAh8fDRJDBbWMBHYuWeu2
  wgNrOAuMStJ/OZQGwRARWJEyfOsIMsYBaYyCixbcFrFoht/YwSU2ZsB+tmE9CQuNdykxHE5hT
  QkriwtwtqkoXE4jcH2SFseYntb+eAXSchoChxpPMvC4RdITFrVhsThK0mcfXcJuYJjMKzkBw7
  C8lRs5CMnYVk7AJGllWMpsWpRWWpRbpmeklFmekZJbmJmTl6iVW6iXqppbrlqcUlukZ6ieXFe
  qnFxXrFlbnJOSl6eaklmxiBsZZSrHRvB+O0ZX/0DjFKcjApifIyiIclC/El5adUZiQWZ8QXle
  akFh9ilOHgUJLgDTANTxYSLEpNT61Iy8wBxj1MWoKDR0mEd6kCUJq3uCAxtzgzHSJ1ilFRSpy
  3EqRPACSRUZoH1wZLNZcYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAqCfNymgBN4cnMK4Gb/gpo
  MRPQ4jVzw0AWlyQipKQamHhL6/3a/xSL7ilIWvRbQulWsCPbj9n8kTIlIuKvkvwlLiesLD0rt
  5FLfYZgt+WTeQXn1oTICHsrK5dv2CU84+AP5+/djsH3jSqc44S+79hnm+dX2KrI1/OEc5la+Z
  JoY2Mn6ykPFRafjOBV0r86scHjqb3nu97sW0m/6tRPOJi8XvCVU9wuYtu72Z4vZs+qzdW5odZ
  YZbxpz+03OZGiizY+3yTG36DeJBe5TNqEdVmsT8U/geSzNacLXO2vHQgROqpVVnS6y/pG+N33
  6l9Mn3rOsZZ3uJ+7//7DnTcvVh+8o/uhm89ompnGjklTeg/kWN+Z7vNVptgnQ3ip0SIevam1e
  UL1cYvffje/5vtNiaU4I9FQi7moOBEAXIP/wbADAAA=
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-4.tower-565.messagelabs.com!1666659934!296755!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11446 invoked from network); 25 Oct 2022 01:05:34 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-4.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Oct 2022 01:05:34 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id A9A74154;
        Tue, 25 Oct 2022 02:05:34 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 9C4C3153;
        Tue, 25 Oct 2022 02:05:34 +0100 (BST)
Received: from [10.167.226.45] (10.167.226.45) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 25 Oct 2022 02:05:31 +0100
Message-ID: <15c06129-3584-70df-a084-d7c8dde4cfbc@fujitsu.com>
Date:   Tue, 25 Oct 2022 09:05:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH for-next v3 2/2] RDMA/rxe: Fix mr leak in RESPST_ERR_RNR
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <zyjzyj2000@gmail.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
References: <1666582315-2-1-git-send-email-lizhijian@fujitsu.com>
 <20221024052049.20577-1-lizhijian@fujitsu.com> <Y1bHygLEu6VjXIzI@nvidia.com>
From:   Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <Y1bHygLEu6VjXIzI@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 25/10/2022 01:13, Jason Gunthorpe wrote:
> On Mon, Oct 24, 2022 at 01:20:49PM +0800, Li Zhijian wrote:
>> rxe_recheck_mr() will increase mr's ref_cnt, so we should call rxe_put(mr)
>> to drop mr's ref_cnt in RESPST_ERR_RNR to avoid below warning:
>> [  633.447883] WARNING: CPU: 0 PID: 4156 at drivers/infiniband/sw/rxe/rxe_pool.c:259 __rxe_cleanup+0x1df/0x240 [rdma_rxe]
>> ...
>> [  633.509482] Call Trace:
>> [  633.510246]  <TASK>
>> [  633.510962]  rxe_dereg_mr+0x4c/0x60 [rdma_rxe]
>> [  633.512123]  ib_dereg_mr_user+0xa8/0x200 [ib_core]
>> [  633.513444]  ib_mr_pool_destroy+0x77/0xb0 [ib_core]
>> [  633.514763]  nvme_rdma_destroy_queue_ib+0x89/0x240 [nvme_rdma]
>> [  633.516230]  nvme_rdma_free_queue+0x40/0x50 [nvme_rdma]
>> [  633.517577]  nvme_rdma_teardown_io_queues.part.0+0xc3/0x120 [nvme_rdma]
>> [  633.519204]  nvme_rdma_error_recovery_work+0x4d/0xf0 [nvme_rdma]
>> [  633.520695]  process_one_work+0x582/0xa40
>> [  633.522987]  ? pwq_dec_nr_in_flight+0x100/0x100
>> [  633.524227]  ? rwlock_bug.part.0+0x60/0x60
>> [  633.525372]  worker_thread+0x2a9/0x700
>> [  633.526437]  ? process_one_work+0xa40/0xa40
>> [  633.527589]  kthread+0x168/0x1a0
>> [  633.528518]  ? kthread_complete_and_exit+0x20/0x20
>> [  633.529792]  ret_from_fork+0x22/0x30
>>
>> CC: Bob Pearson <rpearsonhpe@gmail.com>
>> Fixes: 8a1a0be894da ("RDMA/rxe: Replace mr by rkey in responder resources")
>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>> V2: remove mr testing
>> ---
>>   drivers/infiniband/sw/rxe/rxe_resp.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
> Sigh, please try to avoid sending patches in a way that causes
> patchworks to become confused.

Understood
> I updated things to remove the if as in
> this v2.

thanks a lot.




>
> Jason

