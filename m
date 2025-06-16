Return-Path: <linux-rdma+bounces-11369-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F56CADBCB2
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 00:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8760189282E
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 22:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4D6226CE5;
	Mon, 16 Jun 2025 22:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5XN+xWu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7AD2192E4;
	Mon, 16 Jun 2025 22:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750111945; cv=none; b=AMX8DwTttr8WRKFTDT6toKHY8ZSkRUXG2yiqjegq3E40NIfL0RpVYn4BdvPOOpYwxfZhvYgaRdCcqU2LvT5qGu9+as0I0ooZThKMdh+3M9CCyKts+BSNv4xjg2y7Ba8KwKyWYWemf/1AN7+t8mp3XNjlzBtWKX/9GtT0xZeAT3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750111945; c=relaxed/simple;
	bh=3ceT7BZbCVCNTYjqfooM+q41Q7d1VC/hi+bt2AMBtnA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b31QKNC+eFfGh6sAdVq/uQpu7xQB27Z3MO+J/JrzPntk2Hu2tzrNBW/pTf+dPW4X59PsgSJmAyo7OE+4sFz5EhMbqqmRrGKxUaX2jBHqAHCx8JTESi3f67X0NQiSej9XF2OqPgfH9Nk0jF7lIPMcnFIg8X51bP0J+VThonM0ZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5XN+xWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05756C4CEEA;
	Mon, 16 Jun 2025 22:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750111944;
	bh=3ceT7BZbCVCNTYjqfooM+q41Q7d1VC/hi+bt2AMBtnA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q5XN+xWuhXCfOQcdPHsSdVRAO8wfLoy9pHfjPC0la+CwaaL2P5FesPuXTq5FoLiKw
	 ahFX5QlM/q97teeUlWRPokLCeIw6vurmLK6B1LQ4CuH7TY/8GgQ/TpEV2junSK+3gK
	 UelUh0dkDmUDzh9++nLKxeZtiOh9qee+3qqEfqFESDKqjLHjJk+RXti5eBY04sdvPo
	 jq8c/apXuokzK2HcqFZATpyYuBTly5GR9noHprYnlF8q5FkicB77KGKCay9mqFXjhk
	 r5/IYOxzZe05mUWP2ODe5hNy226g1f5hRZYdrigFZUnBiNYUfLP7ybTPcgIHVpCmdQ
	 3R0RV86OLZxAg==
Date: Mon, 16 Jun 2025 15:12:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev,
 jiri@resnulli.us, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, aleksandr.loktionov@intel.com, corbet@lwn.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 linux-doc@vger.kernel.org, Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH net-next v6 3/3] ice: add ref-sync dpll pins
Message-ID: <20250616151223.52254699@kernel.org>
In-Reply-To: <20250613200655.1712561-4-arkadiusz.kubalewski@intel.com>
References: <20250613200655.1712561-1-arkadiusz.kubalewski@intel.com>
	<20250613200655.1712561-4-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 22:06:55 +0200 Arkadiusz Kubalewski wrote:
> - rebase and align with introducation of software pins

Another conflict, probably with the other DPLL series.
One more respin, please.
-- 
pw-bot: cr

