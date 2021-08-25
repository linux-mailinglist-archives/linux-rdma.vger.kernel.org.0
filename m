Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1553F7DF0
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Aug 2021 23:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhHYVpK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Aug 2021 17:45:10 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:51915 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbhHYVpI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Aug 2021 17:45:08 -0400
Received: by mail-pj1-f49.google.com with SMTP id oa17so693707pjb.1;
        Wed, 25 Aug 2021 14:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/iCaQmw0mVspWtMkXRo5AjWEYDfVjC1L0GlLteTtCrA=;
        b=XgnordZdOZAm7wHkfEd0eoFJ2SJBdF1ncZRAiyx8p8PH01+hFrvNyum205pownfflL
         LmebXHa3R8/NdpvJR7eHuyK/TsYZbZfhzrbQu3NrYnNc1B3SNxE3dW7gzaWRTqxnTSs2
         hMChFr/+Rd8g50Waxb0jFcbBY8IZ8NpQJsNHUm3dRGmWS2r9UkgVkyrohAkrJviMJG/H
         SlC1PPtrtabKMnTXlosaw/YnkaeAiqApxbGsWD1a2Ax0AlO4rxCF4bweUuWoZVLjKoUI
         VVGAzc8G1F3EJRmqP0nIAAq+a747LfsuS12uVA0WhVUgxwcgSxPW2oSHU2rgJH6hyUMj
         IuaQ==
X-Gm-Message-State: AOAM531WvWJmVmTj/EfW47P2BzFD7klRzFRn8oIVEk9YRj/ToraVYvTM
        /5e/E31a48EOlspdE6K0tei2xYOI+yo=
X-Google-Smtp-Source: ABdhPJxna7cCboYCHeHgJXNZZ7lzBlir1EuTeA6z3bdLmLS/CO2RrtSUi+QvCuRl8i5FQaJzr9PVPA==
X-Received: by 2002:a17:902:6b47:b0:12f:6c5f:ab4f with SMTP id g7-20020a1709026b4700b0012f6c5fab4fmr555076plt.17.1629927861515;
        Wed, 25 Aug 2021 14:44:21 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:5f7b:5bac:8246:4328])
        by smtp.gmail.com with ESMTPSA id on15sm5960054pjb.19.2021.08.25.14.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 14:44:20 -0700 (PDT)
Subject: Re: v5.14 RXE driver broken?
To:     Bob Pearson <rpearsonhpe@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <c3d1a966-b9b0-d015-38ec-86270b5045fc@acm.org>
 <CAD=hENcriq-mwnvzY3UdowuGpKb=Uekvk-v8Lj0G=QB-qK0kJg@mail.gmail.com>
 <20210825163219.GY543798@ziepe.ca>
 <423ed740-96e7-aebb-3e6f-7416108f5a62@acm.org>
 <bac1d404-ae2b-c6cc-a065-de2dab25bea9@acm.org>
 <c4550410-5b5a-b460-c57c-af2008b5c0e9@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f436017c-fa40-3e62-8f75-94ea01f36127@acm.org>
Date:   Wed, 25 Aug 2021 14:44:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <c4550410-5b5a-b460-c57c-af2008b5c0e9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/25/21 2:09 PM, Bob Pearson wrote:
> Are you seeing the ib_alloc_mr() failure in 5.14? I thought that was just a
> 5.13 thing. I am still not seeing that error in my test setup. I am getting > a soft lockup error after ~20 seconds. During most of that there is a> constant exchange of req/ack packets with nothing else happening.
> 
> If you want I can send you a patch to print out error messages from MR
> allocation.

Hi Bob,

I see the ib_alloc_mr() failures with kernel v5.14 in two different VMs. A
different Linux distro has been installed in each VM.

If it would help your debugging efforts, please send me the patch that prints
out the MR allocation error messages.

Bart.
