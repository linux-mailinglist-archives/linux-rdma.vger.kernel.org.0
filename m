Return-Path: <linux-rdma+bounces-5033-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 303A397DC41
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Sep 2024 10:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F7A2827FD
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Sep 2024 08:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BB915099B;
	Sat, 21 Sep 2024 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ihmT+Zei"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5967462;
	Sat, 21 Sep 2024 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726909135; cv=none; b=VLV6wK745JY8mnOKQd+THJMU2M6jAOlFumRymh31g1rkFQVeiJAhqbTJXAZ+iTl4cNlUVhdef3w4CWSQgCNEVfS32bMk1zZdajbCjmxHK1m+Aum9fkGhac48/LKcoVuu7vmxHN8kXaLAB9zmzN91Y9r6PdT/E74lLuaAgKJ6S4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726909135; c=relaxed/simple;
	bh=Gcm6g6v0heAHEjRyrF+WBTEcEL/E3qKlUK/ucazeCwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIk57iw2WIKCBxJ5bBHbgP3NOx/0js/dfkoyvPmj20vZTkiRTBYVgv7aH78NKWMH2lslM6Ffc4Zic0hRwGsvpEHVJ/uDlwgLJhxRMDgcZpL8kCWNeOQpkWXPnj+Z7PJ7xDmph8fz7ptlu7XVwmasQYRi3wAxIvYHs2l8brbpCHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ihmT+Zei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE371C4CEC2;
	Sat, 21 Sep 2024 08:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726909135;
	bh=Gcm6g6v0heAHEjRyrF+WBTEcEL/E3qKlUK/ucazeCwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ihmT+Zei5EQc+BZdtFI9oNt7QTzc3cHLMm0Zm6dlin3UTmJdbyR+B0E4M+Y93xz4D
	 tYIqFTbqbCg1hunbhbpQLLE/d3+y7HvTt/N2l7+lAZVKvCsTMLWcHrxG5QEINmD9lG
	 epM/0nLn6ZW8XpwcuvH4ULt8XiriuyrosjU/qPi8=
Date: Sat, 21 Sep 2024 10:58:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Yan, Haixiao (CN)" <haixiao.yan.cn@windriver.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, liangwenpeng@huawei.com,
	liweihang@huawei.com, dledford@redhat.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: Fix UAF for cq async event
Message-ID: <2024092146-issue-mandarin-952c@gregkh>
References: <20240920124540.2392571-1-haixiao.yan.cn@windriver.com>
 <Zu1xS4dX77jikYw9@ziepe.ca>
 <e195d0ec-92a8-4ea4-a939-31f6d5b7ef7b@windriver.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e195d0ec-92a8-4ea4-a939-31f6d5b7ef7b@windriver.com>

On Fri, Sep 20, 2024 at 09:02:58PM +0800, Yan, Haixiao (CN) wrote:
> Add Greg in the loop. Thanks.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

