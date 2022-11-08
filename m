Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8851E620C3C
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Nov 2022 10:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiKHJaY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Nov 2022 04:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbiKHJaW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Nov 2022 04:30:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC5213D77
        for <linux-rdma@vger.kernel.org>; Tue,  8 Nov 2022 01:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667899762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G/IvXa3Gtc42ocSwbE6e2PTXEI1xHOCM/WDymiGQVjk=;
        b=EclQgB/BAXWPmHv1CQSriGjM01041EmwLWXrYJNK4SB8YG848WwPaT3gtRThNKwuxzmdw5
        WIGW9R+7AM/5gAAZRH/0L5G44XvsMJQpHiO/l6SjGpDw5LLZtlzG5p9K4gQknYqLCl5Jpf
        5BIWRtsM4d1QsnoJfX3bzespR7vjkbA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-376-gRNyBM1qN2eDFPQ6Qe_dEw-1; Tue, 08 Nov 2022 04:29:21 -0500
X-MC-Unique: gRNyBM1qN2eDFPQ6Qe_dEw-1
Received: by mail-wm1-f71.google.com with SMTP id 1-20020a05600c028100b003cf7833293cso9645101wmk.3
        for <linux-rdma@vger.kernel.org>; Tue, 08 Nov 2022 01:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/IvXa3Gtc42ocSwbE6e2PTXEI1xHOCM/WDymiGQVjk=;
        b=CjvbFNEnECuVUXHF2lAQCKofJC+217F12nJ/vdwfsm8X5URFln8Km31XXIicSCKGlQ
         gNRHd3hts4RQJ/tZYkoFbvUScX2fTfpew3t0gZri+0hNh3lLShn1W46vjekRyd147QXY
         ZRJiCwVhfoJNh4eOPlajhy/WIbwgdJRzGWK0+W7wtmAFKvuQVWxkTLE+cilLDCq0yR42
         CAIYdXN5d61GUmEM2vuvvTDajCE73+qtXQ2TSjW25p0GvaNDC6pSInfOA4hwEITHeOiV
         XefWBYBZSDnTMC6o0L1bbqC9ViLdAYUH3kt0DH2iQcpxtj66h/fQ1xRk9OIGP1+jPlua
         SWEQ==
X-Gm-Message-State: ACrzQf2OY+l/CnCQ8AGuva5kYkqGlVP33D26woLWOwStYOT81i+Vq1jI
        Tbt6dVEhIpsDvowedeL283aaGiGj9czGYWHiGq/ABCu2rGT6snlWWPu6Lnd2swnkwmF3XLDFjvS
        wA1nR5zLkXg9ZLLTspsTfLw==
X-Received: by 2002:a1c:7418:0:b0:3cf:703a:4f0c with SMTP id p24-20020a1c7418000000b003cf703a4f0cmr31192089wmc.63.1667899760175;
        Tue, 08 Nov 2022 01:29:20 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5StZVkpugFYppLkRHp5xlGTjmqFOUyferk1nDQuYzjbb+gdKwEthZaHv8SGYCGJ8Geu++6Xg==
X-Received: by 2002:a1c:7418:0:b0:3cf:703a:4f0c with SMTP id p24-20020a1c7418000000b003cf703a4f0cmr31192042wmc.63.1667899759842;
        Tue, 08 Nov 2022 01:29:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:db00:6510:da8d:df40:abbb? (p200300cbc708db006510da8ddf40abbb.dip0.t-ipconnect.de. [2003:cb:c708:db00:6510:da8d:df40:abbb])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d420a000000b0023682011c1dsm9563940wrq.104.2022.11.08.01.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 01:29:19 -0800 (PST)
Message-ID: <ee9fceb8-f928-8754-d94f-54b662bb0c74@redhat.com>
Date:   Tue, 8 Nov 2022 10:29:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC 00/19] mm/gup: remove FOLL_FORCE usage from drivers
 (reliable R/O long-term pinning)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>
References: <20221107161740.144456-1-david@redhat.com>
 <CAHk-=wj51-dtxf8BQBYP+9Kc3ejq4Y0=-6hCbf_XAnkT3fsgDQ@mail.gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHk-=wj51-dtxf8BQBYP+9Kc3ejq4Y0=-6hCbf_XAnkT3fsgDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 07.11.22 18:27, Linus Torvalds wrote:
> On Mon, Nov 7, 2022 at 8:18 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> So instead, make R/O long-term pinning work as expected, by breaking COW
>> in a COW mapping early, such that we can remove any FOLL_FORCE usage from
>> drivers.
> 
> Nothing makes me unhappy from a quick scan through these patches.
> 
> And I'd really love to just have this long saga ended, and FOLL_FORCE
> finally relegated to purely ptrace accesses.
> 
> So an enthusiastic Ack from me.

Thanks Linus! My hope is that we can remove it from all drivers and not 
have to leave it in for some corner cases; so far it looks promising.

-- 
Thanks,

David / dhildenb

