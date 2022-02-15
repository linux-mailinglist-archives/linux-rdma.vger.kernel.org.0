Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482D84B623E
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 05:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiBOEu6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Feb 2022 23:50:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiBOEu5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Feb 2022 23:50:57 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C91AD106
        for <linux-rdma@vger.kernel.org>; Mon, 14 Feb 2022 20:50:48 -0800 (PST)
Subject: Re: Inconsistent lock state warning for rxe_poll_cq()
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644900644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IS5rkaJUhNZfUQhGyrt+aGGcym07eVPC+otEd1XAuT8=;
        b=PEQxNjG/1y0NRlsy07dAMAnS/RDrtydq2PKoybH3QkM9yla4CgOuViHTvA5FEzRCrXKM7e
        PDqjORTIAGHs0F4MF8CVvYvAhhumpf3iRDCkwmHycz69NQvorgdVN/khFksnp4gkKzp6c2
        dNP6X8ghQ7NKQFXjfvjPrUCbwNZgTRA=
To:     Bart Van Assche <bvanassche@acm.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <8f9fe1da-c302-0c45-8df8-2905c630daad@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <6d4360db-af4d-3c85-c035-2d08c0e28685@linux.dev>
Date:   Tue, 15 Feb 2022 12:50:39 +0800
MIME-Version: 1.0
In-Reply-To: <8f9fe1da-c302-0c45-8df8-2905c630daad@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/15/22 2:01 AM, Bart Van Assche wrote:
> Hi Bob,
>
> If I run the SRP tests against Jason's rdma/for-next branch then these
> tests pass if I use the siw driver but not if I use the rdma_rxe driver.
> Can you please take a look at the output triggered by running blktests?
> If I run blktests as follows: ./check -q srp, the following output
> appears:
>
> WARNING: CPU: 1 PID: 1052 at kernel/softirq.c:363 
> __local_bh_enable_ip+0xa4/0xf0
>  _raw_write_unlock_bh+0x31/0x40
>  __rxe_add_index+0x38/0x50 [rdma_rxe]
>  rxe_create_ah+0xce/0x1b0 [rdma_rxe]
>  _rdma_create_ah+0x2c8/0x2f0 [ib_core]
>  rdma_create_ah+0xfd/0x1c0 [ib_core]
>  cm_alloc_msg+0xbc/0x280 [ib_cm]
>  cm_alloc_priv_msg+0x2d/0x70 [ib_cm]
>  ib_send_cm_req+0x4fe/0x830 [ib_cm]
>  cma_connect_ib+0x3c4/0x600 [rdma_cm]
>  rdma_connect_locked+0x145/0x490 [rdma_cm]
>  rdma_connect+0x31/0x50 [rdma_cm]
>  srp_send_req+0x58a/0x830 [ib_srp]
>  srp_connect_ch+0x9f/0x1d0 [ib_srp]
>  add_target_store+0xa6b/0xf20 [ib_srp]
>  dev_attr_store+0x3e/0x60
>  sysfs_kf_write+0x87/0xa0
>  kernfs_fop_write_iter+0x1c7/0x270
>  new_sync_write+0x296/0x3c0
>  vfs_write+0x43c/0x580
>  ksys_write+0xd9/0x180
>  __x64_sys_write+0x42/0x50
>  do_syscall_64+0x35/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae

I think it is exactly the same which I encountered with 5.17-rc3.

https://lore.kernel.org/linux-rdma/20220210073655.42281-1-guoqing.jiang@linux.dev/T/#m0c0ce0745078095ea931f61d2b1c6ce0fdd5403b

Thanks,
Guoqing
