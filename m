Return-Path: <linux-rdma+bounces-19290-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBjJDoP13GkvYgkAu9opvQ
	(envelope-from <linux-rdma+bounces-19290-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 15:54:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8FE3ECC8B
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 15:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBD37302BDF2
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 13:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3570F3C9435;
	Mon, 13 Apr 2026 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="f/TW0Bx+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ECA1E230E
	for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087968; cv=none; b=hRv+gotGbVi0kJLeFmnjOVmPqtfzoaqeNSHLk0B+fQWoZIqe8dgUo38c9KTaeXnMjj7rsPpRJJjapDEvw6PmJZ6pnGkqs8MtrFlokU6YOjlD2RMD1WJrVS6riBkZq5hVT6E18xQrSYiMNFxmsQWUuMYgrCv9N2zZhidYSggEQ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087968; c=relaxed/simple;
	bh=SKDyDeGLAKxeIgYcE/qZKnwcFXAE4s0elS0LgRHfpcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRBpXasdE5zpQNGQuNYd62wANHYjiuRj3lag75uGgWU25QUXcX+NfOH+TnXs/8GK8ynRi8JBXG3o/DO1QSjSa0iYQsMKxPyqDIxZFMPH6jHlazkTQPxalY7h0diT2LiVIy8GQKNeLxHmDxMhpiti/26WZ7Yft/nQM2bL1zWiWC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=f/TW0Bx+; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cfc5941028so657273685a.1
        for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 06:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776087965; x=1776692765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rx2nTgwnCEnXXRiMkiTBuROyOk5YN+wYsn+Y4QhOS7Y=;
        b=f/TW0Bx+rkGxH3UsA8E8/yvYJXo+e0k96pGH27Kt2SzqKf6T+nL4Zh+vFD4AiWtT8A
         sSJZuatZcfRBCeCj7EBvfmzK8wz39zWeKAFRTFSjfBgOfy1KryEVXM6nkISDEHp++ptv
         SoZXa3h7R34NjuxEg2pAgTxLsNf7AzCKaczdupu7DjkVL+fjzYibfq1zj84FXowKcMhT
         5HtmadyhT2RQRLY+Wqw2aIYZITHXZPmLh6kifzaPvj9LR+GVCP79SecqNOUWH2mcr1uW
         MQ1XHuji/D+g/xO60/IOosD1sWEG0t5WuDCks0FgliUuIboUEFYMMhKznhhtRb89AJ1H
         dwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776087965; x=1776692765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rx2nTgwnCEnXXRiMkiTBuROyOk5YN+wYsn+Y4QhOS7Y=;
        b=BuBV7gb6nNpqgrlGZ+1nBBzR8MT93ep/0VbwMQKACTD+WYmfJ2RUkdMOYldiBdmcBd
         D4CdnVox6zta3zKn/oHL710RIVNNmOu91AlrPKa6EtLuUxk2goSKxjFF1Og/EUgiiZcQ
         F/vos1IMVGoS4oJoxIxVWRVmjrvTMQLc1a3Bw/PBVBS/jH6wfuQSbUch1NJ3vBjh/mN5
         1FArz67DxE2ZqZ1W5xN/MJkWmse5STOahGux4j4D1zyVSwQ98h8YNzkksMZc2Z157kCR
         2RcyKk1XTZlsiPvxUR1M5ZIn6BzsJxgor6MIlk+6r6I6XBa4LaX4VcAr/jpkNVbkxcQn
         qSpA==
X-Forwarded-Encrypted: i=1; AFNElJ/mYbMs2YEFfMT/Xj4AkCYm5OA55DYNclSz2fBZ7Uc46Mua/j3UHa6D9TKhnLytaz7BcI78htCqyoa4@vger.kernel.org
X-Gm-Message-State: AOJu0YxtYzLELzsjtiHx8zNx1DWy0PNRrNJsIRfi3smyFLOLWejzwuUq
	hRSHuc5aTN7A+nugbLeRbmRpkOgOzjXybUBkk1GLOyV2bAku/CTp7MoIM4sQTmJfjds=
X-Gm-Gg: AeBDiet+KsOoH1HLWgnt6qGrN7ZifFwo/jDavrt8hz7Cv/TVzw24AIkBYdaJeAuEODS
	FoD2Su8iGgRc4MRBGpkVg+aMDUfHxHbPz4PaQB5swULWjxc2IbvV1DAI39L2xoi0aLagUA2FUTb
	mfl6GlOnAgGEPfl4Q3YrTJ3bXwoywVcosdJsiKTS6ONEfYs47QBi4xRy0jxJ35zZVrPnBgJSUqI
	gQE2jeAcKUAsu9Tny88LKa51FUL6sxh9wvuVCsFEBU6U9p115H7gOEiMo5TLGURqS8EOJLjxbdl
	NGaklQ6XIFhbB7qq07BfZ8UXFD84NXUEDTVdnnyWpjzP5iVGvFJhc1qa20RavrudsEqckcW8Lwy
	sCUZSjpF8GpUwjh0LxQYE2ubmXo9UG8mKW+Q7zdAHV9dxW2e9zhBDoc40g2yVfJOuq+xoyJy4Y6
	jsH8Z2r9qQ+1H97TvCynSo0GzrrWxf2giTvNVnttpODYDqny31Ax2DNc4s5jOkm7sYakYfrK+NC
	DESLg==
X-Received: by 2002:a05:620a:31a8:b0:8cd:b33a:a4da with SMTP id af79cd13be357-8ddd00a8a98mr1835861985a.55.1776087964542;
        Mon, 13 Apr 2026 06:46:04 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e07730d836sm381231385a.3.2026.04.13.06.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 06:46:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCHc2-00000005BFb-48oy;
	Mon, 13 Apr 2026 10:46:02 -0300
Date: Mon, 13 Apr 2026 10:46:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Long Li <longli@microsoft.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH rdma-next v2] RDMA/mana_ib: hardening:
 Clamp adapter capability values from MANA_IB_GET_ADAPTER_CAP
