Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6066E28EDDA
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Oct 2020 09:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgJOHou (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Oct 2020 03:44:50 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13962 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgJOHou (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Oct 2020 03:44:50 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f87fde50000>; Thu, 15 Oct 2020 00:44:37 -0700
Received: from [172.27.15.143] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 15 Oct
 2020 07:44:47 +0000
Subject: Re: dynamic-sg patch has broken rdma_rxe
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
CC:     <linux-rdma@vger.kernel.org>
References: <0fdfc60e-ea93-8cf2-b23a-ce5d07d5fe33@gmail.com>
 <20201014225125.GC5316@nvidia.com>
From:   Maor Gottlieb <maorg@nvidia.com>
Message-ID: <e2763434-2f4f-9971-ae9d-62bab62b2e93@nvidia.com>
Date:   Thu, 15 Oct 2020 10:44:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201014225125.GC5316@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602747877; bh=lJBTdhyan13G6oLRBx0QggRQdSjVxtGmGH42+g8MUT0=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=g+qhF496r3ZHM4glHB00cUX0bdTquMvHXWmUox4Ltww9bEsQWxP6vqUMuPpmlQGOW
         6DkOLTWVY1vVT3Ih+YA5651k4T4KqTLpuL/O0LsjarOPvAYEiWvOfY0FAxLubGvQuJ
         h/Etvp/E1WRvpzabDI/17fnYouR61+XSWWoCnR4eTtfrNhmAAO1BzznGYiTb2kbjYd
         oxsDdlqbCnZydUVga3jNvklxmbis7WOxfzOSY/KXiOzmPbGo44elXqjfxSJysY9nz5
         n/9rMPvAmO3nPluz8Ydn6weJs/n53rBdVqAICyNK6aKiH7/2dxmB7aIFaAJz81vc16
         EOppqHKuIh6Qg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 10/15/2020 1:51 AM, Jason Gunthorpe wrote:
> On Tue, Oct 13, 2020 at 09:33:14AM -0500, Bob Pearson wrote:
>> Jason,
>>
>> Just pulled for-next and now hit the following warning.
>> Register user space memory is not longer working.
>> I am trying to debug this but if you have any idea where to look let me =
know.
> The offset_in_page is wrong, but it is protecting some other logic..
>
> Maor? Leon? Can you sort it out tomorrow?

Leon and I investigated it. This check existed before my series to=20
protect the alloc_table_from_pages logic. It's still relevant.
This patch that broke it:=C2=A0 54816d3e69d1 ("RDMA: Explicitly pass in the=
=20
dma_device to ib_register_device"), and according to below link it was=20
expected.=C2=A0 The safest approach is to set the max_segment_size back the=
=20
2GB in all drivers. What do you think?

https://lore.kernel.org/linux-rdma/20200923072111.GA31828@infradead.org/

>
> Jason
