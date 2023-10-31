Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8657DC3E5
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Oct 2023 02:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjJaBhE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Oct 2023 21:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjJaBhD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Oct 2023 21:37:03 -0400
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [IPv6:2001:41d0:1004:224b::aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C927C1
        for <linux-rdma@vger.kernel.org>; Mon, 30 Oct 2023 18:36:59 -0700 (PDT)
Message-ID: <4a19ae90-cc0f-4ace-862c-1251b6d98c3b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698716218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gsS7S3qpsELEMM28UG6g5BMi5CwZiNinbiqTJam4Wo0=;
        b=xI46AKRxA+tFBbA0R9w1AL7WkxFJsqgz9+A606l8g7FFdKiMN2Z+X5BguoKmDmZmreh+Xw
        ThCMZsExVR1bdKGhCfb0hseAJJyJz8aQ0vyfiCna1xDBYWI9tF9tLBN/ZWTuK79dyk5AL2
        Njsnm/v741hf21RTtzIZJgIUQRwE10o=
Date:   Tue, 31 Oct 2023 09:36:46 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with 64k
 page size
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        Yi Zhang <yi.zhang@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20231013011803.70474-1-yanjun.zhu@intel.com>
 <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <a6e4efa6-0623-4afa-9b57-969aaf346081@fujitsu.com>
 <20231020140139.GF691768@ziepe.ca>
 <6c57cf0d-c7a7-4aac-9eb2-d8bb1d832232@fujitsu.com>
 <CAHj4cs86fFi+1LMMAzjcdGg1g1gbQwy6QgksC0kYVmNgghLV_w@mail.gmail.com>
 <1ffaeaa4-4ac2-4531-8e0c-586e13c14c97@fujitsu.com>
 <366da960-6036-49c5-ad47-3ae3f4e55452@fujitsu.com>
 <8f705223-6fde-4b29-880b-570349f40db8@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <8f705223-6fde-4b29-880b-570349f40db8@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/10/26 17:05, Zhijian Li (Fujitsu) 写道:
> The root cause is that
> 
> rxe:rxe_set_page() gets wrong when mr.page_size != PAGE_SIZE where it only stores the *page to xarray.
> So the offset will get lost.

It is interesting root cause.
page_size is 0x1000, PAGE_SIZE 0x10000.

Zhu Yanjun

> 
> For example,
> store process:
> page_size = 0x1000;
> PAGE_SIZE = 0x10000;
> va0 = 0xffff000020651000;
> page_offset = 0 = va & (page_size - 1);
> page = va_to_page(va);
> xa_store(&mr->page_list, mr->nbuf, page, GFP_KERNEL);
> 
> load_process:
> page = xa_load(&mr->page_list, index);
> page_va = kmap_local_page(page) --> it must be a PAGE_SIZE align value, assume it as 0xffff000020650000
> va1 = page_va + page_offset = 0xffff000020650000 + 0 = 0xffff000020650000;
> 
> Obviously, *va0 != va1*, page_offset get lost.
> 
> 
> How to fix:
> - revert 325a7eb85199 ("RDMA/rxe: Cleanup page variables in rxe_mr.c")
> - don't allow ulp registering mr.page_size != PAGE_SIZE ?
> 
> 
> 
> Thanks
> Zhijian
> 
> 
> On 24/10/2023 17:13, Li Zhijian wrote:
>>
>>
>> On 24/10/2023 16:15, Zhijian Li (Fujitsu) wrote:
>>>
>>>
>>> On 23/10/2023 18:45, Yi Zhang wrote:
>>>> On Mon, Oct 23, 2023 at 11:52 AM Zhijian Li (Fujitsu)
>>>> <lizhijian@fujitsu.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 20/10/2023 22:01, Jason Gunthorpe wrote:
>>>>>> On Fri, Oct 20, 2023 at 03:47:05AM +0000, Zhijian Li (Fujitsu) wrote:
>>>>>>> CC Bart
>>>>>>>
>>>>>>> On 13/10/2023 20:01, Daisuke Matsuda (Fujitsu) wrote:
>>>>>>>> On Fri, Oct 13, 2023 10:18 AM Zhu Yanjun wrote:
>>>>>>>>> From: Zhu Yanjun<yanjun.zhu@linux.dev>
>>>>>>>>>
>>>>>>>>> The page_size of mr is set in infiniband core originally. In the commit
>>>>>>>>> 325a7eb85199 ("RDMA/rxe: Cleanup page variables in rxe_mr.c"), the
>>>>>>>>> page_size is also set. Sometime this will cause conflict.
>>>>>>>> I appreciate your prompt action, but I do not think this commit deals with
>>>>>>>> the root cause. I agree that the problem lies in rxe driver, but what is wrong
>>>>>>>> with assigning actual page size to ibmr.page_size?
>>>>>>>>
>>>>>>>> IMO, the problem comes from the device attribute of rxe driver, which is used
>>>>>>>> in ulp/srp layer to calculate the page_size.
>>>>>>>> =====
>>>>>>>> static int srp_add_one(struct ib_device *device)
>>>>>>>> {
>>>>>>>>              struct srp_device *srp_dev;
>>>>>>>>              struct ib_device_attr *attr = &device->attrs;
>>>>>>>> <...>
>>>>>>>>              /*
>>>>>>>>               * Use the smallest page size supported by the HCA, down to a
>>>>>>>>               * minimum of 4096 bytes. We're unlikely to build large sglists
>>>>>>>>               * out of smaller entries.
>>>>>>>>               */
>>>>>>>>              mr_page_shift           = max(12, ffs(attr->page_size_cap) - 1);
>>>>>>>
>>>>>>>
>>>>>>> You light me up.
>>>>>>> RXE provides attr.page_size_cap(RXE_PAGE_SIZE_CAP) which means it can support 4K-2G page size
>>>>>>
>>>>>> That doesn't seem right even in concept.>
>>>>>> I think the multi-size support in the new xarray code does not work
>>>>>> right, just looking at it makes me think it does not work right. It
>>>>>> looks like it can do less than PAGE_SIZE but more than PAGE_SIZE will
>>>>>> explode because kmap_local_page() does only 4K.
>>>>>>
>>>>>> If RXE_PAGE_SIZE_CAP == PAGE_SIZE  will everything work?
>>>>>>
>>>>>
>>>>> Yeah, this should work(even though i only verified hardcoding mr_page_shift to PAGE_SHIFT).
>>>>
>>>> Hi Zhijian
>>>>
>>>> Did you try blktests nvme/rdma use_rxe on your environment, it still
>>>> failed on my side.
>>>>
>>>
>>> Thanks for your testing.
>>> I just did that, it also failed in my environment. After a glance debug, I found there are
>>> other places still registered 4K MR. I will dig into it later.
>>
>>
>> nvme intend to register 4K mr, but it should work IMO, at least the RXE have handled it correctly.
>>
>>
>> 1293 static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
>> 1294                 struct nvme_rdma_request *req, struct nvme_command *c,
>> 1295                 int count)
>> 1296 {
>> 1297         struct nvme_keyed_sgl_desc *sg = &c->common.dptr.ksgl;
>> 1298         int nr;
>> 1299
>> 1300         req->mr = ib_mr_pool_get(queue->qp, &queue->qp->rdma_mrs);
>> 1301         if (WARN_ON_ONCE(!req->mr))
>> 1302                 return -EAGAIN;
>> 1303
>> 1304         /*
>> 1305          * Align the MR to a 4K page size to match the ctrl page size and
>> 1306          * the block virtual boundary.
>> 1307          */
>> 1308         nr = ib_map_mr_sg(req->mr, req->data_sgl.sg_table.sgl, count, NULL,
>> 1309                           SZ_4K);
>>
>>
>> Anyway, i will go ahead. if you have any thought, please let me know.
>>
>>
>>
>>>
>>> Thanks
>>> Zhijian
>>>
>>>
>>>
>>>
>>>> # use_rxe=1 nvme_trtype=rdma  ./check nvme/003
>>>> nvme/003 (test if we're sending keep-alives to a discovery controller) [failed]
>>>>        runtime  12.179s  ...  11.941s
>>>>        --- tests/nvme/003.out 2023-10-22 10:54:43.041749537 -0400
>>>>        +++ /root/blktests/results/nodev/nvme/003.out.bad 2023-10-23
>>>> 05:52:27.882759168 -0400
>>>>        @@ -1,3 +1,3 @@
>>>>         Running nvme/003
>>>>        -NQN:nqn.2014-08.org.nvmexpress.discovery disconnected 1 controller(s)
>>>>        +NQN:nqn.2014-08.org.nvmexpress.discovery disconnected 0 controller(s)
>>>>         Test complete
>>>>
>>>> [ 7033.431910] rdma_rxe: loaded
>>>> [ 7033.456341] run blktests nvme/003 at 2023-10-23 05:52:15
>>>> [ 7033.502306] (null): rxe_set_mtu: Set mtu to 1024
>>>> [ 7033.510969] infiniband enP2p1s0v0_rxe: set active
>>>> [ 7033.510980] infiniband enP2p1s0v0_rxe: added enP2p1s0v0
>>>> [ 7033.549301] loop0: detected capacity change from 0 to 2097152
>>>> [ 7033.556966] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>>>> [ 7033.566711] nvmet_rdma: enabling port 0 (10.19.240.81:4420)
>>>> [ 7033.588605] nvmet: connect attempt for invalid controller ID 0x808
>>>> [ 7033.594909] nvme nvme0: Connect Invalid Data Parameter, cntlid: 65535
>>>> [ 7033.601504] nvme nvme0: failed to connect queue: 0 ret=16770
>>>> [ 7046.317861] rdma_rxe: unloaded
>>>>
>>>>
>>>>>
>>>>>>>> import ctypes
>>>>>>>> libc = ctypes.cdll.LoadLibrary('libc.so.6')
>>>>>>>> hex(65536)
>>>>> '0x10000'
>>>>>>>> libc.ffs(0x10000) - 1
>>>>> 16
>>>>>>>> 1 << 16
>>>>> 65536
>>>>>
>>>>> so
>>>>> mr_page_shift = max(12, ffs(attr->page_size_cap) - 1) = max(12, 16) = 16;
>>>>>
>>>>>
>>>>> So I think Daisuke's patch should work as well.
>>>>>
>>>>> https://lore.kernel.org/linux-rdma/OS3PR01MB98652B2EC2E85DAEC6DDE484E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com/T/#md133060414f0ba6a3dbaf7b4ad2374c8a347cfd1
>>>>>
>>>>>
>>>>>> Jason
>>>>
>>>>
>>>>
>>>> -- 
>>>> Best Regards,
>>>>      Yi Zhang

