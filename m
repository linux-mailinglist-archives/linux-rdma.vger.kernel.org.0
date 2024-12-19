Return-Path: <linux-rdma+bounces-6648-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD05C9F7A71
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 12:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B6116946D
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 11:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7D222333F;
	Thu, 19 Dec 2024 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2uPJh/8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE7C18CBFC
	for <linux-rdma@vger.kernel.org>; Thu, 19 Dec 2024 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734608057; cv=none; b=TpgXzAVWfOcdgzOaBAPi5yqO6Rii1askgGDghfkgjXXufm6yfcYMJ/as8vjzUhG8clff9aHaFgEW69znZ8aVmV6B1MvF0wWtVh8ArQRk9w4ZPmH+tnisP4odoJHLMIuTAQNPeXdEaMYqZ1OinUT/ZteyX1/ZWDoFKyNyq+PnJE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734608057; c=relaxed/simple;
	bh=nhnqOmoEL2Um3tJfZNR5EClJCeFNoo1sdGnnh9Q5JRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hu9bGdMAo+mTOUh9MpUVUfVKjeNBe6a5XtomActGzuvOI5qhT5taMxLkHcv/4PFivOCsmLdej+AbQBNXfO93TOHbbMSJJV9z93kqstuc1yanqCbbPRySvsJqOnpNEN5gpy1bUxhbp3lxLlVNolBd2U0jZ/ZS0/I6rOdr4NsGSD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2uPJh/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBCCC4CECE;
	Thu, 19 Dec 2024 11:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734608057;
	bh=nhnqOmoEL2Um3tJfZNR5EClJCeFNoo1sdGnnh9Q5JRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f2uPJh/8M5m3/E60omqWedXzn3489uKcS/MAbMBOSrp5ESQmGUX+0c9RiYFRk06Qk
	 oDnjh8409n45hwIHtmQivQ4Bc6W7eyr3tkOfWWFz80e94CTBwxGKYCRLe/bOS5Ur2E
	 gl9hlZHHHjTAUfxbXyVpVY5dV1XK/m9pCjMBPWRiNnBE7p+whvpjanzpjqsh5lS4cn
	 b57dfutuyzyvkxG1je12/psozkD7FXzQ/ym8Rzp/E37EWBo/i71UG0i5N7+G2cT3Vn
	 82uTeqGkjKQ28z9/Q3+WmcImRPMNn4mM9PXJFp0nth7QX/P9zfzKlakMKcMJmkpFBl
	 xJvVFUh2QT/UQ==
Date: Thu, 19 Dec 2024 13:34:12 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "xiyan@cestc.cn" <xiyan@cestc.cn>
Cc: linux-rdma <linux-rdma@vger.kernel.org>,
	markzhang <markzhang@nvidia.com>, phaddad <phaddad@nvidia.com>,
	"yuan.liu" <yuan.liu@cestc.cn>, zhangsiyao <zhangsiyao@cestc.cn>,
	peizhiwei <peizhiwei@cestc.cn>
Subject: Re: [BUG] rdma_cm: unable to handle kernel NULL pointer dereference
 in process_one_work when disconnect
Message-ID: <20241219113412.GB82731@unreal>
References: <2024121711374552593113@cestc.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024121711374552593113@cestc.cn>

On Tue, Dec 17, 2024 at 11:37:46AM +0800, xiyan@cestc.cn wrote:
> Hello RDMA Community,
> While testing the RoCEv2 feature of the Lustre file system, we encountered a crash issue related to ARP updates. Preliminary analysis suggests that this issue may be kernel-related, and it is also observed in the nvmeof environment，We are eager to receive your assistance. Below are the detailed information regarding the issue  LU-18364. 
> Thanks.

Please contact Nvidia support. Lustre and MOFED are not related to upstream mailing list.

Thanks

