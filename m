Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50E022DC73
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jul 2020 09:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgGZHGJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jul 2020 03:06:09 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:47844 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgGZHGJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 26 Jul 2020 03:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595747168; x=1627283168;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=nyPvtnoqG/ac2Sfk59iGyiEkM2LglkoGM9+F0XvBF98=;
  b=oK99XAwptu+BKmy9M+OBF8FNnnxOiC1aczTn5Lggc1YpAppclzzn4/ON
   f2RYWTY6aSKiDiET8n1slXnhUGfVNePLl+X5uAOIcxfQAZD1n5j9iQPHR
   os1l8jOxRtCPfvUOX8FNFSCFCX+bfKmWHkahC5isED0nV/Lsx8C9k+0EX
   o=;
IronPort-SDR: aO7XOm2wX4HyYO5KZdi1DLlVLub7sXzKDM5/76TAem0FzklYhQ5GUub5Bn1DiajogUKl9/cap1
 P6x6SI1+w5PQ==
X-IronPort-AV: E=Sophos;i="5.75,397,1589241600"; 
   d="scan'208";a="54662248"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 26 Jul 2020 07:06:08 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id F1F46A1C7C;
        Sun, 26 Jul 2020 07:06:07 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 26 Jul 2020 07:06:07 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.156) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 26 Jul 2020 07:06:04 +0000
Subject: Re: Can't build rdma-core's azp image
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>
References: <05382c9f-a58d-ba5a-02cd-c25aa3604e52@amazon.com>
 <98b72450-1422-39ec-2f31-52a7dbaa57ea@amazon.com>
 <20200526192335.GO744@ziepe.ca>
 <9f697fea-30e0-2a1f-3c9c-a2ae0100a8df@amazon.com>
Message-ID: <221cbc21-f027-3312-5043-7622c7e854d3@amazon.com>
Date:   Sun, 26 Jul 2020 10:05:59 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9f697fea-30e0-2a1f-3c9c-a2ae0100a8df@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.156]
X-ClientProxiedBy: EX13D41UWC004.ant.amazon.com (10.43.162.31) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 27/05/2020 10:35, Gal Pressman wrote:
> On 26/05/2020 22:23, Jason Gunthorpe wrote:
>> On Tue, May 26, 2020 at 09:25:30AM +0300, Gal Pressman wrote:
>>> On 07/04/2020 18:47, Gal Pressman wrote:
>>>> I'm trying to build the azp image and it fails with the following error [1].
>>>> Anyone has an idea what went wrong?
>>>
>>> azp build broke again :(.
>>>
>>> The last step
>>> Step 4/4 : RUN apt-get update && apt-get install -y --no-install-recommends libgcc-s1:i386 libgcc-s1:ppc64el && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends abi-compliance-checker abi-dumper ca-certificates clang-10 cmake cython3 debhelper dh-python dh-systemd dpkg-dev fakeroot gcc-10 gcc-9-aarch64-linux-gnu gcc-9-powerpc64le-linux-gnu git libc6-dev libc6-dev:arm64 libc6-dev:i386 libc6-dev:ppc64el libgcc-10-dev:i386 libgcc-9-dev:arm64 libgcc-9-dev:ppc64el libnl-3-dev libnl-3-dev:arm64 libnl-3-dev:i386 libnl-3-dev:ppc64el libnl-route-3-dev libnl-route-3-dev:arm64 libnl-route-3-dev:i386 libnl-route-3-dev:ppc64el libsystemd-dev libsystemd-dev:arm64 libsystemd-dev:i386 libsystemd-dev:ppc64el libudev-dev libudev-dev:arm64 libudev-dev:i386 libudev-dev:ppc64el lintian make ninja-build pandoc pkg-config python3 python3-dev python3-docutils python3-yaml sparse valgrind && apt-get clean && rm -rf /usr/share/doc/ /usr/lib/debug /var/lib/apt/lists/
>>>
>>> Fails with
>>> W: https://apt.llvm.org/focal/pool/main/l/llvm-toolchain-10/libllvm10_10.0.1~++20200519100828+f79cd71e145-1~exp1~20200519201452.38_amd64.deb: No system certificates available. Try installing ca-certificates.
>>> E: Could not configure 'libc6:arm64'.
>>> E: Could not perform immediate configuration on 'libgcc-s1:arm64'. Please see man 5 apt.conf under APT::Immediate-Configure for details. (2)
>>
>> couldn't reproduce
> 
> Maybe you have a cached image or something?
> I just set up a clean instance and it reproduces immediately.

It was fixed at some point, and now it's back again:

Step 4/4 : RUN apt-get update && apt-get install -y --no-install-recommends libgcc-s1:i386 libgcc-s1:ppc64el && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends abi-compliance-checker abi-dumper ca-certificates clang-10 cmake cython3 debhelper dh-python dh-systemd dpkg-dev fakeroot gcc-10 gcc-9-aarch64-linux-gnu gcc-9-powerpc64le-linux-gnu git libc6-dev libc6-dev:arm64 libc6-dev:i386 libc6-dev:ppc64el libgcc-10-dev:i386 libgcc-9-dev:arm64 libgcc-9-dev:ppc64el libnl-3-dev libnl-3-dev:arm64 libnl-3-dev:i386 libnl-3-dev:ppc64el libnl-route-3-dev libnl-route-3-dev:arm64 libnl-route-3-dev:i386 libnl-route-3-dev:ppc64el libsystemd-dev libsystemd-dev:arm64 libsystemd-dev:i386 libsystemd-dev:ppc64el libudev-dev libudev-dev:arm64 libudev-dev:i386 libudev-dev:ppc64el lintian make ninja-build pandoc pkg-config python3 python3-dev python3-docutils python3-yaml sparse valgrind && apt-get clean && rm -rf /usr/share/doc/ /usr/lib/debug /var/lib/apt/lists/

[...]

W: https://apt.llvm.org/focal/pool/main/l/llvm-toolchain-10/libllvm10_10.0.1~++20200708122807+ef32c611aa2-1~exp1~20200707223407.61_amd64.deb: No system certificates available. Try installing ca-certificates.
W: https://apt.llvm.org/focal/pool/main/l/llvm-toolchain-10/libclang1-10_10.0.1~++20200708122807+ef32c611aa2-1~exp1~20200707223407.61_amd64.deb: No system certificates available. Try installing ca-certificates.
E: Could not configure 'libc6:arm64'.
E: Could not perform immediate configuration on 'libgcc-s1:arm64'. Please see man 5 apt.conf under APT::Immediate-Configure for details. (2)

Maybe it's an issue with the llvm repo?
