Return-Path: <linux-rdma+bounces-6230-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6639E397D
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 13:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE5D2819B4
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 12:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4C61B6CF9;
	Wed,  4 Dec 2024 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ljZNXT52"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E191B4153
	for <linux-rdma@vger.kernel.org>; Wed,  4 Dec 2024 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314009; cv=none; b=NuZt4iMqBjfa2b/hKYlNTkrUKojCwI1dafb5jSX3bvBdeWb9qcloDbX1v8zhq5SNl1f2GDbNqe/zT5rdqHCArZg9u6OaxomJFfKF6cxxnc2LC5nTaq6GeGbXLxGJcpZWHDi277hVBVR0/aPVYuGluFJ/hpKjk2UfCnOQWqTgnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314009; c=relaxed/simple;
	bh=JDuHv6uKQbsHmnfZl4eZomwStWLbB2P9XNr61tQtoTk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oAsuqXJjjQTiuhPhQCmk1N9PfTunIevWrwVcainwn1xGn6YvugFYRgH829eGpEbAuWqwZArLFZnmhOkd5o6rgrWG634Umfjx4VBmWpUU3+azBo4ge0FMzaxa/0wwGkVnMsaPPueWiOYzR4nTUZAHQXUhjX5qBKKhWUlWqEIEbo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ljZNXT52; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385dfb168cbso3230125f8f.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 Dec 2024 04:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733314006; x=1733918806; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywma13jqMEAR0GKd8Er2i+hQcM6w7VPqBl5YrMVzLNg=;
        b=ljZNXT527HsCuXDN04ftSTOa7EdLqkLaJgxqyahBN/Hy3l0O+uPycEaB5EmEKsdMxe
         kV7ey+bTmpyZV6esyDa3I5Br6Pmw77su4JefNShB474nT3N9vmjSh79QBlWEo4y7UNUl
         XOAH6Ioxsx6Dpk94+vGwVOHQXCYsFUXRhU+5JxbfuhF/sTw2CFWpQn1vQhP4NOuH6fwB
         4/MTZgWGcwrt3XDaFjKwYS9Q3voxeby96NcSmTjWllX8xAjFq6/INHXwPVsuRUWdqo2Q
         sWEvU1nRomKubzL6/hzh/o4DUxrFDJjzPB7kNhTI66RxbAYXJFLdp94NK8pCESdn/b8f
         XQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733314006; x=1733918806;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywma13jqMEAR0GKd8Er2i+hQcM6w7VPqBl5YrMVzLNg=;
        b=oDbysTywD9vVj/aH4p3zvBN/b2qqdDQ5MQsGeIrqb/pStXff24sqxhEkcXMJ7O/GpZ
         9wQK00l9L+0+ddRC9nu0vr2ByUxiqDo2PfdksEYlLM70J0ZjElWw26vaxlAM0FXEnxOs
         JXc6EKe3LGSjNsMjxo3jM32AQFxNY+km1i0ucgINX4hwYg4DTnq54KYpOxX+v6X5g3Xx
         JucexCiHxQX+ECrNCGUS2hjR+7rT1FNjFj0nGL73oSWj0xve/Tut1QuMwndXUD4fIL5Y
         o2hjsczE4qop25AYb2yLHJcZKbu+3Bawjd0i8dxW6QHUV/52ybu7unEt4Uy84eyA1XCY
         XLzA==
X-Forwarded-Encrypted: i=1; AJvYcCU8fDOyEwbtb1irjZBw3WT4KdiJJqjTalf6oO/IbB1m+YE8Z8+MDVy0AEW7VoCVudoR2kJiORj5g3mG@vger.kernel.org
X-Gm-Message-State: AOJu0YzQLtewu/kZD1jJbED5a+p+s/tDRMubo30LNHcj8wTeIbFPZMOR
	Otf55hk0iHt0frFkbQZOTIonYJNS8EOqRbPCcIUJTe5bmIrwQDt8vVQBX8vAXvI=
X-Gm-Gg: ASbGnctc9NlLUqYPEAJW8aTBlTJQa7vM1zIE4/aAILV78CaGTGWQkRpJcOxMoPtbvk/
	rwGRpa1qM92ho9CIjhhjoKxwgJ3BWtp8GHlOqc1uohxX7IZxVQ8E9e7aUromS25mFkOI5fQAvuG
	lxLQ6ne1Dmji+NxjRxTZ3HqSlJMAJWCQ99L1XnW2JjYBMhVEiIRzuaNw8l1uyFmYrhpMLJ8dYe4
	+3o0Mb4w0/QxY0O+6NcH52/med8Qc//ntCd5/pD/5YeoYyrCvU2+go=
X-Google-Smtp-Source: AGHT+IGJUj6d/zYcZD5M/Et3lJs2ShDAAV/RYF8yEIzq3ilyWBo8QUqo+ERoO6DKk5D16w9J5pmwRQ==
X-Received: by 2002:a5d:5f83:0:b0:385:df4e:3691 with SMTP id ffacd0b85a97d-385fd418da7mr4972574f8f.42.1733314005639;
        Wed, 04 Dec 2024 04:06:45 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385fd599b31sm4473289f8f.21.2024.12.04.04.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 04:06:45 -0800 (PST)
Date: Wed, 4 Dec 2024 15:06:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Muhammad Sammar <muhammads@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v3 net] net/mlx5: DR, prevent potential error pointer
 dereference
Message-ID: <07477254-e179-43e2-b1b3-3b9db4674195@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The dr_domain_add_vport_cap() function generally returns NULL on error
but sometimes we want it to return ERR_PTR(-EBUSY) so the caller can
retry.  The problem here is that "ret" can be either -EBUSY or -ENOMEM
and if it's and -ENOMEM then the error pointer is propogated back and
eventually dereferenced in dr_ste_v0_build_src_gvmi_qpn_tag().

Fixes: 11a45def2e19 ("net/mlx5: DR, Add support for SF vports")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: fix typo in commit message
v3: better style

 .../net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c  | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
index 3d74109f8230..49f22cad92bf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
@@ -297,7 +297,9 @@ dr_domain_add_vport_cap(struct mlx5dr_domain *dmn, u16 vport)
 	if (ret) {
 		mlx5dr_dbg(dmn, "Couldn't insert new vport into xarray (%d)\n", ret);
 		kvfree(vport_caps);
-		return ERR_PTR(ret);
+		if (ret == -EBUSY)
+			return ERR_PTR(-EBUSY);
+		return NULL;
 	}
 
 	return vport_caps;
-- 
2.45.2


