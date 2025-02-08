Return-Path: <linux-rdma+bounces-7579-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93331A2D531
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 10:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB7E188D6F0
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 09:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3691AA1E8;
	Sat,  8 Feb 2025 09:19:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DAC6FBF
	for <linux-rdma@vger.kernel.org>; Sat,  8 Feb 2025 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739006361; cv=none; b=r4fUN+++hTcp8BEKitD4d8x0T8NU7sIChvcp7Mu+4YXH8cwwRAif5GnnDXnZ3UB4VhIIc8c0Xsw1jetkj4i1WoK6JuED/53CHD2t3JKhAq/tKHIHHX7H7p9STf17040yPK3NJZ73MeGFnfdBsdNW50JrzUH6ch5tkiDn0BssR6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739006361; c=relaxed/simple;
	bh=QErUXwoU3wN8HzSke3b5xGa49Q4/t42THZJZph/xb6A=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RwOvmMOGS3EnStl6CXGHf+NaBXJwzu9AylbDXAYoWkPpmeQhou7Zs3ME6XivJOJ4MDZXagmukUy0rHmFMpD+3f+KZNF2EWb587lwT6YfW59xe64RW2FSApvJgXhOOyXmwzkEzAwmxVAGq9GpF5Hpffly3nkhUcKg2fG06AexNxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YqlYt6s2Wzbnsv;
	Sat,  8 Feb 2025 17:15:46 +0800 (CST)
Received: from kwepemd500026.china.huawei.com (unknown [7.221.188.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F773140135;
	Sat,  8 Feb 2025 17:19:15 +0800 (CST)
Received: from [10.67.121.229] (10.67.121.229) by
 kwepemd500026.china.huawei.com (7.221.188.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 8 Feb 2025 17:19:14 +0800
Subject: Re: [PATCH for-next v2] RDMA/bnxt_re: Congestion control settings
 using debugfs hook
To: Selvin Xavier <selvin.xavier@broadcom.com>, <leon@kernel.org>,
	<jgg@ziepe.ca>
References: <1737301535-6599-1-git-send-email-selvin.xavier@broadcom.com>
CC: <linux-rdma@vger.kernel.org>, <andrew.gospodarek@broadcom.com>,
	<kalesh-anakkur.purayil@broadcom.com>
From: Chengchang Tang <tangchengchang@huawei.com>
Message-ID: <4fa11b0e-e838-bfc1-a9e1-80c4aefc728f@huawei.com>
Date: Sat, 8 Feb 2025 17:19:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1737301535-6599-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd500026.china.huawei.com (7.221.188.35)



On 2025/1/19 23:45, Selvin Xavier wrote:
> Implements routines to set and get different settings  of
> the congestion control. This will enable the users to modify
> the settings according to their network.
> 
> Currently supporting only GEN 0 version of the parameters.
> Reading these files queries the firmware and report the values
> currently programmed. Writing to the files sends commands that
> update the congestion control settings
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
> v1 -> v2:
>   Addressed Leon's comments
>      - rename debugfs file "g" to "run_avg_weight_g"
>      - Fix the indentation errors
>      - Remove the unnecessary error message during the read entry point
>      - Fix the return value
> 
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h |   2 +
>  drivers/infiniband/hw/bnxt_re/debugfs.c | 212 +++++++++++++++++++++++++++++++-
>  drivers/infiniband/hw/bnxt_re/debugfs.h |  15 +++
>  3 files changed, 228 insertions(+), 1 deletion(-)
> 

...
> +static const struct file_operations bnxt_re_cc_config_ops = {
> +	.owner = THIS_MODULE,
> +	.open = simple_open,
> +	.read = bnxt_re_cc_config_get,
> +	.write = bnxt_re_cc_config_set,
> +};
> +
>  void bnxt_re_debugfs_add_pdev(struct bnxt_re_dev *rdev)
>  {
>  	struct pci_dev *pdev = rdev->en_dev->pdev;
> +	struct bnxt_re_dbg_cc_config_params *cc_params;
> +	int i;
>  
>  	rdev->dbg_root = debugfs_create_dir(dev_name(&pdev->dev), bnxt_re_debugfs_root);
>  
>  	rdev->qp_debugfs = debugfs_create_dir("QPs", rdev->dbg_root);
> +	rdev->cc_config = debugfs_create_dir("cc_config", rdev->dbg_root);
> +
> +	rdev->cc_config_params = kzalloc(sizeof(*cc_params), GFP_KERNEL);
> +
> +	for (i = 0; i < BNXT_RE_CC_PARAM_GEN0; i++) {
> +		struct bnxt_re_cc_param *tmp_params = &rdev->cc_config_params->gen0_parms[i];
> +
> +		tmp_params->rdev = rdev;
> +		tmp_params->offset = i;
> +		tmp_params->cc_gen = CC_CONFIG_GEN0_EXT0;
> +		tmp_params->dentry = debugfs_create_file(bnxt_re_cc_gen0_name[i], 0400,

Write operation doesn't seem to work?
> +							 rdev->cc_config, tmp_params,
> +							 &bnxt_re_cc_config_ops);
> +	}
>  }
>  


