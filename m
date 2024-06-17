Return-Path: <linux-rdma+bounces-3213-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA0690B454
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 17:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231CF287ADA
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F3813A265;
	Mon, 17 Jun 2024 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FA7meC4E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1051110958;
	Mon, 17 Jun 2024 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636551; cv=none; b=Rp3JCo5O/1zpoSmvSBoZUo6KlB9zgi0mRGgfXn6Su5gSS/jfgodwTL4/pG9AkV/89p6SzmKy5CGze/o8TVCNM2Ge8UcV+KQMB3mS8Sl4czJ/ceZJV/EIh0nPncCeq1kq0RM+3KoWdSoP9lfROFIGfhCqFpL9Y2j/3uMw27Z5FqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636551; c=relaxed/simple;
	bh=Gp3uR0qZ+/SQJ4MnZLms8pVZ4Xf2Bw9ZLHrWOyvmpPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hp4i4R4obTzvPQdIjyEutnUV5lzSJAI+Xfp2lLzSt0VG1RWL70Rw+kkn6eau0zWILypLB/D9pcB91MLnEEie7Wmwwbs/EiVUUyX/LY3/Yh+eXKhpzBbwHNfJ43rQ+M4BM2DJRbi0+/Gfw83fTf/IVkma0rN+lrX17yeNemOS404=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FA7meC4E; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=nIdL7P86hcKvhF+tvLQiYN1713n2GXUoWwoYBL1KXZc=; b=FA
	7meC4EcKsGp7Bc73EpvI0iZ/MsHIgAybJgVbVC5Dbqt3O1gcwASYCJO+vqF3E/eh8PgwhsbGLdgK2
	KlnA+Qs3YMiNXd6JaB1DKBD5gyC7kNy/Prlkmw0HZ9hNhRahFNONHYSP2pruUmCQPrBnyHll/jJfr
	WIFSCPlQDoP/MdI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sJDsG-000HYN-Gp; Mon, 17 Jun 2024 17:02:24 +0200
Date: Mon, 17 Jun 2024 17:02:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Abhilash K V <kvabhilash@habana.ai>,
	Andrey Agranovich <aagranovich@habana.ai>,
	Bharat Jauhari <bjauhari@habana.ai>,
	David Meriin <dmeriin@habana.ai>,
	Omer Shpigelman <oshpigelman@habana.ai>,
	Sagiv Ozeri <sozeri@habana.ai>, Zvika Yehudai <zyehudai@habana.ai>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/15] net: hbl_cn: add habanalabs Core Network driver
Message-ID: <f2ddbeaa-e053-467f-96d2-699999d72aba@lunn.ch>
References: <20240613082208.1439968-2-oshpigelman@habana.ai>
 <9d13548f-7707-4741-9824-390146462db0@web.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d13548f-7707-4741-9824-390146462db0@web.de>

On Mon, Jun 17, 2024 at 04:05:57PM +0200, Markus Elfring wrote:
> …
> > +++ b/drivers/net/ethernet/intel/hbl_cn/common/hbl_cn.c
> > @@ -0,0 +1,5954 @@
> …
> > +int hbl_cn_read_spmu_counters(struct hbl_cn_port *cn_port, u64 out_data[], u32 *num_out_data)
> > +{
> …
> > +	mutex_lock(&cn_port->cnt_lock);
> > +	rc = port_funcs->spmu_sample(cn_port, *num_out_data, out_data);
> > +	mutex_unlock(&cn_port->cnt_lock);
> > +
> > +	return rc;
> > +}
> …
> 
> Would you become interested to apply a statement like “guard(mutex)(&cn_port->cnt_lock);”?
> https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/mutex.h#L196

Hi Markus

We decided for netdev that guard() was too magical, at least for the
moment. Lets wait a few years to see how it pans out. scoped_guard()
is however O.K.

   Andrew

