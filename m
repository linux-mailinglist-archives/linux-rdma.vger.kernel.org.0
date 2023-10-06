Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3289B7BBC3E
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Oct 2023 17:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjJFP6c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Oct 2023 11:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjJFP6b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Oct 2023 11:58:31 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F891D6;
        Fri,  6 Oct 2023 08:58:30 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1e0ee4e777bso1462265fac.3;
        Fri, 06 Oct 2023 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696607909; x=1697212709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A8aZU1JKGGQNU6piZuIIfwXotOX1h9r7PK5oh8+YYl4=;
        b=C2eQeDQffW0CphCzYwkoE6xBq1hmJ9ti7C3v5vCvv+vmyPIFlFZ7xxS1DST9cBhTtP
         97wPBI/9vYkbNzqfRSDkYvGEfaKQilOuez53vqRIlGomnvzMS8tuOjD+rKt9LefFE6p5
         eQRKB+Fzp2TP0N+olkZC7Ls5lhOjpxS8G+ZLc2/SRHDWWYW54MhVFz3TdJsHbY5IhwTt
         3Js0bxejbziMgLZn7De7NWvv0vMfP8Ylu6+rGQtXJctDjG8SMgigx9NXbsPQixeqFi8V
         9iPkDDO7uQBp9uXe4SIKD/KuE/XbRkkPKkU3FYFV1Sn0wIc6WQj9yvjTzlYFOp/WU3NX
         qZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696607909; x=1697212709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A8aZU1JKGGQNU6piZuIIfwXotOX1h9r7PK5oh8+YYl4=;
        b=PhAbD/U3jwSJ+IKwp1bFwi7mqv9fmfYQo5M/Xl/o6T+0h5REHeUaHDBYyuBMx4/m5w
         KLHp7unHpQrNh2DVoDHDEZZz5flK92jttBOLFFs+p/XsuX4e63rdFCvfv3IkxJn3TXFI
         DP7USlw0qY88YqKPMRvHg8SN3SSAo8newBXxtM6+JfprJJVROU58Td8VPci2z3ccuZPl
         sxt9sIUOMeFSyWYZB4LZoomHjXvd67p0UFa2MZbv6twoCP4f5+peTeU+YY7T/s1ZXN8P
         Ebh5g7QqRvCvPJUUAM+fa4o3lmVcwwU54SwEeBPkM7QItMgMbwR/f3x3D1fm6Cc6pHL0
         Omjw==
X-Gm-Message-State: AOJu0Yw71X0c/zhQSkZWRLJ6X7kf0R1s+oN+UiEUoH4LcQTrNe2xZQGY
        kWP3zfzyGu6y990h8JLWhdE=
X-Google-Smtp-Source: AGHT+IEbUKNU95zcRjjWkib0SjSPGjUnT2pQyP16pWWyLgvt9XVAsI/JYm7KoPy/ox6MGA2400DklA==
X-Received: by 2002:a05:6871:a68f:b0:1e5:6f60:c0cd with SMTP id wh15-20020a056871a68f00b001e56f60c0cdmr3894250oab.55.1696607909017;
        Fri, 06 Oct 2023 08:58:29 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:9b89:a1d9:111c:e917? (2603-8081-1405-679b-9b89-a1d9-111c-e917.res6.spectrum.com. [2603:8081:1405:679b:9b89:a1d9:111c:e917])
        by smtp.gmail.com with ESMTPSA id a7-20020a056870b14700b001d53c57b55asm781000oal.57.2023.10.06.08.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 08:58:28 -0700 (PDT)
Message-ID: <93c8ad67-f008-4352-8887-099723c2f4ec@gmail.com>
Date:   Fri, 6 Oct 2023 10:58:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, matsuda-daisuke@fujitsu.com,
        shinichiro.kawasaki@wdc.com, linux-scsi@vger.kernel.org,
        Zhu Yanjun <yanjun.zhu@intel.com>
References: <20230926140656.GM1642130@unreal>
 <d3c05064-a88b-4719-a390-6bf9ae01fba5@acm.org>
 <b7b365e3-dd11-bc66-dace-05478766bf41@gmail.com>
 <2d5e02d7-cf84-4170-b1a3-a65316ac84ee@acm.org>
 <2fcef3c8-808e-8e6a-b23d-9f1b3f98c1f9@linux.dev>
 <552f2342-e800-43bc-b859-d73297ce940f@acm.org>
 <20231004183824.GQ13795@ziepe.ca>
 <c0665377-d2be-e4b6-3d25-727ef303d26e@linux.dev>
 <20231005142148.GA970053@ziepe.ca>
 <6a730dad-9d81-46d9-8adc-764d00745b01@acm.org>
 <20231005155616.GR13795@ziepe.ca>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20231005155616.GR13795@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/5/23 10:56, Jason Gunthorpe wrote:
> On Thu, Oct 05, 2023 at 07:50:28AM -0700, Bart Van Assche wrote:
>> On 10/5/23 07:21, Jason Gunthorpe wrote:
>>> Which is why it shows there are locking problems in this code.
>>
>> Hi Jason,
>>
>> Since the locking problems have not yet been root-caused, do you
>> agree that it is safer to revert patch "RDMA/rxe: Add workqueue
>> support for rxe tasks" rather than trying to fix it?
> 
> I don't think that makes the locking problems go away any more that
> using a single threaded work queue?
> 
> Jason

This is slightly off topic but may still be relevant.
If there are locking bugs they are between the two send side tasks
rxe_completer and rxe_requester which share the send queue and other
state. Bart attempts to fix this by setting max_active to 1 which
limits the ability of these two work queue tasks from interfering.
For completely different reasons we have looked at merging these
two tasks into a single task which it turns out improves performance,
especially in high scale situations where it reduces the number of
cpu cores needed to complete work. But even at low scale (1-2 QPs)
it helps because of improved caching. It turns out that if the work
is mostly sends and writes that there isn't much for the completer
to do while if it is mostly reads there isn't much for the requester
to do. So combining them doesn't hurt performance by having fewer cores
to do the work. But this also prevents the two tasks for a given QP
to run at the same time which should eliminate locking issues.
If no one hates the idea I can send in our patch that does this.

Bob
