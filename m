Return-Path: <linux-rdma+bounces-1877-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7D989E220
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 20:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB081C2170C
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 18:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73090156892;
	Tue,  9 Apr 2024 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="jH1HgOpB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327607F499;
	Tue,  9 Apr 2024 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712686045; cv=none; b=kTzBnh27ekbuLkLLwynPdNjeLRq3vOkNO4FF6g5jFLtL5ziaDpEuruX6BjH6GyowqyR8BH7+9pTepyQ+iOwMJ4kCsuPLnFp0J+D2/HV4xbHPOx1FBeahQZ4nQOSVkBsJk9Mzx1ehYTDhSTarndX4m4Yyt5ERhJQ7Icbe7La1KRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712686045; c=relaxed/simple;
	bh=tYIcoz0wchts/Gtp2iRLf9iduerku6Apdgx2vlKtfFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ozfoXuIwEP4flzEryE5RMKQxgeLoVqBva+AC9mM0vy8WKxWyaLsRoUUkhruNDwoobh7WS5V/zUuFzQ/J0mWR+g07ZIpTZeRWT7SrmlN3WNd5r/IthieEf1o7aUy80QdmQAc0LDVZcr6BMRdf8WlCnxEF3QZPr2Heior+/apW2hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=jH1HgOpB; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 839D7100002;
	Tue,  9 Apr 2024 21:07:00 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1712686020; bh=RFwbyFvj6nYarjY+Ujb977cApsg0/oYvU6Fkzw6g2QA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=jH1HgOpBJSPPtG5Q/nmkFX7x9hWXSVqxu3SD6zU1gLZzeze/lAR/ODu6+EJPEmoop
	 Xy4mnbXKxU76+XQgOW7y+Acu9dhtp8zQJ4Xcpk2onfl4FB8m4h9eX1CG+RGP/qLKCm
	 9WVfP5dgRkSt33V+sppeejz8qnZAidNTAnXMvMinUn1O/DNKtDd0tVfmoB79Z2iaUT
	 l2ZT6NPY9if6E4GHBUP9wK96ecu+TqnCCfyKP+qg4fYPVmLdZVyUUeFiFcqiSqsSob
	 XZw0wUrbPE7vM5BLyDINajThKhp5eCIz3lTClrqv0gpGOyUrW/2HgViIqpcBuIEPzt
	 VFswAgoEXAGXA==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue,  9 Apr 2024 21:05:54 +0300 (MSK)
Received: from [172.17.214.6] (172.17.214.6) by ta-mail-02 (172.17.13.212)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Apr 2024
 21:05:03 +0300
Message-ID: <1a96d3be-cc40-4aef-bd4d-bb3a9ef3a7d4@t-argos.ru>
Date: Tue, 9 Apr 2024 21:01:38 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA: hns: Fix possible null pointer dereference
To: Junxian Huang <huangjunxian6@hisilicon.com>, Leon Romanovsky
	<leon@kernel.org>
CC: Wei Xu <xuwei5@hisilicon.com>, Chengchang Tang
	<tangchengchang@huawei.com>, Jason Gunthorpe <jgg@ziepe.ca>, Xi Wang
	<wangxi11@huawei.com>, Shengming Shu <shushengming1@huawei.com>, Weihang Li
	<liweihang@huawei.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
References: <20240409083047.15784-1-amishin@t-argos.ru>
 <20240409092601.GG4195@unreal>
 <1476bb96-c0a9-379a-546b-98fc8a06beea@hisilicon.com>
