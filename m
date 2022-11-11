Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50746624FBC
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 02:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiKKBk3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Nov 2022 20:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKKBk2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Nov 2022 20:40:28 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BC160EBE
        for <linux-rdma@vger.kernel.org>; Thu, 10 Nov 2022 17:40:27 -0800 (PST)
Message-ID: <b1e5e838-4060-7afe-f60c-cc24863dd156@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668130826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mN7q/pBtO6pGAPqOSAqlgWo38mLkfkjPLRTkqmo9ru4=;
        b=mFb61zE5ZUtihjCvCyfpN6NpYSkOonKC3ZkJaOX3lkGzwu1jhYb6FWVSwMo03/Q5VkFtZ4
        Wi8+DiWt88bjWMUDrmr6TihbjRCGY0Qv3eZL7xVMeJQDG69uO7I4rLKU98EgJrsxGtCtEY
        kOsQVneZ3NCM393D5urJ3rZ2AlBs2Rg=
Date:   Fri, 11 Nov 2022 09:40:19 +0800
MIME-Version: 1.0
Subject: Re: rxe patches
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
References: <Y21Ujbxz+B56hMjY@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <Y21Ujbxz+B56hMjY@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/11/11 3:44, Jason Gunthorpe 写道:
> I am looking at the patchworks here:
> 
> https://patchwork.kernel.org/project/linux-rd
Hi, Jason

I can not find any patch in this link.

> 
> And all I see is a huge number of rxe patches with no Reviewed-bys.

Sorry. I am busy with the work in the company. So I can not handle these 
patches in time. I will do my best to review these patches.

> 
> I need all of you in the rxe community to start looking at these. At a
> minimum group test these things. The changes are too big to expect me
> to deeply understand rxe (which I do not) and somehow approve them.
> 
> If this does not improve I will probably propose Bob as the maintainer
> of RXE and just take everything he sends, unreviewed by me.

Yes. If you will do, I am glad to welcome Bob as the maintainer of RXE.

Zhu Yanjun

> 
> Thanks,
> Jason

