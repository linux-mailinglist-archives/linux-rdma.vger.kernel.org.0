Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01F332C744
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 15:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfE1ND4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 09:03:56 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:60463 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfE1NDz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 May 2019 09:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559048634; x=1590584634;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=VAG0o7GXkVuzLLxun7Kdj0YAs2O7tiEZAt567gSRwek=;
  b=Qykm8OoieqYEnID6tZxf/cNsC48EnHNRaPcGt3itGV4xB275unBKlqWC
   K3TP3iMZsTtwuM6mtpuiDDQUkoMrZJhEf72dto7Bukhkm0Q+pzXaBaaQc
   0URBUKyoj+dfQPd9uEqjY05kTCqUMrAKnBeR0XrJh/XIavmRNlxCgLNIP
   k=;
X-IronPort-AV: E=Sophos;i="5.60,523,1549929600"; 
   d="scan'208";a="735044354"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 May 2019 13:03:52 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x4SD3l0t047597
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 28 May 2019 13:03:51 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 May 2019 13:03:51 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.82) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 May 2019 13:03:47 +0000
Subject: Re: [PATCH rdma-next v1 2/3] RDMA: Clean destroy CQ in drivers do not
 return errors
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20190528113729.13314-1-leon@kernel.org>
 <20190528113729.13314-3-leon@kernel.org>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <1934b1ce-d700-2cd1-d4eb-a30d8d13770d@amazon.com>
Date:   Tue, 28 May 2019 16:03:42 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528113729.13314-3-leon@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.82]
X-ClientProxiedBy: EX13D07UWB001.ant.amazon.com (10.43.161.238) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 28/05/2019 14:37, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Like all other destroy commands, .destroy_cq() call is not supposed
> to fail. In all flows, the attempt to return earlier caused to memory
> leaks.
> 
> This patch converts .destroy_cq() to do not return any errors.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>

This patch doesn't apply to my tree for some reason.

Other than that, for the EFA part:
Acked-by: Gal Pressman <galpress@amazon.com>

Thanks Leon
