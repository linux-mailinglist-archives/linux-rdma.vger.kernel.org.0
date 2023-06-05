Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9280D723350
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 00:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjFEWph (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 18:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjFEWpg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 18:45:36 -0400
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EA099
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 15:45:33 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2b1a4be0ba1so10771171fa.0
        for <linux-rdma@vger.kernel.org>; Mon, 05 Jun 2023 15:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686005131; x=1688597131;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=WoKNs9AvDpgK2YtAS0rulf0rvStng1ALuSHVLVZvwFtiY/5CuWCIU8VNH9BJ94XaVj
         AfFDRoM043VSUGWbvLEMdWG235LTUHQczNILHSFlMVxA3P2N/OpmTP8SUWsUWt0lGBxD
         LaYabqLbc8m1NrNIjuL+z0C120myD5SM3678L2tmknBovfZjwLTtR5NoF5wPleJAFa7J
         5poglOG1C5lQESgjkGlmw0ClzpRIptUcz5PSM4KPiKf/F7TfcR+M4EnPmvPp8i2zesrP
         IC/DPgBVcQcoSX4eyvESCbzP43rEp+9wYn0ceJDebeHt9ps0VfD5kONo2eJP+fIjhpY3
         UlwQ==
X-Gm-Message-State: AC+VfDx+qVoAdh8eKNPPpWve+Ssrh0WEoFlqUyFPeVols8+jgsRdIvA5
        BSm6NluMbn2BP8hkZv/ZbuQ=
X-Google-Smtp-Source: ACHHUZ5tPrAv03RVCKpiaVe+ZZUDiZd/jl0pwInHvnhSHKLMlMbXjW9LVlvM1ft8cGUuFWnwibUGQw==
X-Received: by 2002:a05:651c:2cf:b0:2b1:ebdc:c477 with SMTP id f15-20020a05651c02cf00b002b1ebdcc477mr248317ljo.5.1686005131183;
        Mon, 05 Jun 2023 15:45:31 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id l1-20020a2e8341000000b002ad333df101sm1599849ljh.133.2023.06.05.15.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 15:45:30 -0700 (PDT)
Message-ID: <35783daa-da1f-5b23-e02a-1d4cf3a31fdf@grimberg.me>
Date:   Tue, 6 Jun 2023 01:45:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH for-rc 1/3] IB/isert: Fix dead lock in ib_isert
Content-Language: en-US
To:     Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
        selvin.xavier@broadcom.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
References: <20230601094220.64810-1-saravanan.vajravel@broadcom.com>
 <20230601094220.64810-2-saravanan.vajravel@broadcom.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230601094220.64810-2-saravanan.vajravel@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
