Return-Path: <linux-rdma+bounces-315-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4954A808CF8
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 17:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2711C20B15
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 16:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1CE46B95;
	Thu,  7 Dec 2023 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfS/iD0Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A1946B82;
	Thu,  7 Dec 2023 16:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692A3C433C7;
	Thu,  7 Dec 2023 16:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701965704;
	bh=MOEuOWnQ7iJjzsou/brhCZLRq2Q1F1WBC0eit+b83AI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=EfS/iD0YEjiR9YGMWCKAaiQfo4bUkvuBYv+oGfmqOV256nDlIhOk8KeH6iUHNSPAj
	 m5zqxoaRzm5lM3+qGrNmzzRug9RYeCpfAGEidyiwyNuv+/qOruiZWy7eBrvlA8NwK/
	 6N3xhmnTjD6XK5Ytu9k9uN5ft/ntCocvuh+NFFpre2pAul0FNsq7rayOWGByKa9t3t
	 AkzATgTEgLaif/A3nQ6J/Qv2FX3hb0hwpCHZbcyoYWfJb+kSACfvI/NHbE3n3IvFeb
	 8qaYQqzngQ7dyzDEDOX9+U25JgYaqXC276utFm2iFwVEDHCWyhdzRALuyYuotjNZvn
	 tC8kaOBSUV7UQ==
Message-ID: <89d3b24c-2f04-4793-9f7b-8818b320c372@kernel.org>
Date: Thu, 7 Dec 2023 09:15:03 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v5 0/7] RDMA/rxe: Make multicast work
Content-Language: en-US
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Bob Pearson <rpearsonhpe@gmail.com>,
 jgg@nvidia.com, linux-rdma@vger.kernel.org,
 "davem@davemloft.net" <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20231205002322.10143-1-rpearsonhpe@gmail.com>
 <9d5f532a-9ea1-42be-8628-4acb060753b3@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <9d5f532a-9ea1-42be-8628-4acb060753b3@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/4/23 10:50 PM, Zhu Yanjun wrote:
> Add  David S. Miller and  David Ahern.
> 
> They are the maintainers in netdev and very familiar with mcast.
> 

I am nowhere close to being an expert on multicast, but many members of
the netdev community are. This set seems to be refactoring rxe code vs
new use of Linux networking stack. If there is something specific,
please Cc netdev on the entire patch set with a request in the cover
letter for specific reviews of individual patches.

