Return-Path: <linux-rdma+bounces-880-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24165848C82
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Feb 2024 10:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5591282C15
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Feb 2024 09:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A95D1802B;
	Sun,  4 Feb 2024 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBm3PnpO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5E618AF9
	for <linux-rdma@vger.kernel.org>; Sun,  4 Feb 2024 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707039494; cv=none; b=F7UZmW0Yar1B/3bxl9w8c4moTNLauznA8YDaf0DwHoKPQrMMECCra2A78rTsIXEnRR3u9LJ9KUx1FuyTfi3SoLO+RXfVhEB2NF8lyzvmPZPXUG1guVM/s3WItQqdnF2XUxwIOxNKrdqeQdDW/dnGMw07mclIy5GGc5/qE86eRQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707039494; c=relaxed/simple;
	bh=9eh3OMP4w+UbMfvEfjLUJeCI9GeWsell8XwJpVUU8rE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dFRvvL1ALGww87FTDiu2zzYHx3PJjmIHOayt5gH9sGLWh1/nvwEyVuxGR4QlFemGsmCXI6nKL4ryECUZRbA6SLKHVGOysTcwJRr7Em53BH6fo+oFqxgkd6eg/f7nVnRvxyOiNgT9A0oppf4Eev3CWDYEvzFY1NPEp2u0WYF/TNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBm3PnpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DEEC433F1;
	Sun,  4 Feb 2024 09:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707039493;
	bh=9eh3OMP4w+UbMfvEfjLUJeCI9GeWsell8XwJpVUU8rE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YBm3PnpOAAhWajkJk9S4i2hTBekIT/ArFh7SWXm/GL9RPWwD/LkEUDAWURaDO39MV
	 SJ2WX6T3XJqY1CB41Ul9l7xnpIBVuk9Tvpnkkxi+/+PlUBn903q4z0JfM6k0lOLlrG
	 7i9EGzOGnchmDmSfeSsxN3e5jKIRp/fZKreiVJLIHqlckBigqDNVQM8H57MNjj4S/+
	 wGXoQvJzMN8nnn+Ak2I5yUu87Z6sTMI1cLfN1PBQwIgdU+TG7KEwUjiSdnL4450RIo
	 dGEdSrzENTlraIcA+wTGS8LQRX/6bTLpVbWaMNMiMAScpL8UDxBEECdLt15e21qOhH
	 ZKGSp4lKTMetQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Sindhu Devale <sindhu.devale@intel.com>
Cc: linux-rdma@vger.kernel.org, Mustafa Ismail <mustafa.ismail@intel.com>
In-Reply-To: <20240131233953.400483-1-sindhu.devale@intel.com>
References: <20240131233953.400483-1-sindhu.devale@intel.com>
Subject: Re: [PATCH rdma-next] RDMA/irdma: Remove duplicate assignment
Message-Id: <170703948931.15655.14304985954050998306.b4-ty@kernel.org>
Date: Sun, 04 Feb 2024 11:38:09 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Wed, 31 Jan 2024 17:39:53 -0600, Sindhu Devale wrote:
> Remove the unneeded assignment of the qp_num which is already
> set in irdma_create_qp().
> 
> 

Applied, thanks!

[1/1] RDMA/irdma: Remove duplicate assignment
      https://git.kernel.org/rdma/rdma/c/926e8ea4b8dac8

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

