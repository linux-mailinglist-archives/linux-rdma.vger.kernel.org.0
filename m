Return-Path: <linux-rdma+bounces-14472-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 691ABC58FE0
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 18:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ABEB03624F7
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 16:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0058F345739;
	Thu, 13 Nov 2025 16:48:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346BA334689
	for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052504; cv=none; b=B29F38Lqyy+VQsYd7cnkO+wbKU3C9zWCxgYLEbQM5oUI9zEgu8eQBfEQdKOGQbPY9npik/8a5vbxQ+Y1WyrpBaXpyPeoo4qePNhbridJkNLqIB/OHfiYlEJoi9Ue1INUlLBUWFyQypf4QMYlbqCFsSWFCVoOby+yAwCnpmuXcAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052504; c=relaxed/simple;
	bh=Sum4+JVeXPfizys9pdpiHbOuRRQLqk+dWSvyWk6OJtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fA2pW8Q9KQYa20bDXyHECNEFdZ4+vnmujsHtypFib8HR0zCdhKGZdDqlplO7HMZgwCz0XiB2leyo/6ArkdxiZcNgDZHJoV5Wl0UEsxervfPK4rQa0Ca1ZW2T5z1RZ1B0ic3F4B3zj0HG+4dokH8Rj1mCus5/vpy5T+qNdHLhGu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-656de56ce7aso226164eaf.3
        for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 08:48:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052502; x=1763657302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sum4+JVeXPfizys9pdpiHbOuRRQLqk+dWSvyWk6OJtU=;
        b=gzagiFzHzxBUkRKmXuUVlDWtuiFONezkbToe4LM/OiLIysVvKs2Frg+AA7fl+ykmsC
         8L4UAs+eMt8Bc/11tNZyXQL0LUAcGyqMSYac4lOstMFJL1H9xm4grE+Y5BW96ImIh7oh
         lGEEs0JMj2MTubhRmtqBv0+JkDN9Lf0VPwcpuVgrTIVKxZm6zAeUJcP51gssFKzblt3o
         zJ8UfLy1hBX71CqJf4Ldn+l8CqpQfc1xMvTrmwln6gO1XhURMXKkV+I5xyWG9QXpJ5u4
         csM3ayTlzteN9ltDCTOjxbCWyp1H8uJcoYagXaSR9TdivKUVlVdr2CDtMQCENBgrP10Z
         VPSw==
X-Forwarded-Encrypted: i=1; AJvYcCWHSq7hr4NY+h6sqMERiwvNs/8yzOUVCVW0i2+0DA8g3j3SYgGLdZAcMa8K6R0L+76K554D51r9BBW6@vger.kernel.org
X-Gm-Message-State: AOJu0YyNGwUIPRVG5BLxKf2AK/9gPEdx2ACNBvFqtDdemSAt9249FrmO
	nShk1BQoXXebNaneVy6v+2ZhhcTz9Wfa748o0mcV1wPhQPVv3E7ifWdf
X-Gm-Gg: ASbGncurOJb3dtYXSwy9eqhxK1ykCA5nfsTedyK/X0JnC7+xaCuJY09dWxorFRpyDlL
	S/uwsbvd8C6e2Zeee6XWhAabzZtLHxsT55xjdX8pt4xXyv3ZZ47Q0veBuf9YXeLhjthfytOBOLo
	VlUzVgi+zZGK0Ajt/oEqM5siuLgGd5h5iFmQXxcvkbNKJ7cXIE93w2DXcyS27G1vUhEpkUSkSS9
	/jozHvjxcyXBHiRBGK2WqJMvM2++hW4QS+WNwnAshttQNFAFDrVzyXhZECUZTvcdLlfxmGHEG9y
	zH456l2/Be8naWziTXTukH/iSsBy5g9VIH/GprWp2epjFwTYvn8jEgR7htBGBd3Y+gAu1CXHQmt
	T/5fpJoDSxQj3bgEJVly2q9MNwGyRaCw4PqfJrYSYSraC/D03XUqwvDvF9yXyiqc/SnlBv5uHHr
	jVZS389nrJNGYZ4g==
X-Google-Smtp-Source: AGHT+IG9TDGsXXH71ZlSYsT4b04gTMVdrIDzUOCAbUC+AwdHftVnv0Uodlv7OFGiel08iPesDyqhlA==
X-Received: by 2002:a05:6808:228b:b0:44f:e7bd:274b with SMTP id 5614622812f47-450745acef7mr3902165b6e.55.1763052502220;
        Thu, 13 Nov 2025 08:48:22 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:5d::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4508a2e4af5sm1261843b6e.0.2025.11.13.08.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:48:21 -0800 (PST)
Date: Thu, 13 Nov 2025 08:48:20 -0800
From: Breno Leitao <leitao@debian.org>
To: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 0/2] net: mlx: migrate to new get_rx_ring_count ethtool
 API
Message-ID: <lto3b6lf2ic6ajph74ljo2ibpmoltkgpswfbvcprx5pr3iqfoi@67u4olbyq4km>
References: <20251113-mlx_grxrings-v1-0-0017f2af7dd0@debian.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113-mlx_grxrings-v1-0-0017f2af7dd0@debian.org>

On Thu, Nov 13, 2025 at 08:46:02AM -0800, Breno Leitao wrote:
> This series migrates the mlx4 and mlx5 drivers to use the new
> .get_rx_ring_count() callback introduced in commit 84eaf4359c36 ("net:
> ethtool: add get_rx_ring_count callback to optimize RX ring queries").

This is "net-next" material. I will update and resend with the proper
"net-next" tag.

