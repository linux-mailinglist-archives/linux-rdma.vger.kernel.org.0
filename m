Return-Path: <linux-rdma+bounces-8347-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DEBA4F204
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 01:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD70188D473
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 00:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38776A32;
	Wed,  5 Mar 2025 00:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhrxWi5J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C5E17588;
	Wed,  5 Mar 2025 00:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133059; cv=none; b=nAQe8HAOM+gyFY2tfnxU/VvTFVIPRwjzAVKMTDovbaLAv0/hu+EtCvuqb2R2SL7k+jm7GL7JrsO72HlcRfMBNi47cwjSW2E9t5eYdzRhdRUQwoS0pCFSZi7Wjo3MzzgAKlB/+9UCR1Ni6zaodcErTIam1pCGoSe3tDlAX03ayn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133059; c=relaxed/simple;
	bh=grQBFSBKN9sa0z1XG6gzVBEgwAxLz+1xaokbH7gi8n0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Enw1KlR36CgKrj1EtfrdDSWWstvtrB54WJ7GcLNPdVr0Ii8mNtCOUltSdBewkMnAZQPnjCWdE8cv8FI8pgedLOPkatvrVXyi7zgc5SpMep996djcLfBY0+ORJTSqSD9v3u18fV1gotOuFJkGwEZ/3i2Eb0Y4TpmaWkc88doyIgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhrxWi5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618BAC4CEE5;
	Wed,  5 Mar 2025 00:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741133055;
	bh=grQBFSBKN9sa0z1XG6gzVBEgwAxLz+1xaokbH7gi8n0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bhrxWi5JG1ax6wwFXMGsHNI7lc46kpaHJTG8DIQHH0M7VeYKNu2iHg7ulE5SVtX5C
	 4kuMDsDi7yPkPYjy5F77pUlEBActgFmxcDuaeU+QDGn46K32jH3Z9ANX18LOO+Cwtn
	 Kko7xM4DFQH1HL4TNsrKHtFuxhjk8auhTAWAWtY5njuPN8tqRyCYlBCvhkQ6aJjdeQ
	 Rn8ugUxvS8fbcTiUo6ULxr4YKDvmmZC3jqHRDEinG2zOgEsmA7lDCN3vudOnOKy/jO
	 hHA8lNbYzx42QTWK9fsfRcnha6Av9DS0gkpsBb2n3ZQ/P9SluHjpe9d6DbnGe9OPwe
	 2FnrrZjEz5M2g==
Date: Tue, 4 Mar 2025 16:04:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Jiri Pirko
 <jiri@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran
 <cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 03/10] devlink: Serialize access to rate
 domains
Message-ID: <20250304160412.50e5b6b8@kernel.org>
In-Reply-To: <ytupptfmds5nptspek6qvraotyzrky3gzjhzkuvt7magplva4f@dpusiuluch3a>
References: <20250213180134.323929-1-tariqt@nvidia.com>
	<20250213180134.323929-4-tariqt@nvidia.com>
	<ieeem2dc5mifpj2t45wnruzxmo4cp35mbvrnsgkebsqpmxj5ib@hn7gphf6io7x>
	<20250218182130.757cc582@kernel.org>
	<qaznnl77zg24zh72axtv7vhbfdbxnzmr73bqr7qir5wu2r6n52@ob25uqzyxytm>
	<20250225174005.189f048d@kernel.org>
	<wgbtvsogtf4wgxyz7q4i6etcvlvk6oi3xyckie2f7mwb3gyrl4@m7ybivypoojl>
	<20250226185310.42305482@kernel.org>
	<kmjgcuyao7a7zb2u4554rj724ucpd2xqmf5yru4spdqim7zafk@2ry67hbehjgx>
	<20250303140623.5df9f990@kernel.org>
	<ytupptfmds5nptspek6qvraotyzrky3gzjhzkuvt7magplva4f@dpusiuluch3a>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Mar 2025 14:11:40 +0100 Jiri Pirko wrote:
> Mon, Mar 03, 2025 at 11:06:23PM +0100, kuba@kernel.org wrote:
> >On Thu, 27 Feb 2025 13:22:25 +0100 Jiri Pirko wrote:  
> >> Depends. On normal host sr-iov, no. On smartnic where you have PF in
> >> host, yes.  
> >
> >Yet another "great choice" in mlx5 other drivers have foreseen
> >problems with and avoided.  
> 
> What do you mean? How else to model it? Do you suggest having PF devlink
> port for the PF that instantiates? That would sound like Uroboros to me.

I reckon it was always more obvious to those of us working on
NPU-derived devices, to which a PCIe port is just a PCIe port,
with no PCIe<>MAC "pipeline" to speak of.

The reason why having the "PF port" is a good idea is exactly
why we're having this conversation. If you don't you'll assign
to the global scope attributes which are really just port attributes.

> >> Looks like pretty much all current NICs are multi-PFs, aren't they?  
> >
> >Not in a way which requires cross-port state sharing, no.
> >You should know this.  
> 
> This is not about cross-port state sharing. This is about per-PF
> configuration. What am I missing?

Maybe we lost the thread of the conversation.. :)
I'm looking at the next patch in this series and it says:

  devlink: Introduce shared rate domains

  The underlying idea is modeling a piece of hardware which:
  1. Exposes multiple functions as separate devlink objects.
  2. Is capable of instantiating a transmit scheduling tree spanning
     multiple functions.

  Modeling this requires devlink rate nodes with parents across other
  devlink objects.

Are these domains are not cross port?

