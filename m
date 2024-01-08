Return-Path: <linux-rdma+bounces-554-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7047F826AFC
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 10:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 101A0B211DE
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 09:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A94A125A2;
	Mon,  8 Jan 2024 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBfDMEQd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ECC12B68;
	Mon,  8 Jan 2024 09:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E24FC433C8;
	Mon,  8 Jan 2024 09:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704707049;
	bh=01oRDd88Azw6HlR4YLwDBMSfI7It/XFdIsLRiMoD5AQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kBfDMEQdFKC/F8P/358A2qxnJu+2mDhE0e+SUexsQ+49KZMeioz65gwz/jeNC8Npl
	 hk7IdnCW/3MkkJEc26UYfuROvYl0PfS6lNB6EF8s8sGF9Wd6zPMy5gaehvDmkzUTBX
	 34N7dYzpnqAy97Lu0Po1S1YsG274dThb2WqhmGEanuUH711iyZvDbgkW9ZfgBlfnrY
	 SGsrtQy3jaMs/Mjy3dNCbClWkdQVZ+Cp/knFyFpl9rajy7LeP+nZ2TwjMAU3kn+RqU
	 cOu18R7g6XtIQWgxffcjNrspLcN3g4La+EqjjmHi/8DqH4OjXOrk9Zqc55+MiMJKtq
	 n96HcSP1X8apA==
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <d714306e-b7d7-4e89-b973-a9ff0f260c78@moroto.mountain>
References: <d714306e-b7d7-4e89-b973-a9ff0f260c78@moroto.mountain>
Subject: Re: [PATCH] RDMA/bnxt_re: Fix error code in bnxt_re_create_cq()
Message-Id: <170470704553.160127.3442999643967580359.b4-ty@kernel.org>
Date: Mon, 08 Jan 2024 11:44:05 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Mon, 08 Jan 2024 12:06:11 +0300, Dan Carpenter wrote:
> Return -ENOMEM if get_zeroed_page() fails.  Don't return success.
> 
> 

Applied, thanks!

[1/1] RDMA/bnxt_re: Fix error code in bnxt_re_create_cq()
      https://git.kernel.org/rdma/rdma/c/abdde500cdf456

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

