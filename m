Return-Path: <linux-rdma+bounces-20517-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKZpGE9+A2pV6QEAu9opvQ
	(envelope-from <linux-rdma+bounces-20517-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 21:23:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A945289CA
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 21:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D9C330316D5
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 19:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E5938333C;
	Tue, 12 May 2026 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="c0+d3o5Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C927368D42
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 19:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613802; cv=none; b=vDdvaKtIkFlDXu8IHMAT7rk3t9/sxBViKpYBvk1AUKPpa2ZB6m+InBbaOUVBtb71yx9jYlpYqDOzClayBicZ+EAD/l/yCxI7YK22KMu8Pzkvl1JPDYn43t7dZm4yTLv3qRmdx/DcIvSPmTGsyar1T8n0YvoiOqR8QdgQ0kRcchg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613802; c=relaxed/simple;
	bh=pdqW41VZmpw0mXcF+HArwZLLOTtlbncYfCHIegAJKxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULAhlVs718zdYx+oM/hLSrlXOI2cj3Xql8boevBzhW3Pvimw5xh+t4o1c6q0k3IG+UM/IxmT+D7jl6BjqPMz6PTVEyk1unr2DAw+SGrtGgx6cQdqqAaf8CWFVYbk0B80niXXlBl4c9RnNR2+qoJ579c1HhGM2uccf9+/kho7CpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=c0+d3o5Y; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-90d2e6b4fb4so111608185a.1
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 12:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778613800; x=1779218600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1YgSEbWoadG4nnUiOiVn0upSDxam1IO+ICxE+kKFjx4=;
        b=c0+d3o5Yk98a/2wg2Vyg1LTRATWznQ3hqZqrykNKLw4R2xuhhS4sVN9jQbUDRX4Eh4
         NqQdCSxIJciN1ZelmO++M5chzNRC5L7FoPwR+b7nnhMLyfB2Z3tlggaEboJC6tbpzD9m
         0s5J+cuqHSzyGJk376q/gtAFC9HWiFNpcFU1KsECR5VuqLyIvj2I3sT9tpja5uk/eEw0
         wBtbWQSCg6xBqePCavQhxtX73n0zY9mkfSTMpn4SoPBeW9mO+uO8ZJld01Dy/G9FZInq
         rcbuTCCvIaHkiKvYlypnsnFL6CD1Jhc//1gCo9r9IpKjIfB8noQuS+/NUUaPFBVaQ2ES
         eTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778613800; x=1779218600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YgSEbWoadG4nnUiOiVn0upSDxam1IO+ICxE+kKFjx4=;
        b=do+B5M4flVclRmhILvPR5Oy5cpcmHBazeqkSaQv0YG1uOmINlstGUy2Fyb330IA+CV
         QxO6X+HWo2zBIk1x9kcpCNdnMxxKrNNZoWwGyigivj6RfIqLlyTtpPmAiVg/2fnj7HO5
         BAQ53UScS4DSqUuT8/cnsqIbUHHXrcsKSf+G9Hu0nKvN3AYPimBOLFq0bizqSKDlIZZg
         bAPv3jKl4vWSCDAzlpaA4Nv9BN8+oiAvj+vbiK2cKdzftFMPypsbK104dzmqpjHzK/IM
         80fpuN7Gkpd3wyFTXM1DQWh0bot0g54AeHfz0RHjBRkfIfUIs5spOyme3rVS+rbCphXq
         2I3Q==
X-Gm-Message-State: AOJu0YypMIvw1iUQbPuD+X8mPnzi/tAC835gpCO3iU3Xsf/ZhGFFG5J+
	BR0231pl0B2Q0UBoxziAKMU5HlVvnFg1wb83k9hllAVqPf3nTF1BHv+0sRmJp7VQJDU=
X-Gm-Gg: Acq92OEuq6Tb4nhMvzXG2Db9Qli1e89ZyO2SPdcobKBKELkPyrEZIKkrYvCwTAMxAy2
	JUvCT2HQEEx/2pSHXZRHa6sCmnznkDVGzq1DhSd5ujDzOLJweAsuTSiQ4j+W3J+hoZcufRq0fnD
	fpLTq2F7WOeqp6XAz2Z0nl7d2nJDSXUqbi7CbuEx1IINx490L8A6dBSHpKmWXM7mrxB9XxrcE+I
	ZRRuF1djaVnj3mXi7FuamrGPgad0NmzrgpDIZFCXkyOGoAEhfgDNcu7AFkQvEShSdCS9glut7RC
	Pl6JDL8hhpsLpL1h8xjOQ7GPIN5+n0Kg/rriSm2p8Kvjn7nLPBuZSMvMdnVUzM1BFQYGLBfbKKT
	topulgKw0r+zcGYZVDHXqCtW1OzDlUjI0m195HfhwogNXT6u8qXy62I6VXXBDADFFDJA1i2ijp7
	7DMbZUt+3C6PDVKpWs8J3XZU+ACw/37CBQUEuHKoSEmwezm/0MnzYUU4cx34a7bO20CGRAmX7sg
	PmtSw==
X-Received: by 2002:a05:620a:4044:b0:8cd:923a:87a0 with SMTP id af79cd13be357-90f88d9aa33mr56263085a.21.1778613800041;
        Tue, 12 May 2026 12:23:20 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b918cffesm1507218285a.14.2026.05.12.12.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 12:23:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wMshL-00000000x0Q-0Z6o;
	Tue, 12 May 2026 16:23:19 -0300
Date: Tue, 12 May 2026 16:23:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com,
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com,
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com,
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com,
	ynachum@amazon.com, huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com,
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v4 00/16] RDMA: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <20260512192319.GM7702@ziepe.ca>
References: <20260507125231.2950751-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507125231.2950751-1-jiri@resnulli.us>
X-Rspamd-Queue-Id: C9A945289CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20517-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 02:52:15PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> This patchset introduces a generic buffer descriptor infrastructure
> for passing memory buffers (dma-buf or user VA) to uverbs commands,
> and wires it up for CQ and QP creation in the uverbs core, efa, mlx5,
> bnxt_re and mlx4 drivers.
> 
> Instead of adding ad-hoc per-buffer UAPI attributes for each new buffer
> type, each command declares dedicated UVERBS_ATTR_UMEM attributes that
> carry one buffer descriptor each. Each descriptor specifies a buffer
> type, covering both VA and dma-buf. A consumption check ensures
> userspace and driver agree on which attributes are used.
> 
> The patchset:
> 1-2,4. Plumbing: rename ib_umem_get() to ib_umem_get_va() and re-route
>    it through the new central ib_umem_get(); no behaviour change.
> 3. Introduces the core buffer descriptor infrastructure and UAPI.
> 5. Inlines the const attr helpers so ib_core can use them.
> 6. Factors out CQ buffer umem processing into a helper.
> 7. Adds the CQ buffer UMEM attribute and driver wrappers.
> 8-11. Converts efa, mlx5, bnxt_re and mlx4 to use the new CQ helpers,
>    with drivers taking umem ownership.
> 12. Removes the legacy umem field from struct ib_cq, now that all
>    drivers use the new helpers.
> 13. Adds optional whole-QP, RQ and SQ UMEM attributes to QP creation.
> 14. Converts mlx5 QP creation to use the new attributes.
> 15-16. Adds mlx5 driver-namespace UMEM attributes for CQ and QP
>    doorbell records.

I think it is OK looking, Leon?

Jason

