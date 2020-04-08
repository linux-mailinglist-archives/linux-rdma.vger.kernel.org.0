Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4873C1A1BEE
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Apr 2020 08:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgDHGfr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Apr 2020 02:35:47 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:3588 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgDHGfq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Apr 2020 02:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586327746; x=1617863746;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Os+5nSGLobhgm1MgM4LtepQogKsu6uJ6PxE/akeWJ58=;
  b=NxW72qA+mMRt/MEDlxnucP5irHJOhn1WDdSIqdUAdM4P07b+f/jVFxMF
   s4Th3zxmcE3Zo4xEj0CUThcL6ZN+jrjKRsRr0P85rQCuvh3gtjES5qQxK
   igy7R5vuMkZmiBUPEDjCS7IB6iJIXAKheR8ot+zMF4YBj00SPy8urGAgz
   Q=;
IronPort-SDR: 4nEoDzlORuo279zN++jBOYGmoTdMmXcro2SxkiuOUaGWk9lmmFnQFDzUwrTguuqIU9qWbKGPmg
 Yy4VR2vdtjFg==
X-IronPort-AV: E=Sophos;i="5.72,357,1580774400"; 
   d="scan'208";a="27562551"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 08 Apr 2020 06:35:44 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id DF596A2523;
        Wed,  8 Apr 2020 06:35:42 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Apr 2020 06:35:42 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.100) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Apr 2020 06:35:39 +0000
Subject: Re: Can't build rdma-core's azp image
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>
References: <05382c9f-a58d-ba5a-02cd-c25aa3604e52@amazon.com>
 <20200407180658.GW20941@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <67f9e08a-467c-34ce-e17e-816cb4bf03db@amazon.com>
Date:   Wed, 8 Apr 2020 09:35:32 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200407180658.GW20941@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D37UWC004.ant.amazon.com (10.43.162.212) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 07/04/2020 21:06, Jason Gunthorpe wrote:
> On Tue, Apr 07, 2020 at 06:47:51PM +0300, Gal Pressman wrote:
>> I'm trying to build the azp image and it fails with the following error [1].
>> Anyone has an idea what went wrong?
> 
>> Reading package lists...
>> W: http://apt.llvm.org/bionic/dists/llvm-toolchain-bionic-8/InRelease: No system
>> certificates available. Try installing ca-certificates.
>> W: http://apt.llvm.org/bionic/dists/llvm-toolchain-bionic-8/Release: No system
>> certificates available. Try installing ca-certificates.
>> E: The repository 'http://apt.llvm.org/bionic llvm-toolchain-bionic-8 Release'
>> does not have a Release file.
> 
> Oh, there is lots going wrong here..
> 
> Above is because llvm droped http support from their repo.. Bit
> annoying to fix..
> 
>> The following packages have unmet dependencies:
>>  libc6-dev:arm64 : Depends: libc6:arm64 (= 2.27-3ubuntu1) but it is not going to
>> be installed
>>  libgcc-8-dev:arm64 : Depends: libgcc1:arm64 (>= 1:8.4.0-1ubuntu1~18.04)
>>                       Depends: libgomp1:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
>> is not going to be installed
>>                       Depends: libitm1:arm64 (>= 8.4.0-1ubuntu1~18.04) but it is
>> not going to be installed
>>                       Depends: libatomic1:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
>> is not going to be installed
>>                       Depends: libasan5:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
>> is not going to be installed
>>                       Depends: liblsan0:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
>> is not going to be installed
>>                       Depends: libtsan0:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
>> is not going to be installed
>>                       Depends: libubsan1:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
>> is not going to be installed
>>  libnl-3-dev:arm64 : Depends: libnl-3-200:arm64 (= 3.2.29-0ubuntu3) but it is
>> not going to be installed
>>  libnl-route-3-dev:arm64 : Depends: libnl-route-3-200:arm64 (= 3.2.29-0ubuntu3)
>> but it is not going to be installed
>>  libsystemd-dev:arm64 : Depends: libsystemd0:arm64 (= 237-3ubuntu10.39) but it
>> is not going to be installed
>>  libudev-dev:arm64 : Depends: libudev1:arm64 (= 237-3ubuntu10.39) but it is not
>> going to be installed
> 
> Oh neat, that is a problem in the toolchain ppa:
> 
> $ apt-get install libgcc-s1:arm64 gcc-7
> 
> The following packages have unmet dependencies:
>  libgcc-s1:arm64 : Breaks: libgcc-7-dev (< 7.5.0-4) but 7.5.0-3ubuntu1~18.04 is to be installed
> 
> The only ubuntu not broken right now is focal.. which is very new.
> 
> Keep using the old docker image? Ask me in a week if it is still
> broken, we can probably fix this by updating to focal, it is the next
> LTS anyhow..

Thanks Jason, I'll keep tracking the issue.
