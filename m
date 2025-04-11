Return-Path: <linux-rdma+bounces-9361-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85256A85193
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 04:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816848C5EAF
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 02:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E00C27BF90;
	Fri, 11 Apr 2025 02:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPVAE8VZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA41F157E88;
	Fri, 11 Apr 2025 02:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744338576; cv=none; b=NRJ6Mhm6/i8pfqi7qs7s90Y6wb2+jhO7eyw1VsZ7qiK3ZLSw9qixr8h33zenjNCb7IZEQAA6XKShc/ybDXOqJ5NjhipUR//aacuTf8lRmMCxYpLmRMZlxkkFtfZegRBxNF0AqQBzHOWC63AAARvlzvegIyE1rKuFU860jzG0+GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744338576; c=relaxed/simple;
	bh=bNVYi1SQYbbz/w0th5xJapjjWB9VlDV/aSvSKGKw108=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ABaSwF2LxpQV8z6w8g99LqQpo42jVb77MmeCEcD29hiSo2X9eTI+rYMrB9ahvfp4hN++/g/edzGGoWDudMJMjRiV5iVktOcnIeQyW5Stjc1eIAK2/VHxm/yoFz4Mr2B0mZbufvBFjwvTFvRkrUgCdgmsqyl7Crvk2Q0svSxHmNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPVAE8VZ; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2295d78b433so16321035ad.2;
        Thu, 10 Apr 2025 19:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744338574; x=1744943374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gXoi19SV1w4efRvxspNJpUWNECbXvbnmGNIAl2BgeRQ=;
        b=WPVAE8VZtnVa6JeAeV6eowciugJUXJBceXjQ+14OH6Q0mpJVfL35px7LN+t6Zt+mmq
         Fg2VTIezUopxsbKJCO/WKq2qoMhYSnTzOhUVvQnna6mGyGmzheMs3UCHD3Ua+kOrRXYn
         319nlXr5xac3/fbfzHdjr53Q9hhx0kMEKxJjri/Ep7BRXXWh0CUBtMLdugsMXpQiNeH6
         lKz083QoSbISOqvRo6v3dCc6FMaPo19xWlCv8j31X3Sj21ZNFwi8+cdFDu2W+OlcdGB9
         m5eF+f4rBXPm+b7uKpcopIgVIimJ6wPWdYxCpy8u+cmsDSycImgxm9r1z8Qm4ix6n1VV
         aBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744338574; x=1744943374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXoi19SV1w4efRvxspNJpUWNECbXvbnmGNIAl2BgeRQ=;
        b=T72WRpoHKAxUh12BByVQAgJx8VSde3tIb3YgeDI0Fq8t4U/FLD39Jxr60CHsnUJwtF
         JOk8Syf3S+IjlQm3TO1J0GI5TEL9snxn8XCwt6Ly1QSoojao7JQhzX7HVyQNRbf8nlwS
         zVSTj/SCDHzqU1LwounJhVky2XDFyJp5zNSxLxWWBXMRqbyJfuNjQ6QVPpQ+kA9e91WC
         cAx917hFZRPeHotJbfH2d6RACOIfyMaAjwXNlBijwEdjypOAwN6PAKMSuerVpHOMiRQm
         Eo+RRVxbYiX2LigWWT9Fs3s/NRJOswZNKYInASkNbM6rnKb/GlATXBqPsJHDJYNUW8Bd
         t5mw==
X-Forwarded-Encrypted: i=1; AJvYcCVOxJpEkJmAC+RXUL/iR52QbuV6voRL4pA9X0p/1o5qTbJN9Kdn1J9U7jeD9mc+SZVmU/X73j48@vger.kernel.org, AJvYcCVj5CntP/v3EVdpy2rGKKPezTljBReYi7o5wSjBK5MqDwaGPVAoAwfDErmJraJglDNss+Es/da/7One7Q==@vger.kernel.org, AJvYcCWNMYJDM9vLgWjZRQOH88MeuaDlr/g+YbBkEfFNyDS4QcN6GjP+Mth0wjbb9zwNcC/VCl+YDgRP7nB30O8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvcaLU7Eb9x0nsNfDscpcUnttoVL3iUFirRTTm9MvuBmujQROy
	/hZYd3Aup0gA9Rjzr5Y11sMdGtw7zy//srK8ScIMkJW9VAf0ND9R
X-Gm-Gg: ASbGncvHYn6MmDLUQFacjqxQgxKMO4wULcN8S5kG4YDMugSNbYg0hlhEbbJDfWYrI2D
	9TR84JstCeACW/i8RzcmcGQBDUPPRQpVOKRKyP0JLyYWCL308heMJIBHWbhWpTE63HOyNEfCRZu
	ERiGZDmtUgTC3qT5JTgKlP8Afe9fSGAZ/3igYLqxypTP0NFfccVktloSGMxze546tLoMjy0kJ1N
	Sun1b1LQq88xv3Zq4IltySCMyDqt+E3sX1KVXTTg6zu0EEX9o3lgQUftSTGlTu1vOzZqtISJe6m
	DehdEwkjrHZW3hd5AkDoVRNxe5dQ/xdLOMj5aX8Mkt+3T37XIEUZqlxwbKuheFipUVk=
X-Google-Smtp-Source: AGHT+IEWc2MJH9CyX0FvTFVkivEIs/MKnHkpXrOfxfiEe4yDKAwHAyTkIvcr2l3cQMWpXkZXMT4/RA==
X-Received: by 2002:a17:903:4290:b0:224:1c95:451e with SMTP id d9443c01a7336-22bea4f665emr9611695ad.33.1744338573872;
        Thu, 10 Apr 2025 19:29:33 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230e34asm319168b3a.137.2025.04.10.19.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 19:29:33 -0700 (PDT)
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
Subject: [PATCH v3 0/1] net/mlx5: Fix null-ptr-deref in TTC table creation
Date: Fri, 11 Apr 2025 10:29:15 +0800
Message-Id: <20250411022916.44698-1-bsdhenrymartin@gmail.com>
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

 drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.34.1


