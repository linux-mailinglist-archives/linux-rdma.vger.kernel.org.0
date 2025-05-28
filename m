Return-Path: <linux-rdma+bounces-10831-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 108A7AC63E6
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 10:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD091BC4ADC
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 08:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B93526B973;
	Wed, 28 May 2025 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kbk5JKQJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8554926A1D8
	for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 08:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419878; cv=none; b=CdecNHj+nP8inIm+RlrQ5KjmEe3Y4cb3F/ehXtT3s3ygq/5mR5WKKEbHGoUGseVSbJf+2gyq6wwJ68+790BH2NqJHvH/WO5fsO3AIxnfzMrTtV0w/ZqInf5xpnbGlz/1zWgMIDokoOtHsaEQ3l3iGjvvWi7o72oPOgjv/zKNetk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419878; c=relaxed/simple;
	bh=Mou1ieGyUfMk0Ql4ddZnpgGEyPlSxoqDatPUfQa5VIg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PDwz7QTmDJYrbeHrhdV4dZ6u/4EHPSgwl0N1ez6TIi8qOo86C/JvMDrfc/ksxCv/A3wt4Uovs6ik4c7YUlF1S1GBMeggmqkNUa1Md6eNGGMa+78stDXajZi0t56Zv1FBqFBjW7SH2tjX1XApAnaCmK3PGL+TXA5f6rDPI6JHQOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kbk5JKQJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a3771c0f8cso3015296f8f.3
        for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 01:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748419874; x=1749024674; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2eGBmhHpAoBCXn4dDL8o5LjT2W5woVp7uljWhl0TnKw=;
        b=Kbk5JKQJO6bcJ66sbfD5oJcyrM2Eejliy35OG+5TsyyaDjs1UphVXxvz3EiP24THym
         W8TL8L77U4YHJ2uEjz3x+Btwy/yLy/yJS1kaOqf+jRurQ/gbdnkgCjhiXLx2CbwwrlHF
         i4e+NhVR2c5Wd+mRuO5N8OIC9X6XkYb/X/lx3sKJH5zZa9J/DSQ26ZkFsee+QbtBOg1G
         dIgKxd+ojQZ6gOxEpVtS8F0VPAXFKr0keXb+YXs5rIa0gJOUnsj1lVfjGNbF+d3pTjrO
         7B5BJGNvbYJpEKWDUbZYpc1CbLUw5lLIb6wTFCSapplHE53XBpb+LM6c3JEEEBYnXvSd
         D8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748419874; x=1749024674;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2eGBmhHpAoBCXn4dDL8o5LjT2W5woVp7uljWhl0TnKw=;
        b=rhqdjpbevG0DKfOg1x9WdQvTQeeWP0DvD3WbBvJt5/rskBGe776xjLcjkhQsbGZpHj
         M0yx8CBsvk+jnLKMLG9B0YCleaxiF0+72JtAzKLEMKSAdToiX9XOHzKFwUMVuFasaB8W
         7ZdhLEzErXSXazLn7jN+WwU4hqINkk7nho6pTzLBuseGhHRGJQYIoaCm08xmsrAc2bG7
         u+qUZsgHwXEMI7G+aJJ03+Z/fl3NqcD570RvzBDa2sBFTXIF1d5k6nqc4ubD6jgUnZgP
         NC/peYB6UTPkAvpYD3AhFo4AMNMS+dYViqMx+Kv5cy1q3N1wAe8Z1VtzZMeW2+1eE4/Y
         W9Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVpYPwhonYQbqguicVkUHDv+TvI0+UxBf+HBFt0sD+w8qc70aL+Cj4dCIJG4Rj9sedsf1SR4e1vK3aE@vger.kernel.org
X-Gm-Message-State: AOJu0YzvcVfMY3xbNijU6rYTi64POle3MJte0jWDQYGOzxcznyqmizGi
	OpwqggBcLxwg07cvq2SmMa4NSoaHBvYL+hdunS0fqeDHEKPb/PWDqRBDFYIfyzNoCQs=
X-Gm-Gg: ASbGncsCmWis6IfA1Uvs5buSBWwLYzafIGxiYHLv51QTYA8corVvvoHPShVZ/NjCXGO
	pdQwUf4MhyHtjaAI1UqaFzkdjtYrJasUCUp6zxTLkfLeYs6rwICvWLTSYS9K2QJeDok9At64Qk2
	Xrdq5JiyT36GxlfF32Va+3yrkVIFjduiMOylqa13sR1BGw+aaljBmpTSFCwCM/waJljTgL9ApQJ
	CsUklSRL7DYkkK36TasJQ01Pxa3LAoFDyyAojc+ix9k84HSGL+ZsaOUhxp00tEQ4Pvd+19Y9X3s
	PwQlQvOSHgbqtEfOrG1NuhEqiYIsz/y4G1re/phBpnlMdn7BLcLrxNkV
X-Google-Smtp-Source: AGHT+IGyt9pIlXzNb8QFnz35HETogZyJleM14B194rW68Yuuufz6AtscehzIU6fQJn738bKFOwrivA==
X-Received: by 2002:a05:6000:2dc4:b0:3a4:e8bc:594 with SMTP id ffacd0b85a97d-3a4e8bc0917mr1162825f8f.8.1748419873739;
        Wed, 28 May 2025 01:11:13 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45006498d2dsm13303805e9.4.2025.05.28.01.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 01:11:13 -0700 (PDT)
Date: Wed, 28 May 2025 11:11:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Eugenia Emantayev <eugenia@mellanox.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Matan Barak <matanb@mellanox.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2 net] net/mlx4_en: Prevent potential integer overflow
 calculating Hz
Message-ID: <aDbFHe19juIJKjsb@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "freq" variable is in terms of MHz and "max_val_cycles" is in terms
of Hz.  The fact that "max_val_cycles" is a u64 suggests that support
for high frequency is intended but the "freq_khz * 1000" would overflow
the u32 type if we went above 4GHz.  Use unsigned long long type for the
mutliplication to prevent that.

Fixes: 31c128b66e5b ("net/mlx4_en: Choose time-stamping shift value according to HW frequency")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: Use ULL instead UL.

 drivers/net/ethernet/mellanox/mlx4/en_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_clock.c b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
index cd754cd76bde..d73a2044dc26 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_clock.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
@@ -249,7 +249,7 @@ static const struct ptp_clock_info mlx4_en_ptp_clock_info = {
 static u32 freq_to_shift(u16 freq)
 {
 	u32 freq_khz = freq * 1000;
-	u64 max_val_cycles = freq_khz * 1000 * MLX4_EN_WRAP_AROUND_SEC;
+	u64 max_val_cycles = freq_khz * 1000ULL * MLX4_EN_WRAP_AROUND_SEC;
 	u64 max_val_cycles_rounded = 1ULL << fls64(max_val_cycles - 1);
 	/* calculate max possible multiplier in order to fit in 64bit */
 	u64 max_mul = div64_u64(ULLONG_MAX, max_val_cycles_rounded);
-- 
2.47.2


