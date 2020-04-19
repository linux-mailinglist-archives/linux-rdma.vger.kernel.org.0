Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F201AF796
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Apr 2020 08:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgDSGiK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Apr 2020 02:38:10 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:8725 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSGiJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 Apr 2020 02:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587278288; x=1618814288;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=NkK7ZtOw/klinHC3PgqsyEIBZfTFnHlWWPj4xtTMl60=;
  b=ETapkehXIQsBmKDV0XFjaE7zqf7PQUiDbMmelaxigg/7sKwSe8zIPTr1
   O25qUy+I7FBJ5nQvlOXpT9KftatUmP+XzUCiNX4KCH30YV6uT/CgOSe1F
   +oYKFBxBRCk5Pf9jeYjglEw9b3IRTMh/E1Qz/kOwUi/h5vmjb2JhkRAJU
   Y=;
IronPort-SDR: IbzxjDoYWRWJXlVGufKY6SP2KTMkS43GPd9MbAh3uAgMEU0BLov5HY432dD/EjvSwtjc/6XkIe
 i9wnaAriLdzw==
X-IronPort-AV: E=Sophos;i="5.72,402,1580774400"; 
   d="scan'208";a="26452049"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 19 Apr 2020 06:37:55 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id E3306A1F2D;
        Sun, 19 Apr 2020 06:37:53 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 19 Apr 2020 06:37:53 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.203) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 19 Apr 2020 06:37:50 +0000
Subject: Re: Can't build rdma-core's azp image
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>
References: <05382c9f-a58d-ba5a-02cd-c25aa3604e52@amazon.com>
 <20200407180658.GW20941@ziepe.ca>
 <67f9e08a-467c-34ce-e17e-816cb4bf03db@amazon.com>
 <ca41331c-3b53-fbb6-4543-bc960f796062@amazon.com>
 <20200417162150.GH26002@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <519a9c33-fa1b-7439-fa6a-7a54b69bde0b@amazon.com>
