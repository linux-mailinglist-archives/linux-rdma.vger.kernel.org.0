Return-Path: <linux-rdma+bounces-18186-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKg5HaEquGnhZgEAu9opvQ
	(envelope-from <linux-rdma+bounces-18186-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 17:06:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD3729D0E0
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 17:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B69BF302C901
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 16:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA093254A8;
	Mon, 16 Mar 2026 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxCyrJ6+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4569C238D54
	for <linux-rdma@vger.kernel.org>; Mon, 16 Mar 2026 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676928; cv=none; b=WmAvyi2apd2wgJ7qXW6OgnfZ2z6NGUNjtIOcfeQwQfVzmbjMCUZbGT1lfduc3oCc2TTPZKyxgaBqsAwYmOlOfFH4FuVX4MEXEeVaqNXoCMP+Hq0pWI0XuvV63RYe6BWPOAP4Akdj1zG8iqrIBnK1yzUDt2S70UFypHsk1EQYrbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676928; c=relaxed/simple;
	bh=TBpV7Ngzs+EAaLE1jiLPFDRnbBZQmKeP/ASRqEbGPpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z500wCFLJ5WzQAZAyoPiPy4CXBp9jBGwxXWxl3bpY6lqU8Dj5JK2CUaHRDWK2KaxQCn9I7vsZP7Gf0cLDQeX9fzmRCRqehFzeGElHwVUQYTBnS3qtPrPLfLDixnwBJXsrKrrg/d+aZuZVagqiyVHfyTtS37lRjFqXNL174ilw34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxCyrJ6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C35AC19421;
	Mon, 16 Mar 2026 16:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773676928;
	bh=TBpV7Ngzs+EAaLE1jiLPFDRnbBZQmKeP/ASRqEbGPpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jxCyrJ6+2UTHqgCdXiIWyk9zjG16X3Xq/2Wi3wqXjnas0XRPrS0aSL1z9c1LFkVFA
	 8W4U6g13LyCgba7O7GRc9gRC5H0EhI9mjwZWg5FnISlXQMjdKDDttMl/lBcxjdV5RM
	 kVhuhG2tzYLr5LERE7okIMX4Utu5DyOYMQxObKhIJYdm2eHl7Ygud39nHCihJbA/nr
	 64M4r7CxjFlqV9/khvcAZ0zEW169dxHbhuNqyb3HDeQVhDkFfSVk258xN419QgkwY3
	 l94y5MEXH8undn8WYXPw79pV/6VuuGK81yhe8cjJ5i+5ZGOrRYfDAtgYlpXmP4EuvD
	 g4HgU4zEBffDg==
Date: Mon, 16 Mar 2026 18:02:03 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: jgg@ziepe.ca,
	Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
	Douglas Miller <doug.miller@cornelisnetworks.com>,
	Dean Luick <dean.luick@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next resend 00/24] Migrate to hfi2 driver
Message-ID: <20260316160203.GE61385@unreal>
References: <177325138778.57064.8330693913074464417.stgit@awdrv-04.cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177325138778.57064.8330693913074464417.stgit@awdrv-04.cornelisnetworks.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18186-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: DAD3729D0E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 01:53:45PM -0400, Dennis Dalessandro wrote:
> Apologies for re-sending but even my cover letter bounced so no hope of
> getting thigns to thread properly. Re-sending the whole series.
> 
> While sharing similar bones, the chip for the Cornelis Networks next
> generation fabric technology has some fundamental differences that
> resulted in a near complete re-write of the driver. It also does not
> use the private cdev interface that the hfi1 driver exposes. After
> discussing this with the RDMA maintainers we have decided to go with
> the approach of moving to a new driver and declaring hfi1 obsolete.

We didn't agree to take problematic parts of hfi1 and put them in hfi2.

Thanks

