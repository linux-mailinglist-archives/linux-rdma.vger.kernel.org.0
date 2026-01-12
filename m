Return-Path: <linux-rdma+bounces-15468-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1A4D13BE1
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 16:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F69830E492B
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 15:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B943612F2;
	Mon, 12 Jan 2026 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Mz8wsO/1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796D83612EA
	for <linux-rdma@vger.kernel.org>; Mon, 12 Jan 2026 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232107; cv=none; b=PrKFGRvrBVnU1AWmebsp7A3N+cL7Glje3WOEZ64+lpkDoBVL/rl1O/j4nsDXsnR1kx7UGaOpQobFIDWOnOZqOa0IxWUsayX2vpX3u7kojcHBxKR5QuphjGo4T23i0+5050Fp3gMoaoEd4UqqXRcQI/U94knhnF4PHydfAtMPpGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232107; c=relaxed/simple;
	bh=2+ptEh+o740cfHiY7Soe2/6xEyrL9rhhMehdOO2NfTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4hHm3p0/n5u2LaoqPKXoRvbrqESJdtLw4kkhT+nSEW7GzxFrnrWuy6TOInpJptm1tUM6/sy9YAeuk2Z8h/+8bG3wAlmg15Q6IFFWU2c/aQ4SOc5TERJhX3tIisc76DPmcGQX1K9VNeYoeAoa5PzgJxXse8QEZz6vH9kzhpq/Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Mz8wsO/1; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-88a26ce6619so68806566d6.3
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jan 2026 07:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768232104; x=1768836904; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YhowijaztWf/3gTanh1QGKmo9pcuIvisiulcfP4DQN8=;
        b=Mz8wsO/1AxcX3Tu66r/F9+HFCxf/0eGmDXiMy5tfjv7e+FpCblV+0TfvfBsbGfLvVN
         oo/9y7xe70ntJnSJ2PA8UuaKmp+vNPc4XKOqjUPGfYbPwsLZ1/McBFVHgn3LOE+WDA9Q
         GeuQ4YVoC/46hlst1x4HIK5C3AC3xnrthogAejFhmYXCGnGdOZah2Kqm+Ax2q2OFYDv7
         whf+ZMifd/AnwClHT4NAsWDp9BMlVY3MGybws9/fKCllkylug+RcOUSWP5GfpuhNYqO7
         pIDQlgjMgi5UMOSFSSh8w8OfKZY7fl2GyteFf9fW5X9DZbXpOdFIIPVJiszfM+bkq6Rb
         tJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768232104; x=1768836904;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YhowijaztWf/3gTanh1QGKmo9pcuIvisiulcfP4DQN8=;
        b=wKo6btIrLSXDci2nHNazDG0qjpjRH23UBoQtWat6bGjmDcQkSyGrVPG94YCAP8+FFj
         ruTJTg/EHPHMl9RI1p/jgEQ82ffnyYfyoKJBvdhBJnOFslP50w7h4LNBhFqTgQKt8b1u
         8BsLIgXO1qG2+u1a/kNvy9UuvH+Di6b8vhJqvYmdlcuKDvwx2gDmhLHauf5d3Ukmzufz
         iu8QPM1PAFupB6m6wDc83zPzTEURd2MmnKFkAJdy7U0KMROd1MxsvGH/82MVN/GaNg6k
         vkYRUBVj5nqRSNPepesEBS/bUlGdOlHLFfS5+yk8FiIqmu39zGMzkYrMEr2yahjyA7z3
         UcNg==
X-Forwarded-Encrypted: i=1; AJvYcCVdB9466XGkE5fBbq96XO4SH1f6NMa5REw1W1+oTbFQvfDdxO2wMnWDxxqtRquFslOlplM2tPa/a+NJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj4Sofu6ch2CFFTM5mEKu0CnFXz+xSuC1Gd3loWdVwowLWRHFW
	uY9qARYo4olibzziIjQyNBkaOxCzL32dUHxC5WzDzRNMvhrUEcOxVoeSH1CYsHmMKNA=
