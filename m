Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8587C6D87
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Oct 2023 13:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbjJLL7r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Oct 2023 07:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbjJLL7i (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Oct 2023 07:59:38 -0400
Received: from out-210.mta1.migadu.com (out-210.mta1.migadu.com [IPv6:2001:41d0:203:375::d2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D58F49D1
        for <linux-rdma@vger.kernel.org>; Thu, 12 Oct 2023 04:50:12 -0700 (PDT)
Message-ID: <fe0fbdd9-93a2-4478-b1ef-9b2420c0d76e@linux.dev>
Date:   Thu, 12 Oct 2023 19:49:35 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        Leon Romanovsky <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Zhu Yanjun <yanjun.zhu@intel.com>
References: <20231004183824.GQ13795@ziepe.ca>
 <c0665377-d2be-e4b6-3d25-727ef303d26e@linux.dev>
 <20231005142148.GA970053@ziepe.ca>
 <6a730dad-9d81-46d9-8adc-764d00745b01@acm.org>
 <a8453889-3f5f-49ff-89f2-ec0ef929d915@linux.dev>
 <OS3PR01MB9865F9BEB1A90DDCAEEBFC8BE5CDA@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <20231010160919.GC55194@ziepe.ca>
 <a4808fa6-5bd5-4a64-a437-6a7e89ca7e9f@acm.org>
 <20231011155104.GF55194@ziepe.ca>
 <70191324-018e-4cfe-9c1d-0bd3d17fb437@acm.org>
 <20231011231201.GH55194@ziepe.ca>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20231011231201.GH55194@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/10/12 7:12, Jason Gunthorpe 写道:
> On Wed, Oct 11, 2023 at 01:14:16PM -0700, Bart Van Assche wrote:
>> On 10/11/23 08:51, Jason Gunthorpe wrote:
>>> If we revert it then rxe will probably just stop development
>>> entirely. Daisuke's ODP work will be blocked and if Bob was able to
>>> fix it he would have done so already. Which mean's Bobs ongoing work
>>> is lost too.
>>
>> If Daisuke's work depends on the RXE changes then Daisuke may decide
>> to help with the RXE changes.
>>
>> Introducing regressions while refactoring code is not acceptable.
> 
> Generally, but I don't view rxe as a production part of the kernel so
> I prefer to give time to resolve it.
> 
>> I don't have enough spare time to help with the RXE driver.

commit 11ab7cc7ee32d6c3e16ac74c34c4bbdbf8f99292
Author: Bart Van Assche <bvanassche@acm.org>
Date:   Tue Aug 22 09:57:07 2023 -0700

     Change the default RDMA driver from rdma_rxe to siw

     Since the siw driver is more stable than the rdma_rxe driver, 
change the
     default into siw. See e.g.
 
https://lore.kernel.org/all/c3d1a966-b9b0-d015-38ec-86270b5045fc@acm.org/.

     Signed-off-by: Bart Van Assche <bvanassche@acm.org>
     Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>


> 
> Nor I
> 
> Jason

