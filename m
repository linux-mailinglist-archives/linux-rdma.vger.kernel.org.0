Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555FA6D0751
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 15:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjC3NwN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 09:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjC3NwM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 09:52:12 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7F65FEC
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 06:52:10 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id t4so13930346wra.7
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 06:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680184329; x=1682776329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=D6iQIr8p9vLAuu8u/2gkvEH0hfvfpQbTSAKfIT0x4twSFVk7YeJ2WnD6Bu4khaPSc4
         cB6ZCHHQ/6QnraXROLzeHlrFq/sZ56rIHNf7K1zfZTIFlBCUJDJP3SOPaAVtP5QZpdok
         ZXGaOxgLUe3nCW6RUkh4hXgT/221F6A3PeO3tYn29uNQd9u6huv0xpM7jxe57xMGS5Gx
         6FE3DgMaHOLFZA1jypVpAQerYFNPCezdT5HDvpvvy6B/bK3cfTxjO8z0MrZbsJ9yR/6n
         lkVmeKDa017IICCk5elEtAl7qCj7AyA9gZYRh+EegiTB32iSZ+6EDBfkaojXHAcc3u/o
         GYcg==
X-Gm-Message-State: AAQBX9cWJ1B7pBA32pb4KprsYADfdka9YEJA0aVe/+tsWvJ9oDV98EVs
        BJabfRzff50sMPW48QRF9/D2OLkvWuo=
X-Google-Smtp-Source: AKy350Z1qS+IWspo1D7iNkcSlLAhMgaTi3BZ8LGGQssIT063LrM+RLSTViiSUNcXj1PJnLOP6t9E+w==
X-Received: by 2002:a5d:49c4:0:b0:2ca:ab68:eff9 with SMTP id t4-20020a5d49c4000000b002caab68eff9mr12734300wrs.7.1680184328987;
        Thu, 30 Mar 2023 06:52:08 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id a4-20020adffb84000000b002d322b9a7f5sm32872522wrr.88.2023.03.30.06.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 06:52:08 -0700 (PDT)
Message-ID: <5abe0431-80b3-8280-34f1-49a1da31cd3f@grimberg.me>
Date:   Thu, 30 Mar 2023 16:52:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/3] IB/iser: remove redundant new line
Content-Language: en-US
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, leonro@nvidia.com,
        linux-rdma@vger.kernel.org, jgg@nvidia.com
Cc:     israelr@nvidia.com, oren@nvidia.com, sergeygo@nvidia.com
References: <20230330131333.37900-1-mgurtovoy@nvidia.com>
 <20230330131333.37900-3-mgurtovoy@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230330131333.37900-3-mgurtovoy@nvidia.com>
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
