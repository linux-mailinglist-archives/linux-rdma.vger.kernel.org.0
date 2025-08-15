Return-Path: <linux-rdma+bounces-12767-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B04B2754D
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 04:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589AC581818
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 02:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95E429BDB7;
	Fri, 15 Aug 2025 01:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="K+izhJXm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3188D292B4B;
	Fri, 15 Aug 2025 01:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222975; cv=none; b=BjePhBrh5YWcLncRxSpsqx+2vz6XxcFRTW33wMqiRpsjuTgGAG7yBMiAXS079A5Q1I7ue2ajKoojenL9s4hvvIsoR/OV8V1jg1gKlXDeuBJ1in33cDJFmw2N2Z0y3Ml3L3sOYWSWtaaj1xSQEkSAzSs8NDx04Xkm81wWsq0vLM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222975; c=relaxed/simple;
	bh=+nBM0hG2RnI2dnOPGBNUDFaGBpn2PLbz2yh8BzKLn0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/CUP01dCtLUPUsGv4Njj/5hmXcYaCB12ZrJaSvCWP9ERNe7dkLrdbNovbJg8BeFQ2/74EdsvsPK+kuDrczfJMPpFwC+bzqPION17SD2SigclRxaPF6TSGNJPtj0oNXu88GIxzFewku/bXzBjkgY6SBlEiGlhgwbLt9VsyXnCDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=K+izhJXm; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755222964; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=iGiVqtfZRbEkrw+mdhN+VrYas9P5Pc4amtyTrXuf5OU=;
	b=K+izhJXmvQV/G1cAADnCUxO+Kt6XmPaX6YfrnGT5fXIcJ56z8phephToDpbU21d+fnzOu9n1bBNol9DUYkPiwXFQNDbVHdmSCwMwGGdHDh1n5mzRKU+dFgyP6JsEw75Lqt9x3Pr0/R/T0e68s5xlJKPuP8Dan/93Pm1kNaurxCQ=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0Wlmn22a_1755222962 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Aug 2025 09:56:03 +0800
Date: Fri, 15 Aug 2025 09:56:02 +0800
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
Subject: Re: [RFC net-next 11/17] net/dibs: Move struct device to dibs_dev
Message-ID: <aJ6TsutbywkTLWxO@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
 <20250806154122.3413330-12-wintera@linux.ibm.com>
 <369a292c-c8c5-4002-a116-f9e1b4a436ba@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <369a292c-c8c5-4002-a116-f9e1b4a436ba@linux.ibm.com>

On 2025-08-14 10:51:27, Alexandra Winter wrote:
>
>
>On 06.08.25 17:41, Alexandra Winter wrote:
>[...]
>> 
>> Replace smcd->ops->get_dev(smcd) by dibs_get_dev().
>> 
>
>Looking at the resulting code, I don't really like this concept of a *_get_dev() function,
>that does not call get_device().
>I plan to replace that by using dibs->dev directly in the next version.

May I ask why? Because of the function name ? If so, maybe we can change the name.

While I don't have a strong preference either way, I personally favor
hiding the members of the dibs_dev structure from the upper layer. In my
opinion, it would be better to avoid direct access to dibs members from
upper layers and instead provide dedicated interface functions.

For example, I even think we should not expose dibs->ops->xxx directly
to the SMC layer. Encapsulating such details would improve modularity
and maintainability. Just like what IB subsystem has done before :)

