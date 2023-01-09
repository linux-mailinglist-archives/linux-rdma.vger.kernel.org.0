Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5A5661BD8
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 02:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjAIBQh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 Jan 2023 20:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjAIBQf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 8 Jan 2023 20:16:35 -0500
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8C2CC6
        for <linux-rdma@vger.kernel.org>; Sun,  8 Jan 2023 17:16:34 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id n12so7227369pjp.1
        for <linux-rdma@vger.kernel.org>; Sun, 08 Jan 2023 17:16:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUbTzo4rItIVgpvAQzUIhVV7Kbs/6VkCYTQA4oglWDE=;
        b=ivbfK9X38hpZ/ajcal57+16+c/Ou28yf0iha9Z1aKK3C74EkPpqCwoA0qjfHgXGYqO
         2Yjw8lX3x6yUWNfkUA9FshQxuBYEsvDZ+aHKhTi2s6UBB/S9x+0N9zQVzesBM9okNdmM
         COb+3prK1B4imDYlXxZ76pRcuNNAvzAKXxdAqI2KyIhWl0sSg7G65im7wwOgPrRRMnSF
         HpQhvfTaOzdJhXzDogS/++VIy6dQyvOlwdIuOM0j3FDXkPBbRkzR4IUxC6NlZWpOhVfq
         AxEXyMKDVPvOWXFNvAe0E6zmYxUUr6pMV0QP53hbfwM3nnKA95DdwjmQvFYlV7hcQfxD
         L6IQ==
X-Gm-Message-State: AFqh2kqvhN397RWYCCL8WQ7QzseCQMkoAIv7c6KMcs9K+Z0i1+Jy3L+X
        F0ZNoD0AO1XPE8/oasDAGoOfExose3g=
X-Google-Smtp-Source: AMrXdXud5V9eguRnVmPi7hOWcYgNtkTJnfjtKnOlWYwjidwqQxRUUlVFqken4/CRpY0Mvhf/PErhwg==
X-Received: by 2002:a17:902:f80d:b0:192:f6d0:6029 with SMTP id ix13-20020a170902f80d00b00192f6d06029mr17984919plb.15.1673226993894;
        Sun, 08 Jan 2023 17:16:33 -0800 (PST)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id o9-20020a1709026b0900b00188c9c11559sm4782589plk.1.2023.01.08.17.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 17:16:32 -0800 (PST)
Message-ID: <2497aff6-caea-5785-26b0-dd20c2df279f@acm.org>
Date:   Sun, 8 Jan 2023 17:16:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH rdma-next] RDMA/cma: Refactor the inbound/outbound path
 records process flow
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org
References: <7610025d57342b8b6da0f19516c9612f9c3fdc37.1672819376.git.leonro@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <7610025d57342b8b6da0f19516c9612f9c3fdc37.1672819376.git.leonro@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/4/23 00:03, Leon Romanovsky wrote:
> From: Mark Zhang <markzhang@nvidia.com>

The SRP changes in this patch look good to me.

Thanks,

Bart.

