Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F3352ACEA
	for <lists+linux-rdma@lfdr.de>; Tue, 17 May 2022 22:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240633AbiEQUpA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 May 2022 16:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiEQUo7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 May 2022 16:44:59 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6104517D4
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 13:44:57 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id f9so43705ejc.0
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 13:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tzi+gMRl141FK7OMF8rTJZjNpbyFGjMMbNVttgfjAhE=;
        b=7RuKMYjYRXHaRp7c9a8yf69aP6NgrN5MZ48HyRa71eChK9t8FQLE6tKhfdRL7Y7dAH
         oPBjbdQrtTV7NyJbB24pKXnVugGBOGI+z+wKt/mF6NtKvNStm+6ld3kFWL3yo1z+IMvC
         p8Si4/6esDJba2scqou9cpyVK9uMWEvsW0UQNtipCwH7149zTx+kBtgqGLH9zoc9dH6I
         jQvtymvxtiMYgxC2X9SODd4yZasdvxqpowSvQayTviLRFsSmUWj7VFcGckdxLW9c/9wa
         zqHJ7lG7NP0/nfjGev5Q+k1TzbPj8bVRDT2XmUXQIy6qHlrMQVSWVLW62V86HUThUVMK
         tfhw==
X-Gm-Message-State: AOAM530HGEL/kkwxRu6ls0Brzp6aN147lLsyCROhHDdn6F2VYVm2vnMf
        JCrLuryU7GpIlUJEAb80Nug=
X-Google-Smtp-Source: ABdhPJxJgoFMOHBQbwavRtgqeLpNjOHI5SO1Gv/iT23zTyJMMHEoz1sl0rgI6iIPAuLAoEkAqZOIMQ==
X-Received: by 2002:a17:907:6d0e:b0:6f5:28b5:5f49 with SMTP id sa14-20020a1709076d0e00b006f528b55f49mr20857496ejc.577.1652820296332;
        Tue, 17 May 2022 13:44:56 -0700 (PDT)
Received: from [192.168.50.14] (178-117-55-239.access.telenet.be. [178.117.55.239])
        by smtp.gmail.com with ESMTPSA id d29-20020a1709067a1d00b006f3ef214e39sm103444ejo.159.2022.05.17.13.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 13:44:55 -0700 (PDT)
Message-ID: <88e9b45d-e7cd-45ce-ad12-d1ec8e238bc8@acm.org>
Date:   Tue, 17 May 2022 22:44:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Apparent regression in blktests since 5.18-rc1+
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        Douglas Gilbert <dgilbert@interlog.com>
References: <e7c31ebb-60c0-cd57-2009-5e9383ecc472@gmail.com>
 <cf8b9980-3965-a4f6-07e0-d4b25755b0db@acm.org>
 <4b0153c7-a8e9-98de-26ae-d421434a116d@linux.dev>
 <20220507012952.GH49344@nvidia.com>
 <81571bbb-c5d2-9b68-765d-f004eb7ba6fd@linux.dev>
 <43c2fed8-699f-19fe-81fa-c5f5b4af646f@gmail.com>
 <4c3439c3-6279-804f-63b2-99d8529e5d3d@acm.org>
 <b2908c39-636a-1cba-db22-838640385d84@gmail.com>
 <529dbb0a-0b75-9752-62a3-a1235565aa1a@acm.org>
 <66379f8e-c7ab-1daf-b2a8-19d0368e229f@gmail.com>
 <7b8f7d5c-cda5-a160-b988-186b371a6e4d@acm.org>
 <ad81fbce-0b8c-c49f-00d5-c8c2678a5779@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ad81fbce-0b8c-c49f-00d5-c8c2678a5779@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/17/22 17:21, Bob Pearson wrote:
> Thanks Bart. I was able to follow your steps above. But unfortunately not much has changed.
> I still see hangs in siw (with no code changes by me) and also in rxe (but here I have
> fixed some lockdep warnings so it will run in a debug kernel.) There are two test cases that
> cause the most problems. srp/002 and srp/011. 011 always fails solidly. 002 sometimes hangs and
> sometimes completes but with failed status. The rest of the tests all pass.
> 
> Both tests hang at a line that looks like
> 	scsi host6: ib_srp: Already connected to target port with id_ext=...
> 
> When 002 completes but fails there are 14 second gaps at some of the same lines in the trace.
> This has the feel of the earlier problem with the 3 minute timeout that was fixed by the
> patch (revert ... scsi_debug.c) that you sent and is applied here.
> 
> I really don't know how to make progress here. If anyone knows what is happening at the
> already connected lines let me know. They seem normal except for the long gaps and hangs
> when they occur.

How about sharing the kernel config file that you are using in your 
tests such that I can try to reproduce the behavior that you are observing?

Thanks,

Bart.
