Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3807DA294
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 23:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjJ0VqU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 17:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ0VqT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 17:46:19 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E06129;
        Fri, 27 Oct 2023 14:46:17 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1cc30bf9e22so1433705ad.1;
        Fri, 27 Oct 2023 14:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698443177; x=1699047977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OqWYhZdOBKN0vuVuVk6oSf3RWtos4En+IaVgzSnRbmo=;
        b=qm6VKbBVjoq5rSN7BtIwckjRc/dFg2Okf1H57mk1SwTy1TWX+qK/ezL1MWHsPNW6eq
         Pp5zi7WcpDqhAFmpd+g0WWnJJHZ+VRUjISATeSJORPJ3cFxX35SdOqpZ6VUtkAkXqySV
         FBAAI49kaVM1/OcyeoiOsmxGcSsHh655H9au0AhF2JfEgFRJHrUQlEhMCUOz8NPQ3Y9j
         AAQkZJww9I4t985o7KydTZfw642LhPD7BzBF90MaVCDBo6R1gVnC5Ejnt1OPS0LVnIRX
         WTlHV+OerhPGCApIyuK7PuaT5r+7wPPCi/HMcZ7szLVibAeO3c5fuauAXMv49Hq4ALor
         rgxg==
X-Gm-Message-State: AOJu0Yy8iD5ZXbZoiUcYPjv0Ji5S6u/g+QQymtapPlLYMBPHI81okzuP
        95rePgikf16eGhL2ZK6l3M8=
X-Google-Smtp-Source: AGHT+IEqQVCKyAK6PoNXccrAGq1QX8X86RlikVytazJ0trsS/NzCRLw1zLhUtPA9bbXNotIm8oKywg==
X-Received: by 2002:a17:902:c94f:b0:1ca:eb17:b51a with SMTP id i15-20020a170902c94f00b001caeb17b51amr9024077pla.27.1698443177065;
        Fri, 27 Oct 2023 14:46:17 -0700 (PDT)
Received: from ?IPV6:2601:647:4d7e:54f3:667:4981:ffa1:7be1? ([2601:647:4d7e:54f3:667:4981:ffa1:7be1])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b001b9f032bb3dsm2084436pln.3.2023.10.27.14.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 14:46:16 -0700 (PDT)
Message-ID: <adad4ee6-ceef-4e45-a13d-048a1377e86f@acm.org>
Date:   Fri, 27 Oct 2023 14:46:14 -0700
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <53c18b2a-c3b2-4936-b654-12cb5f914622@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/27/23 01:17, Zhu Yanjun wrote:
> When ULP uses folio or compound page, ULP can not work well with RXE 
> after this commit is applied.

Isn't it the responsibility of the DMA mapping code to build an sg-list
for folios? Drivers like ib_srp see an sg-list, whether that comes from
a folio or from something else.

Bart.
