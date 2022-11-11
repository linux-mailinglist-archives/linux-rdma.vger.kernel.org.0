Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AA2625359
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 07:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiKKGHy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Nov 2022 01:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiKKGHw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Nov 2022 01:07:52 -0500
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E09F5E9E5
        for <linux-rdma@vger.kernel.org>; Thu, 10 Nov 2022 22:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1668146869; i=@fujitsu.com;
        bh=Ddwo0i9PQJCNeKeG7eDIiEq5HIdUKq4hfZkVWUtsHt4=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=k+QW6lck33CGQFWf5PSdwgtfnanYSigORGHwaidd+fh41lFyvVyg2wqEkSGr0qp8x
         fApFtv9mC38EihjqTjbhCSBiSrZKL+oe0/TB3XeGZl6v9gjWHk+s3W7AdmO/dX4FD/
         tx6Q1+Q6sWVtavOdyrrXG8DvtUAyUQKhvEy/e7aVoo3kq2W3bQ8+7EzKJ6T99vNPmK
         f99uVRd7TmsSIDzrGFqUUOQTWQUJd3+Bg5YMQ+DlkRyS+MXhRlbxvmG/jjvjf8+f2Q
         rZXtm6cBkN6cn+Pkxo2hgBHxwTnlQmb4E0LKT5lcrEzVtOyCFR3/DtK74zDbiaZBki
         0Cw3mF5/cgHHg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleJIrShJLcpLzFFi42Kxs+GYpLvlWW6
  ywezpfBb7nz5nsbjybw+jxbNDvSwWDW+5HFg8Wo68ZfVYvOclk0dv8zs2j8+b5AJYolgz85Ly
  KxJYM7p33mAteOld0d55mqWB8YRNFyMXh5DAFkaJ2btPsUA4y5kkptxayQThbGOUuPNxPpDDy
  cErYCdx5exGZhCbRUBVYsP9zSwQcUGJkzOfgNmiAkkSVzfcZQWxhQV8JJbfm8XexcjBISIQLL
  H/TDpImFkgROLF5uNg5UICJRKrJ/0GK2cTcJSYN2sjG4jNCbTq+ebHzBD1FhKL3xxkh7DlJba
  /nQMWlxBQlGhb8o8dwq6QmDWrjQnCVpO4em4T8wRGoVlIrpuFZNQsJKMWMDKvYjQtTi0qSy3S
  NdFLKspMzyjJTczM0Uus0k3USy3VLU8tLtE10kssL9ZLLS7WK67MTc5J0ctLLdnECIyRlGJVz
  x2Mf5b+0TvEKMnBpCTKu88mN1mILyk/pTIjsTgjvqg0J7X4EKMMB4eSBO+lx0A5waLU9NSKtM
  wcYLzCpCU4eJREePOeAKV5iwsSc4sz0yFSpxh1OabO/refWYglLz8vVUqcN+IpUJEASFFGaR7
  cCFjquMQoKyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmFcLZApPZl4J3KZXQEcwAR1hl5oFckRJ
  IkJKqoGp/4zNxEcTHAQUHge1r9SYynwjX8h4ZrOsW9q9+nN7HldUrs+KvLOf9Y3GnAaNKwk+q
  5mMO/yPrbliGm5Qpi6k/FdB6PGa8O9aa5fxiDzzWPBmu16A0MmJqySnLzlh+HChs+RuqXv7nH
  dfsAt/KvIv4Zzd5G/fbSya+VVZxTl/LH9/u3Tr4QcJJiq7nn1Y+dlDwvTK4pYv3l0X7Sd0NE0
  K2H2949s3dYUzN9sWH3o+wffE7UC9TJeaGu5pc2+8K/nT/HbOfcZK4RXRaUWLznVdnmHw94Fx
  gkeG04dzHzqqfFZ9j3ipVzvjZ2tbojxPkMwVv5d+9+Qfqdiu2lSitubj1cBtAnHKy6Y7e5r3l
  mU2KrEUZyQaajEXFScCADikRDeYAwAA
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-4.tower-565.messagelabs.com!1668146868!258840!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9855 invoked from network); 11 Nov 2022 06:07:48 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-4.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 11 Nov 2022 06:07:48 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id E06C61000E7;
        Fri, 11 Nov 2022 06:07:47 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id D2D031000D5;
        Fri, 11 Nov 2022 06:07:47 +0000 (GMT)
