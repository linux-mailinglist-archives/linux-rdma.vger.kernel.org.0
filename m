Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED7E564313
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Jul 2022 00:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiGBW0h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 2 Jul 2022 18:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGBW0g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 2 Jul 2022 18:26:36 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED560BCA0;
        Sat,  2 Jul 2022 15:26:35 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id w24so5924607pjg.5;
        Sat, 02 Jul 2022 15:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wmKJjE5vKeaf/7hALO5BZs23LpV4XD9oNAnQEbe2c54=;
        b=QC7Jkj5q2yrsfUOxI+KOzbHijhSvrkaDkGaqsKy7GIghuiRz2YwfpQ2ZJgGjwg5mCT
         ITBSoMPFAk1r8uH5tPJMEic+rVkHjrqxgZXDjVwNIVviRtmYrhtpu2nNq6D4IoKwTykG
         Ga5S4JcrVUZpltFfLBm1fd8C/Es/pgQpV1K0OYk2EpOF3ieRmzjs59EOpY0Y/xMKd3u4
         lAJyBhWGBxxxwbMUP9Mz8Aky1bWqUK6orC7VePhMrF5wNYDNdRMn1W4ktKDbYd33oLV7
         L/hHcBtlQYQR2ku4xZZ62P6pWJH8eRAMVG4TaqYTur0VipeusFlBQSDU/6hFvuP4i+3s
         rIbA==
X-Gm-Message-State: AJIora9665/33BzJbI5kJi067ORqaD8+sn9UH5OlD/fJ8sThs95hlS4w
        RLRp/LcghrV6XSNfxZAxIvCR1+VJ81Q=
X-Google-Smtp-Source: AGRyM1uL34QRx1K6TCXvSfB1HsN3blmKOYVLBNVYYcMPGigJiHLyE1L2IYlMOgbfkXL2dAfdvTSo2g==
X-Received: by 2002:a17:90b:180b:b0:1ed:27d3:988f with SMTP id lw11-20020a17090b180b00b001ed27d3988fmr26679132pjb.170.1656800795309;
        Sat, 02 Jul 2022 15:26:35 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id cb14-20020a056a00430e00b0051bbe085f16sm18013245pfb.104.2022.07.02.15.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 15:26:34 -0700 (PDT)
Message-ID: <18afff6f-ce0a-1d98-aeb9-236878692e6b@acm.org>
Date:   Sat, 2 Jul 2022 15:26:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: use-after-free in srpt_enable_tpg()
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
Cc:     Mike Christie <michael.christie@oracle.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <17649b9c-7e42-1625-8bc9-8ad333ab771c@fujitsu.com>
 <ed7e268e-94c5-38b1-286d-e2cb10412334@acm.org>
 <fbaca135-891c-7ff3-d7ac-bd79609849f5@oracle.com>
 <20220701015934.1105-1-hdanton@sina.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220701015934.1105-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/30/22 18:59, Hillf Danton wrote:
> That hang can be skipped by removing the wait loop in
> srpt_release_sport() - in the direction of 9b64f7d0bb0a, sdev will not
> go home if any sport's refcount does not drop on ground. To do that, add
> port refcount to sdev in the diff below in bid to resurrect 9b64f7d0bb0a.
> 
> Then gc work can be added for dying sports to drop tpg after delaying a second.

I'm afraid that the patch from your email will lead to a use-after-free 
of sdev->pd. As long as a session is live the ch->qp pointer may be 
dereferenced. The sdev->pd pointer is stored in the pd member of struct 
ib_qp and hence may be dereferenced by any function that uses ch->qp.

Thanks,

Bart.
