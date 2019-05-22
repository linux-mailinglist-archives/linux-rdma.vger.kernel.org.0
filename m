Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADC0425E54
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2019 08:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfEVG4G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 02:56:06 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:65108 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfEVG4G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 May 2019 02:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1558508165; x=1590044165;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=H/QjLFtALIHhkWCmsu6HhBvGOYB4ic5DsC5cZKRwgVs=;
  b=jhdr4Gb2sIcR7QyFXVjb5zYkzJXsHG9lgIupEwYaMGvalCE8I7oqeCIb
   +vttPFWJQvAEn9fGwCJ8YKZ3+w43pgpKg53NP7zmKqrk9DPiNFPf+fZAI
   c3xuzE6hQ3AFlVZFcHb84/0M2XjNbiVOJDKxl5/vBwB7nLgTKb8r2o0Pn
   Q=;
X-IronPort-AV: E=Sophos;i="5.60,498,1549929600"; 
   d="scan'208";a="801078714"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 May 2019 06:56:03 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x4M6tw8G125944
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 22 May 2019 06:56:01 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 22 May 2019 06:56:00 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.38) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 22 May 2019 06:55:57 +0000
Subject: Re: [PATCH for-rc] RDMA/core: Clear out the udata before error unwind
To:     Jason Gunthorpe <jgg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
References: <20190521175515.GA12761@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <9b0fd2e3-5027-b5fa-d0e6-7d8a71a16d30@amazon.com>
Date:   Wed, 22 May 2019 09:55:52 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521175515.GA12761@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.38]
X-ClientProxiedBy: EX13D17UWC004.ant.amazon.com (10.43.162.195) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 21/05/2019 20:55, Jason Gunthorpe wrote:
> The core code should not pass a udata to the driver destroy function that
> contains the input from the create command. Otherwise the driver will
> attempt to interpret the create udata as destroy udata, and at least
> in the case of EFA, will leak resources.
> 
> Zero this stuff out before invoking destroy.
> 
> Reported-by: Leon Romanovsky <leonro@mellanox.com>
> Fixes: c4367a26357b ("IB: Pass uverbs_attr_bundle down ib_x destroy path")
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Reviewed-by: Gal Pressman <galpress@amazon.com>
I will send a followup patch that handles the flows that pass NULL udata.