For example:
# git grep dibs net/smc
[...]
net/smc/smc_ism.c:      return dibs->ops->query_remote_gid(dibs, &ism_rgid, vlan_id ? 1 : 0,
net/smc/smc_ism.c:      return smcd->dibs->ops->get_fabric_id(smcd->dibs);
net/smc/smc_ism.c:      if (!smcd->dibs->ops->add_vlan_id)
net/smc/smc_ism.c:      if (smcd->dibs->ops->add_vlan_id(smcd->dibs, vlanid)) {
net/smc/smc_ism.c:      if (!smcd->dibs->ops->del_vlan_id)
net/smc/smc_ism.c:      if (smcd->dibs->ops->del_vlan_id(smcd->dibs, vlanid))
[...]

Best regards,
Dust

>
>
>See below for the code pieces I am referring to:
>
>
>> diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
>> index 84a6e9ae2e64..0ddfd47a3a7c 100644
>> --- a/drivers/s390/net/ism_drv.c
>> +++ b/drivers/s390/net/ism_drv.c
>[...]
>> @@ -697,16 +684,14 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>  	ism_dev_exit(ism);
>>  err_dibs:
>>  	/* pairs with dibs_dev_alloc() */
>> -	kfree(dibs);
>> +	put_device(dibs_get_dev(dibs));
>[...]
>> @@ -719,13 +704,12 @@ static void ism_remove(struct pci_dev *pdev)
>>  	dibs_dev_del(dibs);
>>  	ism_dev_exit(ism);
>>  	/* pairs with dibs_dev_alloc() */
>> -	kfree(dibs);
>> +	put_device(dibs_get_dev(dibs));
>>  
>>  	pci_release_mem_regions(pdev);
>[...]
>> @@ -871,13 +855,6 @@ static void smcd_get_local_gid(struct smcd_dev *smcd,
>>  	smcd_gid->gid_ext = 0;
>>  }
>>  
>> -static inline struct device *smcd_get_dev(struct smcd_dev *dev)
>> -{
>> -	struct ism_dev *ism = dev->priv;
>> -
>> -	return &ism->dev;
>> -}
>> -
>>  static const struct smcd_ops ism_smcd_ops = {
>>  	.query_remote_gid = smcd_query_rgid,
>>  	.register_dmb = smcd_register_dmb,
>> @@ -890,7 +867,6 @@ static const struct smcd_ops ism_smcd_ops = {
>>  	.move_data = smcd_move,
>>  	.supports_v2 = smcd_supports_v2,
>>  	.get_local_gid = smcd_get_local_gid,
>> -	.get_dev = smcd_get_dev,
>>  };
>>  
>>  const struct smcd_ops *ism_get_smcd_ops(void)
>> diff --git a/include/linux/dibs.h b/include/linux/dibs.h
>> index 805ab33271b5..4459b9369dc0 100644
>> --- a/include/linux/dibs.h
>> +++ b/include/linux/dibs.h
>[...]
>> @@ -158,6 +159,21 @@ static inline void *dibs_get_priv(struct dibs_dev *dev,
>>  
>>  /* ------- End of client-only functions ----------- */
>>  
>> +/* Functions to be called by dibs clients and dibs device drivers:
>> + */
>> +/**
>> + * dibs_get_dev()
>> + * @dev: dibs device
>> + * @token: dmb token of the remote dmb
>> + *
>> + * TODO: provide get and put functions
>> + * Return: struct device* to be used for device refcounting
>> + */
>> +static inline struct device *dibs_get_dev(struct dibs_dev *dibs)
>> +{
>> +	return &dibs->dev;
>> +}
>> +
>[...]
>> diff --git a/include/net/smc.h b/include/net/smc.h
>> index e271891b85e6..05faac83371e 100644
>> --- a/include/net/smc.h
>> +++ b/include/net/smc.h
>> @@ -63,7 +63,6 @@ struct smcd_ops {
>>  			 unsigned int size);
>>  	int (*supports_v2)(void);
>>  	void (*get_local_gid)(struct smcd_dev *dev, struct smcd_gid *gid);
>> -	struct device* (*get_dev)(struct smcd_dev *dev);
>>  
>>  	/* optional operations */
>>  	int (*add_vlan_id)(struct smcd_dev *dev, u64 vlan_id);
>[...]
>
>>  
>> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
>> index 67f9e0b83ebc..71c410dc3658 100644
>> --- a/net/smc/smc_core.c
>> +++ b/net/smc/smc_core.c
>> @@ -924,7 +924,7 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
>>  	if (ini->is_smcd) {
>>  		/* SMC-D specific settings */
>>  		smcd = ini->ism_dev[ini->ism_selected];
>> -		get_device(smcd->ops->get_dev(smcd));
>> +		get_device(dibs_get_dev(smcd->dibs));
>>  		lgr->peer_gid.gid =
>>  			ini->ism_peer_gid[ini->ism_selected].gid;
>>  		lgr->peer_gid.gid_ext =
>> @@ -1474,7 +1474,7 @@ static void smc_lgr_free(struct smc_link_group *lgr)
>>  	destroy_workqueue(lgr->tx_wq);
>>  	if (lgr->is_smcd) {
>>  		smc_ism_put_vlan(lgr->smcd, lgr->vlan_id);
>> -		put_device(lgr->smcd->ops->get_dev(lgr->smcd));
>> +		put_device(dibs_get_dev(lgr->smcd->dibs));
>>  	}
>>  	smc_lgr_put(lgr); /* theoretically last lgr_put */
>>  }
>[...]
>> diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
>> index 37d8366419f7..262d0d0df4d0 100644
>> --- a/net/smc/smc_loopback.c
>> +++ b/net/smc/smc_loopback.c
>> @@ -23,7 +23,6 @@
>>  #define SMC_LO_SUPPORT_NOCOPY	0x1
>>  #define SMC_DMA_ADDR_INVALID	(~(dma_addr_t)0)
>>  
>> -static const char smc_lo_dev_name[] = "loopback-ism";
>>  static struct smc_lo_dev *lo_dev;
>>  
>>  static void smc_lo_generate_ids(struct smc_lo_dev *ldev)
>> @@ -255,11 +254,6 @@ static void smc_lo_get_local_gid(struct smcd_dev *smcd,
>>  	smcd_gid->gid_ext = ldev->local_gid.gid_ext;
>>  }
>>  
>> -static struct device *smc_lo_get_dev(struct smcd_dev *smcd)
>> -{
>> -	return &((struct smc_lo_dev *)smcd->priv)->dev;
>> -}
>> -
>>  static const struct smcd_ops lo_ops = {
>>  	.query_remote_gid = smc_lo_query_rgid,
>>  	.register_dmb = smc_lo_register_dmb,
>> @@ -274,7 +268,6 @@ static const struct smcd_ops lo_ops = {
>>  	.signal_event		= NULL,
>>  	.move_data = smc_lo_move_data,
>>  	.get_local_gid = smc_lo_get_local_gid,
>> -	.get_dev = smc_lo_get_dev,
>>  };
>>  
>[...]
>> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
>> index 76ad29e31d60..bbdd875731f2 100644
>> --- a/net/smc/smc_pnet.c
>> +++ b/net/smc/smc_pnet.c
>> @@ -169,7 +169,7 @@ static int smc_pnet_remove_by_pnetid(struct net *net, char *pnet_name)
>>  			pr_warn_ratelimited("smc: smcd device %s "
>>  					    "erased user defined pnetid "
>>  					    "%.16s\n",
>> -					    dev_name(smcd->ops->get_dev(smcd)),
>> +					    dev_name(dibs_get_dev(smcd->dibs)),
>>  					    smcd->pnetid);
>>  			memset(smcd->pnetid, 0, SMC_MAX_PNETID_LEN);
>>  			smcd->pnetid_by_user = false;
>> @@ -332,7 +332,7 @@ static struct smcd_dev *smc_pnet_find_smcd(char *smcd_name)
>>  
>>  	mutex_lock(&smcd_dev_list.mutex);
>>  	list_for_each_entry(smcd_dev, &smcd_dev_list.list, list) {
>> -		if (!strncmp(dev_name(smcd_dev->ops->get_dev(smcd_dev)),
>> +		if (!strncmp(dev_name(dibs_get_dev(smcd_dev->dibs)),
>>  			     smcd_name, IB_DEVICE_NAME_MAX - 1))
>>  			goto out;
>>  	}
>> @@ -431,7 +431,7 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
>>  	if (smcd) {
>>  		smcddev_applied = smc_pnet_apply_smcd(smcd, pnet_name);
>>  		if (smcddev_applied) {
>> -			dev = smcd->ops->get_dev(smcd);
>> +			dev = dibs_get_dev(smcd->dibs);
>>  			pr_warn_ratelimited("smc: smcd device %s "
>>  					    "applied user defined pnetid "
>>  					    "%.16s\n", dev_name(dev),
>> @@ -1192,7 +1192,7 @@ int smc_pnetid_by_table_ib(struct smc_ib_device *smcibdev, u8 ib_port)
>>   */
>>  int smc_pnetid_by_table_smcd(struct smcd_dev *smcddev)
>>  {
>> -	const char *ib_name = dev_name(smcddev->ops->get_dev(smcddev));
>> +	const char *ib_name = dev_name(dibs_get_dev(smcddev->dibs));
>>  	struct smc_pnettable *pnettable;
>>  	struct smc_pnetentry *tmp_pe;
>>  	struct smc_net *sn;

