Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24AD6113CDE
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2019 09:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfLEIMf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Dec 2019 03:12:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:47818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfLEIMf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Dec 2019 03:12:35 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 459992464E;
        Thu,  5 Dec 2019 08:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575533554;
        bh=JEIH2kGlRU+tSCHKOQOqnLlf3chbV8kEzD72lsHpTPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iFznFbd+7TMJLxod6lWEiKY28IXyy6siqHarb7+ZiEovQg8PrHSuwfivK34eAsoRm
         flrGXMsiZR4IcxGDeGNRC9e/0a/M4nAQ+GjVt4cI9ddtf6JTcNc2Gs9ULstR2dRZQm
         ZHyuuqzE3MN2zS2BPCjKs2IbreFPy7A1oiRgOGaM=
Date:   Thu, 5 Dec 2019 10:12:27 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Thorben =?iso-8859-1?Q?R=F6mer?= <thorben.roemer@secunet.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: install-step fails for pandoc-prebuilt man-pages in
 infiniband-diags/man
Message-ID: <20191205081227.GB4939@unreal>
References: <5d754108-7020-6041-1b7d-bbb3fb2f089b@secunet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d754108-7020-6041-1b7d-bbb3fb2f089b@secunet.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 04, 2019 at 03:34:14PM +0100, Thorben Römer wrote:
> I tested the following on release 0.26.0 and 0.26.1, with the *.tar.gz
> provided on github. It is probably relevant for a lot more released
> archives and future releases. My build environment is restricted and
> does not have access to pandoc or rst2man.
>
> The command 'ninja install' fails in environments without pandoc and/or
> rst2man. There is an automatic fallback to use man-pages in
> buildlib/pandoc-prebuilt that are added for every release-archive.
> However, the install step fails with error such as:
>
> CMake Error at infiniband-diags/man/cmake_install.cmake:40 (file):
> file INSTALL cannot find
> "rdma-core-26.0/buildlib/pandoc-prebuilt/64a3de4dd91635b29f4f8d11a987670751827c60".
> Call Stack (most recent call first):
> cmake_install.cmake:166 (include)

We don't support any make/ninja install flows and you posted one of the possible failures.

There are three recommended ways to build and install rdma-core:
1. For run in-place (without install) - use build.sh - recommended way.
2. For properly created RPM/DEB packages for other OSes - use buildlib/cbuild script.
3. For RPMs created for this OS - use "rpmbuild --build-in-place -bb redhat/rdma-core.spec"

Fro step 2 and 3, installation is done with those RPMs/DEBs.

Thanks
