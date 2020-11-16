Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64D72B4FC6
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 19:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388620AbgKPSdL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 13:33:11 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:56159 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387967AbgKPSdK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Nov 2020 13:33:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605551589; x=1637087589;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0i96hj4LvkV+hSHNBdrXT4E9rubS2HzSXWf+D8r8nIA=;
  b=uWJhPXgKcRW9YrYNA4iayJCBhiA0uVHqTVXfpcWd0EHPNJ0/tsWD5nEy
   E0AqiykBN5rT5Y2dLE53icwUErufK1T7SWG3Xmynvht3Ci2tv5hwuSX+X
   1hwio2jy/BrKEqWKLiBXdEX92uHa0wIUKJUQsCm3SDJ9HCtnzo92TAVey
   w=;
X-IronPort-AV: E=Sophos;i="5.77,483,1596499200"; 
   d="scan'208";a="64332304"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 16 Nov 2020 18:32:54 +0000
Received: from EX13D19EUB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with ESMTPS id A5849A1AF7;
        Mon, 16 Nov 2020 18:32:53 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.160.125) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 16 Nov 2020 18:32:50 +0000
Subject: Re: [PATCH for-next 1/2] RDMA/core: Check .create_ah is not NULL only
 in case it's needed
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
References: <20201115103404.48829-1-galpress@amazon.com>
 <20201115103404.48829-2-galpress@amazon.com>
 <20201116182207.GF244516@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <b892cec7-ab71-5c76-a780-9f6f947706d3@amazon.com>
Date:   Mon, 16 Nov 2020 20:32:45 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201116182207.GF244516@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.125]
X-ClientProxiedBy: EX13D04UWA002.ant.amazon.com (10.43.160.31) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 16/11/2020 20:22, Jason Gunthorpe wrote:
> On Sun, Nov 15, 2020 at 12:34:02PM +0200, Gal Pressman wrote:
>> Drivers now expose two callbacks for address handle creation, one for
>> uverbs and one for kverbs. The function pointer NULL check in
>> _rdma_create_ah() should only happen if !udata.
>>
>> A NULL check for .create_user_ah is not needed as it is validated by the
>> uverbs uapi definitions.
>>
>> Fixes: 676a80adba01 ("RDMA: Remove AH from uverbs_cmd_mask")
> 
> Why is this a fixes? It makes sense in the context of the next patch,
> but it doesn't look like any driver sets ops.create_ah == NULL ?

I assumed that the NULL check should be changed regardless as it makes more
sense to only check the callback if it's used.
You can remove it if you prefer, I just hope the second patch won't be
accidentally picked up without this one.
