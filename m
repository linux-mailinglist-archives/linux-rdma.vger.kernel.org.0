Return-Path: <linux-rdma+bounces-7087-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB4FA161A6
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 13:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3B81885939
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 12:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA7419D07A;
	Sun, 19 Jan 2025 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0nv0fbb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A991157A5C
	for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737290063; cv=none; b=JuuWqYpgShqU4AhZaBW2iRuMSRgwcsp4ZLRcfGTWpQDISiQPEl57fcYhPc8n/zc5h0ABsQkhNVVBuYNG8Q1TKAXKkaeSdV5rx1gp9CEKGKEFRS/iA/dxdqtIJ+mLOQT2KctejXi70/4GEDc0oO6dlW3J2sQIpcYduXFdtPY2nk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737290063; c=relaxed/simple;
	bh=GAQPcZcn7fad88vpRjjcUAMCEolobo8ItCGFDACXnLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URxjtUaHvQ9m+kzmN0xnQF/LrlbSpD8qnHMxvNu3GrmvzScjXOY5bnXLV9ZJ70qe1JRKExYwxBwEiypvVUFBf1wlBvAJ2JBvOm2W8pp0MLg/zkcNdLNKhMyCoUaLTLq53DWvtXKNtefRn+GQh4bI8lOSlDyOMvbmHA1/jPibTDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0nv0fbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48385C4CED6;
	Sun, 19 Jan 2025 12:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737290062;
	bh=GAQPcZcn7fad88vpRjjcUAMCEolobo8ItCGFDACXnLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K0nv0fbbYtXTHHYBSD5Rqqjx33gySW7D5KRKx4kLetBC+9QVpjD0lIp1wcT2qWLwi
	 M6zPXq04gOEW5FNTP523cIkDkKJndxTyPCXO5BH55WDiAo8yq6dBZfUlg0BiPHj4AH
	 6+OJaPLJWNgAfw+HsxoEFcI9mVCe/efhEjvlBjjTFoWzFdbUQ7UwA0/81Zt/s+Q9rE
	 NZTfxjulJm7yRzNGuDS6ZBHACx8uqlxI/Ukf7lwoLIJsYBaCJfYxxw3MLvOLR2MI+5
	 muV/Bx93fX3pU+5GIXgmmRRPqIxIfl74OwjPQ/UD31EZiwKPI6i6OTpE8jifc+M5hb
	 cN7/4fQH7fsnA==
Date: Sun, 19 Jan 2025 14:34:17 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH for-next] RDMA/bnxt_re: Congestion control settings using
 debugfs hook
Message-ID: <20250119123417.GE21007@unreal>
References: <1737174544-2059-1-git-send-email-selvin.xavier@broadcom.com>
 <20250119095750.GC21007@unreal>
 <CA+sbYW3fsjMxqMPyq7HGLMuhb2TEkG8Jo3PmgOyMR7ba5TF3DQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+sbYW3fsjMxqMPyq7HGLMuhb2TEkG8Jo3PmgOyMR7ba5TF3DQ@mail.gmail.com>

On Sun, Jan 19, 2025 at 04:01:55PM +0530, Selvin Xavier wrote:
> On Sun, Jan 19, 2025 at 3:27 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Fri, Jan 17, 2025 at 08:29:04PM -0800, Selvin Xavier wrote:
> > > Implements routines to set and get different settings  of
> > > the congestion control. This will enable the users to modify
> > > the settings according to their network.
> > >
> > > Currently supporting only GEN 0 version of the parameters.
> > > Reading these files queries the firmware and report the values
> > > currently programmed. Writing to the files sends commands that
> > > update the congestion control settings.
> > >
> > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > ---
> > >  drivers/infiniband/hw/bnxt_re/bnxt_re.h |   2 +
> > >  drivers/infiniband/hw/bnxt_re/debugfs.c | 215 +++++++++++++++++++++++++++++++-
> > >  drivers/infiniband/hw/bnxt_re/debugfs.h |  15 +++
> > >  3 files changed, 231 insertions(+), 1 deletion(-)
> >
> > <...>
> >
> > > +static const char * const bnxt_re_cc_gen0_name[] = {
> > > +     "enable_cc",
> > > +     "g",
> >
> > ????
> It is the "running avg. weight" used by Congestion control algo in HW.
> It is referred as "g" in the parameters and the FW command. So used
> the same name for the debugfs file.

At the end, it is your debugfs for your customers. IMHO, it doesn't look
nice to them.

Thanks

