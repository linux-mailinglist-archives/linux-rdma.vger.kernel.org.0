Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D978B7CE818
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Oct 2023 21:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjJRTtC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Oct 2023 15:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjJRTs4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Oct 2023 15:48:56 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C63E119;
        Wed, 18 Oct 2023 12:48:53 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ca82f015e4so25861875ad.1;
        Wed, 18 Oct 2023 12:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697658532; x=1698263332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=efu5n80K4BeYMOyw0yJMpboRDNc9xovwNFAE6xFyMHE=;
        b=SKxiCbGULhPwmarxqxAQ8MH6UAzSnJi+UIxMA2OoeQUHxLd7B9BI6u1utDuGb9xh4z
         0CMY6oKez3t9+P31SiT+PYJIka4L5Pm9G9LZz7lugWsk6tCoE3ZITlsXXmO6sdbGC3wU
         IDNtP5EqfMy00kDrZQSW9lMfb9efUrwxX2vXVWsEYCO+aE56uzu8oA1ZrYRJcC6HOQpa
         0XzuqKnfpJ8FExrWi/vOagbQYIIkotAtx5AXCZPOJaD0bOrbrPHvq7Jxg1CdOAsrNlyC
         qTLIu92zlwnHzEsYmgm+Qb0UOwYc09g+WPzCEq5rETTcxHVfCAzkWuW+miDKAULMTFnx
         el2w==
X-Gm-Message-State: AOJu0YxKirCoSKXNqPbNiyBbbyeVGPdn6VNQ3y74B9CIo0nQ1A7RMdOG
        tTEbSrgmAPcy0+/1DkbHUik=
X-Google-Smtp-Source: AGHT+IG9plijIYbk4TwsTNC+52WjhQPsXQXs40IaW+f+6atvPiFwI85rJ1MnVBS8VmNgb5yzjvKZXw==
X-Received: by 2002:a17:902:ec82:b0:1ca:82f0:131a with SMTP id x2-20020a170902ec8200b001ca82f0131amr474963plg.19.1697658532413;
        Wed, 18 Oct 2023 12:48:52 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:66c1:dd00:1e1e:add3? ([2620:15c:211:201:66c1:dd00:1e1e:add3])
        by smtp.gmail.com with ESMTPSA id o13-20020a170902d4cd00b001bc676df6a9sm304382plg.132.2023.10.18.12.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 12:48:52 -0700 (PDT)
Message-ID: <8e7dbd64-856d-47cc-9d2f-73aa101afa11@acm.org>
Date:   Wed, 18 Oct 2023 12:48:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>, Bob Pearson <rpearsonhpe@gmail.com>
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231018191735.GC691768@ziepe.ca>
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


On 10/18/23 12:17, Jason Gunthorpe wrote:
> If siw hangs as well, I definitely comfortable continuing to debug and
> leaving the work queues in-tree for now.

Regarding the KASAN complaint that I shared about one month ago, can 
that complaint have any other root cause than the patch "RDMA/rxe: Add
workqueue support for rxe tasks"? That report shows a use-after-free by
rxe code with a pointer to memory that was owned by the rxe driver and
that was freed by the rxe driver. That memory is an skbuff. The rxe
driver manages skbuffs. The SRP driver doesn't even know about these
skbuff objects. See also 
https://lore.kernel.org/linux-rdma/8ee2869b-3f51-4195-9883-015cd30b4241@acm.org/

Thanks,

Bart.

