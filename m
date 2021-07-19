Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42A93CEDD1
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jul 2021 22:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344259AbhGSTsx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jul 2021 15:48:53 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:55826 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351993AbhGSRtG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Jul 2021 13:49:06 -0400
Received: by mail-pj1-f43.google.com with SMTP id gx2so888462pjb.5
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jul 2021 11:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QYfs8NrQLPQvYULk/aLJREvBoW3wpUFTzJ06+vuqAd8=;
        b=sAcX8g/8SFF1rnFX679Fa2HrGgqVz+r2qh/qFIS/gdNOR1flWb2oUDFPjd1XU9yc9b
         EGVFIjcs8WNPsbYB/aUs8HBbS+tsVT00aFa6QScN0QpuVvS4O6qkXf77guB7aNzCEx9d
         xSXEWW4CBMyrM/qkweypPa1bBsjZw2Uyvnne2R3vbdFLv4rIMFPZtBBv7EvzmPicdEqo
         KuQBmUKdAFuon/hoyHMtFAoaiWG8w0RRAujb/0fuMqVOH58wAPU3dsh3sUPz8tYm/HCX
         bAu6i4qU1z6DRhUyBQAhyViakMkDTfpCsnVZ1u2Z3O93I0Zrmtepr1FbL1qDhc98Vfi+
         IkCQ==
X-Gm-Message-State: AOAM531sfEqJeeCz2G6r0HHyDV69n87OeJXeIZCWgtykVKqfqBeX8Eo7
        yKTx+iM7M5IsMoMURQmEDCg=
X-Google-Smtp-Source: ABdhPJxlZZ73WDJDFqbMpgVYL+Mu6oUgS1/NSaLt+3Q/UpbfAc9TVdkbG2ty3Fm94B9OwO8kXtORiQ==
X-Received: by 2002:a17:903:32cf:b029:12b:8b8b:3a5 with SMTP id i15-20020a17090332cfb029012b8b8b03a5mr5405056plr.48.1626719381807;
        Mon, 19 Jul 2021 11:29:41 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2ce3:950:ff23:e549? ([2601:647:4802:9070:2ce3:950:ff23:e549])
        by smtp.gmail.com with ESMTPSA id n33sm22792936pgm.55.2021.07.19.11.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 11:29:41 -0700 (PDT)
Subject: Re: [PATCH 1/1] iser-target: Fix handling of
 RDMA_CV_EVENT_ADDR_CHANGE
To:     Chesnokov Gleb <Chesnokov.G@raidix.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "lanevdenoche@gmail.com" <lanevdenoche@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
References: <20210714182646.112181-1-Chesnokov.G@raidix.com>
 <20210719121302.GA1048368@nvidia.com>
 <2ea098b2bbfc4f5c9e9b590804e0dcb5@raidix.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0e6e8da9-5d14-92ef-39d9-99d7a0792f62@grimberg.me>
Date:   Mon, 19 Jul 2021 11:29:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2ea098b2bbfc4f5c9e9b590804e0dcb5@raidix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> What is this trying to do anyhow? If the addr has truely changed why
>> does the bind fail?
> 
> When the active physical link member of bonding interface in active-standby
> mode gets faulty, the standby link will represent the assigned addresses on
> behalf of the active link.
> Therefore, RDMA communication manager will notify iSER target with
> RDMA_CM_EVENT_ADDR_CHANGE.

Ah, here is my recollection...

However I think that if we move that into a work, we should do it
periodically until we succeed or until the endpoint is torn down so
we can handle address removed and restore use-cases.

See nvmet-rdma for an example of what I'm talking about.
