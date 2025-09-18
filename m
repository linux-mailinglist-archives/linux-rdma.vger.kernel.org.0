Return-Path: <linux-rdma+bounces-13172-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BDEB49F32
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 04:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B7D4E27FE
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 02:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3612472BF;
	Tue,  9 Sep 2025 02:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SwnrT/pL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EB42BB1D;
	Tue,  9 Sep 2025 02:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384750; cv=none; b=lCUDCxvBt2m+QY8ilPvi3QAyuMUItFvJb593sV59Q1Hx5Pvhuh4+e3g82f++Tqj2nQT8VVaAAWKEjlieKFj/+8/a9Lzmzn/ON2uholRSJ/yoihZX90hvPolmg3I/cnJnEYTibrAktHg8E7AzGdjyRo2J9593NBw7JFDVrFejGlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384750; c=relaxed/simple;
	bh=jzih0fPFRvkmYnkc2Adr4s8WYoGT8lfcE/4rTvyTq4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTMnv7AhX7kG0aoZDMm6wbly1OLEoHcCXgcz98oOxn0UwCQQ4GgXQQkLYG10HKuszp6FigtNY511YlFSh+DUdxs5oj3SqiRVY+yTPzcWycTEpYbnFdN2CUWZ6C1VSIDm20BR7zvxw4vfr36xUMMSH4e58ra7mSOQb/TUSgiooQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SwnrT/pL; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757384744; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=vkBVVKXA8E2Qg6jlYY+/JdYV7StEHfVo+c88j/b2Z9k=;
	b=SwnrT/pLV7+bFVvDXHTVwyGlmmhrnOjRjL/iNi+F8LAiCzuzCRW5lDOUdAMv9ygaeSDXw7sZWfIxqomRnkKjww81Xt+MAfSpbCe/J8N7dz20iTtHLbsDIzpwtQZp9dqu7Erw7RcigSu9bvipKhMvMQI9TzvgsIj/a6QCMTlHfPg=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WnbvpxP_1757384742 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 10:25:43 +0800
Date: Tue, 9 Sep 2025 10:25:42 +0800
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
Subject: Re: [PATCH net-next 13/14] net/dibs: Move data path to dibs layer
Message-ID: <aL-QJr0pBCZmXhf0@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250905145428.1962105-1-wintera@linux.ibm.com>
 <20250905145428.1962105-14-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905145428.1962105-14-wintera@linux.ibm.com>

