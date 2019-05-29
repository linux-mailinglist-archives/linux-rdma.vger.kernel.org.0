Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49D0A2E51C
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2019 21:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbfE2TLt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 May 2019 15:11:49 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:6971 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2TLt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 May 2019 15:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559157107; x=1590693107;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=H0/OjCU3aiAqasMSTvOJglxIq8Ajj4o3SAUt63ANPrg=;
  b=i3LoaD2JRgeBn9aJ4TpTUMsNQ+34pv7SGEGVI7/rfLGpFJwK2LSDlNY3
   EJuy33qJ9rmzPjFGY2bJWWJlA3ls8yZEfmE3YWheTVt3uoml/tT/LJkir
   V9JrvhIphGTPwQT71L1jmnnXm7/lioLqpG3WOzHye82bWLaA5YojPa/B4
   4=;
X-IronPort-AV: E=Sophos;i="5.60,527,1549929600"; 
   d="scan'208";a="398563969"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 29 May 2019 19:11:45 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id B93D8A2628;
        Wed, 29 May 2019 19:11:44 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 29 May 2019 19:11:44 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.16) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 29 May 2019 19:11:39 +0000
Subject: Re: [PATCH for-rc 5/6] RDMA/efa: Use rdma block iterator in chunk
 list creation
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20190528124618.77918-1-galpress@amazon.com>
 <20190528124618.77918-6-galpress@amazon.com>
 <9DD61F30A802C4429A01CA4200E302A7A5B07A3B@fmsmsx124.amr.corp.intel.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <74218704-80f4-88da-ea09-8a5c7a8dcf66@amazon.com>
Date:   Wed, 29 May 2019 22:11:34 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A7A5B07A3B@fmsmsx124.amr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.16]
X-ClientProxiedBy: EX13D12UWA004.ant.amazon.com (10.43.160.168) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 29/05/2019 20:03, Saleem, Shiraz wrote:
>> Subject: [PATCH for-rc 5/6] RDMA/efa: Use rdma block iterator in chunk list
>> creation
>>
>> When creating the chunks list the rdma_for_each_block() iterator is used in order
>> to iterate over the payload in EFA_CHUNK_PAYLOAD_SIZE (device
>> defined) strides.
>>
>> Cc: Shiraz Saleem <shiraz.saleem@intel.com>
>> Reviewed-by: Firas JahJah <firasj@amazon.com>
>> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
>> Signed-off-by: Gal Pressman <galpress@amazon.com>
>> ---
> 
> Looks ok.
> 
> Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>

Thanks Shiraz

