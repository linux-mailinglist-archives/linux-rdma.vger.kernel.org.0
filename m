Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757274DB41E
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 16:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356955AbiCPPIg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Mar 2022 11:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351738AbiCPPI2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Mar 2022 11:08:28 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C505245B6
        for <linux-rdma@vger.kernel.org>; Wed, 16 Mar 2022 08:06:56 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id u10so3377386wra.9
        for <linux-rdma@vger.kernel.org>; Wed, 16 Mar 2022 08:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+KhrMhcJSvItbb/04gtqwcqQ9SN2qd7j6u0HCMyKS6E=;
        b=NIl9PPdUr2j7BUiFGRRI+kFOfs0N0cakZwwSUHvfrOQIDgSZE9Nyv7MzY1H1340ep3
         BRvEFPihMrLwpSKriWRUBJRbwJCLWF/XaEpMH2a5fl33T4+c6svZMCHSxykGuRTZwZ7L
         rMUT/sXO2Yh+F9+a0Ia/SXutl3vP7/JMpmLid3d/ihsUrG8bIN/tDrqBFoMb2mfeGCQs
         yiVnJU2gqM6UiRInRFT5siLh+jc1RNbaUy8ShCvxgf9QAYl+axm3ff8Ea61ozziihEBp
         +SUnUYIhOJFxClZIcGrwiiCJDGXR/3oXu8urlwyouiS8L/lU0WC3q/YHfHlLjKfay8GJ
         KW7Q==
X-Gm-Message-State: AOAM530e3/vMTnqcKf9PZA0CRPP+q8aV5m5I/QP290DY9eSCWW9StyY1
        rf2pZ7bLXeOHlPSSXxzj3ow=
X-Google-Smtp-Source: ABdhPJwL3WffrhwtEx05U1BYoyBHIQLiGeLMKNCJGq+zcR9WR3yoFreWmNeEpcYgha8aEPEyZ37A9A==
X-Received: by 2002:a5d:598b:0:b0:203:95c0:7b72 with SMTP id n11-20020a5d598b000000b0020395c07b72mr348651wri.172.1647443214808;
        Wed, 16 Mar 2022 08:06:54 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5091000000b001edb61b2687sm2592930wrt.63.2022.03.16.08.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 08:06:53 -0700 (PDT)
Message-ID: <7c462ca7-7998-0d2b-89f6-4aec37f74f60@grimberg.me>
Date:   Wed, 16 Mar 2022 17:06:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/4] IB/iser: remove iser_reg_data_sg helper function
Content-Language: en-US
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
Cc:     oren@nvidia.com, sergeygo@nvidia.com, israelr@nvidia.com,
        leonro@nvidia.com
References: <20220308145546.8372-1-mgurtovoy@nvidia.com>
 <20220308145546.8372-2-mgurtovoy@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220308145546.8372-2-mgurtovoy@nvidia.com>
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
