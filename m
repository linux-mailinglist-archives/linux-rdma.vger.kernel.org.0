Return-Path: <linux-rdma+bounces-12642-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4E6B1FA90
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 16:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10DEE3BCD93
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 14:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2D326D4E6;
	Sun, 10 Aug 2025 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="I5qMKnai"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815C926CE0F;
	Sun, 10 Aug 2025 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754837179; cv=none; b=JcMCPgQz/1cfNwTUWzbydtKq7B6yO6rkMHsUvtnBjqySTi1q8dEjdSKFVYcBvRCDR6aNzG0H1qan4zrq0hW2FeQem0qXx8zwPIgW9o4ppqxTdRbzGzHS3xDVylawpk42Farv605RqDf4tlp1CapGxVMLZvN4lcoZ6/o2xCvDJSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754837179; c=relaxed/simple;
	bh=ypEms/w1BnTycLubbLmin8A2iohDrcXPRyunSm4ZQNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6UoY4Ljc4h5QmyP7fSwKraXS97FRnBtdf75Cn6mz5dTxyeU+C35stb8aG9KVoHxrzBgFCteS0Htmgd2moFBUhRajhfgCfx/uNqGfDRpRjL9JIA2dPv84FylqPEHkH7++yjDc8LApoYaX53gyLIKLMvU4fiD86NFXwY2BdMpb5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=I5qMKnai; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754837166; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=0ANgq0ytYpgrPxRxTAFWvY3tor2cv/l9KWGySz8uQbc=;
	b=I5qMKnaidQwWR/+DfZcrl/wjzSBPVjFC2mGmVSofVb4L0nj/jkLhna8ODC/jSUDNk5wjq86ME4B7KG2uksRKWBEZN14s6lyzQiYsvOTIvUclaaTJCypu46vmx8OkDyEVgaXFUOIaO3tg8jziWqE2blT8b0Z7BcFw7Eg38K+T79g=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WlMTGeG_1754837164 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 10 Aug 2025 22:46:05 +0800
Date: Sun, 10 Aug 2025 22:46:04 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, Halil Pasic <pasic@linux.ibm.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [RFC net-next 08/17] net/dibs: Register ism as dibs device
Message-ID: <aJiwrG-XD06gTKb3@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
 <20250806154122.3413330-9-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806154122.3413330-9-wintera@linux.ibm.com>

On 2025-08-06 17:41:13, Alexandra Winter wrote:
>Register ism devices with the dibs layer. Follow-on patches will move
>functionality to the dibs layer.
>
>As DIBS is only a shim layer without any dependencies, we can depend ISM
>on DIBS without adding indirect dependencies. A follow-on patch will
>remove implication of SMC by ISM.
>
>Define struct dibs_dev. Follow-on patches will move more content into
>dibs_dev.  The goal of follow-on patches is that ism_dev will only
>contain fields that are special for this device driver. The same concept
>will apply to other dibs device drivers.
>
>Define dibs_dev_alloc(), dibs_dev_add() and dibs_dev_del() to be called
>by dibs device drivers and call them from ism_drv.c
>Use ism_dev.dibs for a pointer to dibs_dev.

I've been wondering whether we should completely remove the ISM concept
from SMC. Including rename smc_ism.c into smc_dibs.c.

Since DIBS already serves as the replacement for ISM, having both ISM
and DIBS coexist in the codebase seems a bit confusing and inconsistent.
Removing ISM could help streamline the code and improve clarity.

Best regards,
Dust

