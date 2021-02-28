Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085F23271E1
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Feb 2021 11:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhB1KZn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Feb 2021 05:25:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230019AbhB1KZn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 28 Feb 2021 05:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614507856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LtsioDL5PngNkqPShYW897q7nvUwVlLfsXw3GYzXE38=;
        b=HuV75nBjdFfbc4bFdXWrRt6EAbW0REc5sSPnWZ/aobMjIuat8rpa3RLvjru3T+rvTBG7S2
        5NWdHEZrJVxw0yb0DfdtNx317eg/55vfTAbUxhi1EbSELSTaxURM5hg2C2VrgUsFE2bxUD
        7/eZTd/lBIJkLPbiJ62aUeIaGt1W4DQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-okBHKN96NySzismYhseCoQ-1; Sun, 28 Feb 2021 05:24:14 -0500
X-MC-Unique: okBHKN96NySzismYhseCoQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C4B78030BB;
        Sun, 28 Feb 2021 10:24:13 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-126.pek2.redhat.com [10.72.12.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E92960C9B;
        Sun, 28 Feb 2021 10:24:11 +0000 (UTC)
Subject: Re: modprobe rdma_rxe failed when ipv6 disabled
To:     Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
References: <1688338252.14107275.1614354083739.JavaMail.zimbra@redhat.com>
 <1010828157.14107334.1614354448762.JavaMail.zimbra@redhat.com>
 <CAD=hENfyNMc-wQL5JAX+T3GGaj75mMy8JTpuUrpuqOPY0Gcgfw@mail.gmail.com>
 <b153b7e2-e62b-1289-3566-c1184e224ed8@redhat.com>
 <CAD=hENeotEgBxi7WFmUVg8asxPduJaVc3UR+YSV3DxdX5v0=2w@mail.gmail.com>
 <YDthKWQa9+2BhvHd@unreal>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <880d7b59-4b17-a44f-1a91-88257bfc3aaa@redhat.com>
Date:   Sun, 28 Feb 2021 18:24:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YDthKWQa9+2BhvHd@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Tested-by: Yi Zhang <yi.zhang@redhat.com>

# modprobe rdma_rxe
# dmesg
[  598.134022] rdma_rxe: IPv6 is disabled by ipv6.disable=1 in cmdline
[  598.134026] rdma_rxe: loaded




On 2/28/21 5:23 PM, Leon Romanovsky wrote:
> On Sat, Feb 27, 2021 at 11:32:35PM +0800, Zhu Yanjun wrote:
>>  From 9dcdd09f3ca3cf222b563866acd91d18bc4b93d4 Mon Sep 17 00:00:00 2001
>> From: Zhu Yanjun <zyjzyj2000@gmail.com>
>> Date: Sat, 27 Feb 2021 23:01:15 +0000
>> Subject: [PATCH 1/1] RDMA/rxe: Disable ipv6 features when ipv6.disable set in
>>   cmdline
>>
>> When ipv6.disable=1 is set in cmdline, ipv6 is actually disabled
>> in the stack. As such, the operations of ipv6 in RXE will fail.
>> So ipv6 features in RXE should also be disabled in RXE.
>>
>> Reported-by: Yi Zhang <yi.zhang@redhat.com>
>> Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_net.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c
>> b/drivers/infiniband/sw/rxe/rxe_net.c
>> index 0701bd1ffd1a..6ef092cb575e 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
>> @@ -72,6 +72,11 @@ static struct dst_entry *rxe_find_route6(struct
>> net_device *ndev,
>>          struct dst_entry *ndst;
>>          struct flowi6 fl6 = { { 0 } };
>>
>> +       if (!ipv6_mod_enabled()) {
>> +               pr_info("IPv6 is disabled by ipv6.disable=1 in cmdline");
>> +               return NULL;
>> +       }
>> +
>
> Except the info message, the change looks valid.
>
> pr_info("IPv6 is disabled by ipv6.disable=1 in cmdline");
> ->
> pr_info("IPv6 is disabled");
>
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
>

