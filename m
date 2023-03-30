Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFCE6D0750
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 15:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjC3NwF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 09:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjC3NwE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 09:52:04 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BBF5598
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 06:52:02 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id d11-20020a05600c3acb00b003ef6e6754c5so8043921wms.5
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 06:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680184320;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=W85eWeVk7rt4VKApOZPQHjSwFtyqf3yiU93npj7BX1vMtBxuf5P0mp65+nVbGI4lmu
         nKE5FKEPLw4Ovv9glqjfwDuF9289mWXXFVTU517CGH/I5w1Lr2TeLGoYfRqkCeBWDzpb
         YGUo/1dJ3jfHTmgfgLrM+QQN8Nyfuyt/08jwwmjIYYYdz38emGGS6u7YtSQNLNJbQICh
         vgKfaoIbFLXCAzrjrILdDnipZUL3brLieJp9Y85ChiZz96RlbJbvoHPzO3STXyCEVitF
         uW9Kw6UXMetpFf+Rxd4yjpQJuIN/4hQSE7S7whRGsnmBODLyA51wQ5r79QzwGDqDkm2f
         heyA==
X-Gm-Message-State: AAQBX9eMCIiGinM22jBWOPCJeIUfkgJsKEXTdryn3dBHzmwMRqTHUsog
        nOOs/MCJrxPrzaBAXQrxmofrc9Faee0=
X-Google-Smtp-Source: AKy350bx8xTzDcb3g3rcuEstzUKLf0WqjK9l7uMyys85mjKHdWipP0V9OOtWkwLmZ8tolsbxj/oFxw==
X-Received: by 2002:a05:600c:3d8b:b0:3f0:34c4:e76d with SMTP id bi11-20020a05600c3d8b00b003f034c4e76dmr2004404wmb.0.1680184320634;
        Thu, 30 Mar 2023 06:52:00 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id e23-20020a5d5957000000b002cfefa50a8esm32809961wri.98.2023.03.30.06.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 06:52:00 -0700 (PDT)
Message-ID: <f9725274-8e96-10d2-5a5e-c297b59b5304@grimberg.me>
Date:   Thu, 30 Mar 2023 16:51:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/3] IB/iser: centralize setting desc type and done
 callback
Content-Language: en-US
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, leonro@nvidia.com,
        linux-rdma@vger.kernel.org, jgg@nvidia.com
Cc:     israelr@nvidia.com, oren@nvidia.com, sergeygo@nvidia.com
References: <20230330131333.37900-1-mgurtovoy@nvidia.com>
 <20230330131333.37900-2-mgurtovoy@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230330131333.37900-2-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
