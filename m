Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96FD5A3F84
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Aug 2022 21:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiH1Tuf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Aug 2022 15:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiH1Tue (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Aug 2022 15:50:34 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127C663F4
        for <linux-rdma@vger.kernel.org>; Sun, 28 Aug 2022 12:50:32 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d12so6095852plr.6
        for <linux-rdma@vger.kernel.org>; Sun, 28 Aug 2022 12:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=YDhcqo6tUNOlSKfVZ7ncyytdOfVAbDIM/ALZCpaGGj8=;
        b=MziCO+DHX2ah1Qljz26kJ8GFlNHh9q/8mWOBJdSiMsLhN/TNQjipTUFovPISZjIROM
         dxsqt+N2ZIxpXSaTNRxF+pA8K1WeKD1F4ETRzas2KdbSvB/zqaH/PPFVPXYR3J3Wjf4a
         rkI6elEgSTrpL1TxqGC7aiIBlNQUU00UmweTv51FCsv4X1EbU/zn27BsIhrrxGjtJMmN
         CJXEAJ+4Y0qox9Dhn7xQUjqgP9PnsyH8TAdv9Sm0R9TqR3i5HV2ysOmVG+n0CZImhVdo
         xh+SzzutXG1Ehli2Kc/PP9acWhuIcSXe/h0bm04vsAHmPUGvglXt1sUUmZbo56dAOfGM
         RtIw==
X-Gm-Message-State: ACgBeo2NO7V1Lttr6yewpJggJqEbqgqX9MqQCfJ80fGfIIyU2uOzs7Ju
        qAeTHohx/R0Cs/rkH2qB/srhIybzkXs=
X-Google-Smtp-Source: AA6agR5IB4EcZyAT6WergE3VokXdlfSCmxn3YhhbzuDMl+m878ON3Xshp7KZAtYgvB7Yc+NCISVgsA==
X-Received: by 2002:a17:90b:4f44:b0:1f5:1310:9e7f with SMTP id pj4-20020a17090b4f4400b001f513109e7fmr14882220pjb.235.1661716231195;
        Sun, 28 Aug 2022 12:50:31 -0700 (PDT)
Received: from [10.46.21.69] ([156.39.10.100])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709027ec900b00172bc4e0fb7sm5684820plb.250.2022.08.28.12.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 12:50:30 -0700 (PDT)
Message-ID: <f98c7a98-21e5-817b-df6c-04df777307c2@acm.org>
Date:   Sun, 28 Aug 2022 12:50:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/4] RDMA/srp: Handle dev_set_name() failure
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
References: <20220825213900.864587-1-bvanassche@acm.org>
 <Yws9t6Xj/08izIdR@unreal>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Yws9t6Xj/08izIdR@unreal>
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

On 8/28/22 03:04, Leon Romanovsky wrote:
> On Thu, Aug 25, 2022 at 02:38:56PM -0700, Bart Van Assche wrote:
>> This patch series includes one patch that handles dev_set_name() failure and
>> three refactoring patches. Please consider these patches for the next merge
>> window.
> 
> You confuse me. "next merge window" means that patches are targeted to
> -next, but you added stable@... tag and didn't add any Fixes lines.
> 
> I applied everything to rdma-next and removed stable@ tag.

Hi Leon,

Although it's not a big deal for this patch series, please do not modify patches
without agreement from the patch author.

As far as I know adding a Fixes: tag if a Cc: stable tag is present is not required
by any document in the Documentation/ directory?

I had not added a Fixes: tag because the issue fixed by patch 3/3 was introduced
by the commit that added the ib_srp driver to the kernel tree. So it would be fine
to backport the first three patches of this series to all older kernel versions to
which the patches can be backported.

Thanks,

Bart.
