Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4B964A81A
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Dec 2022 20:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiLLT2M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Dec 2022 14:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiLLT2L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Dec 2022 14:28:11 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D62D6362;
        Mon, 12 Dec 2022 11:28:10 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id jr11so9266592qtb.7;
        Mon, 12 Dec 2022 11:28:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rL/zxiDSTuN1ebusTkQoLeQODNwEIHUlNJemxq0MbU4=;
        b=JAG94mcDrpnBRMKpD1hZVhrQlGpEumen9rm08W8SLsvJPid8WhzPaXq7Y0D1x835fm
         AtDkeCEGCvzX/acCYVkniM7zzpbnNZ54JIlYX+SBqM9B1ALRIVUk4StcfyPokVdfobqU
         RsF77P2mNIdnXdc+28R16SN6eb//UCbUVNmDuaNjMuXHRTo8wTEbXGcfyelpSqSpY4Qe
         eSBIdxn5Km5GwHMPzQ+LFQOtiaQkoDIM6vYsqh2lTJEaRJl81ZVt3DZkX+ZD2goFztsf
         VN17Ody/h1PPwsn7sVY9rKdGp2350cimr5pG8wgfbbBtm6RYRm66DJRTsSWXbr0IWnRk
         8WDw==
X-Gm-Message-State: ANoB5pl55ptVGgjo6PRLvW3IAeKjdoO2hGliOM0W5VTCtTEORrVSKkcX
        X0H8ed4+a4/ko/p3BLv9gHYv2bN/uMY=
X-Google-Smtp-Source: AA0mqf7cdwitdPLOliQ+9/IP6kcBzwKhdQIFHC35ohpITOJD6QFU3qFE4Eff3VFb9ZTbiRQQgAP+LA==
X-Received: by 2002:a05:622a:5a99:b0:3a7:e788:dca7 with SMTP id fz25-20020a05622a5a9900b003a7e788dca7mr27277310qtb.39.1670873289713;
        Mon, 12 Dec 2022 11:28:09 -0800 (PST)
Received: from [172.22.37.189] (rrcs-76-81-102-5.west.biz.rr.com. [76.81.102.5])
        by smtp.gmail.com with ESMTPSA id o15-20020a05620a2a0f00b006fafc111b12sm6516731qkp.83.2022.12.12.11.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 11:28:09 -0800 (PST)
Message-ID: <e5dfd705-4d46-f965-6772-4de51798d2ca@acm.org>
Date:   Mon, 12 Dec 2022 11:28:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] RDMA/srp (gcc13): move large values to a new enum
Content-Language: en-US
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Martin Liska <mliska@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
References: <20221212120411.13750-1-jirislaby@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221212120411.13750-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/12/22 04:04, Jiri Slaby (SUSE) wrote:
> Since gcc13, each member of an enum has the same type as the enum [1]. And
> that is inherited from its members. Provided these two:
>    SRP_TAG_NO_REQ        = ~0U,
>    SRP_TAG_TSK_MGMT	= 1U << 31
> all other members are unsigned ints.
> 
> Esp. with SRP_MAX_SGE and SRP_TSK_MGMT_SQ_SIZE and their use in min(),
> this results in the following warnings:
>    include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast
>    drivers/infiniband/ulp/srp/ib_srp.c:563:42: note: in expansion of macro 'min'
> 
>    include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast
>    drivers/infiniband/ulp/srp/ib_srp.c:2369:27: note: in expansion of macro 'min'
> 
> So move the large values away to a separate enum, so that they don't
> affect other members.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

