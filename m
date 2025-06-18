Return-Path: <linux-rdma+bounces-11432-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA03ADF311
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 18:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7DB401754
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 16:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ACD2F0053;
	Wed, 18 Jun 2025 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3PwePHC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9F62ED15B;
	Wed, 18 Jun 2025 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265493; cv=none; b=fZ5opCLGTopZ30q5NEFzvq9ixZ70SzAPAx9khV4AZwirWg+gzBZQ4li8qqVTEEWqp6y4iRO26ezKSwI/RQit3SbQAx++MprGyCOxffHFo1iRCKnNlVTotU28BCqvrUEbPFR/N3/g8Srere8a7ADgMIWcxZzRJEEuOzALEixKcJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265493; c=relaxed/simple;
	bh=XMO9fKp20Q7DTaYszCjqBD1MVCHKlOCMtsj8qLUYrFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KM15dJCOkvDbFodrjbBYgYvR0h4w2GvryXwH7NNzyQym6P62eA2VVb1VtBsgUNaNXcr22ExvdSgwcr4KVtVsQtDACOCXnHzQU54kIbX14w83RLlkIvPs6VTidsC8sqsXvuWifp//vyRM9qdpNOtv6jhjPuDGMnJz2nQHXKiUyVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3PwePHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF16BC4CEE7;
	Wed, 18 Jun 2025 16:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750265492;
	bh=XMO9fKp20Q7DTaYszCjqBD1MVCHKlOCMtsj8qLUYrFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E3PwePHCrYicZteOg5yu8/BY+j2hHrTdssFE0f+Ro8l3ul8oGL9SsMfvRRiLrVkID
	 bQ9cfpAv/a+h0V0/ciauddxBFhvKcdien7r2zWbKhDQtF/bkTCfsAZxvpGsCJ+KsVK
	 0dnHZKjK6Pplnsq6l0bo4JvWa3zc+QuVUV9vxw3tqmNWKJ13prh3b1b5HHp5kIPII7
	 +G5gNulRan00ZWgmAr9NU8KezJsDvkIGVYGNVAsQui4v/T+tRJTh5EDGYdDIIzDHXi
	 BXKECJe7kb8dwmEXvK84tgn/v8cBF4cWiuRNS0bmhvKEbABz4j29UTelti9oisNAtu
	 8uIYM9W6541bg==
Date: Wed, 18 Jun 2025 17:51:27 +0100
From: Simon Horman <horms@kernel.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/smc: remove unused input parameters in
 smc_buf_get_slot
Message-ID: <20250618165127.GU1699@horms.kernel.org>
References: <20250618103342.1423913-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618103342.1423913-1-wangliang74@huawei.com>

On Wed, Jun 18, 2025 at 06:33:42PM +0800, Wang Liang wrote:
> The input parameter "compressed_bufsize" of smc_buf_get_slot is unused,
> remove it.
> 
> Signed-off-by: Wang Liang <wangliang74@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


