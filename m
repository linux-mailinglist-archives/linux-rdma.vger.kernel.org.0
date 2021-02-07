Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE40D312265
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Feb 2021 09:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhBGIHf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Feb 2021 03:07:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:55866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhBGIHe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 7 Feb 2021 03:07:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94E8D64E6E;
        Sun,  7 Feb 2021 08:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612685213;
        bh=mvIXzaF1CNhkIX8fo3RN4AcWUFBnIDlWv72mz/nLshg=;
        h=Date:From:To:Cc:Subject:From;
        b=vNglszl+RBkOhlybmBTC2AEJUhrqFNUonr61q89/ooZhAvRzC7lAku1eYKhxfI9iM
         HfisjbOVMfVpnrpbIPxatATGPZ1WHyrx9N/r4trIR1KZ6/4sP8Cbr2i6XGFu+Bp0Bq
         LWztd0GyWgcOrIby1jLfw4SWqMSSGeFLpV/gPFOffKi/v1pCXSIcCn4IftXBdx2a1v
         yx1brG2rwSGzO3NPENnKIwNtJPyJfA0OXC0m9A3Nxf2VUHdQkTW69hQSLiAIGAzbsL
         LEs3+qhFNSQUIyILLhhbpeSjNI0W4MGXKEH2DV6RGcGVZZh6cgukdkLcqgkgQ33wXC
         Ht7qZOJ5u+X8Q==
Date:   Sun, 7 Feb 2021 10:06:49 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Honggang Li <honli@redhat.com>
Cc:     Itay Aveksis <itayav@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Alaa Hleihel <alaa@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
Subject: rdma-core spec weird behavior on Fedora
Message-ID: <20210207080649.GB4656@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Honggang,

Your commit b02de521022a ("redhat: Remove base package dependency from all sub-packages")
removes protection from rdma-core when user performs "dnf autoremove".

Before your patch, systemd was dependent on libibverbs and latter
required rdma-core. After your patch, the last link is lost and
rdma-core marked as orphaned package.

Any attempt to install rdma-core as standalone package will have the
following errors, due to the library dependency of udevadm.
[leonro@c rdma-core]$ ldd /sbin/udevadm | grep verbs
	libibverbs.so.1 => not found

[leonro@c rdma-core]$ sudo dnf install /tmp/rdma-core/RPMS/x86_64/rdma-core-34.0-1.fc32.x86_64.rpm
Last metadata expiration check: 1:29:40 ago on Sun 07 Feb 2021 07:29:13 AM IST.
Dependencies resolved.
======================================================================================================================
 Package                    Architecture            Version                       Repository                     Size
======================================================================================================================
Installing:
 rdma-core                  x86_64                  34.0-1.fc32                   @commandline                   54 k

Transaction Summary
======================================================================================================================
Install  1 Package

Total size: 54 k
Installed size: 121 k
Is this ok [y/N]: y
Downloading Packages:
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                        1/1
  Installing       : rdma-core-34.0-1.fc32.x86_64                                                           1/1
  Running scriptlet: rdma-core-34.0-1.fc32.x86_64                                                           1/1
/sbin/udevadm: error while loading shared libraries: libibverbs.so.1: cannot open shared object file: No such file or directory
/sbin/udevadm: error while loading shared libraries: libibverbs.so.1: cannot open shared object file: No such file or directory
/sbin/udevadm: error while loading shared libraries: libibverbs.so.1: cannot open shared object file: No such file or directory

/usr/bin/udevadm: error while loading shared libraries: libibverbs.so.1: cannot open shared object file: No such file or directory

/usr/bin/systemctl: error while loading shared libraries: libibverbs.so.1: cannot open shared object file: No such file or directory
warning: %triggerin(systemd-245.8-2.fc32.x86_64) scriptlet failed, exit status 127

Error in <unknown> scriptlet in rpm package rdma-core
  Verifying        : rdma-core-34.0-1.fc32.x86_64                                                           1/1

Installed:
  rdma-core-34.0-1.fc32.x86_64

Complete!

--------------------------------------------------------------------------------------
I think that the right solution is to make rdma-core meta-package as we
wanted it from the beginning when created rdma-core repo.

Thanks
