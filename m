Return-Path: <linux-rdma+bounces-15479-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBF6D144DC
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 18:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF13E306E4BA
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 17:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84A2379967;
	Mon, 12 Jan 2026 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="l7zXiZ/a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E3130BF6F
	for <linux-rdma@vger.kernel.org>; Mon, 12 Jan 2026 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237480; cv=none; b=ewNY0iIkMFHLghNG5Go8wJ2rR0mlrEp1JTxdbBBXaw7aTL1xwWAfkP9EbpsQAJtH2YxUp7vLQFnO/4Cab9fo/CPu98a4ctJUJWKlAtd8Uao6XfaCFcfNjh+eXiE8pe11UYvKum7RtUSMDoaweQ+8lmx3X8GuDOmODQlmgDiV9UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237480; c=relaxed/simple;
	bh=kqVUiqT6KtRytlahMDtuyi2Socb+UOgt4TA6Nk04jRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAu5ezX73wuPPHjTVqhjfY7ELWFQ1uvnaDG+sIAEL/lQRrzR5iorGjo80I25HZaQ3+wNPT5NtgyWGQbmJUCEyfrPxpi8Nv5xOA0rCYGLAZN6BEt7C/q9Q0Zz6iZY1vMI1O2/C0P1YyX4R5zVtNZms0Zury8WBzNdVsj8BKl7Wss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=l7zXiZ/a; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b2148ca40eso956631685a.1
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jan 2026 09:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768237477; x=1768842277; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OcyVQ16xm+GiG5uZamh0DYF4z7rm9kbmhFMirpeUsGo=;
        b=l7zXiZ/aW+yD1Lv6DQdcw5be3vS+3NHd7+FDGKooRgEbQI6AqXfFuAIWjkUm6CnH7V
         WLgNA/iA+xYpZmsSFB33UemonE6M2qdmV6VRIKY1GKU8x4ry/68eS8UB94cynvPnLpeH
         5Ubp3Jr0ipJixDxja4/jscEMwwcBGK836j0E+1rh2nMA4t9qjmi8uY2F3NVTZ/8FpnTB
         F+3/wAZasvEB0FYVd5Xkka/xfcpQiKuvn+7Ong8qGxeIn50jZfTjDbPHXxNOMctSbKFG
         pwAy4nc+ZKZNsVrYlcIlNHMt6FEeMVpkedypb3/mt0QVC1toBayqtsCyhBYNJWmnaRoR
         mAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768237477; x=1768842277;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OcyVQ16xm+GiG5uZamh0DYF4z7rm9kbmhFMirpeUsGo=;
        b=Zc21diUHX55gWkIvKOY9EsQMBEa+fO9M+jFyWKdC66cGyUqPbNDNln3uOmww1seg3X
         Sj5/LV5ZWZZ1JFDppH/j94MvWMaN9kBiJ3KvTTEj0G99cCoNgfv33qJ/aj4pLn16be6u
         rUDHzWqh+SlzTCxtAvKcpr9a69lM8IXrjgizTdWH25ohx0BfnOp43pfUCERzGCMHCrpD
         olbyqywI9V+GG654iL7kgCUZxd5GANWZ1iGE8+hJ+xt9FKtevEsNTq+azjIZNd2+qdFQ
         3SkVIn9a9B2COTrqsfDXWM+hzeB1mbtLCp6d1gExhqdM40PIt8PL+67VIUiQtw52eQU3
         F8xg==
X-Forwarded-Encrypted: i=1; AJvYcCUIDLJk/dHZp63xa244q2o6MclGGkN2iGOqwQ6dInUrSMVaEU5ZHqufG3rmXk2IlmWLJT+ERjhqOy02@vger.kernel.org
X-Gm-Message-State: AOJu0YweJi7qVGqhugpk8vtnPBPqCR6PfQvl2tfxlSy+1BJted5/byHs
	+ytP1aMFJ/A50myttnj5to1hdjxWhEWoPWvlbvS/yhvDBs1lZu2MbC568OxjO8Tdc8XP8OoDaVR
	YyCUL
X-Gm-Gg: AY/fxX4nylcTQTHD4QPVmiI+9K/vjHDu+iwJpfXkSKB7jM6kPICg+oFG1b3puR5s6b1
	hiaWTsNHn3M9UKCzNOdp+uH9PyHTgZJPAY/wI4+QRfBXnlTcPR2WdzT2OMPpTaga5lGuDnFSoIa
	Tl+49EoXbT1cQ26mBXzhXDgo8DhzNJ9idgqV41GqM3C9EbIDXvNXzZ434UGbtV4yf+D9rdaAcyn
	oeRCyNWfbxZ46ZDRooX3UENpW0PuTIJdUH+qbHnWqhpxgMgXj1yW8LN+Mv6hKQjOYQzqijSCewB
	lPE0CzrSjAoIIDUPGXDn+yYpRgfWiL9XGuB/l1OTqz31l7DmSLbzLkdho3F+WRa4vWfttYkcnnI
	//CyAHyFI7pDD1O66rMZwXoGLniShqEqGfjc4LXB5YeXy7bQccSZE2HH3QjQpoX/zpUmwKk8r75
	Io8+VJU4d+vIvdy4jIneN3m042QRYZkTMOzCQUyjwlaMQW08n7Paz2n2sqxjDu/IbKtbQWKl5E8
	B7peA==
