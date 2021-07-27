Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5643D744F
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 13:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbhG0LYC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 07:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbhG0LX5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Jul 2021 07:23:57 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FADEC061796
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jul 2021 04:23:57 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id f20-20020a9d6c140000b02904bb9756274cso13089247otq.6
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jul 2021 04:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eeu1cqLnKKeMT1/fQnGjqqXzionNrV7MF3LMpRw4RqI=;
        b=OgskOafRyAhhb9Kbyihow5c/XpJ074Su0OItBRd5jrms7+3BAsnp9E8Ia8pZl28e5s
         whpP5iPe3AKDpIFt7UERnVwJjyz/uNPB6eMB73xE3Njrd1HUoUThlR+5GV/J77EaabQb
         X8N/h3Rwu/wPBWZkF7d3YbZN3meYOvFfkNN70xN5PFgQLaGduBfaNP/vIg8L/fr6V6Hq
         CZ9DnyLzm4NEpXnLmgzIn2JId0KbT4N95mMSLhbul04Nh0uEpjYyVJmg392Fqj2LEcB0
         ciu8T9G3+K4m/qu0wW9mws2DRbZGa+NBsi3o8L4lOOLjYadnshSsaCvFgwztD0gsozqX
         DHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eeu1cqLnKKeMT1/fQnGjqqXzionNrV7MF3LMpRw4RqI=;
        b=CM6wc4Ex2KRd5PH8dfQThA6V9Mbh2BZkdOG9QPkOfR6ItXg5NxAF2tG9VWZE+WeNyF
         2aQHhnk47A9lr1hjw5c8sA9T2qTHqFimks7ZoyLms6cZ9sRPDwlzz9Vu0il5hA99jqry
         lMmsxcLY8l33GipSsehmmGB2RDoMdxi1SnU80qw6pybYePaC7vI4EAnEkNupsNmWHWxz
         Gi9fobbAXmtgEiB3+iKLz3h7uudKP0e1jKmkKHA0xWd7aSln5sHGcwf7CYRLnm5qWm53
         NftKVMU9hOVa+5pu0gJCdivHypFgP1XNDEBeq5e1i8Agkr82QbNRG+dHIkkyB5+Aljd6
         8Ojw==
X-Gm-Message-State: AOAM5320zSJd7CJmH4Ae+w+rethq0iEwEM+2G5Vs0GjYkWTsQ8ccRvn+
        5huSqwYWxC+cMxAY9i/DzX6PnJqp9P4=
X-Google-Smtp-Source: ABdhPJwi0TskM+8jQtMSMXbxGgSrPPaQsWSJHLmVvc7vF5ePYQzR8/5ZlXpt6h1/uN/ywsczBwbY7Q==
X-Received: by 2002:a05:6830:2b25:: with SMTP id l37mr6626432otv.324.1627385036796;
        Tue, 27 Jul 2021 04:23:56 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:79a:6fd8:e907:f2b3? (2603-8081-140c-1a00-079a-6fd8-e907-f2b3.res6.spectrum.com. [2603:8081:140c:1a00:79a:6fd8:e907:f2b3])
        by smtp.gmail.com with ESMTPSA id h24sm483626otl.41.2021.07.27.04.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 04:23:56 -0700 (PDT)
Subject: Re: [PATCH for-next] IB/core: Add xrc opcodes to ib_pack.h
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20210726231009.24020-1-rpearsonhpe@gmail.com>
 <YP/jN7fWbDKt4GqW@unreal>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <90946031-b1a4-3944-b207-05bdad9a8cb6@gmail.com>
Date:   Tue, 27 Jul 2021 06:23:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YP/jN7fWbDKt4GqW@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/27/21 5:43 AM, Leon Romanovsky wrote:
> On Mon, Jul 26, 2021 at 06:10:10PM -0500, Bob Pearson wrote:
>> ib_pack.h defines enums for all the RDMA opcodes except for the XRC
>> opcodes. This patch adds those opcodes.
> 
> Why do we need such patch? What does it fix? What didn't work before?
> 
> Thanks
> 
I'm working on implementing xrc for rxe. It uses the opcodes from ib_pack.h. So I have to either add the
opcodes to ib_pack.h or redefine all the opcodes in the rxe driver.
This seems like the better solution of the two.

Bob
