Return-Path: <linux-rdma+bounces-9376-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA4EA85E75
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 15:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7DF73A810C
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 13:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E964713635E;
	Fri, 11 Apr 2025 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gcf0TmoG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6363C17BA1;
	Fri, 11 Apr 2025 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377288; cv=none; b=PudPSoYd41I8L7crceTTCzVhCG5Ksh3iHYS8MskAa3fnX0/cUf3BmGwqj/X9XH1pstWiE49CF292vJJRHglqG2t1leRLO5jIDkrrGJxBWbXOp4P+pRT0+sPTIzhgDite+PJ8LJuJ5ZIDZHwf2RpOffmF+AaNlIkrl0El10F5zTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377288; c=relaxed/simple;
	bh=1UWUISv2DT7w0ljeiMVoiOZmsDc2AkD2/AxvOAuUcNg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qPSxMdgGZswDgdy51TJs7H5KJGRM3zw115jqADoA0zf9VRDzorquNXkAC5pp0NKqaot66S/vR4snQaNmllUXTPTy6/MX+lba7coUYvxW4SSVaEJ8Mt98uOq7ah3Ro4qGonuHdX1bwlJlpVvmTyx++E7HKBKv6jfJL84ccx7tqTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gcf0TmoG; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7376e311086so2522153b3a.3;
        Fri, 11 Apr 2025 06:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744377287; x=1744982087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XthcdcN8Iyv55J5M18ylV0pZBSRnbvsK3fQGBG1/ZS0=;
        b=Gcf0TmoGTe2JMaaTzKwcP+hpr4OXwCO3So3ae87ao311GfGYrKrxalP4F2JuV7B5un
         vtPgADnhr+BtfDWiseEN1MJFq6ktVRfU2xPZIyZ+gYzDgukEbQCtsp5gICMh96l8P/Am
         cxDvElEyCZoenUZNHXYjLnIOMb73gcig/xT/8NP2wjnlRje0p2ZUIlObGyYrZAXSQaAa
         gSsA74nYXiCv+IdHD96VYWiJmPEVEHYuuLhAsOIj+MIrjS+29n4XH67Q8zKZN0j6PpkL
         weZlRjTtmpSLWmVGWfMfYzXPR8ezFuMqUPHovYIAB9juRYhyAFJfwY047pO5sGeTNGKd
         +s8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744377287; x=1744982087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XthcdcN8Iyv55J5M18ylV0pZBSRnbvsK3fQGBG1/ZS0=;
        b=YdK+TRLTd7uDBuhZXROksX3Uv4x+3t2RN/8pqemP5uJXKEhn/g53xeJAPQDh84FC/9
         UvtX6rxD3xLDNVPdIf/fGII9qDVM1gBXqNSbLFS/BfIxAKEFqr7TGNY4+HChhQNaC0jX
         Su1b1tZYe8t0RtObsCxIm+xhyUsL7CN3gAnC/gweQLzfwjq8lX9+93aKbrDxCLrjPoZQ
         G8+wR5xOP00El4MKMAVEbbzNOpS075I8XRBbmpV6Omdu0d0D31o1Sv8GBWX8QWEsz+PP
         N4k0XYfVc02GVAo1g/gtjLSWvxGmmzGpb91vuaPr0Y1tx9WZ+CjqVemaspyKp1Ja5GRB
         qNPA==
X-Forwarded-Encrypted: i=1; AJvYcCVAPf5ng/ercjQpEpU+/bKiZkb7K4Fj+U6cMAqzawTBH+UlmMIgy2nAFyLe4JHTI71vJSd5UzBMiZcb0s4=@vger.kernel.org, AJvYcCWV9ziCqedApPpBOvqhyDuqwnL6c5IgBwT4frPHj5gdGGnLFH5tBSeJ9bSN39RLd0qWcMyHK2oC+HgONA==@vger.kernel.org, AJvYcCXP2RX7I9gBV765vr4cEN9msoU63VCxdKwfukp9P2BKEDjbw5ll7MiD0mT0rCGFTVYZafi4q50M@vger.kernel.org
X-Gm-Message-State: AOJu0YzjQJfvWwlEAfKAv2Io1c2tf84lgTvyqOOOfOqvPU5pTOPhoESG
	bSSfwatHsbcubMFbI8MfGbusEkAs2LffNA88uWcj3wv3g4lBYu6P
X-Gm-Gg: ASbGncvodgWnv7I2y84GGZq/SOqIExnSokNOsyX6YLA9qT5vVRixyqdhpuBmBNcHjEy
	Gu0iq5l5R5GZcjWLk5aFPEvqKP73V1LhG+jSH4hTvhumPJhKKSuIQlWG34aUsaD4tPJfIBR2jnr
	Wxp+eXa4RmSmrB3rKOA5L8AVpVAd34fTocuRrZwms437B2e40r9IbwBpFSSMoMyfm79Y1tyjHCz
	8Gp4e1wy4LoMksKXkcIstLNoR0SDu5CrzwpCSkraJVLyyv1QoP7QCo2471O3oOjlCY7Qu/5VXx0
	/WySPhVh7T5FWPO8eiWdgo4BJIYrVP+Hw7+WTzfFn9+p3kyZf8Ob45XyiAhAEphP
X-Google-Smtp-Source: AGHT+IHmGROtDU7FGfj92ZtlqT45b3qBFiBzD4gjS4C6XnOuqIUxsSIhZ2n2lqx9HDyQ6OcXD/Mg8Q==
X-Received: by 2002:a05:6a21:3943:b0:1fd:e9c8:b8c3 with SMTP id adf61e73a8af0-20179975a19mr4204075637.26.1744377286370;
        Fri, 11 Apr 2025 06:14:46 -0700 (PDT)
Received: from henry.localdomain ([223.72.104.59])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0de8926sm3967494a12.30.2025.04.11.06.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 06:14:45 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	amirtz@nvidia.com,
	ayal@nvidia.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v4 0/1] net/mlx5: Fix null-ptr-deref in TTC table creation
Date: Fri, 11 Apr 2025 21:14:30 +0800
Message-Id: <20250411131431.46537-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a NULL pointer dereference in
mlx5_create_{inner_,}ttc_table() by adding NULL checks for
mlx5_get_flow_namespace() return values.

Henry Martin (1):
  net/mlx5: Fix null-ptr-deref in mlx5_create_{inner_,}ttc_table()

 drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.34.1


