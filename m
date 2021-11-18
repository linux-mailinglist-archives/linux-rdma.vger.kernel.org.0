Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E258F456342
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Nov 2021 20:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhKRTR2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Nov 2021 14:17:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:59278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229678AbhKRTR2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Nov 2021 14:17:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00CF261266;
        Thu, 18 Nov 2021 19:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637262867;
        bh=X4p4hD4m/Fv4EsrKa1Gp0ujysEBeFtYCDK62Mdtr0UM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mBmHFGXcBBfXeEM8+sLmRRJlKQKCMLmHHY9fKYDXReLwE3V5i6Zt8nR9Ur4dMY+v5
         Ud/MtGK2O9qjyDP9CvzkF3npxYvh17LHZiau2IIPqNj75GGttYQljajOXrDnJEUx6T
         it+PL60M1Ooi53aL1BroB80oqo6v9U2EzG1nfd2muKy+g3jQEAtu2DA0RjZZsGWZU3
         F0AczmnVXOs9ng83bKdM3NMVz1SInY/7cIMfAgyziuoopSizf1B5MZjz5JYgKuUHQQ
         geYuePu2px/Yu44k9k3kjvmL98lRfpoZVrSwRud5hDSerJ/u1CYObI5qauR1NJRmtL
         9QYh3Op2Zm/Eg==
Date:   Thu, 18 Nov 2021 21:14:22 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob =?iso-8859-1?Q?Dr=F6ge?= <b.e.droge@rug.nl>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Installation with prebuilt docs failing
Message-ID: <YZamDj1EqThLccyj@unreal>
References: <760b0992-776f-d35d-bbf3-6d7f351d0839@rug.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <760b0992-776f-d35d-bbf3-6d7f351d0839@rug.nl>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 18, 2021 at 06:09:55PM +0100, Bob Dröge wrote:
> Hi,
> 
> I'm trying to install rdma-core 37.1  from source on a Gentoo Prefix system
> which does not have pandoc nor rst2man installed. I'm using the release
> tarball from the GitHub release page (https://github.com/linux-rdma/rdma-core/releases/download/v37.1/rdma-core-37.1.tar.gz),
> though, and was expecting that it would use the prebuilt man pages in this
> case. However, this fails at some point with the following error:
> 
> -- Installing: /cvmfs/pilot.eessi-hpc.org/2021.06/compat/linux/x86_64/var/tmp/portage/sys-cluster/rdma-core-37.1/image/cvmfs/pilot.eessi-hpc.org/2021.06/compat/linux/x86_64/usr/share/perl5/IBswcountlimits.pm
> -- Installing: /cvmfs/pilot.eessi-hpc.org/2021.06/compat/linux/x86_64/var/tmp/portage/sys-cluster/rdma-core-37.1/image/cvmfs/pilot.eessi-hpc.org/2021.06/compat/linux/x86_64/usr/share/man/man8/check_lft_balance.8
> CMake Error at infiniband-diags/man/cmake_install.cmake:66 (file):
>   file INSTALL cannot find
> "/cvmfs/pilot.eessi-hpc.org/2021.06/compat/linux/x86_64/var/tmp/portage/sys-cluster/rdma-core-37.1/work/rdma-core-37.1/buildlib/pandoc-prebuilt/8db9dce39d3eaf2d3992fd9198060d4bdfeb83d6":
>   No such file or directory.
> Call Stack (most recent call first):
>   cmake_install.cmake:222 (include)
> 
> FAILED: CMakeFiles/install.util
> cd /cvmfs/pilot.eessi-hpc.org/2021.06/compat/linux/x86_64/var/tmp/portage/sys-cluster/rdma-core-37.1/work/rdma-core-37.1_build
> && /cvmfs/pilot.eessi-hpc.org/2021.06/compat/linux/x86_64/usr/bin/cmake -P
> cmake_install.cmake
> ninja: build stopped: subcommand failed.
> 
> Though the directory does exist and contains a bunch of files, this one is
> indeed missing. Is this expected (does it only work for certain cases?), or
> is something missing in this tarball?

It is definitely a bug. 

Thanks

> 
> Best regards,
> Bob Dröge
