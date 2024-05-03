Return-Path: <linux-rdma+bounces-2253-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DDE8BB67D
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 23:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 504A6B22359
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 21:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C37E56B76;
	Fri,  3 May 2024 21:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqcV8oJJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0243D57C8A;
	Fri,  3 May 2024 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714773490; cv=none; b=aa+uWOWWvCm3sF0KseysJtB7a0y6Ugk+tkNRMVVbxohes1ZKR4uIQJQR6jV+3mh2Azne2d3PWAAKa4uMJ5XVphUSPZtRBOxbG/YHp3kiifdKCP7uixGZtdX+O62wTCTJ93undGJOv5bonaTBlBQI6SDVlTG0GqDWpTbVg3oiq0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714773490; c=relaxed/simple;
	bh=Pmgm0glX9FkwDL+qG+ZRYjmYLShv8WqXdvSZfLM8GdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsJpqlVrazYFIZXmFgsmEByi1IqIdZA6B9c98Qkgl953MFeIPXq93esWWo39lRgdDqOJU+ISU2Ao47EZeIi0ijPIk2c6yFff03v0ltXp/n2dmNLUPHicZErF33By0yqAHmMz26xLwtrWl2EttZbnBxCoGuX/1mB7dVLj1G46J1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqcV8oJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA34C2BBFC;
	Fri,  3 May 2024 21:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714773489;
	bh=Pmgm0glX9FkwDL+qG+ZRYjmYLShv8WqXdvSZfLM8GdQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lqcV8oJJHiXbVU1Q6YInX13ctxFLeFOqEJm9imf6VFK5/YXvfMOFchud+cCllv2Qa
	 edPBUw8Vt6CfW0eeQk4Xumswr28Kvl90K0hFbK37wRrcRYX0wszi77W6pPKDT4pSGi
	 p9wvA/RSUajHXeGzJV3H2TEIZok61CQqKZAo+JoyfYKtQY7OhcanpXT1BM4UmDYQzj
	 obRL4GZFIdxWJYpFr/l1K54HdlJzZA5MYnLw8USngBFF8b8/RNEi+lU/RCfrxJ7x9Y
	 XnMQfOwm/QXJgINcjHT2cznYLaevmNJ93rO1j3NScuAdf7qTvmj0sCQ1S7kfcrdz4D
	 5rAB9FoC2DJWQ==
Date: Fri, 3 May 2024 14:58:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, tariqt@nvidia.com, saeedm@nvidia.com,
 gal@nvidia.com, nalramli@fastly.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Leon Romanovsky
 <leon@kernel.org>, "open list:MELLANOX MLX5 core VPI driver"
 <linux-rdma@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 0/1] mlx5: Add netdev-genl queue stats
Message-ID: <20240503145808.4872fbb2@kernel.org>
In-Reply-To: <ZjUwT_1SA9tF952c@LQ3V64L9R2>
References: <20240503022549.49852-1-jdamato@fastly.com>
	<c3f4f1a4-303d-4d57-ae83-ed52e5a08f69@linux.dev>
	<ZjUwT_1SA9tF952c@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 May 2024 11:43:27 -0700 Joe Damato wrote:
> 1. it includes the PTP stats that I don't include in my qstats, and/or
> 2. some other reason I don't understand

Can you add the PTP stats to the "base" values? 
I.e. inside mlx5e_get_base_stats()?

We should probably touch up the kdoc a little bit, but it sounds like
the sort of thing which would fall into the realm of "misc delta"
values:

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index c7ac4539eafc..f5d9f3ad5b66 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -59,6 +59,8 @@ struct netdev_queue_stats_tx {
  * statistics will not generally add up to the total number of events for
  * the device. The @get_base_stats callback allows filling in the delta
  * between events for currently live queues and overall device history.
+ * @get_base_stats can also be used to report any miscellaneous packets
+ * transferred outside of the main set of queues used by the networking stack.
  * When the statistics for the entire device are queried, first @get_base_stats
  * is issued to collect the delta, and then a series of per-queue callbacks.
  * Only statistics which are set in @get_base_stats will be reported


SG?

