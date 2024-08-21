Return-Path: <linux-rdma+bounces-4476-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE17295A87C
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 01:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE1C283C42
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 23:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153BA17C22F;
	Wed, 21 Aug 2024 23:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pef1j/RS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15B417DE06;
	Wed, 21 Aug 2024 23:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724283997; cv=none; b=MLJ0VWCCcAr7G5kzszQJ4SqxXLNkJnnnnaPDTf8vk9BiHFpIECYsqPyJrHTmgA96woTy6J0kyOf0pKuLRBAzw8Itq6/wLKaEszbMSc99W1SW0CkJGw6CWZsENC7ycc8UunQCxL5RPYlzx8UBElUiaV8fkOlcCAh6HKQMyVIIPfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724283997; c=relaxed/simple;
	bh=pHeCE0JVeBpqF0rxOABye6Px2xKWYIb6b4GGiS88vb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sbWngB36Wqcmz/mUFYqFEnsaqbzC8Q12F2mD97I4kSWsH9NCR0Km75IcS/QDATypr+qJUmtV/nx2MVUzCcPktED5wVTwpU4O3svRBENVzGT24c1PAFc8g/3rEpvCBDnXluAB9AgEd86c01XbliifdrYX+PJRGc51bzdUxJTqunM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pef1j/RS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F06C32781;
	Wed, 21 Aug 2024 23:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724283997;
	bh=pHeCE0JVeBpqF0rxOABye6Px2xKWYIb6b4GGiS88vb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pef1j/RSk0THDa3D2Kuhbl0KAsA3FtZRxKx4IUjmzzgjCqLnmKSjIXqPorKVC3aKU
	 jxi4ZbI0rsUSHj2YNvHPwO64w5LjqXm6IyLYqtnbFlAQ8hGXUk0tRvb7KsxCG0Uol0
	 mJB08HccrDyJU7lU+mKZFJi9Bj42snSFU7Jap3yC6KyJdyidgEI/rl/Mj7lcgHoyX4
	 xnJdBetz3JOsPZtVbnXJWpCyJwnmQgfVEKKOFcRjKytqUBxvD6LjFOzwXBf0uWob3b
	 gLr5w6vompltmD2ktuXjInBfWSQaurMumM8RR3P8g8pQB59rb5F2CZW8/2pdGoqsvX
	 MsUNgHjqZvjlw==
Date: Wed, 21 Aug 2024 16:46:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jan Karcher <jaka@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
 wenjia@linux.ibm.com, wintera@linux.ibm.com, guwen@linux.alibaba.com,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, tonylu@linux.alibaba.com, pabeni@redhat.com,
 edumazet@google.com
Subject: Re: [PATCH net-next v2] net/smc: add sysctl for smc_limit_hs
Message-ID: <20240821164636.555dfe9f@kernel.org>
In-Reply-To: <abd79f44-aed2-4e01-a7f8-7d806f5bc755@linux.ibm.com>
References: <1724207797-79030-1-git-send-email-alibuda@linux.alibaba.com>
	<abd79f44-aed2-4e01-a7f8-7d806f5bc755@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 10:03:49 +0200 Jan Karcher wrote:
> If so, why is it inconvenient to use netlink in containers?
> Can this be changed?

Adding a YAML spec for the link to make it easily accessible from
C/C++/Python applications seems like a better direction.

