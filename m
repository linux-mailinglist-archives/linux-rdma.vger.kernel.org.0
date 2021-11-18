Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACA2456131
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Nov 2021 18:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhKRRM6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Nov 2021 12:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhKRRM6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Nov 2021 12:12:58 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4A3C061574
        for <linux-rdma@vger.kernel.org>; Thu, 18 Nov 2021 09:09:57 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x6so18392790edr.5
        for <linux-rdma@vger.kernel.org>; Thu, 18 Nov 2021 09:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rug-nl.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=oLBvcU6rwcYDmYLmduBp4uzU0B4TCA/YCXWooSNcg4A=;
        b=4YGsG//ok1CSAH9CRSU7wtBvrg6wnF8MfhK3xGij9jAWiHmNna/Qynd1Z+TPj2lCnN
         jNNNaVrkBLBpltX5qMS5C+aD5BxET98KmyN6ZjihMC/g+SSdsD5AEJLoy36vTmhC4NH4
         CR6eztWlLc7M2nl2n310B+uo+aDxkxH/7O5OQZ2W5FREb2GthTZHCZdeTTceSkgE76fd
         f0EPU9+r2DVSq1OHHL09heWgT/ZQmb/CL6Gj15l8G/sXiUgxKmQmCTWrnPFFQKg1bllk
         lNDi4uTzQjc73EOh6YWkKfTgKOzXxV6+wt2zhtBwDxot2PvImF5IPvY5L9D8JhSIKeWE
         D4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=oLBvcU6rwcYDmYLmduBp4uzU0B4TCA/YCXWooSNcg4A=;
        b=z2NWYxSyNunq6NU7YSvo+F25lH8C2Gssx1yxK6grZj4PFSEyYGcVlKXc6fVJvrn1pB
         9dU8DLtR9OSPtLHM3pZ9t/R0G04LEaShjmaEn4gNjI+e6r3fwkHE4WCShkpJehRVP1VJ
         14SAR9AGOU6JTxUJAxB/LMT9Ya4w9Qd7LP8ZLYFObw4MFdsvFrJrWDQ9YgqGLS6vGlNe
         kzBAqJvdMOXuXYLseT3KPpdPSFS/smLmQvL/LQMY+7mYsTqIJ/tI77s7davQFLVfSB8A
         fb4Z5ZpCgOrVb9kgKRS08sljpIbCQuJio1IusQtv/XdJ3cSbz3FuV8sRlRlAdHJ4N1GY
         Y6nQ==
X-Gm-Message-State: AOAM531QI4JWjU66ThHMWwZk2feZsrNlgV1jN2EO+DFxZ8lTl6W8ir2C
        eR6LZbKfbPdnoWLdku8WgT9uti/7wEpx4Q==
X-Google-Smtp-Source: ABdhPJyahXHPhdDYBI5P7d/7m4P0Ga4ZLn7QSZpMZOHTOg2BkVQUtmmtd57gQ2DBEux9djoMxhEyaw==
X-Received: by 2002:a05:6402:51cf:: with SMTP id r15mr450388edd.271.1637255396237;
        Thu, 18 Nov 2021 09:09:56 -0800 (PST)
Received: from [192.168.2.3] (86-83-245-97.fixed.kpn.net. [86.83.245.97])
        by smtp.gmail.com with ESMTPSA id m6sm260611edc.36.2021.11.18.09.09.55
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 09:09:55 -0800 (PST)
Message-ID: <760b0992-776f-d35d-bbf3-6d7f351d0839@rug.nl>
Date:   Thu, 18 Nov 2021 18:09:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-US
To:     linux-rdma@vger.kernel.org
From:   =?UTF-8?Q?Bob_Dr=c3=b6ge?= <b.e.droge@rug.nl>
Subject: Installation with prebuilt docs failing
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

I'm trying to install rdma-core 37.1  from source on a Gentoo Prefix 
system which does not have pandoc nor rst2man installed. I'm using the 
release tarball from the GitHub release page 
(https://github.com/linux-rdma/rdma-core/releases/download/v37.1/rdma-core-37.1.tar.gz), 
though, and was expecting that it would use the prebuilt man pages in 
this case. However, this fails at some point with the following error:

-- Installing: 
/cvmfs/pilot.eessi-hpc.org/2021.06/compat/linux/x86_64/var/tmp/portage/sys-cluster/rdma-core-37.1/image/cvmfs/pilot.eessi-hpc.org/2021.06/compat/linux/x86_64/usr/share/perl5/IBswcountlimits.pm
-- Installing: 
/cvmfs/pilot.eessi-hpc.org/2021.06/compat/linux/x86_64/var/tmp/portage/sys-cluster/rdma-core-37.1/image/cvmfs/pilot.eessi-hpc.org/2021.06/compat/linux/x86_64/usr/share/man/man8/check_lft_balance.8
CMake Error at infiniband-diags/man/cmake_install.cmake:66 (file):
   file INSTALL cannot find
"/cvmfs/pilot.eessi-hpc.org/2021.06/compat/linux/x86_64/var/tmp/portage/sys-cluster/rdma-core-37.1/work/rdma-core-37.1/buildlib/pandoc-prebuilt/8db9dce39d3eaf2d3992fd9198060d4bdfeb83d6":
   No such file or directory.
Call Stack (most recent call first):
   cmake_install.cmake:222 (include)

FAILED: CMakeFiles/install.util
cd 
/cvmfs/pilot.eessi-hpc.org/2021.06/compat/linux/x86_64/var/tmp/portage/sys-cluster/rdma-core-37.1/work/rdma-core-37.1_build 
&& /cvmfs/pilot.eessi-hpc.org/2021.06/compat/linux/x86_64/usr/bin/cmake 
-P cmake_install.cmake
ninja: build stopped: subcommand failed.

Though the directory does exist and contains a bunch of files, this one 
is indeed missing. Is this expected (does it only work for certain 
cases?), or is something missing in this tarball?

Best regards,
Bob Dröge
