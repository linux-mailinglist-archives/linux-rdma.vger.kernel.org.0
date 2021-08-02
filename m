Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1763DD261
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 10:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhHBIzV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 04:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232711AbhHBIzV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Aug 2021 04:55:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BD7260F36;
        Mon,  2 Aug 2021 08:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627894512;
        bh=n8DwHd29igzBVu5Vls1Dt9OiWgHP0IJVjLuxMI48Ye0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LIAc035KkbyWM77j6T4Lvgs9xzFFNXnnQfJsvcNhyFO37q9mJ2/hgbk4lnNssFDyL
         LQAwpxvjXVcOLOeNBmmaYZGHtx3E2glpTftYJudWCrlKpnd5HMY94SezT5IyUvR6w5
         PDTXQGhkVsyVL1TgAX2/WLYeQ5s0iM8gm1jfoukHppC2oEcuYH9Q9fOYv9nw5nT8lJ
         db+p8h8hdD49BWSzdUvPoYQJ5pFa8PdJGsIayMddC9w6KiKawLa0oVEP9fG/M4Xsjh
         VVg3XLbr8dsEaXTlWe3pRV34f0Uzs6DwOFpJ2bu+QLOnbyGoDMsPIjNJMBdTr6lz3p
         LuYqHh9L9H5fw==
Date:   Mon, 2 Aug 2021 11:55:08 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Launchpad Buildd System <noreply@launchpad.net>
Cc:     Linux RDMA <linux-rdma@vger.kernel.org>
Subject: Re: [Build #21827825] i386 build of rdma-core
 37.0~202108010758+git3592de91~ubuntu18.04.1 in ubuntu bionic RELEASE
 [~linux-rdma/ubuntu/rdma-core-daily]
Message-ID: <YQey7OvLuFdYhM/G@unreal>
References: <162782313574.23023.16177627475675830238.launchpad@alphecca.canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162782313574.23023.16177627475675830238.launchpad@alphecca.canonical.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 01, 2021 at 01:05:35PM -0000, Launchpad Buildd System wrote:
> 
>  * Source Package: rdma-core
>  * Version: 37.0~202108010758+git3592de91~ubuntu18.04.1
>  * Architecture: i386
>  * Archive: ~linux-rdma/ubuntu/rdma-core-daily
>  * Component: main
>  * State: Failed to build
>  * Duration: 2 minutes
>  * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/21827825/+files/buildlog_ubuntu-bionic-i386.rdma-core_37.0~202108010758+git3592de91~ubuntu18.04.1_BUILDING.txt.gz

Interesting, this build found python
-- Found PythonLibs: /usr/lib/i386-linux-gnu/libpython3.6m.so (found suitable exact version "3.6.9")
but our AZP didn't
-- Missing Optional Items:
--  Compiler attribute symver NOT supported, can not use LTO
--  cython NOT found (disabling pyverbs)
--  extended C warnings NOT supported
-- Configuring done
-- Generating done
https://dev.azure.com/ucfconsort/rdma-core/_build/results?buildId=22267&view=logs&j=143eea66-4597-539b-c2e7-6e457837a569&t=8f1c60c7-a972-5972-c048-1b94a90e9ebc

Thanks

>  * Builder: https://launchpad.net/builders/lgw01-amd64-020
>  * Source: not available
> 
> 
> 
> If you want further information about this situation, feel free to
> contact us by asking a question on Launchpad
> (https://answers.launchpad.net/launchpad/+addquestion).
> 
> -- 
> i386 build of rdma-core 37.0~202108010758+git3592de91~ubuntu18.04.1 in ubuntu bionic RELEASE
> https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/21827825
> 
> You are receiving this email because you created this version of this
> package.
> 
