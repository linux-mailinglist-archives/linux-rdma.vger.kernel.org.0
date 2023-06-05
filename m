Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D518972335C
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 00:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjFEWxi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 18:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjFEWxi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 18:53:38 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85233BE
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 15:53:36 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4f3af42459bso772085e87.0
        for <linux-rdma@vger.kernel.org>; Mon, 05 Jun 2023 15:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686005615; x=1688597615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFFKx12p5+40IK/H9chRazbDo7e5dLWR8E7036+FiEM=;
        b=bIub4yIck/LT/m/UVZuVDWM9AYtAw4LfQZGbNo2symXv+vzObMVOG7lp04tgTtwHOU
         7Y6PJ0VbQE9UwexE9R4azVEtVFamQ7sAETF8e/1JRtR6IVPy6rydX9XpNZpelre3C2tp
         sXttu3qip2obitED2R4D5wsPYW1Z9z1gvtUWALTehTK5fhAw1kH8dyrmFFI4SS89w7e1
         3A9v+pMXSQ0QZAF2BYN+H5MoYBz49fM6se6fWwh9yrDgflblNJvR1tJZrtMCXiitsqnQ
         QgCgMfAX/qlkT36QF04EU+BGg3hWIMjKTOxvKiUZIUTFmah29Er7Ic25UszxlpEfB9QG
         Y4mg==
X-Gm-Message-State: AC+VfDyHbN3LZAKJQF2IdXH1yPFSubqQn8cTSR7TAGTjSefecRA8Vx9V
        scLfL4hECK9ZMhuzEqxwC+wHW5IOlJA=
X-Google-Smtp-Source: ACHHUZ4IIYTqdT6bp7k2rlFg70IVKUQv51mpnZsy2YJCzRxBGdkaAhzuqhjTDkodLLCerPOxugiRfw==
X-Received: by 2002:ac2:51b1:0:b0:4f2:56d9:310a with SMTP id f17-20020ac251b1000000b004f256d9310amr159094lfk.0.1686005614682;
        Mon, 05 Jun 2023 15:53:34 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id a24-20020ac25218000000b004f6337508afsm67426lfl.222.2023.06.05.15.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 15:53:34 -0700 (PDT)
Message-ID: <0c733a1c-d1c7-ddf9-3fdb-0adc2c1fc40c@grimberg.me>
Date:   Tue, 6 Jun 2023 01:53:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH for-rc 0/3] IB/isert Bug fixes in ib_isert
Content-Language: en-US
To:     Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>, leon@kernel.org,
        linux-rdma@vger.kernel.org
References: <20230601094220.64810-1-saravanan.vajravel@broadcom.com>
 <ZHjXJMDWif75kbJC@nvidia.com>
 <51a676ee57e57ce3ad994be2462fc7f9@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <51a676ee57e57ce3ad994be2462fc7f9@mail.gmail.com>
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

>>> Bug fixes for generic issues in ib_isert, found during connect/release
> 
>>> of bunch of isert connections
>>>
>>> Saravanan Vajravel (3):
>>> IB/isert: Fix dead lock in ib_isert
>>> IB/isert: Fix possible list corruption in CMA handler
>>> IB/isert: Fix incorrect release of isert connextion
> 
>> These all need fixes lines
> 
> Added Fixes tag. Sent v2 patch series.

Did you?
