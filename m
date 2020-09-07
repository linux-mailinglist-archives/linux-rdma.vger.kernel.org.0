Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A856725FA9D
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 14:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgIGMou (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 08:44:50 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11897 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729262AbgIGMor (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Sep 2020 08:44:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f562b1a0000>; Mon, 07 Sep 2020 05:44:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 07 Sep 2020 05:44:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 07 Sep 2020 05:44:24 -0700
Received: from [172.27.12.170] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 7 Sep
 2020 12:44:16 +0000
Subject: Re: [PATCH rdma-next 3/4] lib/scatterlist: Add support in dynamic
 allocation of SG table from pages
To:     Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
References: <20200903121853.1145976-1-leon@kernel.org>
 <20200903121853.1145976-4-leon@kernel.org> <20200907072921.GC19875@lst.de>
From:   Maor Gottlieb <maorg@nvidia.com>
Message-ID: <15552707-c9ae-b76b-f6ff-7fedd5b02aed@nvidia.com>
Date:   Mon, 7 Sep 2020 15:44:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200907072921.GC19875@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599482650; bh=Do+ITTDxBPQkRwNINDAMtH/xddQo5kNkcXGmE8sqjYI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:
         Content-Transfer-Encoding:Content-Language:X-Originating-IP:
         X-ClientProxiedBy;
        b=T9kSV4Vx3B5KdRjaa2H9jq5hfVpsWyHmHeZo8m9GE/J0ZZnId6jCB8TZmVUpK8Ice
         FV6Q7vvKlIoIuvv0HhR0I2SMC97KcKbT4TI63pJpKiB1YfbRTYLQ1Mlhsz2Smjy4lj
         LkqbVDtLtM3sei34IQX41ndOdcRECr7Vx914sJh6x8OpEANC5k86qo5fWtfZ3mvQc1
         eWChnZH+yxHmxM2GjSNaZX+7qAiro30JXqv1CyceB+zEXkcWgriINYAPv7OmYI4uiy
         RAgR1SzsTGGy1pc8SbuSPb5ylRguuYh23V/1+FXIHRXry/GACHeAYnOuah/aiE+e+R
         Y/q5m1lubwfpw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 9/7/2020 10:29 AM, Christoph Hellwig wrote:
> On Thu, Sep 03, 2020 at 03:18:52PM +0300, Leon Romanovsky wrote:
>> +struct sg_append {
>> +	struct scatterlist *prv; /* Previous entry to append */
>> +	unsigned int left_pages; /* Left pages to add to table */
>> +};
> I don't really see the point in this structure.   Either pass it as
> two separate arguments, or switch sg_alloc_table_append and the
> internal helper to pass all arguments as a struct.

I did it to avoid more than 8 arguments of this function, will change it 
to be 9 if it's fine for you.
>
>> + *    A user may provide an offset at a start and a size of valid data in a buffer
>> + *    specified by the page array. A user may provide @append to chain pages to
> This adds a few pointles > 80 char lines.

Will fix.
>
>> +struct scatterlist *
>> +sg_alloc_table_append(struct sg_table *sgt, struct page **pages,
>> +		      unsigned int n_pages, unsigned int offset,
>> +		      unsigned long size, unsigned int max_segment,
>> +		      gfp_t gfp_mask, struct sg_append *append)
>> +{
>> +#ifdef CONFIG_ARCH_NO_SG_CHAIN
>> +	if (append->left_pages)
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +#endif
> Which makes this API entirely useless for !CONFIG_ARCH_NO_SG_CHAIN,
> doesn't it?  Wouldn't it make more sense to not provide it for that
> case and add an explicitl dependency in the callers?

Current implementation allow us to support small memory registration 
which not require chaining. I am not aware which archs has the SG_CHAIN 
support and I don't want to break it so I can't add it to as dependency 
to the Kconfig. Another option is to do the logic in the caller, but it 
isn't clean.

>
>> +	return alloc_from_pages_common(sgt, pages, n_pages, offset, size,
>> +				       max_segment, gfp_mask, append);
> And if we somehow manage to sort that out we can merge
> sg_alloc_table_append and alloc_from_pages_common, reducing the amount
> of wrappers that just make it too hard to follow the code.
>
>> +EXPORT_SYMBOL(sg_alloc_table_append);
> EXPORT_SYMBOL_GPL, please.

Sure
