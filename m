Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8502271B42
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Sep 2020 09:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIUHOK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Sep 2020 03:14:10 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:25423 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgIUHOK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Sep 2020 03:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600672450; x=1632208450;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=j1hyi4uW0dW+lCsxRl1fZv8pS3WTC62bapK32xNJUIU=;
  b=jrGCZItd0OmeiReGQ2oCAIMqhnTHLLdkxDKXIwC2xu2i8CawKluvlmdJ
   A2XhXqr1xxVRAl6eekPDt4NT48NqPrrIOHs2ZvRfj1qzdUREunURwmZJZ
   et3LozQyF3AOm4aOWJ+1qZ8i1soNoM2I6j4eZfR5KqeWrJ9uafC9RUepE
   Y=;
X-IronPort-AV: E=Sophos;i="5.77,285,1596499200"; 
   d="scan'208";a="77766272"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 21 Sep 2020 07:13:57 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id 60712A06C3;
        Mon, 21 Sep 2020 07:13:55 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.237) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 21 Sep 2020 07:13:49 +0000
Subject: Re: [PATCH 05/14] RDMA/efa: drop double zeroing
To:     Julia Lawall <Julia.Lawall@inria.fr>
CC:     <kernel-janitors@vger.kernel.org>,
        Yossi Leybovich <sleybo@amazon.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1600601186-7420-1-git-send-email-Julia.Lawall@inria.fr>
 <1600601186-7420-6-git-send-email-Julia.Lawall@inria.fr>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <ee835ad6-c1fc-cd48-fc70-f42e2ded3ac0@amazon.com>
Date:   Mon, 21 Sep 2020 10:13:43 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <1600601186-7420-6-git-send-email-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.237]
X-ClientProxiedBy: EX13D08UWB003.ant.amazon.com (10.43.161.186) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 20/09/2020 14:26, Julia Lawall wrote:
> sg_init_table zeroes its first argument, so the allocation of that argument
> doesn't have to.
> 
> the semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression x,n,flags;
> @@
> 
> x = 
> - kcalloc
> + kmalloc_array
>   (n,sizeof(*x),flags)
> ...
> sg_init_table(x,n)
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Thanks Julia,
Acked-by: Gal Pressman <galpress@amazon.com>
