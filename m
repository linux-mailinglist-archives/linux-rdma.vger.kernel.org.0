Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E6F6C4B38
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Mar 2023 14:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjCVNAN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Mar 2023 09:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjCVNAM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Mar 2023 09:00:12 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945991E9F7;
        Wed, 22 Mar 2023 06:00:11 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso1645271wms.1;
        Wed, 22 Mar 2023 06:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679490010; x=1682082010;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wlUlfJH2jEDcVl2IXNvhN66n7VhhkTLFG1ri1AhZ96E=;
        b=473hVc6yM2m0Yf+aRomm+/PDG5Gl5DPMp9Gk1bkkvNv/GW42m4wyqvHEEb+nsVz5Ah
         XTEkZSVK8vAuVTa8Bdz1xQoy4MVttSJU6rA1jduzq9Jki8i8dn0hmxqcDZT+bLJKoGhL
         KY1jMPHAWqA7sv0ri9wfMbxfRMzMkyQwPCFaORGRaI+/ASVpz145NUb5nOPG4tyUfegB
         6oBXy28tkWjTxI1Juj9j+DUnEz0RmLfT8I1GvvnHBc19qBXz/HE7PzaBzReV+E0eKC9t
         VEhKJt4EqBlXcYJXFMeHgWNi5uPTqqjhCeX6LtIPhP7KoIwmazD7+AqPjBJz8iFU0tJN
         ugjw==
X-Gm-Message-State: AO0yUKUo2JTiYRCUTbTNRzZCZlFEOgDPc2aC0CP3pOH3ehMfldxUdIiH
        kySxs1hlesvnu6RSEePAOynWKoGgQIs=
X-Google-Smtp-Source: AK7set+3oUSz7A4kh2FyzoQg9sqDXCoYN+c+BOuSNV8kIVgOcTlwAFyKWAkkyKCNyFAx1AjCmCWoXg==
X-Received: by 2002:a05:600c:4ec7:b0:3e9:b564:fae4 with SMTP id g7-20020a05600c4ec700b003e9b564fae4mr5917655wmq.0.1679490009972;
        Wed, 22 Mar 2023 06:00:09 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c16-20020adffb50000000b002c56179d39esm13829688wrs.44.2023.03.22.06.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 06:00:09 -0700 (PDT)
Message-ID: <c51d3d99-5bc9-cb47-6efa-5371ef3cc0f4@grimberg.me>
Date:   Wed, 22 Mar 2023 15:00:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma devices
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-rdma@vger.kernel.org
References: <20230322123703.485544-1-sagi@grimberg.me>
 <ZBr6kNVoa5RbNzSa@ziepe.ca>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZBr6kNVoa5RbNzSa@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> No rdma device exposes its irq vectors affinity today. So the only
>> mapping that we have left, is the default blk_mq_map_queues, which
>> we fallback to anyways. Also fixup the only consumer of this helper
>> (nvme-rdma).
> 
> This was the only caller of ib_get_vector_affinity() so please delete
> op get_vector_affinity and ib_get_vector_affinity() from verbs as well

Yep, no problem.

Given that nvme-rdma was the only consumer, do you prefer this goes from
the nvme tree?
