Return-Path: <linux-rdma+bounces-11245-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1238CAD6A9F
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 10:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076C8189FEA4
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 08:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125A621421D;
	Thu, 12 Jun 2025 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfTUP6Qo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53D415573F
	for <linux-rdma@vger.kernel.org>; Thu, 12 Jun 2025 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749716832; cv=none; b=FrzwZ0hrdRCFJlmNQYniPIWHcK2NQqszWF96ENgDMKXNrXrN1rWYNVcwinym9+oqp/wFoRZrUpvdiCZUuUHR7sshHgpJBuXqxpZiV6WhUITrySI4SZ3UGUibLObqh9e5ObQpiecvBJSSmJuh0U8HYfgjnkj4RFjC5LAE+6M41I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749716832; c=relaxed/simple;
	bh=A3MnggeP5t3f6ggXnjwD46CyL8lqq+3mtfIpjYggTjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U343fMHDRsRGcyVkhR3/TeSAcIq5Kl+fOeUxyUCavcNKhpMA+U5Tq5DrDIOL3p2hVtmGLggvxe9ufbSEZRKfPoKEsy8gZIORIL2+cgMEUjooy7SiO8FQr9uivRbV8puHc9xLEl109EYavS5cLtHzWRYHUHs29dI+LVdKUxEd2+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfTUP6Qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AEFC4CEEA;
	Thu, 12 Jun 2025 08:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749716832;
	bh=A3MnggeP5t3f6ggXnjwD46CyL8lqq+3mtfIpjYggTjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CfTUP6Qo2xehghK9EIws1xPJJv1f+yk9CukqvvozTZkoy4g5kkycdFDORKVGgMx93
	 jVWEaygmoOzQWWiDhKGDC3Ssl6t7I/zi8M996+S0FBTIm4eiQOjcwo2gEuHM35EbsP
	 gGgoUcknwRwJkFw0258BmlCndArr54hP2+lDzY0UBBmzsLPdDv7aQ9dsFVr8j9Xfer
	 QDbVgrHD2hLqsVXfF9RrSJTZTHI27tIk1H3JYnSNmlap78lzXUECYBap49NC8eXNBw
	 u8kg4hLLnCHZJaBKHPI/kiYRAUjLtNfy7Hl7PiWlqTcPd8Q/c5ZgAXWQSWDlX6FIjX
	 ufT3VZ63I8x4Q==
Date: Thu, 12 Jun 2025 11:27:07 +0300
From: Leon Romanovsky <leon@kernel.org>
To: zhenwei pi <zhenwei.pi@linux.dev>
Cc: linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com, jgg@ziepe.ca
Subject: Re: Github RXE CI support
Message-ID: <20250612082707.GR10669@unreal>
References: <f1cdcb41eb6939ccd12905391f473e74337c0391@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1cdcb41eb6939ccd12905391f473e74337c0391@linux.dev>

On Sun, Jun 08, 2025 at 10:28:04AM +0000, zhenwei pi wrote:
> Hi,
> 
> On July 2024, I attempted to contribute the new feature of Valkey Over RDMA to the Valkey community, which allows Valkey to communicate using RDMA and achieved significant performance improvements and latency reductions. Valkey is a popular KV database with a large number of users, so relevant CI testing is necessary. However, the virtual machine used by GitHub does not support RXE (compilation option is not turned on), so we need to compile an out of tree RXE driver in a timely manner and install it into CI's virtual machine, and then run the automated testing program. At that time, in order to support this feature as soon as possible, I copied the RXE code from Linux based on the kernel version of GitHub virtual machine and successfully ran it. Later, with the upgrade of the GitHub virtual machine kernel version, it was also upgraded once.
> 
> Link of my RXE: https://github.com/pizhenwei/rxe.git
> Github CI steps example(Valkey: https://github.com/valkey-io/valkey.git, CI config: .github/workflows/ci.yml):
>     steps:
>       - name: clone-rxe-kmod
>         run: |
>           mkdir -p tests/rdma/rxe
>           git clone https://github.com/pizhenwei/rxe.git tests/rdma/rxe
>           make -C tests/rdma/rxe
>       - name: clear-kernel-log
>         run: sudo dmesg -c > /dev/null
>       - name: test
>         run: sudo ./runtest-rdma --install-rxe
> 
> Because Github CI virtual machine does not allow to run 'insmod -f tests/rdma/rxe/rdma_rxe.ko' directly, it's installed by 'sudo ./runtest-rdma --install-rxe'. 
> 
> With the increasing popularity of RDMA, more and more services may require automated testing based on RXE. I hope to have community support for the corresponding official version, rather than using multiple personally supported versions(like my RXE).

There is no such thing like "official supported version" for in-tree kernel modules.
Use latest from rdma-rc branch.

Thanks

> 
> Looking forward to the response from the RXE community!
> 

