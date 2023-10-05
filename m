Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A047BA27D
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Oct 2023 17:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjJEPjV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Oct 2023 11:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjJEPik (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Oct 2023 11:38:40 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6010A826C2;
        Thu,  5 Oct 2023 07:52:08 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2791747288cso800914a91.0;
        Thu, 05 Oct 2023 07:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696517431; x=1697122231;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZ4zNKP97+yn3jnmTeaeOiOiac+Cn0Wmg79EhpHIZ0E=;
        b=PjrwjG8wzJR9Bnc/a+ad2yX1Nu1ugMNOqAUrnWJFEdW7I3sUKn/hlV2v5qn4DQgSFO
         nK+wk8ptq4dubliF+5o0gp05uf+OyaEvRMsg/InskeoS7Sh2gf5doncDizoYJECsBkML
         W+Ir5QbQH0XDsV/F1DpdWwj60xFVlKbfEgJrQ5OTDQc+cLXHu+Fp0OJ1M9EmSRIbS5It
         UHrUMn3j3rtte5gtGcOiR1rYnTAKbSkEiRyVayXc0vTHQy5H/CPaElSRQI+o2f/zs6eT
         NFPMd8WPk5lPBPJtrPz7jI4MdEIbOU1uLiaEU19mJTSBtbjvpXnA9MCK8AlXG3V64Sy7
         5utw==
X-Gm-Message-State: AOJu0YyVWE+N3h+rKf6wOBba5Q8AFbFTB2C4H/3DyEuQETjFJ1nqA7JY
        tkZKot/PW1Y8LFfdR1CPOMw=
X-Google-Smtp-Source: AGHT+IEjBKMR8x6uvEs1r0nWt+BFvEswYq11yXeDI/JXYeWv5tSaMpN3hIcEj2a9AsTWdELGiQlAjA==
X-Received: by 2002:a17:90a:ad09:b0:268:2500:b17e with SMTP id r9-20020a17090aad0900b002682500b17emr5405252pjq.23.1696517430785;
        Thu, 05 Oct 2023 07:50:30 -0700 (PDT)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id 6-20020a17090a1a0600b00263dfe9b972sm3983016pjk.0.2023.10.05.07.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 07:50:30 -0700 (PDT)
Message-ID: <6a730dad-9d81-46d9-8adc-764d00745b01@acm.org>
Date:   Thu, 5 Oct 2023 07:50:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, matsuda-daisuke@fujitsu.com,
        shinichiro.kawasaki@wdc.com, linux-scsi@vger.kernel.org,
        Zhu Yanjun <yanjun.zhu@intel.com>
References: <20230922163231.2237811-1-yanjun.zhu@intel.com>
 <169572143704.2702191.3921040309512111011.b4-ty@kernel.org>
 <20230926140656.GM1642130@unreal>
 <d3c05064-a88b-4719-a390-6bf9ae01fba5@acm.org>
 <b7b365e3-dd11-bc66-dace-05478766bf41@gmail.com>
 <2d5e02d7-cf84-4170-b1a3-a65316ac84ee@acm.org>
 <2fcef3c8-808e-8e6a-b23d-9f1b3f98c1f9@linux.dev>
 <552f2342-e800-43bc-b859-d73297ce940f@acm.org>
 <20231004183824.GQ13795@ziepe.ca>
 <c0665377-d2be-e4b6-3d25-727ef303d26e@linux.dev>
 <20231005142148.GA970053@ziepe.ca>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231005142148.GA970053@ziepe.ca>
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

On 10/5/23 07:21, Jason Gunthorpe wrote:
> Which is why it shows there are locking problems in this code.

Hi Jason,

Since the locking problems have not yet been root-caused, do you
agree that it is safer to revert patch "RDMA/rxe: Add workqueue
support for rxe tasks" rather than trying to fix it?

Thanks,

Bart.
