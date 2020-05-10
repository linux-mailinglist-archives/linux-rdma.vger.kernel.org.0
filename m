Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0244A1CCBBA
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2020 17:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgEJPEz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 May 2020 11:04:55 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:20752 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgEJPEz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 May 2020 11:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589123095; x=1620659095;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=LwewQ/zp8cZQATaWMap4TEfpdmneBceV7hkqINwKpi0=;
  b=Tk0PePibbv75YMy0KEHOQ3wncCUufpVcG6gnoMg0F7RvjMd5dHTjv7Bz
   ucUAg51feNyL0/ioaM7adElkA7UKUe71a6hfPFoD3eBTRjp5D8KfmsgI0
   dNJDndo0DriOgSJO3VWR5ATgF4YEbDX5663oDWz5fY/EUjM7d+z2lcy23
   4=;
IronPort-SDR: bMFS/i2k/91sbYtX8onVVbzRsacE0zIqQPLucA/1KZdmqmTPc9Md1BXzYpa5GGYHgolrOnkff6
 ouMQgsRoMW4g==
X-IronPort-AV: E=Sophos;i="5.73,376,1583193600"; 
   d="scan'208";a="34021849"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 10 May 2020 15:04:54 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id 9363BA2085;
        Sun, 10 May 2020 15:04:53 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 10 May 2020 15:04:53 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.90) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 10 May 2020 15:04:49 +0000
Subject: Re: [PATCH 0/4] Introducing RDMA shared CQ pool
To:     Yamin Friedman <yaminf@mellanox.com>
CC:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, <linux-rdma@vger.kernel.org>
References: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <8062fcff-dd42-f3a7-f40c-8b6d51d4e1a8@amazon.com>
Date:   Sun, 10 May 2020 18:04:43 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.90]
X-ClientProxiedBy: EX13D18UWA001.ant.amazon.com (10.43.160.11) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/05/2020 17:55, Yamin Friedman wrote:
> This is the fourth re-incarnation of the CQ pool patches proposed
> by Sagi and Christoph. I have started with the patches that Sagi last
> submitted and built the CQ pool as a new API for acquiring shared CQs.

Can you please share a link to the previous revisions?
