Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67774DB487
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 16:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiCPPOh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Mar 2022 11:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357136AbiCPPMM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Mar 2022 11:12:12 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733496BDE0
        for <linux-rdma@vger.kernel.org>; Wed, 16 Mar 2022 08:09:43 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id h23so2798387wrb.8
        for <linux-rdma@vger.kernel.org>; Wed, 16 Mar 2022 08:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+KhrMhcJSvItbb/04gtqwcqQ9SN2qd7j6u0HCMyKS6E=;
        b=LVlc+tCh00HQTUg8Rup/qh3FLKI40+oR8V7+GzR3bRB9szC70Bw7ciluaIyTYtDqgn
         8+Pv4vOXmTuld9DbSRSKgWd8Ztusnia9UWBPRti1xE4ODRb2EoVKqbRkk+l/6Wj3RsNn
         ujk1U2QiTbi5noYQS+zWPKLpsscYtqnPIXHz64ggkZ2Zi6sd7AJ3aWK4g0qB5634trJp
         Qgk9GgD9rpL2Osyln+xyYUnI8kt0rp52dtc/nSRcbOszg2OX64fcDf5919kiWTXQMqX1
         86WC+utXqSkRSVou+YBeE/It4SwoqiaQprt58Lx/H9fJTlmMR5o1BT2FzVccMw14E49k
         6FKA==
X-Gm-Message-State: AOAM531ACbi2xhmsVL7iMlYMKnap92u8NGpz36uh0/Udc3VQ7Th2Rycq
        mn/eRzlcNirdNuHmN46kONxFPeEgayQ=
X-Google-Smtp-Source: ABdhPJy/Cmiuh1WzaOdh0gnzXdKi8KDv8915lxMnx2F5sp/1P0eiI9IK9xZRqhySgUxSjW7+8phWgA==
X-Received: by 2002:a5d:4084:0:b0:1f0:2381:871d with SMTP id o4-20020a5d4084000000b001f02381871dmr271085wrp.663.1647443381988;
        Wed, 16 Mar 2022 08:09:41 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v14-20020a7bcb4e000000b0034492fa24c6sm1952435wmj.34.2022.03.16.08.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 08:09:41 -0700 (PDT)
Message-ID: <12db9b59-040b-3b0c-2879-c88d5ccd475e@grimberg.me>
Date:   Wed, 16 Mar 2022 17:09:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/4] IB/iser: use iser_fr_desc as registration context
Content-Language: en-US
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
Cc:     oren@nvidia.com, sergeygo@nvidia.com, israelr@nvidia.com,
        leonro@nvidia.com
References: <20220308145546.8372-1-mgurtovoy@nvidia.com>
 <20220308145546.8372-3-mgurtovoy@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220308145546.8372-3-mgurtovoy@nvidia.com>
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
