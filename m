Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99DD1D6692
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2020 10:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgEQIfl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 May 2020 04:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgEQIfl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 17 May 2020 04:35:41 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D127DC061A0C
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2020 01:35:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k12so6222095wmj.3
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2020 01:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Z5Az9UYrH5GWBS677fTUyuXYmTyvfXR+WC6LgJrEOCM=;
        b=c9nfYBbdHkc/nKXVRLBwedJkAgtx0WlBjAiPAAgj3hZGtiqelrm52AOmYp9+Vi9ztT
         RxrE91WrCnzgs9dA5k3j2gY3SellY4i7ZpqVNxmQ9UKdEwNFsa0PgK9GhM69cz37uVdn
         KYR4Wakauzc+/z0DIlliRwKej+3tP9mTqxdD26/nNDRY+3vs2lPOXtENjANEA8t2oB6i
         Es/bdVdkpZ6s5Qem7C6jyCTB3EAtXfl4bK4COCk/6qqUEEewC2/PXwI26nk6P2qOKDdE
         ISUfOnTGT2hLD83/mhlTZBXj5zLnVuJBQffSTW7zEGrTpti/RSIFmj59KPXdYlgUqgJq
         bf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Z5Az9UYrH5GWBS677fTUyuXYmTyvfXR+WC6LgJrEOCM=;
        b=TxUbDfM+d3wfb7eOSFNtK9C7OeZcDXb2kZcQqag9gl0+uhxuatRzH+BDRZPwOXeKdJ
         CuZAHDP/fRqvTjXJzLrQPbf2oPDDEdCnEJxb6O/3TIYMn0ZBY2P0OAPAcGcjeIpaShTD
         jtGbAM/mV7c1hTkBoAsszuu1YFXSa29US3yTiHoXS6JS7BiUUypkQ+jhwb4fnFeSKZim
         LSmjaIBGba0Fuz1JMhj+y0bqhcRdXWi3QkYgm7G4uBP43ACzvh5zPMBICzIRc/hcV0Ds
         JehWBzvtXV3/M5C9ZI/noKPvVP/rG/hFCytYRTvkwLJrJ6dydktsVuOk7HuLOVv1rSI/
         zY/Q==
X-Gm-Message-State: AOAM532Yzq0dmOumYK8CfJ037LGx638YXpQtGcfKQPrd1L0/cLngI02Q
        K1p7Ak5JuP/JGW4RCQWNSnc=
X-Google-Smtp-Source: ABdhPJy7z+JEDFL53Lf6318MvrEzMpIG1/PsWJ8AmReuDx+DvqGbd1UMeuaxAJqBFhA15U5GI6MXLQ==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr13906337wmg.161.1589704539425;
        Sun, 17 May 2020 01:35:39 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:89ec:cfad:2acd:dac2? ([2601:647:4802:9070:89ec:cfad:2acd:dac2])
        by smtp.gmail.com with ESMTPSA id b2sm12775643wrm.30.2020.05.17.01.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2020 01:35:38 -0700 (PDT)
Subject: Re: [PATCH] IB/iser: Remove support for FMR memory registration
To:     Alexey Lyashkov <umka@cloudlinux.com>,
        Max Gurtovoy <maxg@mellanox.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Israel Rukshin <israelr@mellanox.com>, sagi@grimberg.me,
        jgg@mellanox.com, linux-rdma@vger.kernel.org, dledford@redhat.com,
        sergeygo@mellanox.com
References: <1589299739-16570-1-git-send-email-israelr@mellanox.com>
 <20200512171633.GO4814@unreal> <5b8b0b51-83e3-06c2-9b99-dec0862c0e5b@acm.org>
 <49391e02-803b-f705-b00e-e48efd278759@mellanox.com>
 <0C22D41B-89CD-4B2D-B514-8EA06F2233D7@cloudlinux.com>
From:   Sagi Grimberg <sagigrim@gmail.com>
Message-ID: <9fe7ac28-4702-d537-a568-c3eb0b5b0ce3@gmail.com>
Date:   Sun, 17 May 2020 01:35:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0C22D41B-89CD-4B2D-B514-8EA06F2233D7@cloudlinux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/14/20 3:09 AM, Alexey Lyashkov wrote:
> CX3 with fast registration isn’t stable enough.
> I was make this change for Lustre for year or two ago, but it was 
> reverted by serious bugs.

This must be issues with the Lustre implementation, all the rest of the 
ULPs (almost) default
to FRWR.
