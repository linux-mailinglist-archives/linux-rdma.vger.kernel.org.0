Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A8E7CE9F3
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Oct 2023 23:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjJRV1m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Oct 2023 17:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjJRV1l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Oct 2023 17:27:41 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE6811C;
        Wed, 18 Oct 2023 14:27:38 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-692d2e8c003so97166b3a.1;
        Wed, 18 Oct 2023 14:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697664458; x=1698269258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+CBVf5AStNt7Fc6ndUOav5IId83WfRjEYF6HhGxE9tU=;
        b=t6MOt9HXMoSNw9sFT/+qtKmKv1Kr/KuAkeb2mR0LzEhpG3ZBKiCr72Eu+wMXM/itQy
         bw/q3UdO9hgDYxvErAP8LmzYurxq5hkpHXxekJObOikkoyN1+jdvDx/iFw5VGhZ34XYZ
         AoC0cjgEb0IuZGMph12pebrcdZ/Tqar7tsMBeAkltfcnA4V2KPBjBIIWa2lW8e1WdiS0
         2A62+siul2dFq7c8rVl3O8rrpX+ZXqCLPzAm+/8NK3SleVkX9kNQe/MUqpDDRr/dLGMQ
         nFpCKlw13XlFrcSI9M4PoVCWY0T03xFJ2RsaHb2NBN1cPQIs0X7NuWvLPoQnLr5Ln4OP
         uOQA==
X-Gm-Message-State: AOJu0YzqLDaZtg4+U8KA/jfgTQ0U1FEBCIwQxSK/dTlOvzajfZjpCO/B
        M9O9eMyRp4L98MnOIXT5E9o=
X-Google-Smtp-Source: AGHT+IFG32lFWcjT/UgMnp1Xq/AeCb3FWCzH0nc9Ik4NVkURXVqEzjo+5rdfVCCATI8ql8gYtow02Q==
X-Received: by 2002:a05:6a20:a110:b0:17b:9675:23fa with SMTP id q16-20020a056a20a11000b0017b967523famr22310pzk.24.1697664457731;
        Wed, 18 Oct 2023 14:27:37 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:66c1:dd00:1e1e:add3? ([2620:15c:211:201:66c1:dd00:1e1e:add3])
        by smtp.gmail.com with ESMTPSA id p15-20020aa7860f000000b006b2dff03b3csm3777760pfn.113.2023.10.18.14.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 14:27:37 -0700 (PDT)
Message-ID: <7ea5a4b0-26b8-4521-a53b-99cbdb02c594@acm.org>
Date:   Wed, 18 Oct 2023 14:27:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Rain River' <rain.1986.08.12@gmail.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <20231017185139.GA691768@ziepe.ca>
 <c65f92b2-9821-4349-b1f5-7dc2a287946a@gmail.com>
 <08a8d947-25b5-434c-9ba3-282d298b5bfd@acm.org>
 <e3d91c4f-b124-4031-9f92-fcb61973a645@gmail.com>
 <02cd10fd-fd4a-4ad7-9b1d-6d37b070aacf@acm.org>
 <5c6e69b3-f83b-461d-a08a-37bfbd82f995@gmail.com>
 <cad2fee4-9359-4614-b36b-c2599dc12358@acm.org>
 <bf2705ff-716a-45b5-bcc4-8710ea0fb98e@gmail.com>
 <65b871ef-dd93-4bfb-bae9-c147a87c64d0@acm.org>
 <dbd9f019-693f-476c-aa4c-739746753d2b@gmail.com>
 <20231018191735.GC691768@ziepe.ca>
 <8e7dbd64-856d-47cc-9d2f-73aa101afa11@acm.org>
 <fb5f6da5-5017-440d-9cb5-38796554366c@gmail.com>
 <6f5ed2dd-3809-4805-8d31-de24f3f14486@acm.org>
 <MW4PR84MB2307BE5EEC6DF51918FCCDF1BCD5A@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <MW4PR84MB2307BE5EEC6DF51918FCCDF1BCD5A@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/18/23 14:17, Pearson, Robert B wrote:
> Help. Do I run after the hang (from a different shell) or before I
> run srp/002?

Hi Bob,

Please only run that shell command after a complaint like "INFO: task
kworker/11:0:85 blocked for more than 120 seconds." has appeared in the
kernel log.

Thanks,

Bart

