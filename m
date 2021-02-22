Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F91321CE8
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 17:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhBVQ1R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 11:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhBVQ06 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Feb 2021 11:26:58 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E275C061574;
        Mon, 22 Feb 2021 08:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=4G2c4gsQQ/sKBEI06UU7bCq4rbHSCsZ03J36bIQz7jQ=; b=KRWO+b9m+GnGORV3rM6t+dTy0u
        CUm/7wmx7aN9QrWQT8eTM7AK+D6YeHn0rlXg5Aec7xpHBCCaeMYVV1iy09W0BnGgxbKvdnvasNDh8
        0LJ4yXdAntPwF38jORzz3JHDarZDnHBQuC5/liVyiRs2X8ilBa13CT4hx9uiMoDBhuyWBXPdeO7Sk
        mvCICpxKz3yWHIBBMC8r2DKjolJqWoKhgMJSU1xUTraEbYhVKvcwyYratfSyJHif0vVutX+7MSbsN
        YXkj0l6hNrgGg2p0ttq/JDgi0baxivScBmUJi++aPmFocG9HR1dKRDAVcK0yktJHJuQh0nF1VX8Q3
        +s5EcckQ==;
Received: from [2601:1c0:6280:3f0::d05b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lEE2I-0002ZX-PP; Mon, 22 Feb 2021 16:26:15 +0000
Subject: Re: [PATCH] drivers: infiniband: sw: rxe: fix kconfig dependency on
 CRYPTO
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Julian Braha <julianbraha@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <21525878.NYvzQUHefP@ubuntu-mate-laptop> <YDICM3SwwGZfE+Sg@unreal>
 <CAD=hENeCXGtKrXxLof=DEZjxpKyYBFS80pAX20nnJBuP_s-GBA@mail.gmail.com>
 <YDOq060TvAwLgknl@unreal> <20210222155845.GI2643399@ziepe.ca>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e1e3bec7-0350-4bdd-50c3-41b21388fc71@infradead.org>
Date:   Mon, 22 Feb 2021 08:26:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210222155845.GI2643399@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/22/21 7:58 AM, Jason Gunthorpe wrote:
> On Mon, Feb 22, 2021 at 03:00:03PM +0200, Leon Romanovsky wrote:
>> On Mon, Feb 22, 2021 at 10:39:20AM +0800, Zhu Yanjun wrote:
>>> On Sun, Feb 21, 2021 at 2:49 PM Leon Romanovsky <leon@kernel.org> wrote:
>>>>
>>>> On Fri, Feb 19, 2021 at 06:32:26PM -0500, Julian Braha wrote:
>>>>> commit 6e61907779ba99af785f5b2397a84077c289888a
>>>>> Author: Julian Braha <julianbraha@gmail.com>
>>>>> Date:   Fri Feb 19 18:20:57 2021 -0500
>>>>>
>>>>>     drivers: infiniband: sw: rxe: fix kconfig dependency on CRYPTO
>>>>>
>>>>>     When RDMA_RXE is enabled and CRYPTO is disabled,
>>>>>     Kbuild gives the following warning:
>>>>>
>>>>>     WARNING: unmet direct dependencies detected for CRYPTO_CRC32
>>>>>       Depends on [n]: CRYPTO [=n]
>>>>>       Selected by [y]:
>>>>>       - RDMA_RXE [=y] && (INFINIBAND_USER_ACCESS [=y] || !INFINIBAND_USER_ACCESS [=y]) && INET [=y] && PCI [=y] && INFINIBAND [=y] && INFINIBAND_VIRT_DMA [=y]
>>>>>
>>>>>     This is because RDMA_RXE selects CRYPTO_CRC32,
>>>>>     without depending on or selecting CRYPTO, despite that config option
>>>>>     being subordinate to CRYPTO.
>>>>>
>>>>>     Signed-off-by: Julian Braha <julianbraha@gmail.com>
>>>>
>>>> Please use git sent-email to send patches and please fix crypto Kconfig
>>>> to enable CRYPTO if CRYPTO_* selected.
>>>>
>>>> It is a little bit awkward to request all users of CRYPTO_* to request
>>>> select CRYPTO too.
>>>
>>> The same issue and similar patch is in this link:
>>>
>>> https://patchwork.kernel.org/project/linux-rdma/patch/20200915101559.33292-1-fazilyildiran@gmail.com/#23615747
>>
>> So what prevents us from fixing CRYPTO Kconfig?
> 
> Yes, I would like to see someone deal with this properly, either every
> place doing select CRYPTO_XX needs fixing or something needs to be
> done in the crypto layer.
> 
> I have no idea about kconfig to give advice, I've added Arnd since he
> always seems to know :)

I will Ack the original patch in this thread.

How many Mellanox drivers are you concerned about?
You don't have to fix any other drivers that have a similar issue.


-- 
~Randy
