Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDF87CCB78
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 20:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjJQS7w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 14:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344008AbjJQR62 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 13:58:28 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6048D9B
        for <linux-rdma@vger.kernel.org>; Tue, 17 Oct 2023 10:58:26 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5a9bc2ec556so3038914a12.0
        for <linux-rdma@vger.kernel.org>; Tue, 17 Oct 2023 10:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1697565506; x=1698170306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ERqNElzqK3ivGhZFkbR1xLkOQfN9J+nTp0C/iYJJ+VA=;
        b=XqcCAps+8YsariOAHQzEiFfjcJBTYAoekfrhKC19iXGjyXJ6ENGSqdRI+YvGocZW2d
         q1LRd80AQG7O3RKmKgHzU9Xpy9mokg3jHhKV1RC7Mbp2e6qXwArBlpkPRkHXueb0gVfQ
         wdk/HSdQ+uDKBn37ULmBA3kQ4xo3xAsWfz4IOKc+bFf3R8zittfSmgAVURIQ1B5OGIVM
         2ZK69269YHVQBzEjM7N5/EDNeuFxcij9iLOBpg7jz9qTz1NGXAbA9LX4OHq1ZQlVBE4J
         cdotPEOGW/87TAVDf4ZnvnaPvlPJ4z5cOZOstKm1NTOYLkkfk0t9vIIebniHDyc+2dx8
         25sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697565506; x=1698170306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERqNElzqK3ivGhZFkbR1xLkOQfN9J+nTp0C/iYJJ+VA=;
        b=vc7ivTVBNbaZoyXprIa1Qx7ao76cRXa4dttK20MhSZ+xnHCtGB9w079rGxNT8ZqbOK
         L1Jf19AAglQfWdUDpsVNo3zP3JTlAdcCNO+1F/1CmDIaEBkO7Xmk3d2VFTpNODodfjoX
         q2Bl3zz6LLEsYBSCOzymO+PVyjj5xJjOh898rXbwVqLDv+3Z5SfLwcmbvlYiKpAH0yYh
         y+EMdMgLMuuQtoW6jOIlFjkwj+avln9wd7zO5jJ2fiz+Pcyatn3T0fgmFEUMQXVBSw5y
         z2lG+cn5ULSvHWyWazQwpN0hS0JSh4IJIs9nhZAX93X2uffs1/4GqiYBOvorF9aT4aKH
         nPew==
X-Gm-Message-State: AOJu0Yz9XQqDUMlh2eJk6T+A2gKdxuvoq+g0mhhyBi+k8c9t52rnTAhg
        Lj0zIONZeRiv/pAdKQ/4uPdyKQ==
X-Google-Smtp-Source: AGHT+IHlUf16ZVZJPS3ADV9Yv03x8UI3R6UaRGantthvSPP+pLWQgx7zQmsS3AaqPA44Ed7qPZeJRg==
X-Received: by 2002:a17:90a:f410:b0:27d:4f1f:47f5 with SMTP id ch16-20020a17090af41000b0027d4f1f47f5mr2958963pjb.23.1697565505762;
        Tue, 17 Oct 2023 10:58:25 -0700 (PDT)
Received: from ziepe.ca ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id gz24-20020a17090b0ed800b0027d0af2e9c3sm6671197pjb.40.2023.10.17.10.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 10:58:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qsoKj-002t1w-CQ;
        Tue, 17 Oct 2023 14:58:21 -0300
Date:   Tue, 17 Oct 2023 14:58:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Bart Van Assche' <bvanassche@acm.org>,
        'Rain River' <rain.1986.08.12@gmail.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [bug report] blktests srp/002 hang
Message-ID: <20231017175821.GG282036@ziepe.ca>
References: <b80dae29-3a7c-f039-bc35-08c6e9f91197@gmail.com>
 <CAJr_XRAy4EHueAP-10=WSEa46j2aQBArdzYsq7OqSqR93Ue+ug@mail.gmail.com>
 <8aff9124-85c0-8e3b-dc35-1017b1540037@gmail.com>
 <3c84da83-cdbb-3326-b3f0-b2dee5f014e0@linux.dev>
 <4e7aac82-f006-aaa7-6769-d1c9691a0cec@gmail.com>
 <CAJr_XRCFuv_XO3Zk+pfq6C73CgDsnaJT4-G-jq1ds3bdg76iEA@mail.gmail.com>
 <OS7PR01MB1180450455E624D5CD977C461E5FCA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <29c5de53-cc61-4efc-8e8d-690e27756a16@acm.org>
 <OS7PR01MB118045AD711E93D223DCD6F17E5C3A@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <a3be5e98-e783-4108-a690-acc8a5cc5981@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3be5e98-e783-4108-a690-acc8a5cc5981@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 17, 2023 at 12:09:31PM -0500, Bob Pearson wrote:

 
> For qp#167 the call to srp_post_send() is followed by the rxe driver
> processing the send operation and generating a work completion which
> is posted to the send cq but there is never a following call to
> __srp_get_rx_iu() so the cqe is not received by srp and failure.

? I don't see this funcion in the kernel?  __srp_get_tx_iu ?
 
> I don't yet understand the logic of the srp driver to fix this but
> the problem is not in the rxe driver as far as I can tell.

It looks to me like __srp_get_tx_iu() is following the design pattern
where the send queue is only polled when it needs to allocate a new
send buffer - ie the send buffers are pre-allocated and cycle through
the queue.

So, it is not surprising this isn't being called if it is hung - the
hang is probably something that is preventing it from even wanting to
send, which is probably a receive side issue.

Followup back up from that point to isolate what is the missing
resouce to trigger send may bring some more clarity.

Alternatively if __srp_get_tx_iu() is failing then perhaps you've run
into an issue where it hit something rare and recovery does not work.

eg this kind of design pattern carries a subtle assumption that the rx
and send CQ are ordered together. Getting a rx CQ before a matching tx
CQ can trigger the unusual scenario where the send side runs out of
resources.

Jason
