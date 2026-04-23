Return-Path: <linux-rdma+bounces-19508-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EiT8NfMt6mmVwQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19508-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 16:34:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE09F453C06
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 16:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE8CE30131A9
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 14:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B131033D6FA;
	Thu, 23 Apr 2026 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IgRZtKjP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E3B340273
	for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2026 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954512; cv=none; b=DmqCtZT18KmHysflhrmPIxBPxF7Rb245emhZ0wCdtk7DoqZerDczXXK5YFQeZa7hF903iX5bU6NZvvCuAGp88ApcZ8O7V9jkh21/YEh9AGXoG2SzvlecAHSI7wKuD57Wc6PT83lcpOKzKjsvugTyfH+7kZFm/ECEmewKBiX3KAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954512; c=relaxed/simple;
	bh=Q+CH0cryHB9H3XngNd6AR9iIUT0JpK6a3rt8/T4ped4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVTs0sjXQBSV9MxPaFQEuNxBfR4ObmV4oOpDA+PpQX412u1G9FbUqztzMuYNHFW/xL2NjVXrGnHkZ0UsBqzknxMNJIfo5xwfjGKGBAL7U0M56NjBeTKqTGzZQlDd1rtxR18wQIad2DhOOjDX4OTaUIOuZ/gje/MR4hwjm7+m/lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IgRZtKjP; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8ea8563c693so521680185a.2
        for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2026 07:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776954510; x=1777559310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U8vZETDzbkQ40NDAvMNX2MsWW7x5AHD6ZgWcNohscU8=;
        b=IgRZtKjPwbD7AUMKdw6B5nazR9uBXdJ0EO4L1N/1p3itfssrbvjjqDXItCJbJZSvDM
         fGAYoi+uT+KmXsF/N8/tZfMu2onpq9j6Iq9ycJTiYQLqorQ7WxY1d1mo2NFuZPJun1QL
         Ce5AXmkRXAUwUyQlikMy1ilW1hSk075Tr5ruqtqARmIbdtCW9Td15eMq1DJusFThNLVS
         iSPdo+JIM5Ig1mTA7L7a9lVEYuYOi7cpmH9MKkjM4IaXqHVJcv12atji+r7YIWNN+zSi
         bWN3qLY330G0D5pnwH9j5VjSTTkmYNUvRbAjMwWMtCtbyYcSFByWPd/nWUhttt0j2KWo
         BbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776954510; x=1777559310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8vZETDzbkQ40NDAvMNX2MsWW7x5AHD6ZgWcNohscU8=;
        b=Dm5uYI5Ae2uojOnGAIUPxggVHWC5JV2m+CIw8H2z3lzLQ7XEihT9xY47zQHSmrmJhr
         RSlJwe3AD7cS25QRbbVbhF4RVIXA9D/MvH0LgGIw+p+mgBswJ3BZsJY8CkEodshfNI1/
         9J71atbC5bWVlRBBc5Oah7UZbx9xrGyqqSWAhhirTZ8zN2HN8EPw1TL5xIiH73dmw9lq
         YhmaRcrPEY7pSGfbrJYWqokzZjo2/0XE650xILEnBilt8ZsNNF5D18n1Zfnpb6yNVtgS
         EkDg52tJtuYsTUBlcOEYm6ahZwrwjG5gy8T93ClF9AIOAGs5qNhiwfxZAbvDIVTqO/2X
         vqtg==
X-Forwarded-Encrypted: i=1; AFNElJ9hMi+SRDU3oCHy/kWkG1xHds08uHEpwPeU/iSUbjpxlq5NfMzizewbXptyB5fyh8bFmiw4qUvydLHc@vger.kernel.org
X-Gm-Message-State: AOJu0YxWmC7oP4GXFgC4ba+DLjr9tJLGWM6BvkQggO9ZQ1OMyleBKo49
	a0FMwINCFEutaVVTPqgXq1/iAXDfj+kojn6xzPSfM61d+Vs6j0iWWs7yRbm3LJqccro=