X-Google-Smtp-Source: AGHT+IFNLsjliAScqbFFhKVSqiGiRJW+dH1w6MdFsmu8SpI9IHI7Dx7AHxGoF9vGvT6LPNemfh4Zsw==
X-Received: by 2002:a05:620a:2807:b0:8b5:5a03:36e3 with SMTP id af79cd13be357-8c38936c4e7mr2741533585a.16.1768237475821;
        Mon, 12 Jan 2026 09:04:35 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51cdcesm1544825185a.26.2026.01.12.09.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:04:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfLLG-00000003RoH-2rL8;
	Mon, 12 Jan 2026 13:04:34 -0400
Date: Mon, 12 Jan 2026 13:04:34 -0400
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
Message-ID: <20260112170434.GH745888@ziepe.ca>
References: <20260111-dmabuf-revoke-v1-0-fb4bcc8c259b@nvidia.com>
 <eed9fd4c-ca36-4f6a-af10-56d6e0997d8c@amd.com>
 <20260112121956.GE14378@unreal>
 <2db90323-9ddc-4408-9074-b44d9178bc68@amd.com>
 <20260112141440.GE745888@ziepe.ca>
 <f7f1856a-44fa-44af-b496-eb1267a05d11@amd.com>
 <20260112153503.GF745888@ziepe.ca>
 <f2f82341-3799-4379-a0e7-6e9d56a7eda1@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2f82341-3799-4379-a0e7-6e9d56a7eda1@amd.com>

On Mon, Jan 12, 2026 at 05:12:36PM +0100, Christian König wrote:
> > static struct dma_buf_attach_ops ib_umem_dmabuf_attach_pinned_ops = {
> > 	.allow_peer2peer = true,
> > 	.move_notify = ib_umem_dmabuf_unsupported_move_notify,
> > };
> > 
> > So we can't just allow it to attach to exporters that are going to
> > start calling move_notify while pinned.
> 
> The point is exporters are already doing this.

:( So obviously this doesn't work fully correctly..

> > Which is why we are coming to negotiation because at least the above
> > isn't going to work if move_notify is called for revoke reasons, and
> > we'd like to block attaching exporters that need revoke for the above.
> 
> Ah, yes that makes sense. This is clearly a new requirement.
> 
> So basically for PCIe hotplug was a rare event were we said we have
> some problems with non-ODP but we can live with that, but for this
> use case here it's more like a perfectly normal condition that
> userspace can trigger.

Yes that seems to be exactly the case. I didn't know about the PCI RAS
case until now :(

> So the exporter wants to reject importers which can't handle a
> mapping invalidation while the BO is pinned, correct?

Yes. I think at a minimum exporters where it is a normal use case
should block it so unpriv user space cannot trigger incorrect behavior
/ ignored invalidation. ie VFIO will trigger this based on unpriv user
system calls.

I supposed we have to retain the PCI RAS misbehavior for now at least.
It would probably be uAPI regression to start blocking some of the
existing ones.

It also seems we should invest in the RDMA side to minimize where this
is used.

> > So, would you be happier with this if we documented that move_notify
> > can be called for pinned importers for revoke purposes and figure out
> > something to mark the above as special so exporters can fail pin if
> > they are going to call move_notify?
> 
> That would work for me. I mean it is already current practice, we
> just never fully documented it.

OK
 
> > Then this series would transform into documentation, making VFIO
> > accept pin and continue to call move_notify as it does right now, and
> > some logic to reject the RDMA non-ODP importer.
> 
> I think we just need to expose this with flags or similar from the
> importer side. As far as I know RDMA without ODP is currently the
> only one really needing this (except for cross device scanout, but
> that is special anyway).

I did not see any other importers with an obvious broken move_notify,
so I hope this is right. Even iommufd has a working move_notify
(disruptive, but working).

How do you feel about an enum in the ops:

+enum dma_buf_move_notify_level {
+	/*
+	 * The importer can pause HW access while move_notify is running
+	 * and cleanly handle dynamic changes to the DMA mapping without
+	 * any disruption.
+	 */
+	DMA_BUF_MOVE_NOTIFY_FAULTING = 0,
+	/*
+	 * The importer can stop HW access and disruptively fail any
+	 * of its DMA activity. move_notify should only be called if the
+	 * exporter is experiencing an unusual error and can accept
+	 * that the importer will be disrupted.
+	 */
+	DMA_BUF_MOVE_NOTIFY_REVOKING,
+	/*
+	 * move_notify is not supported at all and must not be called. Do not
+	 * introduce new drivers using this, it has significant draw backs
+	 * around PCI error handling and other cases. It has the most limited
+	 * set of compatible importers.
+	 */
+	DMA_BUF_MOVE_NOTIFY_UNSUPPORTED,
+};
+
 /**
  * struct dma_buf_attach_ops - importer operations for an attachment
  *
@@ -457,6 +480,8 @@ struct dma_buf_attach_ops {
 	 */
 	bool allow_peer2peer;
 
+	enum dma_buf_move_notify_level move_notify_level;
+
 	/**
 	 * @move_notify: [optional] notification that the DMA-buf is moving
 	 *

Jason