On 2025-09-05 16:54:26, Alexandra Winter wrote:
>Use struct dibs_dmb instead of struct smc_dmb and move the corresponding
>client tables to dibs_dev. Leave driver specific implementation details
>like sba in the device drivers.
>
>Register and unregister dmbs via dibs_dev_ops. A dmb is dedicated to a
>single client, but a dibs device can have dmbs for more than one client.
>
>Trigger dibs clients via dibs_client_ops->handle_irq(), when data is
>received into a dmb. For dibs_loopback replace scheduling an smcd receive
>tasklet with calling dibs_client_ops->handle_irq().
>
>For loopback devices attach_dmb(), detach_dmb() and move_data() need to
>access the dmb tables, so move those to dibs_dev_ops in this patch as well.
>
>Remove remaining definitions of smc_loopback as they are no longer
>required, now that everything is in dibs_loopback.
>
>Note that struct ism_client and struct ism_dev are still required in smc
>until a follow-on patch moves event handling to dibs. (Loopback does not
>use events).
>
>Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
>---
> drivers/s390/net/ism_drv.c | 121 +++++++----------
> include/linux/dibs.h       | 177 +++++++++++++++++++++++++
> include/linux/ism.h        |  23 ----
> include/net/smc.h          |  22 ----
> net/dibs/dibs_loopback.c   | 257 +++++++++++++++++++++++++++++++++++++
> net/dibs/dibs_loopback.h   |  19 +++
> net/dibs/dibs_main.c       |  56 +++++++-
> net/smc/Makefile           |   1 -
> net/smc/smc_ism.c          |  68 +++++-----
> net/smc/smc_ism.h          |   4 +-
> 10 files changed, 590 insertions(+), 158 deletions(-)
>
>diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
>index 121b3a2be760..346d1ea8650b 100644
>--- a/drivers/s390/net/ism_drv.c
>+++ b/drivers/s390/net/ism_drv.c
>@@ -98,14 +98,6 @@ int ism_unregister_client(struct ism_client *client)
> 		spin_lock_irqsave(&ism->lock, flags);
> 		/* Stop forwarding IRQs and events */
> 		ism->subs[client->id] = NULL;
>-		for (int i = 0; i < ISM_NR_DMBS; ++i) {
>-			if (ism->sba_client_arr[i] == client->id) {
>-				WARN(1, "%s: attempt to unregister '%s' with registered dmb(s)\n",
>-				     __func__, client->name);
>-				rc = -EBUSY;
>-				goto err_reg_dmb;
>-			}
>-		}
> 		spin_unlock_irqrestore(&ism->lock, flags);
> 	}
> 	mutex_unlock(&ism_dev_list.mutex);
>@@ -116,11 +108,6 @@ int ism_unregister_client(struct ism_client *client)
> 		max_client--;
> 	mutex_unlock(&clients_lock);
> 	return rc;
>-
>-err_reg_dmb:
>-	spin_unlock_irqrestore(&ism->lock, flags);
>-	mutex_unlock(&ism_dev_list.mutex);
>-	return rc;
> }
> EXPORT_SYMBOL_GPL(ism_unregister_client);
> 
>@@ -308,15 +295,20 @@ static int ism_query_rgid(struct dibs_dev *dibs, const uuid_t *rgid,
> 	return ism_cmd(ism, &cmd);
> }
> 
>-static void ism_free_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
>+static int ism_max_dmbs(void)
>+{
>+	return ISM_NR_DMBS;
>+}
>+
>+static void ism_free_dmb(struct ism_dev *ism, struct dibs_dmb *dmb)
> {
>-	clear_bit(dmb->sba_idx, ism->sba_bitmap);
>+	clear_bit(dmb->idx, ism->sba_bitmap);
> 	dma_unmap_page(&ism->pdev->dev, dmb->dma_addr, dmb->dmb_len,
> 		       DMA_FROM_DEVICE);
> 	folio_put(virt_to_folio(dmb->cpu_addr));
> }
> 
>-static int ism_alloc_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
>+static int ism_alloc_dmb(struct ism_dev *ism, struct dibs_dmb *dmb)
> {
> 	struct folio *folio;
> 	unsigned long bit;
>@@ -325,16 +317,16 @@ static int ism_alloc_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
> 	if (PAGE_ALIGN(dmb->dmb_len) > dma_get_max_seg_size(&ism->pdev->dev))
> 		return -EINVAL;
> 
>-	if (!dmb->sba_idx) {
>+	if (!dmb->idx) {
> 		bit = find_next_zero_bit(ism->sba_bitmap, ISM_NR_DMBS,
> 					 ISM_DMB_BIT_OFFSET);
> 		if (bit == ISM_NR_DMBS)
> 			return -ENOSPC;
> 
>-		dmb->sba_idx = bit;
>+		dmb->idx = bit;
> 	}
>-	if (dmb->sba_idx < ISM_DMB_BIT_OFFSET ||
>-	    test_and_set_bit(dmb->sba_idx, ism->sba_bitmap))
>+	if (dmb->idx < ISM_DMB_BIT_OFFSET ||
>+	    test_and_set_bit(dmb->idx, ism->sba_bitmap))
> 		return -EINVAL;
> 
> 	folio = folio_alloc(GFP_KERNEL | __GFP_NOWARN | __GFP_NOMEMALLOC |
>@@ -359,13 +351,14 @@ static int ism_alloc_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
> out_free:
> 	kfree(dmb->cpu_addr);
> out_bit:
>-	clear_bit(dmb->sba_idx, ism->sba_bitmap);
>+	clear_bit(dmb->idx, ism->sba_bitmap);
> 	return rc;
> }
> 
>-int ism_register_dmb(struct ism_dev *ism, struct ism_dmb *dmb,
>-		     struct ism_client *client)
>+static int ism_register_dmb(struct dibs_dev *dibs, struct dibs_dmb *dmb,
>+			    struct dibs_client *client)
> {
>+	struct ism_dev *ism = dibs->drv_priv;
> 	union ism_reg_dmb cmd;
> 	unsigned long flags;
> 	int ret;
>@@ -380,10 +373,10 @@ int ism_register_dmb(struct ism_dev *ism, struct ism_dmb *dmb,
> 
> 	cmd.request.dmb = dmb->dma_addr;
> 	cmd.request.dmb_len = dmb->dmb_len;
>-	cmd.request.sba_idx = dmb->sba_idx;
>+	cmd.request.sba_idx = dmb->idx;
> 	cmd.request.vlan_valid = dmb->vlan_valid;
> 	cmd.request.vlan_id = dmb->vlan_id;
>-	cmd.request.rgid = dmb->rgid;
>+	memcpy(&cmd.request.rgid, &dmb->rgid, sizeof(u64));
> 
> 	ret = ism_cmd(ism, &cmd);
> 	if (ret) {
>@@ -391,16 +384,16 @@ int ism_register_dmb(struct ism_dev *ism, struct ism_dmb *dmb,
> 		goto out;
> 	}
> 	dmb->dmb_tok = cmd.response.dmb_tok;
>-	spin_lock_irqsave(&ism->lock, flags);
>-	ism->sba_client_arr[dmb->sba_idx - ISM_DMB_BIT_OFFSET] = client->id;
>-	spin_unlock_irqrestore(&ism->lock, flags);
>+	spin_lock_irqsave(&dibs->lock, flags);
>+	dibs->dmb_clientid_arr[dmb->idx - ISM_DMB_BIT_OFFSET] = client->id;
>+	spin_unlock_irqrestore(&dibs->lock, flags);
> out:
> 	return ret;
> }
>-EXPORT_SYMBOL_GPL(ism_register_dmb);
> 
>-int ism_unregister_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
>+static int ism_unregister_dmb(struct dibs_dev *dibs, struct dibs_dmb *dmb)
> {
>+	struct ism_dev *ism = dibs->drv_priv;
> 	union ism_unreg_dmb cmd;
> 	unsigned long flags;
> 	int ret;
>@@ -411,9 +404,9 @@ int ism_unregister_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
> 
> 	cmd.request.dmb_tok = dmb->dmb_tok;
> 
>-	spin_lock_irqsave(&ism->lock, flags);
>-	ism->sba_client_arr[dmb->sba_idx - ISM_DMB_BIT_OFFSET] = NO_CLIENT;
>-	spin_unlock_irqrestore(&ism->lock, flags);
>+	spin_lock_irqsave(&dibs->lock, flags);
>+	dibs->dmb_clientid_arr[dmb->idx - ISM_DMB_BIT_OFFSET] = NO_DIBS_CLIENT;
>+	spin_unlock_irqrestore(&dibs->lock, flags);
> 
> 	ret = ism_cmd(ism, &cmd);
> 	if (ret && ret != ISM_ERROR)
>@@ -423,7 +416,6 @@ int ism_unregister_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
> out:
> 	return ret;
> }
>-EXPORT_SYMBOL_GPL(ism_unregister_dmb);
> 
> static int ism_add_vlan_id(struct dibs_dev *dibs, u64 vlan_id)
> {
>@@ -459,9 +451,11 @@ static unsigned int max_bytes(unsigned int start, unsigned int len,
> 	return min(boundary - (start & (boundary - 1)), len);
> }
> 
>-int ism_move(struct ism_dev *ism, u64 dmb_tok, unsigned int idx, bool sf,
>-	     unsigned int offset, void *data, unsigned int size)
>+static int ism_move(struct dibs_dev *dibs, u64 dmb_tok, unsigned int idx,
>+		    bool sf, unsigned int offset, void *data,
>+		    unsigned int size)
> {
>+	struct ism_dev *ism = dibs->drv_priv;
> 	unsigned int bytes;
> 	u64 dmb_req;
> 	int ret;
>@@ -482,7 +476,6 @@ int ism_move(struct ism_dev *ism, u64 dmb_tok, unsigned int idx, bool sf,
> 
> 	return 0;
> }
>-EXPORT_SYMBOL_GPL(ism_move);
> 
> static u16 ism_get_chid(struct dibs_dev *dibs)
> {
>@@ -518,14 +511,17 @@ static irqreturn_t ism_handle_irq(int irq, void *data)
> {
> 	struct ism_dev *ism = data;
> 	unsigned long bit, end;
>+	struct dibs_dev *dibs;
> 	unsigned long *bv;
> 	u16 dmbemask;
> 	u8 client_id;
> 
>+	dibs = ism->dibs;
>+
> 	bv = (void *) &ism->sba->dmb_bits[ISM_DMB_WORD_OFFSET];
> 	end = sizeof(ism->sba->dmb_bits) * BITS_PER_BYTE - ISM_DMB_BIT_OFFSET;
> 
>-	spin_lock(&ism->lock);
>+	spin_lock(&dibs->lock);
> 	ism->sba->s = 0;
> 	barrier();
> 	for (bit = 0;;) {
>@@ -537,10 +533,13 @@ static irqreturn_t ism_handle_irq(int irq, void *data)
> 		dmbemask = ism->sba->dmbe_mask[bit + ISM_DMB_BIT_OFFSET];
> 		ism->sba->dmbe_mask[bit + ISM_DMB_BIT_OFFSET] = 0;
> 		barrier();
>-		client_id = ism->sba_client_arr[bit];
>-		if (unlikely(client_id == NO_CLIENT || !ism->subs[client_id]))
>+		client_id = dibs->dmb_clientid_arr[bit];
>+		if (unlikely(client_id == NO_DIBS_CLIENT ||
>+			     !dibs->subs[client_id]))
> 			continue;
>-		ism->subs[client_id]->handle_irq(ism, bit + ISM_DMB_BIT_OFFSET, dmbemask);
>+		dibs->subs[client_id]->ops->handle_irq(dibs,
>+						       bit + ISM_DMB_BIT_OFFSET,
>+						       dmbemask);
> 	}
> 
> 	if (ism->sba->e) {
>@@ -548,13 +547,17 @@ static irqreturn_t ism_handle_irq(int irq, void *data)
> 		barrier();
> 		ism_handle_event(ism);
> 	}
>-	spin_unlock(&ism->lock);
>+	spin_unlock(&dibs->lock);
> 	return IRQ_HANDLED;
> }
> 
> static const struct dibs_dev_ops ism_ops = {
> 	.get_fabric_id = ism_get_chid,
> 	.query_remote_gid = ism_query_rgid,
>+	.max_dmbs = ism_max_dmbs,
>+	.register_dmb = ism_register_dmb,
>+	.unregister_dmb = ism_unregister_dmb,
>+	.move_data = ism_move,
> 	.add_vlan_id = ism_add_vlan_id,
> 	.del_vlan_id = ism_del_vlan_id,
> };
>@@ -568,15 +571,10 @@ static int ism_dev_init(struct ism_dev *ism)
> 	if (ret <= 0)
> 		goto out;
> 
>-	ism->sba_client_arr = kzalloc(ISM_NR_DMBS, GFP_KERNEL);
>-	if (!ism->sba_client_arr)
>-		goto free_vectors;
>-	memset(ism->sba_client_arr, NO_CLIENT, ISM_NR_DMBS);
>-
> 	ret = request_irq(pci_irq_vector(pdev, 0), ism_handle_irq, 0,
> 			  pci_name(pdev), ism);
> 	if (ret)
>-		goto free_client_arr;
>+		goto free_vectors;
> 
> 	ret = register_sba(ism);
> 	if (ret)
>@@ -605,8 +603,6 @@ static int ism_dev_init(struct ism_dev *ism)
> 	unregister_sba(ism);
> free_irq:
> 	free_irq(pci_irq_vector(pdev, 0), ism);
>-free_client_arr:
>-	kfree(ism->sba_client_arr);
> free_vectors:
> 	pci_free_irq_vectors(pdev);
> out:
>@@ -629,7 +625,6 @@ static void ism_dev_exit(struct ism_dev *ism)
> 	unregister_ieq(ism);
> 	unregister_sba(ism);
> 	free_irq(pci_irq_vector(pdev, 0), ism);
>-	kfree(ism->sba_client_arr);
> 	pci_free_irq_vectors(pdev);
> 	list_del_init(&ism->list);
> 	mutex_unlock(&ism_dev_list.mutex);
>@@ -677,6 +672,9 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 	dibs->drv_priv = ism;
> 	dibs->ops = &ism_ops;
> 
>+	/* enable ism device, but any interrupts and events will be ignored
>+	 * before dibs_dev_add() adds it to any clients.
>+	 */
> 	ret = ism_dev_init(ism);
> 	if (ret)
> 		goto err_dibs;
>@@ -766,17 +764,6 @@ module_exit(ism_exit);
> /*************************** SMC-D Implementation *****************************/
> 
> #if IS_ENABLED(CONFIG_SMC)
>-static int smcd_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
>-			     void *client)
>-{
>-	return ism_register_dmb(smcd->priv, (struct ism_dmb *)dmb, client);
>-}
>-
>-static int smcd_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
>-{
>-	return ism_unregister_dmb(smcd->priv, (struct ism_dmb *)dmb);
>-}
>-
> static int ism_signal_ieq(struct ism_dev *ism, u64 rgid, u32 trigger_irq,
> 			  u32 event_code, u64 info)
> {
>@@ -801,18 +788,8 @@ static int smcd_signal_ieq(struct smcd_dev *smcd, struct smcd_gid *rgid,
> 			      trigger_irq, event_code, info);
> }
> 
>-static int smcd_move(struct smcd_dev *smcd, u64 dmb_tok, unsigned int idx,
>-		     bool sf, unsigned int offset, void *data,
>-		     unsigned int size)
>-{
>-	return ism_move(smcd->priv, dmb_tok, idx, sf, offset, data, size);
>-}
>-
> static const struct smcd_ops ism_smcd_ops = {
>-	.register_dmb = smcd_register_dmb,
>-	.unregister_dmb = smcd_unregister_dmb,
> 	.signal_event = smcd_signal_ieq,
>-	.move_data = smcd_move,
> };
> 
> const struct smcd_ops *ism_get_smcd_ops(void)
>diff --git a/include/linux/dibs.h b/include/linux/dibs.h
>index c75a40fe3039..be009c614205 100644
>--- a/include/linux/dibs.h
>+++ b/include/linux/dibs.h
>@@ -36,12 +36,44 @@
>  * clients.
>  */
> 
>+/* DMB - Direct Memory Buffer
>+ * --------------------------
>+ * A dibs client provides a dmb as input buffer for a local receiving
>+ * dibs device for exactly one (remote) sending dibs device. Only this
>+ * sending device can send data into this dmb using move_data(). Sender
>+ * and receiver can be the same device. A dmb belongs to exactly one client.
>+ */
>+struct dibs_dmb {
>+	/* tok - Token for this dmb
>+	 * Used by remote and local devices and clients to address this dmb.
>+	 * Provided by dibs fabric. Unique per dibs fabric.
>+	 */
>+	u64 dmb_tok;
>+	/* rgid - GID of designated remote sending device */
>+	uuid_t rgid;
>+	/* cpu_addr - buffer address */
>+	void *cpu_addr;
>+	/* len - buffer length */
>+	u32 dmb_len;
>+	/* idx - Index of this DMB on this receiving device */
>+	u32 idx;
>+	/* VLAN support (deprecated)
>+	 * In order to write into a vlan-tagged dmb, the remote device needs
>+	 * to belong to the this vlan
>+	 */
>+	u32 vlan_valid;
>+	u32 vlan_id;
>+	/* optional, used by device driver */
>+	dma_addr_t dma_addr;
>+};
>+
> struct dibs_dev;
> 
> /* DIBS client
>  * -----------
>  */
> #define MAX_DIBS_CLIENTS	8
>+#define NO_DIBS_CLIENT		0xff
> /* All dibs clients have access to all dibs devices.
>  * A dibs client provides the following functions to be called by dibs layer or
>  * dibs device drivers:
>@@ -69,6 +101,22 @@ struct dibs_client_ops {
> 	 * The device is no longer usable by this client after this call.
> 	 */
> 	void (*del_dev)(struct dibs_dev *dev);
>+	/**
>+	 * handle_irq() - Handle signaling for a DMB
>+	 * @dev: device that owns the dmb
>+	 * @idx: Index of the dmb that got signalled
>+	 * @dmbemask: signaling mask of the dmb
>+	 *
>+	 * Handle signaling for a dmb that was registered by this client
>+	 * for this device.
>+	 * The dibs device can coalesce multiple signaling triggers into a
>+	 * single call of handle_irq(). dmbemask can be used to indicate
>+	 * different kinds of triggers.
>+	 *
>+	 * Context: Called in IRQ context by dibs device driver
>+	 */
>+	void (*handle_irq)(struct dibs_dev *dev, unsigned int idx,
>+			   u16 dmbemask);
> };
> 
> struct dibs_client {
>@@ -147,6 +195,77 @@ struct dibs_dev_ops {
> 	 */
> 	int (*query_remote_gid)(struct dibs_dev *dev, const uuid_t *rgid,
> 				u32 vid_valid, u32 vid);
>+	/**
>+	 * max_dmbs()
>+	 * Return: Max number of DMBs that can be registered for this kind of
>+	 *	   dibs_dev
>+	 */
>+	int (*max_dmbs)(void);
>+	/**
>+	 * register_dmb() - allocate and register a dmb
>+	 * @dev: dibs device
>+	 * @dmb: dmb struct to be registered
>+	 * @client: dibs client
>+	 * @vid: VLAN id; deprecated, ignored if device does not support vlan
>+	 *
>+	 * The following fields of dmb must provide valid input:
>+	 *	@rgid: gid of remote user device
>+	 *	@dmb_len: buffer length
>+	 *	@idx: Optionally:requested idx (if non-zero)
>+	 *	@vlan_valid: if zero, vlan_id will be ignored;
>+	 *		     deprecated, ignored if device does not support vlan
>+	 *	@vlan_id: deprecated, ignored if device does not support vlan
>+	 * Upon return in addition the following fields will be valid:
>+	 *	@dmb_tok: for usage by remote and local devices and clients
>+	 *	@cpu_addr: allocated buffer
>+	 *	@idx: dmb index, unique per dibs device
>+	 *	@dma_addr: to be used by device driver,if applicable
>+	 *
>+	 * Allocate a dmb buffer and register it with this device and for this
>+	 * client.
>+	 * Return: zero on success
>+	 */
>+	int (*register_dmb)(struct dibs_dev *dev, struct dibs_dmb *dmb,
>+			    struct dibs_client *client);
>+	/**
>+	 * unregister_dmb() - unregister and free a dmb
>+	 * @dev: dibs device
>+	 * @dmb: dmb struct to be unregistered
>+	 * The following fields of dmb must provide valid input:
>+	 *	@dmb_tok
>+	 *	@cpu_addr
>+	 *	@idx
>+	 *
>+	 * Free dmb.cpu_addr and unregister the dmb from this device.
>+	 * Return: zero on success
>+	 */
>+	int (*unregister_dmb)(struct dibs_dev *dev, struct dibs_dmb *dmb);
>+	/**
>+	 * move_data() - write into a remote dmb
>+	 * @dev: Local sending dibs device
>+	 * @dmb_tok: Token of the remote dmb
>+	 * @idx: signaling index in dmbemask
>+	 * @sf: signaling flag;
>+	 *      if true, idx will be turned on at target dmbemask mask
>+	 *      and target device will be signaled.
>+	 * @offset: offset within target dmb
>+	 * @data: pointer to data to be sent
>+	 * @size: length of data to be sent, can be zero.
>+	 *
>+	 * Use dev to write data of size at offset into a remote dmb
>+	 * identified by dmb_tok. Data is moved synchronously, *data can
>+	 * be freed when this function returns.
>+	 *
>+	 * If signaling flag (sf) is true, bit number idx bit will be turned
>+	 * on in the dmbemask mask when handle_irq() is called at the remote
>+	 * dibs client that owns the target dmb. The target device may chose
>+	 * to coalesce the signaling triggers of multiple move_data() calls
>+	 * to the same target dmb into a single handle_irq() call.
>+	 * Return: zero on success
>+	 */
>+	int (*move_data)(struct dibs_dev *dev, u64 dmb_tok, unsigned int idx,
>+			 bool sf, unsigned int offset, void *data,
>+			 unsigned int size);
> 	/**
> 	 * add_vlan_id() - add dibs device to vlan (optional, deprecated)
> 	 * @dev: dibs device
>@@ -166,6 +285,55 @@ struct dibs_dev_ops {
> 	 * Return: zero on success
> 	 */
> 	int (*del_vlan_id)(struct dibs_dev *dev, u64 vlan_id);
>+	/**
>+	 * support_mmapped_rdmb() - can this device provide memory mapped
>+	 *			    remote dmbs? (optional)
>+	 * @dev: dibs device
>+	 *
>+	 * A dibs device can provide a kernel address + length, that represent
>+	 * a remote target dmb (like MMIO). Alternatively to calling
>+	 * move_data(), a dibs client can write into such a ghost-send-buffer
>+	 * (= to this kernel address) and the data will automatically
>+	 * immediately appear in the target dmb, even without calling
>+	 * move_data().
>+	 *
>+	 * Either all 3 function pointers for support_dmb_nocopy(),
>+	 * attach_dmb() and detach_dmb() are defined, or all of them must
>+	 * be NULL.
>+	 *
>+	 * Return: non-zero, if memory mapped remote dmbs are supported.
>+	 */
>+	int (*support_mmapped_rdmb)(struct dibs_dev *dev);
>+	/**
>+	 * attach_dmb() - attach local memory to a remote dmb
>+	 * @dev: Local sending ism device
>+	 * @dmb: all other parameters are passed in the form of a
>+	 *	 dmb struct
>+	 *	 TODO: (THIS IS CONFUSING, should be changed)
>+	 *  dmb_tok: (in) Token of the remote dmb, we want to attach to
>+	 *  cpu_addr: (out) MMIO address
>+	 *  dma_addr: (out) MMIO address (if applicable, invalid otherwise)
>+	 *  dmb_len: (out) length of local MMIO region,
>+	 *           equal to length of remote DMB.
>+	 *  sba_idx: (out) index of remote dmb (NOT HELPFUL, should be removed)
>+	 *
>+	 * Provides a memory address to the sender that can be used to
>+	 * directly write into the remote dmb.
>+	 * Memory is available until detach_dmb is called
>+	 *
>+	 * Return: Zero upon success, Error code otherwise
>+	 */
>+	int (*attach_dmb)(struct dibs_dev *dev, struct dibs_dmb *dmb);
>+	/**
>+	 * detach_dmb() - Detach the ghost buffer from a remote dmb
>+	 * @dev: ism device
>+	 * @token: dmb token of the remote dmb
>+	 *
>+	 * No need to free cpu_addr.
>+	 *
>+	 * Return: Zero upon success, Error code otherwise
>+	 */
>+	int (*detach_dmb)(struct dibs_dev *dev, u64 token);
> };
> 
> struct dibs_dev {
>@@ -179,6 +347,15 @@ struct dibs_dev {
> 
> 	/* priv pointer per client; for client usage only */
> 	void *priv[MAX_DIBS_CLIENTS];
>+
>+	/* get this lock before accessing any of the fields below */
>+	spinlock_t lock;
>+	/* array of client ids indexed by dmb idx;
>+	 * can be used as indices into priv and subs arrays
>+	 */
>+	u8 *dmb_clientid_arr;
>+	/* Sparse array of all ISM clients */
>+	struct dibs_client *subs[MAX_DIBS_CLIENTS];
> };
> 
> static inline void dibs_set_priv(struct dibs_dev *dev,
>diff --git a/include/linux/ism.h b/include/linux/ism.h
>index a926dd61b5a1..b7feb4dcd5a8 100644
>--- a/include/linux/ism.h
>+++ b/include/linux/ism.h
>@@ -11,17 +11,6 @@
> 
> #include <linux/workqueue.h>
> 
>-struct ism_dmb {
>-	u64 dmb_tok;
>-	u64 rgid;
>-	u32 dmb_len;
>-	u32 sba_idx;
>-	u32 vlan_valid;
>-	u32 vlan_id;
>-	void *cpu_addr;
>-	dma_addr_t dma_addr;
>-};
>-
> /* Unless we gain unexpected popularity, this limit should hold for a while */
> #define MAX_CLIENTS		8
> #define ISM_NR_DMBS		1920
>@@ -36,7 +25,6 @@ struct ism_dev {
> 	struct ism_sba *sba;
> 	dma_addr_t sba_dma_addr;
> 	DECLARE_BITMAP(sba_bitmap, ISM_NR_DMBS);
>-	u8 *sba_client_arr;	/* entries are indices into 'clients' array */
> 	void *priv[MAX_CLIENTS];
> 
> 	struct ism_eq *ieq;
>@@ -58,11 +46,6 @@ struct ism_event {
> struct ism_client {
> 	const char *name;
> 	void (*handle_event)(struct ism_dev *dev, struct ism_event *event);
>-	/* Parameter dmbemask contains a bit vector with updated DMBEs, if sent
>-	 * via ism_move_data(). Callback function must handle all active bits
>-	 * indicated by dmbemask.
>-	 */
>-	void (*handle_irq)(struct ism_dev *dev, unsigned int bit, u16 dmbemask);
> 	/* Private area - don't touch! */
> 	u8 id;
> };
>@@ -79,12 +62,6 @@ static inline void ism_set_priv(struct ism_dev *dev, struct ism_client *client,
> 	dev->priv[client->id] = priv;
> }
> 
>-int  ism_register_dmb(struct ism_dev *dev, struct ism_dmb *dmb,
>-		      struct ism_client *client);
>-int  ism_unregister_dmb(struct ism_dev *dev, struct ism_dmb *dmb);
>-int  ism_move(struct ism_dev *dev, u64 dmb_tok, unsigned int idx, bool sf,
>-	      unsigned int offset, void *data, unsigned int size);
>-
> const struct smcd_ops *ism_get_smcd_ops(void);
> 
> #endif	/* _ISM_H */
>diff --git a/include/net/smc.h b/include/net/smc.h
>index 5bd135fb4d49..8e3debcf7db5 100644
>--- a/include/net/smc.h
>+++ b/include/net/smc.h
>@@ -28,17 +28,6 @@ struct smc_hashinfo {
> };
> 
> /* SMCD/ISM device driver interface */
>-struct smcd_dmb {
>-	u64 dmb_tok;
>-	u64 rgid;
>-	u32 dmb_len;
>-	u32 sba_idx;
>-	u32 vlan_valid;
>-	u32 vlan_id;
>-	void *cpu_addr;
>-	dma_addr_t dma_addr;
>-};
>-
> #define ISM_EVENT_DMB	0
> #define ISM_EVENT_GID	1
> #define ISM_EVENT_SWR	2
>@@ -53,25 +42,14 @@ struct smcd_gid {
> };
> 
> struct smcd_ops {
>-	int (*register_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb,
>-			    void *client);
>-	int (*unregister_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb);
>-	int (*move_data)(struct smcd_dev *dev, u64 dmb_tok, unsigned int idx,
>-			 bool sf, unsigned int offset, void *data,
>-			 unsigned int size);
>-
> 	/* optional operations */
> 	int (*signal_event)(struct smcd_dev *dev, struct smcd_gid *rgid,
> 			    u32 trigger_irq, u32 event_code, u64 info);
>-	int (*support_dmb_nocopy)(struct smcd_dev *dev);
>-	int (*attach_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb);
>-	int (*detach_dmb)(struct smcd_dev *dev, u64 token);
> };
> 
> struct smcd_dev {
> 	const struct smcd_ops *ops;
> 	void *priv;
>-	void *client;
> 	struct dibs_dev *dibs;
> 	struct list_head list;
> 	spinlock_t lock;
>diff --git a/net/dibs/dibs_loopback.c b/net/dibs/dibs_loopback.c
>index 6b53e626a6d1..3270585a07c0 100644
>--- a/net/dibs/dibs_loopback.c
>+++ b/net/dibs/dibs_loopback.c
>@@ -9,12 +9,18 @@
>  *
>  */
> 
>+#include <linux/bitops.h>
>+#include <linux/device.h>
> #include <linux/dibs.h>
> #include <linux/slab.h>
>+#include <linux/spinlock.h>
> #include <linux/types.h>
> 
> #include "dibs_loopback.h"
> 
>+#define DIBS_LO_SUPPORT_NOCOPY	0x1
>+#define DIBS_DMA_ADDR_INVALID	(~(dma_addr_t)0)
>+
> static const char dibs_lo_dev_name[] = "lo";
> /* global loopback device */
> static struct dibs_lo_dev *lo_dev;
>@@ -33,11 +39,259 @@ static int dibs_lo_query_rgid(struct dibs_dev *dibs, const uuid_t *rgid,
> 	return 0;
> }
> 
>+static int dibs_lo_max_dmbs(void)
>+{
>+	return DIBS_LO_MAX_DMBS;
>+}
>+
>+static int dibs_lo_register_dmb(struct dibs_dev *dibs, struct dibs_dmb *dmb,
>+				struct dibs_client *client)
>+{
>+	struct dibs_lo_dmb_node *dmb_node, *tmp_node;
>+	struct dibs_lo_dev *ldev;
>+	unsigned long flags;
>+	int sba_idx, rc;
>+
>+	ldev = dibs->drv_priv;
>+	sba_idx = dmb->idx;
>+	/* check space for new dmb */
>+	for_each_clear_bit(sba_idx, ldev->sba_idx_mask, DIBS_LO_MAX_DMBS) {
>+		if (!test_and_set_bit(sba_idx, ldev->sba_idx_mask))
>+			break;
>+	}
>+	if (sba_idx == DIBS_LO_MAX_DMBS)
>+		return -ENOSPC;
>+
>+	dmb_node = kzalloc(sizeof(*dmb_node), GFP_KERNEL);
>+	if (!dmb_node) {
>+		rc = -ENOMEM;
>+		goto err_bit;
>+	}
>+
>+	dmb_node->sba_idx = sba_idx;
>+	dmb_node->len = dmb->dmb_len;
>+	dmb_node->cpu_addr = kzalloc(dmb_node->len, GFP_KERNEL |
>+				     __GFP_NOWARN | __GFP_NORETRY |
>+				     __GFP_NOMEMALLOC);
>+	if (!dmb_node->cpu_addr) {
>+		rc = -ENOMEM;
>+		goto err_node;
>+	}
>+	dmb_node->dma_addr = DIBS_DMA_ADDR_INVALID;
>+	refcount_set(&dmb_node->refcnt, 1);
>+
>+again:
>+	/* add new dmb into hash table */
>+	get_random_bytes(&dmb_node->token, sizeof(dmb_node->token));
>+	write_lock_bh(&ldev->dmb_ht_lock);
>+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_node->token) {
>+		if (tmp_node->token == dmb_node->token) {
>+			write_unlock_bh(&ldev->dmb_ht_lock);
>+			goto again;
>+		}
>+	}
>+	hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
>+	write_unlock_bh(&ldev->dmb_ht_lock);
>+	atomic_inc(&ldev->dmb_cnt);
>+
>+	dmb->idx = dmb_node->sba_idx;
>+	dmb->dmb_tok = dmb_node->token;
>+	dmb->cpu_addr = dmb_node->cpu_addr;
>+	dmb->dma_addr = dmb_node->dma_addr;
>+	dmb->dmb_len = dmb_node->len;
>+
>+	spin_lock_irqsave(&dibs->lock, flags);
>+	dibs->dmb_clientid_arr[sba_idx] = client->id;
>+	spin_unlock_irqrestore(&dibs->lock, flags);
>+
>+	return 0;
>+
>+err_node:
>+	kfree(dmb_node);
>+err_bit:
>+	clear_bit(sba_idx, ldev->sba_idx_mask);
>+	return rc;
>+}
>+
>+static void __dibs_lo_unregister_dmb(struct dibs_lo_dev *ldev,
>+				     struct dibs_lo_dmb_node *dmb_node)
>+{
>+	/* remove dmb from hash table */
>+	write_lock_bh(&ldev->dmb_ht_lock);
>+	hash_del(&dmb_node->list);
>+	write_unlock_bh(&ldev->dmb_ht_lock);
>+
>+	clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
>+	kvfree(dmb_node->cpu_addr);
>+	kfree(dmb_node);
>+
>+	if (atomic_dec_and_test(&ldev->dmb_cnt))
>+		wake_up(&ldev->ldev_release);
>+}
>+
>+static int dibs_lo_unregister_dmb(struct dibs_dev *dibs, struct dibs_dmb *dmb)
>+{
>+	struct dibs_lo_dmb_node *dmb_node = NULL, *tmp_node;
>+	struct dibs_lo_dev *ldev;
>+	unsigned long flags;
>+
>+	ldev = dibs->drv_priv;
>+
>+	/* find dmb from hash table */
>+	read_lock_bh(&ldev->dmb_ht_lock);
>+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
>+		if (tmp_node->token == dmb->dmb_tok) {
>+			dmb_node = tmp_node;
>+			break;
>+		}
>+	}
>+	read_unlock_bh(&ldev->dmb_ht_lock);
>+	if (!dmb_node)
>+		return -EINVAL;
>+
>+	if (refcount_dec_and_test(&dmb_node->refcnt)) {
>+		spin_lock_irqsave(&dibs->lock, flags);
>+		dibs->dmb_clientid_arr[dmb_node->sba_idx] = NO_DIBS_CLIENT;
>+		spin_unlock_irqrestore(&dibs->lock, flags);
>+
>+		__dibs_lo_unregister_dmb(ldev, dmb_node);
>+	}
>+	return 0;
>+}
>+
>+static int dibs_lo_support_dmb_nocopy(struct dibs_dev *dibs)
>+{
>+	return DIBS_LO_SUPPORT_NOCOPY;
>+}
>+
>+static int dibs_lo_attach_dmb(struct dibs_dev *dibs, struct dibs_dmb *dmb)
>+{
>+	struct dibs_lo_dmb_node *dmb_node = NULL, *tmp_node;
>+	struct dibs_lo_dev *ldev;
>+
>+	ldev = dibs->drv_priv;
>+
>+	/* find dmb_node according to dmb->dmb_tok */
>+	read_lock_bh(&ldev->dmb_ht_lock);
>+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
>+		if (tmp_node->token == dmb->dmb_tok) {
>+			dmb_node = tmp_node;
>+			break;
>+		}
>+	}
>+	if (!dmb_node) {
>+		read_unlock_bh(&ldev->dmb_ht_lock);
>+		return -EINVAL;
>+	}
>+	read_unlock_bh(&ldev->dmb_ht_lock);
>+
>+	if (!refcount_inc_not_zero(&dmb_node->refcnt))
>+		/* the dmb is being unregistered, but has
>+		 * not been removed from the hash table.
>+		 */
>+		return -EINVAL;
>+
>+	/* provide dmb information */
>+	dmb->idx = dmb_node->sba_idx;
>+	dmb->dmb_tok = dmb_node->token;
>+	dmb->cpu_addr = dmb_node->cpu_addr;
>+	dmb->dma_addr = dmb_node->dma_addr;
>+	dmb->dmb_len = dmb_node->len;
>+	return 0;
>+}
>+
>+static int dibs_lo_detach_dmb(struct dibs_dev *dibs, u64 token)
>+{
>+	struct dibs_lo_dmb_node *dmb_node = NULL, *tmp_node;
>+	struct dibs_lo_dev *ldev;
>+
>+	ldev = dibs->drv_priv;
>+
>+	/* find dmb_node according to dmb->dmb_tok */
>+	read_lock_bh(&ldev->dmb_ht_lock);
>+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, token) {
>+		if (tmp_node->token == token) {
>+			dmb_node = tmp_node;
>+			break;
>+		}
>+	}
>+	if (!dmb_node) {
>+		read_unlock_bh(&ldev->dmb_ht_lock);
>+		return -EINVAL;
>+	}
>+	read_unlock_bh(&ldev->dmb_ht_lock);
>+
>+	if (refcount_dec_and_test(&dmb_node->refcnt))
>+		__dibs_lo_unregister_dmb(ldev, dmb_node);
>+	return 0;
>+}
>+
>+static int dibs_lo_move_data(struct dibs_dev *dibs, u64 dmb_tok,
>+			     unsigned int idx, bool sf, unsigned int offset,
>+			     void *data, unsigned int size)
>+{
>+	struct dibs_lo_dmb_node *rmb_node = NULL, *tmp_node;
>+	struct dibs_lo_dev *ldev;
>+	u16 s_mask;
>+	u8 client_id;
>+	u32 sba_idx;
>+
>+	ldev = dibs->drv_priv;
>+
>+	read_lock_bh(&ldev->dmb_ht_lock);
>+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_tok) {
>+		if (tmp_node->token == dmb_tok) {
>+			rmb_node = tmp_node;
>+			break;
>+		}
>+	}
>+	if (!rmb_node) {
>+		read_unlock_bh(&ldev->dmb_ht_lock);
>+		return -EINVAL;
>+	}
>+	memcpy((char *)rmb_node->cpu_addr + offset, data, size);
>+	sba_idx = rmb_node->sba_idx;
>+	read_unlock_bh(&ldev->dmb_ht_lock);
>+
>+	if (!sf)
>+		return 0;
>+
>+	spin_lock(&dibs->lock);
>+	client_id = dibs->dmb_clientid_arr[sba_idx];
>+	s_mask = ror16(0x1000, idx);
>+	if (likely(client_id != NO_DIBS_CLIENT && dibs->subs[client_id]))
>+		dibs->subs[client_id]->ops->handle_irq(dibs, sba_idx, s_mask);
>+	spin_unlock(&dibs->lock);
>+
>+	return 0;
>+}
>+
> static const struct dibs_dev_ops dibs_lo_ops = {
> 	.get_fabric_id = dibs_lo_get_fabric_id,
> 	.query_remote_gid = dibs_lo_query_rgid,
>+	.max_dmbs = dibs_lo_max_dmbs,
>+	.register_dmb = dibs_lo_register_dmb,
>+	.unregister_dmb = dibs_lo_unregister_dmb,
>+	.move_data = dibs_lo_move_data,
>+	.support_mmapped_rdmb = dibs_lo_support_dmb_nocopy,
>+	.attach_dmb = dibs_lo_attach_dmb,
>+	.detach_dmb = dibs_lo_detach_dmb,
> };
> 
>+static void dibs_lo_dev_init(struct dibs_lo_dev *ldev)
>+{
>+	rwlock_init(&ldev->dmb_ht_lock);
>+	hash_init(ldev->dmb_ht);
>+	atomic_set(&ldev->dmb_cnt, 0);
>+	init_waitqueue_head(&ldev->ldev_release);
>+}
>+
>+static void dibs_lo_dev_exit(struct dibs_lo_dev *ldev)
>+{
>+	if (atomic_read(&ldev->dmb_cnt))
>+		wait_event(ldev->ldev_release, !atomic_read(&ldev->dmb_cnt));
>+}
>+
> static int dibs_lo_dev_probe(void)
> {
> 	struct dibs_lo_dev *ldev;
>@@ -56,6 +310,7 @@ static int dibs_lo_dev_probe(void)
> 
> 	ldev->dibs = dibs;
> 	dibs->drv_priv = ldev;
>+	dibs_lo_dev_init(ldev);
> 	uuid_gen(&dibs->gid);
> 	dibs->ops = &dibs_lo_ops;
> 
>@@ -69,6 +324,7 @@ static int dibs_lo_dev_probe(void)
> 	return 0;
> 
> err_reg:
>+	kfree(dibs->dmb_clientid_arr);
> 	/* pairs with dibs_dev_alloc() */
> 	put_device(&dibs->dev);
> 	kfree(ldev);
>@@ -82,6 +338,7 @@ static void dibs_lo_dev_remove(void)
> 		return;
> 
> 	dibs_dev_del(lo_dev->dibs);
>+	dibs_lo_dev_exit(lo_dev);
> 	/* pairs with dibs_dev_alloc() */
> 	put_device(&lo_dev->dibs->dev);
> 	kfree(lo_dev);
>diff --git a/net/dibs/dibs_loopback.h b/net/dibs/dibs_loopback.h
>index fd03b6333a24..0664f6a8e662 100644
>--- a/net/dibs/dibs_loopback.h
>+++ b/net/dibs/dibs_loopback.h
>@@ -13,13 +13,32 @@
> #define _DIBS_LOOPBACK_H
> 
> #include <linux/dibs.h>
>+#include <linux/hashtable.h>
>+#include <linux/spinlock.h>
> #include <linux/types.h>
> #include <linux/wait.h>
> 
> #if IS_ENABLED(CONFIG_DIBS_LO)
>+#define DIBS_LO_DMBS_HASH_BITS	12
>+#define DIBS_LO_MAX_DMBS	5000
>+
>+struct dibs_lo_dmb_node {
>+	struct hlist_node list;
>+	u64 token;
>+	u32 len;
>+	u32 sba_idx;
>+	void *cpu_addr;
>+	dma_addr_t dma_addr;
>+	refcount_t refcnt;
>+};
> 
> struct dibs_lo_dev {
> 	struct dibs_dev *dibs;
>+	atomic_t dmb_cnt;
>+	rwlock_t dmb_ht_lock;
>+	DECLARE_BITMAP(sba_idx_mask, DIBS_LO_MAX_DMBS);
>+	DECLARE_HASHTABLE(dmb_ht, DIBS_LO_DMBS_HASH_BITS);
>+	wait_queue_head_t ldev_release;
> };
> 
> int dibs_loopback_init(void);
>diff --git a/net/dibs/dibs_main.c b/net/dibs/dibs_main.c
>index f20ed0594a51..aacb3ea7825a 100644
>--- a/net/dibs/dibs_main.c
>+++ b/net/dibs/dibs_main.c
>@@ -36,6 +36,16 @@ static struct dibs_dev_list dibs_dev_list = {
> 	.mutex = __MUTEX_INITIALIZER(dibs_dev_list.mutex),
> };
> 
>+static void dibs_setup_forwarding(struct dibs_client *client,
>+				  struct dibs_dev *dibs)
>+{
>+	unsigned long flags;
>+
>+	spin_lock_irqsave(&dibs->lock, flags);
>+	dibs->subs[client->id] = client;
>+	spin_unlock_irqrestore(&dibs->lock, flags);
>+}
>+
> int dibs_register_client(struct dibs_client *client)
> {
> 	struct dibs_dev *dibs;
>@@ -60,6 +70,7 @@ int dibs_register_client(struct dibs_client *client)
> 		list_for_each_entry(dibs, &dibs_dev_list.list, list) {
> 			dibs->priv[i] = NULL;
> 			client->ops->add_dev(dibs);
>+			dibs_setup_forwarding(client, dibs);
> 		}
> 	}
> 	mutex_unlock(&dibs_dev_list.mutex);
>@@ -71,10 +82,25 @@ EXPORT_SYMBOL_GPL(dibs_register_client);
> int dibs_unregister_client(struct dibs_client *client)
> {
> 	struct dibs_dev *dibs;
>+	unsigned long flags;
>+	int max_dmbs;
> 	int rc = 0;
> 
> 	mutex_lock(&dibs_dev_list.mutex);
> 	list_for_each_entry(dibs, &dibs_dev_list.list, list) {
>+		spin_lock_irqsave(&dibs->lock, flags);
>+		max_dmbs = dibs->ops->max_dmbs();
>+		for (int i = 0; i < max_dmbs; ++i) {
>+			if (dibs->dmb_clientid_arr[i] == client->id) {
>+				WARN(1, "%s: attempt to unregister '%s' with registered dmb(s)\n",
>+				     __func__, client->name);
>+				rc = -EBUSY;
>+				goto err_reg_dmb;
>+			}
>+		}
>+		/* Stop forwarding IRQs */
>+		dibs->subs[client->id] = NULL;
>+		spin_unlock_irqrestore(&dibs->lock, flags);
> 		clients[client->id]->ops->del_dev(dibs);
> 		dibs->priv[client->id] = NULL;
> 	}
>@@ -87,6 +113,11 @@ int dibs_unregister_client(struct dibs_client *client)
> 
> 	mutex_unlock(&dibs_dev_list.mutex);
> 	return rc;
>+
>+err_reg_dmb:
>+	spin_unlock_irqrestore(&dibs->lock, flags);
>+	mutex_unlock(&dibs_dev_list.mutex);
>+	return rc;
> }
> EXPORT_SYMBOL_GPL(dibs_unregister_client);
> 
>@@ -150,11 +181,19 @@ static const struct attribute_group dibs_dev_attr_group = {
> 
> int dibs_dev_add(struct dibs_dev *dibs)
> {
>+	int max_dmbs;
> 	int i, ret;
> 
>+	max_dmbs = dibs->ops->max_dmbs();
>+	spin_lock_init(&dibs->lock);
>+	dibs->dmb_clientid_arr = kzalloc(max_dmbs, GFP_KERNEL);
>+	if (!dibs->dmb_clientid_arr)
>+		return -ENOMEM;
>+	memset(dibs->dmb_clientid_arr, NO_DIBS_CLIENT, max_dmbs);
>+
> 	ret = device_add(&dibs->dev);
> 	if (ret)
>-		return ret;
>+		goto free_client_arr;
> 
> 	ret = sysfs_create_group(&dibs->dev.kobj, &dibs_dev_attr_group);
> 	if (ret) {
>@@ -164,8 +203,10 @@ int dibs_dev_add(struct dibs_dev *dibs)
> 	mutex_lock(&dibs_dev_list.mutex);
> 	mutex_lock(&clients_lock);
> 	for (i = 0; i < max_client; ++i) {
>-		if (clients[i])
>+		if (clients[i]) {
> 			clients[i]->ops->add_dev(dibs);
>+			dibs_setup_forwarding(clients[i], dibs);
>+		}
> 	}
> 	mutex_unlock(&clients_lock);
> 	list_add(&dibs->list, &dibs_dev_list.list);
>@@ -175,6 +216,8 @@ int dibs_dev_add(struct dibs_dev *dibs)
> 
> err_device_del:
> 	device_del(&dibs->dev);
>+free_client_arr:
>+	kfree(dibs->dmb_clientid_arr);
> 	return ret;
> 
> }
>@@ -182,8 +225,16 @@ EXPORT_SYMBOL_GPL(dibs_dev_add);
> 
> void dibs_dev_del(struct dibs_dev *dibs)
> {
>+	unsigned long flags;
> 	int i;
> 
>+	sysfs_remove_group(&dibs->dev.kobj, &dibs_dev_attr_group);
>+
>+	spin_lock_irqsave(&dibs->lock, flags);
>+	for (i = 0; i < MAX_DIBS_CLIENTS; ++i)
>+		dibs->subs[i] = NULL;
>+	spin_unlock_irqrestore(&dibs->lock, flags);
>+
> 	mutex_lock(&dibs_dev_list.mutex);
> 	mutex_lock(&clients_lock);
> 	for (i = 0; i < max_client; ++i) {
>@@ -195,6 +246,7 @@ void dibs_dev_del(struct dibs_dev *dibs)
> 	mutex_unlock(&dibs_dev_list.mutex);
> 
> 	device_del(&dibs->dev);
>+	kfree(dibs->dmb_clientid_arr);
> }
> EXPORT_SYMBOL_GPL(dibs_dev_del);
> 
>diff --git a/net/smc/Makefile b/net/smc/Makefile
>index 96ccfdf246df..0e754cbc38f9 100644
>--- a/net/smc/Makefile
>+++ b/net/smc/Makefile
>@@ -6,4 +6,3 @@ smc-y := af_smc.o smc_pnet.o smc_ib.o smc_clc.o smc_core.o smc_wr.o smc_llc.o
> smc-y += smc_cdc.o smc_tx.o smc_rx.o smc_close.o smc_ism.o smc_netlink.o smc_stats.o
> smc-y += smc_tracepoint.o smc_inet.o
> smc-$(CONFIG_SYSCTL) += smc_sysctl.o
>-smc-y += smc_loopback.o

Why not remove smc_loopback.* as well ?

Best regards,
Dust


