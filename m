Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE90A71F0EB
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 19:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjFARiu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 13:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjFARit (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 13:38:49 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4498137
        for <linux-rdma@vger.kernel.org>; Thu,  1 Jun 2023 10:38:48 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-55854c3576eso742635eaf.1
        for <linux-rdma@vger.kernel.org>; Thu, 01 Jun 2023 10:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685641128; x=1688233128;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o7/iqCAuXddwk3r6p22rYoVySeZtm+E4uvWhfQKpZDs=;
        b=T8bN4WmKt/JwPviHZxDEMAQQq5cKly05Ux1LvVttSC1piYK7RkplFzkv6+nz52Actl
         4UKz+vMfz5UnC99IeDhO188teJ555uQ0Yo7qF4z7TQhoJ+kwTJAn66wgaNI8iqE2X6IG
         Ac379VKz/o3qkJIwuth5CM9tsJ6QvNPVdqVbLx1/mBNNVwZooQ/JxU03sJ0R2QAMcL4r
         anXIYEYXFrBbme/HOVe7JvvDzzbtkTgKAOIn2eE1ECa1GauVB/Y5uintAW4E98EaBqfb
         aN3PzkzwU7TGuaThSCLVjqSRVGCepcpIK8UNgsI7rWKSWVe8Weq10/6N5+U8hgPupvNT
         dEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685641128; x=1688233128;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7/iqCAuXddwk3r6p22rYoVySeZtm+E4uvWhfQKpZDs=;
        b=UTNkMiT5BgRVMVNcaij7ETd9RnDiCFSYEqc5aBCAwi8xRZsxtfq9fP17oPT6ZlQVXC
         PXL+LW5ViTWhcdpLxSp77ZhgLwZig/O62ZKWnEcbap2p6AONUE+tE9C4pqw/3b4e43AW
         SXCTehiI9jkS1WOo63sIRGbO888wIWGzVuYQ8g8cnDIuy8EQAnZmI8ZzjAH4YB7WbLln
         8JGBdDtKdJVJZzYC38zNNuQLmIKIhba9wu4giik+V0l+Otmt9uyDlUzG8Hd240pLh2wH
         Wg+dLs2y1Z5Xbv9zZPoZJLWiEtZmhiFG1tmVmSqEN2Uu5yAivXTKbokGGcyoWK75UORc
         Nr/Q==
X-Gm-Message-State: AC+VfDyM0cqQBpLSLloGL4MUwKJz9R+9N0pNefP3t/pMHFiNUo4nqzzx
        YFPhWQl+yeUYyTpZMgayESYb2XBaQfI=
X-Google-Smtp-Source: ACHHUZ4nACfsxQm+ck0xA1EY9LzVE1aCsE6WgD1JGXh+vvnCK+bMOWEt0wJbkBQW59PEaom4RwhXtQ==
X-Received: by 2002:a4a:97ed:0:b0:54f:629a:f581 with SMTP id x42-20020a4a97ed000000b0054f629af581mr4561724ooi.7.1685641128023;
        Thu, 01 Jun 2023 10:38:48 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:808f:9c5:a407:c332? (2603-8081-140c-1a00-808f-09c5-a407-c332.res6.spectrum.com. [2603:8081:140c:1a00:808f:9c5:a407:c332])
        by smtp.gmail.com with ESMTPSA id v12-20020a4aa40c000000b0055556a756bcsm7410513ool.7.2023.06.01.10.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 10:38:47 -0700 (PDT)
Message-ID: <a724a611-4911-eca6-b489-8fd74e5bc096@gmail.com>
Date:   Thu, 1 Jun 2023 12:38:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH for-next] RDMA/rxe: Fix packet length checks
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org, jhack@hpe.com
References: <20230517172242.1806340-1-rpearsonhpe@gmail.com>
 <ZHjWW/O9d2bAET4g@nvidia.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <ZHjWW/O9d2bAET4g@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/1/23 12:33, Jason Gunthorpe wrote:
> On Wed, May 17, 2023 at 12:22:42PM -0500, Bob Pearson wrote:
>> In rxe_net.c a received packet, from udp or loopback, is passed
>> to rxe_rcv() in rxe_recv.c as a udp packet. I.e. skb->data is
>> pointing at the udp header. But rxe_rcv() makes length checks
>> to verify the packet is long enough to hold the roce headers as
>> if it were a roce packet. I.e. skb->data pointing at the bth
>> header. A runt packet would appear to have 8 more bytes than it
>> actually does which may lead to incorrect behavior.
>>
>> This patch calls skb_pull() to adjust the skb to point at the
>> bth header before calling rxe_rcv() which fixes this error.
>>
>> Fixes: 8700e3e7c485 ("Soft RoCE driver")
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_net.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
> 
> Applied to for-rc, thanks
> 
> Jason
thanks
