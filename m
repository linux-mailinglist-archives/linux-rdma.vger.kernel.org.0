Return-Path: <linux-rdma+bounces-1003-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80201851732
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Feb 2024 15:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B875283A45
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Feb 2024 14:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689CA3B293;
	Mon, 12 Feb 2024 14:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FsWKi9oc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831583B290
	for <linux-rdma@vger.kernel.org>; Mon, 12 Feb 2024 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707748817; cv=none; b=uTTT10VoGXSUxWnPZr5cxPhFy7XuMF7nUqJ7t7tGT2KPTETaopcz7ifBGwyF7tHhqIHjwuqXBFTFqQWkmwLgm54+JA0iYzq5NUifd2TAkiOsk4Uxsuev5Am5d/XhA7REzMMeerFaqc/UcbIjQ/v1iAsGqKE/Tm0+1/juibgc35I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707748817; c=relaxed/simple;
	bh=IUjgP5m3Vd0GxuIYtyq+YbCeGvPTpINoSjcfE87Z5Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIW3wmgyRmRNHb7l7l7NpfxrLmfik7dSekpFSg+KQualqCX9rP77hTR/hQ0vzTn3UqcWtr7Rml4PboeB0GTMobu9GeRKB6WZ4MfC6QM1JV91R/5Pr6pZINoUiw51oLH1csFwberivBJAzu8/vz2M9xMJ6+zTFvrGJbasAsYR/hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FsWKi9oc; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bfe59bd1abso1653134b6e.1
        for <linux-rdma@vger.kernel.org>; Mon, 12 Feb 2024 06:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707748814; x=1708353614; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XuchYImAovIwnbArQHI1AJKwQgdYfPou/C5ew7UP6iI=;
        b=FsWKi9ocvdH6DB9iKn2TjI+OtDnxWBfRHMTi2yZMigBYkt9S18PWhy72ApHbpRzMfc
         m0nR4Iw7vx1n1AjM5vjzkADkXIupZ5GkevybX0+Geb7c2GQvcBbZ6kpKO+K7R65xjtHf
         Dz1fqdVsyWteEpdEWSUdoZhAJCiRkyASBF80ZX/g/XSygOzihqCznuH7DIDU56CTOwUG
         Ps3gLWnT+AOHT9LkfVgb0TkAMz1bCcHBtok3MYiHCy8LEd5C7w4Dw8/t+dpzhVT0uO4v
         1D/K8zqR77qPwIKwqRD2+lIHp/lYK78R2w+K7m2lM9O3ZHvZdC3Pu6vJ+HLzwH/LOPzo
         mDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707748814; x=1708353614;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XuchYImAovIwnbArQHI1AJKwQgdYfPou/C5ew7UP6iI=;
        b=DIod1lxIyu1hM8dFETFTHh38uEsJ44Zlx5Wx2Jo49KXMUg90VkRMBsHEXJqyFfxW0s
         AxhjDhbgIZDMGvGVPs5eQkJkEDjxdHkFdYaYTuZsbU83Ly8+c4o2fryQQdMLfN2n8TRE
         9ohW9gJwANFjGsllzarbGfXgSWbliuVrNuSI4l3rCDD64pBl4FpovzDUm/4ngWH53vc/
         8jdJK0zTTTWW4bBgubGBG1PYRvWSr1LXKE+Yz4pG9gZmDYmOCGMz/9gF7WkpQqRoCBx4
         PgRfNt6iHMAyxUFqyESGwT4+f5RMsD5ceuRU2hIzji90OjsFDRUJVKfcXcqZ88lOrUnN
         ukqw==
X-Forwarded-Encrypted: i=1; AJvYcCVmB23x1GWYNadlw7ig45qKpRvhjbnMJgi31/Cp1ppaXZf7407jXpvc250NosIK0ZsJZrvRPUC4s7sw+n7k360qR30K+TYKPNphYw==
X-Gm-Message-State: AOJu0YzlkWCtc1IKec7J3bGQq+csPbZhFSIWddNZtGCz3dNZKq6VZs3H
	FRXBA+iTAGAqJyrf6guTwNJ5XigNJuZLbWZ2DemLAyavUxdmPOwyH5Y6XrInMYjZhZMgrAIGX9U
	B
X-Google-Smtp-Source: AGHT+IESFShQuXolTOubLToAlqs46wxv4heD6nq7X0O27Sam4y0oCqnib7Q7ONToGe2g0L+/zR1VDA==
X-Received: by 2002:a05:6870:e40a:b0:214:d965:f5a0 with SMTP id n10-20020a056870e40a00b00214d965f5a0mr9203551oag.29.1707748814610;
        Mon, 12 Feb 2024 06:40:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFHHqtJMvp5TJbP90T/bBe8a2RaiVP+qjV2NpEnK+w/Wh9WxqkHyDDLl0ElunT0jHfcnNSzUiUtLFhI313lMfgAVWkf/JJ281xYZQlFWng//2NrCUQDV2r8dJtE3uhQZVTuAhS+AgcjXz/eDf2mHUwcmT5OHcJ1r39d5S/R1/NTNJNHlfkQLOzKW96JxVIMjnEIe8dWS602LCIUK8X
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id gi5-20020a0568703b8500b0021a542a3b66sm767809oab.53.2024.02.12.06.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 06:40:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rZXTh-00H8y2-Cu;
	Mon, 12 Feb 2024 10:40:13 -0400
Date: Mon, 12 Feb 2024 10:40:13 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kevan Rehm <kevanrehm@gmail.com>
Cc: Mark Zhang <markzhang@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>, kevan.rehm@hpe.com,
	chien.tin.tung@intel.com
Subject: Re: Segfault in mlx5 driver on infiniband after application fork
Message-ID: <20240212144013.GD765010@ziepe.ca>
References: <3CAF66C4-32E1-4258-9656-D886843D7771@gmail.com>
 <20240212133303.GA765010@ziepe.ca>
 <8BB93F6F-14EC-4B43-B1F0-5FE185A64073@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8BB93F6F-14EC-4B43-B1F0-5FE185A64073@gmail.com>

On Mon, Feb 12, 2024 at 09:37:25AM -0500, Kevan Rehm wrote:

> > This was all fixed in the kernel, upgrade your kernel and forking
> > works much more reliably, but I'm not sure this case will work.
> 
> I agree, that won’t help here.
> 
> > It is a libfabric problem if it is expecting memory to be registers
> > for RDMA and be used by both processes in a fork. That cannot work.
> > 
> > Don't do that, or make the memory MAP_SHARED so that the fork children
> > can access it.
> 
> Libfabric agrees, it wants to use separate registered memory in the
> child, but there doesn’t seem to be a way to do this.

How can that be true? libfabric is the only entity that causes memory
to be registered :)

> > The bugs seem a bit confused, there is no issue with ibv_device
> > sharing. Only with actually sharing underlying registered memory. Ie
> > sharing a SRQ memory pool between the child and parent.
> 
> Libfabric calls rdma_get_devices(), then walks the list looking for
> the entry for the correct domain (mlx5_1).  It saves a pointer to
> the matching dev_list entry which is an ibv_context structure.
> Wrapped on that ibv_context is the mlx5 context which contains the
> registered pages that had dontfork set when the parent established
  ^^^^^^^^^^^^^^^^

It does not. context don't have pages, your problem comes from
something else.

Jason

