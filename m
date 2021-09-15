Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771D140BCCE
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 02:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhIOBAL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 21:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhIOBAL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Sep 2021 21:00:11 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAC6C061574
        for <linux-rdma@vger.kernel.org>; Tue, 14 Sep 2021 17:58:53 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id h133so1868678oib.7
        for <linux-rdma@vger.kernel.org>; Tue, 14 Sep 2021 17:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3JVrGTbx5bwIY9JVyzG8T8nc8frCCS15djhEoq6z09M=;
        b=dhAV6b3pE/sTS4A0uIe5L84PIv5eg4S8BwTebv8kdrc/tTNDBgaWKmiHK2A8CPUjkz
         CPvzdGonvH4q5JHmSMm002umnY2+51mckTCI9yfncNB7vuzkgUk37nWBAIpKc9dtJkkZ
         ZXaR4qHjbnoQdLwIrR7q55B8X17lplZhdvcPF6E4BcFjOfbiNcdlOF2rQSs63YK7gvaS
         3z0VChgDLu3Zv5bQUiK8p3zmsg4PxiW26sPuRXv9SYIcIsX9Fss0uVST6bTpKdwxttm/
         mufQX9dUmT1iD6CLMRQBU/2olNYJ/uttzub0P9vF4Lkk1GBsdjvT9FyhdIC6oJXiymrh
         +muQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3JVrGTbx5bwIY9JVyzG8T8nc8frCCS15djhEoq6z09M=;
        b=j4LlTnwR6kUl26D55obNDetqMEco4dslPzFqg6iDai+kL5ZfiqnAoKSpsJsVVo9t7u
         ZBT197E9fQGYPSQRxGPC+xVNsAm7ioE1in/ux2TBfhqVO/YmUVFhU9Go0nt7wi+NkWSw
         QCiz2nEQVy52XM2TWNb33PROlPapKBN+rOucofmUG2y3UdxYMHgtEwdTuSXKpWU3z02F
         dndrSo+FVq/SkZ8Oljk6u/wYrHISSqZykmKVlcemcCZvrFZb5Rpk45oluRtA67Q7wRXk
         IdL/q9x2ct94DjQWX79Bz6sZHgJKOTi08X3rTsCv40/JbRnvsCVTuksiJaOsTbuRxmk2
         olTg==
X-Gm-Message-State: AOAM532y8YDgjghXMQ5OGm+vefp16DEJ7qlhPeBO7n3ZOMF/gZxIRj9Y
        rqkq7t0JYHunKIZ3pTrFZfE=
X-Google-Smtp-Source: ABdhPJywB6dxkVC9Q+3n8vqniQqaGuQQe8eHtK5UCVD30Ugc9XkbccB7COGrKjFwrbthQ+DvTPRlhg==
X-Received: by 2002:aca:2b0e:: with SMTP id i14mr3509456oik.16.1631667532644;
        Tue, 14 Sep 2021 17:58:52 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:d9f3:4e7a:72f1:83fe? (2603-8081-140c-1a00-d9f3-4e7a-72f1-83fe.res6.spectrum.com. [2603:8081:140c:1a00:d9f3:4e7a:72f1:83fe])
        by smtp.gmail.com with ESMTPSA id w10sm2648828oiv.14.2021.09.14.17.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 17:58:52 -0700 (PDT)
Subject: Re: [PATCH for-rc v4 0/5] RDMA/rxe: Various bug fixes.
To:     Shoaib Rao <rao.shoaib@oracle.com>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        bvanassche@acm.org, mie@igel.co.jp
References: <20210914164206.19768-1-rpearsonhpe@gmail.com>
 <032c0bd7-568e-e98f-d1c6-4fd4b3b25efb@oracle.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <a1d598a4-2022-46d7-c438-492b5a4ce595@gmail.com>
Date:   Tue, 14 Sep 2021 19:58:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <032c0bd7-568e-e98f-d1c6-4fd4b3b25efb@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/14/21 7:07 PM, Shoaib Rao wrote:
> Hi Bob, I can verify that rping works after applying this patch series.
> 
> Thanks.
> 
> Shoaib
> 
> 
Thanks,

I appreciate your quick response.

Bob
