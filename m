Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551CA7B3216
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Sep 2023 14:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjI2MMX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Sep 2023 08:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbjI2MMW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Sep 2023 08:12:22 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55781AA
        for <linux-rdma@vger.kernel.org>; Fri, 29 Sep 2023 05:12:19 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5780040cb81so11206247a12.1
        for <linux-rdma@vger.kernel.org>; Fri, 29 Sep 2023 05:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695989539; x=1696594339; darn=vger.kernel.org;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:to:from:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dL45IqGKFINeZXD3V3WGPUqTF0v8lHv/e4pLArJn4Hc=;
        b=dYJtUaMpT5O0+5mRfRoubk0/8+yORzdSOgLHe9bD74OWsU574/sAeUq94PnQVJSi7j
         u5DAPDsdAdEyf8VuvlavFSgF11YySAZQo2LAUmVnTeV6Ju2rKcX07mCscix+w7+eigJt
         oCc3ZM6ah40AyTUD8ohDWkVWFbXLDvKZXkY+zt5tI3YfPJ4+zLVeuQwFcD20OpYx1JBO
         BMoi23NNI8O48mF/xeL4ngAu55QDbLfR2eimL+JucOhK+4QGTkebWOzIPZXhLUyEucEd
         xrWtiwMxHpxHjZNaEO9/f7L5Tedr11iOFbg1JHEN6b5eSaxcgeZ2octAkcMens9b1ipr
         8wCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695989539; x=1696594339;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:to:from:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dL45IqGKFINeZXD3V3WGPUqTF0v8lHv/e4pLArJn4Hc=;
        b=tVUWzv9XkhJijtZTBSS1C2C82pYlw88xhQ0d9Vk3tamEY9nAhueUuZ059JvupkGpel
         7gsApACo7J3tInijMcXtjcmSNBvZOVe4uLwNtFyWkMRpF15IN30ftNUjmV3UDPTyPXED
         NkWdwEptH2KNPAatsRBMAkiK8OHzw/U9Xu5ObKYrs5kw5T8q22OLFE6FiZoCiamgATJW
         twSJbBnjn34HYYbqdkjK3K4oArnghaFISuLzElZUWqBflgEglp8c8jUYTv2ZH++pH1wk
         oHB+wpyskszdjrB77yJLQU0auVDH0i4MxveJ8/K0P/CQtyZWdl2/+SWeYLfacqPNIpgX
         5QeQ==
X-Gm-Message-State: AOJu0YzcVMCN5kZL9LgR4AWhxqw9CDWgNgZmm8GJI/bFbYdJ+vN2OW4r
        T6iXc1beOY8At5e8S4i+gfwi8DmSEVg=
X-Google-Smtp-Source: AGHT+IGmMi6nw1rlnhFTG0ndh/isS6fjwRJSF1VFU4O5o6QtCzywZZ4ljQQ7L+Bocc6Zk8baXLkMJQ==
X-Received: by 2002:a17:90b:398:b0:268:dad:2fdc with SMTP id ga24-20020a17090b039800b002680dad2fdcmr3993517pjb.21.1695989539083;
        Fri, 29 Sep 2023 05:12:19 -0700 (PDT)
Received: from ?IPv6:2409:4063:6d8e:3a0d:a52b:e67f:d8b3:45d0? ([2409:4063:6d8e:3a0d:a52b:e67f:d8b3:45d0])
        by smtp.gmail.com with ESMTPSA id n2-20020a17090a394200b0027782f611d1sm1388946pjf.36.2023.09.29.05.12.16
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 05:12:18 -0700 (PDT)
Reply-To: businesssolutionsrocks23@gmail.com
From:   Ayan Seth <ayansethjk3@gmail.com>
To:     linux-rdma@vger.kernel.org
Subject: RE: Meeting request with
Message-ID: <5d1cd82a-0ef9-fcc0-0846-ea2f9bf46a94@gmail.com>
Date:   Fri, 29 Sep 2023 17:42:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi ,

Circling back on my previous email if you have a requirement for Mobile 
App OR Web App Development service.

Can we schedule a quick call for Tuesday (3rd october) or Wednesday (4th 
October)?

Please suggest a suitable time based on your availability. Please share 
your contact information to connect.

Best Regards,
Ayan Seth

On Tuesday 22 August 2023 5:43 PM, Ayan Seth wrote:


Hi ,

We are a Software development company creating solutions for many 
industries across all over the world.

We follow the latest development approaches and technologies to build 
web applications that meet your requirements.

Our development teams only use modern and scalable technologies to 
deliver a mobile or web application the way you mean it.

Can we have a quick call to discuss if we can be of some assistance to 
you? Please share your phone number to reach you.

Thanks & Regards,
Ayan Seth
