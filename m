Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C1258810A
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Aug 2022 19:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiHBR3k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Aug 2022 13:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbiHBR3i (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Aug 2022 13:29:38 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69824AD4E;
        Tue,  2 Aug 2022 10:29:36 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so16095078pjk.1;
        Tue, 02 Aug 2022 10:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=mfYHixUbEcOqG9todPTMIfXVXyVYJLrmy28abC934W0=;
        b=x4VfKw2pmiW6YYGT5MkTAkg72OTBIjJidtrWMJpGf9SZ4OGqwAtPYq2QNtnyO0bfqi
         n7ax5pQb2JD3FWgfOu0BKqWmOc62gKs/e5ANkhfwHhs2nG+2Mb/FqPgE9A7qr4RluyXS
         0tO6XFppm2ua/EX2v9DSy8PMoy6DoelilYwXiqiOX+tsBHvbmNH5Kss0ffVql55dlF1J
         PTjaGjp9cSJQM7x/l/rEgO2CEsB7DCxScgLpZcWhHmb4CIfkfCMbcQeCvg+xNayVBgHR
         NHoLaRvRy1pfSS1r4cU2m92snWclCEZ7S7HVfzp2er0bPuAAKM9jBMdj/oc6qs7DpcgA
         H8sw==
X-Gm-Message-State: ACgBeo0vtu+BFByYtCdcxwIA55Z7O6SHN2/XZHyV7hK9llRg/BZSBUUK
        TpRS0vvoqkimJxJ8IMiq474=
X-Google-Smtp-Source: AA6agR7maEFOdljm2WfYy0VxJ11rsgURrCxl4XGiWIlyA14D/fUc1uHAuXZIxJTFt0VyrKyhQmEMoQ==
X-Received: by 2002:a17:90a:c1:b0:1f4:f757:6b48 with SMTP id v1-20020a17090a00c100b001f4f7576b48mr572641pjd.56.1659461376031;
        Tue, 02 Aug 2022 10:29:36 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:5297:9162:3271:e5df? ([2620:15c:211:201:5297:9162:3271:e5df])
        by smtp.gmail.com with ESMTPSA id bt21-20020a17090af01500b001f1ea1152aasm8719634pjb.57.2022.08.02.10.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 10:29:35 -0700 (PDT)
Message-ID: <0efde7b8-35fc-5412-f896-5a5b09fa265e@acm.org>
Date:   Tue, 2 Aug 2022 10:29:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/ib_srpt: unify checking rdma_cm_id condition in
 srpt_cm_req_recv()
Content-Language: en-US
To:     Li Zhijian <lizhijian@fujitsu.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <1659336226-2-1-git-send-email-lizhijian@fujitsu.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1659336226-2-1-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/31/22 23:43, Li Zhijian wrote:
> Although rdma_cm_id and ib_cm_id passing to srpt_cm_req_recv() are
> exclusive currently, all other checking condition are using rdma_cm_id.
> So unify the 'if' condition to make the code more clear.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
