Return-Path: <linux-rdma+bounces-21420-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COzrGpf5F2oWXwgAu9opvQ
	(envelope-from <linux-rdma+bounces-21420-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 10:15:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C59A5EE609
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 10:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 155D9302AEE1
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 08:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBE6365A03;
	Thu, 28 May 2026 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="VWNmy/8p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C53277C9E;
	Thu, 28 May 2026 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955472; cv=none; b=EXNoiDnCe4loUImdIgiegBLfIt2mnp/rLq7r4uGlacAIXnohqKKujOS0TCWm2JsWOe4nIfam3mzF0d29N+vM7EAOIOtjmbJe6s6W23r7VSrtf3iY+a04ZeaxakcN4Nhl5XbZZ84f0rqyfDDS57KwiYoBmeWulWkqo8CLFkrp2Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955472; c=relaxed/simple;
	bh=GWCH/Aonkgn/NPWpyC1bnkTBZ5RLU7iQOKnQqDuOdik=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HrXcZrIVVpxfdLp9LCqEdRemb9Pc3SHFBnOTUs7ZShFq26xb+l5G7+BMU95n0iSKMAKRsAXWB5ZLdlkG9jbOInoXVmtuMQVEKX2dQsyM7xyDO7H6kC8CW1TWQCbHKHTwIq+PbwsgtNCbX7NQ0eyamBLjJYA5mJtmX/UDaAbQVsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=VWNmy/8p; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CEfwnPgqLrNaYc1mj4Eyf5bsKzEWDOcFqXc4WbjJj3Y=;
	b=VWNmy/8ppTsOaeH7aF0IkCxzVtF02EKB40Q9n+4FS2a49yqKE93km1cGo7tdMukvd+DizK640
	vi3iz/xW1BQV8Gi5uBJySJ7LLs+A4yUb35GPILBJVkXEleZVBmRDs/+XWvwt+5lC9/Fs3PEnMDf
	Z/U2WkMeDuot+idcTJbFv+w=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gQzMp6R6nzmV6T;
	Thu, 28 May 2026 15:56:38 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 59E7140539;
	Thu, 28 May 2026 16:04:26 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 May 2026 16:04:25 +0800
Message-ID: <65b3d63a-271a-4aa8-ba8c-fc2b186349dc@huawei.com>
Date: Thu, 28 May 2026 16:04:25 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] PCI/TPH: expose the enabled TPH requester type
To: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Sumit
 Semwal <sumit.semwal@linaro.org>, Christian Konig <christian.koenig@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>, <kvm@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Keith Busch
	<kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
	<yishaih@nvidia.com>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <20260526144401.1485788-2-zhipingz@meta.com>
 <20260527145332.30412ea4@shazbot.org>
 <CAH3zFs3Yv2G0rQNE7x8DjBWPE+3sFC_3X6ZtF4x-mPp==h0BQA@mail.gmail.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <CAH3zFs3Yv2G0rQNE7x8DjBWPE+3sFC_3X6ZtF4x-mPp==h0BQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-21420-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shazbot.org:email,meta.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Queue-Id: 7C59A5EE609
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/2026 1:35 PM, Zhiping Zhang wrote:
> On Wed, May 27, 2026 at 1:53 PM Alex Williamson <alex@shazbot.org> wrote:
>>
>>>
>> On Tue, 26 May 2026 07:43:53 -0700
>> Zhiping Zhang <zhipingz@meta.com> wrote:
>>
>>> Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
>>> requester mode without reaching into pci_dev internals.
>>>
>>> This keeps pci_dev::tph_req_type inside the PCI/TPH code and provides a
>>> !CONFIG_PCIE_TPH stub for callers.
>>>
>>> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>>> ---
>>>  drivers/pci/tph.c       | 12 ++++++++++++
>>>  include/linux/pci-tph.h |  2 ++
>>>  2 files changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
>>> index 91145e8d9d95..6c4492075ae9 100644
>>> --- a/drivers/pci/tph.c
>>> +++ b/drivers/pci/tph.c
>>> @@ -174,6 +174,18 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
>>>  }
>>>  EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
>>>
>>> +/**
>>> + * pcie_tph_enabled_req_type - Return the device's enabled TPH requester type
>>> + * @pdev: PCI device to query
>>> + *
>>> + * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_EXT_TPH.
>>> + */
>>> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
>>> +{
>>> +     return pdev->tph_req_type;
>>> +}
>>> +EXPORT_SYMBOL(pcie_tph_enabled_req_type);
>>> +
>>>  /*
>>>   * Return the size of ST table. If ST table is not in TPH Requester Extended
>>>   * Capability space, return 0. Otherwise return the ST Table Size + 1.
>>> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
>>> index be68cd17f2f8..fe572737b409 100644
>>> --- a/include/linux/pci-tph.h
>>> +++ b/include/linux/pci-tph.h
>>> @@ -30,6 +30,7 @@ void pcie_disable_tph(struct pci_dev *pdev);
>>>  int pcie_enable_tph(struct pci_dev *pdev, int mode);
>>>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
>>>  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
>>> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
>>>  #else
>>>  static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
>>>                                       unsigned int index, u16 tag)
>>> @@ -41,6 +42,7 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
>>>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
>>>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
>>>  { return -EINVAL; }
>>> +static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev) { return 0; }
>>
>> nit, s/0/PCI_TPH_REQ_DISABLE/ for consistency.  Thanks,

It need add #include <linux/pci.h> at beginning too, else it will counter compile error like this:

   In file included from drivers/vdpa/mlx5/core/mr.c:8:
   In file included from include/linux/mlx5/qp.h:36:
   In file included from include/linux/mlx5/device.h:37:
   In file included from include/rdma/ib_verbs.h:46:
>> include/linux/pci-tph.h:48:10: error: use of undeclared identifier 'PCI_TPH_LOC_NONE'
      48 | { return PCI_TPH_LOC_NONE; }
         |          ^
   1 error generated.

>>
>> Alex
>>
> ack, will do.
> 
> Thanks,
> Zhiping
> 