Date:   Sun, 19 Apr 2020 09:37:45 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200417162150.GH26002@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.203]
X-ClientProxiedBy: EX13D18UWC003.ant.amazon.com (10.43.162.237) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 17/04/2020 19:21, Jason Gunthorpe wrote:
> On Thu, Apr 16, 2020 at 10:05:11AM +0300, Gal Pressman wrote:
>> On 08/04/2020 9:35, Gal Pressman wrote:
>>> On 07/04/2020 21:06, Jason Gunthorpe wrote:
>>>> On Tue, Apr 07, 2020 at 06:47:51PM +0300, Gal Pressman wrote:
>>>>> I'm trying to build the azp image and it fails with the following error [1].
>>>>> Anyone has an idea what went wrong?
>>>>
>>>>> Reading package lists...
>>>>> W: http://apt.llvm.org/bionic/dists/llvm-toolchain-bionic-8/InRelease: No system
>>>>> certificates available. Try installing ca-certificates.
>>>>> W: http://apt.llvm.org/bionic/dists/llvm-toolchain-bionic-8/Release: No system
>>>>> certificates available. Try installing ca-certificates.
>>>>> E: The repository 'http://apt.llvm.org/bionic llvm-toolchain-bionic-8 Release'
>>>>> does not have a Release file.
>>>>
>>>> Oh, there is lots going wrong here..
>>>>
>>>> Above is because llvm droped http support from their repo.. Bit
>>>> annoying to fix..
>>>>
>>>>> The following packages have unmet dependencies:
>>>>>  libc6-dev:arm64 : Depends: libc6:arm64 (= 2.27-3ubuntu1) but it is not going to
>>>>> be installed
>>>>>  libgcc-8-dev:arm64 : Depends: libgcc1:arm64 (>= 1:8.4.0-1ubuntu1~18.04)
>>>>>                       Depends: libgomp1:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
>>>>> is not going to be installed
>>>>>                       Depends: libitm1:arm64 (>= 8.4.0-1ubuntu1~18.04) but it is
>>>>> not going to be installed
>>>>>                       Depends: libatomic1:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
>>>>> is not going to be installed
>>>>>                       Depends: libasan5:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
>>>>> is not going to be installed
>>>>>                       Depends: liblsan0:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
>>>>> is not going to be installed
>>>>>                       Depends: libtsan0:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
>>>>> is not going to be installed
>>>>>                       Depends: libubsan1:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
>>>>> is not going to be installed
>>>>>  libnl-3-dev:arm64 : Depends: libnl-3-200:arm64 (= 3.2.29-0ubuntu3) but it is
>>>>> not going to be installed
>>>>>  libnl-route-3-dev:arm64 : Depends: libnl-route-3-200:arm64 (= 3.2.29-0ubuntu3)
>>>>> but it is not going to be installed
>>>>>  libsystemd-dev:arm64 : Depends: libsystemd0:arm64 (= 237-3ubuntu10.39) but it
>>>>> is not going to be installed
>>>>>  libudev-dev:arm64 : Depends: libudev1:arm64 (= 237-3ubuntu10.39) but it is not
>>>>> going to be installed
>>>>
>>>> Oh neat, that is a problem in the toolchain ppa:
>>>>
>>>> $ apt-get install libgcc-s1:arm64 gcc-7
>>>>
>>>> The following packages have unmet dependencies:
>>>>  libgcc-s1:arm64 : Breaks: libgcc-7-dev (< 7.5.0-4) but 7.5.0-3ubuntu1~18.04 is to be installed
>>>>
>>>> The only ubuntu not broken right now is focal.. which is very new.
>>>>
>>>> Keep using the old docker image? Ask me in a week if it is still
>>>> broken, we can probably fix this by updating to focal, it is the next
>>>> LTS anyhow..
>>>
>>> Thanks Jason, I'll keep tracking the issue.
>>
>> Looks like the issue persists :\.
> 
> Are you sure? It seems fixed
> 
> root@069a1ad800ba:/# apt-get install libgcc-s1:arm64 gcc-7
> Reading package lists... Done
> Building dependency tree
> Reading state information... Done
> The following additional packages will be installed:
>   binutils binutils-common binutils-x86-64-linux-gnu cpp-7 gcc-10-base gcc-10-base:arm64 gcc-7-base gcc-8-base libasan4
>   libatomic1 libbinutils libc-dev-bin libc6:arm64 libc6-dev libcc1-0 libcilkrts5 libgcc-7-dev libgcc-s1 libgcc1 libgomp1
>   libisl19 libitm1 liblsan0 libmpc3 libmpfr6 libmpx2 libquadmath0 libstdc++6 libtsan0 libubsan0 linux-libc-dev manpages
>   manpages-dev
> Suggested packages:
>   binutils-doc gcc-7-locales gcc-7-multilib gcc-7-doc libgcc1-dbg libgomp1-dbg libitm1-dbg libatomic1-dbg libasan4-dbg
>   liblsan0-dbg libtsan0-dbg libubsan0-dbg libcilkrts5-dbg libmpx2-dbg libquadmath0-dbg glibc-doc:arm64 locales:arm64
>   glibc-doc man-browser
> The following NEW packages will be installed:
>   binutils binutils-common binutils-x86-64-linux-gnu cpp-7 gcc-10-base gcc-10-base:arm64 gcc-7 gcc-7-base libasan4
>   libatomic1 libbinutils libc-dev-bin libc6:arm64 libc6-dev libcc1-0 libcilkrts5 libgcc-7-dev libgcc-s1 libgcc-s1:arm64
>   libgomp1 libisl19 libitm1 liblsan0 libmpc3 libmpfr6 libmpx2 libquadmath0 libtsan0 libubsan0 linux-libc-dev manpages
>   manpages-dev
> The following packages will be upgraded:
>   gcc-8-base libgcc1 libstdc++6
> 3 upgraded, 32 newly installed, 0 to remove and 9 not upgraded.
> Need to get 35.2 MB of archives.
> After this operation, 131 MB of additional disk space will be used.
> Do you want to continue? [Y/n]
> 
> I will look more later

The error is different now, ends up with:

debconf: delaying package configuration, since apt-utils is not installed
Fetched 328 MB in 4s (80.9 MB/s)
Selecting previously unselected package gcc-10-base:amd64.
(Reading database ... 4046 files and directories currently installed.)
Preparing to unpack .../gcc-10-base_10-20200416-0ubuntu1~18.04_amd64.deb ...
Unpacking gcc-10-base:amd64 (10-20200416-0ubuntu1~18.04) ...
Selecting previously unselected package gcc-10-base:i386.
Preparing to unpack .../gcc-10-base_10-20200416-0ubuntu1~18.04_i386.deb ...
Unpacking gcc-10-base:i386 (10-20200416-0ubuntu1~18.04) ...
Selecting previously unselected package gcc-10-base:ppc64el.
Preparing to unpack .../gcc-10-base_10-20200416-0ubuntu1~18.04_ppc64el.deb ...
Unpacking gcc-10-base:ppc64el (10-20200416-0ubuntu1~18.04) ...
Selecting previously unselected package gcc-10-base:arm64.
Preparing to unpack .../gcc-10-base_10-20200416-0ubuntu1~18.04_arm64.deb ...
Unpacking gcc-10-base:arm64 (10-20200416-0ubuntu1~18.04) ...
Setting up gcc-10-base:amd64 (10-20200416-0ubuntu1~18.04) ...
Setting up gcc-10-base:i386 (10-20200416-0ubuntu1~18.04) ...
Setting up gcc-10-base:ppc64el (10-20200416-0ubuntu1~18.04) ...
Setting up gcc-10-base:arm64 (10-20200416-0ubuntu1~18.04) ...
Selecting previously unselected package libgcc-s1:amd64.
(Reading database ... 4054 files and directories currently installed.)
Preparing to unpack .../libgcc-s1_10-20200416-0ubuntu1~18.04_amd64.deb ...
Unpacking libgcc-s1:amd64 (10-20200416-0ubuntu1~18.04) ...
Replacing files in old package libgcc1:amd64 (1:8.3.0-26ubuntu1~18.04) ...
Selecting previously unselected package libgcc-s1:i386.
Preparing to unpack .../libgcc-s1_10-20200416-0ubuntu1~18.04_i386.deb ...
Unpacking libgcc-s1:i386 (10-20200416-0ubuntu1~18.04) ...
Selecting previously unselected package libgcc-s1:ppc64el.
Preparing to unpack .../libgcc-s1_10-20200416-0ubuntu1~18.04_ppc64el.deb ...
Unpacking libgcc-s1:ppc64el (10-20200416-0ubuntu1~18.04) ...
Selecting previously unselected package libgcc-s1:arm64.
Preparing to unpack .../libgcc-s1_10-20200416-0ubuntu1~18.04_arm64.deb ...
Unpacking libgcc-s1:arm64 (10-20200416-0ubuntu1~18.04) ...
Setting up libgcc-s1:amd64 (10-20200416-0ubuntu1~18.04) ...
Selecting previously unselected package libc6:i386.
(Reading database ... 4062 files and directories currently installed.)
Preparing to unpack .../libc6_2.27-3ubuntu1_i386.deb ...
debconf: unable to initialize frontend: Dialog
debconf: (TERM is not set, so the dialog frontend is not usable.)
debconf: falling back to frontend: Readline
debconf: unable to initialize frontend: Readline
debconf: (Can't locate Term/ReadLine.pm in @INC (you may need to install the
Term::ReadLine module) (@INC contains: /etc/perl
/usr/local/lib/x86_64-linux-gnu/perl/5.26.1 /usr/local/share/perl/5.26.1
/usr/lib/x86_64-linux-gnu/perl5/5.26 /usr/share/perl5
/usr/lib/x86_64-linux-gnu/perl/5.26 /usr/share/perl/5.26
/usr/local/lib/site_perl /usr/lib/x86_64-linux-gnu/perl-base) at
/usr/share/perl5/Debconf/FrontEnd/Readline.pm line 7.)
debconf: falling back to frontend: Teletype
Unpacking libc6:i386 (2.27-3ubuntu1) ...
Selecting previously unselected package libc6:ppc64el.
Preparing to unpack .../libc6_2.27-3ubuntu1_ppc64el.deb ...
debconf: unable to initialize frontend: Dialog
debconf: (TERM is not set, so the dialog frontend is not usable.)
debconf: falling back to frontend: Readline
debconf: unable to initialize frontend: Readline
debconf: (Can't locate Term/ReadLine.pm in @INC (you may need to install the
Term::ReadLine module) (@INC contains: /etc/perl
/usr/local/lib/x86_64-linux-gnu/perl/5.26.1 /usr/local/share/perl/5.26.1
/usr/lib/x86_64-linux-gnu/perl5/5.26 /usr/share/perl5
/usr/lib/x86_64-linux-gnu/perl/5.26 /usr/share/perl/5.26
/usr/local/lib/site_perl /usr/lib/x86_64-linux-gnu/perl-base) at
/usr/share/perl5/Debconf/FrontEnd/Readline.pm line 7.)
debconf: falling back to frontend: Teletype
Unpacking libc6:ppc64el (2.27-3ubuntu1) ...
Selecting previously unselected package libc6:arm64.
Preparing to unpack .../libc6_2.27-3ubuntu1_arm64.deb ...
debconf: unable to initialize frontend: Dialog
debconf: (TERM is not set, so the dialog frontend is not usable.)
debconf: falling back to frontend: Readline
debconf: unable to initialize frontend: Readline
debconf: (Can't locate Term/ReadLine.pm in @INC (you may need to install the
Term::ReadLine module) (@INC contains: /etc/perl
/usr/local/lib/x86_64-linux-gnu/perl/5.26.1 /usr/local/share/perl/5.26.1
/usr/lib/x86_64-linux-gnu/perl5/5.26 /usr/share/perl5
/usr/lib/x86_64-linux-gnu/perl/5.26 /usr/share/perl/5.26
/usr/local/lib/site_perl /usr/lib/x86_64-linux-gnu/perl-base) at
/usr/share/perl5/Debconf/FrontEnd/Readline.pm line 7.)
debconf: falling back to frontend: Teletype
Unpacking libc6:arm64 (2.27-3ubuntu1) ...
dpkg: dependency problems prevent configuration of libc6:i386:
 libc6:i386 depends on libgcc1; however:
  Package libgcc-s1:i386 which provides libgcc1 is not configured yet.

