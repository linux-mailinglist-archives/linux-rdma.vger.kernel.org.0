Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9961171EEB7
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 18:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjFAQXd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 12:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjFAQXc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 12:23:32 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83C8186
        for <linux-rdma@vger.kernel.org>; Thu,  1 Jun 2023 09:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1685636611; x=1717172611;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=sM+WlY2JEQ0vQLrxq/ZmtorIZagwSbDU7e7PXwqXxyM=;
  b=IahsGSsTzvYAdpdq+sq2tuWoEmr1OLWo3HwnI/vjE8KfYMhoCb0nK+Ob
   sHqChSFpJKWbAC/bKeGolpXWM/j6aELVKYHdoE2D/6IHbJIm5deUh0T+p
   mEak41KRwScMt+UuJYxJ+agDhNMba6SvSeElGtchQpgnhUUqgCrBLbA5t
   I=;
X-IronPort-AV: E=Sophos;i="6.00,210,1681171200"; 
   d="scan'208";a="218020431"
Subject: Re: [PATCH] MAINTAINERS: Update maintainer of Amazon EFA driver
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 16:23:28 +0000
Received: from EX19D007EUA003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com (Postfix) with ESMTPS id 8BAA0A27D2;
        Thu,  1 Jun 2023 16:23:26 +0000 (UTC)
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19D007EUA003.ant.amazon.com (10.252.50.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 16:23:25 +0000
Received: from [192.168.94.45] (10.85.143.174) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 16:23:22 +0000
Message-ID: <64a963ec-ab8d-5c31-0dc3-011c835213ff@amazon.com>
Date:   Thu, 1 Jun 2023 19:23:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Gal Pressman <gal.pressman@linux.dev>, <jgg@nvidia.com>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <sleybo@amazon.com>, <matua@amazon.com>
References: <20230525094444.12570-1-mrgolin@amazon.com>
 <a8a18dfe-818d-03e3-8e7d-b186b1688767@linux.dev>
From:   "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <a8a18dfe-818d-03e3-8e7d-b186b1688767@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.85.143.174]
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/28/2023 9:54 AM, Gal Pressman wrote:

> Thanks, best of luck Michael!
> Please change me to a reviewer (R:), I would like to be CCed on patches.
Sure, sending v2. Thanks!
