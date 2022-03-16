Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D734DA929
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 05:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiCPEGZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Mar 2022 00:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiCPEGZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Mar 2022 00:06:25 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E93344D4
        for <linux-rdma@vger.kernel.org>; Tue, 15 Mar 2022 21:05:11 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id o64so1385155oib.7
        for <linux-rdma@vger.kernel.org>; Tue, 15 Mar 2022 21:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1Id4BsxxbJRKwY04Yn7KeGGp6Q51GOF8hycE21o3deo=;
        b=UJCG1wALnIIftHDNpWXKGJhs94L7Qio+kE0UNE9gVVxs+ax3uzDnjkzduRERZMI4JI
         PDabXbkqP3b4Uwvq/plRyb1uhRPZ47p0G5FnHTcpCRnsAojv6RU2nkJAHSLlDzfKJolz
         kV6NRbIWIAB8YE9slrGxZy3zSVM1WTCMjmJMMn/SJraQlprfAtQyaUTY7dVJ075jWgVo
         tIDUXbP/seQv6KOUhdcpGdOtRiCW12TFkCawms7FnpnL+GtjtYHuQDKTetm1XoHozNOz
         EPKsNv8pDW9h2fIZmyXgVG6BJWAlhQLTTKl1q3yara0FeNOT6u8LAv5R/1cPRVaHXEM5
         K2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1Id4BsxxbJRKwY04Yn7KeGGp6Q51GOF8hycE21o3deo=;
        b=Iu7fdNsKRTxFVR9HtIOUIuUsYz+8RKiiUN36/aow407iufM+K3HktDozQkPvgQc1Fs
         fahmlEBXrjHRF1gcKeXRKyAqK16XPISYY9HSFFwcsOeya2GVtHIMk43RRftA8J7iWZCl
         NqbhwjMwAJbj2rLBZjujzoaIhnhrRB8c8uHDCWVa6qMkEU880dhvjeMR3Pq5knH+3g+s
         klLjJS9DALN69eCZ+LfzpKRH2RIz5zM7+gr1hw/+xWKCnze7vmrCxJ2Wdgtz2pglLGG9
         idof782GM4nOBAZgr+eqGoO9uyUU5oAtfgKtG9lwLAqvqEvAmwJdFhgPN8/b0l9Jr0YX
         qiGQ==
X-Gm-Message-State: AOAM532JF1xmRyOxpdG1OVydYFO1ggs6GyA3+vZupRR1kUiPeAr5pGwh
        bL9Rp0PEt2ON7S8E9VzrMXCy1Kwk4uU=
X-Google-Smtp-Source: ABdhPJyr5db2YOK39OgiYrrUrL746P8ezxtBWd2t+b/+SMk3QgmheCId4J4JB17/bAUMtjn6kURo+w==
X-Received: by 2002:a05:6808:8c4:b0:2da:575e:3402 with SMTP id k4-20020a05680808c400b002da575e3402mr2997618oij.8.1647403511088;
        Tue, 15 Mar 2022 21:05:11 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:744:9605:b0bf:1b15? (2603-8081-140c-1a00-0744-9605-b0bf-1b15.res6.spectrum.com. [2603:8081:140c:1a00:744:9605:b0bf:1b15])
        by smtp.gmail.com with ESMTPSA id 5-20020a056870100500b000ddac364643sm4802oai.30.2022.03.15.21.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 21:05:10 -0700 (PDT)
Message-ID: <e8992581-f409-bb4a-2755-e4fcee29e051@gmail.com>
Date:   Tue, 15 Mar 2022 23:05:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH for-next v11 12/13] RDMA/rxe: Convert read side locking to
 rcu
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
 <20220304000808.225811-13-rpearsonhpe@gmail.com>
 <20220316001835.GX11336@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220316001835.GX11336@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/15/22 19:18, Jason Gunthorpe wrote:
> On Thu, Mar 03, 2022 at 06:08:08PM -0600, Bob Pearson wrote:
>> Use rcu_read_lock() for protecting read side operations in rxe_pool.c.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>  drivers/infiniband/sw/rxe/rxe_pool.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
>> index 4fb6c7dd32ad..ec464b03d120 100644
>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
>> @@ -207,16 +207,15 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
>>  {
>>  	struct rxe_pool_elem *elem;
>>  	struct xarray *xa = &pool->xa;
>> -	unsigned long flags;
>>  	void *obj;
>>  
>> -	xa_lock_irqsave(xa, flags);
>> +	rcu_read_lock();
>>  	elem = xa_load(xa, index);
>>  	if (elem && kref_get_unless_zero(&elem->ref_cnt))
>>  		obj = elem->obj;
>>  	else
>>  		obj = NULL;
>> -	xa_unlock_irqrestore(xa, flags);
>> +	rcu_read_unlock();
> 
> This makes the hide even more confusing because hide is racey with
> a RCU lookup.
> 
> Looks OK otherwise though
> 
> Jason

This conforms with my understanding of RCU. hide() is a write side operation
since it changes the xarray contents while pool_get_index() is a read side
operation. The xa_load here just has to pick a side of the fence for what
to return as the link. It should either return elem or NULL just not something
in the middle. If we have to put the spinlock around the lookup there is no
point in using RCU. In theory there are typically many packets received for
each object create/destroy operation so we should benefit from RCU.

Bob

