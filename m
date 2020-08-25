Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31583251DDD
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 19:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgHYRMW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 13:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgHYRMV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Aug 2020 13:12:21 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73376C061574
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 10:12:20 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id e6so12294467oii.4
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 10:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PczvNUgJOb95B2FgYOf9wXo8Bku2CenuBfA1fKCXUy4=;
        b=iiRilZ0AVioRUANGqb7SGvQJZxSANEiIgRMAnrc8BBCh1+LmuBonaia4ti6e8z+tqt
         eJWluF8DZN0c8GpJ4IalwzvjM6PQPDU6PmA/drCZvfveIs13n3OmRSVl12XHQ/KZExA4
         kDZWYte34Px98I9DJuWBsDzdQBcvW2HwxA34owWZ0IUVHm4wsGRm89uqTio3JCxECRSd
         Q6IX3mYWsBSTgTqUeSHMRh6dUuQyOHVwlfvjRwCDslBLo44cHTMih0xIuok3w88tyaIv
         9k0mdsOa1RcpuXGWkI+BwM7/oncFqpIXVvLuUkdo/PNsqlFKey9ErfUoMLbRjLsV81Dn
         3VYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PczvNUgJOb95B2FgYOf9wXo8Bku2CenuBfA1fKCXUy4=;
        b=dBz64Pt7Afby84dVNFZaYKv4DWIOCB8wwK2vnco1QfI2G3cPseXtQ/h6mlAxZpr2xQ
         WgXC0U0Iysc9rKiEzLCQ4zMxS1J81jUJro2mwF2hYXrI3KymmNtioo++RHViaq6Cuf19
         1nC8a2rmXbU4R81zXZf234cQgVfXUzGvvru6f8wNwAPuiAg4PB+CrW8K8oUWxtKEuXyR
         tdRSxgl1CMguZs6PHiI6D6ZarD8nImxtNnZ7HHjV6X7z9YTPECw4GidST0HJionMk/g9
         gY5QWXDMhbwkuGy5FlTOhQY5xbtYRtKUNFS4qVoBuh9E/Iv2YYkiZn8YGRA+uOjRGTh/
         8Pzg==
X-Gm-Message-State: AOAM5317f/iWJnkP3pHb09iOetC58MfLYf1W8LexPKYt4jFOVnn+3XAX
        G1Zvut+XAy7uNxWBVRhOEhefyLOeg2k/Dg==
X-Google-Smtp-Source: ABdhPJxrJDqIf1jUQ5YdP/5+p1jzItV6cIk0I7l7QXcazFReBMQRjiHhecuHLPVC6obhjTt6dDCy+w==
X-Received: by 2002:a05:6808:7c3:: with SMTP id f3mr1498834oij.153.1598375539781;
        Tue, 25 Aug 2020 10:12:19 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:d277:9c63:7fd2:8e07? ([2605:6000:8b03:f000:d277:9c63:7fd2:8e07])
        by smtp.gmail.com with ESMTPSA id u20sm799684ote.9.2020.08.25.10.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 10:12:19 -0700 (PDT)
Subject: Re: Re another alternative to resolve hardened user copy warnings
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
References: <42b0da37-898f-2ca1-ffcb-444b65c9c48d@gmail.com>
 <20200825165307.GI24045@ziepe.ca>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <a6ccc179-b23d-3dc4-cff7-57f39e912f13@gmail.com>
Date:   Tue, 25 Aug 2020 12:12:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200825165307.GI24045@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/25/20 11:53 AM, Jason Gunthorpe wrote:
> On Tue, Aug 25, 2020 at 11:37:52AM -0500, Bob Pearson wrote:
> 
>> Currently only the rxe driver is exhibiting the issue of kernel
>> warnings during qp create caused by recent kernel changes looking
>> for potential information leaks to user space. The test which
>> triggers this warning is very specific. It occurs when a portion of
>> a kernel object stored in a slab cache is copied to user space and
>> the copied area has not been 'whitelisted' by setting useroffset and
>> usersize parameters for the kmem cache. As already discussed there
>> are two ways to mitigate this
> 
> I think we should just add a uverbs_copy_to() for integers, much like
> netlink does.
> 
> We already have various getters for integers..
> 
> Jason
> 

Perhaps. But I think the proposed fix is good in any case. It gets rid of a bunch of code that doesn't add anything.
The info leak police will come after kmalloc too. It is just a harder problem so your suggestion will still be a good one.
