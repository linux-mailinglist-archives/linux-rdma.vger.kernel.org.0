Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E599B4B4F22
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Feb 2022 12:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352458AbiBNLpi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Feb 2022 06:45:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352456AbiBNLjv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Feb 2022 06:39:51 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21B31FA4B
        for <linux-rdma@vger.kernel.org>; Mon, 14 Feb 2022 03:32:05 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so10612537wml.5
        for <linux-rdma@vger.kernel.org>; Mon, 14 Feb 2022 03:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6tZxi9wSFHsRxcU826+Mko/UMT+85arEzrSGpQkyu64=;
        b=W/5tr72YcymZ6lGQ26SApa84tjXTLDSCqngoyYhXkBXf+5xCkL0X6plmb4P7Jfzkme
         C77irvJQ2MpXzUm65GFv//OzNSZ+t5fgVy+hNqwJvTQLYSQfP/NGmR5twdQmJuXD9P9Y
         WXXnCyYmxDJKe43XrarE4vs7QtL5H0t14CQa9q40pLLWufRRoeL0hPPuNNOu8t0SmUrt
         00yxQ7qquqLyIGat9BV53lpgFBYGPbyw18pcZCq7+3ZahdQBfCfE2tkNm/EZh+KnqfRI
         9QIp+/r8VfocTcWD+ukTLDUzTjrWAaaSmgddPBXcGOxaHFwxV+yeelAxtIh05fsVC+mf
         e+zw==
X-Gm-Message-State: AOAM532DFk0lykmULzkgwSTSiVQueJT/RjYoy/UB0n+T4KKuKBc4Y7Rl
        L73ZTzwwi72uT58byKV/RuckTGIKaT0=
X-Google-Smtp-Source: ABdhPJx/OrVMF3Zg1Y1tU5iNcRfARJfI6rU6d2UIlVFLkTLfqcTBhieez7VFcsmrhr5kg9+UFf1i/Q==
X-Received: by 2002:a7b:c351:: with SMTP id l17mr10558590wmj.54.1644838324105;
        Mon, 14 Feb 2022 03:32:04 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o14sm32992182wry.104.2022.02.14.03.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 03:32:03 -0800 (PST)
Message-ID: <a2fabeb3-5f19-11b6-8c00-a479e3759182@grimberg.me>
Date:   Mon, 14 Feb 2022 13:32:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Haakon Bugge <haakon.bugge@oracle.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <9f115198-bafc-be4e-1c90-06444b8a37f6@grimberg.me>
 <CAHj4cs8wBwDGhhtEPodyBdR-sCqJLYhwLhNHuPDm+KCan0hwWg@mail.gmail.com>
 <42ccd095-b552-32f7-96b0-d34d46f7c83e@grimberg.me>
 <CAHj4cs9EazUmtbjPKp5TXO4kRPcSShiYbhmsHwfh7SOTQAeoyw@mail.gmail.com>
 <c6d43a10-44bc-e73a-8836-d75367df049b@grimberg.me>
 <162ec7c5-9483-3f53-bd1c-502ff5ac9f87@nvidia.com>
 <CAHj4cs_kCorBjHcvamhZLBNXP2zWE0n_e-3wLwb-ERfpJWJxUA@mail.gmail.com>
 <3292547e-2453-0320-c2e7-e17dbc20bbdd@nvidia.com>
 <CAHj4cs9QuANriWeLrhDvkahnNzHp-4WNFoxtWi2qGH9V0L3+Rw@mail.gmail.com>
 <fcad6dac-6d40-98d7-93e2-bfa307e8e101@nvidia.com>
 <CAHj4cs_WGP9q10d9GSzKQZi3uZCF+S8qW1sirWZWkkHuepgYgQ@mail.gmail.com>
 <2D31D2FB-BC4B-476A-9717-C02E84542DFA@oracle.com>
 <CAHj4cs-yt1+Lufqgwira-YbB6PHtJ=2JA_Vora_CfarzSzoFrA@mail.gmail.com>
 <4BB6D957-6C18-4E58-A622-0880007ECD9F@oracle.com>
 <CAHj4cs_ta5WR7j0qvHyr1tSCR-U7=svY5j8Hctd7YUMNcGXsaA@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs_ta5WR7j0qvHyr1tSCR-U7=svY5j8Hctd7YUMNcGXsaA@mail.gmail.com>
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


> Hi Sagi/Max
> Here are more findings with the bisect:
> 
> The time for reset operation changed from 3s[1] to 12s[2] after
> commit[3], and after commit[4], the reset operation timeout at the
> second reset[5], let me know if you need any testing for it, thanks.

Does this at least eliminate the timeout?
--
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a162f6c6da6e..60e415078893 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -25,7 +25,7 @@ extern unsigned int nvme_io_timeout;
  extern unsigned int admin_timeout;
  #define NVME_ADMIN_TIMEOUT     (admin_timeout * HZ)

-#define NVME_DEFAULT_KATO      5
+#define NVME_DEFAULT_KATO      10

  #ifdef CONFIG_ARCH_NO_SG_CHAIN
  #define  NVME_INLINE_SG_CNT  0
--

> 
> [1]
> # time nvme reset /dev/nvme0
> 
> real 0m3.049s
> user 0m0.000s
> sys 0m0.006s
> [2]
> # time nvme reset /dev/nvme0
> 
> real 0m12.498s
> user 0m0.000s
> sys 0m0.006s
> [3]
> commit 5ec5d3bddc6b912b7de9e3eb6c1f2397faeca2bc (HEAD)
> Author: Max Gurtovoy <maxg@mellanox.com>
> Date:   Tue May 19 17:05:56 2020 +0300
> 
>      nvme-rdma: add metadata/T10-PI support
> 
> [4]
> commit a70b81bd4d9d2d6c05cfe6ef2a10bccc2e04357a (HEAD)
> Author: Hannes Reinecke <hare@suse.de>
> Date:   Fri Apr 16 13:46:20 2021 +0200
> 
>      nvme: sanitize KATO setting-

This change effectively changed the keep-alive timeout
from 15 to 5 and modified the host to send keepalives every
2.5 seconds instead of 5.

I guess that in combination that now it takes longer to
create and delete rdma resources (either qps or mrs)
it starts to timeout in setups where there are a lot of
queues.