>
>Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
>---
> drivers/s390/net/Kconfig   |  2 +-
> drivers/s390/net/ism.h     |  1 +
> drivers/s390/net/ism_drv.c | 83 ++++++++++++++++++++++++--------------
> include/linux/dibs.h       | 38 +++++++++++++++++
> include/linux/ism.h        |  1 +
> net/dibs/dibs_main.c       | 36 +++++++++++++++++
> 6 files changed, 129 insertions(+), 32 deletions(-)
>
>diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
>index 2b43f6f28362..92985f595d59 100644
>--- a/drivers/s390/net/Kconfig
>+++ b/drivers/s390/net/Kconfig
>@@ -81,7 +81,7 @@ config CCWGROUP
> 
> config ISM
> 	tristate "Support for ISM vPCI Adapter"
>-	depends on PCI
>+	depends on PCI && DIBS
> 	imply SMC
> 	default n
> 	help
>diff --git a/drivers/s390/net/ism.h b/drivers/s390/net/ism.h
>index b5b03db52fce..3078779fa71e 100644
>--- a/drivers/s390/net/ism.h
>+++ b/drivers/s390/net/ism.h
>@@ -5,6 +5,7 @@
> #include <linux/spinlock.h>
> #include <linux/types.h>
> #include <linux/pci.h>
>+#include <linux/dibs.h>
> #include <linux/ism.h>
> #include <net/smc.h>
> #include <asm/pci_insn.h>
>diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
>index a543e59818bb..7948334f8d30 100644
>--- a/drivers/s390/net/ism_drv.c
>+++ b/drivers/s390/net/ism_drv.c
>@@ -599,8 +599,39 @@ static void ism_dev_release(struct device *dev)
> 	kfree(ism);
> }
> 
>+static void ism_dev_exit(struct ism_dev *ism)
>+{
>+	struct pci_dev *pdev = ism->pdev;
>+	unsigned long flags;
>+	int i;
>+
>+	spin_lock_irqsave(&ism->lock, flags);
>+	for (i = 0; i < max_client; ++i)
>+		ism->subs[i] = NULL;
>+	spin_unlock_irqrestore(&ism->lock, flags);
>+
>+	mutex_lock(&ism_dev_list.mutex);
>+	mutex_lock(&clients_lock);
>+	for (i = 0; i < max_client; ++i) {
>+		if (clients[i])
>+			clients[i]->remove(ism);
>+	}
>+	mutex_unlock(&clients_lock);
>+
>+	if (ism_v2_capable)
>+		ism_del_vlan_id(ism, ISM_RESERVED_VLANID);
>+	unregister_ieq(ism);
>+	unregister_sba(ism);
>+	free_irq(pci_irq_vector(pdev, 0), ism);
>+	kfree(ism->sba_client_arr);
>+	pci_free_irq_vectors(pdev);
>+	list_del_init(&ism->list);
>+	mutex_unlock(&ism_dev_list.mutex);
>+}
>+
> static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> {
>+	struct dibs_dev *dibs;
> 	struct ism_dev *ism;
> 	int ret;
> 
>@@ -636,12 +667,28 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 	dma_set_max_seg_size(&pdev->dev, SZ_1M);
> 	pci_set_master(pdev);
> 
>+	dibs = dibs_dev_alloc();
>+	if (!dibs) {
>+		ret = -ENOMEM;
>+		goto err_resource;
>+	}
>+	ism->dibs = dibs;
>+
> 	ret = ism_dev_init(ism);
> 	if (ret)
>-		goto err_resource;
>+		goto err_dibs;
>+
>+	ret = dibs_dev_add(dibs);
>+	if (ret)
>+		goto err_ism;
> 
> 	return 0;
> 
>+err_ism:
>+	ism_dev_exit(ism);
>+err_dibs:
>+	/* pairs with dibs_dev_alloc() */
>+	kfree(dibs);
> err_resource:
> 	pci_release_mem_regions(pdev);
> err_disable:
>@@ -655,41 +702,15 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 	return ret;
> }
> 
>-static void ism_dev_exit(struct ism_dev *ism)
>-{
>-	struct pci_dev *pdev = ism->pdev;
>-	unsigned long flags;
>-	int i;
>-
>-	spin_lock_irqsave(&ism->lock, flags);
>-	for (i = 0; i < max_client; ++i)
>-		ism->subs[i] = NULL;
>-	spin_unlock_irqrestore(&ism->lock, flags);
>-
>-	mutex_lock(&ism_dev_list.mutex);
>-	mutex_lock(&clients_lock);
>-	for (i = 0; i < max_client; ++i) {
>-		if (clients[i])
>-			clients[i]->remove(ism);
>-	}
>-	mutex_unlock(&clients_lock);
>-
>-	if (ism_v2_capable)
>-		ism_del_vlan_id(ism, ISM_RESERVED_VLANID);
>-	unregister_ieq(ism);
>-	unregister_sba(ism);
>-	free_irq(pci_irq_vector(pdev, 0), ism);
>-	kfree(ism->sba_client_arr);
>-	pci_free_irq_vectors(pdev);
>-	list_del_init(&ism->list);
>-	mutex_unlock(&ism_dev_list.mutex);
>-}
>-
> static void ism_remove(struct pci_dev *pdev)
> {
> 	struct ism_dev *ism = dev_get_drvdata(&pdev->dev);
>+	struct dibs_dev *dibs = ism->dibs;
> 
>+	dibs_dev_del(dibs);
> 	ism_dev_exit(ism);
>+	/* pairs with dibs_dev_alloc() */
>+	kfree(dibs);
> 
> 	pci_release_mem_regions(pdev);
> 	pci_disable_device(pdev);
>diff --git a/include/linux/dibs.h b/include/linux/dibs.h
>index 5c432699becb..e9a66cc7f25d 100644
>--- a/include/linux/dibs.h
>+++ b/include/linux/dibs.h
>@@ -9,6 +9,7 @@
> #ifndef _DIBS_H
> #define _DIBS_H
> 
>+#include <linux/device.h>
> /* DIBS - Direct Internal Buffer Sharing - concept
>  * -----------------------------------------------
>  * In the case of multiple system sharing the same hardware, dibs fabrics can
>@@ -61,4 +62,41 @@ int dibs_register_client(struct dibs_client *client);
>  */
> int dibs_unregister_client(struct dibs_client *client);
> 
>+/* DIBS devices
>+ * ------------
>+ */
>+struct dibs_dev {
>+	struct list_head list;
>+};
>+
>+/* ------- End of client-only functions ----------- */
>+
>+/*
>+ * Functions to be called by dibs device drivers:
>+ */
>+/**
>+ * dibs_dev_alloc() - allocate and reference device structure
>+ *
>+ * The following fields will be valid upon successful return: dev
>+ * NOTE: Use put_device(dibs_get_dev(@dibs)) to give up your reference instead
>+ * of freeing @dibs @dev directly once you have successfully called this
>+ * function.
>+ * Return: Pointer to dibs device structure
>+ */
>+struct dibs_dev *dibs_dev_alloc(void);
>+/**
>+ * dibs_dev_add() - register with dibs layer and all clients
>+ * @dibs: dibs device
>+ *
>+ * The following fields must be valid upon entry: dev, ops, drv_priv
>+ * All fields will be valid upon successful return.
>+ * Return: zero on success
>+ */
>+int dibs_dev_add(struct dibs_dev *dibs);
>+/**
>+ * dibs_dev_del() - unregister from dibs layer and all clients
>+ * @dibs: dibs device
>+ */
>+void dibs_dev_del(struct dibs_dev *dibs);
>+
> #endif	/* _DIBS_H */
>diff --git a/include/linux/ism.h b/include/linux/ism.h
>index 8358b4cd7ba6..9a53d3c48c16 100644
>--- a/include/linux/ism.h
>+++ b/include/linux/ism.h
>@@ -30,6 +30,7 @@ struct ism_dev {
> 	spinlock_t lock; /* protects the ism device */
> 	spinlock_t cmd_lock; /* serializes cmds */
> 	struct list_head list;
>+	struct dibs_dev *dibs;
> 	struct pci_dev *pdev;
> 
> 	struct ism_sba *sba;
>diff --git a/net/dibs/dibs_main.c b/net/dibs/dibs_main.c
>index d91e461f2f06..5345e41ae5e4 100644
>--- a/net/dibs/dibs_main.c
>+++ b/net/dibs/dibs_main.c
>@@ -21,6 +21,15 @@ MODULE_LICENSE("GPL");
> static struct dibs_client *clients[MAX_DIBS_CLIENTS];
> static u8 max_client;
> static DEFINE_MUTEX(clients_lock);
>+struct dibs_dev_list {
>+	struct list_head list;
>+	struct mutex mutex; /* protects dibs device list */
>+};
>+
>+static struct dibs_dev_list dibs_dev_list = {
>+	.list = LIST_HEAD_INIT(dibs_dev_list.list),
>+	.mutex = __MUTEX_INITIALIZER(dibs_dev_list.mutex),
>+};
> 
> int dibs_register_client(struct dibs_client *client)
> {
>@@ -56,6 +65,33 @@ int dibs_unregister_client(struct dibs_client *client)
> }
> EXPORT_SYMBOL_GPL(dibs_unregister_client);
> 
>+struct dibs_dev *dibs_dev_alloc(void)
>+{
>+	struct dibs_dev *dibs;
>+
>+	dibs = kzalloc(sizeof(*dibs), GFP_KERNEL);
>+	return dibs;
>+}
>+EXPORT_SYMBOL_GPL(dibs_dev_alloc);
>+
>+int dibs_dev_add(struct dibs_dev *dibs)
>+{
>+	mutex_lock(&dibs_dev_list.mutex);
>+	list_add(&dibs->list, &dibs_dev_list.list);
>+	mutex_unlock(&dibs_dev_list.mutex);
>+
>+	return 0;
>+}
>+EXPORT_SYMBOL_GPL(dibs_dev_add);
>+
>+void dibs_dev_del(struct dibs_dev *dibs)
>+{
>+	mutex_lock(&dibs_dev_list.mutex);
>+	list_del_init(&dibs->list);
>+	mutex_unlock(&dibs_dev_list.mutex);
>+}
>+EXPORT_SYMBOL_GPL(dibs_dev_del);
>+
> static int __init dibs_init(void)
> {
> 	memset(clients, 0, sizeof(clients));
>-- 
>2.48.1

