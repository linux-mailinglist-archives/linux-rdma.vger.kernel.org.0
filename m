Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 671177995D
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2019 22:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfG2UPC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jul 2019 16:15:02 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7438 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbfG2UPB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Jul 2019 16:15:01 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3f53bb0000>; Mon, 29 Jul 2019 13:14:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 29 Jul 2019 13:14:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 29 Jul 2019 13:14:59 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Jul
 2019 20:14:59 +0000
Subject: Re: [PATCH] rdma: siw: remove unused variable
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Anders Roxell <anders.roxell@linaro.org>, <bmt@zurich.ibm.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190726092540.22467-1-anders.roxell@linaro.org>
 <08d1942fa99465329348a1bbfd55823b590921c2.camel@redhat.com>
 <20190729190326.GG17990@ziepe.ca>
 <b5775622b2e8360e77f90dddfff9aa84af48240e.camel@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <f7500581-c3df-a0cb-8229-b832f12fcf05@nvidia.com>
Date:   Mon, 29 Jul 2019 13:14:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b5775622b2e8360e77f90dddfff9aa84af48240e.camel@redhat.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564431291; bh=4uhSuXtsJxEPWIma4eracBI9ZaEU9XbH/JW6QFfPO/0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=LqMSti86GIJ+cd/+7fUdQAPgfcFNX6ObqSp7MXDkUEgTSoUOs51kK8bKZ6Rr2p/mn
         +ZDODHoQpGGv6VvrIa4rXlneqMSKydDQGoS8IDqgHrqD/HoGAr1u8VQO825dMy84D6
         mKPswW11L7ZzIMCzvu/MwdTfSaqOOOGHwRmUct+oX0/tHUMvLygv9NJf1IXmgesofw
         RqFY3WT0BYoqXvs2V0liyJjNPVJ+TrpqmtaYnPvxjitFPBQnlb7iAmkD5NqYAIM0eH
         klCpNhdVcFo7TF29hPTCqSqV3BTJGeXqOSG2K4afrl5hJrPNWV4wHBx6bA0OKAhfNb
         NUVd2Pl6b4mOw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/29/19 12:45 PM, Doug Ledford wrote:
> On Mon, 2019-07-29 at 16:03 -0300, Jason Gunthorpe wrote:
>> On Mon, Jul 29, 2019 at 02:19:35PM -0400, Doug Ledford wrote:
>>> On Fri, 2019-07-26 at 11:25 +0200, Anders Roxell wrote:
>>>> The variable 'p' si no longer used and the compiler rightly
>>>> complains
>>>> that it should be removed.
>>>>
>>>> ../drivers/infiniband/sw/siw/siw_mem.c: In function
>>>> =E2=80=98siw_free_plist=E2=80=99:
>>>> ../drivers/infiniband/sw/siw/siw_mem.c:66:16: warning: unused
>>>> variable
>>>>  =E2=80=98p=E2=80=99 [-Wunused-variable]
>>>>   struct page **p =3D chunk->plist;
>>>>                 ^
>>>>
>>>> Rework to remove unused variable.
>>>>
>>>> Fixes: 8288d030447f ("mm/gup: add make_dirty arg to
>>>> put_user_pages_dirty_lock()")
>>>
>>> This commit hash and the commit subject does not exist in Linus'
>>> tree as
>>> of today.  What tree is this being merged through, and is it slated
>>> to
>>> merge soon or is this a for-next item?
>>
>> This is though -mm, maybe John knows what is what
>=20
> Hmmm...if it's through -mm, doesn't that mean that we can't rely on the
> hash because the next time Andrew's tree rebases (using quilt or
> whatever it is he does) that the hash will change?  It doesn't really
> matter too much...we can't take the fix anyway, it should probably be
> squashed into the patch that it's fixing, and if you follow Bernard's
> advice, you fix the problem by eliminating this function and changing
> the sole call site to just call put_user_pages_dirty_lock() directly.
>=20

Hi,

Although I don't know which tree has 8288d030447f, I did get a report
from linux-next last night with that report about the warning, and so
I believe that the patch flowed from Andrew's -mm tree (which has=20
speculatively added my patches), to linux-next

(+CC Andrew)

I also sent out a fix for it, as a reply-to the warning report:

    https://lore.kernel.org/r/20190729074306.10368-1-jhubbard@nvidia.com

Pasting in my response (minus the trivial fix), to save you a click:

"This fixes the warning. Ideally this should be merged with the commit
that it fixes, if that's still possible.

"Andrew, would you also like a fixed version of this patch posted
as a new version of the 3-patch set that it came with?"

thanks,
--=20
John Hubbard
NVIDIA
