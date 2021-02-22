Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A679322027
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 20:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhBVT36 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 14:29:58 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:22535 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbhBVT1v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Feb 2021 14:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1614022071; x=1645558071;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=61aSBlvNcmW+wVtMrVhWlHOgsup+I24sb9LpYC8ek7o=;
  b=CUTQlUITb74wbKP+Y1PbXkRl+Wqepz3PBBUo3HV1Prwwqd+yuRTQEi9c
   bZyFcno2Kp5hBvHg9qXlstEeIwM9CQRreFKFQahNTW0ojKoH4cAqKFDYR
   7pHWmT9JOtJvk9/kwZuhasLSGSallg+6bMcqHy/WjVpppmQ2HiETaWs3/
   c=;
X-IronPort-AV: E=Sophos;i="5.81,198,1610409600"; 
   d="scan'208";a="86589510"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 22 Feb 2021 19:27:03 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id 92524A2386;
        Mon, 22 Feb 2021 19:27:01 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.87) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 22 Feb 2021 19:26:58 +0000
Subject: Re: ibv_req_notify_cq clarification
To:     "Hefty, Sean" <sean.hefty@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>
References: <bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
 <20210218125339.GY4718@ziepe.ca>
 <5287c059-3d8c-93f4-6be4-a6da07ccdb8a@amazon.com>
 <20210218162329.GZ4718@ziepe.ca>
 <51a8fa8c-7529-9ef9-bb52-eccaaef3a666@amazon.com>
 <20210222134642.GG2643399@ziepe.ca>
 <e26a3e90-cc8b-d681-5d6b-4e363aa1933c@amazon.com>
 <MW3PR11MB46518F4C79C4114675F976F89E819@MW3PR11MB4651.namprd11.prod.outlook.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <9316beee-20c1-4d92-c99e-f34babbfaa2a@amazon.com>
Date:   Mon, 22 Feb 2021 21:26:52 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <MW3PR11MB46518F4C79C4114675F976F89E819@MW3PR11MB4651.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.87]
X-ClientProxiedBy: EX13D48UWB002.ant.amazon.com (10.43.163.125) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 22/02/2021 20:38, Hefty, Sean wrote:
>> Running this with 32 iterations, the client does something like:
>> - arm cq
>> - post send x 32
>> - wait for cq event
>> - arm cq
>> - poll cq (once, with batch size of 16)
> 
> This is a race.  The code should continue to read completions until the CQ is drained.
> 
> At this point, all completions may have been written to the CQ, and no new events will be generated.
> 
>> - no more post send (reached tot_iters)
>> - wait for cq event (but an event has already been generated?)
>>
>> And gets stuck?
> 
> - Sean
> 

That's what I suspected, but I assume people run this and it works fine on
different hardware?
