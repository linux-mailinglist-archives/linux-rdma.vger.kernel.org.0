Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A267DAA16
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Oct 2023 01:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjJ1XH3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Oct 2023 19:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1XH2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 28 Oct 2023 19:07:28 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E110CF;
        Sat, 28 Oct 2023 16:07:26 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6be840283ceso3067165b3a.3;
        Sat, 28 Oct 2023 16:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698534446; x=1699139246;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDlPBkLdn2EAK6+ebgcvjT1S6LOy4Uub2C1Sv2Bx9Lc=;
        b=PPFEQ2N4WdYE5udC1tpQ9bFxHn2cKSh7wAI6Q06p3HwugYDqAcz5APKCLhEX/K+8I5
         wCkgQ2+VxT16pZKPNPOzsypwQGW6JltXQbofN38RwLFaKYiN8Q6uG0gPUQJujpoGAWkp
         lxH2ruByNzrZvk6E3V/+oXoiCq2gXN7PyXJCNcvNADUfcy5GKSo1hJVR8rkUIdeH24OF
         f4yXZR0wPeIRErTEphJfOOprGiOGT76tYilJFIxn05DCerKUPhJB7hpu0gPlwWTJU/e3
         52jnrsB3nGnzdZVGn/AH2D6PaWBoV8pi3w34lOhiyyHFVyGFcwlCzRV4Q5AgG5DTsxpz
         anAg==
X-Gm-Message-State: AOJu0Yyhd1aW2wf1WyuYuglVIJh7oM/5xSDoiIw/pGar59OzcBhWpN34
        aQiLU952al3O5JOmMweF170=
X-Google-Smtp-Source: AGHT+IFhJa+1mVncSE0wPTEE2mIe537HRM5rVISqh5B77tiL+T93sCHuen690B6KoaDZGmH83Lkmkg==
X-Received: by 2002:a05:6a00:93aa:b0:6be:bf7:fda5 with SMTP id ka42-20020a056a0093aa00b006be0bf7fda5mr6220884pfb.12.1698534445490;
        Sat, 28 Oct 2023 16:07:25 -0700 (PDT)
Received: from ?IPV6:2601:647:4d7e:54f3:667:4981:ffa1:7be1? ([2601:647:4d7e:54f3:667:4981:ffa1:7be1])
        by smtp.gmail.com with ESMTPSA id m16-20020aa78a10000000b0068bc6a75848sm3422684pfa.156.2023.10.28.16.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Oct 2023 16:07:24 -0700 (PDT)
Message-ID: <a344b3b0-a43f-47eb-b5e4-9d54cda62518@acm.org>
Date:   Sat, 28 Oct 2023 16:07:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] RDMA/rxe: don't allow registering !PAGE_SIZE mr
Content-Language: en-US
To:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Li Zhijian <lizhijian@fujitsu.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        matsuda-daisuke@fujitsu.com
References: <20231027054154.2935054-1-lizhijian@fujitsu.com>
 <53c18b2a-c3b2-4936-b654-12cb5f914622@linux.dev>
 <adad4ee6-ceef-4e45-a13d-048a1377e86f@acm.org>
 <45c23e30-8405-470b-825c-e5166cd8a313@linux.dev>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <45c23e30-8405-470b-825c-e5166cd8a313@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/27/23 19:48, Zhu Yanjun wrote:
> In this case, ULP with folio will not work well with current RXE after 
> this commit is applied.

Why not? RDMA ULPs like the SRP initiator driver use ib_map_mr_sg(). The
latter function calls rxe_map_mr_sg() if the RXE driver is used. 
rxe_map_mr_sg() calls ib_sg_to_pages(). ib_sg_to_pages() translates
SG-entries that are larger than a virtual memory page into multiple
entries with size mr->page_size.

Thanks,

Bart.

