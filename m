Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADCA28F1EF
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Oct 2020 14:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgJOMVk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Oct 2020 08:21:40 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12621 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgJOMVk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Oct 2020 08:21:40 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f883ea80001>; Thu, 15 Oct 2020 05:20:56 -0700
Received: from [172.27.15.143] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 15 Oct
 2020 12:21:38 +0000
Subject: Re: dynamic-sg patch has broken rdma_rxe
To:     Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Bob Pearson" <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
CC:     <linux-rdma@vger.kernel.org>
References: <0fdfc60e-ea93-8cf2-b23a-ce5d07d5fe33@gmail.com>
 <20201014225125.GC5316@nvidia.com>
 <e2763434-2f4f-9971-ae9d-62bab62b2e93@nvidia.com>
 <63997d02-827c-5a0d-c6a1-427cbeb4ef27@amazon.com>
From:   Maor Gottlieb <maorg@nvidia.com>
Message-ID: <8cf4796d-4dcb-ef5a-83ac-e11134eac99b@nvidia.com>
Date:   Thu, 15 Oct 2020 15:21:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <63997d02-827c-5a0d-c6a1-427cbeb4ef27@amazon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602764456; bh=NWtxuGAKngdyRoJu8S7DezWrowK2Ke5gpzFALApQ+tw=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=ku90oI65JoGs0wMRnu5f+8wFKb3ZKL5hgdLnhzpC3+F/3l80biTqW19aKM+2igVhP
         IQ6YsEs9ve6wB3Q8PPBkSNOXouME2m2kJrzJLYv/6v+kloo+RBgH3yLng6Q+AiSs+n
         kxyxCx0EwWJbjnqv1pXr65mN3QEnrqaLVZ7h55tsCkbEIahiBb8YxNMgo4Hx405o4L
         XCgzolWs+jvmk8uFlitl/EInJl+dw5dgGgx7QjMhKwbBWZlV2Ku2d09E3lWn8hbDlY
         4xH+wcyVeq5ZHWfGTlF81awKQo3Pa3FxQiJsjW7xzw2rnyapwcr0ZNdOYFsWzSiM31
         wLM8CmTrPAALQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 10/15/2020 2:23 PM, Gal Pressman wrote:
> On 15/10/2020 10:44, Maor Gottlieb wrote:
>> On 10/15/2020 1:51 AM, Jason Gunthorpe wrote:
>>> On Tue, Oct 13, 2020 at 09:33:14AM -0500, Bob Pearson wrote:
>>>> Jason,
>>>>
>>>> Just pulled for-next and now hit the following warning.
>>>> Register user space memory is not longer working.
>>>> I am trying to debug this but if you have any idea where to look let m=
e know.
>>> The offset_in_page is wrong, but it is protecting some other logic..
>>>
>>> Maor? Leon? Can you sort it out tomorrow?
>> Leon and I investigated it. This check existed before my series to prote=
ct the
>> alloc_table_from_pages logic. It's still relevant.
>> This patch that broke it:=C2=A0 54816d3e69d1 ("RDMA: Explicitly pass in =
the
>> dma_device to ib_register_device"), and according to below link it was
>> expected.=C2=A0 The safest approach is to set the max_segment_size back =
the 2GB in
>> all drivers. What do you think?
>>
>> https://lore.kernel.org/linux-rdma/20200923072111.GA31828@infradead.org/
> FWIW, EFA is broken as well (same call trace) so it's not just software d=
rivers.

This is true to all drivers that call to ib_umem_get and set UINT_MAX=C2=A0=
=20
as max_segment_size.
Jason,=C2=A0 maybe instead of set UINT_MAX as max_segment_size, need to set=
=20
SCATTERLIST_MAX_SEGMENT which does the required alignment.
