Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068C96E4682
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Apr 2023 13:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjDQLbV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Apr 2023 07:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjDQLbT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Apr 2023 07:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEA093DE
        for <linux-rdma@vger.kernel.org>; Mon, 17 Apr 2023 04:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681730883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5KNRdeLRU2Xq/n1iDZzMtTXMvfraDKy7YfY/QU65aIc=;
        b=fNnByWbwE3qh87tApVtnWJFSqJ7utlLClJA2dkQ6incdbZgfFqC+4gpDVjCqTe2JwRFtep
        SvOoYKImmGDCRNj4vZ1cdmOERchoAHLGQTMXGVHXjZVwaAZUyWChPw8j2983Lpo5wY4CNj
        xP0K4XUk6OYmx2OZxh4GnLdQ+IEzFBs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-Otsm3X_oMdGiFFUDzAr2Vw-1; Mon, 17 Apr 2023 07:14:40 -0400
X-MC-Unique: Otsm3X_oMdGiFFUDzAr2Vw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f080f534acso8156405e9.0
        for <linux-rdma@vger.kernel.org>; Mon, 17 Apr 2023 04:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681730079; x=1684322079;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5KNRdeLRU2Xq/n1iDZzMtTXMvfraDKy7YfY/QU65aIc=;
        b=eoUQtVjSpELpNanmiNk/NXD79YR9pWSpXakvi8NUglKkueffW4jPg6RIPX7Wu6536g
         lblJjABumg0xKjHI7K/VfprQLJcX0uu1hSOf57Db/V2gGscK5AXRhkLHLO8w2xGIHuGt
         MR+WBW4N0fcG51mMRZnOg4qgZ+rJJmz7+fOnruFQn7WbJY5TLsdWGEBhkkNj7PG5bmpY
         RRjwJMj1eqzGxpgy3z17EqUw+ovzuN0OyiBD1NrdN8mLXhKxcdiyaSVJi5JnOJE9Cmnj
         FdRgegDseypUstQLRXvLBs/rpODmge62qaSo8WVWHfdjXqDSIEzBfo3vjGe7vNKX72jP
         ZaAA==
X-Gm-Message-State: AAQBX9e6t2rcCBBHQYEMW2XBdTBoU0lHx9TDIzPb94ICtu+/sb9XDfCf
        RsaQ64TsAsvmqebpB2KNvsmhyCjm7kAp7pWBo43sv7ZhAt3+iTIa3Drwp5N2QaQ9PsufIF9ii4D
        H2wnYaIYdfJXIw3xSjxOYXg==
X-Received: by 2002:a5d:650c:0:b0:2f8:3225:2bc2 with SMTP id x12-20020a5d650c000000b002f832252bc2mr4681543wru.41.1681730079148;
        Mon, 17 Apr 2023 04:14:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350bNt0CQlgSAneNNoqT/xp81/MyHZrBQz3dDdnffEdIUnbPzTF+43gFytbOZ+e3kttt+3w0ALw==
X-Received: by 2002:a5d:650c:0:b0:2f8:3225:2bc2 with SMTP id x12-20020a5d650c000000b002f832252bc2mr4681519wru.41.1681730078827;
        Mon, 17 Apr 2023 04:14:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:db07:68a9:6af5:ecdf? (p200300cbc700fc00db0768a96af5ecdf.dip0.t-ipconnect.de. [2003:cb:c700:fc00:db07:68a9:6af5:ecdf])
        by smtp.gmail.com with ESMTPSA id v3-20020adfe4c3000000b002f459afc809sm10282660wrm.72.2023.04.17.04.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 04:14:38 -0700 (PDT)
Message-ID: <eb624430-6fb5-0349-0798-3f71c39e8768@redhat.com>
Date:   Mon, 17 Apr 2023 13:14:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 6/7] mm/gup: remove vmas parameter from
 pin_user_pages()
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Bjorn Topel <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, io-uring@vger.kernel.org,
        bpf@vger.kernel.org
References: <cover.1681558407.git.lstoakes@gmail.com>
 <fa5487e54dfae725c84dfd7297b06567340165bd.1681558407.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <fa5487e54dfae725c84dfd7297b06567340165bd.1681558407.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 15.04.23 14:09, Lorenzo Stoakes wrote:
> After the introduction of FOLL_SAME_FILE we no longer require vmas for any
> invocation of pin_user_pages(), so eliminate this parameter from the
> function and all callers.
> 
> This clears the way to removing the vmas parameter from GUP altogether.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---

Ideally, we'd avoid FOLL_SAME_FILE as well

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

