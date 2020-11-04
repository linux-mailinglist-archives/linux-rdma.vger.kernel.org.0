Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328532A6C15
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 18:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbgKDRqZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 12:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732054AbgKDRqZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Nov 2020 12:46:25 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4BEC0613D3
        for <linux-rdma@vger.kernel.org>; Wed,  4 Nov 2020 09:46:24 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id x1so22983924oic.13
        for <linux-rdma@vger.kernel.org>; Wed, 04 Nov 2020 09:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LXJMnx/HfGlvQ8IjP7zzgPkGeqPjANlOZV5Qcof0/t8=;
        b=l6qt/2hK4h/owVW5S+KLQlYRmLtODI+K8m8T0Qau++N5dKDUh527OCKxliZmnr//XC
         b2I/5t5Po9L3EDXXz5YieyJt53J8c9gaa2+RO1duEa41r4O6egSJrPJZZrWuDOBaY4yh
         5CC5X09niu863O9Pxf1ha4pbhUsuNkLrYMmLWTaHeseBN4O4ZmNeYW3wTUiImU/cnObd
         1wQPll8ao3nBhBAx4l3pzzuGkMvsJzeV4ng+sVQ7xyds4Hke8bK6muEHlqHk53nrc8lY
         MjUonk8xoRMpl+dqAtLTDlKabGwmfORyKDuDEllZkZmx/ooh0SlXbphVwiYxZaCUi7XP
         NFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LXJMnx/HfGlvQ8IjP7zzgPkGeqPjANlOZV5Qcof0/t8=;
        b=md7aIcNQnFH4Mtz+a9D5tN1Sa8dGN8Pg0QJwt9Khj0cufryRdH5xQmfIC8Z80Zamrm
         TebkHoj5qjmsgy45tvGCRNlOHuI6N4weSCFJ04D6ttEMA+/PdtNb5XPOaCRNkRSKmkeh
         iPVK0eG5tDTXOFEZXD97OOKE21Mi5cfhIcSR00TqltAevbwrOPreo6tjFKC7FkPh4HTZ
         m+6x+O4GGqqbVTlWGd6ZqZMToVwjQj9g36DvFa0Jx7kD3NL0ZJvv5kzBH7nuLXaqPSFT
         7IuUj5QaQrHrk19tsQ8WVNsdtuIJISw5nKmlA/KMcFZbY00KDeZCBemN9zEQZADY1Les
         AXzg==
X-Gm-Message-State: AOAM533QJgEaKS8Am7ugy3baQz/VxHncnM7erOhCF2mxIMQo0XbMbgfQ
        e9QCSBjshnRgsTOBSG6hOjKbAkuCJ+0=
X-Google-Smtp-Source: ABdhPJzt/a1QfV79yS8gYKwX73jwK5Qf9KhDw83Nk3MB8MR5llvIZ88xXCwrfkTifMDXq9R2hmuBRw==
X-Received: by 2002:a05:6808:b35:: with SMTP id t21mr3119409oij.102.1604511984022;
        Wed, 04 Nov 2020 09:46:24 -0800 (PST)
Received: from ?IPv6:2603:8081:140c:1a00:1c77:3258:9ca4:99ae? (2603-8081-140c-1a00-1c77-3258-9ca4-99ae.res6.spectrum.com. [2603:8081:140c:1a00:1c77:3258:9ca4:99ae])
        by smtp.gmail.com with ESMTPSA id 62sm628153otj.37.2020.11.04.09.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 09:46:23 -0800 (PST)
Subject: Re: pyverbs test regression
To:     Gal Pressman <galpress@amazon.com>,
        Edward Srouji <edwards@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <f8de77b3-d9c7-5b0f-c118-c95f0c6a271c@gmail.com>
 <20201104000020.GU2620339@nvidia.com>
 <5a02bf4d-c864-124a-38ea-0911686737ea@nvidia.com>
 <2e391227-83a7-8999-8024-25e28c114d93@amazon.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <9df1dbb6-f190-3f72-1ee3-f0798c911734@gmail.com>
Date:   Wed, 4 Nov 2020 11:46:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <2e391227-83a7-8999-8024-25e28c114d93@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/4/20 5:47 AM, Gal Pressman wrote:
> On 04/11/2020 12:40, Edward Srouji wrote:
>> On 11/4/2020 2:00 AM, Jason Gunthorpe wrote:
>>> On Tue, Nov 03, 2020 at 05:54:58PM -0600, Bob Pearson wrote:
>>>> Since 5.10 some of the pyverbs tests are skipping with the warning
>>>>     "Device rxe_0 doesn't have net interface"
>>>>
>>>> These occur in tests/test_rdmacm.py. As far as I can tell the error occurs in
>>>>
>>>> RDMATestCase _add_gids_per_port after the following
>>>>
>>>>         if not
>>>> os.path.exists('/sys/class/infiniband/{}/device/net/'.format(dev)):
>>>>                  self.args.append([dev, port, idx, None])
>>>>                  continue
>>>>
>>>> In fact there is no such path which means it never finds an ip_addr for the
>>>> device.
>>> That isn't an acceptable way to find netdevs for a RDMA device..
>>>
>>> This test is really buggy, that is not an acceptable way to find the
>>> netdev for a RDMA device. Looks like it is some hacky way to read the
>>> gid table? It should just read the gid table.. Edward?
>>
>> GID table is not the reason. We need the netdev in order to get the IP address
>> of the interface.
>>
>> Do you have a better alternative suggestion to do that?
>>
>>>> Did something change here? Do other RDMA devices have
>>>> /sys/class/infiniband/XXX/device/net?
>>> Yes, some will
>>
>> Nothing really changed in this area lately (in pyverbs / rdma-core tests).
>>
>> RXE can also have a netdev here if it's linked to one. E.g. by doing "rdma link
>> add <rxe_devname> type rxe netdev <net_devname>"
> 
> Maybe it was changed in b27e504929d7 ("tests: Verify net interface support on
> RDMATestCase"), which made the tests skip if the path doesn't exist, instead of
> returning an error and failing the test.
> 
> How did these tests work for rxe before if the path doesn't exist?
> 

I wasn't really focused on this area so I only have a vague recollection that I wasn't
getting errors and I wasn't skipping these tests but I can't swear to it. From my point of
view there was clearly a netdev (enp6s0) with several IP addresses (one IPV4 and five IPV6).
