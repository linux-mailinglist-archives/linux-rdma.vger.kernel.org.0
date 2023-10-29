Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9F77DAA93
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Oct 2023 04:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjJ2DXK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Oct 2023 23:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2DXK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 28 Oct 2023 23:23:10 -0400
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B62CF
        for <linux-rdma@vger.kernel.org>; Sat, 28 Oct 2023 20:23:07 -0700 (PDT)
Message-ID: <b5085c19-490e-4c0a-8c89-03d646876c8f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698549785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4yxBTWSsCkysQe0ogkN7X/PN6LEWWC8Vi87iPiTcgJQ=;
        b=vcI8DwYKIl6Vq53OVrTJH0bqktBueb1dak/gHHVFh6o8gxPZjDsKvmvA5ty+6aQiYsk3OF
        sqsjKlH3VMK1W810YUHpF/NZeVFqC8NURLt/sa/vT+yXbnwcZ7oFaOUXXMXMufTTiF2f/J
        g4DrDaU72HPyoNwelveNjciQvKCvbyE=
Date:   Sun, 29 Oct 2023 11:22:53 +0800
MIME-Version: 1.0
Subject: Re: [PATCH RFC 1/2] RDMA/rxe: don't allow registering !PAGE_SIZE mr
To:     Bart Van Assche <bvanassche@acm.org>,
        Li Zhijian <lizhijian@fujitsu.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        matsuda-daisuke@fujitsu.com
References: <20231027054154.2935054-1-lizhijian@fujitsu.com>
 <53c18b2a-c3b2-4936-b654-12cb5f914622@linux.dev>
 <adad4ee6-ceef-4e45-a13d-048a1377e86f@acm.org>
 <45c23e30-8405-470b-825c-e5166cd8a313@linux.dev>
 <a344b3b0-a43f-47eb-b5e4-9d54cda62518@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <a344b3b0-a43f-47eb-b5e4-9d54cda62518@acm.org>
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

在 2023/10/29 7:07, Bart Van Assche 写道:
> On 10/27/23 19:48, Zhu Yanjun wrote:
>> In this case, ULP with folio will not work well with current RXE after 
>> this commit is applied.
> 
> Why not? RDMA ULPs like the SRP initiator driver use ib_map_mr_sg(). The
> latter function calls rxe_map_mr_sg() if the RXE driver is used. 
> rxe_map_mr_sg() calls ib_sg_to_pages(). ib_sg_to_pages() translates
> SG-entries that are larger than a virtual memory page into multiple
> entries with size mr->page_size.

It seems that we are not on the same page. I am thinking that this fix 
should also work for the future folio. And your idea is based on the 
current implementation.

Perhaps it is not a good time to discuss folio currently. Let me focus 
on the current implementation.

In this commit, if the page size is not equal to PAGE_SIZE, it will pop 
out warning then exit. So "rxe_info_mr" should be changed to rxe_warning_mr?

In fact, I like to remove the page size assignment in rxe, that is, 
partly reverting the commit 325a7eb85199 ("RDMA/rxe: Cleanup page 
variables in rxe_mr.c"). But it seems that Jason did not like this.
I no longer insist on this.

I am not sure whether Jason, Leon, Bob and you have better solution to 
this problem or not.

If not, this commit can fix this problem if no better solution.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Thanks,
Zhu Yanjun

> 
> Thanks,
> 
> Bart.
> 

