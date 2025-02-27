Return-Path: <linux-rdma+bounces-8178-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B87A47337
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 03:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3F4188E2AD
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 02:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3603A183098;
	Thu, 27 Feb 2025 02:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dm72vgPE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D430542A8F;
	Thu, 27 Feb 2025 02:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740624793; cv=none; b=HEbK25Qxa9HmlqXivGTX49jSMiNOwrGDPEiUTYoSx1U32lB9o1wTKcsvdw3vYJaq75oX+XDg/4o/jwxeoEsfVgnJ9VKYc6vlxcQbMl/JLn9duZkrXNjlXwDMutpBOeXVjQaQ/oRZ8ExYeslzc6vwLS7WhmxnuBzpcgNdcgdLBJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740624793; c=relaxed/simple;
	bh=HQn3kFyIyqvH4epxW53yWGH/1SfObMrTDpgmVoEPrqk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/u3G8OWXwbYMw3Phyc8i6lnhjuJVNucgTIPRFIUeqDgTh+1iqtPore8PhK/zo96Dgb0+/gVQxlNT5L+iRKcN+b8YvBRQqvYwxo/CVZcylVKqwmW6mrf9oEFgG2iIoyMVTR7Izr2jGTpJQdU/CvQhPuSgj7Fmzyx4xw33+Kvn3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dm72vgPE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49E4C4CEE2;
	Thu, 27 Feb 2025 02:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740624792;
	bh=HQn3kFyIyqvH4epxW53yWGH/1SfObMrTDpgmVoEPrqk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dm72vgPEzDhxvXsgbDuBab5q4/HSlANu+hcSMiVek6Dli7PMo6Ut2OyQ8JRZJId/+
	 l9oINZuu8w9LBLepUw0hj3uA40e2waZT4+0dFHGLsgMqR54gX7T51FxPZpJKI5Ah19
	 NnQctRX3OJOkL63XXn+CXkEYC7GC1f8N1X5t5kMTgD8TQeBz0F24EjgQcRA+rSB2JZ
	 bfau5kfi0old55RcolHdlHhebS1OpD0lTTOUMu1O8UR7EhOa0evwNThttf4EIuXmef
	 oRfDDLCQ47Kl7rRQI//1SALuvxXiDDUJnqYaB/Gls5xgg1NVOzjv2f9+Nbxp2DS4NE
	 JSoRWsGM5jn+Q==
Date: Wed, 26 Feb 2025 18:53:10 -0800
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
Message-ID: <20250226185310.42305482@kernel.org>
In-Reply-To: <wgbtvsogtf4wgxyz7q4i6etcvlvk6oi3xyckie2f7mwb3gyrl4@m7ybivypoojl>
References: <20250213180134.323929-1-tariqt@nvidia.com>
	<20250213180134.323929-4-tariqt@nvidia.com>
	<ieeem2dc5mifpj2t45wnruzxmo4cp35mbvrnsgkebsqpmxj5ib@hn7gphf6io7x>
	<20250218182130.757cc582@kernel.org>
	<qaznnl77zg24zh72axtv7vhbfdbxnzmr73bqr7qir5wu2r6n52@ob25uqzyxytm>
	<20250225174005.189f048d@kernel.org>
	<wgbtvsogtf4wgxyz7q4i6etcvlvk6oi3xyckie2f7mwb3gyrl4@m7ybivypoojl>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 15:44:35 +0100 Jiri Pirko wrote:
> > Why would there still be PF instances? I'm not suggesting that you
> > create a hierarchy of instances.  
> 
> I'm not sure how you imagine getting rid of them. One PCI PF
> instantiates one devlink now. There are lots of configuration (e.g. params)
> that is per-PF. You need this instance for that, how else would you do
> per-PF things on shared ASIC instance?

There are per-PF ports, right?

> Creating SFs is per-PF operation for example. I didn't to thorough
> analysis, but I'm sure there are couple of per-PF things like these.

Seems like adding a port attribute to SF creation would be a much
smaller extension than adding a layer of objects.

> Also not breaking the existing users may be an argument to keep per-PF
> instances.

We're talking about multi-PF devices only. Besides pretty sure we 
moved multiple params and health reporters to be per port, so IDK 
what changed now.

