Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC9C7260F3
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jun 2023 15:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240318AbjFGNRe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jun 2023 09:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbjFGNRc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Jun 2023 09:17:32 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2741735
        for <linux-rdma@vger.kernel.org>; Wed,  7 Jun 2023 06:17:31 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f732d37d7bso34997985e9.0
        for <linux-rdma@vger.kernel.org>; Wed, 07 Jun 2023 06:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686143850; x=1688735850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SYupklKPpCKqKq19TrZNmrOzCG5CBVYGrgEKzSjksBw=;
        b=Uxytj1HUTANpDEX7sOxU5muMpy2+aTbVqSBOhYkeKyZU3X6/GU21krI9hvsWQ9K8+U
         dewEqv6TAKDvpFdMDkkexuQvAL17bwxsqWNgYTiw4xagNxMgE2jS3JnVd3Zy13eYwETp
         4XY1/zyBB6XDqGreJwvdqOU8LLgdeQpGgmNWlSJ2eRnNxAH8PAFIZCtgRY6dnwEV7cx4
         Ovce5CkcTgIjwIjOyT/5XfH3i6gh7uDk7PR7w8FheonfK7Ec8iWkp1P5T6IQOxphpxWf
         dyTgHZuhLtd1hhikpBY0NylOIbLCkLtQ4I/hcbzmbe+p9gnMXksFGWVqOfyE7O6biDL3
         MQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686143850; x=1688735850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYupklKPpCKqKq19TrZNmrOzCG5CBVYGrgEKzSjksBw=;
        b=lkKPt8PKNplAmt0R731FPCqC1yCBFlrokiPJzxCh2kBpxL6FjKsQ5yod5LeRtyhmRM
         3wVI4u58AUn1KcV8ChQaAWqlyVXcKcv8v+yZ3WoNfyWVnCOSzGUsnbh7codBNCRe/bFV
         Gfxx1RdpQHWe4Yd/eHWpxEdux5f5WIWPnFkyIESQ3gocofxyEzCPDiPbrwvXjTUavalX
         6CC1jsdhcU5U3tD0CEwNKQkrRvSH6cERKkqLZXsk8yt12s/weWUEMGe5MsN2ek92ZM8H
         mqvvI3ASemV6NBETbcMzbOlo9Lv2VQVVAiqlt6ddl7MMxk1DAwbzOcgtkhd7oFSydtc5
         gHww==
X-Gm-Message-State: AC+VfDy9o7x1TZWmbLFQP459Y+iwVCEd0TwvmhNhmnLvoNDfLYiHTNgk
        wVP8w4QESfM16O4QiXZ4Ur/5pQ==
X-Google-Smtp-Source: ACHHUZ6A2Mv4i6a8CT5EZdOFavhuZd9JFWLbOlgPuVri5jEuN8Bi4i8e21JI9qcWVoyRIvzHEfIj8g==
X-Received: by 2002:a05:600c:204e:b0:3f6:d2f:27f7 with SMTP id p14-20020a05600c204e00b003f60d2f27f7mr4774242wmg.17.1686143849965;
        Wed, 07 Jun 2023 06:17:29 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:3a59:921c:4758:7db5? ([2a05:6e02:1041:c10:3a59:921c:4758:7db5])
        by smtp.googlemail.com with ESMTPSA id i10-20020a05600c290a00b003f60faa4612sm2154979wmd.22.2023.06.07.06.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 06:17:29 -0700 (PDT)
Message-ID: <05402205-bbe1-617c-d43e-205b0d238508@linaro.org>
Date:   Wed, 7 Jun 2023 15:17:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/8] net/mlx5: Update the driver with the recent thermal
 changes
Content-Language: en-US
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        thierry.reding@gmail.com, Sandipan Patra <spatra@nvidia.com>,
        Gal Pressman <gal@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:MELLANOX MLX5 core VPI driver" <netdev@vger.kernel.org>,
        "open list:MELLANOX MLX5 core VPI driver" 
        <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
 <20230525140135.3589917-2-daniel.lezcano@linaro.org> <ZHfF2kXIiONh6iDr@x130>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ZHfF2kXIiONh6iDr@x130>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 01/06/2023 00:10, Saeed Mahameed wrote:
> On 25 May 16:01, Daniel Lezcano wrote:
>> The thermal framework is migrating to the generic trip points. The set
>> of changes also implies a self-encapsulation of the thermal zone
>> device structure where the internals are no longer directly accessible
>> but with accessors.
>>
>> Use the new API instead, so the next changes can be pushed in the
>> thermal framework without this driver failing to compile.
>>
>> No functional changes intended.
>>
> 
> I see this patch is part of a large series, do you expect me to re-post to
> net-next or you are going to submit via another tree ?

Sorry for the delay.

Yes, this patch is targeted for the thermal tree. The last patch of the 
series depends on it as it moves the thermal zone device structure to 
the private thermal header, thus the structure internals won't be 
accessible from this driver anymore.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