X-Gm-Gg: AeBDievGYhc/FTUimH7OeqsBmLpT/CsQT0KoC8mno8xLPYrDOzhM5EIxZdTRA+bFWw9
	VBaIHYWxS/kKqsHMLdKna8e9SZDzyD+yJzQXSLMV5EVT83iIM0Z6c/pbvblMW06oA4WCGCarPKR
	9lLpfu30Ga+jUsY9xwgD9Cr00Xub2kkS0YS1NLLcucqSFp7Ud8wA/bHNF+JFyi1Pn3wM4poKFgW
	2ECoRDafQy6q2qlVkZqaUT+Qyzb0MgbVP71zBHLG762OGcTT0Hj6mlZh3QyxqmrfOmft8OctXin
	7U6MygZNegnVa+qBb5PLy+NlHrJfNBqluxHhUoyNTiwQv7SVulL7YExEf+9GUtUeqeAuU8Dj7Qg
	dUnG5V+eoZHgZeNku7jY2Q5aklca9K0ybyl57WWeH+Rs+P6IAMBQ4y2aUrdGeaOO6/N6HQ3UHhW
	U3R0vvuxzeIB2wSlFY4A9vGUyL0Hgh6lYgM3oUuiehN9/dyvGIIVAnfUaCeYv46WT/Xj0oheV5D
	kzSnX9leFoAQU+7
X-Received: by 2002:a05:620a:4089:b0:8d5:bb98:f3f3 with SMTP id af79cd13be357-8e78f82cf44mr4032915785a.15.1776954509767;
        Thu, 23 Apr 2026 07:28:29 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8eb3aa60b99sm1331296285a.42.2026.04.23.07.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 07:28:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wFv2a-0000000EFmA-3Fc7;
	Thu, 23 Apr 2026 11:28:28 -0300
Date: Thu, 23 Apr 2026 11:28:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex@shazbot.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Stanislav Fomichev <sdf@meta.com>,
	Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
Message-ID: <20260423142828.GQ3611611@ziepe.ca>
References: <20260420183920.3626389-1-zhipingz@meta.com>
 <20260420183920.3626389-2-zhipingz@meta.com>
 <20260422092327.3f629ad6@shazbot.org>
 <20260422162928.GL3611611@ziepe.ca>
 <20260422132740.5f809bf7@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422132740.5f809bf7@shazbot.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-19508-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c15:e001:75::12fc:5321:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Queue-Id: DE09F453C06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 01:27:40PM -0600, Alex Williamson wrote:
> I don't know how to qualify the statement in the last paragraph about
> "[t]he only requirement is that the device limit the TPH to only the
> function that is perceiving them", though.  Is that implicit in being
> associated to the dma-buf for the user owned device, or is it a
> property of the suggested steering tags, that we're not validating?

It is a property of VFs and VFIO.

For instance if an insane device allows a steering tag to reach
outside the VF's memory space then it can't really be used with VFIO.

> Steering tags can induce caching abuse, as interpreted in the
> interconnect fabric, but maybe we've already conceded that as
> fundamental aspect of TPH in general.

steering tags are opaque, we don't know what a device will do when it
receives them.

The common CPU issue is indeed cache abuse, but who knows what a
device will do with them.

> So why does vfio need to be involved in any of the sequence proposed
> here?  It seems like it would be a much cleaner design, avoiding
> overloading the existing vfio feature and questionable array semantics,
> if there were a set-tph ioctl on the resulting dma-buf instead of
> making some vfio specific interface bundling creation with tph
> hints.

Realistically only VFIO dmabufs will have this property that user
space can set any TPH.

Other in-kernel drivers should accept some kind of hint from userspace
when creating their dmabuf that makes sense for their device, not a
raw TPH value. Like a GPU might accept a hint that specifies which
dielet or something like that.

So I don't see a generality here from that perspective. The generality
is that exporting drivers that can use TPH now have the option to tell
the importing driver to send them.

Jason

