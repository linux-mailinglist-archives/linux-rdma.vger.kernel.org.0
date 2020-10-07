Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C394286B99
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 01:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgJGXug (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Oct 2020 19:50:36 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:35153 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgJGXug (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Oct 2020 19:50:36 -0400
Received: by mail-wr1-f42.google.com with SMTP id n15so4312630wrq.2
        for <linux-rdma@vger.kernel.org>; Wed, 07 Oct 2020 16:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YzONL2Hb1OMpCFtgMmM5avS4gAVg4nzeCc187wyrH+I=;
        b=g15BiiwC2WpIFmwayW5/F6gvkbRZENjbhqxAXRP1Jbj9eVLxf0DMHm78FLxweqUlqR
         9Tw/IBe5oX/14aq4nRGa21hyD/WH5wn8++4kd6u3rcSDY9cd+zRQ5IcJeAxvS3d5R07P
         B/Y37JOL5ZY5+DIz1AOhGCIdTTNbEwd20Aci6CSZ0tb4pnnhfpRr6AtweSXN1PVG2ikl
         niaLeVzzrfCsDoHgBknI6bYROQi+HYxwwRM75R2moidX+3pXhSx3tpoKj0WYvcY0LmIy
         e4xKLDdpNNr3daF0qDiMc6gfC+GbtagxGFjjbVr/QU0C+cnGRetYBVKVNGPB0s2qAsVJ
         hFCA==
X-Gm-Message-State: AOAM532MRu86BHf4lHWajyhh6R3cs8aiCzOqTYopEjDwoT0aYYqBGs/7
        ftWGq5eKLWePtic9qrdlPCs=
X-Google-Smtp-Source: ABdhPJwR5UWRSvia4CYBTWzvFA7vtOATWUZTLDKKiUueU9OqKsWaV2ZfL+oQJ+Rccx0dVb+CFW3shw==
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr3815759wrt.314.1602114632853;
        Wed, 07 Oct 2020 16:50:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:a6e2:a053:3c10:8bbd? ([2601:647:4802:9070:a6e2:a053:3c10:8bbd])
        by smtp.gmail.com with ESMTPSA id p21sm4524960wmc.28.2020.10.07.16.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 16:50:32 -0700 (PDT)
Subject: Re: reduce iSERT Max IO size
To:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Krishnamraju Eraparaju <krishna2@chelsio.com>
Cc:     linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Max Gurtovoy <maxg@mellanox.com>
References: <20200922104424.GA18887@chelsio.com>
 <07e53835-8389-3e07-6976-505edbd94f2a@grimberg.me>
 <20201002171007.GA16636@chelsio.com>
 <4d0b1a3f-2980-c7ed-ef9a-0ed6a9c87a69@grimberg.me>
 <20201003033644.GA19516@chelsio.com>
 <4391e240-5d6d-fb59-e6fb-e7818d1d0bd2@nvidia.com>
 <20201007033619.GA11425@chelsio.com>
 <1a034761-3723-3c70-8a44-25ef2cbf786e@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <fe4ff8ac-fd0a-ed6f-312b-51be9a9fdcc6@grimberg.me>
Date:   Wed, 7 Oct 2020 16:50:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1a034761-3723-3c70-8a44-25ef2cbf786e@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> I think max IO size, at iSER initiator, depends on
>> "max_fast_reg_page_list_len".
>> currently, below are the supported "max_fast_reg_page_list_len" of
>> various iwarp drivers:
>>
>> iw_cxgb4: 128 pages
>> Softiwarp: 256 pages
>> i40iw: 512 pages
>> qedr: couldn't find.
>>
>> For iwarp case, if 512 is the max pages supported by all iwarp drivers,
>> then provisioning a gigantic MR pool at target(to accommodate never used
>> 16MiB IO) wouldn't be a overkill?
> 
> For RoCE/IB Mellanox HCAs we support 16MiB IO size and even more. We 
> limited to 16MiB in iSER/iSERT.
> 
> Sagi,
> 
> what about adding a module parameter for this as we did in iSER initiator ?

I don't think we have any other choice...
