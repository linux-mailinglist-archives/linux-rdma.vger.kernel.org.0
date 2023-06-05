Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E218723359
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 00:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjFEWvt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 18:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjFEWvt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 18:51:49 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1259BD9
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 15:51:48 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4f60924944aso830295e87.0
        for <linux-rdma@vger.kernel.org>; Mon, 05 Jun 2023 15:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686005506; x=1688597506;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R9ltrQCC2RRygDfX31U5BQpeH9XFlXJrloFRrScVD1Q=;
        b=lmzlgT9RmLwIsceR1pAyOg8Xu8joC8nJQndFdIkvME+ig2jKaRTj6MUyvyv7aZTyBF
         AKOxyAcA//s66MYumpPhFfZCE87mTduzDp7JsEcAEqDeOwEKqeUvxmhjEdQEo34wVvrz
         gJYVy4sAV9YhZK88AvfQKZYH6XZn9ohydCmzKqUQCbI3YyAE82ECVz8bgDoWTYS9NpF1
         a2wB6Vhp2YwEA72LkcgJUW5ZEROtqh3PRYKYA1I1RZZH6uzxzgg0ou+E1xPv7/vAw47c
         rSF57Nsjg1tMqM0Pmsj4VMtEY0kmUpJGyT4L/NOZA5cJPONdYPvBSosqWD7yNf755ody
         2XsA==
X-Gm-Message-State: AC+VfDyqyWDquoVbcS30v2DUTiyGwFd5hnD4CNjX/O6tZja/ldSYA5d9
        oJLn2oLRnuhmKYdtlI0Tx0z3XQoInBg=
X-Google-Smtp-Source: ACHHUZ5EuQ06SNMAdRRnmxgnRegdQknhpr/+s+u2QthCZt58VERSgEDeeiNjl/+SWZ8zt+RxGLLBmg==
X-Received: by 2002:a19:5518:0:b0:4f3:b297:909e with SMTP id n24-20020a195518000000b004f3b297909emr134447lfe.3.1686005506240;
        Mon, 05 Jun 2023 15:51:46 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id h18-20020a197012000000b004f382ae9892sm1272551lfc.247.2023.06.05.15.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 15:51:45 -0700 (PDT)
Message-ID: <18746527-515b-d89b-df8b-cab4205b78e3@grimberg.me>
Date:   Tue, 6 Jun 2023 01:51:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH for-rc 3/3] IB/isert: Fix incorrect release of isert
 connextion
Content-Language: en-US
To:     Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
        selvin.xavier@broadcom.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
References: <20230601094220.64810-1-saravanan.vajravel@broadcom.com>
 <20230601094220.64810-4-saravanan.vajravel@broadcom.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230601094220.64810-4-saravanan.vajravel@broadcom.com>
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


typo in commit title.


Other than that,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
