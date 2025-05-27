Return-Path: <linux-rdma+bounces-10745-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75654AC47D3
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 07:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07423AE99B
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 05:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDDD1E8332;
	Tue, 27 May 2025 05:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bHBTFXVq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E951D54FA
	for <linux-rdma@vger.kernel.org>; Tue, 27 May 2025 05:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748325109; cv=none; b=tTLXLL2rP4Bpy0Io19ILVHdk8AUEHE3K2+rJGDuqNcLHlbRP2Fbl7FfT7R+JfTOiswQMEHaoZV6xYGHjKnPXzQbhGENMN/zfgem3W3dTVHnekp//lLEj4pgHHUL/WheZK9EsZCtBCVK7AL/Ws3G+ctAyy6qTs0rpIBTOLKAA2mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748325109; c=relaxed/simple;
	bh=FRU9W1+DS8rfpo6UNzEN6UMBg1u0Yz12fF9f8ZKM/kE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JgYWYmfvol0zKEogOBx1ye0ef+2GRt1OcGoxD+9bGLSALpRItiIdxz52kKBEefEGtsgj8kU2nPVacpbZUQwS5Sxji86+jKflxZEnl9HIZNYE3eBaJojLH8MG7PIqus3Y3sYFgwoe+u3szyG6XFgJrjRr302E3dze8dVER0ClFH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bHBTFXVq; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad572ba1347so498676566b.1
        for <linux-rdma@vger.kernel.org>; Mon, 26 May 2025 22:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748325105; x=1748929905; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZVp2NY7FohPgZU2Typ+0h2uamFavzqINb4M9GCUjHoM=;
        b=bHBTFXVq7lydwB0QzS+hm0UM3cfkRYU8KwUkLGuYw2TcnPaOUTR13DvGMIXmoqNmW0
         HA2S3B579S0TlaPnpVn6T31o4VgrKCs2yJXpOTDGwxNxKNBh5Hffe+Bp5do0pn+GjdgR
         MpY0S9SaXpe5RFJEbnAdlLvQMlEKhCGG4bEzvW+a0/HC0o8ikkSUFjzTH1VKlodI4J1C
         l5Q4C7TJGoPgeNKaJqg3pzlnzd0+cs0RzloH7ZxFCOrwLaQs4p6zoG21ZdvrPMWPYWyE
         xmLtJaE+wHldpnrw3Y5Z2cJpuNTp3EJ3H5Aiz4sZGlXTfu8IaEpkray8s4svhPcYmgfv
         +5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748325105; x=1748929905;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVp2NY7FohPgZU2Typ+0h2uamFavzqINb4M9GCUjHoM=;
        b=AxUyzFDmsX86eQMAjidlUr+n8adJfwCr+QCijm54kclpVcoKNV6HWMLsl4EohNqQ7X
         dUhQaCgwXZWJDjTFGaJBBVInP9jZIjQ1IWvZLqq60aNbHC1EmBpGamAggVVCNWUILRCV
         iz89f7DxDHliwesNpUEiDJJm9aRPSBt7Lx34OFM++F7gtMeHqeA3+HbqQ3GicEHthraz
         u5mSnIDQOSjkHulKMlIg5lirQQXdkmJ6AQhENhyXKBFx0weqJjpcCyStxZNaZVF1AzBX
         sN0fr6+s1q1jEJGjdQjIZvg1CKZbfX4aMUEiSLXy9fgs4ejvGvdrRu3SZ7s/ly6dxl0h
         XPFg==
X-Forwarded-Encrypted: i=1; AJvYcCVhs4Blu2CcCoNj8NkddzmMmpOwU/d2mZw8b3nGXGXUAYdECbLE1m0h1bfwBsQz6yRArQgyol0kj4u5@vger.kernel.org
X-Gm-Message-State: AOJu0YzUUnL2oGuifdnEgwe/zujzbfIUj4eXRN7JGBrFm7Xz5z1CQSJ1
	v4N+4KenA0VGnchtHUT3chC7gB0tOHB0o01zj8cQRpXDbdTlCEm7fubZpkaLY8QY6PN/vnznXdz
	R15co
X-Gm-Gg: ASbGncvi4LEG0/pjiqZv/AtwRkwb4ah0MdA8Cu0enLL8QYIuho2U4EdhmroUVVgnmq2
	/K40YoUsauU2W++IAqlI6NNsXAUJuHELOLd0HrcMZ9E8BgzZa3w8vBjQZ0bIqdLBP9bkpotPIWV
	QIQ+sIPew+Nygr51O5gnhmXnbmG1K6TcisVZuAYsNUewBiDShKFGGMmEOl1+crz0WlH5CT2kWe4
	sT0CH+cexEYiI5rmC6ujKj+BjPVFGXqHExW8dZc90jOaxzJn7Frg5upJZAlHJjrWVmrBy0hZScU
	zFHT+DSPq8MCHwdLYIS8fxYgucn/JIJj+R3w/SkRhR4j8PrWwX040U9VBxnKcbFIvAcqdRsUrF4
	=
X-Google-Smtp-Source: AGHT+IHjsxqs/6jcL8C7UZ6kgwo4G0JpqJqenkT3mjexlsQRl4jPPZvuq7A6WGfuQrzvXuOSfE1M6A==
X-Received: by 2002:a17:906:b84c:b0:ad8:883b:f10d with SMTP id a640c23a62f3a-ad8883bf140mr176024766b.34.1748325104785;
        Mon, 26 May 2025 22:51:44 -0700 (PDT)
Received: from localhost (hf94.n1.ips.mtn.co.ug. [41.210.143.148])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ad8908a54f8sm40467266b.63.2025.05.26.22.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 22:51:44 -0700 (PDT)
Date: Tue, 27 May 2025 08:51:38 +0300
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
Subject: [PATCH net] net/mlx4_en: Prevent potential integer overflow
 calculating Hz
Message-ID: <aDVS6vGV7N4UnqWS@stanley.mountain>
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
the u32 type if we went above 4GHz.  Use unsigned long type for the
mutliplication to prevent that.

Fixes: 31c128b66e5b ("net/mlx4_en: Choose time-stamping shift value according to HW frequency")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_clock.c b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
index cd754cd76bde..7abd6a7c9ebe 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_clock.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
@@ -249,7 +249,7 @@ static const struct ptp_clock_info mlx4_en_ptp_clock_info = {
 static u32 freq_to_shift(u16 freq)
 {
 	u32 freq_khz = freq * 1000;
-	u64 max_val_cycles = freq_khz * 1000 * MLX4_EN_WRAP_AROUND_SEC;
+	u64 max_val_cycles = freq_khz * 1000UL * MLX4_EN_WRAP_AROUND_SEC;
 	u64 max_val_cycles_rounded = 1ULL << fls64(max_val_cycles - 1);
 	/* calculate max possible multiplier in order to fit in 64bit */
 	u64 max_mul = div64_u64(ULLONG_MAX, max_val_cycles_rounded);
-- 
2.47.2


