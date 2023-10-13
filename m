Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873617C85CB
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Oct 2023 14:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjJMM26 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Oct 2023 08:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjJMM2z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Oct 2023 08:28:55 -0400
Received: from out-208.mta1.migadu.com (out-208.mta1.migadu.com [95.215.58.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAB2A9
        for <linux-rdma@vger.kernel.org>; Fri, 13 Oct 2023 05:28:53 -0700 (PDT)
Message-ID: <6f155aa3-8e75-40c5-9686-cad9f9ac0d81@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697200130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2WcNCjqTrYw4w54tLjxx6lE9IzfrwCwu1B6SvV0EX7g=;
        b=KOpng4ZEFIK9KUv/RZtB4K4gKz8qixI4WpNdHbuA+KLrvn4K2ZKEsO+WkPb2YlwQ02q61d
        AdodBsY7zO+K1O/MgtDWK3rAWoVfySj3hz51gJG1l4C26slGUbhckaadgk+2wirdAv5iHr
        xHatuR1r6JR7HOWkzT3wUjxrzqODy0o=
Date:   Fri, 13 Oct 2023 20:28:39 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with 64k
 page size
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Zhu Yanjun' <yanjun.zhu@intel.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>
Cc:     "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
References: <20231013011803.70474-1-yanjun.zhu@intel.com>
 <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
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

在 2023/10/13 20:01, Daisuke Matsuda (Fujitsu) 写道:
> On Fri, Oct 13, 2023 10:18 AM Zhu Yanjun wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> The page_size of mr is set in infiniband core originally. In the commit
>> 325a7eb85199 ("RDMA/rxe: Cleanup page variables in rxe_mr.c"), the
>> page_size is also set. Sometime this will cause conflict.
> 
> I appreciate your prompt action, but I do not think this commit deals with
> the root cause. I agree that the problem lies in rxe driver, but what is wrong
> with assigning actual page size to ibmr.page_size?

Please check the source code. ibmr.page_size is assigned in 
infiniband/core. And then it is assigned in rxe.
When the 2 are different, the problem will occur.
Please add logs to infiniband/core and rxe to check them.

Zhu Yanjun

> 
> IMO, the problem comes from the device attribute of rxe driver, which is used
> in ulp/srp layer to calculate the page_size.
> =====
> static int srp_add_one(struct ib_device *device)
> {
>          struct srp_device *srp_dev;
>          struct ib_device_attr *attr = &device->attrs;
> <...>
>          /*
>           * Use the smallest page size supported by the HCA, down to a
>           * minimum of 4096 bytes. We're unlikely to build large sglists
>           * out of smaller entries.
>           */
>          mr_page_shift           = max(12, ffs(attr->page_size_cap) - 1);
>          srp_dev->mr_page_size   = 1 << mr_page_shift;
> =====
> On initialization of srp driver, mr_page_size is calculated here.
> Note that the device attribute is used to calculate the value of page shift
> when the device is trying to use a page size larger than 4096. Since Yi specified
> CONFIG_ARM64_64K_PAGES, the system naturally met the condition.
> 
> =====
> static int srp_map_finish_fr(struct srp_map_state *state,
>                               struct srp_request *req,
>                               struct srp_rdma_ch *ch, int sg_nents,
>                               unsigned int *sg_offset_p)
> {
>          struct srp_target_port *target = ch->target;
>          struct srp_device *dev = target->srp_host->srp_dev;
> <...>
>          n = ib_map_mr_sg(desc->mr, state->sg, sg_nents, sg_offset_p,
>                           dev->mr_page_size);
> =====
> After that, mr_page_size is presumably passed to ib_core layer.
> 
> =====
> int ib_map_mr_sg(struct ib_mr *mr, struct scatterlist *sg, int sg_nents,
>                   unsigned int *sg_offset, unsigned int page_size)
> {
>          if (unlikely(!mr->device->ops.map_mr_sg))
>                  return -EOPNOTSUPP;
> 
>          mr->page_size = page_size;
> 
>          return mr->device->ops.map_mr_sg(mr, sg, sg_nents, sg_offset);
> }
> EXPORT_SYMBOL(ib_map_mr_sg);
> =====
> Consequently, the page size calculated in srp driver is set to ibmr.page_size.
> 
> Coming back to rxe, the device attribute is set here:
> =====
> rxe.c
> <...>
> /* initialize rxe device parameters */
> static void rxe_init_device_param(struct rxe_dev *rxe)
> {
>          rxe->max_inline_data                    = RXE_MAX_INLINE_DATA;
> 
>          rxe->attr.vendor_id                     = RXE_VENDOR_ID;
>          rxe->attr.max_mr_size                   = RXE_MAX_MR_SIZE;
>          rxe->attr.page_size_cap                 = RXE_PAGE_SIZE_CAP;
>          rxe->attr.max_qp                        = RXE_MAX_QP;
> ---
> rxe_param.h
> <...>
> /* default/initial rxe device parameter settings */
> enum rxe_device_param {
>          RXE_MAX_MR_SIZE                 = -1ull,
>          RXE_PAGE_SIZE_CAP               = 0xfffff000,
>          RXE_MAX_QP_WR                   = DEFAULT_MAX_VALUE,
> =====
> rxe_init_device_param() sets the attributes to rxe_dev->attr, and it is later copied
> to ib_device->attrs in setup_device()@core/device.c.
> See that the page size cap is hardcoded to 4096 bytes. I suspect this led to
> incorrect page_size being set to ibmr.page_size, resulting in the kernel crash.
> 
> I think rxe driver is made to be able to handle arbitrary page sizes.
> Probably, we can just modify RXE_PAGE_SIZE_CAP to fix the issue.
> What do you guys think?
> 
> Thanks,
> Daisuke Matsuda
> 