Message-ID: <20260413134602.GL3694781@ziepe.ca>
References: <20260312181642.989735-1-ernis@linux.microsoft.com>
 <20260316194929.GI61385@unreal>
 <SA1PR21MB66832D25A93394735624F454CE40A@SA1PR21MB6683.namprd21.prod.outlook.com>
 <20260317094408.GR61385@unreal>
 <SA1PR21MB66833EBAF447BA0B102862FCCE4DA@SA1PR21MB6683.namprd21.prod.outlook.com>
 <20260410154327.GA2551565@ziepe.ca>
 <LV0PR21MB66700DC2FB827B93ED6A5714CE592@LV0PR21MB6670.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV0PR21MB66700DC2FB827B93ED6A5714CE592@LV0PR21MB6670.namprd21.prod.outlook.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-19290-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[ziepe.ca];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C8FE3ECC8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 10:29:45PM +0000, Long Li wrote:
> > On Sat, Mar 21, 2026 at 12:56:39AM +0000, Long Li wrote:
> > 
> > > How we rephrase this in this way: the driver should not corrupt or
> > > overflow other parts of the kernel if its device is misbehaving (or
> > > has a bug).
> > 
> > If we are going to do this CC hardening stuff I think I want to see a more
> > comphrensive approach, like if we detect an attack then the kernel instantly
> > crashes or something. Or at least an approach in general agreed to by the CC and
> > kernel community.
> > 
> > Igoring the issue and continuing seems just wrong.
> > 
> > This sprinkling of random checks in this series doesn't feel comprehensive or
> > cohesive to me.
> > 
> > Jason
> 
> Can we follow the virtio BAD_RING()/vq->broken pattern in
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/virtio/virtio_ring.c#n57.
> 
> Add a broken flag to mana_ib_dev. When any hardware response
> contains out-of-range values, mark the device broken and fail the
> operation - during probe this prevents device registration entirely,
> at runtime all subsequent operations return -EIO.

If that's the plan I would think it should be struct device based, but
yeah, I'm more comfortable with this sort of direction as a CC
hardening plan.

Jason

