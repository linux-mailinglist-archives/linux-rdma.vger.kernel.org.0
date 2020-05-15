Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54761D4F95
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2020 15:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgEONxE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 May 2020 09:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgEONxE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 May 2020 09:53:04 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A2DC05BD09
        for <linux-rdma@vger.kernel.org>; Fri, 15 May 2020 06:53:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x2so976364pfx.7
        for <linux-rdma@vger.kernel.org>; Fri, 15 May 2020 06:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KLHDMMAfcXZ/sKsrs2509XkriszmE5YcTBkAUiw9NP0=;
        b=qW8u9dwLX6Pw5v4y6WxHDJ6iEH9Y1g0kvElJUII+0IqDiBUpd5WnaxwRtnd6+sV1Iq
         pMEzmb6dZr2tqxZwoX194wLFsO31RV+8UXj72w6QxPiFxsg21ScITE2skoazff5xzG1l
         KI8eza5f1jYi1+XK98blCugSTl03hvxkCsQDGv1rqOk1A/zseVeXIRuNBN2QVDFs2Jn6
         UEekGgx1LU1JBcu2cXQ76UwVsKOdbyDK7iQnjGbgFpNJRGpaMStxRwyUEoCZZnmo/mMJ
         5w2tzpqOwpVadOE0z8BPv9PR7E2iAXRATTgE6haWbSp52yajsh4BB0A81ytnihrdxpKR
         eQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KLHDMMAfcXZ/sKsrs2509XkriszmE5YcTBkAUiw9NP0=;
        b=o9N2JtxrQEImZpHfgrlc3+RlsbyMaT+aRAJq9ieZ6y2gnkqOioXG7mLXpQ2vrThxJB
         xdcUpgs0lmwAb3N6I/PQyLkpgEgYg6PR6eV2LS8rT7oRhGPnzBqoYRpLvlRZNuy9CrE6
         dRF8q3N4zrYIYoIgyiAYZhZhJSLUlyf7ZGlmVeb0B2IF3qe3oQ1G1jREDmDAK55VrtBX
         RGcexNOZWNqmkyUhS8cw15DM9+lz2BmZmn0qa5oZsFF/nKC9CGPp4qfRuVzlLI2oPCTb
         GhaWomVB3Kmbt0C+SgvXYNJXEbo+KIGiJqAExJ8WHLaLT5Gr4gJY5Ul3w2czclfYZELN
         W+ew==
X-Gm-Message-State: AOAM5300OlTmKvtNSGwjpyxR7wCvNhiJm4qbyKcueeVBoLuwTyXLrJJV
        FvukDSNtTlZj6oPYWXrHG7r/kQ==
X-Google-Smtp-Source: ABdhPJxgv7XbaHg/4AQxteRaeeW3ROhmjMu7FDQUH73FPz430Br2KwdmCoDucndGudp8IY6VCFIgDA==
X-Received: by 2002:a63:5a5d:: with SMTP id k29mr3266957pgm.176.1589550782324;
        Fri, 15 May 2020 06:53:02 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21d6::1089? ([2620:10d:c090:400::5:7df0])
        by smtp.gmail.com with ESMTPSA id u45sm1739435pjb.7.2020.05.15.06.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 06:53:01 -0700 (PDT)
Subject: Re: [PATCH v15 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>
References: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
 <CAHg0HuyYO913MmHt7qi12T6mVXo9nabUs6GJyqRAGfWAdfPjCQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e04fc798-ee25-53a5-fae0-5985306b55fd@kernel.dk>
Date:   Fri, 15 May 2020 07:53:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHg0HuyYO913MmHt7qi12T6mVXo9nabUs6GJyqRAGfWAdfPjCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/15/20 4:29 AM, Danil Kipnis wrote:
> Hi Jens,
> 
> we've fixed the kbuild cross-compile problem identified for our
> patches for 5.7-rc4. The block part has been reviewed by Bart van
> Assche (thanks a lot Bart), we also replaced idr by xarray there as
> Jason suggested. You planned to queue us
> for 5.7: https://www.spinics.net/lists/linux-rdma/msg88472.html. Could
> you please give Jason an OK to take this through the rdma tree, see
> https://www.spinics.net/lists/linux-rdma/msg91400.html?

My main worry isn't the current state of it, it's more how it's going
to be handled going forward. If you're definitely going to maintain
the upstream code in a suitable fashion, and not maintain an on-the-side
version that you push to clients, then I'm fine with it going upstream
and you can add my acked-by to the block part of the series.

But maintaining the upstream version as the canonical version is key
here.

-- 
Jens Axboe

