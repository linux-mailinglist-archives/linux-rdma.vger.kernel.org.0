Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EB94DC02B
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Mar 2022 08:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiCQHdR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Mar 2022 03:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiCQHdR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Mar 2022 03:33:17 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DE91C16EE
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 00:31:58 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id h23so5472441wrb.8
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 00:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eNf4DUwJ2Md/PYhuStbEUyYDVS2mtD+s1QR6ANqFQKU=;
        b=USACeVSR6DlBqPU91i16DpJEvIWWlrNeldwTZ2ETp1StilZm5KXsKGsu5CHMu03Rki
         QZknSYUV6Yqsf0u2GqR/KaBWxkaCE7BbTh/NxuBngZ3ScoeN7CwpQTIsZgmdxyvxtOBD
         0hw3hGpKIcUjd7CyNBg4LUBlooxRjl3JTA4Y7OceOA8wmTwoGOP39SjYLeQDLigjFeBq
         FS0zb/8c4BtzRjEqU2EulY0yQIjP4FTzhH+1ILXkjdji5i6yHLXxKAViZQMTHut435C/
         itihNUAFvpwzVicEXbVz2bAxnqIEtzsd9mxDgrSScnEI2mNvZJ0l2nXc2ZYMUBb2yQwT
         Rwcg==
X-Gm-Message-State: AOAM533l1v6jiNLQLBC/X49eJCqL+UPMWKglyyW+BAD3OjeNZfQfAb+H
        cfNX3tpmMEQCtAM2N40KRrv8Qusksas=
X-Google-Smtp-Source: ABdhPJya8/dI6OboPqz9H9gsXa2Z1VQU3KtrTif8YRwhUjg7Whr/trSlBGMhnSPuSJSSJ/KXbsHylA==
X-Received: by 2002:adf:8296:0:b0:203:e8bc:7337 with SMTP id 22-20020adf8296000000b00203e8bc7337mr1831193wrc.118.1647502317336;
        Thu, 17 Mar 2022 00:31:57 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b00380deeaae72sm5615417wmb.1.2022.03.17.00.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 00:31:56 -0700 (PDT)
Message-ID: <3a07e1ea-c57a-5589-be8c-bb3613d4c669@grimberg.me>
Date:   Thu, 17 Mar 2022 09:31:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/4] IB/iser: fix error flow in case of registration
 failure
Content-Language: en-US
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
Cc:     oren@nvidia.com, sergeygo@nvidia.com, israelr@nvidia.com,
        leonro@nvidia.com
References: <20220308145546.8372-1-mgurtovoy@nvidia.com>
 <20220308145546.8372-5-mgurtovoy@nvidia.com>
 <f3e1200b-1375-0a5e-7b56-3c1565576cf5@grimberg.me>
 <61e7094d-e645-f6d4-d267-3f0b86404879@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <61e7094d-e645-f6d4-d267-3f0b86404879@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>> During READ/WRITE preparation, in case of failure in memory registration
>>> using iser_reg_mem_fastreg we must unmap previously mapped iser task.
>>>
>>> Reviewed-by: Sergey Gorenko <sergeygo@nvidia.com>
>>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>
>> Looks good,
>> Acked-by: Sagi Grimberg <sagi@grimberg.me>
>>
>> Doesn't this need a fixes tag?
> 
> I'm not sure.
> 
> I see this issue from iSER in 2006 (commit e85b24b5e7de9 - IB/iser: iSER 
> initiator iSCSI PDU and TX/RX).

Hmm... ok
