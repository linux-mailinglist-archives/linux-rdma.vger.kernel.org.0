Return-Path: <linux-rdma+bounces-18908-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDv9D2RdzWkRcQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18908-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:01:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 495B937EF50
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A47A30C993E
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 17:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B28477E57;
	Wed,  1 Apr 2026 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ecUw8mHL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128E62E62B5
	for <linux-rdma@vger.kernel.org>; Wed,  1 Apr 2026 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065411; cv=none; b=MRR+6kbK6r1Qywe44833MhhJIetAmMUTA2PLhkKpnJGDnO04tyEeqND4bKQ2obzsjoIFLC63srdS8dNFrbUebntRj2pq3mopTtiy3I++urnDAozlVWn4i7pelqzaW0BdaJcUZktB525Q1FM5dTqP4DwxtqLfSx7prgBRHqMtk5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065411; c=relaxed/simple;
	bh=e3CRoJffDelcNgBLLlUtD6WhhBUG5M2GmDFzS5vKChE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nanOA4bt8lF4N36nDcAU+3+HmEBLBkurp9FKjhLjYXs/4SSElpuAmKvt8uRTHErouZ4PFeIt6oS99KxqjQMKRHMVmT05XKcWuAIiFY7YojHOgGboCmDZeNq9M2dxqQFRjp93s18Pn5AAqtWp7Rvsp1y/JYv0zXGH0TqMcn37+Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ecUw8mHL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b0c12be0ecso14735ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 01 Apr 2026 10:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775065409; x=1775670209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ay3iF+IOIXyQ8Y5GyamWOg2dop1zP3uPJAWOZ58oQh4=;
        b=ecUw8mHLZJ/xKhBi7Y/TumFZgnACNDjYGqlu394B1yh4xUgyKmsIM4UE4iFSGDFdGc
         cy+X3iuSYC6FL7wgeLAlJeMwkHWgNp8JcrAvqIAqm6sWbpLBS9ePfCJ3zF5PIPmELI2H
         Z4ndQyxISOGr4Rd6f9bB366lxBPRpTD4Z+8DiwRDBuLwp+6XiUlf86kwM6qy+CJpZyPw
         Ic8xHeAnSvPAcn22UH5K0KuU3gTB3SkEHTy5dSLqfBx0Lg//eWAm1fOQErjCTKl4nA1n
         p6no8N8X2RLAsz6DEH0kNdSzJsK4xUAZ6/tp6AaEDOBAWDVMR09fVe+U/Kvigc7ZxOj9
         9uLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775065409; x=1775670209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ay3iF+IOIXyQ8Y5GyamWOg2dop1zP3uPJAWOZ58oQh4=;
        b=FGX//HEDOb24b8mJR8wPmDThUtd3dxTRleUE98Q9aM0EngEsqbGxlzXpSCAnjr4kf0
         fP/Q6XIAvsFd/mGHZ4cPkLm/pvAbJsf3V8TB9dihSzxG6GroUCOU2B8ykghMfEvkCta0
         tS8tMd8OeXJ2HWICSYiChBLNLmusedw+untmV4ZaIrUbiSuoAuNYqe7Aq1JdKOu1hc3Q
         0c+HLOa0x8APijtu8CxgKom6A4IBmv8zB/YuGENa3AaW44/KEtLxrG8uyJUjtK9p2KdE
         Hv0TaleFjh6RjCg2dtOajxm3LdkVY22FC2HtZC7Fa/DgpkE3/zcFeEd+2mhgAhUhnf8B
         6fnw==
X-Forwarded-Encrypted: i=1; AJvYcCX4/OyagsdyhbQ3q7CJEqohAUn2po4JUPpkJVEkBEFFdmtoIcclA3d9qZqPpxLrdwbYE5c9k214Y+WG@vger.kernel.org
X-Gm-Message-State: AOJu0YxUUqDs+ZqYdjMR2emOF2EaBywjvvtbuefm40eY2WMb82SgRwEf
	0zQ4ILog/E4/v4lqJ4ueRjNf9kKAPzxFQ52xb/1pJ+z9+MgKAB5BcXNzFeiWgbDjkg==
