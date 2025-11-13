Return-Path: <linux-rdma+bounces-14468-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD5DC59068
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 18:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 75407364DC7
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 16:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D62359FB2;
	Thu, 13 Nov 2025 16:46:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5D821D3F3
	for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052376; cv=none; b=nRBgQ74WGFwLEQTrOKGNclnQ3hewjKFKW5XkLOkn4zEyhmiEma7aVZQtzAdSjGgfMrDOanXPJBpTblOuxBAKE4AtOA2HmwP1019EXlmmPYswvmbfscH/tcJbm2K+U8/eztUEfqTS/cZryUgRN5o3qgRhweukYbiz7oJdD5bnnMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052376; c=relaxed/simple;
	bh=VGnC9M5GyCZAIUV5N/UMNwO6x7HUT0IBSW2UW8dHOTs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jDs45jjI9bhLUjRXdw9F1y6p9mIXrcTal/RXlTZKne3jdhDpt+nxPHF7RyfO1PrKtlpyXJy9eNn9anmPXMa2NN22qvKqsCW5XNrVtmGkPoOQZ4XHgDUNpLLfKli1gImnm0gSezr7/Sb9AT3yxBhz9oZJzhUmQC2z7Gz0TZfIX24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c6ce4f65f7so877171a34.0
        for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 08:46:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052373; x=1763657173;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Le654lwVo/6yvzyB42yjnqH7EJH3FTtiuiBest9Aydw=;
        b=mPlCy6YONB5aACX6rCvCaIccZPfj2g5ZkvErs4dZzKyMW3M9Mi+77vP99IQ1cdMCl0
         UfMCnF9NkQ5Woa7NyfDhgnMBYSH2OUVlBjXvks5TUO95JehSA5f3jBCbPLk+0LC07SaB
         G/51OdLfPdXlgjg2sHEEOqxokZhvosVQvaidRl2EcXhR7idNE4J8IMwpUFBnhRtTzZ1V
         9GPlPmS2ZmiND1K9oMvgzNCCrLzvMCokAcOiD/j6W9yHLGfZAMPYt7H20hYtx94gitRV
         7rqSqdVdsbKjc0rzRNhUt6vsQdPJepH3OwEhFSKLjh+7op6YiO12OYEdkJnHreneEMEp
         YJCw==
X-Forwarded-Encrypted: i=1; AJvYcCUkxotrua4MxOUDfsZhmmwliUQRiasH9f1WF8L+VEYI6jKlTCikdmg0HI87LEYXH5al1BZ7Ek+9g9P8@vger.kernel.org
X-Gm-Message-State: AOJu0YwUjf5BfTQZjq3JTK6YF8dS6REEuKWDyiGY8beoYmXhlALRINGR
	YQGuLyZ7nf2lhUCcs0LaRrqaJRF+auT2EXm9aqHCRMk5I1DnuDqPlHC85d7aqA==
X-Gm-Gg: ASbGnct5PZLW3N0tPn20SdAvQPkIh0/cVeEuVzdH7KH11MdwbXLku1nf02QpuySBgDj
	mHuup0Zf/NxtA2rmc5NZMkMhpI5Id/iKs+V32JDW/0HxGrdTPFCsPqPYPGGZstEuLgErOmVwiQz
	T7c6t0wWLVQUZR5G03U81DPQkNinEw4rxgSszkmm1XQ8xrlp68qCOn6sgTsFw9fZm9PFpOqMwFR
	zJ7/DiioQAQRhvK4S8NrawgxgIOaI0VKiEyekjK0h/OmCYqDNgK0LyNdWG2bt+6gI4YK7GFJP/n
	J9NUw2KDi/Ii/GW2SLnjobnHLTIbZjE3qCmLeiHzFDcLSNQkiv4DVP6NZnexuA0FEI0Dv11RwxQ
	RkmxBlm9gsH8efM+2IOw90yT2VaUxrljY9ti+nBUgeTyBwzCAu+5CGMc30ByAHPOf/R2zKCHhGv
	zScg==
