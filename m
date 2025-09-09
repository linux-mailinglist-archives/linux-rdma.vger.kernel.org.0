Return-Path: <linux-rdma+bounces-13169-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D89B49EA4
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 03:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CCC83AD53D
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 01:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1EC219301;
	Tue,  9 Sep 2025 01:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Is/jeUlP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D8D16DC28;
	Tue,  9 Sep 2025 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757380987; cv=none; b=dc3Vk0T9MCmAHFuOf2d+9GkIrPB8XK2TaMv9HsG5UPYlpkurDqR5UrIfDZswBBmY5qOOTTor36KgC0Ebd/xtA3V2MOq4qMf20bghcenebHVk+5onE+Sf1yaazowiUYNtgEQABKGFDEDb+3/CoumCP4c6T8PtOJer71wc+nVptyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757380987; c=relaxed/simple;
	bh=+Suf3UYL1FEYqrtEdRrLdPX55+LxnXEf18p8fqNUYqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttmgnCyY7k+W4q58+Bw+XYpi1bVbaX/B6zRuOK1qKqKwA+hYhyMMoREHuTXJImh43Ri176FpAplDKNpXtZ809fBdl4BPyZ5XW1GVVOjlCndvrXlyaqvmZTM8r/lBqE4t1vhDslGzWeBN1v28N6NSykacitaB6PVWFDK8Dm5rzh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Is/jeUlP; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757380981; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=xA2Ejw8sW8Ofk5QY6h87367f6vzr1rTStNEScUBbL98=;
	b=Is/jeUlPQCjThmyHaJHkSbMrMF10wWmdyesywFmj8n8Dapc4jEKcpng2/HQfOEe+y+58zByof03mDffmjKu3W5Lm286VUOr7o8py5BospLjW0w0pbgQNwaTD2hh1ygVp85WXAcW0/Bz01l9hpRkVV7rIIvOxkrdyiBrqSeWoipQ=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WnbokwK_1757380980 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 09:23:00 +0800
Date: Tue, 9 Sep 2025 09:23:00 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
	Aswin Karuvally <aswin@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 01/14] net/smc: Remove error handling of
 unregister_dmb()
Message-ID: <aL-BdPSnQTPUy5rc@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250905145428.1962105-1-wintera@linux.ibm.com>
 <20250905145428.1962105-2-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905145428.1962105-2-wintera@linux.ibm.com>

On 2025-09-05 16:54:14, Alexandra Winter wrote:
>smcd_buf_free() calls smc_ism_unregister_dmb(lgr->smcd, buf_desc) and
>then unconditionally frees buf_desc.
>
>Remove the cleaning up of fields of buf_desc in
>smc_ism_unregister_dmb(), because it is not helpful.
>
>This removes the only usage of ISM_ERROR from the smc module. So move it
>to drivers/s390/net/ism.h.
>
>Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
>Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Best regards,
Dust

>---
> drivers/s390/net/ism.h |  1 +
> include/net/smc.h      |  2 --
> net/smc/smc_ism.c      | 14 +++++---------
> net/smc/smc_ism.h      |  3 ++-
> 4 files changed, 8 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/s390/net/ism.h b/drivers/s390/net/ism.h
>index 047fa6101555..b5b03db52fce 100644
>--- a/drivers/s390/net/ism.h
>+++ b/drivers/s390/net/ism.h
>@@ -10,6 +10,7 @@
> #include <asm/pci_insn.h>
> 
> #define UTIL_STR_LEN	16
>+#define ISM_ERROR	0xFFFF
> 
> /*
>  * Do not use the first word of the DMB bits to ensure 8 byte aligned access.
>diff --git a/include/net/smc.h b/include/net/smc.h
>index db84e4e35080..a9c023dd1380 100644
>--- a/include/net/smc.h
>+++ b/include/net/smc.h
>@@ -44,8 +44,6 @@ struct smcd_dmb {
> 
> #define ISM_RESERVED_VLANID	0x1FFF
> 
>-#define ISM_ERROR	0xFFFF
>-
> struct smcd_dev;
> 
> struct smcd_gid {
>diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
>index a58ffb7a0610..fca01b95b65a 100644
>--- a/net/smc/smc_ism.c
>+++ b/net/smc/smc_ism.c
>@@ -205,13 +205,13 @@ int smc_ism_put_vlan(struct smcd_dev *smcd, unsigned short vlanid)
> 	return rc;
> }
> 
>-int smc_ism_unregister_dmb(struct smcd_dev *smcd, struct smc_buf_desc *dmb_desc)
>+void smc_ism_unregister_dmb(struct smcd_dev *smcd,
>+			    struct smc_buf_desc *dmb_desc)
> {
> 	struct smcd_dmb dmb;
>-	int rc = 0;
> 
> 	if (!dmb_desc->dma_addr)
>-		return rc;
>+		return;
> 
> 	memset(&dmb, 0, sizeof(dmb));
> 	dmb.dmb_tok = dmb_desc->token;
>@@ -219,13 +219,9 @@ int smc_ism_unregister_dmb(struct smcd_dev *smcd, struct smc_buf_desc *dmb_desc)
> 	dmb.cpu_addr = dmb_desc->cpu_addr;
> 	dmb.dma_addr = dmb_desc->dma_addr;
> 	dmb.dmb_len = dmb_desc->len;
>-	rc = smcd->ops->unregister_dmb(smcd, &dmb);
>-	if (!rc || rc == ISM_ERROR) {
>-		dmb_desc->cpu_addr = NULL;
>-		dmb_desc->dma_addr = 0;
>-	}
>+	smcd->ops->unregister_dmb(smcd, &dmb);
> 
>-	return rc;
>+	return;
> }
> 
> int smc_ism_register_dmb(struct smc_link_group *lgr, int dmb_len,
>diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
>index 6763133dd8d0..765aa8fae6fa 100644
>--- a/net/smc/smc_ism.h
>+++ b/net/smc/smc_ism.h
>@@ -47,7 +47,8 @@ int smc_ism_get_vlan(struct smcd_dev *dev, unsigned short vlan_id);
> int smc_ism_put_vlan(struct smcd_dev *dev, unsigned short vlan_id);
> int smc_ism_register_dmb(struct smc_link_group *lgr, int buf_size,
> 			 struct smc_buf_desc *dmb_desc);
>-int smc_ism_unregister_dmb(struct smcd_dev *dev, struct smc_buf_desc *dmb_desc);
>+void smc_ism_unregister_dmb(struct smcd_dev *dev,
>+			    struct smc_buf_desc *dmb_desc);
> bool smc_ism_support_dmb_nocopy(struct smcd_dev *smcd);
> int smc_ism_attach_dmb(struct smcd_dev *dev, u64 token,
> 		       struct smc_buf_desc *dmb_desc);
>-- 
>2.48.1

