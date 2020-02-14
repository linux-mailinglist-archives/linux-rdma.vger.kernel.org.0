Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D705615F70D
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2020 20:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgBNTob (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Feb 2020 14:44:31 -0500
Received: from mail.dlink.ru ([178.170.168.18]:42598 "EHLO fd.dlink.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729015AbgBNTob (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Feb 2020 14:44:31 -0500
Received: by fd.dlink.ru (Postfix, from userid 5000)
        id AD9CA1B20178; Fri, 14 Feb 2020 22:44:26 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru AD9CA1B20178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlink.ru; s=mail;
        t=1581709467; bh=ItqstqYtNHX+QVklGkmfTzbUQC2jTgbpnXa1roamK1k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=g2ZcmNHmYFpNVQ/ONcvDt4Qfib6JAbg3MfRZqfRWes7TUvI94q7lnBFPTPaT9hsSn
         yshMR9Kq/0yop0S7n99zZvDd+OWpyFzB7xWDIldt9lwhXJGEJjUb4f3WLqQcl1V1la
         HKBb0RFMHLT0spt4Uub1SJSVr6s1SYaCvknZqEHM=
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.dlink.ru
X-Spam-Level: 
X-Spam-Status: No, score=-99.2 required=7.5 tests=BAYES_50,URIBL_BLOCKED,
        USER_IN_WHITELIST autolearn=disabled version=3.4.2
Received: from mail.rzn.dlink.ru (mail.rzn.dlink.ru [178.170.168.13])
        by fd.dlink.ru (Postfix) with ESMTP id EA5671B201FA;
        Fri, 14 Feb 2020 22:44:17 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru EA5671B201FA
Received: from mail.rzn.dlink.ru (localhost [127.0.0.1])
        by mail.rzn.dlink.ru (Postfix) with ESMTP id C5F261B2267C;
        Fri, 14 Feb 2020 22:44:17 +0300 (MSK)
Received: from mail.rzn.dlink.ru (localhost [127.0.0.1])
        by mail.rzn.dlink.ru (Postfix) with ESMTPA;
        Fri, 14 Feb 2020 22:44:17 +0300 (MSK)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 14 Feb 2020 22:44:17 +0300
From:   Alexander Lobakin <alobakin@dlink.ru>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Maxim Mikityanskiy <maximmi@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma] IB/mlx5: Fix linkage failure on 32-bit arches
In-Reply-To: <20200214192410.GW31668@ziepe.ca>
References: <20200214191309.155654-1-alobakin@dlink.ru>
 <20200214192410.GW31668@ziepe.ca>
User-Agent: Roundcube Webmail/1.4.0
Message-ID: <6f7c270fef9ec5bae2dcb780dee3f49f@dlink.ru>
X-Sender: alobakin@dlink.ru
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Jason Gunthorpe wrote 14.02.2020 22:24:
> On Fri, Feb 14, 2020 at 10:13:09PM +0300, Alexander Lobakin wrote:
>> Commit f164be8c0366 ("IB/mlx5: Extend caps stage to handle VAR
>> capabilities") introduced a straight "/" division of the u64
>> variable "bar_size", which emits an __udivdi3() libgcc call on
>> 32-bit arches and certain GCC versions:
>> 
>> error: "__udivdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined! 
>> [1]
>> 
>> Replace it with the corresponding div_u64() call.
>> Compile-tested on ARCH=mips 32r2el_defconfig BOARDS=ocelot.
>> 
>> [1] 
>> https://lore.kernel.org/linux-mips/CAMuHMdXM9S1VkFMZ8eDAyZR6EE4WkJY215Lcn2qdOaPeadF+EQ@mail.gmail.com/
>> 
>> Fixes: f164be8c0366 ("IB/mlx5: Extend caps stage to handle VAR
>> capabilities")
>> Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
>> ---
>>  drivers/infiniband/hw/mlx5/main.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Randy beat you too it..
> 
> https://lore.kernel.org/linux-rdma/20200206143201.GF25297@ziepe.ca/

Ah, OK. Sorry for missing this one. I didn't see any fix over
git.kernel.org and thought it doesn't exist yet.

> But it seems patchwork missed this somehow.
> 
> Applied now at least

Thanks!

> Jason

Regards,
ᚷ ᛖ ᚢ ᚦ ᚠ ᚱ
