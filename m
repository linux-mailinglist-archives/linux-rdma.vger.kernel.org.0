Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F3B61272C
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Oct 2022 04:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiJ3Dd5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 29 Oct 2022 23:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJ3Ddy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 29 Oct 2022 23:33:54 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B28D476C9;
        Sat, 29 Oct 2022 20:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1667100830; i=@fujitsu.com;
        bh=gno1/0vNe/YOEtCBHguxYVAH15s+9OzRJAgfAiRxFHc=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=CkKH/hIWXFsn93KfXEsPrS9s3sC+zG5uszg8z20rkBzT7l9jycOciKyozrTc8idyK
         0Ded/cOY4ZS9F2tXVq+kU8S/DlMXXAUZuSYdX+aB2w37phDPR47jwZIQQ8o3ZN3j7/
         Igg5WVO1HMnG2dHK1KRtUtDh43/8FG58NWLpN/w/l3zJVOL37amtY5gqVthfBAuIK3
         futugkDWVF+Cz6hDSUEGgczCI0eH/f+v3ruVvOXoZF29HlfhF/07wdXC6njpBwreVz
         PhQxp1e+aovE6nvCJKfkzzN5F9pIaKGghvaZfsBxx9o8WwVOmCzJkTKZgLgajMkhtN
         jGPCd9DxWUA0A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRWlGSWpSXmKPExsViZ8MxSXfOh9h
  kg7PfmSymT73AaHHl3x5Giym/ljJbnPvrZ3F51xw2i2eHelksPkw9wmzxZeo0ZotTv04xWfy9
  9I/N4vyxfnYHbo+ds+6ye7QcecvqsXjPSyaPTas62Tx6m9+xeVx+coXR4/MmuQD2KNbMvKT8i
  gTWjP57t9gLvmhW3J3Wzt7A2KvSxcjFISSwhVFiY/s7VghnOZPEjKd32SCcbYwS7b2XWLoYOT
  l4Bewkjv1ZC2azCKhKNH/5zAwRF5Q4OfMJWFxUIELi4aNJYLawQIrE7x1zWEFsZgFxiVtP5jO
  B2CICKhInTpxhB1nALHCTSeLom9tgCSGBDkaJ70u8QWw2AQ2Jey03GUFsTgEtiak9GxghBllI
  LH5zkB3Clpdo3job7AgJAUWJI51/WSDsColZs9qYIGw1iavnNjFPYBSeheTWWUhumoVk7CwkY
  xcwsqxiNC1OLSpLLdI11EsqykzPKMlNzMzRS6zSTdRLLdUtTy0u0TXSSywv1kstLtYrrsxNzk
  nRy0st2cQIjN2UYtVDOxhfLfmjd4hRkoNJSZQ3szM2WYgvKT+lMiOxOCO+qDQntfgQowwHh5I
  E76u3QDnBotT01Iq0zBxgGoFJS3DwKInwpr0ASvMWFyTmFmemQ6ROMepynN+5fy+zEEtefl6q
  lDhv/jugIgGQoozSPLgRsJR2iVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5Iwb80boCk8mXklc
  JteAR3BBHRE+qQokCNKEhFSUg1MITH+Db+2F/S/ZxX8prk7hdfqgEuSpeTUG1Mnz6t+kpjz8G
  221SfB3A4tca/QpXN0gu9d4J1t91blbna700LZE1ceuCTszar/V7J6LjOX76TH7sLqF952tdj
  ZvnOyfFf5UPbI5nMv2rwf6PQ+YNvjKTw58dqLJwX6YX5/wx5bzFexleXt31Rv8CBJ82yIApt9
  WWTFWxcV2+e3/lwP3xGYHfn1V2PMbA6pTwU7/IpNDghomyp+fGoS6/LLP8kyPMatjkvnbE1ir
  W7mnQ++S3xDOfVnykop2DlG1t2quv/l/oSjSnNOcZY7bRW53pTOeswu6KlKftW6dycDig2VLz
  t1MrRXZOZyvLl1bb6MoxJLcUaioRZzUXEiAGblD7PkAwAA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-11.tower-571.messagelabs.com!1667100827!729693!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27736 invoked from network); 30 Oct 2022 03:33:48 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-11.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 30 Oct 2022 03:33:48 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id AE99A1000E9;
        Sun, 30 Oct 2022 03:33:47 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id A147A1000D7;
        Sun, 30 Oct 2022 03:33:47 +0000 (GMT)
