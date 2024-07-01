Return-Path: <linux-rdma+bounces-3586-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636E691DF75
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 14:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F36C28223D
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 12:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CD414F9F3;
	Mon,  1 Jul 2024 12:36:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBF814D701
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jul 2024 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837412; cv=none; b=XHugTqJLsDt4lGD6y9kxIotzul0NcQvLLX7dbc7eTeZJf20kBJKY9fD918QVbZ2nFTpPOQ13Win3kUupkdhI6GD9zw3sDnzNvYPPXEnKfQQgJuRk1SS8K0J+ou4W5jBwnIp3R5e4HJOlnTOyjONrN62JEObCEMWLK3c1Z6n+luo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837412; c=relaxed/simple;
	bh=fFa4xCzB5Aa1W0/GFE0BBrmbXqIKb6MfwfI5hFMSVPM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QLF/Yt+khRCGBxL6uuOwtYZu7KRhNEgdv0Hl9N1ysVuue5qa5z0QkZLSp2rC4eMjs9RJMc05PAYdOWNDhv13fFh1iEOL3PYmAms5LJQoafjppyUSgb5d15rGq0q+RF49IqTqPOFLrUoOttxsWushmf72qgLOo//ZPLyzFC/lgMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9A1C2BD10;
	Mon,  1 Jul 2024 12:36:51 +0000 (UTC)
From: Leon Romanovsky <leonro@nvidia.com>
To: leon@kernel.org, linux-rdma@vger.kernel.org, 
 Jason Gunthorpe <jgg@ziepe.ca>, Michael Margolin <mrgolin@amazon.com>
Cc: sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev, 
 Yonatan Nachum <ynachum@amazon.com>
In-Reply-To: <20240701095752.20246-1-mrgolin@amazon.com>
References: <20240701095752.20246-1-mrgolin@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Add EFA 0xefa3 PCI ID
Message-Id: <171983740850.330197.1809909798869664353.b4-ty@nvidia.com>
Date: Mon, 01 Jul 2024 15:36:48 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-13183


On Mon, 01 Jul 2024 09:57:52 +0000, Michael Margolin wrote:
> Add support for 0xefa3 devices.
> 
> 

Applied, thanks!

[1/1] RDMA/efa: Add EFA 0xefa3 PCI ID
      https://git.kernel.org/rdma/rdma/c/9e6ff3ef30417a

Best regards,
-- 
Leon Romanovsky <leonro@nvidia.com>


