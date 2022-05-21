Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DB252FF22
	for <lists+linux-rdma@lfdr.de>; Sat, 21 May 2022 22:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiEUUDu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 21 May 2022 16:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiEUUDu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 21 May 2022 16:03:50 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6AE5AA55;
        Sat, 21 May 2022 13:03:48 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id o12-20020a1c4d0c000000b00393fbe2973dso8635861wmh.2;
        Sat, 21 May 2022 13:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=KD5gCRlWiS/0hW7c2QgKfzIlOkG7sU11TbsPKgPMUz2up8gL7CB2kLLd0GocmToSlU
         k9uIJ2dly709wbNX8Q58ZZ7R5MHSIJIWpBWoB+9oBny+zOlJ6mxpgZyTdmRxhgkayy2G
         SpD9OER0YfPbXQCw7SNpMU09d45uE/TjGIliC9AdsvDnibMkgK4S2C92wotRr7k/vao4
         di/qQHf4ffUE4oiX7Q9xXs8caMD1GRQ/FkR+JRRFaWhzFFj5qnBw7UDSuafuBYEOxiOr
         v0SXvECgpFeMZvWlh/I3SucpI6tT7aFJVY8q4ER+yzEj7FBp/37AH8Ytn6PaODaA5f/l
         xe5g==
X-Gm-Message-State: AOAM531GeRi3RzY03jHTw0PMSAZ4pBT4P1y58OBariXTgA+U9lYOwCIJ
        5ZlV2jS1w4nwS3WMFaR0VWc=
X-Google-Smtp-Source: ABdhPJwWOSURnpMuTktKZK+FlyLFjj6RHyhAd2DORlYWnYibLFpPmzEebzlHDo5WCw0x+HshpLDVmQ==
X-Received: by 2002:a7b:cd95:0:b0:397:3c5e:9639 with SMTP id y21-20020a7bcd95000000b003973c5e9639mr6978872wmj.12.1653163426610;
        Sat, 21 May 2022 13:03:46 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c1d9000b003973435c517sm5579239wms.0.2022.05.21.13.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 13:03:46 -0700 (PDT)
Message-ID: <bfe4d070-1f7b-f727-c6c2-fa9e0b0db37d@grimberg.me>
Date:   Sat, 21 May 2022 23:03:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] IB/iser: fix typo in comment
Content-Language: en-US
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220521111145.81697-4-Julia.Lawall@inria.fr>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220521111145.81697-4-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
