Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B97A5223F9
	for <lists+linux-rdma@lfdr.de>; Tue, 10 May 2022 20:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245415AbiEJS24 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 May 2022 14:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244905AbiEJS2z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 May 2022 14:28:55 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E94222C12;
        Tue, 10 May 2022 11:28:53 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id c9so16792076plh.2;
        Tue, 10 May 2022 11:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=2VCAe3+5d6v1gJ9JUTUSueBETGStDd1QrI+SfUX7SoXKOxuWoF5p5s5rFjUco4drHV
         vJrNBHac0y1TBrEJmT9bef1Zy2sx7kOa00JZ/Li+F6JQswU1x4ip2Oq/2cECVwQC5wpO
         eZZQUuggoR7UcQKL29XmTEc4427gOXNuL16UALxjeiGNff/L2y88o+5qNq2dRxGVzpoK
         xXiqxc44sSqniCtxvzayXdnohreduIDJWF4UepJDXjC4HeWVz9ocWLWfkvfaSm8Zf9h1
         7QymYy7TW5hLu7BedqTF1fZ3CI6AqZw+13v9IusBZGGUjUjxkot4FqCDLHDO0jC68P/O
         Gt3g==
X-Gm-Message-State: AOAM533RUvrkNrOz1ohfEoXKuxqksu0xAMrvNasinft5DhYnMLIHSpOO
        KMRqYPdzwjT5gUk6SNQONa4=
X-Google-Smtp-Source: ABdhPJxmCDW6ahpwx9iYz9rrpsjvWGYh75/sFM6vutBMoA3/sKLVKx2FlkJLCXb8Y5/lE5D9Dm9mNA==
X-Received: by 2002:a17:902:d2d1:b0:15e:9b06:28b3 with SMTP id n17-20020a170902d2d100b0015e9b0628b3mr22212124plc.148.1652207333267;
        Tue, 10 May 2022 11:28:53 -0700 (PDT)
Received: from [172.16.228.60] ([65.122.177.243])
        by smtp.gmail.com with ESMTPSA id bh2-20020a170902a98200b0015e8d4eb2d2sm2343362plb.284.2022.05.10.11.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 11:28:53 -0700 (PDT)
Message-ID: <3cb0c6bc-0c79-77d2-a892-2492d10a7bcc@grimberg.me>
Date:   Tue, 10 May 2022 11:28:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] IB/isert: Avoid flush_scheduled_work() usage
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>,
        target-devel@vger.kernel.org
References: <fbe5e9a8-0110-0c22-b7d6-74d53948d042@I-love.SAKURA.ne.jp>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <fbe5e9a8-0110-0c22-b7d6-74d53948d042@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
