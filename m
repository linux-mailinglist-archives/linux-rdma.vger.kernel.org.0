Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9281A12B7
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2020 19:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgDGR2o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Apr 2020 13:28:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgDGR2n (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Apr 2020 13:28:43 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76D8C206F7;
        Tue,  7 Apr 2020 17:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586280522;
        bh=GP7wvnW1K2jw7arQN3z+8+d7qRxswrVoIZZam8RVMaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C5rgo3ofgCP3tRDlK48wT7yYYxbPVp/D98Gzie/rDk79H/YqBuKxfNcm6+WFYEVgb
         2sabGQHSmx0Z5JKAZQbQj90OGC8ZwB8f5cWjoJ/SNPNrdZNDjH5CdZjs2jVASoW6Rz
         dvGLv++y3VLKtS5G95tA8ZlNx6HI+l+FPUJ4JlcA=
Date:   Tue, 7 Apr 2020 20:28:39 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Can't build rdma-core's azp image
Message-ID: <20200407172839.GO80989@unreal>
References: <05382c9f-a58d-ba5a-02cd-c25aa3604e52@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05382c9f-a58d-ba5a-02cd-c25aa3604e52@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 07, 2020 at 06:47:51PM +0300, Gal Pressman wrote:
> I'm trying to build the azp image and it fails with the following error [1].
> Anyone has an idea what went wrong?
>
> Thanks
>
> [1]
>
> [ec2-user@ip-10-0-0-221 rdma-core]$ sudo ./buildlib/cbuild build-images azp

Why do you run "sudo"? It should work without it.

Thanks


> [...]
>  ---> Running in 84c2eeb7a740
> Ign:1 https://apt.llvm.org/bionic llvm-toolchain-bionic-8 InRelease
> Err:2 https://apt.llvm.org/bionic llvm-toolchain-bionic-8 Release
>   Certificate verification failed: The certificate is NOT trusted. The
> certificate issuer is unknown.  Could not handshake: Error in the certificate
> verification. [IP: 199.232.26.49 443]
> Get:3 http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu bionic InRelease
> [15.4 kB]
> Get:4 http://ports.ubuntu.com bionic InRelease [242 kB]
> Get:5 http://ports.ubuntu.com bionic-security InRelease [88.7 kB]
> Get:6 http://ports.ubuntu.com bionic-updates InRelease [88.7 kB]
> Get:7 http://archive.ubuntu.com/ubuntu bionic InRelease [242 kB]
> Get:8 http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu bionic/main arm64
> Packages [19.5 kB]
> Get:9 http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu bionic/main amd64
> Packages [39.0 kB]
> Get:10 http://archive.ubuntu.com/ubuntu bionic-updates InRelease [88.7 kB]
> Get:11 http://ports.ubuntu.com bionic/main ppc64el Packages [1284 kB]
> Get:12 http://archive.ubuntu.com/ubuntu bionic-backports InRelease [74.6 kB]
> Get:13 http://security.ubuntu.com/ubuntu bionic-security InRelease [88.7 kB]
> Get:14 http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu bionic/main
> ppc64el Packages [19.5 kB]
> Get:15 http://ports.ubuntu.com bionic/main arm64 Packages [1285 kB]
> Get:16 http://ports.ubuntu.com bionic/universe arm64 Packages [11.0 MB]
> Get:17 http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu bionic/main i386
> Packages [36.7 kB]
> Get:18 http://ports.ubuntu.com bionic/universe ppc64el Packages [10.9 MB]
> Get:19 http://archive.ubuntu.com/ubuntu bionic/restricted i386 Packages [13.5 kB]
> Get:20 http://archive.ubuntu.com/ubuntu bionic/main i386 Packages [1328 kB]
> Get:21 http://archive.ubuntu.com/ubuntu bionic/multiverse i386 Packages [177 kB]
> Get:22 http://archive.ubuntu.com/ubuntu bionic/main amd64 Packages [1344 kB]
> Get:23 http://archive.ubuntu.com/ubuntu bionic/universe amd64 Packages [11.3 MB]
> Get:24 http://ports.ubuntu.com bionic-security/universe ppc64el Packages [693 kB]
> Get:25 http://ports.ubuntu.com bionic-security/universe arm64 Packages [742 kB]
> Get:26 http://ports.ubuntu.com bionic-security/main ppc64el Packages [507 kB]
> Get:27 http://ports.ubuntu.com bionic-security/main arm64 Packages [571 kB]
> Get:28 http://ports.ubuntu.com bionic-updates/universe ppc64el Packages [1157 kB]
> Get:29 http://ports.ubuntu.com bionic-updates/main ppc64el Packages [773 kB]
> Get:30 http://archive.ubuntu.com/ubuntu bionic/universe i386 Packages [11.3 MB]
> Get:31 http://ports.ubuntu.com bionic-updates/universe arm64 Packages [1220 kB]
> Get:32 http://ports.ubuntu.com bionic-updates/main arm64 Packages [844 kB]
> Get:33 http://archive.ubuntu.com/ubuntu bionic/restricted amd64 Packages [13.5 kB]
> Get:34 http://archive.ubuntu.com/ubuntu bionic/multiverse amd64 Packages [186 kB]
> Get:35 http://archive.ubuntu.com/ubuntu bionic-updates/multiverse amd64 Packages
> [12.6 kB]
> Get:36 http://archive.ubuntu.com/ubuntu bionic-updates/main i386 Packages [865 kB]
> Get:37 http://archive.ubuntu.com/ubuntu bionic-updates/universe amd64 Packages
> [1370 kB]
> Get:38 http://security.ubuntu.com/ubuntu bionic-security/main amd64 Packages
> [883 kB]
> Get:39 http://archive.ubuntu.com/ubuntu bionic-updates/multiverse i386 Packages
> [8174 B]
> Get:40 http://archive.ubuntu.com/ubuntu bionic-updates/restricted i386 Packages
> [14.1 kB]
> Get:41 http://archive.ubuntu.com/ubuntu bionic-updates/universe i386 Packages
> [1302 kB]
> Get:42 http://archive.ubuntu.com/ubuntu bionic-updates/restricted amd64 Packages
> [58.4 kB]
> Get:43 http://archive.ubuntu.com/ubuntu bionic-updates/main amd64 Packages [1181 kB]
> Get:44 http://archive.ubuntu.com/ubuntu bionic-backports/universe i386 Packages
> [4240 B]
> Get:45 http://archive.ubuntu.com/ubuntu bionic-backports/main i386 Packages [2493 B]
> Get:46 http://archive.ubuntu.com/ubuntu bionic-backports/main amd64 Packages
> [2496 B]
> Get:47 http://archive.ubuntu.com/ubuntu bionic-backports/universe amd64 Packages
> [4247 B]
> Get:48 http://security.ubuntu.com/ubuntu bionic-security/restricted amd64
> Packages [43.1 kB]
> Get:49 http://security.ubuntu.com/ubuntu bionic-security/multiverse amd64
> Packages [7904 B]
> Get:50 http://security.ubuntu.com/ubuntu bionic-security/universe i386 Packages
> [788 kB]
> Get:51 http://security.ubuntu.com/ubuntu bionic-security/universe amd64 Packages
> [836 kB]
> Get:52 http://security.ubuntu.com/ubuntu bionic-security/main i386 Packages [588 kB]
> Get:53 http://security.ubuntu.com/ubuntu bionic-security/restricted i386
> Packages [5385 B]
> Get:54 http://security.ubuntu.com/ubuntu bionic-security/multiverse i386
> Packages [4513 B]
> Reading package lists...
> W: http://apt.llvm.org/bionic/dists/llvm-toolchain-bionic-8/InRelease: No system
> certificates available. Try installing ca-certificates.
> W: http://apt.llvm.org/bionic/dists/llvm-toolchain-bionic-8/Release: No system
> certificates available. Try installing ca-certificates.
> E: The repository 'http://apt.llvm.org/bionic llvm-toolchain-bionic-8 Release'
> does not have a Release file.
> Reading package lists...
> Building dependency tree...
> Reading state information...
> Some packages could not be installed. This may mean that you have
> requested an impossible situation or if you are using the unstable
> distribution that some required packages have not yet been created
> or been moved out of Incoming.
> The following information may help to resolve the situation:
>
> The following packages have unmet dependencies:
>  libc6-dev:arm64 : Depends: libc6:arm64 (= 2.27-3ubuntu1) but it is not going to
> be installed
>  libgcc-8-dev:arm64 : Depends: libgcc1:arm64 (>= 1:8.4.0-1ubuntu1~18.04)
>                       Depends: libgomp1:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
> is not going to be installed
>                       Depends: libitm1:arm64 (>= 8.4.0-1ubuntu1~18.04) but it is
> not going to be installed
>                       Depends: libatomic1:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
> is not going to be installed
>                       Depends: libasan5:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
> is not going to be installed
>                       Depends: liblsan0:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
> is not going to be installed
>                       Depends: libtsan0:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
> is not going to be installed
>                       Depends: libubsan1:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
> is not going to be installed
>  libnl-3-dev:arm64 : Depends: libnl-3-200:arm64 (= 3.2.29-0ubuntu3) but it is
> not going to be installed
>  libnl-route-3-dev:arm64 : Depends: libnl-route-3-200:arm64 (= 3.2.29-0ubuntu3)
> but it is not going to be installed
>  libsystemd-dev:arm64 : Depends: libsystemd0:arm64 (= 237-3ubuntu10.39) but it
> is not going to be installed
>  libudev-dev:arm64 : Depends: libudev1:arm64 (= 237-3ubuntu10.39) but it is not
> going to be installed
> E: Unable to correct problems, you have held broken packages.
> The command '/bin/sh -c apt-get update; apt-get install -y
> --no-install-recommends abi-compliance-checker abi-dumper ca-certificates
> clang-9 cmake cython3 debhelper dh-systemd dpkg-dev fakeroot
> gcc-8-aarch64-linux-gnu gcc-8-powerpc64le-linux-gnu gcc-9 git libc6-dev
> libc6-dev:arm64 libc6-dev:i386 libc6-dev:ppc64el libgcc-8-dev:arm64
> libgcc-8-dev:ppc64el libgcc-9-dev:i386 libnl-3-dev libnl-3-dev:arm64
> libnl-3-dev:i386 libnl-3-dev:ppc64el libnl-route-3-dev libnl-route-3-dev:arm64
> libnl-route-3-dev:i386 libnl-route-3-dev:ppc64el libsystemd-dev
> libsystemd-dev:arm64 libsystemd-dev:i386 libsystemd-dev:ppc64el libudev-dev
> libudev-dev:arm64 libudev-dev:i386 libudev-dev:ppc64el lintian make ninja-build
> pandoc pkg-config python2.7 python3 python3-dev python3-docutils python3-yaml
> sparse valgrind && apt-get clean && rm -rf /usr/share/doc/ /usr/lib/debug
> /var/lib/apt/lists/' returned a non-zero code: 100
> Traceback (most recent call last):
>   File "./buildlib/cbuild", line 1138, in <module>
>     args.func(args);
>   File "./buildlib/cbuild", line 1042, in cmd_build_images
>     docker_cmd(args,*opts);
>   File "./buildlib/cbuild", line 559, in docker_cmd
>     return subprocess.check_call(["sudo","docker"] + cmd);
>   File "/usr/lib64/python3.7/subprocess.py", line 347, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', 'docker', 'build', '--pull',
> '-f', '/tmp/tmp2l8ziblv/Dockerfile', '-t',
> 'ucfconsort.azurecr.io/rdma-core/azure_pipelines:28.0', '/tmp/tmp2l8ziblv']'
> returned non-zero exit status 100.
