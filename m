Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809843E3032
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Aug 2021 22:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244808AbhHFUOz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Aug 2021 16:14:55 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:34389 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbhHFUOy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Aug 2021 16:14:54 -0400
Received: by mail-pl1-f172.google.com with SMTP id d1so8586484pll.1
        for <linux-rdma@vger.kernel.org>; Fri, 06 Aug 2021 13:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GoG55jQi/C26u5QEIKQItZSIGyeznnS0GuT1kAx5EiM=;
        b=mye9ImJKygFGw0oQcBbaOQPHUXSsnR17d2A+oi5pzI6eMxfhKAU3DO7ZKhRHlOVDxA
         y+egy9fWtzZVwlgqlAtM7VKbHMYUDhG7mTBPWtZYEcLzKHgqXZsn0bLePtASgovr2bnr
         OBKH81sBIWT9uaq0lJof6qE4IeVTjBbtrrP0iPn17I4IhkFbHdgFQbLWcpfAjnRWiUx1
         rwOuOyAGPIAsDxiPCnQRqWw89A0Q78gwWwejXgKK1g7neLVDaRuDdMecwEl8wO1bzhbt
         ay63oqldalsCC9k4AvMJZaXFihVSH0ViO2NaWRuTvwxc7HkTg1U9hRQgpaFiVUvjvpzu
         BGnw==
X-Gm-Message-State: AOAM533HEITrqElkfyb/Uy/9YpP40ocbYph2cjp60/gjvv8AXUd7w6+V
        kcc+gIuxnK9kaIOdv4DKS3g=
X-Google-Smtp-Source: ABdhPJxe9dccVLHuNgy2II/HuyOkkBwl7euIvplSsbTH9VBPrlsGSAI76Y84LN2oqsIjqHsOtPm73Q==
X-Received: by 2002:a17:902:aa89:b029:12c:17dc:43b0 with SMTP id d9-20020a170902aa89b029012c17dc43b0mr10071838plr.81.1628280877771;
        Fri, 06 Aug 2021 13:14:37 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4a77:cdda:c1bf:a6b7? ([2601:647:4802:9070:4a77:cdda:c1bf:a6b7])
        by smtp.gmail.com with ESMTPSA id x19sm13600361pgk.37.2021.08.06.13.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 13:14:37 -0700 (PDT)
Subject: Re: [PATCH 1/1] iser-target: Fix handling of
 RDMA_CV_EVENT_ADDR_CHANGE
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Chesnokov Gleb <Chesnokov.G@raidix.com>,
        "lanevdenoche@gmail.com" <lanevdenoche@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
References: <20210714182646.112181-1-Chesnokov.G@raidix.com>
 <20210719121302.GA1048368@nvidia.com>
 <2ea098b2bbfc4f5c9e9b590804e0dcb5@raidix.com>
 <0e6e8da9-5d14-92ef-39d9-99d7a0792f62@grimberg.me>
 <20210722142346.GL1117491@nvidia.com>
 <d7cba69f-42f1-c86e-8c01-9ddba87332e8@grimberg.me>
 <20210727173709.GH1721383@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4e31b660-822a-5bc9-26e3-76046049695a@grimberg.me>
Date:   Fri, 6 Aug 2021 13:14:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727173709.GH1721383@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>>>>> What is this trying to do anyhow? If the addr has truely changed why
>>>>>> does the bind fail?
>>>>>
>>>>> When the active physical link member of bonding interface in active-standby
>>>>> mode gets faulty, the standby link will represent the assigned addresses on
>>>>> behalf of the active link.
>>>>> Therefore, RDMA communication manager will notify iSER target with
>>>>> RDMA_CM_EVENT_ADDR_CHANGE.
>>>>
>>>> Ah, here is my recollection...
>>>>
>>>> However I think that if we move that into a work, we should do it
>>>> periodically until we succeed or until the endpoint is torn down so
>>>> we can handle address removed and restore use-cases.
>>>
>>> That soudns better, but still I would say this shouldn't even happen
>>> in the first place, check the address and don't initiate rebinding if
>>> it hasn't changed.
>>
>> But don't you need to setup a new cm_id for the this notification? It
>> will remain active?
> 
> AFAIK the existing listening ID remains, the notification is
> informative, it doesn't indicate any CM state has changed.

Gleb, can you confirm that?

>> Also it's a bit cumbersome to match addresses in some cases like multi
>> address interfaces. Almost seems easier to setup a new one...
> 
> How so? There is only one address passed to bind. If you create
> multiple CM ids to cover all addresses then you need to run a set
> algorithm to figure out what cm_ids to destroy and which to
> create.

There is one address passed to bind, but I need to check that this
address belongs to the interface, which is what bind does anyways..
