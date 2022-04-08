Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0F94F8B1F
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 02:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiDHAJF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Apr 2022 20:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiDHAJE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Apr 2022 20:09:04 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D9D2A33B8
        for <linux-rdma@vger.kernel.org>; Thu,  7 Apr 2022 17:07:02 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id q19so6336330pgm.6
        for <linux-rdma@vger.kernel.org>; Thu, 07 Apr 2022 17:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O1F0Rga4shJfbu/xEg0lrLwUsMW/rbQnyjvbz0KIRsA=;
        b=pphtGKbvo8uONYoyXhEXqsy58+i784E1JNDL1shquyd5A7WurgrIc3qLekVfbO1UGD
         POYfiKdRztdkx7zwtw/98RF0y87JXRV6pCg3z3xg1YjI6KnZO9E2TXqFG5TZg8Xge1aV
         sauEKMOOXHrWtZJlIZyTVjhA6Ac3EME5UxqjzSU+xWTc1iNNVSYzM+VZ3np6ADybRuVm
         mPVmyXXwe86TUgsNmWZ6NwEWXfjlHmA+rmGLXJxALmnXE02rGI6IYcEHixAYkEI8r7Ty
         irz58TcgLqVvpnvE3LfwmyDoTLwUNFgIBj0YE5HMmhdVk6m6JG1Qm9DhnxYpKijfsKGN
         sYWg==
X-Gm-Message-State: AOAM5325/fWHlk8vwoxn+CSJyhRfn7ybHuTYatd+WbKYK/038VG88UYu
        +8la0f74U+GQLVsCj1xgn7g=
X-Google-Smtp-Source: ABdhPJzH2sEZNpqBXnMJAWdVnL/cwRL/DDS98iXjQyjfabVGTJrVB1hfDoP64tqe8uCpL374pbQzZQ==
X-Received: by 2002:a65:4b85:0:b0:399:8cd:5270 with SMTP id t5-20020a654b85000000b0039908cd5270mr13025472pgq.418.1649376421805;
        Thu, 07 Apr 2022 17:07:01 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id q9-20020a638c49000000b00398677b6f25sm20251144pgn.70.2022.04.07.17.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 17:07:01 -0700 (PDT)
Message-ID: <fd17d243-f98f-517e-0344-60fe4e326728@acm.org>
Date:   Thu, 7 Apr 2022 17:06:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [bug report] rdma_rxe: WARNING: inconsistent lock state,
 inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>
References: <CAHj4cs-MT13RiEsWXUAcX_H5jEtjsebuZgSeUcfptNVuELgjYQ@mail.gmail.com>
 <1c16f053-0183-8343-9b36-62027c7260a8@acm.org>
 <CAFc_bgZ5oYtK2doybVT5fhrU+Ut-RfPT+g2z1bbf9V3jTtRTUg@mail.gmail.com>
 <d80141c8-04ee-e6ed-34d8-5cf43b49fd55@acm.org>
 <ca8722e6-db2d-0ab1-b8af-0932017df23e@gmail.com>
 <f7b84702-8001-70bf-2f26-704548b96279@acm.org>
 <92181dc8-dadc-3df6-3ecc-e2dca9047be4@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <92181dc8-dadc-3df6-3ecc-e2dca9047be4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/7/22 15:34, Bob Pearson wrote:
> It looks like on 5.18-rc1+ blktest is not running for me. (Last time I ran it was pre 5.18)
> I am not seeing the Warning but instead it just hangs? Are you enabling some lock checking
> that I am not? If so how?

Hi Bob,

The warning shown in the email at the start of this thread has been 
reported by lockdep. I think that you will need to enable at least the 
following in the kernel configuration:

CONFIG_LOCKDEP=y
CONFIG_PROVE_LOCKING=y

Thanks,

Bart.