Received: from [10.167.226.45] (10.167.226.45) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Sun, 30 Oct 2022 03:33:42 +0000
Message-ID: <634031be-4403-8758-9f24-8410a6a1a43d@fujitsu.com>
Date:   Sun, 30 Oct 2022 11:33:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [for-next PATCH v5 05/11] RDMA/rxe: Allow registering persistent
 flag for pmem MR only
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, Zhu Yanjun <zyjzyj2000@gmail.com>,
        <yangx.jy@fujitsu.com>, <y-goto@fujitsu.com>, <mbloch@nvidia.com>,
        <liangwenpeng@huawei.com>, <tom@talpey.com>,
        <tomasz.gromadzki@intel.com>, <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
 <20220927055337.22630-6-lizhijian@fujitsu.com> <Y1wXD/cnIlGUANBY@nvidia.com>
From:   Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <Y1wXD/cnIlGUANBY@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 29/10/2022 01:53, Jason Gunthorpe wrote:
> On Tue, Sep 27, 2022 at 01:53:31PM +0800, Li Zhijian wrote:
>> @@ -122,6 +129,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>>   	int			num_buf;
>>   	void			*vaddr;
>>   	int err;
>> +	bool is_pmem = false;
>>   	int i;
>>   
>>   	umem = ib_umem_get(&rxe->ib_dev, start, length, access);
>> @@ -149,6 +157,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>>   	num_buf			= 0;
>>   	map = mr->map;
>>   	if (length > 0) {
>> +		is_pmem = true;
>>   		buf = map[0]->buf;
>>   
>>   		for_each_sgtable_page (&umem->sgt_append.sgt, &sg_iter, 0) {
>> @@ -166,6 +175,10 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>>   				goto err_cleanup_map;
>>   			}
>>   
>> +			/* True only if the *whole* MR is pmem */
>> +			if (is_pmem)
>> +				is_pmem = vaddr_in_pmem(vaddr);
>> +
> I'm not so keen on this use of resources, but this should be written more
> like
>
> phys = page_to_phys(sg_page_iter_page(&sg_iter))
> region_intersects(phys + sg_iter->offset, sg_iter->length,.. )
>
> And you understand this will make memory registration of every RXE
> user a bit slower?
Good catch, i missed it before.
I tested it qemu guest in which pmem is backing to a normal file in host.
In this case, this testing take ~+9% overhead(1.2S -> 1.3S) for 1G size mr. most the time was taken by gup.

the real pmem environment will be tested later.

To minimize side effect, i updated the code to do pmem mr checking on if the require_pmem is true.

> region_intersects(phys + sg_iter->offset, sg_iter->length,.. )
I haven't fully apply this suggestion since i think my assumption that a page can only associate to a unique/same
memory zone is true. So i only check 1 byte of each page.



index 5d014cef916e..e4e7c180fa0d 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -112,6 +112,13 @@ void rxe_mr_init_dma(int access, struct rxe_mr *mr)
         mr->ibmr.type = IB_MR_TYPE_DMA;
  }

+static bool paddr_in_pmem(unsigned long paddr)
+{
+       return REGION_INTERSECTS ==
+              region_intersects(paddr, 1, IORESOURCE_MEM,
+                                IORES_DESC_PERSISTENT_MEMORY);
+}
+
  int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
                      int access, struct rxe_mr *mr)
  {
@@ -122,6 +129,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
         int                     num_buf;
         void                    *vaddr;
         int err;
+       bool require_pmem = access & IB_ACCESS_FLUSH_PERSISTENT;

         umem = ib_umem_get(&rxe->ib_dev, start, length, access);
         if (IS_ERR(umem)) {
@@ -149,6 +157,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
         num_buf                 = 0;
         map = mr->map;
         if (length > 0) {
+               struct page *pg;
                 buf = map[0]->buf;

                 for_each_sgtable_page (&umem->sgt_append.sgt, &sg_iter, 0) {
@@ -158,13 +167,20 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
                                 num_buf = 0;
                         }

-                       vaddr = page_address(sg_page_iter_page(&sg_iter));
+                       pg = sg_page_iter_page(&sg_iter);
+                       vaddr = page_address(pg);
                         if (!vaddr) {
                                 pr_warn("%s: Unable to get virtual address\n",
                                                 __func__);
                                 err = -ENOMEM;
                                 goto err_release_umem;
                         }
+
+                       if (require_pmem && !paddr_in_pmem(page_to_phys(pg))) {
+                               err = -EINVAL;
+                               goto err_release_umem;
+                       }
+
                         buf->addr = (uintptr_t)vaddr;
                         num_buf++;
                         buf++;


> And actual pmem will be painfully slow.
>
> It seems like we are doing something wrong here..
>

Do you think we don't need this patch ?


>> @@ -174,6 +187,12 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>>   		}
>>   	}
>>   
>> +	if (!is_pmem && access & IB_ACCESS_FLUSH_PERSISTENT) {
>> +		pr_warn("Cannot register IB_ACCESS_FLUSH_PERSISTENT for non-pmem memory\n");
>> +		err = -EINVAL;
>> +		goto err_release_umem;
>> +	}
> Do not pr_warn on syscall paths

Got it, will remove it.

Thanks
Zhijian


>
> Jason

