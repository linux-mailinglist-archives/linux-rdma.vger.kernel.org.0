Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A60F25FA91
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 14:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgIGMgZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 08:36:25 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11108 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729191AbgIGMew (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Sep 2020 08:34:52 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5628d50003>; Mon, 07 Sep 2020 05:34:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 07 Sep 2020 05:34:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 07 Sep 2020 05:34:43 -0700
Received: from [172.27.12.170] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 7 Sep
 2020 12:34:36 +0000
Subject: Re: [PATCH rdma-next 2/4] lib/scatterlist: Add support in dynamically
 allocation of SG entries
To:     Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
References: <20200903121853.1145976-1-leon@kernel.org>
 <20200903121853.1145976-3-leon@kernel.org> <20200907072916.GB19875@lst.de>
From:   Maor Gottlieb <maorg@nvidia.com>
Message-ID: <5fe4d1ce-2c08-ebc1-5b05-3bb051b35069@nvidia.com>
Date:   Mon, 7 Sep 2020 15:34:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200907072916.GB19875@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599482069; bh=Y6PLUbvnGcn7GIGt3cB8hv9M8p6UYp7BGJJ6Xjw8nng=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:
         Content-Transfer-Encoding:Content-Language:X-Originating-IP:
         X-ClientProxiedBy;
        b=dXshJYHJlOZVDbwSKUA8+3fll3gCNyYlc1xSj1YvQDSXSQenMB0ATYEJ9/ZvFREg1
         QuWZiM89ncBvT/7FV0y5/tj1CmxUW9+hGVnbrsKXeQ8ZyCbajnzqFazRnTNSN8Ik+5
         HRtnbUrN09kpcKNZETKjBRQEpmGC2N8xQUhkhLIp9pinryslBbPmus9YnUoYReB3zS
         p8D70vixF9Nvkj1IIbcSRAHkRLlUT68DzXBkc8eAcleChpMPx/rLdCiPMUKA8407QN
         BRZeA/LLxfwYe5pYS7QcDkjBVwmU3sRB2oKdZoo5Iyxz5wWMx31f1Rt+PfPgWamvvP
         2DiGBL4KHW39A==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 9/7/2020 10:29 AM, Christoph Hellwig wrote:
>> +static inline void _sg_chain(struct scatterlist *chain_sg,
>> +			     struct scatterlist *sgl)
>> +{
>> +	/*
>> +	 * offset and length are unused for chain entry. Clear them.
>> +	 */
>> +	chain_sg->offset = 0;
>> +	chain_sg->length = 0;
>> +
>> +	/*
>> +	 * Set lowest bit to indicate a link pointer, and make sure to clear
>> +	 * the termination bit if it happens to be set.
>> +	 */
>> +	chain_sg->page_link = ((unsigned long) sgl | SG_CHAIN) & ~SG_END;
>> +}
> Please call this __sg_chain to stick with our normal kernel naming
> convention.

Will do.
