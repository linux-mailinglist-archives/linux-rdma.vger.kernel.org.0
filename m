Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD95179F37C
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Sep 2023 23:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjIMVKa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Sep 2023 17:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjIMVK3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Sep 2023 17:10:29 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA139B
        for <linux-rdma@vger.kernel.org>; Wed, 13 Sep 2023 14:10:25 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3aa14ed0e7eso165580b6e.1
        for <linux-rdma@vger.kernel.org>; Wed, 13 Sep 2023 14:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694639425; x=1695244225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oaahSbgsIhgNTgcaYzovAL37slp3SRks58Qasz5E4o4=;
        b=O1ya2o3dzuS50JnpR0bt9HGGfjcsHONTe/qnGfbBGHRPvBpq7h1Bxhh/cGMoU03MLz
         w0S3w2wmfcYnIHYrVMs+NadAF08yJKaZYuPhSkmZCBzd68374qYaCqEXl+W431xTjWUn
         LvJ8DV5h89q2VvntzipLb8WgjjxPP4hnavHEKnkGXMoxH8NwW2mACGPkYdF+jxF4aHND
         VtsQPSXTpvtSdbCu5XiNmCzeaKAo+Fw1UkwTLDRUsnwuOptAEugAPZDS/aZ32gBSCiLZ
         6D1BsQ1QxlfWJmL6h7Q7VdQri2Z+TSHy8fg3QzWmNOlBIwUGjprZzKHA3kz4A4gyjkMV
         kwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694639425; x=1695244225;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oaahSbgsIhgNTgcaYzovAL37slp3SRks58Qasz5E4o4=;
        b=xR+6xy75YOF3sLYUjsxzTlmhkJpqhHbHnlwPrhduwI9nb2DxAFwq0DQzV32IeqzTQk
         685CvIcj1EuIzgt4tMRwqie4g9KsEahDCsjYhoS7lM+Z7VWJL/wvcDIdLe63oQhzC3ch
         lqR0u/DVq4x7W9uLg8RsYWuo7PXf250q5+nx+C0CId+iNGChQNaO2x3IDQVplrgecSOQ
         vbgKHv9giN2vmNNYW81lxjVPqSmRmnhpCWchgPtsvh/Vry1dQooPzWmr7ufWk+HI89ij
         w6kgqRCk5QVfM5OkQaz/LV01yFGTF2k57J09dVV6En8omkGDQUF8/cs8I011/r3FAAAk
         Ax9w==
X-Gm-Message-State: AOJu0Yx8awN+kkz3vn7bSbTnY6IW1zcSuVbEBLpv5d3oNEltvvAlhbUp
        gVNR9z7CAXj4FP+EU5mBD0w=
X-Google-Smtp-Source: AGHT+IFNpHo1+YTn55qCB42uB5j5sIvxIiYCmPyZKF2AXm51ugHt4FoGt/T6s4eZVErdh+bz6P+Z/Q==
X-Received: by 2002:a05:6808:f8d:b0:3a3:9b4a:3959 with SMTP id o13-20020a0568080f8d00b003a39b4a3959mr4407443oiw.17.1694639424769;
        Wed, 13 Sep 2023 14:10:24 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:3305:65ce:78cc:72fb? (2603-8081-1405-679b-3305-65ce-78cc-72fb.res6.spectrum.com. [2603:8081:1405:679b:3305:65ce:78cc:72fb])
        by smtp.gmail.com with ESMTPSA id fa12-20020a0568082a4c00b003a4243d034dsm11079oib.17.2023.09.13.14.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 14:10:24 -0700 (PDT)
Message-ID: <66d05c3c-79e0-9841-27f5-a073be46e453@gmail.com>
Date:   Wed, 13 Sep 2023 16:10:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: newlines in message macros
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
References: <1fbe7ebb-6501-10c4-b9eb-8435661f6046@gmail.com>
In-Reply-To: <1fbe7ebb-6501-10c4-b9eb-8435661f6046@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/13/23 15:50, Bob Pearson wrote:
> Li,
> 
> I see that you removed the built-in newlines in the debug macros in rxe.h which is ok by me. But,
> for some reason the rxe_xxx() macros all still have built-in newlines. Why shouldn't we be consistent
> and make them all the same. (Maybe they don't get used much or at all.)
> 
> Bob

On closer examination about half the debug messages that should have newlines added don't. About equally
easy to fix this mess by reverting the change and/or removing or adding newlines as needed.

Which way should we go.

Bob
