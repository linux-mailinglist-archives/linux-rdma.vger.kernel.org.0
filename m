Return-Path: <linux-rdma+bounces-7029-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 275B3A12BA1
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2025 20:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EFF01889C1C
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2025 19:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B0D1D7999;
	Wed, 15 Jan 2025 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="sr2kmj1i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F801DAC95;
	Wed, 15 Jan 2025 19:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736968498; cv=none; b=a9eXoLMRtnYyg/n3xBUhTtDwjlfO5G567J5dUBY/qgOkxJw7UFXwMRRPX3W3b18up3UNafWFIi/kERmGC/RJfTaL2bC7bTlFb7XvK/TlBGBkKFdqOdVqzVk4U0pKpkkLjww3wpNele2fd06cosGKDPuj3gqfaHVMNohEcqVQlFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736968498; c=relaxed/simple;
	bh=JnRRcCvLqDTtLSrSXeRwcGm6QBs2OfCHEiukNGtG8r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7JF+WrwUAD49Cv7KwUSjkwshQMl26OfCUPMot9RFwBL9QUimy+M7awfD6WRM5Q8YNahMCZf7lT7dZLOt54+QVPF8425Ein2BXv1sSQ8VwQuriZMi85mHFdBJ2Dqxplm/StRsp4x2NLjmUOesHF0YPj8iowP1HsKxBPihyRlQCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=sr2kmj1i; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id AA51E40777CD;
	Wed, 15 Jan 2025 19:14:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru AA51E40777CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1736968492;
	bh=2jn0CmhNt5fLhqajQhvLm7NkEQK5KB8QwbZexcJBjLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sr2kmj1iInwgrPAfHoGm9BQrcFTfiqlJqE+Sm9wTsm/4dSQPSn1Q4UoazVbzSZaFV
	 c5B2yq4/IsM3r1asdckbABefJtBe7tB5IW8M+PcYi9JevrKqDKpp4oeGoDyRlMxNwa
	 obYKsQP3TzX4/9j2WmSObuk9kaJYFmjRgNuM2k7o=
Date: Wed, 15 Jan 2025 22:14:52 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Vitaliy Shevtsov <v.shevtsov@maxima.ru>, lvc-project@linuxtesting.org, 
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
Subject: Re: [lvc-project] [PATCH] IB/hfi1: fix buffer underflow in fault
 injection code
Message-ID: <gwdzoxk5gq5ve5jqklt4mkuoo25nhpjagjwbjuqvcrwhccauet@2frrkt22grg7>
References: <20241227230940.20894-1-v.shevtsov@maxima.ru>
 <4e7675a0-0dc0-4da3-b8ae-2462a5b112d1@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e7675a0-0dc0-4da3-b8ae-2462a5b112d1@cornelisnetworks.com>

On Wed, 15. Jan 12:55, Dennis Dalessandro wrote:
> On 12/27/24 6:09 PM, Vitaliy Shevtsov wrote:
> > [Why]
> > The fault injection code may have a buffer underflow, which may cause
> > memory corruption by writing a newline character before the base address of
> > the array. This can happen if the fault->opcodes bitmap is empty.
> > 
> > Since a file in debugfs is created with an empty bitmap, it is possible to
> > read the file before any set bits are written to it.
> > 
> > [How]
> > Fix this by checking that the size variable is greater than zero, otherwise
> > return zero as the number of bytes read.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with Svace.
> > 
> > Fixes: a74d5307caba ("IB/hfi1: Rework fault injection machinery")
> > Signed-off-by: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
> > ---
> >  drivers/infiniband/hw/hfi1/fault.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/hw/hfi1/fault.c b/drivers/infiniband/hw/hfi1/fault.c
> > index ec9ee59fcf0c..2d87f9c8b89d 100644
> > --- a/drivers/infiniband/hw/hfi1/fault.c
> > +++ b/drivers/infiniband/hw/hfi1/fault.c
> > @@ -190,7 +190,8 @@ static ssize_t fault_opcodes_read(struct file *file, char __user *buf,
> >  		bit = find_next_bit(fault->opcodes, bitsize, zero);
> >  	}
> >  	debugfs_file_put(file->f_path.dentry);
> > -	data[size - 1] = '\n';
> > +	if (size)
> > +		data[size - 1] = '\n';
> >  	data[size] = '\0';
> >  	ret = simple_read_from_buffer(buf, len, pos, data, size);
> >  free_data:
> 
> I don't think size can ever be 0. No reason to change this I don't think.
> 
> -Denny
> 

Seems the patch description rather clearly shows the size can be zero in
case the corresponding opcodes bitmap is empty. Which is the case when
user reads the file before writing anything to it.

