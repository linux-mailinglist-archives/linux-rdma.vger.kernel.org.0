Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD1124BDC2
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Aug 2020 15:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgHTNMC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 09:12:02 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:44364 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729657AbgHTNLl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 09:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1597929101; x=1629465101;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=FUrDUNlwE3NW8L03MLl2tMbOs1uS6817KZktmG5NhzY=;
  b=p3G1g3JNZr9ChvtDTbRSOUGKlG/ErJWsjiYh32pSSkpvoNy2KR+Csn/1
   tKiPmTbyrhkM1yt0roT1GF/ctvBpPURt5OIaqN7aE9HOLRs5leAOhUh9D
   NHKUJ3bfrEBwv63JVyc372d7TcTYCeGC1CChyZOdD/B0ZfHAkLdEt0En3
   k=;
X-IronPort-AV: E=Sophos;i="5.76,332,1592870400"; 
   d="scan'208";a="48814187"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 20 Aug 2020 13:11:40 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (Postfix) with ESMTPS id 49E30A24B3;
        Thu, 20 Aug 2020 13:11:37 +0000 (UTC)
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 20 Aug 2020 13:11:37 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.38) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 20 Aug 2020 13:11:28 +0000
Subject: Re: [PATCH for-next] RDMA/usnic: Remove the query_pkey callback
To:     Kamal Heib <kamalheib1@gmail.com>, <linux-rdma@vger.kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Benvenuti <benve@cisco.com>
References: <20200820125346.111902-1-kamalheib1@gmail.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <efb8ce2b-fb37-2950-36fd-fb45b845632a@amazon.com>
Date:   Thu, 20 Aug 2020 16:11:23 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820125346.111902-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.38]
X-ClientProxiedBy: EX13D03UWA004.ant.amazon.com (10.43.160.250) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 20/08/2020 15:53, Kamal Heib wrote:
> Now that the query_pkey() isn't mandatory by the RDMA core, this
> callback can be removed from the usnic provider.

Not directly related to this patch, but pyverbs has a test which verifies that
max_pkeys > 0, maybe this check should be removed.
