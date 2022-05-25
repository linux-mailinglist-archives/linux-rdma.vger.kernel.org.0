Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82012534357
	for <lists+linux-rdma@lfdr.de>; Wed, 25 May 2022 20:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbiEYSvF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 May 2022 14:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbiEYSu5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 May 2022 14:50:57 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6D9AEE25
        for <linux-rdma@vger.kernel.org>; Wed, 25 May 2022 11:50:56 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id n10so43457504ejk.5
        for <linux-rdma@vger.kernel.org>; Wed, 25 May 2022 11:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=b8S6KpSx/8UCHrqKd2wB9qrGCuIDtz1tHvkaQqSRUOc=;
        b=C6o9uyjqdGfipB8Zs7tkP6XYgv3CiXlaT5Q08pdBxAWQqGRItLnpQXooYRnqWC2gqK
         /UGjqnYzbuIF2Fc30FpJoRrDbBjZhhTdsuPJJQlVW8rHBYJexDf/e/ztpy3qZw5L3b4d
         bT8M2+VFfLdBNqKVpfR1ZCN8VYKLppPM/Y+TdC5mVCYxLNtQysxjo+Z04HBdzTKOwz9q
         onKCC+HsHZsrgH7oODDGeazLnzlUnyrHizf1t0DVNbChLQ6qMmw46DERAxdyGbqUTTWl
         nP76uRdKtk19E/toTE43O9Znw1nFOYYJidbbWw0ZLRyZWS3Iy5HJm8Sxqmkkl1sVyM/A
         tRoA==
X-Gm-Message-State: AOAM533IYzdYcMekidXYK2UzTmnaR+09Ct/e2FUtwmqMyf9Mkyty9tYo
        Mj0h7YMSAMJFqtom4FUpyDY=
X-Google-Smtp-Source: ABdhPJw7cmZQR3z2aQG987BTdUWi824dKt19/XjqgPfnr4e7WbcP46wlyBipPTdRYEUwkVFlY8AuSQ==
X-Received: by 2002:a17:907:1c8a:b0:6e9:2a0d:d7b7 with SMTP id nb10-20020a1709071c8a00b006e92a0dd7b7mr30123374ejc.572.1653504654548;
        Wed, 25 May 2022 11:50:54 -0700 (PDT)
Received: from [192.168.50.14] (178-117-55-239.access.telenet.be. [178.117.55.239])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b006ff0fe78cb7sm877215ejc.133.2022.05.25.11.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 11:50:53 -0700 (PDT)
Message-ID: <4f15039a-eae1-ff69-791c-1aeda1d693df@acm.org>
Date:   Wed, 25 May 2022 20:50:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
 <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/25/22 13:01, Sagi Grimberg wrote:
> iirc this was reported before, based on my analysis lockdep is giving
> a false alarm here. The reason is that the id_priv->handler_mutex cannot
> be the same for both cm_id that is handling the connect and the cm_id
> that is handling the rdma_destroy_id because rdma_destroy_id call
> is always called on a already disconnected cm_id, so this deadlock
> lockdep is complaining about cannot happen.
> 
> I'm not sure how to settle this.

If the above is correct, using lockdep_register_key() for 
id_priv->handler_mutex instead of a static key should make the lockdep 
false positive disappear.

Thanks,

Bart.
