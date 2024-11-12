Return-Path: <linux-rdma+bounces-5947-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FA09C5B2B
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 16:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912CB1F21431
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 15:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF00200103;
	Tue, 12 Nov 2024 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzb8jB6a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1571FCF63
	for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2024 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423487; cv=none; b=KOl0qq9NBe0NlSLiFwl1Ms5g2+d+s3IIwG/OtPcqTFmL1H6CysUBQzkuKcpdewH5V5AYaOAqUhopeDL8i1Nww75jYQOow+tLlKcLxH3GlDzxaPEywAjhiw+BQHakffx2yloO89n7ItdQ3eN6l5MXKSswbXn9K0jdFauWzOMFlEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423487; c=relaxed/simple;
	bh=j5X7nnUtvzAVf45kMvUrirBocx79R5nJEitcJjgQVQc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KKqvlS1fcRf+qiL3zUJUt6yH000nB4ARz6gR1xRlSwfLEjLxIQiPvC10VQMlTdRITb4e+x927BJi9vGFS3O6zrojO36monjRrhXTnZ+/Q1WFOOYsCbDlkUWj4F4Ho5VgrhnD2A31lrz/Zn/vWSi4AY/PrwkLXujfAPt+tVx1kds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzb8jB6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C537AC4CECD;
	Tue, 12 Nov 2024 14:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423486;
	bh=j5X7nnUtvzAVf45kMvUrirBocx79R5nJEitcJjgQVQc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kzb8jB6aDHdjB3rpPWSZ/5JByx2Krrr4GvfHXlfcWsRqF20hXcU309x9nVA6xap9t
	 Zq25MwYZuaqFhzQQ7zz78fCemozPpIfWRBeis6pcEGSe0wOrxOtpDv9VbT60tBAcvb
	 iyWUDPkCxuS5OHT8Q8rGaPS4gn+JFmXvl6AMnooTV4j8XBSW+mLSqK5oo8blhKdQ4W
	 X7KD25OH6+9S0SR2Ob3r685keuqciqYp5FZbsgVsb3lmt1NdWZ8SIppXqxJkWXdawv
	 +WL2bkeI02jMqjfX4ZuUD2lLkrfCv7P5H/weBXU+jqb1M+WVUaUXzdxn8gwI493SjH
	 YtQCekAdWv/ZA==
From: Leon Romanovsky <leon@kernel.org>
To: Anumula Murali Mohan Reddy <anumula@chelsio.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, Potnuri Bharat Teja <bharat@chelsio.com>, 
 Leon Romanovsky <leon@kernel.org>
In-Reply-To: <bb9d403419b2b9566da5b8bf0761fa8377927e49.1731401658.git.leon@kernel.org>
References: <bb9d403419b2b9566da5b8bf0761fa8377927e49.1731401658.git.leon@kernel.org>
Subject: Re: [PATCH rdma-rc] Revert "RDMA/core: Fix ENODEV error for iWARP
 test over vlan"
Message-Id: <173142348263.452426.16235928135457664597.b4-ty@kernel.org>
Date: Tue, 12 Nov 2024 09:58:02 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 12 Nov 2024 10:56:26 +0200, Leon Romanovsky wrote:
> The citied commit in Fixes line caused to regression for udaddy [1]
> application. It doesn't work over VLANs anymore.
> 
> Client:
>   ifconfig eth2 1.1.1.1
>   ip link add link eth2 name p0.3597 type vlan protocol 802.1Q id 3597
>   ip link set dev p0.3597 up
>   ip addr add 2.2.2.2/16 dev p0.3597
>   udaddy -S 847 -C 220 -c 2 -t 0 -s 2.2.2.3 -b 2.2.2.2
> 
> [...]

Applied, thanks!

[1/1] Revert "RDMA/core: Fix ENODEV error for iWARP test over vlan"
      https://git.kernel.org/rdma/rdma/c/6abe2a90808192

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


