Return-Path: <linux-rdma+bounces-10127-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3B0AAF00E
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 02:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F431B677FD
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 00:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B19D13635C;
	Thu,  8 May 2025 00:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuDieyUi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD4F28F4;
	Thu,  8 May 2025 00:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746665231; cv=none; b=ICsM8lApsuaknnHYt3fNjmEU6JFWyH0RT4+lBhRVPJppRjn8ei+ivQ6iObsPwHcqyG07Bq8LQobYOw9NvN5vTgo6GWR2xvZEFB73KurXxRQocx0+8J28dxJhAIEv6vb3+fzq//8Xp6XeDIUoqgJYXG9xBXt4yPWrI2VOlorDvpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746665231; c=relaxed/simple;
	bh=u0s6dUMqXaUHGlcrUs1yTnxCrmADeAs8uJEdCUa6cn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M7nxT+KRC2VrOR/YFpRtYR3MzOVPDAHMT9bV5svLwycgnq4KVaHCt1XW1kvFV1qwC5KlmTCi0Vk9pRMsVL+K/L+wcOck+/b9jSWrLduMp9BEep3Faj8VLJTh+oe0z1i5LTOxFBSJFFNQeMJwVp0PZdsgES6XQ3YMOLBIHPXC3rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuDieyUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EA0C4CEE2;
	Thu,  8 May 2025 00:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746665231;
	bh=u0s6dUMqXaUHGlcrUs1yTnxCrmADeAs8uJEdCUa6cn4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CuDieyUiM8oKt7l4Kdbwwrd9c4nOZzjrs13TRR0GrUfAJ7oWFxSGZZppytexK8mxL
	 fY5Ol3aUCCcdHikf9a4VLMiIWdsPPJLBd28teLcKmPihLFcDC9q6f/jQTAbmdCVV+e
	 Z0tGwaI/YlpcfgOiHn/8zMTch5IHEdXAlGlPiRIS7v5uNGtoovC5Uq30FRIenT/Exg
	 60tkh/3bzG/UKBPpdgpUT5hESkXx6g6AKpbVmzha7Ua2Ebp64SwD9sb6d5bHJK3OFT
	 NOT7Wd9QvwllqOAkVWIRvvQz3rrJi43NxHjfD3Iw+0fp5UCtGUn9VK1fJ1Zbyg+/w4
	 YZhyk/q/D/6bA==
Date: Wed, 7 May 2025 17:47:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, Jiri Pirko <jiri@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>, Donald Hunter
 <donald.hunter@gmail.com>, "Jiri Pirko" <jiri@resnulli.us>, Jonathan Corbet
 <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>
Subject: Re: [PATCH net-next V8 1/5] devlink: Extend devlink rate API with
 traffic classes bandwidth management
Message-ID: <20250507174709.5790852a@kernel.org>
In-Reply-To: <1746530803-450152-2-git-send-email-tariqt@nvidia.com>
References: <1746530803-450152-1-git-send-email-tariqt@nvidia.com>
	<1746530803-450152-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 May 2025 14:26:39 +0300 Tariq Toukan wrote:
> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
> index bd9726269b4f..64b6aaa02047 100644
> --- a/Documentation/netlink/specs/devlink.yaml
> +++ b/Documentation/netlink/specs/devlink.yaml
> @@ -202,6 +202,11 @@ definitions:
>          name: exception
>        -
>          name: control
> +  -
> +    name:  devlink-rate-tc-index-max
> +    header: net/devlink.h
> +    type: const
> +    value: 7

The spec is for uAPI, but you're declaring a value which is only known
to the kernel.. What is the thinking here? It can't stay as is, it
breaks the build for user space, since there is no user space header
under net/devlink.h
-- 
pw-bot: cr

