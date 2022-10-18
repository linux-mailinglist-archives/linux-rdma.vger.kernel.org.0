Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A6F602F86
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 17:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJRPWR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 11:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiJRPWO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 11:22:14 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B180BB97A5
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 08:22:11 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-132b8f6f1b2so17149400fac.11
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 08:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HqScLkuFLI4C7y3OKmXiayrq9RvJv1Qo4um49+1PXkc=;
        b=A9m63d/ZShFR4a/LUJ/wNPkHCvD+nZJtAnjgB0QPaYDEZW2f/HaBzbMNBk3wBL3LxU
         HDxqaWYCIsMsRpYt4rjHogqLxjLKpl1NA4be5mzZZ8i5FFGpacJNN+NaNAUE7x4EvAFX
         3olX08zmEZT+k95Z/eB93qk+VoTbZHdXKEs1r1kRcv2tC35rCpNn1aUb2nS2f8RbaDfP
         7l+9t3AbianghGzOyR42uNyLGkws5W/hfY3tJbLwxqDudpLnuVdrNjMKbLxyzZziQ2nU
         Kv35I+it3aaN+G3/GGcQTy5V2V0CPxptNsDJrBlOXiz880KHwzBl5FyG+CSmUea/CCpO
         PytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HqScLkuFLI4C7y3OKmXiayrq9RvJv1Qo4um49+1PXkc=;
        b=3TANEbBvtPVpRBn0SAxtuWe+js/IVDtf7WBD0cEh4oBDGzdNFIbIwvQsIvLESBVCNf
         eRMDY9elfrBkrv9GRn+arAm1ex5Z2btuGsUOs21ronHDyzEaUDDB+VAgxfavogzTsQah
         hQjHaQ0S8gjRkzCjmO6rGv67TOS+w0rfpYfPHX1zXT+EoCGenNVcJIy3PhZuZhdBHkTa
         oaxRbc0iSXD5QnOk9z1ArhDLCkW98SLESbx+Hy4VN0njqAno7HWPCwUWDErBMaaOWAgB
         KrpSq2HddXoH3oVsC7waRxgyQOPRr9G8LCxx7HfAW7hLa6eEsFyNR7ufIK9l2gW6JQPv
         +JAQ==
X-Gm-Message-State: ACrzQf2/45ECu6XaKGCWYVUJwOeS9gGAbFXWEkzqMG7hkdnrVJA64dNJ
        DMglIxPlx2gExXSIDS09C+RqRQdLNFzMHw==
X-Google-Smtp-Source: AMsMyM5qC8l9a84vJskWy/eGBECqglyDodSkRNELbPbK9Uxa97cs4TqT0I4uL5qxfJPTL4NJJJK4mw==
X-Received: by 2002:a05:6870:f703:b0:132:3892:3bfc with SMTP id ej3-20020a056870f70300b0013238923bfcmr18266558oab.288.1666106530575;
        Tue, 18 Oct 2022 08:22:10 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:c2cf:2de0:3c3c:e52c? (2603-8081-140c-1a00-c2cf-2de0-3c3c-e52c.res6.spectrum.com. [2603:8081:140c:1a00:c2cf:2de0:3c3c:e52c])
        by smtp.gmail.com with ESMTPSA id q28-20020a05683022dc00b00661a0a256ffsm6041155otc.81.2022.10.18.08.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 08:22:10 -0700 (PDT)
Message-ID: <c178c3b6-8a3f-7167-4463-4a450684ea80@gmail.com>
Date:   Tue, 18 Oct 2022 10:22:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH for-next 16/16] RDMA/rxe: Add parameters to control task
 type
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
References: <20221018043345.4033-1-rpearsonhpe@gmail.com>
 <20221018043345.4033-17-rpearsonhpe@gmail.com> <Y05rjL+ufktJslNU@unreal>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <Y05rjL+ufktJslNU@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/18/22 04:02, Leon Romanovsky wrote:
> On Mon, Oct 17, 2022 at 11:33:47PM -0500, Bob Pearson wrote:
>> Add modparams to control the task types for req, comp, and resp
>> tasks.
> 
> You need to be more descriptive why module parameters are unavoidable.
> 
> Thanks

I asked Jason what was the best way here and didn't get an answer. These are tuning parameters.
Generally I am not sure how to present them to users. They are pretty specific to this
driver so the rdma app seems a bad choice. I know netlink is the preferred way to talk to
rdma-core but I haven't figured out how it works. I suspect this is temporary and work queues
will replace tasklets in this driver once people are used to it.

Bob
