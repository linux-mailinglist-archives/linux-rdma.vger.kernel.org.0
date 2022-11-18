Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E04862ED29
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Nov 2022 06:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240580AbiKRFWT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Nov 2022 00:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiKRFWS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Nov 2022 00:22:18 -0500
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508226E561
        for <linux-rdma@vger.kernel.org>; Thu, 17 Nov 2022 21:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1668748935; i=@fujitsu.com;
        bh=r/q/ZxKRmGnnJ4y7UaVqEfzYehmiNcG7d74ghP/HWQU=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=MUVquRIrVtI4izbSBV1qayvi91ukVGwL+XEoerbWle41tgcC/PKS6JEYJzIv2FP0P
         7ImjyQPxvMiecXM+SOMMul1VfvFxgVUyFcl2Qxu8mOQMSEEGhH0FRdYYrNQeBwEXdb
         dpx611OpZ2N1pe893NBNAeV3oY6H+Wd5CXVZit2upychk/kINg8KsNiLMnQwtQI8Tr
         71GEagD7U8uxOjLA2qHsJQ3NPwYdz3Pn6agbwKv3Hcz1Nlg5lGvVxIysJK0QUabzJ1
         Wj7NSrerBB47OR2d3NY3xVLG2ZLb4H4zi2A/fgrvgfxdlHzv6fthChLjT+eldum4CJ
         XES8W8Ec6pfQw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleJIrShJLcpLzFFi42Kxs+FI0m0TK08
  2eNurY7H/6XMWiyv/9jBaPDvUy2LR8JbLgcWj5chbVo/Fe14yefQ2v2Pz+LxJLoAlijUzLym/
  IoE1Y+fk90wFH/Uq2ifWNTBOV+li5OIQEtjIKLF3/zJmCGcJk8S6Df1sEM42Rombu2cydTFyc
  vAK2Ek82jyJDcRmEVCVuLfxMStEXFDi5MwnLCC2qECSxNUNd4HiHBzCAg4SHXc4QMIiAq4SDW
  efM4LYzAKWEre/LAezhQQcJf79vAc2kg3InjdrI5jNKeAkMWXLJVaIeguJxW8OskPY8hLb385
  hBrElBBQl2pb8Y4ewKyRmzWpjgrDVJK6e28Q8gVFoFpLrZiEZNQvJqAWMzKsYzYpTi8pSi3QN
  jfSSijLTM0pyEzNz9BKrdBP1Ukt1y1OLS3SN9BLLi/VSi4v1iitzk3NS9PJSSzYxAmMkpVipe
  Qfj32V/9A4xSnIwKYnypguXJwvxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4J0rAJQTLEpNT61Iy8
  wBxitMWoKDR0mE9ylImre4IDG3ODMdInWKUZdj6ux/+5mFWPLy81KlxHnTRICKBECKMkrz4Eb
  AUsclRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK8ZkJAU3gy80rgNr0COoIJ6Igc5zKQI0oS
  EVJSDUyJuYL7nr78wvjHL3Pe/WutaR4sdwqeF+8XKm1VeHS97kASm1qHfvfX1u/NVen2vAqh2
  49crt6nvIzTbcY7D8b8H4G5e9SiGZt1Q5Mtes/scdTLf3M9jzkivbwm+NTrSzFnZjyasj4weG
  LeSbsq+S+HWT+dmMP+fLfgV/e78Y9EGRTT1/eKezsKe6xffe8c95x9b58Kltzc6Kb7a5XGxMc
  Xe1ZF/Svn83yquVJmYbC03ayYFXIe+XfP+p4oV37wae7UtYJyE9emuoqt/Pu+tcTeXHeO2vW/
  n2Mm3SuxtSvsvX1/74PCmQY7VUPf1Djsmfb07jnPreuZri2QvO8ZoJe0bWOi3/H31kmzrkh6P
  zmlxFKckWioxVxUnAgATiwb1JgDAAA=
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-12.tower-571.messagelabs.com!1668748934!36222!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5368 invoked from network); 18 Nov 2022 05:22:14 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-12.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 18 Nov 2022 05:22:14 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 5C194201;
        Fri, 18 Nov 2022 05:22:14 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 510711D6;
        Fri, 18 Nov 2022 05:22:14 +0000 (GMT)
