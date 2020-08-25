Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3664A251D4C
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 18:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgHYQhz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 12:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHYQhy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Aug 2020 12:37:54 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEFDC061574
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 09:37:54 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id r8so1394103ota.6
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 09:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=jxTwDlhT4RdlsKfkyZgB6au+lj91bcjVeupOiRuBhY0=;
        b=aVRyKu8T8SnqBWoGJTb+lJ7bicPz/Aqb2pM1CjJ19pOvstb1n0zQuKOulcQABHvWZC
         Q9Fnyx6ZaGRFbx6hueX41gQ4PmepqeOPZUOLOXom4ozSmKo4MT9pPR23SNC7TCsFT0W+
         /vh3a+3WjCFLbre3oKEByZzGKLTw7Ib3ZR5WuYo+skh0u07+0mpHXUvE8bQVYrAo7aPz
         /mFCU0i8t1PYAnmYf4VoatpOtrRp7TXca7D7Y4aXkGCxh3A0yHeALQ0oX+MhHXKgG5Is
         lnlnSYYiWKZkfcpzgwGgGmbC88tLrPgcy3D8izqNI/DmNZ+SNUL13AwyXboldiKmu5W+
         AhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=jxTwDlhT4RdlsKfkyZgB6au+lj91bcjVeupOiRuBhY0=;
        b=plVh9LvcHITCJn/LAFdKs2ea+BigUJqWQMbQORqwTRQJCH7qKgR0HEuPHptE3o3kRz
         78wUdIkathVda7uYvCMh7JmITAb+D/kOdkBWLcSYAYjPi8pxjbffW4mEjM8n6OKIMeci
         riHHmVxKngqlpJ+mMIbS0g460TKS5OLPJo4MgG+vT54Kppqjc0BfbcDwyNvTm7+mc4ti
         npdXdMD9Aj6nMvuq4IqeMo8vVsATKmBPZb1plw6XvsOTB61mhqkyM5OquqAqhsQorj1i
         zqbj0qgiPlJjdxp2Li+zUiGVnBf44VC4JT9AL/DPOTKusTHuXynkrdU+3m+CW+VSyAaE
         kv+g==
X-Gm-Message-State: AOAM530b08ElEwH3EA+3NWELxzCoJlf6GPolBJ/8EwU7m0LkbbJskWyo
        YovAH1BM4XtYP7+dA1ABYLrk7XTjAZPPeQ==
X-Google-Smtp-Source: ABdhPJz0etUy+iNpxWuX6aSXo5FU74+TyajIk+SJXG7dfQ+WbuRiRQv28FXT9jt9tqrOZxZBziq8vQ==
X-Received: by 2002:a9d:48d:: with SMTP id 13mr7895693otm.9.1598373473504;
        Tue, 25 Aug 2020 09:37:53 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:d277:9c63:7fd2:8e07? ([2605:6000:8b03:f000:d277:9c63:7fd2:8e07])
        by smtp.gmail.com with ESMTPSA id a10sm2740444oto.76.2020.08.25.09.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 09:37:53 -0700 (PDT)
To:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re another alternative to resolve hardened user copy warnings
Message-ID: <42b0da37-898f-2ca1-ffcb-444b65c9c48d@gmail.com>
Date:   Tue, 25 Aug 2020 11:37:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently only the rxe driver is exhibiting the issue of kernel warnings during qp create caused by recent kernel changes looking for potential information leaks to user space. The test which triggers this warning is very specific. It occurs when a portion of a kernel object stored in a slab cache is copied to user space and the copied area has not been 'whitelisted' by setting useroffset and usersize parameters for the kmem cache. As already discussed there are two ways to mitigate this

	- copy the data, in this case an int, out of the kmem cache object then copy that to user space
	- play by the rules and set useroffset and usersize using kmem_cache_create_usercopy()

Additionally, as you have mentioned, we could move the allocation to the core (like AH, CQ, PD, etc.). But this only works for a different reason. If you use kmalloc or kzalloc then the warning is not triggered either and core uses these to allocate objects.

Allocating memory from kmalloc or kzalloc is effectively the same as kmem cache except that the pre-allocated sizes are typically powers of 2 so there is some wastage of memory and you have the potential to pre initialize all the objects in the kmem cache (e.g. locks, constants, etc) saving some time. Currently rxe does not take advantage of this second feature because resource allocation is not on the performance path for RDMA. Given this we have a third alternative which is

	- get rid of the kmem caches and use kzalloc to allocate storage for objects in the pools.

This is a simple change to rxe_pool.c, easy to understand, little or no change to the rest of the driver. This does not prevent moving other object allocations into the core but will resolve the warning issue.

Bob
