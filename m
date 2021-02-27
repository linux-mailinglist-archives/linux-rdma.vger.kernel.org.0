Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E2B326CA9
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Feb 2021 11:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhB0KUB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 27 Feb 2021 05:20:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32378 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229795AbhB0KT7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 27 Feb 2021 05:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614421113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f7ZGQ+L4M+ZuGVfccGA2q+le04R8t+a6DGGoswiaa0I=;
        b=f679BmwsFJW5WwzIGM/tmbzBra7OkIPbyQE4m+YOgAKTvjqNpoYDpIIs/PLUH/D569uIip
        xwu54Xmk/dVaajDP1IcQvY5Ujf2yWXEOW0MkPGIDfUwYARWQO/fntxiO1Kr4QI/G8/HeHv
        +em8cx5q1oItOSfy1Fm0UmYUK3Ishh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-N6Rk_3RzN3qGMceOYKEgow-1; Sat, 27 Feb 2021 05:18:30 -0500
X-MC-Unique: N6Rk_3RzN3qGMceOYKEgow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B5C9801965;
        Sat, 27 Feb 2021 10:18:29 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-90.pek2.redhat.com [10.72.12.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A429D18AAB;
        Sat, 27 Feb 2021 10:18:27 +0000 (UTC)
Subject: Re: modprobe rdma_rxe failed when ipv6 disabled
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
References: <1688338252.14107275.1614354083739.JavaMail.zimbra@redhat.com>
 <1010828157.14107334.1614354448762.JavaMail.zimbra@redhat.com>
 <CAD=hENfyNMc-wQL5JAX+T3GGaj75mMy8JTpuUrpuqOPY0Gcgfw@mail.gmail.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <b153b7e2-e62b-1289-3566-c1184e224ed8@redhat.com>
Date:   Sat, 27 Feb 2021 18:18:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAD=hENfyNMc-wQL5JAX+T3GGaj75mMy8JTpuUrpuqOPY0Gcgfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/27/21 5:05 PM, Zhu Yanjun wrote:
> On Fri, Feb 26, 2021 at 11:50 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>> Hello
>>
>> I found this failure after ipv6 disabled, is that expected?
>>
>> # modprobe rdma_rxe
>> modprobe: ERROR: could not insert 'rdma_rxe': Operation not permitted
>>
>> # dmesg
>> [  596.783484] rdma_rxe: failed to create udp socket. err = -97
>> [  596.789144] rdma_rxe: Failed to create IPv6 UDP tunnel
> ipv6 in RXE is based on config_ipv6. If config_ipv6 is disabled. rxe
> will not implement ipv6 features.
> How do you disable ipv6 in your hosts?
Sorry, I should give the detailed info, I disabled it by kernel parameter:
# cat /proc/cmdline  | grep -o ipv6.disable=1
ipv6.disable=1



> Zhu Yanjun
>
>> # uname -r
>> 5.11.0
>>
>>
>>
>> Best Regards,
>>    Yi Zhang
>>
>>

