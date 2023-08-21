Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0505A78213C
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Aug 2023 03:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjHUBkB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Aug 2023 21:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjHUBkB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Aug 2023 21:40:01 -0400
Received: from out-31.mta1.migadu.com (out-31.mta1.migadu.com [95.215.58.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5466E9C
        for <linux-rdma@vger.kernel.org>; Sun, 20 Aug 2023 18:39:59 -0700 (PDT)
Message-ID: <4e76980d-093f-8edc-85a4-744e281b9d05@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692581997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TsfAIyFjVZ51qM0QCxUKoPG//1rb+YS5QLS8MFLyh4g=;
        b=idMG+puWCC7jpoAydf2nFeSvFIWgX0sWD9c94AO8mibGw7egI+yjCtBYKTtSIwhwxibjjU
        qPPlLKtRBISBxgTnDgPmBQDsI46HpJQFmNPtUC/cupfoFSQSfZ4Bfk8DyyUdlYO54xocke
        WRupxYKWJyyxL+oNQS/x7c+iuFg9MQI=
Date:   Mon, 21 Aug 2023 09:39:49 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Misc changes for siw
To:     Leon Romanovsky <leon@kernel.org>
Cc:     bmt@zurich.ibm.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20230818082318.17489-1-guoqing.jiang@linux.dev>
 <20230820094359.GC1562474@unreal>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <20230820094359.GC1562474@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 8/20/23 17:43, Leon Romanovsky wrote:
> On Fri, Aug 18, 2023 at 04:23:15PM +0800, Guoqing Jiang wrote:
>> Hi,
>>
>> The first one fix below calltrace which could happen if siw_connect
>> goto error (I manually set rv to -1 after siw_send_mpareqrep to trigger
>> it) after cep is allocated.
>>
>> [   97.341035] ------------[ cut here ]------------
>> [   97.341037] WARNING: CPU: 0 PID: 143 at drivers/infiniband/sw/siw/siw_cm.c:444 siw_cep_put+0x1c5/0x1e0 [siw]
>> ...
>> [   97.341126] CPU: 0 PID: 143 Comm: kworker/u4:4 Tainted: G           OE      6.5.0-rc3+ #16
>> [   97.341128] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552c-rebuilt.opensuse.org 04/01/2014
>> [   97.341130] Workqueue: rdma_cm cma_work_handler [rdma_cm]
>> [   97.341137] RIP: 0010:siw_cep_put+0x1c5/0x1e0 [siw]
>> ...
>> [   97.341159] Call Trace:
>> [   97.341160]  <TASK>
>> [   97.341162]  ? show_regs+0x72/0x90
>> [   97.341166]  ? siw_cep_put+0x1c5/0x1e0 [siw]
>> [   97.341170]  ? __warn+0x8d/0x1a0
>> [   97.341175]  ? siw_cep_put+0x1c5/0x1e0 [siw]
>> [   97.341180]  ? report_bug+0x1f9/0x250
>> [   97.341185]  ? handle_bug+0x46/0x90
>> [   97.341188]  ? exc_invalid_op+0x19/0x80
>> [   97.341190]  ? asm_exc_invalid_op+0x1b/0x20
>> [   97.341196]  ? siw_cep_put+0x1c5/0x1e0 [siw]
>> [   97.341204]  siw_connect+0x474/0x780 [siw]
>> [   97.341211]  iw_cm_connect+0x1ca/0x250 [iw_cm]
>> [   97.341216]  rdma_connect_locked+0x1bf/0x940 [rdma_cm]
>> [   97.341227]  nvme_rdma_cm_handler+0x5d7/0x9c0 [nvme_rdma]
>> [   97.341235]  cma_cm_event_handler+0x4f/0x170 [rdma_cm]
>> [   97.341241]  cma_work_handler+0x6a/0xe0 [rdma_cm]
>> [   97.341247]  process_one_work+0x2bd/0x590
>> ...
>>
>> The second one make the debug message consistent with the condition,
>> and the last one cleanup code a bit. Pls help to review them.
>>
>> Thanks,
>> Guoqing
>>
>> Guoqing Jiang (3):
>>    RDMA/siw: Balance the reference of cep->kref in the error path
>>    RDMA/siw: Correct wrong debug message
>>    RDMA/siw: Call llist_reverse_order in siw_run_sq
> All of these patches need to be with Fixes lines.

The last one doesn't need it since it is a cleanup, will update the 
first two.

Thanks,
Guoqing
