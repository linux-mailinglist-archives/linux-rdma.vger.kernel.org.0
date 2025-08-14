Return-Path: <linux-rdma+bounces-12749-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BF2B25F93
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 10:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619B51C83F19
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 08:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811962D46A7;
	Thu, 14 Aug 2025 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oz+i0Asn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CABD2FF662;
	Thu, 14 Aug 2025 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161506; cv=none; b=QV/5AquR9RNJBFlBpnba+fvESNrNOUM3T4wxLup31wP49tSAllxR0jRbvgCcTk1W2iI6dYkBonw9LevqDfhqSFATcop+Fon7MTLR0STk0ik/Nyesl1AZ4JoXfez3L7LPofnaiGysWQqqAO7vsUrseCKemsLTLUf0yb+SvxFFSF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161506; c=relaxed/simple;
	bh=XFAH3UXSvhyR/Rdv8WT4Qm6EXrH7HiErl4dIQLbJdzE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=leJPJRmNJi5wtgLj9SFAx2YoYtVYLiQeVaxesFlCZkZXn8FppReSYdfrCI0jF7ahwQ16/KjSEjwStgXwDLE0dNBQ69K0zyKjSV9z0fiNrnW03+upkwFQ3lEmSKdXRgZ4IdM8VUSfgygPMYSs4TLEPZJqHBTyKWbS1uOD8yEmFuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oz+i0Asn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E06on8031959;
	Thu, 14 Aug 2025 08:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AAqcVO
	5sYWfbdPu3ycJdiGIpYSAyyTXeXH3xf8Pum2E=; b=oz+i0AsnWR0E2UxtlM7n8+
	6F595YVz/9aWcFtjaIlHNTy7q6eVUf6qiBKdG5Vgsl5NIcXPMJ2YTTFMcWY9unxP
	pCye7XUySkAHN2sPWahFUu0wo+2vwAFTpe6+jg8t+dG3J7tSZ51/NNu5GziMkdcA
	asB+yt9Dm562FWPjsWrte3mS/WupkVVMnlRSmKEF5NzsmWiKXHgdVT8DOXllrFg4
	Ljp7V/V+0FJcSNrtjJ3gvXPKOcOlk1sxz+dJRoM7U5tLtRk1D+7crHsNbbn32Yxo
	pcIeybMYKwgXYujNzd7W0TZNJjYfTn3ChXmqxCTjFbvG1YkRkz0jy24P5rKeI2Cw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrp8vb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 08:51:33 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57E8fJqj027274;
	Thu, 14 Aug 2025 08:51:33 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrp8vb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 08:51:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57E64CH0025657;
	Thu, 14 Aug 2025 08:51:32 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ejvmk6fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 08:51:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57E8pSOA18481422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 08:51:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B1E12004B;
	Thu, 14 Aug 2025 08:51:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16F6320040;
	Thu, 14 Aug 2025 08:51:28 +0000 (GMT)
