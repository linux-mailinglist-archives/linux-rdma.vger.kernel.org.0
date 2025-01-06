Return-Path: <linux-rdma+bounces-6838-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884FBA02691
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 14:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DA8F3A446E
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 13:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6444414A605;
	Mon,  6 Jan 2025 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlpIUt2d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F882BAEC
	for <linux-rdma@vger.kernel.org>; Mon,  6 Jan 2025 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736170165; cv=none; b=fqP9Ls0psKt+7LdJB1NhG/OnZxlzmbk8rtfNAApLHPJLRqyfvyiVdTA2NfoHA/hX/+gY5KLC3uSiZc/NYWiSyDrGzVum+nCR3nlYg3sClBn78MZUYEUs/Br5m4DRmRDL5XWS11Y1XjuEaNZ1tOEIv4Ee6ZCQjYbOwHBThuVfBtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736170165; c=relaxed/simple;
	bh=l3xBlSCkrrsT9Ul5Ow91SM4fF+K7Xfr5eDe8gi5wzmg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TvzcSv7wZhxPbhXfQLXOmja2N1UqqhjxZeClWV4oovtyiEq8nx7jP2ml8i+NtGeD7mzR9o2CgXkQNw2z8EyQDDAZycN7Hq5xb0415NxQvo8Gt3YNN8RoUppHJQ1Tkmjr9GGxEmfGcojnKLBl5nUov7d9+lPg8t20v1ubsys4CHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlpIUt2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3CDC4CED2;
	Mon,  6 Jan 2025 13:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736170164;
	bh=l3xBlSCkrrsT9Ul5Ow91SM4fF+K7Xfr5eDe8gi5wzmg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JlpIUt2dhRXzgBRx75yJ1SK9IhT6C3I8vCsJqxqq1lE0es3OWbVBCEa+jmMxYgASJ
	 0hGhHXjPvTBjqKJdi9SN21D0S50M1IOeSrib3pq7Wy/vqnt7WMsZkpNUiwVBkcFd/l
	 MQJ9U0v7MvGhc1nrWPT6ftbqvWD9SRKTcjEBwtNv8LffYILdG5R6lhWIqAtBBJ8ril
	 xaNsH269HLYYQxPO+pLKH3BP44DWrsjOqruTWu5E355eIyioX+P5Vf4FiENKb4pLbJ
	 v1zC1IEmuTc9iwNa9xnXR27uStWnrnHMTFbiDBH7gUIcbs0POkh9AdjjGFM/NzwmQg
	 1M/H7QdEZpmRQ==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 ynachum@amazon.com
Cc: sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev, 
 Daniel Kranzdorf <dkkranzd@amazon.com>, 
 Michael Margolin <mrgolin@amazon.com>
In-Reply-To: <20250105131421.29030-1-ynachum@amazon.com>
References: <20250105131421.29030-1-ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Align interrupt related fields to
 same type
Message-Id: <173617016089.510269.17442025205491886347.b4-ty@kernel.org>
Date: Mon, 06 Jan 2025 08:29:20 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sun, 05 Jan 2025 13:14:21 +0000, ynachum@amazon.com wrote:
> There is a lot of implicit casting of interrupt related fields. Use
> u32 as common type since this is what the device use as type for max
> supported EQs and what IB core expects in num_comp_vectors field.
> 
> 

Applied, thanks!

[1/1] RDMA/efa: Align interrupt related fields to same type
      https://git.kernel.org/rdma/rdma/c/802a9f8792c4b4

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


