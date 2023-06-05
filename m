Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77438723374
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 01:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjFEXBK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 19:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjFEXBJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 19:01:09 -0400
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6271B94
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 16:01:08 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4f61307827cso654850e87.1
        for <linux-rdma@vger.kernel.org>; Mon, 05 Jun 2023 16:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686006067; x=1688598067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcdG1XdA8XnrnFa9/zZB6Q7Yu71aAFsf31yr3Vd3+3k=;
        b=fPhvkvab68O73FpGU1pdFrvMjs6vMIPv/ZjkOUgoksSrvmyy36oZdPJpDrFuBBaYFa
         VWLTqp2F8rpJqNmuOQkuNIFee+YonVrJy0OtfXcrxCCykd/2zsNKrTmC+tC+GLTQ5ruS
         RNrc8sPLDA2m2m1Tm2eDia6HjdaIpmVy+6ex/ACZ4Nql37m4u8XzSpXCdSNFWMyw0N0s
         tuPqDlMXvS7LMwbiJ/QbWCywY4UM36qFZAjv5ULYgirLBoBb1wyb55RJ8L0pda/m0mot
         je5MiQoFtWFlIMMnAjRuTCEF3d4vpUQJ86Sqabc5/EFiapI0kRMh5di/vGE9D1hOEn59
         szRA==
X-Gm-Message-State: AC+VfDwyy0EurLyZAr2J0OcHTtuRBUX5B4XoREpyP8H7PwE3GGVbYXG+
        gOO9nTXeVo74aRR/8sO1pkY=
X-Google-Smtp-Source: ACHHUZ72eyIUbhKoNDoPk0vcakKw9lHDP1Lf/ZUIDhkt85YTOy+WpgALmUD8nldfFIZbrs5eupivEA==
X-Received: by 2002:a2e:aa1c:0:b0:2b1:a69e:6a8e with SMTP id bf28-20020a2eaa1c000000b002b1a69e6a8emr301259ljb.3.1686006066563;
        Mon, 05 Jun 2023 16:01:06 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id z19-20020a2e8853000000b002af15f2a735sm1623369ljj.111.2023.06.05.16.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 16:01:06 -0700 (PDT)
Message-ID: <09504ea7-186d-9ede-e01f-87849673b9b2@grimberg.me>
Date:   Tue, 6 Jun 2023 02:01:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] Revert "IB/core: Fix use workqueue without
 WQ_MEM_RECLAIM"
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Maurizio Lombardi <mlombard@redhat.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org, parav@mellanox.com
References: <20230523155408.48594-1-mlombard@redhat.com>
 <20230523182815.GA2384059@unreal>
 <CAFL455m3T4qrk0Uf5qK7-57Oh6L6AKionfs0mF-imUMYpbqBOg@mail.gmail.com>
 <ZHebeWlpn68Xa1Hd@ziepe.ca>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZHebeWlpn68Xa1Hd@ziepe.ca>
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


>>>> workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_rdma_reconnect_ctrl_work
>>>> [nvme_rdma] is flushing !WQ_MEM_RECLAIM ib_addr:process_one_req [ib_core]
>>>
>>> And why does nvme-wq need WQ_MEM_RECLAIM flag? I wonder if it is really
>>> needed.
>>
>> Adding Sagi Grimberg to cc, he probably knows and can explain it better than me.
> 
> We already allocate so much memory on these paths it is pretty
> nonsense to claim they are a reclaim context. One allocation on the WQ
> is not going to be the problem.
> 
> Probably this nvme stuff should not be re-using a reclaim marke dWQ
> for memory allocating work like this, it is kind of nonsensical.

A controller reset runs on this workqueue, which should succeed to allow
for pages to be flushed to the nvme disk. So I'd say its kind of
essential that this sequence has a rescuer thread.
