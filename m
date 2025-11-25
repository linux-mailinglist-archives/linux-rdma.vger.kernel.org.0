Return-Path: <linux-rdma+bounces-14739-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CB9C83216
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 03:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E783F4E65DF
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 02:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0024E1EDA0F;
	Tue, 25 Nov 2025 02:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDMMBRgH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25691E9906;
	Tue, 25 Nov 2025 02:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764038614; cv=none; b=hprzfou57+2lfNCY3peKngWzRfcajEUabUzR2B23ArgXj7H1Nta2PfFKyQtL1MVg0CqdZ5SwulCTZvT92RXXUnsKVPJiVz+qp9wX/FjbKKt/Uw7xCd8zaftypjT3dpQsJ0PQXwSI3GDXs2NOpHh0uWYbxCchPlKeIp4BDe77sQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764038614; c=relaxed/simple;
	bh=f69EJsOFiMvJuO1H+Aq5rxAHuqwikNpa7xTqrPpABbs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kibq8Vx5ZfmXm5Hn6dRi63swegY0+RyJYfYAgV8HhOnKSMtZXM64DELevrQSMd6djlE9wVcS3i5oPktK4uynuXVTGbVCT0UL7Xn8UCyC2fztNnASPnVtgc4h5KlNeWcm0OvgZFf9fZvYezJRyLOejUzjSVAofw8/w6Bdt+Y5myw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDMMBRgH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639D4C4CEF1;
	Tue, 25 Nov 2025 02:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764038614;
	bh=f69EJsOFiMvJuO1H+Aq5rxAHuqwikNpa7xTqrPpABbs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EDMMBRgHziFCqo5ZJm0PMdFLUtkwJTiYL6z7VrwLUN/0KtvEbiWVsmUDHcTT/1LMP
	 bBa79kc9u1ZExb7zAiWZWRJVU485StvqJIHFfbl2FSeuj5Vpc1S6bH8MgB9NWOk32L
	 /+cFETndNCvbt/EcESbC45JanuDAOzME941LIb9voxOpcUIQClx38WtmqK9dvDW8iY
	 TjjgUEYH3paePotW0IvOuJQ3e5O1Bg3D8JG7jbU8uycuYr2hMNJdVSkzB6Fbn4Yyns
	 4gdsuygFEIVsAm8dliLn76dD5t5budwqPyl17wdzvNknU1m4ygwTNI2pUGcX3F92Hy
	 L+kLHUJzQqp3Q==
Date: Mon, 24 Nov 2025 18:43:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Donald Hunter
 <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
 <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 00/14] devlink and mlx5: Support cross-function
 rate scheduling
Message-ID: <20251124184332.317a652f@kernel.org>
In-Reply-To: <f828d5d5-6ba3-4e9c-a7fb-3a0193f7e9bf@gmail.com>
References: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
	<20251120193942.51832b96@kernel.org>
	<f828d5d5-6ba3-4e9c-a7fb-3a0193f7e9bf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Nov 2025 08:57:58 +0200 Tariq Toukan wrote:
> I submitted the code before my weekend as we have a gap of ~1.5 working 
> days (timezones + Friday). It could be utilized for collecting feedback 
> on the proposed solution, or even get it accepted.

Makes sense, our recommendation is to throw in an RFC in the subjects
in this case. Saves the back and forth.