Received: from [9.152.224.240] (unknown [9.152.224.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Aug 2025 08:51:28 +0000 (GMT)
Message-ID: <369a292c-c8c5-4002-a116-f9e1b4a436ba@linux.ibm.com>
Date: Thu, 14 Aug 2025 10:51:27 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 11/17] net/dibs: Move struct device to dibs_dev
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond
 <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Simon Horman <horms@kernel.org>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-rdma@vger.kernel.org
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
 <20250806154122.3413330-12-wintera@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250806154122.3413330-12-wintera@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIxOSBTYWx0ZWRfX99qRzlkMt2GD
 Olpm53p2Ld97G2tN4zgcyP7FQCiwXGREgFSDcYDa4yCakd+cn40QioyagB/uGSGUsakCNckxbUM
 AsCWyAxYlbhN9OMeX4WnBpJUoU1p7rnP9Fp8Zb/YDKUtofqd0W7OE3cMV/Ln9rTyd4wL9VB8et5
 pVqof/wBPiT4ZZBD16K5ua2n1bVAAtVgui7ZQZxzGe1H6qaV2w/1bQvnteM4vQd1Dalj4yUjjTE
 MrmTi1yav4E/aiDCwfQqXTVUtWRTv4SnMljV3r30DufZGDdqslMDOKu0Xm0jam2GcZ9UGbJoZbr
 6Q7zd+wdGiUPG/m0umq/Ps8++xnuACD8dA/Nh1RzfEb8M3Tqnbti5a7+HN1ZlZYKeEZLPre6iap
 +zUTXhFy
X-Authority-Analysis: v=2.4 cv=GrpC+l1C c=1 sm=1 tr=0 ts=689da395 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=b55MMyH7UsmVj3mJHRQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xtUeB8hFQfe1seCQRBeL9KObdBYvEyHt
X-Proofpoint-ORIG-GUID: gNvEYqXMdAaelgVFAHFeQ49U9M7Zfoeg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120219



On 06.08.25 17:41, Alexandra Winter wrote:
[...]
> 
> Replace smcd->ops->get_dev(smcd) by dibs_get_dev().
> 

Looking at the resulting code, I don't really like this concept of a *_get_dev() function,
that does not call get_device().
I plan to replace that by using dibs->dev directly in the next version.


See below for the code pieces I am referring to:


> diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
> index 84a6e9ae2e64..0ddfd47a3a7c 100644
> --- a/drivers/s390/net/ism_drv.c
> +++ b/drivers/s390/net/ism_drv.c
[...]
> @@ -697,16 +684,14 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	ism_dev_exit(ism);
>  err_dibs:
>  	/* pairs with dibs_dev_alloc() */
> -	kfree(dibs);
> +	put_device(dibs_get_dev(dibs));
[...]
> @@ -719,13 +704,12 @@ static void ism_remove(struct pci_dev *pdev)
>  	dibs_dev_del(dibs);
>  	ism_dev_exit(ism);
>  	/* pairs with dibs_dev_alloc() */
> -	kfree(dibs);
> +	put_device(dibs_get_dev(dibs));
>  
>  	pci_release_mem_regions(pdev);
[...]
> @@ -871,13 +855,6 @@ static void smcd_get_local_gid(struct smcd_dev *smcd,
>  	smcd_gid->gid_ext = 0;
>  }
>  
> -static inline struct device *smcd_get_dev(struct smcd_dev *dev)
> -{
> -	struct ism_dev *ism = dev->priv;
> -
> -	return &ism->dev;
> -}
> -
>  static const struct smcd_ops ism_smcd_ops = {
>  	.query_remote_gid = smcd_query_rgid,
>  	.register_dmb = smcd_register_dmb,
> @@ -890,7 +867,6 @@ static const struct smcd_ops ism_smcd_ops = {
>  	.move_data = smcd_move,
>  	.supports_v2 = smcd_supports_v2,
>  	.get_local_gid = smcd_get_local_gid,
> -	.get_dev = smcd_get_dev,
>  };
>  
>  const struct smcd_ops *ism_get_smcd_ops(void)
> diff --git a/include/linux/dibs.h b/include/linux/dibs.h
> index 805ab33271b5..4459b9369dc0 100644
> --- a/include/linux/dibs.h
> +++ b/include/linux/dibs.h
[...]
> @@ -158,6 +159,21 @@ static inline void *dibs_get_priv(struct dibs_dev *dev,
>  
>  /* ------- End of client-only functions ----------- */
>  
> +/* Functions to be called by dibs clients and dibs device drivers:
> + */
> +/**
> + * dibs_get_dev()
> + * @dev: dibs device
> + * @token: dmb token of the remote dmb
> + *
> + * TODO: provide get and put functions
> + * Return: struct device* to be used for device refcounting
> + */
> +static inline struct device *dibs_get_dev(struct dibs_dev *dibs)
> +{
> +	return &dibs->dev;
> +}
> +
[...]
> diff --git a/include/net/smc.h b/include/net/smc.h
> index e271891b85e6..05faac83371e 100644
> --- a/include/net/smc.h
> +++ b/include/net/smc.h
> @@ -63,7 +63,6 @@ struct smcd_ops {
>  			 unsigned int size);
>  	int (*supports_v2)(void);
>  	void (*get_local_gid)(struct smcd_dev *dev, struct smcd_gid *gid);
> -	struct device* (*get_dev)(struct smcd_dev *dev);
>  
>  	/* optional operations */
>  	int (*add_vlan_id)(struct smcd_dev *dev, u64 vlan_id);
[...]

>  
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index 67f9e0b83ebc..71c410dc3658 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -924,7 +924,7 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
>  	if (ini->is_smcd) {
>  		/* SMC-D specific settings */
>  		smcd = ini->ism_dev[ini->ism_selected];
> -		get_device(smcd->ops->get_dev(smcd));
> +		get_device(dibs_get_dev(smcd->dibs));
>  		lgr->peer_gid.gid =
>  			ini->ism_peer_gid[ini->ism_selected].gid;
>  		lgr->peer_gid.gid_ext =
> @@ -1474,7 +1474,7 @@ static void smc_lgr_free(struct smc_link_group *lgr)
>  	destroy_workqueue(lgr->tx_wq);
>  	if (lgr->is_smcd) {
>  		smc_ism_put_vlan(lgr->smcd, lgr->vlan_id);
> -		put_device(lgr->smcd->ops->get_dev(lgr->smcd));
> +		put_device(dibs_get_dev(lgr->smcd->dibs));
>  	}
>  	smc_lgr_put(lgr); /* theoretically last lgr_put */
>  }
[...]
> diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
> index 37d8366419f7..262d0d0df4d0 100644
> --- a/net/smc/smc_loopback.c
> +++ b/net/smc/smc_loopback.c
> @@ -23,7 +23,6 @@
>  #define SMC_LO_SUPPORT_NOCOPY	0x1
>  #define SMC_DMA_ADDR_INVALID	(~(dma_addr_t)0)
>  
> -static const char smc_lo_dev_name[] = "loopback-ism";
>  static struct smc_lo_dev *lo_dev;
>  
>  static void smc_lo_generate_ids(struct smc_lo_dev *ldev)
> @@ -255,11 +254,6 @@ static void smc_lo_get_local_gid(struct smcd_dev *smcd,
>  	smcd_gid->gid_ext = ldev->local_gid.gid_ext;
>  }
>  
> -static struct device *smc_lo_get_dev(struct smcd_dev *smcd)
> -{
> -	return &((struct smc_lo_dev *)smcd->priv)->dev;
> -}
> -
>  static const struct smcd_ops lo_ops = {
>  	.query_remote_gid = smc_lo_query_rgid,
>  	.register_dmb = smc_lo_register_dmb,
> @@ -274,7 +268,6 @@ static const struct smcd_ops lo_ops = {
>  	.signal_event		= NULL,
>  	.move_data = smc_lo_move_data,
>  	.get_local_gid = smc_lo_get_local_gid,
> -	.get_dev = smc_lo_get_dev,
>  };
>  
[...]
> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> index 76ad29e31d60..bbdd875731f2 100644
> --- a/net/smc/smc_pnet.c
> +++ b/net/smc/smc_pnet.c
> @@ -169,7 +169,7 @@ static int smc_pnet_remove_by_pnetid(struct net *net, char *pnet_name)
>  			pr_warn_ratelimited("smc: smcd device %s "
>  					    "erased user defined pnetid "
>  					    "%.16s\n",
> -					    dev_name(smcd->ops->get_dev(smcd)),
> +					    dev_name(dibs_get_dev(smcd->dibs)),
>  					    smcd->pnetid);
>  			memset(smcd->pnetid, 0, SMC_MAX_PNETID_LEN);
>  			smcd->pnetid_by_user = false;
> @@ -332,7 +332,7 @@ static struct smcd_dev *smc_pnet_find_smcd(char *smcd_name)
>  
>  	mutex_lock(&smcd_dev_list.mutex);
>  	list_for_each_entry(smcd_dev, &smcd_dev_list.list, list) {
> -		if (!strncmp(dev_name(smcd_dev->ops->get_dev(smcd_dev)),
> +		if (!strncmp(dev_name(dibs_get_dev(smcd_dev->dibs)),
>  			     smcd_name, IB_DEVICE_NAME_MAX - 1))
>  			goto out;
>  	}
> @@ -431,7 +431,7 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
>  	if (smcd) {
>  		smcddev_applied = smc_pnet_apply_smcd(smcd, pnet_name);
>  		if (smcddev_applied) {
> -			dev = smcd->ops->get_dev(smcd);
> +			dev = dibs_get_dev(smcd->dibs);
>  			pr_warn_ratelimited("smc: smcd device %s "
>  					    "applied user defined pnetid "
>  					    "%.16s\n", dev_name(dev),
> @@ -1192,7 +1192,7 @@ int smc_pnetid_by_table_ib(struct smc_ib_device *smcibdev, u8 ib_port)
>   */
>  int smc_pnetid_by_table_smcd(struct smcd_dev *smcddev)
>  {
> -	const char *ib_name = dev_name(smcddev->ops->get_dev(smcddev));
> +	const char *ib_name = dev_name(dibs_get_dev(smcddev->dibs));
>  	struct smc_pnettable *pnettable;
>  	struct smc_pnetentry *tmp_pe;
>  	struct smc_net *sn;


