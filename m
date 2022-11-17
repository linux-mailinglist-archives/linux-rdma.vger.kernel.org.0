Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F4062D3DA
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Nov 2022 08:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239095AbiKQHLy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Nov 2022 02:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKQHLt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Nov 2022 02:11:49 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534CF67139
        for <linux-rdma@vger.kernel.org>; Wed, 16 Nov 2022 23:11:48 -0800 (PST)
Subject: Re: [PATCH 1/8] RDMA/rtrs-srv: Refactor rtrs_srv_rdma_cm_handler
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668669106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Tau9zwmL7IyEw84W6hiJEXrqJg6Mub//kNDvqJwMAI=;
        b=w92zgS69JwPo0RN3DIQeOZlvByE458IsYvscYSI2y6cMwg2dVCa8XK7uWgGcoFls5jnI3r
        UUo0rSYvkVPXvYVa95IjHMn3okF7qpift55+XTYXWMy02zXywhPAjjCnGDy7AmbbUK3RND
        4+HcIKXlHO+lvI3BWF1itP/cVGxr8w4=
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     haris.iqbal@ionos.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
References: <20221116111400.7203-1-guoqing.jiang@linux.dev>
 <20221116111400.7203-2-guoqing.jiang@linux.dev>
 <CAMGffEmnzA6+2H_CbhusfQ0r68jo8j93jVau-qoX7=kJv_UNrA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <9c3cf1f5-bd66-7026-9847-1116997a7b9e@linux.dev>
Date:   Thu, 17 Nov 2022 15:11:36 +0800
MIME-Version: 1.0
In-Reply-To: <CAMGffEmnzA6+2H_CbhusfQ0r68jo8j93jVau-qoX7=kJv_UNrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11/17/22 1:52 PM, Jinpu Wang wrote:
> On Wed, Nov 16, 2022 at 12:14 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>> The RDMA_CM_EVENT_CONNECT_REQUEST is quite different to other types,
>> let's checking it separately at the beginning of routine, then we can
>> avoid the identation accordingly.
> There are two typos.
> s/checking/check
> s/identation/indentation.

Thanks! Will send a new version to fix all of them.

Guoqing
