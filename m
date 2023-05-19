Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D7E708FF6
	for <lists+linux-rdma@lfdr.de>; Fri, 19 May 2023 08:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjESGlt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 May 2023 02:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjESGls (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 May 2023 02:41:48 -0400
Received: from out-14.mta0.migadu.com (out-14.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D2A10F
        for <linux-rdma@vger.kernel.org>; Thu, 18 May 2023 23:41:47 -0700 (PDT)
Message-ID: <0f12adcd-0112-3b0e-57b5-ecf707670bc0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684478505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3HV1fajR6x9mpLUSsVelb8cqAgo8L9k5fwnGLhKz0OU=;
        b=K3r3AavLBbuuCGMffhrY/KWhRyGGivH+RYwXCukOmP7bcCLGU2eu50r6pR809rcm8jDYD+
        UOVQScvRpkEv7eaWQg8Ppa1mB8C8hL071dCwUFNLXJRsnpNuY7g8Pe8znhp/C8Nh781jwv
        /6nERG3G4Zqc1BIdluCXrvY8WitCZCk=
Date:   Fri, 19 May 2023 14:41:40 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next v5 0/7] On-Demand Paging on SoftRoCE
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com
References: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

On 5/18/23 16:21, Daisuke Matsuda wrote:
> [2] [PATCH for-next v3 0/7] On-Demand Paging on SoftRoCE
> https://lore.kernel.org/lkml/cover.1671772917.git.matsuda-daisuke@fujitsu.com/

Quote from above link

"There is a problem that data on DAX-enabled filesystem cannot be 
duplicated with
software RAID or other hardware methods."

Could you elaborate a bit more about the problem or any links about it? 
Thank you.

Guoqing