Received: from [10.167.215.54] (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 18 Nov 2022 05:22:11 +0000
Message-ID: <8ef3b4e4-82b6-f30e-9c40-9d7f730ae900@fujitsu.com>
Date:   Fri, 18 Nov 2022 13:22:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Remove struct rxe_phys_buf
To:     <jgg@nvidia.com>, <ira.weiny@intel.com>, <linyunsheng@huawei.com>
CC:     <lizhijian@fujitsu.com>, <linux-rdma@vger.kernel.org>
References: <1668153085-15-1-git-send-email-yangx.jy@fujitsu.com>
From:   =?UTF-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
In-Reply-To: <1668153085-15-1-git-send-email-yangx.jy@fujitsu.com>
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

Hi Jason, Ira and others

Kindly ping. I hope you can review them.
Thank you in advance.

Best Regards,
Xiao Yang

On 2022/11/11 15:51, Xiao Yang wrote:
> 1) Remove rxe_phys_buf[n].size by using ibmr.page_size.
> 2) Replace rxe_phys_buf[n].buf with addrs[n].
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_mr.c    | 45 +++++++++------------------
>   drivers/infiniband/sw/rxe/rxe_verbs.c |  6 +---
>   drivers/infiniband/sw/rxe/rxe_verbs.h |  9 ++----
>   3 files changed, 18 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index bc081002bddc..4438eb8a3727 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -115,7 +115,6 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>   		     int access, struct rxe_mr *mr)
>   {
>   	struct rxe_map		**map;
> -	struct rxe_phys_buf	*buf = NULL;
>   	struct ib_umem		*umem;
>   	struct sg_page_iter	sg_iter;
>   	int			num_buf;
> @@ -144,16 +143,14 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>   
>   	mr->page_shift = PAGE_SHIFT;
>   	mr->page_mask = PAGE_SIZE - 1;
> +	mr->ibmr.page_size = PAGE_SIZE;
>   
> -	num_buf			= 0;
> +	num_buf	= 0;
>   	map = mr->map;
>   	if (length > 0) {
> -		buf = map[0]->buf;
> -
>   		for_each_sgtable_page (&umem->sgt_append.sgt, &sg_iter, 0) {
>   			if (num_buf >= RXE_BUF_PER_MAP) {
>   				map++;
> -				buf = map[0]->buf;
>   				num_buf = 0;
>   			}
>   
> @@ -165,10 +162,8 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>   				goto err_cleanup_map;
>   			}
>   
> -			buf->addr = (uintptr_t)vaddr;
> -			buf->size = PAGE_SIZE;
> +			map[0]->addrs[num_buf] = (uintptr_t)vaddr;
>   			num_buf++;
> -			buf++;
>   
>   		}
>   	}
> @@ -216,9 +211,9 @@ static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
>   			size_t *offset_out)
>   {
>   	size_t offset = iova - mr->ibmr.iova + mr->offset;
> +	u64 length = mr->ibmr.page_size;
>   	int			map_index;
> -	int			buf_index;
> -	u64			length;
> +	int			addr_index;
>   
>   	if (likely(mr->page_shift)) {
>   		*offset_out = offset & mr->page_mask;
> @@ -227,23 +222,20 @@ static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
>   		*m_out = offset >> mr->map_shift;
>   	} else {
>   		map_index = 0;
> -		buf_index = 0;
> -
> -		length = mr->map[map_index]->buf[buf_index].size;
> +		addr_index = 0;
>   
>   		while (offset >= length) {
>   			offset -= length;
> -			buf_index++;
> +			addr_index++;
>   
> -			if (buf_index == RXE_BUF_PER_MAP) {
> +			if (addr_index == RXE_BUF_PER_MAP) {
>   				map_index++;
> -				buf_index = 0;
> +				addr_index = 0;
>   			}
> -			length = mr->map[map_index]->buf[buf_index].size;
>   		}
>   
>   		*m_out = map_index;
> -		*n_out = buf_index;
> +		*n_out = addr_index;
>   		*offset_out = offset;
>   	}
>   }
> @@ -273,13 +265,13 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
>   
>   	lookup_iova(mr, iova, &m, &n, &offset);
>   
> -	if (offset + length > mr->map[m]->buf[n].size) {
> +	if (offset + length > mr->ibmr.page_size) {
>   		pr_warn("crosses page boundary\n");
>   		addr = NULL;
>   		goto out;
>   	}
>   
> -	addr = (void *)(uintptr_t)mr->map[m]->buf[n].addr + offset;
> +	addr = (void *)(uintptr_t)mr->map[m]->addrs[n] + offset;
>   
>   out:
>   	return addr;
> @@ -294,8 +286,6 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
>   	int			err;
>   	int			bytes;
>   	u8			*va;
> -	struct rxe_map		**map;
> -	struct rxe_phys_buf	*buf;
>   	int			m;
>   	int			i;
>   	size_t			offset;
> @@ -325,17 +315,14 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
>   
>   	lookup_iova(mr, iova, &m, &i, &offset);
>   
> -	map = mr->map + m;
> -	buf	= map[0]->buf + i;
> -
>   	while (length > 0) {
>   		u8 *src, *dest;
>   
> -		va	= (u8 *)(uintptr_t)buf->addr + offset;
> +		va	= (u8 *)(uintptr_t)mr->map[m]->addrs[i] + offset;
>   		src = (dir == RXE_TO_MR_OBJ) ? addr : va;
>   		dest = (dir == RXE_TO_MR_OBJ) ? va : addr;
>   
> -		bytes	= buf->size - offset;
> +		bytes	= mr->ibmr.page_size - offset;
>   
>   		if (bytes > length)
>   			bytes = length;
> @@ -346,13 +333,11 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
>   		addr	+= bytes;
>   
>   		offset	= 0;
> -		buf++;
>   		i++;
>   
>   		if (i == RXE_BUF_PER_MAP) {
>   			i = 0;
> -			map++;
> -			buf = map[0]->buf;
> +			m++;
>   		}
>   	}
>   
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index bcdfdadaebbc..13e4d660cb02 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -948,16 +948,12 @@ static int rxe_set_page(struct ib_mr *ibmr, u64 addr)
>   {
>   	struct rxe_mr *mr = to_rmr(ibmr);
>   	struct rxe_map *map;
> -	struct rxe_phys_buf *buf;
>   
>   	if (unlikely(mr->nbuf == mr->num_buf))
>   		return -ENOMEM;
>   
>   	map = mr->map[mr->nbuf / RXE_BUF_PER_MAP];
> -	buf = &map->buf[mr->nbuf % RXE_BUF_PER_MAP];
> -
> -	buf->addr = addr;
> -	buf->size = ibmr->page_size;
> +	map->addrs[mr->nbuf % RXE_BUF_PER_MAP] = addr;
>   	mr->nbuf++;
>   
>   	return 0;
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index 22a299b0a9f0..d136f02d5b56 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -277,15 +277,10 @@ enum rxe_mr_lookup_type {
>   	RXE_LOOKUP_REMOTE,
>   };
>   
> -#define RXE_BUF_PER_MAP		(PAGE_SIZE / sizeof(struct rxe_phys_buf))
> -
> -struct rxe_phys_buf {
> -	u64      addr;
> -	u64      size;
> -};
> +#define RXE_BUF_PER_MAP		(PAGE_SIZE / sizeof(u64))
>   
>   struct rxe_map {
> -	struct rxe_phys_buf	buf[RXE_BUF_PER_MAP];
> +	u64 addrs[RXE_BUF_PER_MAP];
>   };
>   
>   static inline int rkey_is_mw(u32 rkey)
