Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05D4723367
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 00:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjFEW4r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 18:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjFEW4r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 18:56:47 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20620BE
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 15:56:46 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f13c41c957so480607e87.1
        for <linux-rdma@vger.kernel.org>; Mon, 05 Jun 2023 15:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686005804; x=1688597804;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kPX4pEEArmEGJU9sFJ1oZjtprqWUwnJTmFijwssbXr4=;
        b=YPFgaEbH21/zH7b9YQ8gmNb3QYhj20dwJzHIjXJZkj1RRhm46OukIXL4UyNaXvhAyx
         QrV3FsdedD2V48T5VY+wMWTrdKWO9wXZFrtJEKm9x3zmsGnkNq06xzqXzBbUr6M4k7qr
         DpMeZQDGNiqmLMUceT7EKFWdTEitUoa/2mW+PjfWSD5nGVDF8ik7YCxBQWlGFUhP75WV
         J5pQhP027wfEC3s4eujbCLhgTLi00l0ZyJbWf7Y3yoTrdt3zdGk0yDGQfsfYjxMsCzPF
         CwnRGcTq0rO4ETISE83cZqb2PddwFzkw7uZhdW6AvTUnSl+3lKOM822ZbivRIcCcmByW
         TmOQ==
X-Gm-Message-State: AC+VfDznA43xq0Ct4K62HC/fF7SWgJuxHgQ1Ix2QwKRCrOePtDzxU2/i
        CUKNdEOQf2tB6slm8ZIs0oE=
X-Google-Smtp-Source: ACHHUZ49YEtiobdNu6JZIeN/npcgobFurNIIBHFTkiuXy/qLhTZwY1Oq4n2alKCY8Qw5L+8GUzk1nQ==
X-Received: by 2002:a2e:b80c:0:b0:2b1:dc69:67fa with SMTP id u12-20020a2eb80c000000b002b1dc6967famr291552ljo.0.1686005804200;
        Mon, 05 Jun 2023 15:56:44 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id q6-20020a2e8746000000b002ac88e29049sm1628796ljj.43.2023.06.05.15.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 15:56:43 -0700 (PDT)
Message-ID: <cfcfc65f-a646-597f-bc5e-454f2c8a3805@grimberg.me>
Date:   Tue, 6 Jun 2023 01:56:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 for-rc 3/3] IB/isert: Fix incorrect release of isert
 connextion
Content-Language: en-US
To:     Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
        selvin.xavier@broadcom.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
References: <20230602105613.95952-1-saravanan.vajravel@broadcom.com>
 <20230602105613.95952-4-saravanan.vajravel@broadcom.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230602105613.95952-4-saravanan.vajravel@broadcom.com>
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


> The ib_isert module is releasing the isert connection both in
> isert_wait_conn() handler as well as isert_free_conn() handler.
> In isert_wait_conn() handler, it is expected to wait for iSCSI
> session logout operation to complete. It should free the isert
> connection only in isert_free_conn() handler.
> 
> When a bunch of iSER target is cleared, this issue can lead to
> use-after-free memory issue as isert conn is twice released
> 
> Fixes: 0fc4ea701fcf ("Target/iser: Don't put isert_conn inside disconnected handler")

Doesn't seem quite right?
