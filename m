Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E4C1AB952
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2020 09:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438469AbgDPHFn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Apr 2020 03:05:43 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:40751 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438365AbgDPHFe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Apr 2020 03:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587020733; x=1618556733;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=cQL9asWXNP0HyvQQQXydK9FeC9MKJcmNK55Tycabov0=;
  b=gl3kZxzGAqMu6QJ0J1k1l3/xmzR04tCJ1+G0ABWf393dP9dcG9HNf9SE
   e3Qd937StnOuWzdi1W5W3EysNsq6AfWVhKNIemgAQ9WSR27V2z35ChQVA
   mAdSx8uv+4B9rIqVo7rJ4uMjoFRPZGp01WKtys7IMTqsyRj9pjiaDUa/D
   U=;
IronPort-SDR: Y7UqhSsf7FSM4lf0Ygu/J4Iss5XiFIA3YD/yCJ6HOfWnLOGbcQxD3D7HQxznqqLLyTuE/SDWn4
 2s7MIySj29wg==
X-IronPort-AV: E=Sophos;i="5.72,390,1580774400"; 
   d="scan'208";a="27143853"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 16 Apr 2020 07:05:21 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id E3887A24C2;
        Thu, 16 Apr 2020 07:05:19 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 16 Apr 2020 07:05:19 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.238) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 16 Apr 2020 07:05:16 +0000
Subject: Re: Can't build rdma-core's azp image
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>
References: <05382c9f-a58d-ba5a-02cd-c25aa3604e52@amazon.com>
 <20200407180658.GW20941@ziepe.ca>
 <67f9e08a-467c-34ce-e17e-816cb4bf03db@amazon.com>
Message-ID: <ca41331c-3b53-fbb6-4543-bc960f796062@amazon.com>
Date:   Thu, 16 Apr 2020 10:05:11 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <67f9e08a-467c-34ce-e17e-816cb4bf03db@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.238]
X-ClientProxiedBy: EX13D28UWC002.ant.amazon.com (10.43.162.145) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 08/04/2020 9:35, Gal Pressman wrote:
> On 07/04/2020 21:06, Jason Gunthorpe wrote:
>> On Tue, Apr 07, 2020 at 06:47:51PM +0300, Gal Pressman wrote:
>>> I'm trying to build the azp image and it fails with the following error [1].
>>> Anyone has an idea what went wrong?
>>
>>> Reading package lists...
>>> W: http://apt.llvm.org/bionic/dists/llvm-toolchain-bionic-8/InRelease: No system
>>> certificates available. Try installing ca-certificates.
>>> W: http://apt.llvm.org/bionic/dists/llvm-toolchain-bionic-8/Release: No system
>>> certificates available. Try installing ca-certificates.
>>> E: The repository 'http://apt.llvm.org/bionic llvm-toolchain-bionic-8 Release'
>>> does not have a Release file.
>>
>> Oh, there is lots going wrong here..
>>
>> Above is because llvm droped http support from their repo.. Bit
>> annoying to fix..
>>
>>> The following packages have unmet dependencies:
>>>  libc6-dev:arm64 : Depends: libc6:arm64 (= 2.27-3ubuntu1) but it is not going to
>>> be installed
>>>  libgcc-8-dev:arm64 : Depends: libgcc1:arm64 (>= 1:8.4.0-1ubuntu1~18.04)
>>>                       Depends: libgomp1:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
>>> is not going to be installed
>>>                       Depends: libitm1:arm64 (>= 8.4.0-1ubuntu1~18.04) but it is
>>> not going to be installed
>>>                       Depends: libatomic1:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
>>> is not going to be installed
>>>                       Depends: libasan5:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
>>> is not going to be installed
>>>                       Depends: liblsan0:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
>>> is not going to be installed
>>>                       Depends: libtsan0:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
>>> is not going to be installed
>>>                       Depends: libubsan1:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
>>> is not going to be installed
>>>  libnl-3-dev:arm64 : Depends: libnl-3-200:arm64 (= 3.2.29-0ubuntu3) but it is
>>> not going to be installed
>>>  libnl-route-3-dev:arm64 : Depends: libnl-route-3-200:arm64 (= 3.2.29-0ubuntu3)
>>> but it is not going to be installed
>>>  libsystemd-dev:arm64 : Depends: libsystemd0:arm64 (= 237-3ubuntu10.39) but it
>>> is not going to be installed
>>>  libudev-dev:arm64 : Depends: libudev1:arm64 (= 237-3ubuntu10.39) but it is not
>>> going to be installed
>>
>> Oh neat, that is a problem in the toolchain ppa:
>>
>> $ apt-get install libgcc-s1:arm64 gcc-7
>>
>> The following packages have unmet dependencies:
>>  libgcc-s1:arm64 : Breaks: libgcc-7-dev (< 7.5.0-4) but 7.5.0-3ubuntu1~18.04 is to be installed
>>
>> The only ubuntu not broken right now is focal.. which is very new.
>>
>> Keep using the old docker image? Ask me in a week if it is still
>> broken, we can probably fix this by updating to focal, it is the next
>> LTS anyhow..
> 
> Thanks Jason, I'll keep tracking the issue.

Looks like the issue persists :\.
