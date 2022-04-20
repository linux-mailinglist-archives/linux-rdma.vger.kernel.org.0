Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85086509354
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Apr 2022 01:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383059AbiDTXHl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 19:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383072AbiDTXHV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 19:07:21 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7FA205DA
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 16:04:33 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-e5e433d66dso3620023fac.5
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 16:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wM85BMzVyqhXwCMeo/bNrYbNKWB2u5ffon41L2Rbffw=;
        b=mdwthd3N2ZmWCPQXJh9Llfi/+z2jkK4ey5+wfl4wlLXTOcUmnKDzJZvGhVDGUZecfS
         stO1r9KSKSawiW0g6FhrBG5Xo/wI/7CCH3IkaEUFJKc8y/N+cxIPWzOXbTmxNbvdsPQE
         xPfCHN3Flq43oZtR9hlSloVBD4BsXyUzyOl3B/RHU4C7XUGBcnTeCl7GNlsIVLLP3IKK
         xq4EBxshzy6pbr99DyfFLHT2Udv8gkzMPauRYT+7ozZbbN2KS4u8/knYcN4NU+q7L610
         OM/kfHi/YGBVNglC4zkeKUxlGt+eT3rWaLzgMkrm3tPvb3k9KggILquQUnS/d6nqsXoo
         HxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wM85BMzVyqhXwCMeo/bNrYbNKWB2u5ffon41L2Rbffw=;
        b=vNH0wlXyzIJ3CgqSTEqYJ1tfloMe+SYENWGxrw923x/Z2stYLsg13HrvjRfKk4AOlI
         hqlmIyy/FejYN/pAc+/INEKUD1O1FIp8gbmkAcSEadnMiAoC62NNt6JineL9IG0dKVQz
         yAKNHQFi19vsFUjtyhUWqI8Kf0CAW8AG1de7sSez1e7UaMkQ0HX2K3+hup7w2Mlg2Qw9
         genEw2CWzKd0XoUv77Qcds719dwvEQnNhVPuOa1yljcgKT7apJpQcDU/cBbWTc/jqbPv
         N9XQGfVVcAjFlPwG9XVPmdVYb7VMYUJb+DnAxyEUOwM4GeU3MpluMBxFdrTObQKn0sCL
         eMwQ==
X-Gm-Message-State: AOAM531gPDxO7t2NWaVzSRQdK5zv9NmpzEhFC6GNlyOniyukZzA4dnmg
        mKLQ4D0GhkJZ0Mtoe3dO8XU=
X-Google-Smtp-Source: ABdhPJz9526nvOa7+GKeHqjgtxlVvLsBIeWZyMEJINBQ89kSreiTSxXiVeVJSux+22KG1YyqD6kNiw==
X-Received: by 2002:a05:6870:45a4:b0:dd:b08e:fa49 with SMTP id y36-20020a05687045a400b000ddb08efa49mr2705470oao.270.1650495873205;
        Wed, 20 Apr 2022 16:04:33 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:fa82:7fab:b7a7:9932? (2603-8081-140c-1a00-fa82-7fab-b7a7-9932.res6.spectrum.com. [2603:8081:140c:1a00:fa82:7fab:b7a7:9932])
        by smtp.gmail.com with ESMTPSA id f21-20020a056830205500b005cdb59d5d34sm6968193otp.81.2022.04.20.16.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 16:04:32 -0700 (PDT)
Message-ID: <fe069eac-889a-460f-ffb6-fc4e46ff3267@gmail.com>
Date:   Wed, 20 Apr 2022 18:04:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH for-next v13 00/10] Fix race conditions in rxe_pool
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220404215059.39819-1-rpearsonhpe@gmail.com>
 <20220408180659.GA3646477@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220408180659.GA3646477@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/8/22 13:06, Jason Gunthorpe wrote:
> On Mon, Apr 04, 2022 at 04:50:50PM -0500, Bob Pearson wrote:
>> There are several race conditions discovered in the current rdma_rxe
>> driver.  They mostly relate to races between normal operations and
>> destroying objects.  This patch series
>>  - Makes several minor cleanups in rxe_pool.[ch]
>>  - Adds wait for completions to the paths in verbs APIs which destroy
>>    objects.
>>  - Changes read side locking to rcu.
>>  - Moves object cleanup code to after ref count is zero
> 
> This all seems fine to me now, except for the question about the
> tasklets
> 
> Thanks,
> Jason

There has been a long delay because of the mr = NULL bug and the locking
problems. With the following patches applied (last to first) I do not
see any lockdep warnings, seg faults or anything else in dmesg for
long runs of

	pyverbs
	perftests (ib_xxx_bw, ib_xxx_lat)
	rping (node to node)
	blktests (srp)

These patches were in v13 of the "Fix race conditions" patch. I will send v14 today.
8d342cb8d7ce RDMA/rxe: Cleanup rxe_pool.c

6e4c52e04bc9 RDMA/rxe: Convert read side locking to rcu

e3e46d864b98 RDMA/rxe: Stop lookup of partially built objects

e1fb6b7225d0 RDMA/rxe: Enforce IBA C11-17

2607d042376f RDMA/rxe: Move mw cleanup code to rxe_mw_cleanup()

ca082913b915 RDMA/rxe: Move mr cleanup code to rxe_mr_cleanup()

394f24ebc81b RDMA/rxe: Move qp cleanup code to rxe_qp_do_cleanup()


3fb445b66e5c RDMA/rxe: Add rxe_srq_cleanup()

4730b0ed751a RDMA/rxe: Remove IB_SRQ_INIT_MASK


These patches are already submitted
d02e7a7266cf RDMA/rxe: Fix "RDMA/rxe: Cleanup rxe_mcast.c"

569aba28f67c RDMA/rxe: Fix "Replace mr by rkey in responder resources(2)"
 or whatever you called it.
5e74a5ecfb53 RDMA/rxe: Fix "Replace mr by rkey in responder resources"

007493744865 RDMA/rxe: Fix typo: replace paylen by payload


This patch was submitted to scsi by Bart and addressed long timeouts that
were not rxe related (same issue also happens with siw)
cdd844a1ba45 Revert "scsi: scsi_debug: Address races following module load"

If Zhu is not OK with this let know what bugs remain that need fixing.

Bob
