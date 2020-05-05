Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE6C1C5810
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2020 16:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgEEOFa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 May 2020 10:05:30 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:56685 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgEEOF3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 May 2020 10:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1588687529; x=1620223529;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=7hRhq73jJ9OOmBNm5/PpXauR8em9GdTAQP+I78eBZuU=;
  b=b45XMxcjPffLFiZ9I5e4s/LsxajI+9kjJkiWntP2k+C84MSHbzyJdsLd
   bwoOWjtQVk/PHJaZ4Zai7nZEYmNw450eYH+M2ho74LGxzGOWi9R56hMST
   lZ+N0z8T7vIiNk4DNsoMchN70WAPxEwBce5kpnbTSGEEFNbXXpQaEAmcg
   c=;
IronPort-SDR: UQwYJ5AWzT0/Skq46a+od4BC/ysXkhOBOBS9rjhAGoCpZu6TdbkbCstrN22pWLXaiDhSrXglE1
 shZcLN5omLWw==
X-IronPort-AV: E=Sophos;i="5.73,355,1583193600"; 
   d="scan'208";a="41371251"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 05 May 2020 14:05:27 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 75006A1F87;
        Tue,  5 May 2020 14:05:26 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 5 May 2020 14:05:25 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.26) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 5 May 2020 14:05:23 +0000
Subject: Re: Can't build rdma-core's azp image
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>
References: <05382c9f-a58d-ba5a-02cd-c25aa3604e52@amazon.com>
 <20200407180658.GW20941@ziepe.ca>
 <67f9e08a-467c-34ce-e17e-816cb4bf03db@amazon.com>
 <ca41331c-3b53-fbb6-4543-bc960f796062@amazon.com>
 <20200417162150.GH26002@ziepe.ca>
 <519a9c33-fa1b-7439-fa6a-7a54b69bde0b@amazon.com>
 <20200505010906.GD26002@ziepe.ca>
 <fdb88249-dd6f-2cba-9c26-820456a0f011@amazon.com>
 <20200505132125.GE26002@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <fd87ec3e-d622-e213-8640-1f9d5e9d6ebd@amazon.com>
Date:   Tue, 5 May 2020 17:05:18 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505132125.GE26002@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.26]
X-ClientProxiedBy: EX13D39UWB002.ant.amazon.com (10.43.161.116) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 05/05/2020 16:21, Jason Gunthorpe wrote:
> On Tue, May 05, 2020 at 09:40:33AM +0300, Gal Pressman wrote:
>> On 05/05/2020 4:09, Jason Gunthorpe wrote:
>>> On Sun, Apr 19, 2020 at 09:37:45AM +0300, Gal Pressman wrote:
>>>> Unpacking libc6:arm64 (2.27-3ubuntu1) ...
>>>> dpkg: dependency problems prevent configuration of libc6:i386:
>>>>  libc6:i386 depends on libgcc1; however:
>>>>   Package libgcc-s1:i386 which provides libgcc1 is not configured yet.
>>>>
>>>> dpkg: error processing package libc6:i386 (--configure):
>>>>  dependency problems - leaving unconfigured
>>>> dpkg: dependency problems prevent configuration of libgcc-s1:ppc64el:
>>>>  libgcc-s1:ppc64el depends on libc6 (>= 2.17); however:
>>>>   Package libc6:ppc64el is not configured yet.
>>>>
>>>> dpkg: error processing package libgcc-s1:ppc64el (--configure):
>>>>  dependency problems - leaving unconfigured
>>>> Errors were encountered while processing:
>>>>  libc6:i386
>>>>  libgcc-s1:ppc64el
>>>> E: Sub-process /usr/bin/dpkg returned an error code (1)
>>>
>>> Wow, that is actually an APT bug... Must be from old age :O
>>>
>>> Ah we can hack around that with this:
>>>
>>> https://github.com/jgunthorpe/rdma-plumbing/pull/new/azp_fix
>>>
>>> Let me know if it works
>>>
>>> Now that github has docker hosting I wonder if we should try to host a
>>> copy of the docker image there.. Their docker hosting is a pain last I
>>> looked though..
>>
>> I've applied these patches and still got the same error :\.
> 
> It is because you rebased it on top of 9a68d672c3a835d..
> 
> 'cbuild: Adjust to the new clang CDN' is the better fix for that..
> 
> I rebased it on the github

Thanks Jason, confirmed it's working.
