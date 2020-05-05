Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FEF1C4E68
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2020 08:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgEEGkq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 May 2020 02:40:46 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:47233 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgEEGkq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 May 2020 02:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1588660846; x=1620196846;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=U9z5U95rtrIbc8Je0n766Jf1loF4tKjVoCG1Kio0L3s=;
  b=gPcodMFOFG0kMzuc9uQjVdYBhLAUh8f2MG+jGumQt5k1VkgiV2X7p+ng
   8NC0Pn/FWTGGiKDJNbdZSahzF848k3d2ToEVN9ZMHGsHvp3Y1z3qtgHjF
   X0nDkA6v2SxxQX2/ZpbbuQFVpfJHFhI5J/fEFiJ6Cld4tVN3907d7jTFH
   E=;
IronPort-SDR: gmrsRxhwDhubV1eejTNN7eYoKwHxaiEMhgTwpybhsOTvxl85McUrxgqsjhXDiarf0qurUMD6Ud
 nkVM57j4IGKQ==
X-IronPort-AV: E=Sophos;i="5.73,354,1583193600"; 
   d="scan'208";a="42711772"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 05 May 2020 06:40:44 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com (Postfix) with ESMTPS id A7289A218A;
        Tue,  5 May 2020 06:40:43 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 5 May 2020 06:40:42 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.34) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 5 May 2020 06:40:38 +0000
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
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <fdb88249-dd6f-2cba-9c26-820456a0f011@amazon.com>
Date:   Tue, 5 May 2020 09:40:33 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505010906.GD26002@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13D13UWA001.ant.amazon.com (10.43.160.136) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 05/05/2020 4:09, Jason Gunthorpe wrote:
> On Sun, Apr 19, 2020 at 09:37:45AM +0300, Gal Pressman wrote:
>> Unpacking libc6:arm64 (2.27-3ubuntu1) ...
>> dpkg: dependency problems prevent configuration of libc6:i386:
>>  libc6:i386 depends on libgcc1; however:
>>   Package libgcc-s1:i386 which provides libgcc1 is not configured yet.
>>
>> dpkg: error processing package libc6:i386 (--configure):
>>  dependency problems - leaving unconfigured
>> dpkg: dependency problems prevent configuration of libgcc-s1:ppc64el:
>>  libgcc-s1:ppc64el depends on libc6 (>= 2.17); however:
>>   Package libc6:ppc64el is not configured yet.
>>
>> dpkg: error processing package libgcc-s1:ppc64el (--configure):
>>  dependency problems - leaving unconfigured
>> Errors were encountered while processing:
>>  libc6:i386
>>  libgcc-s1:ppc64el
>> E: Sub-process /usr/bin/dpkg returned an error code (1)
> 
> Wow, that is actually an APT bug... Must be from old age :O
> 
> Ah we can hack around that with this:
> 
> https://github.com/jgunthorpe/rdma-plumbing/pull/new/azp_fix
> 
> Let me know if it works
> 
> Now that github has docker hosting I wonder if we should try to host a
> copy of the docker image there.. Their docker hosting is a pain last I
> looked though..

I've applied these patches and still got the same error :\.
