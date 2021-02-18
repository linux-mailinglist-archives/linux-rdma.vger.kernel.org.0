Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A269731EC21
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Feb 2021 17:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhBRQRA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Feb 2021 11:17:00 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:63551 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbhBRMu4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Feb 2021 07:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1613652656; x=1645188656;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Bkyg6DzNW9GxZBNND13eh+QQLDvbjOCwdfI4+SyU4ks=;
  b=W2mHEeLam3oHHrXWzThvmm6S/Pki/MlxOkoujfJbl5jUM/jR/lblzsxy
   kXlB4eoFi6735oi8Rt2MRgJ0nq7IMcjtr1JWp07LHe8lqtviHeH0LPHIo
   3ey+Vo5op/cGBEmC2uzi1gWI7wxGMcQOAQctS5QmdiWkXsdAHW/c3+QCv
   k=;
X-IronPort-AV: E=Sophos;i="5.81,187,1610409600"; 
   d="scan'208";a="89021355"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 18 Feb 2021 12:47:35 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS id DB49E1431DF;
        Thu, 18 Feb 2021 12:47:33 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.160.125) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 18 Feb 2021 12:47:31 +0000
Subject: Re: ibv_req_notify_cq clarification
To:     Bernard Metzler <BMT@zurich.ibm.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>
References: <bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
 <OF8421F948.8385A3FA-ON00258680.00454F8A-00258680.00456EC9@notes.na.collabserv.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <2f01b2b4-f024-d469-7176-aaaca3af9e96@amazon.com>
Date:   Thu, 18 Feb 2021 14:47:27 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <OF8421F948.8385A3FA-ON00258680.00454F8A-00258680.00456EC9@notes.na.collabserv.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.125]
X-ClientProxiedBy: EX13D19UWC004.ant.amazon.com (10.43.162.56) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 18/02/2021 14:38, Bernard Metzler wrote:
> -----"Gal Pressman" <galpress@amazon.com> wrote: -----
> 
>> To: "RDMA mailing list" <linux-rdma@vger.kernel.org>
>> From: "Gal Pressman" <galpress@amazon.com>
>> Date: 02/18/2021 11:26AM
>> Subject: [EXTERNAL] ibv_req_notify_cq clarification
>>
>> I'm a bit confused about the meaning of the ibv_req_notify_cq() verb:
>> "Upon the addition of a new CQ entry (CQE) to cq, a completion event
>> will be
>> added to the completion channel associated with the CQ."
>>
>> What is considered a new CQE in this case?
>> The next CQE from the user's perspective, i.e. any new CQE that
>> wasn't consumed
>> by the user's poll cq?
>> Or any new CQE from the device's perspective?
>>
>> For example, if at the time of ibv_req_notify_cq() call the CQ has
>> received 100
>> completions, but the user hasn't polled his CQ yet, when should he be
>> notified?
>> On the 101 completion or immediately (since there are completions
>> waiting on the
>> CQ)?
> 
> It is from drivers perspective. So notification when 101
> became available and CQ is marked for notification.
> Applications tend to poll the CQ after requesting
> notification, since there might be a race
> from appl perspective...

Thanks Bernard,

Looking at the implementation of rdma-core providers, most of them pass the CQ
consumer index as part of the arm doorbell which made me think it arms the CQ to
notify on a completion newer than what the app polled, not on a completion newer
than the producer index.
Any idea why the consumer index is needed if that's not the case?
