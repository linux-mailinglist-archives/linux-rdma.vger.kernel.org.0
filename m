Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8DE03ACF4F
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 17:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhFRPlW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 11:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhFRPlV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 11:41:21 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255BFC061574
        for <linux-rdma@vger.kernel.org>; Fri, 18 Jun 2021 08:39:12 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so10098177oti.2
        for <linux-rdma@vger.kernel.org>; Fri, 18 Jun 2021 08:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ic1FuZM1BK3d7xlaZFrohhknMVoo72soISrvlnHxxy0=;
        b=oyYSXgvP+82f2sdD2tA492IsbyASrXHa6KDv2Y2JQmq4W5jjdZYfNPpWZas+n0Z9Lz
         VQqhAKdtUXBvKqUjfrSXdTivz/6FHPGHeP2tzq0u1zZW7do9PppqC51Dh98UPADhuRrS
         9Z/OXMe2Ll+APoW2bi0HY8F6rHqTc5jCT+ZDHgguRs66DiMRpyvKHbS6KOmIjS9mijB3
         Kn53G4oVaB2VqiAuzvl9xHaWL6bL90S9r/RFJO6gkzfNGEav6pw3uBIE4lf9jEQC30CK
         RzkhAq1tadPaHrnvTi5nvop7Ph84DxOPEHCv3prce4xibE4XAicawEiJ4uJX+KAJUPBS
         CEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ic1FuZM1BK3d7xlaZFrohhknMVoo72soISrvlnHxxy0=;
        b=PhmNhIsxN1uKpwafTgjsHceRCDagV3/XADPDq6A0ubYtd0wX4FDb0YBaokK6X10yOA
         IfIgRmZPm2Zx4Yirsm1un0s69Z/iMkQK8lXwJvjm/SiCA+QQePEymobFFB1nYsq/mqUf
         FAPkV25TitUgkraxVNHzDGS9oUC34yY1UHTG4jAfxshbpdzMGIX4AuXOc5Es9D4G0XLq
         tY9ipGMnLCkGz/BVnt9DL/DDfPwOTL3P0gysLsohHtX2ngWN43qbJuHc2M0ML1dpg8PF
         gtku7uI3X0IxKMVlKRTsPHLE7SP9kV4qCD4dNdiMSk/2KAH2ro+DHvt5Qy/UeRw1CoHE
         nOsQ==
X-Gm-Message-State: AOAM532A+wbRKs4eh1NY5gdVWjd3ekc7/GTlP+IzUJHl+cSqiWZKjGnr
        osTpa6KERJUBNgK69fME2uRhzTizGlQ=
X-Google-Smtp-Source: ABdhPJx+lYSEOAwkj0PvL03zD/f+yQF+qQVqlF1OUDJKy0SXf7IZMzBLB7jfuxCLIsMe7J5O/fnmlg==
X-Received: by 2002:a9d:588c:: with SMTP id x12mr9528693otg.193.1624030751416;
        Fri, 18 Jun 2021 08:39:11 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:2fce:3453:431e:5204? (2603-8081-140c-1a00-2fce-3453-431e-5204.res6.spectrum.com. [2603:8081:140c:1a00:2fce:3453:431e:5204])
        by smtp.gmail.com with ESMTPSA id j3sm1833235oii.46.2021.06.18.08.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 08:39:11 -0700 (PDT)
Subject: Re: [PATCH for-next v9 00/10] RDMA/rxe: Implement memory windows
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, monis@mellanox.com,
        linux-rdma@vger.kernel.org
References: <20210608042552.33275-1-rpearsonhpe@gmail.com>
 <20210618131927.GA1898298@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <0105425c-2ce4-33ef-223c-98dd0d391084@gmail.com>
Date:   Fri, 18 Jun 2021 10:39:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210618131927.GA1898298@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/18/21 8:19 AM, Jason Gunthorpe wrote:
> On Mon, Jun 07, 2021 at 11:25:43PM -0500, Bob Pearson wrote:
>> This series of patches implement memory windows for the rdma_rxe
>> driver. This is a shorter reimplementation of an earlier patch set.
>> They apply to and depend on the current for-next linux rdma tree.
> 
>> Bob Pearson (10):
>>   RDMA/rxe: Add bind MW fields to rxe_send_wr
>>   RDMA/rxe: Return errors for add index and key
>>   RDMA/rxe: Enable MW object pool
>>   RDMA/rxe: Add ib_alloc_mw and ib_dealloc_mw verbs
>>   RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
>>   RDMA/rxe: Move local ops to subroutine
>>   RDMA/rxe: Add support for bind MW work requests
>>   RDMA/rxe: Implement invalidate MW operations
>>   RDMA/rxe: Implement memory access through MWs
>>   RDMA/rxe: Disallow MR dereg and invalidate when bound
> 
> Applied to for-next, thanks
> 
> Jason
> 

Thanks. I updated the provider in roce-core by applying clang-format-diff. I am not really sure it any better but I am convinced it is logically the same. Looks like the earlier commit already got accepted. So you can take this one or throw it away if you wish. I don't care one way or the other.

Bob
