Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EF53EF4EF
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Aug 2021 23:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbhHQV1j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Aug 2021 17:27:39 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:42874 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhHQV1i (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Aug 2021 17:27:38 -0400
Received: by mail-qk1-f180.google.com with SMTP id bj38so469649qkb.9
        for <linux-rdma@vger.kernel.org>; Tue, 17 Aug 2021 14:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fDeemvJDl0j2+r4T6slCsA26e0VrMkPz1Vz7RSI7Ysw=;
        b=DTvjgDWOgCHRTbUh+WKEWFN9lVOgzO5zknjaK7CM59/oBPotYXsUivfqScj1SZGvEE
         IUxUiK8u545x9t3Agq4ZM4yDkJmEXCvX/72CidqokynS0bkeZF1+P+35ZdfzddKsOUYG
         CfKv0VNGNUKDXNCiqh0WYn2jIlBuU9ruPnhdYfEW8OyTgjA/IsYYgN6K8WzImObnscuy
         uSNJNRWioHVtJE9uTDme4MMcYubPAH/bGD2lzPn+vyuUx/+iuMglBM33M3SG0XnxQJZs
         MJ61G0Ra5KqBQ9JSOpSThOs5Bp1ZPD3TUg9fBxk7ITtBUqIgOvEZgOfeqxEajMU0TjEg
         mz+A==
X-Gm-Message-State: AOAM533mG+hRkQxtdXCdpSczIa+5C/kcpXbGDG15nynFv1wLV4wXLesx
        mkuSjPzZzM//gUiZCwmX0Bc=
X-Google-Smtp-Source: ABdhPJztNtumvPMokLpykZlPRCX8iWuMyzcWuCUkjM2hki6j1UjKvNEDFJuv4SqyQTY2LVwlaWZZKg==
X-Received: by 2002:a05:620a:1790:: with SMTP id ay16mr6026814qkb.67.1629235624510;
        Tue, 17 Aug 2021 14:27:04 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:6c86:2864:dd78:e408? ([2600:1700:65a0:78e0:6c86:2864:dd78:e408])
        by smtp.gmail.com with ESMTPSA id m8sm2209216qkk.130.2021.08.17.14.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 14:27:03 -0700 (PDT)
Subject: Re: [PATCH 1/1] iser-target: Fix handling of
 RDMA_CV_EVENT_ADDR_CHANGE
To:     Chesnokov Gleb <Chesnokov.G@digdes.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     "lanevdenoche@gmail.com" <lanevdenoche@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
References: <20210714182646.112181-1-Chesnokov.G@raidix.com>
 <20210719121302.GA1048368@nvidia.com>
 <2ea098b2bbfc4f5c9e9b590804e0dcb5@raidix.com>
 <0e6e8da9-5d14-92ef-39d9-99d7a0792f62@grimberg.me>
 <20210722142346.GL1117491@nvidia.com>
 <d7cba69f-42f1-c86e-8c01-9ddba87332e8@grimberg.me>
 <20210727173709.GH1721383@nvidia.com>
 <4e31b660-822a-5bc9-26e3-76046049695a@grimberg.me>
 <57cdb944fa6e445c97692328fb2435c0@digdes.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b5b8b842-897d-5cad-1f32-a212c9e91737@grimberg.me>
Date:   Tue, 17 Aug 2021 14:27:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <57cdb944fa6e445c97692328fb2435c0@digdes.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>> AFAIK the existing listening ID remains, the notification is
>>> informative, it doesn't indicate any CM state has changed.
>>
>> Gleb, can you confirm that?
> 
> In my case, when 2 physical interfaces are bonded and the cable is pulled out for one of them,
> the RDMA_CM_EVENT_ADDR_CHANGE event is processed 2 times.
> 
> 1 for condition isert_np->cm_id == cma_id
>          isert_np_cma_handler() is called
>          The old cma_id is destroyed and a new one is created
> 2 for condition isert_np->cm_id != cma_id
>          isert_disconnected_handler() is called
> 
> As I understand it in this case, RDMA_CM_EVENT_ADDR_CHANGE is not just an informative event.
> It is needed to recreate the isert connection (struct isert_conn) for the standby path.
> I may be wrong, but the creation of a 'struct isert_conn' is initiated in isert_rdma_accept(),
> that is, when the cma_id is created.
> 
> Therefore, it seems to me that you need to recreate cma_id,
> otherwise who will recreate isert_conn?

There are two handlers in question here, the listener cm_id and
the connection cm_id. The connection cma_id should definitely trigger
disconnect and resource cleanup. The question is should the listener
cma_id (which maps to the isert network portal - np) recreate the
cma_id in this event.
