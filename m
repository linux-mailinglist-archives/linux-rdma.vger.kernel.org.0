Return-Path: <linux-rdma+bounces-6166-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4829DEFCC
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Nov 2024 11:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC101635ED
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Nov 2024 10:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD9F15539F;
	Sat, 30 Nov 2024 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LXY3bTJa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64091531CB
	for <linux-rdma@vger.kernel.org>; Sat, 30 Nov 2024 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732960904; cv=none; b=RSlKOXlUjiTMT2AYSITvaaXaLiDviohlG+e9UsH8aQRkpULYSsZMRBY5RO0NTKivNKkMHea18830OXzxiaSfCWZe2jdJWEBkM/EZZ4i+SpcyC+4uvzx6pw3/inXShsj2Lvo4lbp4b8kG5sIlgD2M7BXvnEWB4VeKWPRW8WGbfBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732960904; c=relaxed/simple;
	bh=SIBkMDM9PgjbFAyR8EA5YSQSJxCLhTUPXO4IfXW4hxA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b/m37dVSO+YF7uYezxcubiljIVKd6SbnZqOQmYfXlDeeFnXvKAzo/KZBfeDgvJaQgvWsNrrAMBERH83zZ+1sibT+Lkp/P95N7fT+XOkPOAxXW9uPak8akGCLP5EPV15LbYx4JJtEMVgdjw7Iq6gWDpSfoXrn5nUDueo/IGQ+jcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LXY3bTJa; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so1755235a12.1
        for <linux-rdma@vger.kernel.org>; Sat, 30 Nov 2024 02:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732960901; x=1733565701; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gI0rRaj3h2iBiBAn9r1ZitfB9ykqVmf7MWwf3cvySCI=;
        b=LXY3bTJajK069OeOXmcH4TERJntYiYTHdfzKYaSPfOBG7gGyEX5hJw0BCwUSEBOu0m
         jMBXCzQ0WqpllbX36EYDR2r1yJABe11sJcH/cO9L1bxoACo+0sUqJcoHdGhppLppr7MP
         98b6m2lJ7X6L1m7ou8nXwNYmJXhJUqnXuzPGYQOs8JFOC9xsv5OwTKmEL7W4Hx8n9HSS
         SgBXocONN4dVhs43GA0x4c6Ei1RGFZ1Iacx9YliDpBAKM4wEtzz55bIQ2bkfKCJFoOEL
         6v+1cANgeDDsS8TXibQDrH4gHSETrRVlj+uoF95WHEJq+SMMAkM9+hJMAtM5b4BRXtcK
         Bk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732960901; x=1733565701;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gI0rRaj3h2iBiBAn9r1ZitfB9ykqVmf7MWwf3cvySCI=;
        b=GQB3lAws99IehMIe6fX1TY/oK4CYjVXdDdSWzi+BwNoiFoKyafrt8RZjzFHKQFCwtK
         H8G3b86U1zocKTeBmVGsekD6H9refEbk9wAXW0/FYAcS6O1hNRTimHJ3o04ORpn17zeu
         PxaMuxDYUIOiPCOuEpzbicIUYkGDoMjKeQ71M575NBOO6Qhih/l1PE3FUoMgZ1QHlh8c
         uc5EdcVs1K7TVbCumGwQEj6eirCtjOJjnG8dIavd8LI83Vn82p6mEOhgl9s5QeY2/Ok3
         aRtGgFFK9jI37GgqnTr+6zZn0epYSdSS/lJyWpm1psdsOTiK+hiJqlEvj+czV+aV6McA
         Volw==
X-Forwarded-Encrypted: i=1; AJvYcCUzwzcENmvSltKH6gH8XPRBab2IPzhRijfGuIJ5ZjgGUil8db6qDCJ8vpfzPCckxNhWD8sGbTiPT3Kt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4je4Wwdi0qiFkz6+rL0mgXCitkJ7ermNWIvhBjzAH3Zi7cq4L
	4q7zIbdmvi+2BLD0ywFmjtNpy7tiPXRAdix3kTUFx2lhDcUN10r6qI6u9aA4Oz0=
X-Gm-Gg: ASbGncv2zNkYGONbpDtDq5jstpPOn/L4Gvv4ud8lALAdnIkT6F+L0Uhz8f+srZ0x7HI
	N/SUfdZJuuZOy3ES2Ns0vzSS23EXqiuPmWZJ3LloEJcLOduIT57wU3ZdpHv9qmQaqff6HH6LIx2
	khNmwwI9bUdRqhn1xD3+VUcrVuG7onZ7h1eHo3j9PH0TIbcAmhrAqnXpS96VktxpL5l7eY/6JAx
	VvOjtnwjc2Qhfr441QNy4G5tsvcU6BhFhBCtT1np9kIaNkZaCQprKol6mGSWu8FNRG9BYQc
X-Google-Smtp-Source: AGHT+IEFpMg8pm0uwYaiFZHM3DW/3ch6uaXaKn10ANQVIeghH2SzJao+XGL30yqtSajOxrJ4Wm207w==
X-Received: by 2002:a05:6402:1d4f:b0:5d0:840d:ed04 with SMTP id 4fb4d7f45d1cf-5d0840deeb0mr13550421a12.8.1732960901059;
        Sat, 30 Nov 2024 02:01:41 -0800 (PST)
Received: from localhost (h1109.n1.ips.mtn.co.ug. [41.210.145.9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0d0a026e6sm222374a12.80.2024.11.30.02.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 02:01:40 -0800 (PST)
Date: Sat, 30 Nov 2024 13:01:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Atul Gupta <atul.gupta@chelsio.com>
Cc: Potnuri Bharat Teja <bharat@chelsio.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Casey Leedom <leedom@chelsio.com>,
	Michael Werner <werner@chelsio.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] cxgb4: prevent potential integer overflow on 32bit
Message-ID: <86b404e1-4a75-4a35-a34e-e3054fa554c7@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "gl->tot_len" variable is controlled by the user.  It comes from
process_responses().  On 32bit systems, the "gl->tot_len +
sizeof(struct cpl_pass_accept_req) + sizeof(struct rss_header)" addition
could have an integer wrapping bug.  Use size_add() to prevent this.

Fixes: a08943947873 ("crypto: chtls - Register chtls with net tls")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This is from static analysis.  I've spent some time reviewing this code
but I might be wrong.

 drivers/infiniband/hw/cxgb4/device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/cxgb4/device.c
index 80970a1738f8..034b85c42255 100644
--- a/drivers/infiniband/hw/cxgb4/device.c
+++ b/drivers/infiniband/hw/cxgb4/device.c
@@ -1114,8 +1114,10 @@ static inline struct sk_buff *copy_gl_to_skb_pkt(const struct pkt_gl *gl,
 	 * The math here assumes sizeof cpl_pass_accept_req >= sizeof
 	 * cpl_rx_pkt.
 	 */
-	skb = alloc_skb(gl->tot_len + sizeof(struct cpl_pass_accept_req) +
-			sizeof(struct rss_header) - pktshift, GFP_ATOMIC);
+	skb = alloc_skb(size_add(gl->tot_len,
+				 sizeof(struct cpl_pass_accept_req) +
+				 sizeof(struct rss_header)) - pktshift,
+			GFP_ATOMIC);
 	if (unlikely(!skb))
 		return NULL;
 
-- 
2.45.2


