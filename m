Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E72464EE83
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Dec 2022 17:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiLPQHD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Dec 2022 11:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbiLPQGT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Dec 2022 11:06:19 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACD7393
        for <linux-rdma@vger.kernel.org>; Fri, 16 Dec 2022 08:03:24 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id m4so2755350pls.4
        for <linux-rdma@vger.kernel.org>; Fri, 16 Dec 2022 08:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O1qjP7+KqmrUFY+SnaTsk+GxzcwVKXxOCE9bngVZS8Y=;
        b=gShdK6XXiivLeNg7J6NrWJKdwX8H3oI/vll5yGqyUsWhvthrYgVG5ynkc+WQzHH6l1
         pjy9eObYteoQhqshKUAviHYpmueiXHDFQRhZV//Pe2VOORb/xOLa63xIAgjPKFh97gGi
         peQ2otoqOZL2tAvtc3WutLb0CcYgEQddXA3RPMe1cj1aauHQAz4FJAoKfrvmvTpb5ZW8
         PNrAgfXlbXmRsFQr71pATmhnYCzNmRbWDkvgb8CtNo6YuDcXLh5GDxV3+OffnwZLz19D
         6SGGPfe9btPIz8tvTTNAMwamlx79cAk/km8jKXjPY6V3PfUmAy2TEhDnZumkDK+I3u/q
         MKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1qjP7+KqmrUFY+SnaTsk+GxzcwVKXxOCE9bngVZS8Y=;
        b=YiggevuMjlm5zrd5jtuooOq/An4KAJOxz0GaqtEuJ4qMBpDeS8fwcsCzA2lq3Wkwwt
         uIe+OrajnNhYaAmCFY4Bkp0BDNGrlVyriXurCFAGOcjUQZvYmQXiw9z1eDse57Grg/+g
         MOpIQUS99ED7gMqOIWsUYGNi8tzzTVGHzE256fEDResHo6ljnsbQOXYqps0X9UrTUZwD
         3wfB6nyeWAi0kpEXoOJDCfTrivmT11jP/ic7E8BHTVGbE75TnuGwtRD38Geve1VDMsNY
         jBlcJTBCfiFTNGX2CqPLvyhfXCapztVHlG/JQ37xZJNTyGJLIDciPghmTkINmhBytl8C
         K1BA==
X-Gm-Message-State: ANoB5pmXcUhZ1XyVL0Yq0kKPnAV8bCC2QeTtPvWrATwdqU/RWBQfeCCx
        nnsdGAWHODzcS99v1YR/jI9qLA==
X-Google-Smtp-Source: AA0mqf4xvYHTRvfh2jPOwezebiiwAjxNqPenhU44p+alqYmIjvGkgXX83vP3VXqyQbYisb1qj6hfIQ==
X-Received: by 2002:a17:90b:2401:b0:219:89c2:b70b with SMTP id nr1-20020a17090b240100b0021989c2b70bmr41208487pjb.16.1671206603701;
        Fri, 16 Dec 2022 08:03:23 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id e24-20020a17090ac21800b0020ae09e9724sm1525281pjt.53.2022.12.16.08.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 08:03:22 -0800 (PST)
Date:   Fri, 16 Dec 2022 08:03:22 -0800 (PST)
X-Google-Original-Date: Fri, 16 Dec 2022 07:34:37 PST (-0800)
Subject:     Re: [PATCH] RDMA/rxe: Avoid unused variable warnings on 32-bit targets
In-Reply-To: <bc1603aa-cdf5-e8d3-d8f4-9e9c4f4d5563@linux.dev>
CC:     jgg@nvidia.com, zyjzyj2000@gmail.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rivosinc.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     yanjun.zhu@linux.dev
Message-ID: <mhng-1ccd6ce2-3d2d-4fd7-89e6-04aead156903@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 15 Dec 2022 19:11:39 PST (-0800), yanjun.zhu@linux.dev wrote:
> 在 2022/12/16 7:28, Palmer Dabbelt 写道:
>> From: Palmer Dabbelt <palmer@rivosinc.com>
>>
>
> In
> https://patchwork.kernel.org/project/linux-rdma/patch/1669905568-62-2-git-send-email-yangx.jy@fujitsu.com/
>
> In this link, it seems that a similar commit for this problem.
> Please check it.

That one also fixes the compile issues for me.

>
> Thanks
> Zhu Yanjun
>
>> These variables are not used on 32-bit targets as there's a big ifdef
>> around their use.  This results on a handful of warnings for 32-bit
>> RISC-V allyesconfig:
>>
>>    CC      drivers/infiniband/sw/rxe/rxe_resp.o
>> linux/drivers/infiniband/sw/rxe/rxe_resp.c: In function 'atomic_write_reply':
>> linux/drivers/infiniband/sw/rxe/rxe_resp.c:794:13: error: unused variable 'payload' [-Werror=unused-variable]
>>    794 |         int payload = payload_size(pkt);
>>        |             ^~~~~~~
>> linux/drivers/infiniband/sw/rxe/rxe_resp.c:793:24: error: unused variable 'mr' [-Werror=unused-variable]
>>    793 |         struct rxe_mr *mr = qp->resp.mr;
>>        |                        ^~
>> linux/drivers/infiniband/sw/rxe/rxe_resp.c:791:19: error: unused variable 'dst' [-Werror=unused-variable]
>>    791 |         u64 src, *dst;
>>        |                   ^~~
>> linux/drivers/infiniband/sw/rxe/rxe_resp.c:791:13: error: unused variable 'src' [-Werror=unused-variable]
>>    791 |         u64 src, *dst;
>>        |             ^~~
>> cc1: all warnings being treated as errors
>>
>> Fixes: 034e285f8b99 ("RDMA/rxe: Make responder support atomic write on RC service")
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_resp.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
>> index 7a60c7709da0..18977d5a3316 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>> @@ -788,10 +788,10 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
>>   static enum resp_states atomic_write_reply(struct rxe_qp *qp,
>>   						struct rxe_pkt_info *pkt)
>>   {
>> -	u64 src, *dst;
>> -	struct resp_res *res = qp->resp.res;
>> -	struct rxe_mr *mr = qp->resp.mr;
>> -	int payload = payload_size(pkt);
>> +	__maybe_unused u64 src, *dst;
>> +	__maybe_unused struct resp_res *res = qp->resp.res;
>> +	__maybe_unused struct rxe_mr *mr = qp->resp.mr;
>> +	__maybe_unused int payload = payload_size(pkt);
>>
>>   	if (!res) {
>>   		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_WRITE_MASK);
