Return-Path: <linux-rdma+bounces-12643-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59152B1FA9F
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 16:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C914E7A7803
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 14:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C2F264F8A;
	Sun, 10 Aug 2025 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="npWY9WRg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ABA29CEB;
	Sun, 10 Aug 2025 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754837643; cv=none; b=T5zPi7TRaV2+xNdFRXtqR5APOb6PipdeiYHV9ybThFptO9UasAIeXhDgmmiE//7Q5mE6JDma13TYbePgOvEPqn7A9G7eSbJWZuBV4U/tRoFlrWTkSNwgCZ/bST6BeizKOik4x8xFoB8JNvRrZxoEY3bosLEtM2AkxhQ4Av3DSNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754837643; c=relaxed/simple;
	bh=wZR66eV4Dl1HYEn8CVdhPmAggpvvY/TK+plC7HTX40I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/WmU8Cu52KZLkkZFGHpVxQJuhVDtfzsgl27dOnkv6ZRkdSuU/mQ/Xq1jZb3ZHiTLH1a5o6iG8TRSyzfnpTcIQJQ7Gido8i+Mdqt/PraUN0IdUUy26Dj4lEB/B3n0YJoezDSDdWRJgNOgx/fdJvqC+wUGU24En40AhxaI0mBTSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=npWY9WRg; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754837629; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=wZR66eV4Dl1HYEn8CVdhPmAggpvvY/TK+plC7HTX40I=;
	b=npWY9WRg7o7tEBZFE4xYRDNCWu3J29oDzHKnRus3Tg+bIaZMeE2/mQ7v7EeBcY2UcNxxe2Q1MrE3TnWFcPyqT0mmqz74XrWyo+h4uEVkT+MBtN0mbpi479iRsiLrcf49WM7+TjFPFv3NgfnCrCWiwoqZ8FixwfnDWUtqbcRwfDo=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WlMY.5p_1754837627 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 10 Aug 2025 22:53:48 +0800
Date: Sun, 10 Aug 2025 22:53:47 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, Halil Pasic <pasic@linux.ibm.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [RFC net-next 10/17] net/dibs: Define dibs_client_ops and
 dibs_dev_ops
Message-ID: <aJiye8W_giWiWWpI@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
 <20250806154122.3413330-11-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806154122.3413330-11-wintera@linux.ibm.com>

On 2025-08-06 17:41:15, Alexandra Winter wrote:
>Move the device add() and remove() functions from ism_client to
>dibs_client_ops and call add_dev()/del_dev() for ism devices and
>dibs_loopback devices. dibs_client_ops->add_dev() = smcd_register_dev() for
>the smc_dibs_client. This is the first step to handle ism and loopback
>devices alike (as dibs devices) in the smc dibs client.
>
>Define dibs_dev->ops and move smcd_ops->get_chid to
>dibs_dev_ops->get_fabric_id() for ism and loopback devices. See below for
>why this needs to be in the same patch as dibs_client_ops->add_dev().
>
>The following changes contain intermediate steps, that will be obsoleted by
>follow-on patches, once more functionality has been moved to dibs:
>
>Use different smcd_ops and max_dmbs for ism and loopback. Follow-on patches
>will change SMC-D to directly use dibs_ops instead of smcd_ops.
>
>In smcd_register_dev() it is now necessary to identify a dibs_loopback
>device before smcd_dev and smcd_ops->get_chid() are available. So provide
>dibs_dev_ops->get_fabric_id() in this patch and evaluate it in
>smc_ism_is_loopback().
>
>Call smc_loopback_init() in smcd_register_dev() and call
>smc_loopback_exit() in smcd_unregister_dev() to handle the functionality
>that is still in smc_loopback. Follow-on patches will move all smc_loopback
>code to dibs_loopback.
>
>In smcd_unregister_dev() use only ism device name, this will be replaced by
>dibs device name by a follow-on patch.
>
>End of changes with intermediate parts.
>
>Allocate an smcd event workqueue for all dibs devices, although
>dibs_loopback does not generate events.
>
>Use kernel memory instead of devres memory for smcd_dev and smcd->conn.
>Since commit a72178cfe855 ("net/smc: Fix dependency of SMC on ISM") an ism
>device and its driver can have a longer lifetime than the smc module, so
>smc should not rely on devres to free its resources [1]. It is now the
>responsibility of the smc client to free smcd and smcd->conn for all dibs
>devices, ism devices as well as loopback. Call client->ops->del_dev() for
>all existing dibs devices in dibs_unregister_client(), so all device
>related structures can be freed in the client.
>
>When dibs_unregister_client() is called in the context of smc_exit() or
>smc_core_reboot_event(), these functions have already called
>smc_lgrs_shutdown() which calls smc_smcd_terminate_all(smcd) and sets
>going_away. This is done a second time in smcd_unregister_dev(). This is
>analogous to how smcr is handled in these functions, by calling first
>smc_lgrs_shutdown() and then smc_ib_unregister_client() >
>smc_ib_remove_dev(), so leave it that way. It may be worth investigating,
>whether smc_lgrs_shutdown() is still required or useful.
>
>Remove CONFIG_SMC_LO. CONFIG_DIBS_LO now controls whether a dibs loopback
>device exists or not.
>
>Link: https://www.kernel.org/doc/Documentation/driver-model/devres.txt [1]
>Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
>Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>

Hi Winter,

I feel a bit hard for me to review the code especially with so many
intermediate parts. I may need more time to review these.

Seperate such a big refine patch is hard. Maybe put the
small parts in the front and the final one in the last to reduce
the intermediate part as much as possible ? I'm not sure.

Best regards,
Dust


