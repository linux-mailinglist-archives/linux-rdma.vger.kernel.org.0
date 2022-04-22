Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4A450C3D9
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Apr 2022 01:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbiDVWPP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Apr 2022 18:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiDVWPC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Apr 2022 18:15:02 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D803A234085
        for <linux-rdma@vger.kernel.org>; Fri, 22 Apr 2022 14:04:31 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-e5c42b6e31so9855094fac.12
        for <linux-rdma@vger.kernel.org>; Fri, 22 Apr 2022 14:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=WYOsMMIxHq0fFBdiBIW3TLBYniqx0EDq5QZVaEMBx5M=;
        b=L0GX4+6Br3Hy166l4GS3KwRr8qI7osC4ACzpw6ztzGzdfHB2FMDzU7Cuwvkgfzap7S
         IsoSiC0vg9f5VNVXwdsuVUYIcnJHFC2TQlxb1G75d7L2W+8Rm8oxHI3tlX5bjpLAds4d
         gnfIw/qmz1QrVgIpiB+6iLFJxdTBKw58SIrhaVEutqRxwvsQppB4pdgDG34iKRSp9MTO
         8MyjTgcLiJuS6cXJMSMt5QuMVnqEv6FR30qJleSuvj3FP1dYBddFVeZvufJxfdTQ2RN9
         gLpa2df/DYGAcP6qe/Hlbz+buBKc4OmWuSLCSAGRaTdGQ3+LC0z1z2IJsw4eD33YJCgZ
         WK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=WYOsMMIxHq0fFBdiBIW3TLBYniqx0EDq5QZVaEMBx5M=;
        b=y9GSp32fyWteQYgoKl393Ojcg6T7ig5R2c2RSjcrA8wR5a3V0SExi6PC6OfXHv8/np
         GbgJvRw+PCqkiivn1xrMxCKCzp3Xu4n2rtk1UuAjgZLnYgFBld3evms8CTb0ADl7CoBP
         7iUs0I9PlPajP7EFRJcWZIVjHUD+bUQXCWkpn3A7FCa/se1qJ7xbGyKIkPtRXqp7xUYn
         nxayGw02iOuBj/YqJI+rM+FSB7ncKuxm9OBOYE/vkV/d1icnJmp5X11sYROeCgMchRoN
         ESB8d7f2dMcTnAjDZz89f6d7FM1SFnTHrz0cJHDL/gzIO1THCyg06GNqYYG3ukMIn3aC
         TH1Q==
X-Gm-Message-State: AOAM533Jub2SGEYQ0uQNsKfAvgMH69eNtp8TokKI+itUDeERddM8F/WJ
        ERhyiNUMKzxFOZUunrpRhnv3M9wMmYE=
X-Google-Smtp-Source: ABdhPJwEa6/DleDUaMcBjEQoSVVyzStBNATtZdJhRwnfh1JbRJz6APCIJOHNKMoUmVfZ6WRpI5qCiA==
X-Received: by 2002:a05:6870:d20d:b0:e2:62c9:c7d with SMTP id g13-20020a056870d20d00b000e262c90c7dmr6925176oac.158.1650661471248;
        Fri, 22 Apr 2022 14:04:31 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:e508:94f4:5ee:8557? (2603-8081-140c-1a00-e508-94f4-05ee-8557.res6.spectrum.com. [2603:8081:140c:1a00:e508:94f4:5ee:8557])
        by smtp.gmail.com with ESMTPSA id 9-20020a9d0289000000b005e8f77e3022sm1153312otl.57.2022.04.22.14.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 14:04:31 -0700 (PDT)
Message-ID: <5de7d1a9-a7ac-aea5-d11c-49423d3f0bf1@gmail.com>
Date:   Fri, 22 Apr 2022 16:04:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: bug report for rdma_rxe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Local operations in the rdma_rxe driver are not obviously idempotent. But, the
RC retry mechanism backs up the send queue to the point of the wqe that is
currently being acknowledged and re-walks the sq. Each send or write operation is
retried with the exception that the first one is truncated by the packets already
having been acknowledged. Each read and atomic operation is resent except that
read data already received in the first wqe is not requested. But all the
local operations are replayed. The problem is local invalidate which is destructive.
For example

sq:	some operation that times out
	bind mw to mr
	some other operation
	invalidate mw
	invalidate mr

can't be replayed because invalidating the mr makes the second bind fail.
There are lots of other examples where things go wrong.

To make things worse the send queue timer is never cleared and for typical
timeout values goes off every few msec whether anything actually failed.

Bob