X-Gm-Gg: ATEYQzz7oeuLlVD+FGZRjfAFbvT4TBayi6F1wv1cXjpVmmtuWrOBOKMNFDvW56hL2QH
	VKRxq3YBU0mEnthazvR9WDn7qppdWgLYsPEpsblam4sTGFhz6ZmqVw7BTKsgzS5XzCqMA7RL40H
	VGDd3mv8fHlFRHaZkXMo83HC+ynlC1cnaJSmpqQycCZRJHBzeIQeXvshL9pKzOfpT+Wg/JQD6lN
	QuxW2QxDLmO6zI7WjUvgIK3n0P1ivblLqfnDDrpGdjf8343fwkTrIsv5c3b9VspWWnj+5Q2zot9
	mocccyQxl3kJ3pVpprVzWGTddzn2aIsx/eM+HFFTUgjF0IhNM9QyG8Vo81yXyyd8S+tq5dYrKaH
	SV3/XItlJmw3p+J+kKPzyBHnZW6SSEjEpcT9QVMHcTPdSAn87UiHcvNcC8CoK7M9D5knJTHm93Y
	B5sWB2QXCi/dAI7LMh3hcfSyMCCwnPN/ndIxLE45cOnUswic/fkJtHLr7Q2w==
X-Received: by 2002:a17:903:285:b0:2b0:b0c9:96e2 with SMTP id d9443c01a7336-2b27610acd4mr80455ad.21.1775065408798;
        Wed, 01 Apr 2026 10:43:28 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a1e9csm3922085ad.55.2026.04.01.10.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 10:43:27 -0700 (PDT)
Date: Wed, 1 Apr 2026 17:43:22 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Shivaji Kant <shivajikant@google.com>, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] nvme: enable PCI P2PDMA support for RDMA transport
Message-ID: <ac1ZOgnpSjxo51WK@google.com>
References: <20260401103441.1229964-1-shivajikant@google.com>
 <20260401141706.GA22165@lst.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401141706.GA22165@lst.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18908-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 495B937EF50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 04:17:06PM +0200, Christoph Hellwig wrote:
> On Wed, Apr 01, 2026 at 10:34:41AM +0000, Shivaji Kant wrote:
> > Enable BLK_FEAT_PCI_P2PDMA on the NVMe when the underlying
> > RDMA controller supports it.
> > 
> > blk_stack_limits() currently filters out this feature bit because it is
> > absent from BLK_FEAT_INHERIT_MASK. Manually re-assert the capability
> > in nvme_update_ns_info() after the stacking operation.
> 
> This is really two different features/fixes and should be two patches.
> Note that Chaitanya also has an outstanding patch about p2p on multipath,
> so please work with him.
> 

Ack. 
Shivaji, I believe this [1] is the patch Christoph's referring to.

> > Hardware reachability remains enforced by late-stage distance checks
> > during DMA mapping.
> 
> I don't know what this is supposed to mean.  Callers need to check the
> reachability first before submitting P2P I/O.
> 
> > +static bool nvme_rdma_supports_pci_p2pdma(struct nvme_ctrl *ctrl)
> > +{
> > +	struct nvme_rdma_ctrl *r_ctrl = to_rdma_ctrl(ctrl);
> > +	bool supported = false;
> > +
> > +	if (r_ctrl && r_ctrl->device)
> 
> to_rdma_ctrl is a wrapper around container_of, so r_ctrl can't be
> NULL for a non-NULL ctrl.  ->device also should not NULL because it
> is set up before namespaces are probed.
> 
> > +		supported = ib_dma_pci_p2p_dma_supported(r_ctrl->device->dev);
> > +
> > +	dev_dbg(ctrl->device, "PCI P2PDMA support result: %s\n",
> > +			supported ? "PASSED" : "FAILED (HW/Driver restriction)");
> 
> Overly long line, and screaming isn't really something we do in our
> messages.  We also don't do that debug message in PCI, so please just
> drop it.  IF you think this is important enough add a tracepoint in the
> core code in a separate patch.
> 

+1, we should drop the log and add a TP if necessary.

Thanks,
Praan

[1] https://lore.kernel.org/all/20260323234416.46944-3-kch@nvidia.com/

