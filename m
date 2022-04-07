Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB9E4F88FD
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 00:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiDGVqO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Apr 2022 17:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiDGVqN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Apr 2022 17:46:13 -0400
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752F531DCF
        for <linux-rdma@vger.kernel.org>; Thu,  7 Apr 2022 14:44:12 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id q19so6094950pgm.6
        for <linux-rdma@vger.kernel.org>; Thu, 07 Apr 2022 14:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EEQ6/ZjCggOaNIlSnPH+vi7YMLtmOPTl+473CRTr7i8=;
        b=R8YiFjJOh/gRt/akUXcJCnzXhD5R01hALERl8m8csZd7vseZZXzeSTyJFaHNhmD/m1
         Q+wyVLxEYSSRv7s29NB8aPfVDer5aOD2l1MeMdEwZ6++RgyGonRycQKa5D3E2P5EVk+e
         JTBtgdUBiUjPtgl034CH9/hghZs9JMVOpxRarGDM+nKCpIMAkI4fAwHsIUN91rGnKS7x
         8ETpk3+udBjS8DHUxzXJ1FCkVxsZr6HWgpWR2RILcQzhvKum50u3RGXSGtKHMToaQGIu
         f2owAz9cBqUzMgiu9ILB57ese19YHj1dxCdOH/eltCv1NN02AEEEZOs7nQ+B0Z1azUcG
         4/eg==
X-Gm-Message-State: AOAM531hbtA8u6d9aUmOANWz9iKRiQqdFbDIXa4fpQHuifSYWwP6l1pI
        y1Q5w59BzsKTKRhrcVVwppk=
X-Google-Smtp-Source: ABdhPJwE55PqtYcbsB9qKvNSFLwpDsRU/YjC3kDJJsyGXB0vq3wRXluyClT+iHyW2p0W5RErau/AGA==
X-Received: by 2002:a63:3718:0:b0:398:1086:e8ec with SMTP id e24-20020a633718000000b003981086e8ecmr13123510pga.498.1649367851805;
        Thu, 07 Apr 2022 14:44:11 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id be11-20020a056a001f0b00b004fb29215dd9sm21952146pfb.30.2022.04.07.14.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 14:44:10 -0700 (PDT)
Message-ID: <f7b84702-8001-70bf-2f26-704548b96279@acm.org>
Date:   Thu, 7 Apr 2022 14:44:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [bug report] rdma_rxe: WARNING: inconsistent lock state,
 inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>
References: <CAHj4cs-MT13RiEsWXUAcX_H5jEtjsebuZgSeUcfptNVuELgjYQ@mail.gmail.com>
 <1c16f053-0183-8343-9b36-62027c7260a8@acm.org>
 <CAFc_bgZ5oYtK2doybVT5fhrU+Ut-RfPT+g2z1bbf9V3jTtRTUg@mail.gmail.com>
 <d80141c8-04ee-e6ed-34d8-5cf43b49fd55@acm.org>
 <ca8722e6-db2d-0ab1-b8af-0932017df23e@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ca8722e6-db2d-0ab1-b8af-0932017df23e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/7/22 14:06, Bob Pearson wrote:
> On 4/7/22 14:49, Bart Van Assche wrote:
>> On 4/7/22 12:15, Robert Pearson wrote:
>>> I would say it is very possible. There was a period when the
>>> pool locks were switched to _bh spinlocks but that was later
>>> reversed back to _irqsave locks which cleaned up some failures. I
>>> don't know which version Yi Zhang was using. The root cause of
>>> this bug was caused by librdmacm making verbs API calls while
>>> holding _irqsave locks which I didn't figure out until later.
>> 
>> I can reproduce the issue Yi reported with kernel v5.18-rc1. Please
>> let me know if you need any additional information to reproduce
>> this issue.
> 
> From your note I can't figure out what you are running. Can you give
> me more details about the failing test case?

Hi Bob,

In Yi's email I found the following:

run blktests srp/001

That test case can be run as follows:

git clone https://github.com/osandov/blktests && cd blktests && make && 
sudo ./check -q srp/001

Thanks,

Bart.

