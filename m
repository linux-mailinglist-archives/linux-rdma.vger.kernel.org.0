Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB6358971F
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Aug 2022 06:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbiHDEmY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Aug 2022 00:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiHDEmX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Aug 2022 00:42:23 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBC25927F
        for <linux-rdma@vger.kernel.org>; Wed,  3 Aug 2022 21:42:22 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10ea7d8fbf7so17869295fac.7
        for <linux-rdma@vger.kernel.org>; Wed, 03 Aug 2022 21:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=p9pzgJP0Wp+MVfMOjQ/mi9ig3q9i4VV3xYVh5Mh68xc=;
        b=pz02gSx9ydhtL/RzuEcQjUzJIH2dA9PmQIzEF8P8cVwR+VkfBUNllaxTqyCeqOjZNB
         9k69PtKIcCloFvn3IORyX3tcjTQZlfeMcmMrVMwtKHtflf+YgPVZDq5nHusWmQtD9Bmb
         2LcXu7UvRgIoIRlgdJ1YbYcTNCTQaTpTCXrcBkdA8A/iM53TEi0sGfWx0VzChTv0xStq
         hIKWfmE64+d2d/iy1VpSvZt+GBTBj5EupS+QEDShGfLUGbKlTVmS+F1fEQLBrLQOczWR
         hSqPU6CxC4lT0J5DRFz2kAqST8WSiX3M0kPxOoPAhwvKK7nwEpMGPnQt/xmcFlNQaMaO
         XYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=p9pzgJP0Wp+MVfMOjQ/mi9ig3q9i4VV3xYVh5Mh68xc=;
        b=fFV89/mM6qTQZqmoPoPIti0xWp1oR+Pp6xWDO+81wvu2CK92i1na5LEH2opnh+vC+2
         gg+Nb17ZLuD5QshY6fW1GPM+O7JI8712HWNgRYMfV/RccrTn/tP+cOYCVht7rqEHmpuE
         ahLf38h3goCC/40lxB2vB5kld3Vg1IKeixVG8RqDB9x/NM4lVIhRVnwzYEidw0hd8I2Z
         BOdkT9QjVxRQb1dPzgVBoEPGoaKsldrxEQs1Y+Z/5t0VrOa3AKX8leRrfOoSUaM4PKKH
         MIJoWob/dsTtcWKiGfrKWLtQt+v3G/uFSPa4/BkEdwHRu2R11dORD634Yyj9zEzkaaXS
         Kk8Q==
X-Gm-Message-State: ACgBeo3L2aFTTWy+XoMldaaY36ZzeE5+zPQnZNbq+SBdab8r1Pa++MHq
        ZALM8a3nSQvYTVK9mjeNbSQ=
X-Google-Smtp-Source: AA6agR7UafsmpD/LWiPBrhD9xitWm9RY8H60qn/w9nvGscXCqeb81U0Ov6kbmjXks3cS6jlyz/x9gQ==
X-Received: by 2002:a05:6870:4622:b0:10d:fdb0:549a with SMTP id z34-20020a056870462200b0010dfdb0549amr3532721oao.271.1659588141548;
        Wed, 03 Aug 2022 21:42:21 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:11a8:66f0:79e6:46cd? (2603-8081-140c-1a00-11a8-66f0-79e6-46cd.res6.spectrum.com. [2603:8081:140c:1a00:11a8:66f0:79e6:46cd])
        by smtp.gmail.com with ESMTPSA id 68-20020a4a1447000000b0041ba884d42csm10857ood.42.2022.08.03.21.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 21:42:21 -0700 (PDT)
Message-ID: <d6740baf-9656-2e3a-10a4-4c51e17c4e88@gmail.com>
Date:   Wed, 3 Aug 2022 23:42:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 for-next] RDMA/rxe: Fix error paths in MR alloc
 routines
Content-Language: en-US
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
References: <20220804043731.3737-1-rpearsonhpe@gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220804043731.3737-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/3/22 23:37, Bob Pearson wrote:

Li,

It wasn't umem it was pd not getting set in the rdma-core routines when the forced error occurred.
Then when I called rxe_put(pd) it seg faulted. Fixed it by putting back the code that set pd early
before an error can occur.

Bob