dpkg: error processing package libc6:i386 (--configure):
 dependency problems - leaving unconfigured
dpkg: dependency problems prevent configuration of libgcc-s1:ppc64el:
 libgcc-s1:ppc64el depends on libc6 (>= 2.17); however:
  Package libc6:ppc64el is not configured yet.

dpkg: error processing package libgcc-s1:ppc64el (--configure):
 dependency problems - leaving unconfigured
Errors were encountered while processing:
 libc6:i386
 libgcc-s1:ppc64el
E: Sub-process /usr/bin/dpkg returned an error code (1)
The command '/bin/sh -c apt-get update; apt-get install -y
--no-install-recommends abi-compliance-checker abi-dumper ca-certificates
clang-9 cmake cython3 debhelper dh-systemd dpkg-dev fakeroot
gcc-8-aarch64-linux-gnu gcc-8-powerpc64le-linux-gnu gcc-9 git libc6-dev
libc6-dev:arm64 libc6-dev:i386 libc6-dev:ppc64el libgcc-8-dev:arm64
libgcc-8-dev:ppc64el libgcc-9-dev:i386 libnl-3-dev libnl-3-dev:arm64
libnl-3-dev:i386 libnl-3-dev:ppc64el libnl-route-3-dev libnl-route-3-dev:arm64
libnl-route-3-dev:i386 libnl-route-3-dev:ppc64el libsystemd-dev
libsystemd-dev:arm64 libsystemd-dev:i386 libsystemd-dev:ppc64el libudev-dev
libudev-dev:arm64 libudev-dev:i386 libudev-dev:ppc64el lintian make ninja-build
pandoc pkg-config python2.7 python3 python3-dev python3-docutils python3-yaml
sparse valgrind && apt-get clean && rm -rf /usr/share/doc/ /usr/lib/debug
/var/lib/apt/lists/' returned a non-zero code: 100
Traceback (most recent call last):
  File "./buildlib/cbuild", line 1138, in <module>
    args.func(args);
  File "./buildlib/cbuild", line 1042, in cmd_build_images
    docker_cmd(args,*opts);
  File "./buildlib/cbuild", line 559, in docker_cmd
    return subprocess.check_call(["sudo","docker"] + cmd);
  File "/usr/lib64/python3.7/subprocess.py", line 347, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['sudo', 'docker', 'build', '--pull',
'-f', '/tmp/tmpzku61wlq/Dockerfile', '-t',
'ucfconsort.azurecr.io/rdma-core/azure_pipelines:28.0', '/tmp/tmpzku61wlq']'
returned non-zero exit status 100.
