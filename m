Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DA372335E
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 00:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjFEWyQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 18:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjFEWyP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 18:54:15 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CABBE
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 15:54:14 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4f616598bf3so358056e87.0
        for <linux-rdma@vger.kernel.org>; Mon, 05 Jun 2023 15:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686005653; x=1688597653;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2EvWCGHDNoozO1FOR7lM5gcguVZ0zjhFJ1ylGsAsv0=;
        b=as7z3mIeAEvmBNfLfn8quujYZGAebsxEiY39WqcPACK5DAFkZD0i6SoQ/JxY5+tWZN
         k+i/ZPojC/ZV5esgybeBLUWQ68LsVOMFZlDmd2y+pCDhGWqExdGAZqN4ZVzD0SpP/gNt
         U4rISyb8bHMWA4j6fMbRao38yrLJdvAmp/4KelmVRSUkc10/2KJ8h1+cDp+36GA3tAup
         L/HOnToxbKEuFRkMUpnwTUxNbK3tdWz00FFdqkeiVK7nylaPYwFfcJrwvy9bYqZD26DD
         7n7oLkdUBCPY+p4cWjx2g15O4qxBZ9bVLyXmqMmo13BY8xf9nmS+Q5cFBkQJOe5ZDcN4
         f38Q==
X-Gm-Message-State: AC+VfDwIjK/E2/GsbhY1rOHInOAwczN0KWLH7iQXnI+0O0wC474SoM97
        10/CXPrXA0Kli8s+ttAPeR0=
X-Google-Smtp-Source: ACHHUZ43gKZveTwR8g4wGNKuYSJ4nKK/PxKLCxqgvFZvEJFr8pnFOtLIRZeg9y6M9FtHKJ+XyaRybA==
X-Received: by 2002:a19:c511:0:b0:4f2:7381:150c with SMTP id w17-20020a19c511000000b004f27381150cmr161587lfe.1.1686005653105;
        Mon, 05 Jun 2023 15:54:13 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id l17-20020a19c211000000b004f13f4ec267sm1267026lfc.186.2023.06.05.15.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 15:54:12 -0700 (PDT)
Message-ID: <9aa62a5b-fc79-d0f5-d4c4-7e8506a67ac5@grimberg.me>
Date:   Tue, 6 Jun 2023 01:54:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH for-rc 0/3] IB/isert Bug fixes in ib_isert
Content-Language: en-US
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>, leon@kernel.org,
        linux-rdma@vger.kernel.org
References: <20230601094220.64810-1-saravanan.vajravel@broadcom.com>
 <ZHjXJMDWif75kbJC@nvidia.com>
 <51a676ee57e57ce3ad994be2462fc7f9@mail.gmail.com>
 <0c733a1c-d1c7-ddf9-3fdb-0adc2c1fc40c@grimberg.me>
In-Reply-To: <0c733a1c-d1c7-ddf9-3fdb-0adc2c1fc40c@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> Added Fixes tag. Sent v2 patch series.
> 
> Did you?

Yes you did...
