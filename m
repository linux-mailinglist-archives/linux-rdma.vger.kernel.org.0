Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C405773B35B
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 11:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjFWJTv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jun 2023 05:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjFWJTt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Jun 2023 05:19:49 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5801BFE
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 02:19:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9881b9d8cbdso283745166b.1
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 02:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687511985; x=1690103985;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pQ6QabPlq4SG93YlN4F2ainKra0lJ4TZXEDEZJ3pyxA=;
        b=0axuMEg5f03qoxYkBU39Y6B7dmYmm4FMYEjsO8GOkZG74Jr2yt8GLFBXoWG3KVoOV1
         BB49AvFjfeXy7pOh+ot0as7u3Hg2BNMDaK2Xv620QO06T4fTDhCFa4w8YezTRhKIrs51
         mpAgBD5mkh6h014AHUFSASh2NIYisKH6JqgyuF9fUD/AgsdYYw3G+T8ql+ginJ2VJzf6
         ge3We9/1tRYYE0+VUf6bH/G1YKEdWlz8CcSrTxHu4sfyKkgKfAjcfyn6urGlKS4FlHhk
         JN2/j/omQBhqgCNZVjNCgqaPg4Tp6YpB7McC3ulIwA79Vz8Y5OrVwvbc5cmPTij8GJRu
         5KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687511985; x=1690103985;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pQ6QabPlq4SG93YlN4F2ainKra0lJ4TZXEDEZJ3pyxA=;
        b=cvzyB4j/RVG55VYWdXdjnxNWrRcFMRgx2YMBcbUsZaIoopgJs6BbqEJDFlrKiQypaU
         2hDvlBN1h6nD5kvC+XLl/TLG0yFIqG/nog3DPyVLDBFfBTTyQu1pKFWFWXv2rzi+04ko
         cczRo3kU/NFTUc16/WMwIihIGiH1G0021RJvmmATz4VJzR04BE8Vz77xVQ8sLBYwkM0H
         KM7ay89qCPg3p86KTZjz4QEluBHV7au7BW9hW3UCCKamf+9clqx5dtxtejuOFNbe3A9+
         8vSZu731RmUG2S4BRDyxpxboUZmikO+sXwrd0AHosRMi7reTYSaBXDraac0akQsKhpy3
         gQ7A==
X-Gm-Message-State: AC+VfDw6z+figURZykRE73zU4/TYw0/zFPPL8zVb3DMmia8EULgKBHHJ
        UDPQFwihzAB5tkz76tLuSL4ATw==
X-Google-Smtp-Source: ACHHUZ52Fo1SOMyS9PnfNxeqPNIhe3ZVZpvWYLfgZDAsHyINH0WiPBBtpaP7I3qzkw0JoKFz3v5MXg==
X-Received: by 2002:a17:907:6d26:b0:988:2037:c687 with SMTP id sa38-20020a1709076d2600b009882037c687mr14620975ejc.37.1687511984570;
        Fri, 23 Jun 2023 02:19:44 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:7733:4d95:422b:f164? ([2a02:578:8593:1200:7733:4d95:422b:f164])
        by smtp.gmail.com with ESMTPSA id j24-20020a170906279800b00986d8722e46sm5879974ejc.17.2023.06.23.02.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 02:19:44 -0700 (PDT)
Message-ID: <e228646e-bd41-d6fd-b43d-11d3f9d3c029@tessares.net>
Date:   Fri, 23 Jun 2023 11:19:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/8] Fix comment typos about "transmit"
Content-Language: en-GB
To:     Yueh-Shun Li <shamrocklee@posteo.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     jgg@ziepe.ca, leon@kernel.org, anthony.l.nguyen@intel.com,
        davem@davemloft.net, kvalo@kernel.org, jejb@linux.ibm.com,
        pabeni@redhat.com, apw@canonical.com, joe@perches.com,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-scsi@vger.kernel.org,
        mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230622012627.15050-1-shamrocklee@posteo.net>
 <168748862634.32034.1394302200661050543.git-patchwork-notify@kernel.org>
 <50a88781b9e2a80588438c315167bbec@posteo.net>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <50a88781b9e2a80588438c315167bbec@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

On 23/06/2023 10:51, Yueh-Shun Li wrote:
> Dear Maintainer,
> 
> On 23.06.2023 04:50, patchwork-bot+netdevbpf@kernel.org wrote:
>> Hello:
>>
>> This series was applied to netdev/net-next.git (main)
>> by Jakub Kicinski <kuba@kernel.org>:
>>
>> On Thu, 22 Jun 2023 01:26:21 +0000 you wrote:
>>> Fix typos about "transmit" missing the first "s"
>>> found by searching with keyword "tram" in the first 7
>>> patches.
>>>
>>> Add related patterns to "scripts/spelling.txt" in the
>>> last patch.

(...)

>>   - [7/8] selftests: mptcp: connect: fix comment typo
>>     (no matching commit)

I just applied this patch 7/8 in MPTCP tree (features for net-next), no
need to send it again elsewhere.

New patches for t/upstream:
- ba8a625a062a: selftests: mptcp: connect: fix comment typo
- Results: e16a005b0d79..f186e81ff99c (export)

>>   - [8/8] scripts/spelling.txt: Add "transmit" patterns
>>     (no matching commit)
>>
>> You are awesome, thank you!
> 
> Should I rebase the local branch onto netdev/net-next/main
> and send the "no matching commit" patches again?

For the other ones, you might have to send them separately to the
appropriated maintainers according to the MAINTAINERS file, not all of
them in the same series I guess.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
