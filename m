Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5551E3AB1
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2020 09:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387506AbgE0HgH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 03:36:07 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:29330 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387536AbgE0HgH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 May 2020 03:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1590564968; x=1622100968;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZpV6nqPXEnK3XDw4Ye12hpBe7OFM9m4S5fuoOTgsH/A=;
  b=Ky3DImhrXtyhbXu28cvjObWYaUibtW7wNba8qHLsWsNNH2QXIj7PvIkG
   hrNy3Du9RO3betvLgBspfacd4gn1TtmkYXkZQ18ksg80R4ZnWQ+aOt4UO
   IngHMyPhr1l4zjW6D1mS+sPQNl9S7ndDoR1RAyQBVHHhuJPBZ2cfXRNqe
   o=;
IronPort-SDR: J2vFCmNLY/JyZohkLmLur2TyyB8WxMOVlZ698wY3TvySfS5jVFaWvdtFsIQPJRoP7T2W6lB0ry
 3YuK4NlcwP9w==
X-IronPort-AV: E=Sophos;i="5.73,440,1583193600"; 
   d="scan'208";a="32535841"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 27 May 2020 07:35:55 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id 3FA0AA219A;
        Wed, 27 May 2020 07:35:54 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 27 May 2020 07:35:53 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.26) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 27 May 2020 07:35:50 +0000
Subject: Re: Can't build rdma-core's azp image
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>
References: <05382c9f-a58d-ba5a-02cd-c25aa3604e52@amazon.com>
 <98b72450-1422-39ec-2f31-52a7dbaa57ea@amazon.com>
 <20200526192335.GO744@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <9f697fea-30e0-2a1f-3c9c-a2ae0100a8df@amazon.com>
Date:   Wed, 27 May 2020 10:35:45 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200526192335.GO744@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.26]
X-ClientProxiedBy: EX13D34UWC001.ant.amazon.com (10.43.162.112) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 26/05/2020 22:23, Jason Gunthorpe wrote:
> On Tue, May 26, 2020 at 09:25:30AM +0300, Gal Pressman wrote:
>> On 07/04/2020 18:47, Gal Pressman wrote:
>>> I'm trying to build the azp image and it fails with the following error [1].
>>> Anyone has an idea what went wrong?
>>
>> azp build broke again :(.
>>
>> The last step
>> Step 4/4 : RUN apt-get update && apt-get install -y --no-install-recommends libgcc-s1:i386 libgcc-s1:ppc64el && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends abi-compliance-checker abi-dumper ca-certificates clang-10 cmake cython3 debhelper dh-python dh-systemd dpkg-dev fakeroot gcc-10 gcc-9-aarch64-linux-gnu gcc-9-powerpc64le-linux-gnu git libc6-dev libc6-dev:arm64 libc6-dev:i386 libc6-dev:ppc64el libgcc-10-dev:i386 libgcc-9-dev:arm64 libgcc-9-dev:ppc64el libnl-3-dev libnl-3-dev:arm64 libnl-3-dev:i386 libnl-3-dev:ppc64el libnl-route-3-dev libnl-route-3-dev:arm64 libnl-route-3-dev:i386 libnl-route-3-dev:ppc64el libsystemd-dev libsystemd-dev:arm64 libsystemd-dev:i386 libsystemd-dev:ppc64el libudev-dev libudev-dev:arm64 libudev-dev:i386 libudev-dev:ppc64el lintian make ninja-build pandoc pkg-config python3 python3-dev python3-docutils python3-yaml sparse valgrind && apt-get clean && rm -rf /usr/share/doc/ /usr/lib/debug /var/lib/apt/lists/
>>
>> Fails with
>> W: https://apt.llvm.org/focal/pool/main/l/llvm-toolchain-10/libllvm10_10.0.1~++20200519100828+f79cd71e145-1~exp1~20200519201452.38_amd64.deb: No system certificates available. Try installing ca-certificates.
>> E: Could not configure 'libc6:arm64'.
>> E: Could not perform immediate configuration on 'libgcc-s1:arm64'. Please see man 5 apt.conf under APT::Immediate-Configure for details. (2)
> 
> couldn't reproduce

Maybe you have a cached image or something?
I just set up a clean instance and it reproduces immediately.
