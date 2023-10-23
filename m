Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E61F7D29E5
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 08:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjJWGIQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Oct 2023 02:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWGIP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Oct 2023 02:08:15 -0400
Received: from out-192.mta0.migadu.com (out-192.mta0.migadu.com [91.218.175.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927CDD65
        for <linux-rdma@vger.kernel.org>; Sun, 22 Oct 2023 23:08:13 -0700 (PDT)
Message-ID: <3d207f7d-4736-436f-b3c9-3a41c1143700@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698041291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SN1hiP8+ykAXvgUPP6vNrZ4rocQWzlYpmr0ssd5tG7M=;
        b=a00hB7B1VfezajDagcWcPRufNO1eg7gPkEOGdEm6diplTqhIuBJE2uwW0Fi6HhCH0BT+1A
        fjs5AMW3Xa8QFCfN4CZRKtEx3mFzo7hdqOW3gDGtYpBzccXSNJPe8Sa4C72F3rwt65NyUo
        K6/JZkjTg88FztJdkUlnm5yireSdc8I=
Date:   Mon, 23 Oct 2023 14:08:01 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with 64k
 page size
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Zhu Yanjun' <yanjun.zhu@intel.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20231013011803.70474-1-yanjun.zhu@intel.com>
 <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <a6e4efa6-0623-4afa-9b57-969aaf346081@fujitsu.com>
 <20231020140139.GF691768@ziepe.ca>
 <6c57cf0d-c7a7-4aac-9eb2-d8bb1d832232@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <6c57cf0d-c7a7-4aac-9eb2-d8bb1d832232@fujitsu.com>
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

在 2023/10/23 11:52, Zhijian Li (Fujitsu) 写道:
> 
> 
> On 20/10/2023 22:01, Jason Gunthorpe wrote:
>> On Fri, Oct 20, 2023 at 03:47:05AM +0000, Zhijian Li (Fujitsu) wrote:
>>> CC Bart
>>>
>>> On 13/10/2023 20:01, Daisuke Matsuda (Fujitsu) wrote:
>>>> On Fri, Oct 13, 2023 10:18 AM Zhu Yanjun wrote:
>>>>> From: Zhu Yanjun<yanjun.zhu@linux.dev>
>>>>>
>>>>> The page_size of mr is set in infiniband core originally. In the commit
>>>>> 325a7eb85199 ("RDMA/rxe: Cleanup page variables in rxe_mr.c"), the
>>>>> page_size is also set. Sometime this will cause conflict.
>>>> I appreciate your prompt action, but I do not think this commit deals with
>>>> the root cause. I agree that the problem lies in rxe driver, but what is wrong
>>>> with assigning actual page size to ibmr.page_size?
>>>>
>>>> IMO, the problem comes from the device attribute of rxe driver, which is used
>>>> in ulp/srp layer to calculate the page_size.
>>>> =====
>>>> static int srp_add_one(struct ib_device *device)
>>>> {
>>>>            struct srp_device *srp_dev;
>>>>            struct ib_device_attr *attr = &device->attrs;
>>>> <...>
>>>>            /*
>>>>             * Use the smallest page size supported by the HCA, down to a
>>>>             * minimum of 4096 bytes. We're unlikely to build large sglists
>>>>             * out of smaller entries.
>>>>             */
>>>>            mr_page_shift           = max(12, ffs(attr->page_size_cap) - 1);
>>>
>>>
>>> You light me up.
>>> RXE provides attr.page_size_cap(RXE_PAGE_SIZE_CAP) which means it can support 4K-2G page size
>>
>> That doesn't seem right even in concept.>
>> I think the multi-size support in the new xarray code does not work
>> right, just looking at it makes me think it does not work right. It
>> looks like it can do less than PAGE_SIZE but more than PAGE_SIZE will
>> explode because kmap_local_page() does only 4K.
>>
>> If RXE_PAGE_SIZE_CAP == PAGE_SIZE  will everything work?
>>
> 
> Yeah, this should work(even though i only verified hardcoding mr_page_shift to PAGE_SHIFT).
> 
>>>> import ctypes
>>>> libc = ctypes.cdll.LoadLibrary('libc.so.6')
>>>> hex(65536)
> '0x10000'
>>>> libc.ffs(0x10000) - 1
> 16
>>>> 1 << 16
> 65536
> 
> so
> mr_page_shift = max(12, ffs(attr->page_size_cap) - 1) = max(12, 16) = 16;
> 
> 
> So I think Daisuke's patch should work as well.
> 
> https://lore.kernel.org/linux-rdma/OS3PR01MB98652B2EC2E85DAEC6DDE484E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com/T/#md133060414f0ba6a3dbaf7b4ad2374c8a347cfd1

About this patch, please make full tests. Please ensure that this will 
not introduce some potential problems. In the discussion, this patch 
possibly has side effect.

Zhu Yanjun

> 
> 
>> Jason

