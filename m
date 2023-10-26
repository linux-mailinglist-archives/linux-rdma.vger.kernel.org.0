Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D327D7AB6
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Oct 2023 04:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjJZCMh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 22:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZCMg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 22:12:36 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC49A132
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 19:12:34 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b3f6f330d4so214236b6e.2
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 19:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698286354; x=1698891154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/yOzyDib7EqXurrx1CmjUpJe+/xDpI0q7iCGCrFuWI=;
        b=F9f5TMKQbixcOz0Kk9ocQsO0BnxAITyWOADS5idx5FODy2GBHBGLaWRndwbLqibV4R
         /K1IA9U3AfcE9TMUyt+dapUekU7mzhNR9rDZXrDsz35taik8rKMlQaYOK5C56kNBwpbk
         dgYO6veQxIeV/08YK9SSFUz2QfGeyJiHR2Oqx3pgUhV5QTQq7LYkMSFXKWnlcL0CPqJJ
         WqiNjaC+0R363zMPtbzEkxBhxd/96pBNyfH1x/S1PwB2ghdA/mBt6+MPCidt3Ab6upNL
         29qnMKEO07JLaHny5ime/1oOtIae8xiVvUveiy021LgY6k8KeBgV3P4R0NrJmY0TJ1C1
         Jd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698286354; x=1698891154;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/yOzyDib7EqXurrx1CmjUpJe+/xDpI0q7iCGCrFuWI=;
        b=A1YXnOJVVdSfj42neRPIMOZPz2DIUISlKUHx/J1eKF6AsV3uVJmlM3LFYmQG/n0Z/l
         tLrvdvhI8XFbr5w3JHGdWw1m/bxNs5wIAiPCe0TvsCfvBlRuBTdVn9pS4SlytBeJe702
         rVs8gEL63CePFKv3EA2m7blrYtYrhiBrYmyIIXCK/FAsU5U06wBWci14KnAvuSHUXxhl
         kO2Y2A1pm9SVOosF5K0y+irYlWXXEqGQYIFrLSeBTy4YAwaldfB4JouirSvgCDkSZNrn
         FIqEE0yJ3fwuH3MnjPeC5acXWy6+uXgbZbkwtVzZ7LIPnvDAhfQimaFWEEWHxMY2xCjT
         +CSw==
X-Gm-Message-State: AOJu0YxuJXR8H9d4bRZH5MBwnXWfra4R03BwgaOX7VZsCV/6dxGxcqfc
        2D6b4OHLUM+RCd3aFRV1oIA=
X-Google-Smtp-Source: AGHT+IE1e9yz4Kgt8rJLEDNEHwu9Cp669C8ylhjBDWnKn4b026A2eAP2GavUc7p1UoC8d7tUXuqFvw==
X-Received: by 2002:aca:2314:0:b0:3b2:f2af:33d3 with SMTP id e20-20020aca2314000000b003b2f2af33d3mr17197282oie.56.1698286353980;
        Wed, 25 Oct 2023 19:12:33 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:6e91:7bef:35e5:814d? (2603-8081-1405-679b-6e91-7bef-35e5-814d.res6.spectrum.com. [2603:8081:1405:679b:6e91:7bef:35e5:814d])
        by smtp.gmail.com with ESMTPSA id m22-20020a056808025600b003b2e3e0284fsm2583051oie.53.2023.10.25.19.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 19:12:33 -0700 (PDT)
Message-ID: <58a3f829-b6fc-436b-a432-ca9f28cfc620@gmail.com>
Date:   Wed, 25 Oct 2023 21:12:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: modify srq pyverbs test (new?) failing for the rxe driver
Content-Language: en-US
To:     Edward Srouji <edwards@nvidia.com>, jgg@nvidia.com,
        linux-rdma@vger.kernel.org
References: <401221fd-b41d-4db9-be22-b1af17b0d456@gmail.com>
 <99cafadf-a7c5-4217-9162-38fb6f8b56bf@gmail.com>
 <b4ee7c64-720e-5580-ce25-5d7c7991fca4@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <b4ee7c64-720e-5580-ce25-5d7c7991fca4@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 10/25/23 06:29, Edward Srouji wrote:
> You're right.
> I've patched the test and pushed it Upstream (see PR link below [1]).
> Please notify me if you're still having an issue after applying the patch.
> 

Works fine now. Thanks.

Bob
