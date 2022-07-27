Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF741583271
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jul 2022 20:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbiG0Sxi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jul 2022 14:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbiG0SxZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Jul 2022 14:53:25 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F604D4DE
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 10:48:53 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id y15so16674038plp.10
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 10:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WeoXrlzRTj09u4s18TLXfwN77s8K6LJz0p15ceWUqwY=;
        b=FMGKhfIBBTuh8kPKf9l7wE6W2vSYH2etIMsjL0JSRaATaCsFEZsr+Tdw71WG45RUJH
         6+BH2a3Nud3BqEXARgd5qoHXY4oPLWGQGSfqN34miZtZmw6wt7Em+mEj2JwuAki4oVT+
         i2nIWlvEVrSIpCEP6W5peFt/SWl+SLYn5Hux0KsJEXK2+3ujJ3B9XOtz4UIskhrAnxEm
         ZhK1KgZW4RbQ05Dr4k0Fi/QDmSbaie9qtrWKM7dMSO9JbiyqdecVfL+oiuG4naJilmwP
         SfOzgM1XhZeWXsKO7LayrHhW+UETMQQN68hiML2GwdhHbRHz2oqiyKL4zo+ep8UskVZo
         D35w==
X-Gm-Message-State: AJIora86KeMxthQ/UUaBEenH7obmsUAft8kw3un3eQcHNe/eUvMHUtRd
        fvk0vDe6Y9A9ka7uGLtD3is=
X-Google-Smtp-Source: AGRyM1t5YbEhxZ08BILCEDm+/035uCy/AFwZQ2Ja1NYtvmziSEv05nRK3/xs1S3bBMAwbaP0+5mXFA==
X-Received: by 2002:a17:90b:4b0a:b0:1f0:5c2d:fe72 with SMTP id lx10-20020a17090b4b0a00b001f05c2dfe72mr5971903pjb.150.1658944133123;
        Wed, 27 Jul 2022 10:48:53 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a84e:2ec1:1b57:b033? ([2620:15c:211:201:a84e:2ec1:1b57:b033])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902650200b0016c0b0fe1c6sm14234090plk.73.2022.07.27.10.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 10:48:52 -0700 (PDT)
Message-ID: <e268fd7d-e828-c5ed-8f95-0c6179db43fa@acm.org>
Date:   Wed, 27 Jul 2022 10:48:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] RDMA/srpt: Fix a use-after-free
Content-Language: en-US
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Mike Christie <michael.christie@oracle.com>
References: <20220726212156.1318010-1-bvanassche@acm.org>
 <20220726212156.1318010-4-bvanassche@acm.org>
 <c8663ec2-0436-cafd-448b-50f3e191c5b8@fujitsu.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c8663ec2-0436-cafd-448b-50f3e191c5b8@fujitsu.com>
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

On 7/27/22 03:03, lizhijian@fujitsu.com wrote:
> I tested patches with blktests/srp, it works well and the UAF is gone.

Hi Li,

Thank you for having tested these patches so quickly :-) I assume that 
the above counts as a Tested-by?

Bart.
