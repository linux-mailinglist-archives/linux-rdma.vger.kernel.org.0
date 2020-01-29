Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBE714CA31
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2020 13:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgA2MGZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jan 2020 07:06:25 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:36023 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgA2MGY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jan 2020 07:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1580299583; x=1611835583;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=I4al3o1EHV7dzIf1KO4Sk0jmpzwk2+01R27r2Zuidi4=;
  b=Q3lKIysiF7g1XOMtI+PhF1lJ58ve+5NC4SWcZZOgB9jlj9h1YXyoa24L
   4GNLSl5ydQRWvQLbwzHNuskiVozZR0NrR0f6QgigwgbJDfV6rFRjs6TSY
   b7fFzs7HAJkHFgFWpoqdqPFxdNPRdZ3RVOepyoqCibWW5w5jWCyVw7KjP
   E=;
IronPort-SDR: i90nrtCoq2tfJzkTd5oetBy5G2AMKR2XhiELpR8Qgwkp23Ro5kUa5OG5pBcXxpvgEF9NMS4PIh
 doY8VmRW/+8Q==
X-IronPort-AV: E=Sophos;i="5.70,377,1574121600"; 
   d="scan'208";a="13834622"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 29 Jan 2020 12:06:22 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS id F05E6A268A;
        Wed, 29 Jan 2020 12:06:19 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 29 Jan 2020 12:06:19 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.29) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 29 Jan 2020 12:06:14 +0000
Subject: Re: [PATCH rdma-next] RDMA/core: Fix protection fault in
 get_pkey_idx_qp_list
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        "Leon Romanovsky" <leonro@mellanox.com>
References: <20200126171553.4916-1-leon@kernel.org>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <fceb1026-0fb1-5e4f-d617-01a0bcfa21f8@amazon.com>
Date:   Wed, 29 Jan 2020 14:06:08 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200126171553.4916-1-leon@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.29]
X-ClientProxiedBy: EX13D21UWB004.ant.amazon.com (10.43.161.221) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 26/01/2020 19:15, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
> 
> We don't need to set pkey as valid in case that user set only one
> of pkey index or port number, otherwise it will be resulted in NULL
> pointer dereference while accessing to uninitialized pkey list.

Why would the pkey list be uninitialized? Isn't it initialized as an empty list
on device registration?
