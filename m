Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE5DDDD21
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Oct 2019 09:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfJTHDk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Oct 2019 03:03:40 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:26115 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfJTHDj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Oct 2019 03:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1571555019; x=1603091019;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=p/68mmtQcYIr0e5gp9CZpen+jOsd5bBhz6Vp4AZSJ0E=;
  b=q4hPa6LEaGKSySRtDt40VF2GJgPBW0fFISZ1/OmqnPoqF2TTyVBYnOX6
   bAdTalPh6IycGjlUhEKa0x5nN8hF3oJ3dJa77XhW/riX5Uzk0cTVfkD+0
   lHCiwRI2hmUhPG4+hIN/azzcmgwIOus6Xu2rlIwEfzSr3G7pGTA7SCQoA
   I=;
X-IronPort-AV: E=Sophos;i="5.67,318,1566864000"; 
   d="scan'208";a="424856216"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 20 Oct 2019 07:03:36 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id 56AF3A1FC2;
        Sun, 20 Oct 2019 07:03:36 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 20 Oct 2019 07:03:35 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.78) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 20 Oct 2019 07:03:32 +0000
Subject: Re: [PATCH for-next 0/4] EFA RDMA read support
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>
References: <20190910134301.4194-1-galpress@amazon.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <24527b2a-3bd2-cee5-0383-277c6e72af5c@amazon.com>
Date:   Sun, 20 Oct 2019 10:03:27 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190910134301.4194-1-galpress@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.78]
X-ClientProxiedBy: EX13d09UWA003.ant.amazon.com (10.43.160.227) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/09/2019 16:42, Gal Pressman wrote:
> Hi,
> 
> The following series introduces RDMA read support and capabilities
> reporting to the EFA driver.
> 
> The first two patches aren't directly related to RDMA read, but refactor
> some bits in the device capabilities struct.
> 
> The last two patches add support for remote read access in MR
> registration and expose the RDMA read related attributes to the
> userspace library.
> 
> PR was sent:
> https://github.com/linux-rdma/rdma-core/pull/576

Should I resubmit patches 2-4?
