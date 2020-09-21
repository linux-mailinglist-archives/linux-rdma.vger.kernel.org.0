Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72E32730CF
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Sep 2020 19:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgIURXp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Sep 2020 13:23:45 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13536 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgIURXp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Sep 2020 13:23:45 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f68e1440000>; Mon, 21 Sep 2020 10:22:12 -0700
Received: from [172.27.13.124] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Sep
 2020 17:23:43 +0000
Subject: Re: [PATCH rdma-next v1 1/4] IB/core: Improve ODP to use
 hmm_range_fault()
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
References: <20200917112152.1075974-1-leon@kernel.org>
 <20200917112152.1075974-2-leon@kernel.org> <20200921142339.GT3699@nvidia.com>
 <4f3e52f3-2534-b109-0845-8d91f620f370@nvidia.com>
 <20200921152600.GV3699@nvidia.com>
From:   Yishai Hadas <yishaih@nvidia.com>
Message-ID: <6f9bc79e-6c5f-61d4-7544-b396554523e5@nvidia.com>
Date:   Mon, 21 Sep 2020 20:23:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921152600.GV3699@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL109.nvidia.com (172.20.187.15) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600708932; bh=NapB02pKMIxo+zkLRlzhWyrHAD8hl8rTu27Gen9ug9U=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=Gau2k/UMUqmP1wFlmRXLqv/KgJB29V78zEUyHxok3G5Zh+2OHST2xfD003gy9fq9/
         2OMwFsltepatyK+rdbpo9iw0/I7CCyJlQ/+qeImgsfrCLhYOJeTx7CeSY61WPWGyJ8
         HygsXcutfbXWCRPlZmQoa9aJzX0aicfyWxSjyevu1cwR+4RuA1T2Ycgxcoz9zzIOsa
         +fmxwCWSAVnioyztfSetqiOLwwEY8WXVSs0NGvYHr8iDxQvApFAGj0dKRlxwXHi3br
         Egtkk3B85xlnTJEmAPJ8zcf1tmxXUomUkIGPWhBFHeOAU/RxqrZZ4R08WRxp8srzKH
         4xJrQFdaE6ccg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/21/2020 6:26 PM, Jason Gunthorpe wrote:
> On Mon, Sep 21, 2020 at 06:17:51PM +0300, Yishai Hadas wrote:
>> On 9/21/2020 5:23 PM, Jason Gunthorpe wrote:
>>> On Thu, Sep 17, 2020 at 02:21:49PM +0300, Leon Romanovsky wrote:
>>>
>>>> -out:
>>>> -	put_page(page);
>>>> -	return ret;
>>>> +	*dma_addr &=3D ODP_DMA_ADDR_MASK;
>>> I thought we agreed to get rid of this because it must be zero?
>>>
>>> Jason
>> At the end we agreed to not rely on as potentially dma_addr may be zero,=
 the
>> access flags are used=C2=A0 to mark an entry as valid in this case (see =
also
>> ib_umem_odp_unmap_dma_pages).
> I mean the mask, that masking is always a NOP or it is really broken
>
> Jason

I tend to agree that this is redundant as the invalidation flow should=20
to the cleanup in case was some change in access from previous setting.
However,
Don't we want to have it for clearness at least as of the non-faulting=20
mode (i.e. snapshot) that we just add in this series which get current=20
CPU page access and sets it ?

Yishai