Received: from [10.167.215.54] (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 11 Nov 2022 06:07:44 +0000
Message-ID: <60e8ee7b-96f1-6570-471b-d7a7114bd2fd@fujitsu.com>
Date:   Fri, 11 Nov 2022 14:07:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/rxe: Replace page_address() with kmap_local_page()
To:     Yunsheng Lin <linyunsheng@huawei.com>, <jgg@nvidia.com>,
        <ira.weiny@intel.com>
CC:     <linux-rdma@vger.kernel.org>, <lizhijian@fujitsu.com>,
        <Gotoy-goto@fujitsu.com>
References: <1668136765-34-1-git-send-email-yangx.jy@fujitsu.com>
 <11a89848-c4db-6465-8b55-9fc600392cf7@huawei.com>
From:   =?UTF-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
In-Reply-To: <11a89848-c4db-6465-8b55-9fc600392cf7@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.215.54]
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

On 2022/11/11 11:34, Yunsheng Lin wrote:
> On 2022/11/11 11:19, Xiao Yang wrote:
>> 1) Use kmap_local_page() for new in-kernel memory protection schemes.
>> 2) Do some cleanup(e.g. remove struct rxe_phys_buf).
> 
> As the commit log above, it seems better to spilt it to two patches:
> Patch 1: Do some cleanup
> Patch 2: Use kmap_local_page()

Hi Lin,

It's fine for me to split the patchset. I will send v2 soon.

> 
> 
> Alas, does not pin_user_pages_fast() in ib_umem_get() ensure the
> user memory is accessible in the kernel space, which means we
> can use page_address() safely?

Now it's safe to call page_address() here but it will be broken when new 
in-kernel memory protection schemes(e.g. PKS[1]) are applied in the future.

[1]: 
https://lore.kernel.org/lkml/20220419170649.1022246-1-ira.weiny@intel.com/

Jason suggested that we should replace page_address() with 
kmap_local_page(), please see the detailed discussion[2][3]

[2]: 
https://lore.kernel.org/linux-rdma/20220121160654.GC773547@iweiny-DESK2.sc.intel.com/
[3]: https://lore.kernel.org/linux-rdma/Y1bFG%2FOM5zSOoWcr@nvidia.com/

