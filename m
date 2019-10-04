Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52C5ACBAA4
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 14:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387421AbfJDMjq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 08:39:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46107 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387412AbfJDMjq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 08:39:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id o18so6955574wrv.13;
        Fri, 04 Oct 2019 05:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+pseJbkmmDayD6+Jn87ClcbkQZcbbnaCL4Buh3G3qjM=;
        b=Tlq12npjJdGVRcZaaPRBmG1UulkC6ZNwLepKNYSEfIo0Qh6MeOhT7tRWrZBPNSPw5M
         aaeSYYvt6/iEBMJIPNczjKEeCdPcMIsW4dfZQoAPmURw4qMo15KUa/UFTxT9eNhZH0J8
         XJnZ/hiTVceeN4eKrbpjrNYAnoNJTOGbC+J4YjyHn+2wjS+ufM0jhrncj29Z6uNcDKNd
         M5fdcy8iq3vHGNhQ2TkpQ8eLxTztVtSMW6kqpDFFWfSwaREahz5/237RIOOM2bGFe9fU
         R0IA9BPZjnxxXj9y3hDHCF03ZfA0zB8RDKUzTmznMeJYwSXBbVJ7VJmjyVm93RAJZwKn
         M1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=+pseJbkmmDayD6+Jn87ClcbkQZcbbnaCL4Buh3G3qjM=;
        b=tMoJc49Ti/cC+xIkNU6QOIzqO/oT9Cstads4dhQrgi52Szg2AApCR6TqRBjyH6UfFr
         RwCawyM/tnZeLvBbw/1rOpmd05UrxlIUry1hANbKStMnqoiR+WrCBFXCsZWN+GyfN+Vl
         sJdO74dVg+eQI8bj0P/TqvWn52n0d0QofZAq6uQ5xzHmtOd534tDuTC5FvwLBvgmQ/jC
         oYXolkv1oCI1iRgFZ9QmTsRwh+wXaUNKE+fgnKiNoUqq0Xycr77nIOf5HyzT0j9wJZtv
         pRSO0B9Iwyxy4UkaK0X7cVEGY5MtlDIKlNvryITTwSxBouzgVqJShOG39yNUuMxvxUkM
         fJ7Q==
X-Gm-Message-State: APjAAAU/Srl4+w56u74RvHRhHHWz+c5Rst0b8v5c67DLZeuCDm3qQ+FH
        5HPscn7zYGKGkIKa+2t99ZaTpQlJ
X-Google-Smtp-Source: APXvYqxS6UQ2bnKgNuObVtiLOcssLnA6+jvl5KiXC3jViySnaZ7X43QXzYkaXntWj7e4NjMxK9d0eQ==
X-Received: by 2002:adf:ec09:: with SMTP id x9mr12081882wrn.308.1570192783261;
        Fri, 04 Oct 2019 05:39:43 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id a2sm2607667wrt.45.2019.10.04.05.39.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 05:39:42 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 03/11] drm/amdgpu: convert amdgpu_vm_it to half closed
 intervals
To:     Michel Lespinasse <walken@google.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20191003201858.11666-1-dave@stgolabs.net>
 <20191003201858.11666-4-dave@stgolabs.net>
 <dc9cc8c4-7275-43be-5bed-91384e3246ae@amd.com>
 <20191004113628.GA260828@google.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <232710bd-dc54-9d77-6f0f-24a91a28cbf6@gmail.com>
Date:   Fri, 4 Oct 2019 14:39:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004113628.GA260828@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Michel,

Am 04.10.19 um 13:36 schrieb Michel Lespinasse:
> On Fri, Oct 04, 2019 at 06:54:54AM +0000, Koenig, Christian wrote:
>> Am 03.10.19 um 22:18 schrieb Davidlohr Bueso:
>>> The amdgpu_vm interval tree really wants [a, b) intervals,
>> NAK, we explicitly do need an [a, b[ interval here.
> Hi Christian,
>
> Just wanted to confirm where you stand on this patch, since I think
> you reconsidered your initial position after first looking at 9/11
> from this series.
>
> I do not know the amdgpu code well, but I think the changes should be
> fine - in struct amdgpu_bo_va_mapping, the "end" field will hold what
> was previously stored in the "last" field, plus one. The expectation
> is that overflows should not be an issue there, as "end" is explicitly
> declared as an uint64, and as the code was previously computing
> "last + 1" in many places.
>
> Does that seem workable to you ?

No, we computed last + 1 in a couple of debug places were it doesn't 
hurt us and IIRC we currently cheat a bit because we use pfn instead of 
addresses on some other places.

But that is only a leftover from radeon and we need to fix that sooner 
or later, cause essentially the physical address space of the device is 
really full 64bits, e.g. 0x0-0xffffffffffffffff.

So that only fits into a 64bit int when we use half open/closed 
intervals, but would wrap around to zero if we use a closed interval.

I initially thought that the set was changing the interval tree into 
always using a closed interval, but that seems to have been a 
misunderstanding.

Regards,
Christian.

>
> Thanks,
>

