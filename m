Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40C84DB48D
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 16:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350612AbiCPPOj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Mar 2022 11:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358132AbiCPPO0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Mar 2022 11:14:26 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5DDB93
        for <linux-rdma@vger.kernel.org>; Wed, 16 Mar 2022 08:13:10 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id h16so946868wmd.0
        for <linux-rdma@vger.kernel.org>; Wed, 16 Mar 2022 08:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+KhrMhcJSvItbb/04gtqwcqQ9SN2qd7j6u0HCMyKS6E=;
        b=H0c+6LAOLXkmvWjalbMs6BIX6X0Av7DhZhjrDfJybljyphsMP4jjqJ/n3pBtuxrw1U
         HSJUmrxI76wwO52g4U6oAzea2skahe64XjwlF5QD0CCwC+VG7AzZt1HJx1CtOiK3SPNW
         iRMJ/cObdvGmU1XyIPrm+10EfP78EmG52Zn0ycSGWN32HwdtNeEwPw5UUr0rXaCL5Qdc
         2zPORX2b6jjV6w7++MaGJFBxEimUbtmEjyqUPHlA7UQ610zuDkyGy60UfbX0TfHyNkxK
         2rH4G0sYZSEJupYLW6VsZJ++EPwB5CFrDkFGdvf2X8rzn2O0u7+uIIJqYW1Fi+W+kDq2
         CHFw==
X-Gm-Message-State: AOAM533lFds5/x5KrS87P8+pdK3rZtO53dlX+lduX7nFeAQe/KAqagt1
        FfkZfW4d9RlX+r15nvbxWZ5rcw8cMoU=
X-Google-Smtp-Source: ABdhPJx5MwL0Dd+BhupAOFwlJ5l2krSOdliorBlWXL7HoZ+MXXztmdHMk2gV9jZqNHKDNu0eXAb99A==
X-Received: by 2002:a05:600c:2241:b0:382:9bc7:4e66 with SMTP id a1-20020a05600c224100b003829bc74e66mr126507wmm.21.1647443589302;
        Wed, 16 Mar 2022 08:13:09 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d548c000000b001f1f99e7792sm1803822wrv.111.2022.03.16.08.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 08:13:08 -0700 (PDT)
Message-ID: <b34e1ef2-b7f5-2ff6-5c6e-a3c9d45b2a83@grimberg.me>
Date:   Wed, 16 Mar 2022 17:13:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/4] IB/iser: generalize map/unmap dma tasks
Content-Language: en-US
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
Cc:     oren@nvidia.com, sergeygo@nvidia.com, israelr@nvidia.com,
        leonro@nvidia.com
References: <20220308145546.8372-1-mgurtovoy@nvidia.com>
 <20220308145546.8372-4-mgurtovoy@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220308145546.8372-4-mgurtovoy@nvidia.com>
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

Acked-by: Sagi Grimberg <sagi@grimberg.me>