Best Regards,
Xiao Yang
> 
> 
>>
>> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_loc.h   |  2 +
>>   drivers/infiniband/sw/rxe/rxe_mr.c    | 84 +++++++++++++--------------
>>   drivers/infiniband/sw/rxe/rxe_resp.c  |  1 +
>>   drivers/infiniband/sw/rxe/rxe_verbs.c |  6 +-
>>   drivers/infiniband/sw/rxe/rxe_verbs.h |  9 +--
>>   5 files changed, 45 insertions(+), 57 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
>> index c2a5c8814a48..a63d29156a66 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
>> @@ -68,6 +68,8 @@ void rxe_mr_init_dma(int access, struct rxe_mr *mr);
>>   int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>>   		     int access, struct rxe_mr *mr);
>>   int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
>> +void *rxe_map_to_vaddr(struct rxe_mr *mr, int map_index, int addr_index, size_t offset);
>> +void rxe_unmap_vaddr(struct rxe_mr *mr, void *vaddr);
>>   int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
>>   		enum rxe_mr_copy_dir dir);
>>   int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
>> index bc081002bddc..4246b7f34a29 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
>> @@ -115,13 +115,10 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>>   		     int access, struct rxe_mr *mr)
>>   {
>>   	struct rxe_map		**map;
>> -	struct rxe_phys_buf	*buf = NULL;
>>   	struct ib_umem		*umem;
>>   	struct sg_page_iter	sg_iter;
>>   	int			num_buf;
>> -	void			*vaddr;
>>   	int err;
>> -	int i;
>>   
>>   	umem = ib_umem_get(&rxe->ib_dev, start, length, access);
>>   	if (IS_ERR(umem)) {
>> @@ -144,32 +141,19 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>>   
>>   	mr->page_shift = PAGE_SHIFT;
>>   	mr->page_mask = PAGE_SIZE - 1;
>> +	mr->ibmr.page_size = PAGE_SIZE;
>>   
>> -	num_buf			= 0;
>> +	num_buf = 0;
>>   	map = mr->map;
>>   	if (length > 0) {
>> -		buf = map[0]->buf;
>> -
>>   		for_each_sgtable_page (&umem->sgt_append.sgt, &sg_iter, 0) {
>>   			if (num_buf >= RXE_BUF_PER_MAP) {
>>   				map++;
>> -				buf = map[0]->buf;
>>   				num_buf = 0;
>>   			}
>>   
>> -			vaddr = page_address(sg_page_iter_page(&sg_iter));
>> -			if (!vaddr) {
>> -				pr_warn("%s: Unable to get virtual address\n",
>> -						__func__);
>> -				err = -ENOMEM;
>> -				goto err_cleanup_map;
>> -			}
>> -
>> -			buf->addr = (uintptr_t)vaddr;
>> -			buf->size = PAGE_SIZE;
>> +			map[0]->addrs[num_buf] = (uintptr_t)sg_page_iter_page(&sg_iter);
>>   			num_buf++;
>> -			buf++;
>> -
>>   		}
>>   	}
>>   
>> @@ -181,10 +165,6 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>>   
>>   	return 0;
>>   
>> -err_cleanup_map:
>> -	for (i = 0; i < mr->num_map; i++)
>> -		kfree(mr->map[i]);
>> -	kfree(mr->map);
>>   err_release_umem:
>>   	ib_umem_release(umem);
>>   err_out:
>> @@ -216,9 +196,9 @@ static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
>>   			size_t *offset_out)
>>   {
>>   	size_t offset = iova - mr->ibmr.iova + mr->offset;
>> +	u64 length = mr->ibmr.page_size;
>>   	int			map_index;
>> -	int			buf_index;
>> -	u64			length;
>> +	int			addr_index;
>>   
>>   	if (likely(mr->page_shift)) {
>>   		*offset_out = offset & mr->page_mask;
>> @@ -227,27 +207,46 @@ static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
>>   		*m_out = offset >> mr->map_shift;
>>   	} else {
>>   		map_index = 0;
>> -		buf_index = 0;
>> -
>> -		length = mr->map[map_index]->buf[buf_index].size;
>> +		addr_index = 0;
>>   
>>   		while (offset >= length) {
>>   			offset -= length;
>> -			buf_index++;
>> +			addr_index++;
>>   
>> -			if (buf_index == RXE_BUF_PER_MAP) {
>> +			if (addr_index == RXE_BUF_PER_MAP) {
>>   				map_index++;
>> -				buf_index = 0;
>> +				addr_index = 0;
>>   			}
>> -			length = mr->map[map_index]->buf[buf_index].size;
>>   		}
>>   
>>   		*m_out = map_index;
>> -		*n_out = buf_index;
>> +		*n_out = addr_index;
>>   		*offset_out = offset;
>>   	}
>>   }
>>   
>> +void *rxe_map_to_vaddr(struct rxe_mr *mr, int map_index, int addr_index, size_t offset)
>> +{
>> +	void *vaddr = NULL;
>> +
>> +	if (mr->ibmr.type == IB_MR_TYPE_USER) {
>> +		vaddr = kmap_local_page((struct page *)mr->map[map_index]->addrs[addr_index]);
>> +		if (vaddr == NULL) {
>> +			pr_warn("Failed to map page");
>> +			return NULL;
>> +		}
>> +	} else
>> +		vaddr = (void *)(uintptr_t)mr->map[map_index]->addrs[addr_index];
>> +
>> +	return vaddr + offset;
>> +}
>> +
>> +void rxe_unmap_vaddr(struct rxe_mr *mr, void *vaddr)
>> +{
>> +	if (mr->ibmr.type == IB_MR_TYPE_USER)
>> +		kunmap_local(vaddr);
>> +}
>> +
>>   void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
>>   {
>>   	size_t offset;
>> @@ -273,13 +272,13 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
>>   
>>   	lookup_iova(mr, iova, &m, &n, &offset);
>>   
>> -	if (offset + length > mr->map[m]->buf[n].size) {
>> +	if (offset + length > mr->ibmr.page_size) {
>>   		pr_warn("crosses page boundary\n");
>>   		addr = NULL;
>>   		goto out;
>>   	}
>>   
>> -	addr = (void *)(uintptr_t)mr->map[m]->buf[n].addr + offset;
>> +	addr = rxe_map_to_vaddr(mr, m, n, offset);
>>   
>>   out:
>>   	return addr;
>> @@ -294,8 +293,6 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
>>   	int			err;
>>   	int			bytes;
>>   	u8			*va;
>> -	struct rxe_map		**map;
>> -	struct rxe_phys_buf	*buf;
>>   	int			m;
>>   	int			i;
>>   	size_t			offset;
>> @@ -325,17 +322,14 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
>>   
>>   	lookup_iova(mr, iova, &m, &i, &offset);
>>   
>> -	map = mr->map + m;
>> -	buf	= map[0]->buf + i;
>> -
>>   	while (length > 0) {
>>   		u8 *src, *dest;
>>   
>> -		va	= (u8 *)(uintptr_t)buf->addr + offset;
>> +		va = (u8 *)rxe_map_to_vaddr(mr, m, i, offset);
>>   		src = (dir == RXE_TO_MR_OBJ) ? addr : va;
>>   		dest = (dir == RXE_TO_MR_OBJ) ? va : addr;
>>   
>> -		bytes	= buf->size - offset;
>> +		bytes = mr->ibmr.page_size - offset;
>>   
>>   		if (bytes > length)
>>   			bytes = length;
>> @@ -346,14 +340,14 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
>>   		addr	+= bytes;
>>   
>>   		offset	= 0;
>> -		buf++;
>>   		i++;
>>   
>>   		if (i == RXE_BUF_PER_MAP) {
>>   			i = 0;
>> -			map++;
>> -			buf = map[0]->buf;
>> +			m++;
>>   		}
>> +
>> +		rxe_unmap_vaddr(mr, va);
>>   	}
>>   
>>   	return 0;
>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
>> index c32bc12cc82f..31f9ba11a921 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>> @@ -652,6 +652,7 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
>>   
>>   	ret = RESPST_ACKNOWLEDGE;
>>   out:
>> +	rxe_unmap_vaddr(mr, vaddr);
>>   	return ret;
>>   }
>>   
>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
>> index bcdfdadaebbc..13e4d660cb02 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
>> @@ -948,16 +948,12 @@ static int rxe_set_page(struct ib_mr *ibmr, u64 addr)
>>   {
>>   	struct rxe_mr *mr = to_rmr(ibmr);
>>   	struct rxe_map *map;
>> -	struct rxe_phys_buf *buf;
>>   
>>   	if (unlikely(mr->nbuf == mr->num_buf))
>>   		return -ENOMEM;
>>   
>>   	map = mr->map[mr->nbuf / RXE_BUF_PER_MAP];
>> -	buf = &map->buf[mr->nbuf % RXE_BUF_PER_MAP];
>> -
>> -	buf->addr = addr;
>> -	buf->size = ibmr->page_size;
>> +	map->addrs[mr->nbuf % RXE_BUF_PER_MAP] = addr;
>>   	mr->nbuf++;
>>   
>>   	return 0;
>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> index 22a299b0a9f0..d136f02d5b56 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> @@ -277,15 +277,10 @@ enum rxe_mr_lookup_type {
>>   	RXE_LOOKUP_REMOTE,
>>   };
>>   
>> -#define RXE_BUF_PER_MAP		(PAGE_SIZE / sizeof(struct rxe_phys_buf))
>> -
>> -struct rxe_phys_buf {
>> -	u64      addr;
>> -	u64      size;
>> -};
>> +#define RXE_BUF_PER_MAP		(PAGE_SIZE / sizeof(u64))
>>   
>>   struct rxe_map {
>> -	struct rxe_phys_buf	buf[RXE_BUF_PER_MAP];
>> +	u64 addrs[RXE_BUF_PER_MAP];
>>   };
>>   
>>   static inline int rkey_is_mw(u32 rkey)
>>
