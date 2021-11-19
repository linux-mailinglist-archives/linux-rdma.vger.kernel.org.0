Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C4C456FB4
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 14:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhKSNhZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 08:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhKSNhZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Nov 2021 08:37:25 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACF1C061574
        for <linux-rdma@vger.kernel.org>; Fri, 19 Nov 2021 05:34:23 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id g1so7094863qvd.2
        for <linux-rdma@vger.kernel.org>; Fri, 19 Nov 2021 05:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YBsLaEMU43B+wsTjoSsaUAEYE7w8cPIH6FhwIA5oMwQ=;
        b=npewmoQfZBqnuABqlq++4+Lz9C4IYmo3EVDp6ErPMrubc/hJaGBwYbCwUv55OjEmo9
         eYG+c1zrclCUjB5j969CkOsKMQpgDDvR+aewW6YXZb5Cye6U/JM8FtDo1d/uAphAm9jy
         53UKCKFF7ebZ3yD2D1A4sdFY3csCp2DcVBtio2GWgLXqbX+kH3REV+uPrkXiKVTl6n7D
         RzE2WrnQbD5f8RimSidm0t/FWDW3oJKsXKmdrIACCsnPu1cCo+auIWZBWdH+vAWVcaD8
         xpOrjx3XE7EDjXewndQvaiIi+ad/xWa/SHUpQkU4vVLHIb1QhZL03kDvuJFebose0HSJ
         aLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YBsLaEMU43B+wsTjoSsaUAEYE7w8cPIH6FhwIA5oMwQ=;
        b=kmff99gjy9qWcvXVN1gUpR1gaDSMiX991kL5b/n4V03PpoykCyEP2gB9UlPoowELa/
         YjYAT/LcURBiaLWg3ipZ+mtyYZochupKZ/Ldvs3u+7IWREZrnBrwSaYmb8s5UjJ1rr/c
         KEdqX1mpAB3L4GJJkAC02QHyq0Wy8LTxml4XISkYa4IktFpTZV8/JsaF3n9hKGFlLj4r
         qlt7ceJYZJrbXdfig1GQfiZHhidIiR80wMc60w48D86LhkyyWTZZMqBsvOkBux8EosTt
         lvV/P+QAT8SM0qGtP82gdKG2BlvxfFvTQ5WtwqXEfo9ElRpPSrp7NwYYbBGcGSB6qJq/
         pWdQ==
X-Gm-Message-State: AOAM533AlFdkAnDwQ8WXogW2mn20pFEdf2dKFZyfC2OYAsCmUowsoGLD
        12dqyxmuvriJUPWUmi1U2ttZhw==
X-Google-Smtp-Source: ABdhPJwYkmRqv/kq5Q2tUI4TitIYOcayxSqbBwP0MmOFY7uMcXcJsyAfYe6eKuhBkTRionNrAGqdpQ==
X-Received: by 2002:a05:6214:5286:: with SMTP id kj6mr73834138qvb.50.1637328862598;
        Fri, 19 Nov 2021 05:34:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id y16sm1449223qtm.12.2021.11.19.05.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 05:34:21 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mo421-00CE2g-73; Fri, 19 Nov 2021 09:34:21 -0400
Date:   Fri, 19 Nov 2021 09:34:21 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Bob =?utf-8?B?RHLDtmdl?= <b.e.droge@rug.nl>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        linux-rdma@vger.kernel.org
Subject: Re: Installation with prebuilt docs failing
Message-ID: <20211119133421.GG876299@ziepe.ca>
References: <760b0992-776f-d35d-bbf3-6d7f351d0839@rug.nl>
 <YZamDj1EqThLccyj@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YZamDj1EqThLccyj@unreal>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 18, 2021 at 09:14:22PM +0200, Leon Romanovsky wrote:
> On Thu, Nov 18, 2021 at 06:09:55PM +0100, Bob Dröge wrote:
> > Hi,
> > 
> > I'm trying to install rdma-core 37.1  from source on a Gentoo Prefix system
> > which does not have pandoc nor rst2man installed. I'm using the release
> > tarball from the GitHub release page (https://github.com/linux-rdma/rdma-core/releases/download/v37.1/rdma-core-37.1.tar.gz),
> > though, and was expecting that it would use the prebuilt man pages in this
> > case. However, this fails at some point with the following error:
> > 
> > CMake Error at infiniband-diags/man/cmake_install.cmake:66 (file):
> >   file INSTALL cannot find
> > "/cvmfs/pilot.eessi-hpc.org/2021.06/compat/linux/x86_64/var/tmp/portage/sys-cluster/rdma-core-37.1/work/rdma-core-37.1/buildlib/pandoc-prebuilt/8db9dce39d3eaf2d3992fd9198060d4bdfeb83d6":
> >   No such file or directory.
> > Call Stack (most recent call first):
> >   cmake_install.cmake:222 (include)
> > 
> > FAILED: CMakeFiles/install.util
> > cd /cvmfs/pilot.eessi-hpc.org/2021.06/compat/linux/x86_64/var/tmp/portage/sys-cluster/rdma-core-37.1/work/rdma-core-37.1_build
> > && /cvmfs/pilot.eessi-hpc.org/2021.06/compat/linux/x86_64/usr/bin/cmake -P
> > cmake_install.cmake
> > ninja: build stopped: subcommand failed.
> > 
> > Though the directory does exist and contains a bunch of files, this one is
> > indeed missing. Is this expected (does it only work for certain cases?), or
> > is something missing in this tarball?
> 
> It is definitely a bug. 

The prebuilt docs assume that the standard installation paths are
used, it fails if the paths are abnormal, eg /etc/ and so on.

IIRC we had a no docs cmake option that is intended for the no-pandoc
environments.

Jason
