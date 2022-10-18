Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958E5602741
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 10:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJRIl3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 04:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJRIl2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 04:41:28 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4C62D1F9
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 01:41:28 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id v11so217610wmd.1
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 01:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=LmYdBmzIzHhebXZEdqhSwaYL9oXvM5exobWv0klrNEHjMyQMF4hyLHJhOfYD2DlUwL
         9DBKACprIKc+t2/qwOAGWEBINigoBfDIPIySpNqIec6AlpsNdsOUvn5x1Od1EwLYwxI5
         iLQ6D8hAbDYHMuQy1GLXl5HSpIN9JAXhcp8DlC+YGDw/t4atCR7QqB93qgBk0phjDs8X
         ZtchC79cD+7WnXK/mBM7tECS3h3VyKgqV/zJ80t2SiVxiMKiaWZmwLlkRRjnLUB4qGRI
         mZoQcJxYr+puSML6VD4iF6cgzwUgArDj0JnNgdR2pW3mYz933ggVYmGUCdy75YDciWBK
         gTpg==
X-Gm-Message-State: ACrzQf0iHigU1AZHc/7LM2JsSnBG8AeHMLc7EZMW2HUqOwI9xPT9mMY8
        LpqVUNaYK15YCcV4HJ7dgHCYTgf1fpI=
X-Google-Smtp-Source: AMsMyM6LyTA30UGtbjGtIsWslmWbumgZc01fwdMEu2vjeBLcwjLMpauBP0P8lRRM+Tfrj7y9w5CYJQ==
X-Received: by 2002:a05:600c:548c:b0:3c6:d8dd:2a72 with SMTP id iv12-20020a05600c548c00b003c6d8dd2a72mr19438425wmb.179.1666082486501;
        Tue, 18 Oct 2022 01:41:26 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e38-20020a5d5966000000b002252884cc91sm10459496wri.43.2022.10.18.01.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 01:41:26 -0700 (PDT)
Message-ID: <5f43a498-3076-254c-ef9a-eb4eef4dc199@grimberg.me>
Date:   Tue, 18 Oct 2022 11:41:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/3] IB/iser: open code iser_disconnected_handler
Content-Language: en-US
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, jgg@nvidia.com,
        linux-rdma@vger.kernel.org
Cc:     sergeygo@nvidia.com, leonro@nvidia.com
References: <20221016093833.12537-1-mgurtovoy@nvidia.com>
 <20221016093833.12537-4-mgurtovoy@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221016093833.12537-4-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
