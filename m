Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02DA258508
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Sep 2020 03:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgIABKq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Aug 2020 21:10:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38119 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgIABKp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Aug 2020 21:10:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id w13so7695861wrk.5
        for <linux-rdma@vger.kernel.org>; Mon, 31 Aug 2020 18:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RW3FYQY1UG8G/16reFHf5sZjdCvVSkC3BPot7vuIhRA=;
        b=jG+gTRtcxNRK8v8ssh+4g6aqQvWiSTVblNrEyBs+RTRAH1JEMgsPgvVdXeYox+t3nY
         oRxUaN/wuvbCtOTf3XbceSs7IGHcAohST1EX9zPsvVEOs4ctOxRVnPnpWoDsSoGgUNTt
         bPBanIuNjb9Mr5/kwnstkL2HRv671o2JRrJTxeNRnK2jRz8AaHYY+XzVfio/VI5eCAog
         /DnHViFfuUkKimtCQlFejiuDzyEZ/11GeaBwKeOmeZVSo8OrMJNVXWqYNugnGB5QdijV
         CKOg2w5n3ZcgQr4QUVlRR875OOLo4Np3EMmp+D2mmSD1JEzjbsloaUlwbaGXfW9QFnSU
         +A6w==
X-Gm-Message-State: AOAM530ZCZg2MmpX8uYpNrlhwXpdBXbVVVXrjsX9uwU6u7FdQTt8r1IH
        GIip2nCBnNyQdmYJxKYonHGTPJb8LFCp1w==
X-Google-Smtp-Source: ABdhPJySu2A3XX/f93f60GVUdOcRR4fjw3FwEhJlqWcdBGP51tvr3Rze5tlHjQ6w68943iA/kxozQQ==
X-Received: by 2002:a5d:6343:: with SMTP id b3mr4200737wrw.179.1598922643531;
        Mon, 31 Aug 2020 18:10:43 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:70b6:3990:a389:c0d1? ([2601:647:4802:9070:70b6:3990:a389:c0d1])
        by smtp.gmail.com with ESMTPSA id o124sm1631037wmb.2.2020.08.31.18.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 18:10:43 -0700 (PDT)
Subject: Re: [PATCH] IB/isert: fix unaligned immediate-data handling
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Rust <srust@blockbridge.com>,
        Doug Dumitru <doug@dumitru.com>
References: <20200830103209.378141-1-sagi@grimberg.me>
 <20200831121818.GZ24045@ziepe.ca>
 <8bc2755b-e7d6-5d9c-f5e0-e8036b28beb6@grimberg.me>
 <20200901010046.GA289251@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <03366642-e4e3-243a-4ced-df0303202763@grimberg.me>
Date:   Mon, 31 Aug 2020 18:10:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901010046.GA289251@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>>> Currently we allocate rx buffers in a single contiguous buffers
>>>> for headers (iser and iscsi) and data trailer. This means
>>>> that most likely the data starting offset is aligned to 76
>>>> bytes (size of both headers).
>>>>
>>>> This worked fine for years, but at some point this broke.
>>>> To fix this, we should avoid passing unaligned buffers for
>>>> I/O.
>>>
>>> That is a bit vauge - what suddenly broke it?
>>
>> Somewhere around the multipage bvec work that Ming did. The issue was
>> that brd assumed a 512 aligned page vector. IIRC the discussion settled
>> that the block layer expects a 512B aligned buffer(s).
> 
> I don't think the limit is from multipage bvec, and the limit is
> actually from driver since block layer just sets up the vectors which
> is passed to driver, see the following discussion:

Understood, fact is that this used to work (which is probably why this
was overlooked) and now it doesn't. Assumed it was related to multipage
bvec without a proof :)

I guess the basis was the original report:

 > Hi,
 >
 > We recently began testing 5.4 in preparation for migration from 4.14. One
 > of our tests found reproducible data corruption in 5.x kernels. The test
 > consists of a few basic single-issue writes to an iSER attached ramdisk.
 > The writes are subsequently verified with single-issue reads. We tracked
 > the corruption down using git bisect. The issue appears to have 
started in
 > 5.1 with the following commit:
 >
 > 3d75ca0adef4280650c6690a0c4702a74a6f3c95 block: introduce multi-page bvec
 > helpers

Anyways, I think it's a reasonable requirement and hence this fix...
