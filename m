Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6471E6A0F2A
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Feb 2023 19:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjBWSJL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Feb 2023 13:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjBWSJJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Feb 2023 13:09:09 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544B92CFCE
        for <linux-rdma@vger.kernel.org>; Thu, 23 Feb 2023 10:08:47 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id a14-20020a056830100e00b00690ed91749aso2610343otp.7
        for <linux-rdma@vger.kernel.org>; Thu, 23 Feb 2023 10:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dv7JxielYAtXhQHxyHxBzCisR+a4x03LlKWyslR0MDg=;
        b=jej39Pl/RlGyGdY0otgbKMRX+yP8zqpXt16AtJC5ZTB0sXPDJjaTmb8BZ1HU5qSMiD
         G8IyeHGpAWKwZzf5F4n/bYUILeauiF1nR6nQlstA/X3wW0ah54AaL4Ea2sQdfBBDZAYg
         twheo83kRiRWokWHZaRf0z7QrjM8ojGYSoZNjN/CbZJmYFwo7NWo9HKkMd4tKR3qIyOR
         FXv8aEEkb4enngBGZ0UmcsGIDZB14XLRgDDgLhHSL0kPQa7Ie1Qjl9QV73okL3wVbgC3
         ARMPJq6mrkuThbAsAE6BhHiT5MmyNPE5yxuzK1VU0pnWusDZ04WUISBJb4ga/aOCrNYC
         gcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dv7JxielYAtXhQHxyHxBzCisR+a4x03LlKWyslR0MDg=;
        b=HScWdZPeqNVuSB7ONatwlT7asvX6ywPFm9/0M8cpn7K91+xPOy/Evcz/8NJvPyizYd
         dMA/CMTaU8v8GpT/y8N4zqZeZZ7nOXlkZCc+c95TKLR3AI9iGV61bhjm9eruwhnhmdyD
         oE3spkb8GQ6OaQmanbFLk2F0wme56FrsTQ7rk1K1Mdiobnrqk7nDYXx85GLWrXCUpYQX
         kPivsC0mS2sy5p4qo7SmGy1xr/jMvga7c7HjL1K3XVhM8itdM2nsEp763Tojfq7HLiq5
         eqtKcvQoksLiqllI8qKxdOZ8v2GoELC12mIqJzTdechdm3EbLN4o6TQjyO4CJMZ3bD4l
         alwg==
X-Gm-Message-State: AO0yUKUO1Jfxqsk3mvj1JYgZVvwmL6br6VRzszWcRyvkknKovdEp8vRP
        1VPkB0ugrT5O48NUs5r9t4JtyqqbNl4=
X-Google-Smtp-Source: AK7set8bgp4NuTo+LN4sv7mjf3HALJ6qaN1W7lCGdSF/Nji4Zyn9kegCjfs9l4DMHkFhJHlA2ZFYpg==
X-Received: by 2002:a05:6830:3187:b0:68d:a0e5:d31f with SMTP id p7-20020a056830318700b0068da0e5d31fmr2926538ots.3.1677175726265;
        Thu, 23 Feb 2023 10:08:46 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:e92c:8850:3fad:351f? (2603-8081-140c-1a00-e92c-8850-3fad-351f.res6.spectrum.com. [2603:8081:140c:1a00:e92c:8850:3fad:351f])
        by smtp.gmail.com with ESMTPSA id n23-20020a9d7117000000b0068bb73bd95esm2726971otj.58.2023.02.23.10.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 10:08:45 -0800 (PST)
Message-ID: <3921c085-7f05-0116-302c-fe766fd37655@gmail.com>
Date:   Thu, 23 Feb 2023 12:08:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH for-next] RDMA/rxe: Remove extra rxe_get(qp) in
 rxe_rcv_mcast_pkt
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@nvidia.com, linux-rdma@vger.kernel.org
References: <20230221205428.5052-1-rpearsonhpe@gmail.com>
 <Y/VTLrx8ayveJ9/w@nvidia.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <Y/VTLrx8ayveJ9/w@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/21/23 17:26, Jason Gunthorpe wrote:
> On Tue, Feb 21, 2023 at 02:54:29PM -0600, Bob Pearson wrote:
>> The rxe driver implements UD multicast support by cloning an incoming
>> request packet to give one each to the qp's that belong to the multi-
>> cast group. If there are N qp's in the group N-1 clones are created
>> and for each one a reference is taken to the ib device and a reference
>> is taken to the destination qp. This matches the behavior of non
>> multicast packets. The packet itself which already has a reference
>> to the ib device and the qp is given to the last qp.
>>
>> Incorrectly, rxe_rcv_mcast_pkt() takes an additional qp reference
>> which is not needed and will prevent the qp from being destroyed
>> without an error timeout. This patch removes that qp reference.

This was all wrong. The incoming packet had qpn = IB_MULTICAST_QPN
so it did *not* lookup the qp and take a reference. 

>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_recv.c | 1 -
>>  1 file changed, 1 deletion(-)
> 
> Needs a fixes line..
> 
> Jason

Please withdraw this patch.

Bob