Content-Language: ru
From: Aleksandr Mishin <amishin@t-argos.ru>
In-Reply-To: <1476bb96-c0a9-379a-546b-98fc8a06beea@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184641 [Apr 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 16 0.3.16 6e64c33514fcbd07e515710c86ba61de7f56194e, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/09 13:26:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/04/09 13:05:00 #24719238
X-KSMG-AntiVirus-Status: Clean, skipped


Thank you! I assumed something like this, but I couldn't find any 
confirmations and offered a patch as a solution.

On 09.04.2024 14:10, Junxian Huang wrote:
> 
> 
> On 2024/4/9 17:26, Leon Romanovsky wrote:
>> On Tue, Apr 09, 2024 at 11:30:47AM +0300, Aleksandr Mishin wrote:
>>> In hns_roce_hw_v2_get_cfg() pci_match_id() may return
>>> NULL which is later dereferenced. Fix this bug by adding NULL check.
>>
>> I don't know, this NULL can't happen in this flow.
>>
>> Thanks
>>
> 
> Yeah, it's already checked here:
> 
> 6911 static int hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
> 6912 {
> 6913         const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
> 6914         const struct pci_device_id *id;
> 6915         struct device *dev = &handle->pdev->dev;
> 6916         int ret;
> 6917
> 6918         handle->rinfo.instance_state = HNS_ROCE_STATE_INIT;
> 6919
> 6920         if (ops->ae_dev_resetting(handle) || ops->get_hw_reset_stat(handle)) {
> 6921                 handle->rinfo.instance_state = HNS_ROCE_STATE_NON_INIT;
> 6922                 goto reset_chk_err;
> 6923         }
> 6924
> 6925         id = pci_match_id(hns_roce_hw_v2_pci_tbl, handle->pdev);
> 6926         if (!id)
> 6927                 return 0;
> 6928
> 6929         if (id->driver_data && handle->pdev->revision == PCI_REVISION_ID_HIP08)
> 6930                 return 0;
> 6931
> 6932         ret = __hns_roce_hw_v2_init_instance(handle);
> 
> Junxian
> 
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>
>>> Fixes: 0b567cde9d7a ("RDMA/hns: Enable RoCE on virtual functions")
>>> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
>>> ---
>>>   drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 13 +++++++++++--
>>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>> index ba7ae792d279..31a2093334d9 100644
>>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>> @@ -6754,7 +6754,7 @@ static const struct pci_device_id hns_roce_hw_v2_pci_tbl[] = {
>>>   
>>>   MODULE_DEVICE_TABLE(pci, hns_roce_hw_v2_pci_tbl);
>>>   
>>> -static void hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
>>> +static int hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
>>>   				  struct hnae3_handle *handle)
>>>   {
>>>   	struct hns_roce_v2_priv *priv = hr_dev->priv;
>>> @@ -6763,6 +6763,9 @@ static void hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
>>>   
>>>   	hr_dev->pci_dev = handle->pdev;
>>>   	id = pci_match_id(hns_roce_hw_v2_pci_tbl, hr_dev->pci_dev);
>>> +	if (!id)
>>> +		return -ENXIO;
>>> +
>>>   	hr_dev->is_vf = id->driver_data;
>>>   	hr_dev->dev = &handle->pdev->dev;
>>>   	hr_dev->hw = &hns_roce_hw_v2;
>>> @@ -6789,6 +6792,8 @@ static void hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
>>>   
>>>   	hr_dev->reset_cnt = handle->ae_algo->ops->ae_dev_reset_cnt(handle);
>>>   	priv->handle = handle;
>>> +
>>> +	return 0;
>>>   }
>>>   
>>>   static int __hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
>>> @@ -6806,7 +6811,11 @@ static int __hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
>>>   		goto error_failed_kzalloc;
>>>   	}
>>>   
>>> -	hns_roce_hw_v2_get_cfg(hr_dev, handle);
>>> +	ret = hns_roce_hw_v2_get_cfg(hr_dev, handle);
>>> +	if (ret) {
>>> +		dev_err(hr_dev->dev, "RoCE Engine cfg failed!\n");
>>> +		goto error_failed_roce_init;
>>> +	}
>>>   
>>>   	ret = hns_roce_init(hr_dev);
>>>   	if (ret) {
>>> -- 
>>> 2.30.2
>>>
> 

-- 
Kind regards
Aleksandr

