Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A2F5B0400
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 14:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiIGMea (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 08:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIGMe3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 08:34:29 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76545FED
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 05:34:25 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id d2so3078165wrn.1
        for <linux-rdma@vger.kernel.org>; Wed, 07 Sep 2022 05:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IHUUK7beoCDrD2jFmK3WDA+beuDUZr34Z9gNGBPS0BU=;
        b=Fy1hhBXnUbh4C6SxDXqMqtdul96s+TqPddpjpxSiw6Qus1hybyA4EuQsp1qCN+ppUq
         JMwItx4Rn7wEudR3ua6e6sFUUv7YdTuhq7qnb8Se47rAnEmUnPoa904bMVF8u97Iz9VT
         QTzyHsAHy6ZeHNmcmehCv5OfDMPmpfZimaaJn9pangVYmkarvtSpbBeiP4EMt0CoeqF9
         39wJNRBDn/A6K5o7obcYqZpWKT83mtI0sfF2RyyYFugikpmy9oXgQHLuuRloE7oI+F/G
         ezy9O1LhxD3nSf9P4qAfJFYSUAAde+6Jk+AwNbYg2nxDuBofNFn8kb++vWUHshved/Vo
         j4EQ==
X-Gm-Message-State: ACgBeo189GWfg6pUqgzBSTgOuttmXaJiv+ClEzda6/zCaJoNRtBad1qJ
        +s7XXPPkf6M5xV2rM3C2Iac=
X-Google-Smtp-Source: AA6agR4wLQW7dtCpR9Gg8nJQNsRYuycnoQk0AyjEL/QKRdATPfo47Vttlulr/xROmlbxeRbpx2muDg==
X-Received: by 2002:adf:ea05:0:b0:229:9c4c:ec78 with SMTP id q5-20020adfea05000000b002299c4cec78mr1191200wrm.213.1662554063872;
        Wed, 07 Sep 2022 05:34:23 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bd17-20020a05600c1f1100b003a540fef440sm26671091wmb.1.2022.09.07.05.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 05:34:23 -0700 (PDT)
Message-ID: <facc31c4-955e-c82e-191b-150313e73f6a@grimberg.me>
Date:   Wed, 7 Sep 2022 15:34:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rdma-next 4/4] nvme-rdma: add more error details when a QP
 moves to an error state
Content-Language: en-US
To:     Patrisious Haddad <phaddad@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Israel Rukshin <israelr@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-nvme <linux-nvme@lists.infradead.org>,
        linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20220907113800.22182-1-phaddad@nvidia.com>
 <20220907113800.22182-5-phaddad@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220907113800.22182-5-phaddad@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> From: Israel Rukshin <israelr@nvidia.com>
> 
> Add debug prints for fatal QP events that are helpful for finding the
> root cause of the errors. The ib_get_qp_err_syndrome is called at
> a work queue since the QP event callback is running on an
> interrupt context that can't sleep.
> 
> Signed-off-by: Israel Rukshin <israelr@nvidia.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

What makes nvme-rdma special here? Why do you get this in
nvme-rdma and not srp/iser/nfs-rdma/rds/smc/ipoib etc?

This entire code needs to move to the rdma core instead
of being leaked to ulps.
