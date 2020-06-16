Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389451FABAC
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 10:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgFPIx2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 04:53:28 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:29886 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgFPIx2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jun 2020 04:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592297608; x=1623833608;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=9k/S37mQcLkwcJqroMlWZpRbvQs+IFwYaNsdcYsBvM0=;
  b=E1gEPh7UiH3+s1GIkUwBFUoeMEj4cXoIRfajV7KxiMkkXpDLR7p02kO7
   UOO6a72rrDz8a2EibyjMN5Twg1PbVp2K93nSiV9w1wShX4nrhmgddOe4g
   1NaKwGbEnG3Frl9B34Yw2jXAPz8qAXlp4ztfNb3IwBcjjFHdmCNuLIGoT
   M=;
IronPort-SDR: tbR2jULcTn8DJuTNS7gcOK+rt64nIaVIF59Rlj+MJPpcFc7n8nkJVsPjK73ImezFXh81B8Iswb
 Ha+QfyO/W1cQ==
X-IronPort-AV: E=Sophos;i="5.73,518,1583193600"; 
   d="scan'208";a="52583261"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 16 Jun 2020 08:53:22 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id 3349AA1ED5;
        Tue, 16 Jun 2020 08:53:21 +0000 (UTC)
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Jun 2020 08:53:20 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.53) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Jun 2020 08:53:16 +0000
Subject: Re: [PATCH for-next] RDMA/efa: Move provider specific attributes to
 ucontext allocation response
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        "Firas JahJah" <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20200615075920.58936-1-galpress@amazon.com>
 <20200616063045.GC2141420@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <cba7128b-c427-bc26-5f43-69a22463debc@amazon.com>
Date:   Tue, 16 Jun 2020 11:53:11 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200616063045.GC2141420@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.53]
X-ClientProxiedBy: EX13D35UWB002.ant.amazon.com (10.43.161.154) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 16/06/2020 9:30, Leon Romanovsky wrote:
> On Mon, Jun 15, 2020 at 10:59:20AM +0300, Gal Pressman wrote:
>> Provider specific attributes which are necessary for the userspace
>> functionality should be part of the alloc ucontext response, not query
>> device. This way a userspace provider could work without issuing a query
>> device verb call. However, the fields will remain in the query device
>> ABI in order to maintain backwards compatibility.
> 
> I don't really understand why "should be ..."? Device properties exposed
> here are per-device and will be equal to all ucontexts, so instead of
> doing one very fast system call, you are "punishing" every ucontext
> call.

I talked about it with Jason in the past, the query device verb is intended to
follow the IBA verb, alloc ucontext should return driver specific data that's
required to operate the user space provider.
A query device call should not be mandatory to load the provider.

Whether it's done through query device/ucontext response, both happen for each
new context call. With this patch, we gather all needed data in one system call
instead of two.

> What is wrong with calling one query_device before allocating any
> ucontext? What are you trying to achieve and what will it give?

How can you call query device without allocating a context?