X-Google-Smtp-Source: AGHT+IHMlldWyJC6JRWEYFYT1iL5gomLD7IIC4KMdUcHwaxmTiV3LQSm9YXqc/Il2hpg7iYHwyqiKQ==
X-Received: by 2002:a05:6830:67da:b0:7ba:8107:d559 with SMTP id 46e09a7af769-7c74454ea64mr121594a34.26.1763052373137;
        Thu, 13 Nov 2025 08:46:13 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c73a39310csm1490035a34.21.2025.11.13.08.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:46:12 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH 0/2] net: mlx: migrate to new get_rx_ring_count ethtool API
Date: Thu, 13 Nov 2025 08:46:02 -0800
Message-Id: <20251113-mlx_grxrings-v1-0-0017f2af7dd0@debian.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEoLFmkC/x3MQQqDMBAF0KsMf20gY5tFcpUiInVMB2osE5CA5
 O5C3wHehSqmUpHogsmpVY+CRDwQ3p+lZHG6IhFGPwZmfrj92+ZszbTk6jiGNYZNvMQnBsLPZNP
 2715T7ze2omJYXgAAAA==
X-Change-ID: 20251113-mlx_grxrings-195d95fe0e94
To: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354; i=leitao@debian.org;
 h=from:subject:message-id; bh=VGnC9M5GyCZAIUV5N/UMNwO6x7HUT0IBSW2UW8dHOTs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpFgtTGtn9i7Py9ec07FVPLZv/6rFQlwLiE6XVC
 6+4CuAYJhqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaRYLUwAKCRA1o5Of/Hh3
 bYrZEACULVWobdnQ9efzrcFpilU50BH9Lh3TGK7pgRlVM29ZOju0jvQacwOi19SlHukYZiOnmW8
 yKgdmIVbPFSYuCgIcHTU6SUQ4W2LDKqDenwbmKJiTNVGgr91vWVhms1+0hT5EOtCfzvPZjmWaIF
 uv4ZRJiT088YQUbMrVIORBqpOICaKHx8Qm+lN+6uSnd7pfDT05W9PNlBoMaJoMnG0Ds0gTfot4h
 s2+CsizvYVB2M7ij2zxJh8xIkY0WjFd2VoZXuij8yZK4sXJhDKnIe6FEqTbs/KoTBEhpbpr7ech
 wvQGJEKIyeoZK5xN9f8gvt4wkOrnsbVi9U8cxelWfeeOPgxX+mnDVEOiPweFUO6N3KXy2dNSbhB
 j9QQzvR9361xkSpftm2D2A2IloduQSnM7kNT5tbrM8qjR+w69UftVJ5en4VobiHw+4nwFXWxHW5
 5r7N3W7m38YKbTgcXfF9cA7lqiyqyJLYDoGrAYPjupKQoqhFCplb3uR7aYShy4HeuioYeo3ZW3x
 5Vd0CyLn14g41jd8WTraQpkuAFRE+V4C+qozgMkI21bJwyOcRzrRiBHqrZpVzEfMWxfbZjLR3II
 /4Uqcgmh/AjJnxOL7tKsLW/dFHTjhxC66B7Gd+UYoDtwbFVczLz7X2CS+/N9JAPHZ7VQ84HpgtI
 0IdnQAAKtiQKs0Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This series migrates the mlx4 and mlx5 drivers to use the new
.get_rx_ring_count() callback introduced in commit 84eaf4359c36 ("net:
ethtool: add get_rx_ring_count callback to optimize RX ring queries").

Previously, these drivers handled ETHTOOL_GRXRINGS within the
.get_rxnfc() callback. With the dedicated .get_rx_ring_count() API, this
handling can be extracted and simplified.

For mlx5, this affects both the ethernet and IPoIB drivers. The
ETHTOOL_GRXRINGS handling was previously kept in .get_rxnfc() to support
"ethtool -x" when CONFIG_MLX5_EN_RXNFC=n, but this is no longer
necessary with the new dedicated callback.

Note: The mlx4 changes are compile-tested only, while mlx5 changes were
properly tested.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (2):
      mlx4: extract GRXRINGS from .get_rxnfc
      mlx5: extract GRXRINGS from .get_rxnfc

 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c        | 11 ++++++++---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c   | 18 ++++++++----------
 .../net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c    | 18 ++++++++----------
 3 files changed, 24 insertions(+), 23 deletions(-)
---
base-commit: 9f07af1d274223a4314b5e2e6d395a78166c24c5
change-id: 20251113-mlx_grxrings-195d95fe0e94

Best regards,
--  
Breno Leitao <leitao@debian.org>


