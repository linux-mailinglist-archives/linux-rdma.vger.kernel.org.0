Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311BF73620D
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jun 2023 05:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjFTDKr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jun 2023 23:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFTDKj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Jun 2023 23:10:39 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B461723
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jun 2023 20:10:26 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1aa291b3fc7so1449463fac.1
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jun 2023 20:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687230626; x=1689822626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lUJ1yJst3Mgf0WLoIU9PLb0BKiE3rdSqygY39Xaqy+Q=;
        b=I9xqRTigUV6cxFXRum0tZ4ki3I+dzql3S4T4Axp9BgxEfwaDArzweNXebxmm1w22YU
         JWjSCxrdAxHGDC2LjzPy7eVNIrSCrR4wrZ+phnKtKqIW2pfXNy0h5UcvxSZtsxesSWPq
         t7mWmRznkdhOdXzkLtPUshvhkXE+qWnIf6zGLP4KjqkUGu5407bTmZGb+RTqeSv1GSYZ
         Pulx3DAum8ZISXzKj0m466nOrnJymdRxdc0g5Ii5ILmuXv2+pvs3F0DFsCuz7lqHnfnL
         KdBnHsJasRHJX76aXDwTTfv1DhOHz2VBlJhrs8+xJMD2BuWP6N4+YWlMwCithoVP7PRi
         MTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687230626; x=1689822626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUJ1yJst3Mgf0WLoIU9PLb0BKiE3rdSqygY39Xaqy+Q=;
        b=ejnEl6TwBdHHgf72gnR024/25G30t+gllx1WfyiU34AOHdcRCnwrtoZazciBsyk5E9
         Wxbx59P0UJ6inm7/1JsNxhbQUkcw1yyrX9aTs4zoU9lpkUAnV/tnZo2hOrveJzYJSjMf
         N2HMCJfSaaW5cxtk842HTYssUxyxDeiT5G2b0CPA9Sa1HhEVmJkjGtjaNtIGBN71bOFM
         RcMpnPyavPqOE+bVMBxWGLrDIKMMEoSX2rb/L/CkNd5Hz3ZvYwkaqdC4/KfZZ8dwmceE
         89KdMAlcoR6p3wdFgIevWRdJMp271/TOq/EKWBIzQ6dl/l3Gsv4Y/GKiXdvflP6IKU1B
         PsUw==
X-Gm-Message-State: AC+VfDyl5R/vJuOiL9SYpts9P1LnwaU14xNal7RjF1hlUnqawg8TRwHV
        WKvE0faexptSOVRJgc5oyjBfUgeNrzA=
X-Google-Smtp-Source: ACHHUZ6DOrjf+sC10JLLCPJFGohJ02YN2l3xhMl4Wvfq8lAgM6MeIH35gYaBVS+d4nZuZlmWRLVj1A==
X-Received: by 2002:a05:6870:c806:b0:1a3:16af:56e2 with SMTP id ee6-20020a056870c80600b001a316af56e2mr7297170oab.19.1687230626110;
        Mon, 19 Jun 2023 20:10:26 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:773b:851f:3075:b82a? (2603-8081-140c-1a00-773b-851f-3075-b82a.res6.spectrum.com. [2603:8081:140c:1a00:773b:851f:3075:b82a])
        by smtp.gmail.com with ESMTPSA id t25-20020a9d7f99000000b006acfdbdf37csm506721otp.31.2023.06.19.20.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 20:10:25 -0700 (PDT)
Message-ID: <7b086701-02b1-459b-5f99-00e35b2b4892@gmail.com>
Date:   Mon, 19 Jun 2023 22:10:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH for-next 0/3] RDMA/rxe: Fix error path code in
 rxe_create_qp
Content-Language: en-US
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org,
        syzbot+2da1965168e7dbcba136@syzkaller.appspotmail.com
References: <20230619202110.45680-1-rpearsonhpe@gmail.com>
 <CAD=hENcSotJ7EMe_4xbw4=1MeQARV2Us8mhBUPqe-+wPz=V+gw@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CAD=hENcSotJ7EMe_4xbw4=1MeQARV2Us8mhBUPqe-+wPz=V+gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/19/23 17:45, Zhu Yanjun wrote:
> On Tue, Jun 20, 2023 at 4:21 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> If a call to rxe_create_qp() fails in rxe_qp_from_init()
>> rxe_cleanup(qp) will be called. This code currently does not correctly
>> handle cases where not all qp resources are allocated and can seg
>> fault as reported below. The first two patches cleanup cases where
>> this happens. The third patch corrects an error in rxe_srq.c where
>> if caller requests a change in the srq size the correct new value
>> is not returned to caller.
>>
>> Reported-by: syzbot+2da1965168e7dbcba136@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/linux-rdma/00000000000012d89205fe7cfe00@google.com/raw
>> Fixes: 49dc9c1f0c7e ("RDMA/rxe: Cleanup reset state handling in rxe_resp.c")
>> Fixes: fbdeb828a21f ("RDMA/rxe: Cleanup error state handling in rxe_comp.c")
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> 
> Can not apply these commits to Linux 6.4-rc7.
> 
> Zhu Yanjun
> 
>>
>> Bob Pearson (3):
>>   RDMA/rxe: Move work queue code to subroutines
>>   RDMA/rxe: Fix unsafe drain work queue code
>>   RDMA/rxe: Fix rxe_modify_srq
>>
>>  drivers/infiniband/sw/rxe/rxe_comp.c |   4 +
>>  drivers/infiniband/sw/rxe/rxe_loc.h  |   6 -
>>  drivers/infiniband/sw/rxe/rxe_qp.c   | 163 ++++++++++++++++++---------
>>  drivers/infiniband/sw/rxe/rxe_resp.c |   4 +
>>  drivers/infiniband/sw/rxe/rxe_srq.c  |  55 +++++----
>>  5 files changed, 150 insertions(+), 82 deletions(-)
>>
>>
>> base-commit: 830f93f47068b1632cc127871fbf27e918efdf46
>> --
>> 2.39.2
>>

They applied to current for-next.
