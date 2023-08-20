Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC8E781E5F
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Aug 2023 16:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjHTOtq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Aug 2023 10:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjHTOtl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Aug 2023 10:49:41 -0400
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF9F10EB
        for <linux-rdma@vger.kernel.org>; Sun, 20 Aug 2023 07:46:16 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2b73261babdso6708261fa.1
        for <linux-rdma@vger.kernel.org>; Sun, 20 Aug 2023 07:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692542775; x=1693147575;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m8Qao4qQOvjVD/ojYjHUfRV6uA1bkcdh/o7m3a4cOeY=;
        b=H/6lIH2hwe0/dZWRbt1e9/EdShwl14uB5GssEgC2E3CWTEgzSdxVKqIPooNYZmOlT9
         7f0+GihcIuaHh25Doc/01sR7oYvaIHQf/bKonNmHl7uIjsOfkOJNCiPcJPP3ubpm1bj1
         H+UcVCHG8XkPCAruHfGzB28kMEmPCdckp/YPkMQvlIakMevMgMEnUHggEyCgOivy5VQX
         SbxN4ssF5dSpKKSfc+4/jbJCrINfQWXcsmaKoTlNYaPC3S8AUY6vE06Lzosxu7A222mN
         9BfuKTjq29Dq3bxa7XKvSZj3QEF0MPfYDBTJYq/PoFrQ7rxC5k+6l7+1L6Wf7806+i0N
         nR5Q==
X-Gm-Message-State: AOJu0YxSn2IVZ4eHRx2nmOaOGNGgYSRQP8bUpdCB/yPay6ckeQ5aQ7PW
        UXk4jwOtsFyXBpvAyEkISr7fJbL7mtk=
X-Google-Smtp-Source: AGHT+IGmER08Xs9MSW1VX3bmQyteR5VRo3js/RY7v1r7d6P8uIlkX0UbEUXSR4I/XqXnyuTfG484lg==
X-Received: by 2002:a2e:bc04:0:b0:2b6:cd7f:5ea8 with SMTP id b4-20020a2ebc04000000b002b6cd7f5ea8mr3679824ljf.1.1692542774520;
        Sun, 20 Aug 2023 07:46:14 -0700 (PDT)
Received: from [10.100.102.14] (46-116-234-112.bb.netvision.net.il. [46.116.234.112])
        by smtp.gmail.com with ESMTPSA id r23-20020a170906351700b0098951bb4dc3sm4722768eja.184.2023.08.20.07.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 07:46:14 -0700 (PDT)
Message-ID: <4a628865-d555-4b60-3fc7-4675bb40af62@grimberg.me>
Date:   Sun, 20 Aug 2023 17:46:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: isert patch leaving resources behind
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        saravanan.vajravel@broadcom.com
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>,
        Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
References: <921cd1d9-2879-f455-1f50-0053fe6a6655@cornelisnetworks.com>
 <20230813082931.GD7707@unreal> <20230820094622.GD1562474@unreal>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230820094622.GD1562474@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>> Commit: 699826f4e30a ("IB/isert: Fix incorrect release of isert connection") is
>>> causing problems on OPA when we try to unload the driver after doing iSCI
>>> testing. Reverting this commit causes the problem to go away. Any ideas?
>>
>>
>> Saravanan, can you please post kernel logs as you wrote "When a bunch of iSER target
>> is cleared, this issue can lead to use-after-free memory issue as isert conn is twice
>> released" in the reverted commit?
> 
> So what is the resolution here?

We need saravanan to address the reported resource leak upon
DEVICE_REMOVAL. If this stalls, I suggest we revert the offending
commit and add it again without any leaks on surprise hca removals.