X-Gm-Gg: AY/fxX5Dg6xp3kK85SCxljW/to1G8hav3he9Ts9ui600vDDr3eZQYzVo3bXxTQLTZB4
	IIXZJhF3+8cF5Wj3w7diYSBkZ18DdHJy2YzP/s3dKbseh1QanS7tdu0V6RCAc6xvzpQlEQ0Ya8U
	GAPFi3von5CftAoLX73csQqtzX4SVUeq63pKzDh0TZSRU8+czh0XeCSAJwaJhWQ6X3Mm4agkLGU
	0JnXh8BchXMkLvACoVoJLpAvNZNDNcuIRkJ8ylPm+xOKRu6PU2tAIudSTam28IacwXbTjTOOCNZ
	R8m2eM4UyAP7SEVOndILyBBi+uibtZmY2FWXY9AsF9/OUMPuPQKGJXTwXzBux2BBsNMHf7oUJJ+
	gSg22g5s+s5YmOAZkiUND0B8kvMbc/ulvRmhczamgMqCuK+OOI/oUzoBG9qx/enxPvVhIunekFv
	MYpJzbwMOTal1Rc4Bx0n3yJLrXWehPirjEXcV/XRqB6Ssx7zVYv8pP6UKtbJLkd6mwQow=
X-Google-Smtp-Source: AGHT+IHFUDshOX5YDXPelpZvfCAVTGi9FjIy10Hnlj/GEw1ZiF/o5tF46ZaUyCruFsiUwzfjzfL6tA==
X-Received: by 2002:a05:6214:458e:b0:888:6fa6:782b with SMTP id 6a1803df08f44-890841d596amr270142346d6.30.1768232104214;
        Mon, 12 Jan 2026 07:35:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077280fd3sm137593066d6.55.2026.01.12.07.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 07:35:03 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfJwd-00000003R6K-0Swy;
	Mon, 12 Jan 2026 11:35:03 -0400
Date: Mon, 12 Jan 2026 11:35:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
	Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alex Williamson <alex@shazbot.org>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 0/4] dma-buf: add revoke mechanism to invalidate shared
 buffers
Message-ID: <20260112153503.GF745888@ziepe.ca>
References: <20260111-dmabuf-revoke-v1-0-fb4bcc8c259b@nvidia.com>
 <eed9fd4c-ca36-4f6a-af10-56d6e0997d8c@amd.com>
 <20260112121956.GE14378@unreal>
 <2db90323-9ddc-4408-9074-b44d9178bc68@amd.com>
 <20260112141440.GE745888@ziepe.ca>
 <f7f1856a-44fa-44af-b496-eb1267a05d11@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7f1856a-44fa-44af-b496-eb1267a05d11@amd.com>

On Mon, Jan 12, 2026 at 03:56:32PM +0100, Christian König wrote:
> > The problem revoke is designed to solve is that many importers have
> > hardware that can either be DMA'ing or failing. There is no fault
> > mechanims that can be used to implement the full "move around for no
> > reason" semantics that are implied by move_notify.
> 
> In this case just call dma_buf_pin(). We already support that
> approach for RDMA devices which can't do ODP.

That alone isn't good enough - the patch adding the non-ODP support
also contained this:

static void
ib_umem_dmabuf_unsupported_move_notify(struct dma_buf_attachment *attach)
{
	struct ib_umem_dmabuf *umem_dmabuf = attach->importer_priv;

	ibdev_warn_ratelimited(umem_dmabuf->umem.ibdev,
			       "Invalidate callback should not be called when memory is pinned\n");
}

static struct dma_buf_attach_ops ib_umem_dmabuf_attach_pinned_ops = {
	.allow_peer2peer = true,
	.move_notify = ib_umem_dmabuf_unsupported_move_notify,
};

So we can't just allow it to attach to exporters that are going to
start calling move_notify while pinned.

Looking around I don't see anyone else doing something like this, and
reading your remarks I think EFA guys got it wrong. So I'm wondering
if this should not have been allowed. Unfortunately 5 years later I'm
pretty sure it is being used in places where we don't have HW support
to invalidate at all, and it is now well established uAPI that we
can't just break.

Which is why we are coming to negotiation because at least the above
isn't going to work if move_notify is called for revoke reasons, and
we'd like to block attaching exporters that need revoke for the above.

So, would you be happier with this if we documented that move_notify
can be called for pinned importers for revoke purposes and figure out
something to mark the above as special so exporters can fail pin if
they are going to call move_notify?

Then this series would transform into documentation, making VFIO
accept pin and continue to call move_notify as it does right now, and
some logic to reject the RDMA non-ODP importer.

Jason

