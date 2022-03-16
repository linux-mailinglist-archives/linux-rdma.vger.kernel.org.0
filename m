Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B574DA91E
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 04:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343977AbiCPD6k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Mar 2022 23:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiCPD6f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Mar 2022 23:58:35 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AE153E04
        for <linux-rdma@vger.kernel.org>; Tue, 15 Mar 2022 20:57:21 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id a7-20020a9d5c87000000b005ad1467cb59so656627oti.5
        for <linux-rdma@vger.kernel.org>; Tue, 15 Mar 2022 20:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qrjPYETKy9OxfLci9WepWlY9gTVrWxEiy/58XqnL1Es=;
        b=A0TEGT4YfSfpjq66qsfuXknHFNKjAB9jx9fWw3a7Ppx/LyEudBr/ZfhStK50kD4zOV
         PvTsCJnmS4S4Im2imSj77sNob5yp6igCjzJFXIufZG8oash8ZNqMX4nEDLq7vslqvPDn
         ipGGYm6Dout5d4YtcheMHw5qZKtskjSp5Stqp//R3pqEDu+arergoTIFeiv0x8V0nf8y
         PllFFeRtaqT8Aw4IvORA2U69DIqG6IkRuaLdOToWo87+AUMHZ7i1FOoB5cck8aVypcAY
         /50dbHMo45ROm0EunQZyXmcC19+/HxgP+qSNtBoi5j1mG5iPiny2kuLm9vwTSHTIQHAA
         MK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qrjPYETKy9OxfLci9WepWlY9gTVrWxEiy/58XqnL1Es=;
        b=i3MVEF7Bd0UNYGqpqLgCZJYZ19cuKuc1F4Urd9IEdNF25hMw6+9Lb+LUppLBM1iBDf
         a9UXpYaACURZ1s+HzxpMlYProsyZUAUJkckRj7d/phIYZBEO9CCVT9eApooB8bRLf9pM
         AkZlx8Mn4/vGGSum6JqVulYGGaupGu8Po8neSCaqBRm8lh1sti0TGuHMuH/K7aoGck/8
         H7O6FYAfIsVs58CS8hmeRZQCOctvXBVFp+Ym3Vib8Pk1r2a0TQr2uAlx+9mSrYxquXAD
         1DXGLdduY6JbKgOzvPbAuVb3hun7aO3sKmZNgOun2+hczuLu4TKpu4ddT+UvpvrZ5c7n
         faCw==
X-Gm-Message-State: AOAM531QQfEsfYW7frf62+4UBUpzZLQB3Yu2/dEVbFzy1MGhFw61eeS7
        uEVnzq7jVn0bPYzn17SdNak=
X-Google-Smtp-Source: ABdhPJy7fXXFzYaZAmkikMcaMOEAR1QUg/zKXOTZbkAakmUbyc3Ph2QyEQ5ah4Jr68d3F1vs+PiN2w==
X-Received: by 2002:a05:6830:71b:b0:5af:62e1:99ee with SMTP id y27-20020a056830071b00b005af62e199eemr13324926ots.227.1647403041199;
        Tue, 15 Mar 2022 20:57:21 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:744:9605:b0bf:1b15? (2603-8081-140c-1a00-0744-9605-b0bf-1b15.res6.spectrum.com. [2603:8081:140c:1a00:744:9605:b0bf:1b15])
        by smtp.gmail.com with ESMTPSA id p14-20020a056830304e00b005b246b673f2sm390184otr.71.2022.03.15.20.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 20:57:20 -0700 (PDT)
Message-ID: <1a6dab91-b178-6761-151c-a048511bd827@gmail.com>
Date:   Tue, 15 Mar 2022 22:57:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH for-next v11 11/13] RDMA/rxe: Add wait_for_completion to
 pool objects
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
 <20220304000808.225811-12-rpearsonhpe@gmail.com>
 <20220316001737.GW11336@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220316001737.GW11336@nvidia.com>
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

On 3/15/22 19:17, Jason Gunthorpe wrote:
> On Thu, Mar 03, 2022 at 06:08:07PM -0600, Bob Pearson wrote:
>> Reference counting for object deletion can cause an object to
>> wait for something else to happen before an object gets deleted.
>> The destroy verbs can then return to rdma-core with the object still
>> holding references. Adding wait_for_completion in this path
>> prevents this.
> 
> Maybe call this rxe_pool_destroy() or something instead of wait
> 
> wait doesn't really convay to the reader tha the memory is free after
> it returns
> 
> Jason

which is correct because except for MRs which are freed in completion code
all the other objects are just passed back to rdma-core which will free them
in its own good time.

Bob
