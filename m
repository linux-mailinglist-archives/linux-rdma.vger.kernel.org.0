Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E274E234B
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Mar 2022 10:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiCUJ1Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Mar 2022 05:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345883AbiCUJ1P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Mar 2022 05:27:15 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E68145986
        for <linux-rdma@vger.kernel.org>; Mon, 21 Mar 2022 02:25:49 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id v130-20020a1cac88000000b00389d0a5c511so9902411wme.5
        for <linux-rdma@vger.kernel.org>; Mon, 21 Mar 2022 02:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VQQ+KlOOnrLM/du+TmR4nLav7zEu/ca3hcikeuCO5QA=;
        b=VzgLyEq2vzJ4TbdTCXLa8rN6z1Q3c+gkezdzYYXo0C7L5Cb2E3y7ouOGCH0I+S6T3Q
         ovvJWQxX3OgJq6zu23wMKzBadQMbAKZfS80r5pYdAjHwzcohVDvAm4ZIJc+Kqmp2m7S9
         mWPn/IjTJDenAwRcrjiPdwpvNA8ENhS+8tdWM+fo6ytCAqayYW6CbV6b2+oeny4D+k2e
         9XnsBsyZkHX7jC7pyW+fuljpwd+BNHBoYeQ5baJcOIRJWDN6D4Of7k3vjvTPn9eLtXf5
         66PCM9GRYHbNdxGV5aFA91lBO93rAEXD/V7ZPYTTZSpzwKv2niuotTBi8nRzf8aDEtgt
         +8cQ==
X-Gm-Message-State: AOAM531Wz6rAWMyCBm/v6S9WAjvptnf6kwaLkYSQCm49Fh9M/EnFbct2
        Z0Mf1+qhEUoEeRmhDeqfvkytcv//v8s=
X-Google-Smtp-Source: ABdhPJyWGw7fBs/UstS01IgddaGlIWMcCEeHDy2ZBWm7IC1RXkZa+0f2WnzuFrn+Vtcwedip9+2F4g==
X-Received: by 2002:a05:600c:3ac3:b0:38c:8b84:52ee with SMTP id d3-20020a05600c3ac300b0038c8b8452eemr12774274wms.93.1647854748032;
        Mon, 21 Mar 2022 02:25:48 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm14630988wms.25.2022.03.21.02.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 02:25:47 -0700 (PDT)
Message-ID: <f5394785-aafa-784c-9ac0-b4abe19f65be@grimberg.me>
Date:   Mon, 21 Mar 2022 11:25:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bug report] NVMe/IB: kmemleak observed on 5.17.0-rc5 with
 nvme-rdma testing
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Nitzan Carmi <nitzanc@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>
References: <CAHj4cs8vnLXyddEJkV_1Dbmn7UaM4sLX=C1CN9tuA-5Mhczayw@mail.gmail.com>
 <9d9abd33-51f2-5a8e-9df9-8ffe72e3a30b@nvidia.com>
 <CAHj4cs_uViOtdMmFmJZ=htBXybjUP3uL3LnRR0C4PCnHWUM82A@mail.gmail.com>
 <bbb103d5-7622-dc88-07b8-1edc684d2f82@nvidia.com>
 <CAHj4cs_L=QHh4XeOJGfibfSJhhijS6s7RBNuLd_XetKT3hfjWQ@mail.gmail.com>
 <9ba8bfae-2363-e331-83c7-317a9456da31@grimberg.me>
 <CAHj4cs9cmOt=9++wuqJ1ehLPDJcaXJGyTKcHSjU-avWxr1CBrA@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs9cmOt=9++wuqJ1ehLPDJcaXJGyTKcHSjU-avWxr1CBrA@mail.gmail.com>
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


>>>>> # nvme connect to target
>>>>> # nvme reset /dev/nvme0
>>>>> # nvme disconnect-all
>>>>> # sleep 10
>>>>> # echo scan > /sys/kernel/debug/kmemleak
>>>>> # sleep 60
>>>>> # cat /sys/kernel/debug/kmemleak
>>>>>
>>>> Thanks I was able to repro it with the above commands.
>>>>
>>>> Still not clear where is the leak is, but I do see some non-symmetric
>>>> code in the error flows that we need to fix. Plus the keep-alive timing
>>>> movement.
>>>>
>>>> It will take some time for me to debug this.
>>>>
>>>> Can you repro it with tcp transport as well ?
>>>
>>> Yes, nvme/tcp also can reproduce it, here is the log:

Looks like the offending commit was 8e141f9eb803 ("block: drain file 
system I/O on del_gendisk") which moved the call-site for a reason.

However rq_qos_exit() should be reentrant safe, so can you verify
that this change eliminates the issue as well?
--
diff --git a/block/blk-core.c b/block/blk-core.c
index 94bf37f8e61d..6ccc02a41f25 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -323,6 +323,7 @@ void blk_cleanup_queue(struct request_queue *q)

         blk_queue_flag_set(QUEUE_FLAG_DEAD, q);

+       rq_qos_exit(q);
         blk_sync_queue(q);
         if (queue_is_mq(q)) {
                 blk_mq_cancel_work_sync(q);
--
