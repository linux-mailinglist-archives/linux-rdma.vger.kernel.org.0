Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D72436898
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 19:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhJUREz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 13:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhJUREy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Oct 2021 13:04:54 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A577BC061764
        for <linux-rdma@vger.kernel.org>; Thu, 21 Oct 2021 10:02:38 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id g125so1650511oif.9
        for <linux-rdma@vger.kernel.org>; Thu, 21 Oct 2021 10:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6vGhO+75ZF25C5zxTaMNfmXem13fJHteD4eGViiemT8=;
        b=iw+8wV5jV9nLOUDx6bC31wrcA651iDIA0c/jxM8Wzb/oGYgxePPQ/OsOaC/i/WF4Sn
         dN8PALo8QumfL+DGefrdbbotXgvnDrZk01Th2WL4CWsmfiNhuEdaXHzjw0J4jUonQCU9
         sQnBxCu/qvr+n0bDe8FC0AVr3YNVgh+FOEH7592hlVOSnjHDbKUrglif7hFt/5TILsrO
         dZLrfD12a79G2o4a1b90eJHFeSShFZNyUYjB/SFl28dtYRiV5pOAMtAb22ZJzIrxIQ+4
         EvznoYKLfNJLInxfBUJ89o5jnzKSDsRo7ofCHAxa3aF/mTjtst9rH8bGrBHCDQdcs4ph
         ix6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6vGhO+75ZF25C5zxTaMNfmXem13fJHteD4eGViiemT8=;
        b=OLwVNp+CpoYq7dQAp6YVFfbAXTMILbJBwjjKjMEcfSmGTEJM/tB0Oodtbg6bHA5otu
         pH+h0SS9lXqceZjoIgw9ZbzAfYmJ5PtU2s9r6Ss73vYVlp9KWplf/zRDk2BVq0eVwkal
         DHmpLjyNnm8xVdYwDhmPI/v5HGnCHAKG+8yX/odKfEnuvgCzfS8p1dCqz+0biOl9/LGG
         qL3i9l0jmD/GtdhTYEyz0agE1U7u4U/boZG4ON91K1mwvs7PAfbm52NqgU4zp6nkWp/E
         RJfDI8ItSaIpTDRc1xpBdCRGA9RcWNFE6BenZVn2GTG6KrSWcTN5vVts3j/e5xzU8e32
         5+8Q==
X-Gm-Message-State: AOAM531nDY96OYElsao3ISME+/+0C/jDIgNM3QzTQhCAQpv5yB5Gt8xY
        Qdtz9Gr5fSy4oybsPUnwlQnDXJ/o+B4=
X-Google-Smtp-Source: ABdhPJyNglYkrLxStUpzmTtk6q2rn36VdkRy3Og5Ni4uO/RYckiCaNac8z8AGYC7tyM0WLgXhN8x5A==
X-Received: by 2002:aca:af85:: with SMTP id y127mr5637820oie.96.1634835757800;
        Thu, 21 Oct 2021 10:02:37 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:7fac:3dfe:6453:18a3? (2603-8081-140c-1a00-7fac-3dfe-6453-18a3.res6.spectrum.com. [2603:8081:140c:1a00:7fac:3dfe:6453:18a3])
        by smtp.gmail.com with ESMTPSA id q12sm1136896oth.79.2021.10.21.10.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 10:02:37 -0700 (PDT)
Subject: Re: [PATCH for-next 3/7] RDMA/rxe: Add xarray support to rxe_pool.c
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20211020220549.36145-1-rpearsonhpe@gmail.com>
 <20211020220549.36145-4-rpearsonhpe@gmail.com>
 <05c793cf-0652-de02-038e-2785d98574ee@cornelisnetworks.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <2dc017bf-cfc9-3678-1f9a-53f1611a062b@gmail.com>
Date:   Thu, 21 Oct 2021 12:02:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <05c793cf-0652-de02-038e-2785d98574ee@cornelisnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/21/21 6:53 AM, Dennis Dalessandro wrote:
> On 10/20/21 6:05 PM, Bob Pearson wrote:
>> -		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
>> +		//.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
>> +		.flags		= RXE_POOL_XARRAY | RXE_POOL_NO_ALLOC,
> 
> Assume you meant to remove that comment line.
> 
> -Denny
> 

This was an intentionally intermediate step and was a hint that you can run with either choice. In the end of the series all the old stuff goes away including the comment.
