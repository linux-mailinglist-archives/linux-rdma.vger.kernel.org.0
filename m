Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F694A3AFD
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jan 2022 00:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356818AbiA3XXo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Jan 2022 18:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356872AbiA3XXn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 30 Jan 2022 18:23:43 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3153C061714
        for <linux-rdma@vger.kernel.org>; Sun, 30 Jan 2022 15:23:43 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id b17-20020a9d4791000000b005a17fc2dfc1so11418063otf.1
        for <linux-rdma@vger.kernel.org>; Sun, 30 Jan 2022 15:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hsCpQCcWvxp4bAshHsHX6mISnGlfvPfGceGDAB4lWnA=;
        b=W5vX7uRmL4Uh+QuurAgVvnkysl5xSMpW0RupNPy3Rqm1utxKsQxWpwbsYdQgZ+eiG3
         RfWWzGleTUYipN1VqS6N8nT22mvsvaHAib/IwnqLIUb85QRpCf8aaoJklANjoegLPD9F
         ONTtDljvKk9kpR/bD08yBuEMXYLWsUjKMmLYQMSuMAvD+hUo/5suQ+kUQq/XSbshs8rm
         LXe28Dmz1i6DlzS8Bks71kD+ziQsuCl7Z1r/hultmyL8rpzho+W7wXtR54gfuv/Ubcxw
         W18DGVFTSL4oz6AWxuwyoEpeiEnc39hVgbt853g5sguXYqDMVwNoGIhtbJUpLIbOPG83
         P1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hsCpQCcWvxp4bAshHsHX6mISnGlfvPfGceGDAB4lWnA=;
        b=L/1/3di8K/rjnQP+oVedPJfYWVvgyKv6DOYAso49Q6vPKpNmYxzHiBY30lJoeuaBDZ
         9HJk4ezoBPN4v699B0iqCF+dVWfH/8rLFL1mDq9pY3LhIFjIZT5JnpUNxCIgkqteAxrI
         ARDOcqECyWHEpsgGZvkYHgQK6XA9uBrZ/jXm2XYIYFbBEnBOnXgJGEcuVqbseyiRIssi
         rgWwcUIkaPEC1MHBq4MsEv594wbKkTYo28rNoAqINlq/pBUeg2gbQNYJKGpKLvZXFFLc
         P/ZWB5auAkbut47GUeW8wNSG8G1Xn4hwcFXIMLI6f5aM3FKo1VoHjApAzoD8wPxf1gwI
         khgw==
X-Gm-Message-State: AOAM533nRHc3TPhEbDPA05sm7c6THcPWlh3SAnh3xDj9QgHx4SGYclL0
        WTSGXmKoeHlv80RuAYffwuKDgtEOzfI=
X-Google-Smtp-Source: ABdhPJyD9zShTUppW23aOtreplEHym3K3txqCsfoAQgW8cQKocFLrpp2cBjllZnhBBAivh2180ZnYQ==
X-Received: by 2002:a05:6830:310b:: with SMTP id b11mr930879ots.322.1643585023000;
        Sun, 30 Jan 2022 15:23:43 -0800 (PST)
Received: from [192.168.0.27] (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id w22sm13621422oov.24.2022.01.30.15.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jan 2022 15:23:42 -0800 (PST)
Message-ID: <993808cf-7552-15c2-2a5f-6f0b39e00eb1@gmail.com>
Date:   Sun, 30 Jan 2022 17:23:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v9 12/26] RDMA/rxe: Replace pool key by rxe->mcg_tree
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
 <20220127213755.31697-13-rpearsonhpe@gmail.com>
 <20220128183205.GF1786498@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220128183205.GF1786498@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/28/22 12:32, Jason Gunthorpe wrote:
> On Thu, Jan 27, 2022 at 03:37:41PM -0600, Bob Pearson wrote:
>>  
>>  struct rxe_mcg {
>>  	struct rxe_pool_elem	elem;
>> +	struct rb_node		node;
>>  	struct rxe_dev		*rxe;
>>  	struct list_head	qp_list;
>>  	atomic_t		qp_num;
>> @@ -397,6 +398,8 @@ struct rxe_dev {
>>  	struct rxe_pool		mc_grp_pool;
>>  
>>  	spinlock_t		mcg_lock; /* guard multicast groups */
> 
> I think you should probably just use a mutex here and simplify
> things..
> 
> Jason

That won't work. All lthe code in rxe_mcast.c would be OK but I have to take the
lock in rxe_recv.c when we receive a multicast packet and mutexes are not allowed in
bottom halves.

Bob
