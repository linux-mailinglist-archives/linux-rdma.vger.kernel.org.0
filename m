Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6AC7BFDA4
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Oct 2023 15:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjJJNhM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Oct 2023 09:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjJJNhL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Oct 2023 09:37:11 -0400
Received: from out-195.mta1.migadu.com (out-195.mta1.migadu.com [95.215.58.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3510B6
        for <linux-rdma@vger.kernel.org>; Tue, 10 Oct 2023 06:37:08 -0700 (PDT)
Message-ID: <d2f41bf8-45dc-4937-a3a9-b05d422499cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696945027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1u+LUlgCLafiyrOIQ6ypNp68jf1XDI4Vvhre7C/htP0=;
        b=xt4IH2AwODwUvSdW74qNBDoOL7aNGcpcv12D/J5gjbbsclUuUxI/dojHU6/x7IUTpig/rg
        brFv94oOmBLYWKGjuxznJeg4SIkDDQ6cPCAJUgiFa/Ivfdo0DLcE3PvhghSxU09fw1RGwR
        leXQKG3xk/psycMr7L+tgO8ftEW4RFM=
Date:   Tue, 10 Oct 2023 21:36:57 +0800
MIME-Version: 1.0
Subject: Re: [bug report][bisected] rdma_rxe: blktests srp lead kernel panic
 with 64k page size
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Robert Pearson <rpearsonhpe@gmail.com>
References: <CAHj4cs8hVFz=3OkVBrfZ3PCHU3fWN=+GpH40PvAs49CZ3-pJvg@mail.gmail.com>
 <54acca3e-ef7b-40be-867f-061544197557@linux.dev>
 <20231010113542.GH3952@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20231010113542.GH3952@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/10/10 19:35, Jason Gunthorpe 写道:
> On Tue, Oct 10, 2023 at 06:41:17PM +0800, Zhu Yanjun wrote:
>> 在 2023/10/9 12:35, Yi Zhang 写道:
>>> Hello
>>>
>>> blktests srp lead kernel panic[2] on aarch64 when the kernel enabled
>>> CONFIG_ARM64_64K_PAGES, bisect shows it was introduced from commit[1],
>>> pls help check it and let me know if you need any info/testing for it, thanks.
>>>
>>> [1]
>>> commit 325a7eb85199ec9c5b5a7af812f43ea16b735569
>>> Author: Bob Pearson <rpearsonhpe@gmail.com>
>>> Date:   Thu Jan 19 17:59:36 2023 -0600
>>>
>>>       RDMA/rxe: Cleanup page variables in rxe_mr.c
>>>
>>>       Cleanup usage of mr->page_shift and mr->page_mask and introduce
>>>       an extractor for mr->ibmr.page_size. Normal usage in the kernel
>>>       has page_mask masking out offset in page rather than masking out
>>>       the page number. The rxe driver had reversed that which was confusing.
>>>       Implicitly there can be a per mr page_size which was not uniformly
>>>       supported.
>>>
>>>       Link: https://lore.kernel.org/r/20230119235936.19728-6-rpearsonhpe@gmail.com
>>>       Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>>       Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>>>
>> Hi, Yi
>>
>> I delved into the commit. And the commit can not be reverted cleanly. So I
>> made the following diff to try to revert this commit. After this commit is
>> applied, rping can work well.
> We can't keep reverting things for what are probably small bugs. Fix
> the issues please!


This is not an official commit. Because the reporter mentioned that the 
commit causes this problem,

we just confirmed that. If we confirmed that this commit is the root 
cause, we will analyze this commit,

then fix it.

Zhu Yanjun


>
> Jason
