Return-Path: <linux-rdma+bounces-630-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFC982D525
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jan 2024 09:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26ED31F218CD
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jan 2024 08:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D24C1FAB;
	Mon, 15 Jan 2024 08:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udXaLqb2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0696A2563
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jan 2024 08:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D65C433C7;
	Mon, 15 Jan 2024 08:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705307820;
	bh=/Owv6F1avVHuLCJkAOa8NO9i8akMJCF51vslU770NNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=udXaLqb2b3wB0cFUzngM+yloQ6Gwmhmc7oQrzlmYJaw18UK37Srv63Cp2/YInfhVF
	 zMKYKM7rbobKjuqGGa8g0tTp38KN1GIYShEidt4u/RAm0IFqSygPbX9HDTAKUHlEMu
	 IelSK3Eo0ceiruXLx4DvUFNeKNLUyomOs9hi+mpnj0zRxMbFtLthvB9pfCyuiCow/u
	 zdMI1dViezQqHz23j4noVQw0dLX9Y9ZRZumwgPvviX50d7o69SP5CSydbzEJL+hH0u
	 5zuBDXhWgPD/XPCZv14R0wB7EUo1JOOdwbtmUkc+egWif7tN7NmhESEswDna9rJB/V
	 2UTwxOSKX/V9A==
Date: Mon, 15 Jan 2024 10:36:55 +0200
From: Leon Romanovsky <leon@kernel.org>
To: bugzilla-daemon@kernel.org, Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
Subject: Re: [Bug 218375] New: warning compiling siw_tx_hdt:  the frame size
 of 1040 bytes is larger than 1024 bytes
Message-ID: <20240115083655.GA8117@unreal>
References: <bug-218375-11804@https.bugzilla.kernel.org/>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-218375-11804@https.bugzilla.kernel.org/>

+ Bernard

On Sun, Jan 14, 2024 at 04:10:23PM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=218375
> 
>             Bug ID: 218375
>            Summary: warning compiling siw_tx_hdt:  the frame size of 1040
>                     bytes is larger than 1024 bytes
>            Product: Drivers
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: Infiniband/RDMA
>           Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
>           Reporter: ionut_n2001@yahoo.com
>         Regression: No
> 
> Hi Kernel Team,
> 
> I notice today this:
> drivers/infiniband/sw/siw/siw_qp_tx.c: In function 'siw_tx_hdt': 
> drivers/infiniband/sw/siw/siw_qp_tx.c:677:1: warning: the frame size of 1040
> bytes is larger than 1024 bytes [-Wframe-larger-than=] 
>  677 | } 
>      | 
> 
> I use latest kernel 6.7 and this is happened when compiling kernel with GCC -
> gcc (Debian 13.2.0-9) 13.2.0.
> 
> -- 
> You may reply to this email to add a comment.
> 
> You are receiving this mail because:
> You are watching the assignee of the bug.

