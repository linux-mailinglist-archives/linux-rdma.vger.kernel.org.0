Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54A9AABA2B
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2019 16:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbfIFOEW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Sep 2019 10:04:22 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:55342 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfIFOEW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Sep 2019 10:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567778662; x=1599314662;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=bIdnw9uuPcDo9ihD6iyWVZQQ5/HK01tfKep+VXopx/4=;
  b=VmXJAFC8Ft2b2PcQve9QQpah5phAeVctyaGQPCDJaeNoEX6R2wkA+Vg3
   zR/62RfYxyg7S6CJBTvomdcyi6lPY4SAhwPOwqHx3sWps7oLAGho0rFT9
   utTR9V7BpRVq+A84smLsfh6i3FCGoS//mpQ0Nh+/5sgodnmjDibXq9Sja
   8=;
X-IronPort-AV: E=Sophos;i="5.64,473,1559520000"; 
   d="scan'208";a="749389855"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 06 Sep 2019 14:04:15 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id 0FE0BA2297;
        Fri,  6 Sep 2019 14:04:15 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 6 Sep 2019 14:04:14 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.82) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 6 Sep 2019 14:04:11 +0000
Subject: Re: [PATCH] RDMA/siw: Fix page address mapping in TX path
To:     Bernard Metzler <bmt@zurich.ibm.com>
CC:     <linux-rdma@vger.kernel.org>, <krishna2@chelsio.com>,
        <dledford@redhat.com>
References: <20190906084544.26103-1-bmt@zurich.ibm.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <bd025563-e1e0-4d87-2150-b4cb7fc5a816@amazon.com>
Date:   Fri, 6 Sep 2019 17:04:06 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906084544.26103-1-bmt@zurich.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.82]
X-ClientProxiedBy: EX13P01UWA004.ant.amazon.com (10.43.160.127) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 06/09/2019 11:45, Bernard Metzler wrote:
> Use the correct kmap()/kunmap() flow to determine page
> address used for CRC computation. Using page_address()
> is wrong, since page might be in highmem.
> 
> Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> Fixes: b9be6f18cf9e rdma/siw: transmit path

Hi Bernard,
The format of the fixes line should be:
Fixes: b9be6f18cf9e ("rdma/siw: transmit path")
