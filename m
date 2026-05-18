Return-Path: <linux-rdma+bounces-20928-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEUcGDVVC2qYFgUAu9opvQ
	(envelope-from <linux-rdma+bounces-20928-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 20:06:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C28571ED2
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 20:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B8F73085623
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 18:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C313812EF;
	Mon, 18 May 2026 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E7hawOHr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4911938229B
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 18:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127361; cv=none; b=evABqrLdNnC7XJ24ouo6iqX/8ZdqnQy+FxYtZQlXxnM6fAUJ4VRhrVwYdSQMC1xgRy0OvjJov2x0HAxpemT6AOLRS6tVD4ju1MFFS2bBJsEaj1W5rquu6HPl3gqGtPnA3t2GWT3G9rRkzraWQPwKbg9xgl9rfxeEVMzkes3sL8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127361; c=relaxed/simple;
	bh=h96YifEJqAcrNhz1H6iBCXaYOWSpvjFtVvxJ6WVvRjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ne288z+JTyH99iBK/ZeFhV0VZ6aisCVCPCuW0GF+XiM8EFeL6D05YSDdShSdZvN35a5Vh5VAVyYJbG59W9M1yYsTuLNhyKEOfQ0mwtG+KofHtWRC3ZszTGgEdxaFo3CAmfYEBioo8DRgWcNBzTn8+9hDwywdw3WlShQrfOsJyTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=E7hawOHr; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-911dfc86901so291449785a.0
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 11:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779127358; x=1779732158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q010TrJ+rZYbdO8zg1uA459jcJaTc7v6+bMcAy7/xa4=;
        b=E7hawOHrbNt4sYd2taZBQFoZRRoYxqoScDTrf8UDo7EBOvchaUNi2yw4KHv2DMEQDN
         cuTTf5bxNCzo/dtMua6m9EXQxgNDGVWEJojTX8clxdtv27vm0BysyUSymr89Lzm2pelL
         ixgXmqKXRrTbS8eIm1FzAHRKXeK2Vt5gV2SFbFjummq5RUMWGelexgdbeuXSa6j+hhBn
         AllUd3/uuwglZzK9TmGgi+eHr5EYilLZD9yueOyaJEczDbBKk5ErmF5wp6uKwYMfpDwP
         5B5/geiCRn1Ce1PA+EATaMvmQAnA/TWNrybJsm3kOWHtZo1W8/hl0r/TPuIEIAt444qp
         /E8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779127358; x=1779732158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q010TrJ+rZYbdO8zg1uA459jcJaTc7v6+bMcAy7/xa4=;
        b=OeP5cdGWu5weT/CJrvBwWrPzmLV/YErdEzMoZdjaikYQ/dadLaiX3GSahkDhTcTxxE
         YYqJOohQn5cqqMh/6XLWn0YYG13DIAmkf8lqr9a5A0KuUTWG4kohWRoM+ByiZC6TD9If
         ULBiWzqJ0kNSEMDLr+Pn3di+DbYV8oYhU/rnrqxP6kpLUDWZA29LKJaVyFajLgkjLUSv
         MGxSim3GcPUJzUzUGlUVxqABELAkXQrBJ8DGoZeW4heIKPA2ybjVdJJn06SbpB80tjEQ
         Er+hD3LSUdwAnLILfSwJ2rWJU95CwCu0sfvZhkV3mfDiwd35ibAth1qgNjI3EsLTCbjk
         MrQg==
X-Forwarded-Encrypted: i=1; AFNElJ8lg/Nubac1hleVMOd+vCogCLkNbdzKHqFw9/CkWoT6EJ00/okX+kXWVrzuj3k83eW3Q25yxmydpOEo@vger.kernel.org
X-Gm-Message-State: AOJu0YzUPaI6yPa4IfHivht3dVb12uvJdOcFUSImqHnOpR9dwx/QuDN/
	Z/D6sAQHEsYbO0zv2HSvTy57wxAOHlrj0iwLAJFbvgQENF42fdadGNcUM3N5lHCO/ZQ=
X-Gm-Gg: Acq92OGfHWzSdsOM2LqKS3HWuBXH7zsyOXhoxmF0oYVry2VbQj5uitnL0WiVNWVJEvH
	pSZo/LwpcZMj4S1ILEWM2oWIKNUoupzIeNbTHOpuWFfs5SNJB5J0uPxX5x2lhXoggfoO8Chv+6E
	s8+oVR428XAY/vOIQzy+1YRzirnSgLe8f9Wy0H2/Uhq+5zk88eGvEb2cBWWnMa8UZv6RnCw5yur
	kQ2B0xcgZFL0WrrBToKJ8ZLDn9Q4Aqunzo0rNL+BN2Rd6RY4sO6jM3mOnhpXbufCg1L3S/dwgTW
	6Vff8fiSlUXYDsIcUeNqI/zF+mSDd2XnnQdM00XSC/CNqs8uijVoODR7HH9fDYRbmbY/Cj9FALN
	inoP3sZakN7bdx+Dv+aeRIw7MPf2ZoA324hkZwoo3ea59SdV5cyTXZbj0b3F/qwrlfeF+ZLB5j1
	milQH9O1Hd5XaO9gyRbCsdkNb1/jFdKz00cVyEiKnoaArnW8+w8AKDrDsuOWNYvI5ExKAxyilW4
	vRvkiHCl8L3Oo8+
X-Received: by 2002:a05:620a:2589:b0:910:21d2:241c with SMTP id af79cd13be357-911cd75d526mr2268791985a.18.1779127315699;
        Mon, 18 May 2026 11:01:55 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83f926sm1584917285a.30.2026.05.18.11.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 11:01:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wP2Hp-0000000DVgb-3hhi;
	Mon, 18 May 2026 15:01:53 -0300
Date: Mon, 18 May 2026 15:01:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Moroni <jmoroni@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-rdma@vger.kernel.org,
	leon@kernel.org, mrgolin@amazon.com, gal.pressman@linux.dev,
	sleybo@amazon.com, parav@nvidia.com, mbloch@nvidia.com,
	yanjun.zhu@linux.dev, marco.crivellari@suse.com,
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com,
	ynachum@amazon.com, huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com,
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v5 03/15] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <20260518180153.GV7702@ziepe.ca>
References: <20260517063006.2200680-1-jiri@resnulli.us>
 <20260517063006.2200680-4-jiri@resnulli.us>
 <CAHYDg1RXDuB91xDUW9cURq3hWfYeWabrBNKfXEZm6aHVbQi+9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHYDg1RXDuB91xDUW9cURq3hWfYeWabrBNKfXEZm6aHVbQi+9g@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20928-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D2C28571ED2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 09:04:06AM -0400, Jacob Moroni wrote:
> Hi,
> 
> > +struct ib_umem *ib_umem_get_desc(struct ib_device *device,
> > +                                const struct ib_uverbs_buffer_desc *desc,
> > +                                int access)
> > +{
> > +       struct ib_umem_dmabuf *umem_dmabuf;
> > +
> > +       if (desc->reserved[0] || desc->reserved[1])
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       switch (desc->type) {
> > +       case IB_UVERBS_BUFFER_TYPE_DMABUF:
> > +               umem_dmabuf = ib_umem_dmabuf_get_pinned(device, desc->addr,
> > +                                                       desc->length, desc->fd,
> > +                                                       access);
> 
> This all looks good to me. Just thinking out loud...
> 
> Is there a longer term plan to handle revocable dmabufs on this path and
> get rid of the separate ib_umem_dmabuf_get methods?

We probably will need a more general _revocable variation that adds in
an ops struct from the driver to be able to do the revoke.. So far
no driver supports revoke outside of MR so...

Jason

