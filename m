Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686713D9B13
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jul 2021 03:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhG2B2K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jul 2021 21:28:10 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:12418 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbhG2B2J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Jul 2021 21:28:09 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GZt9d047tzcj9h;
        Thu, 29 Jul 2021 09:24:37 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 09:28:05 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 29 Jul
 2021 09:28:05 +0800
Subject: Re: [bug report] RDMA/hns: Optimize cmd init and mode selection for
 hip08
To:     Dan Carpenter <dan.carpenter@oracle.com>, <liuyixian@huawei.com>
References: <20210728114334.GA5071@kili>
CC:     <linux-rdma@vger.kernel.org>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <705c1370-242f-6b04-c76b-14f78d2d8c2b@huawei.com>
Date:   Thu, 29 Jul 2021 09:28:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210728114334.GA5071@kili>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2021/7/28 19:43, Dan Carpenter wrote:
> Hello Yixian Liu,
> 
> The patch 3d50503b3b33: "RDMA/hns: Optimize cmd init and mode
> selection for hip08" from Aug 29, 2019, leads to the following static
> checker warning:
> 
> 	drivers/infiniband/hw/hns/hns_roce_main.c:926 hns_roce_init()
> 	error: double unlocked '&hr_dev->cmd.poll_sem' (orig line 879)
> 
> drivers/infiniband/hw/hns/hns_roce_main.c
>     833 int hns_roce_init(struct hns_roce_dev *hr_dev)
>     834 {
>     835 	struct device *dev = hr_dev->dev;
>     836 	int ret;
>     837 
>     838 	if (hr_dev->hw->reset) {
>     839 		ret = hr_dev->hw->reset(hr_dev, true);
>     840 		if (ret) {
>     841 			dev_err(dev, "Reset RoCE engine failed!\n");
>     842 			return ret;
>     843 		}
>     844 	}
>     845 	hr_dev->is_reset = false;
>     846 
>     847 	if (hr_dev->hw->cmq_init) {
>     848 		ret = hr_dev->hw->cmq_init(hr_dev);
>     849 		if (ret) {
>     850 			dev_err(dev, "Init RoCE Command Queue failed!\n");
>     851 			goto error_failed_cmq_init;
>     852 		}
>     853 	}
>     854 
>     855 	ret = hr_dev->hw->hw_profile(hr_dev);
>     856 	if (ret) {
>     857 		dev_err(dev, "Get RoCE engine profile failed!\n");
>     858 		goto error_failed_cmd_init;
>     859 	}
>     860 
>     861 	ret = hns_roce_cmd_init(hr_dev);
>     862 	if (ret) {
>     863 		dev_err(dev, "cmd init failed!\n");
>     864 		goto error_failed_cmd_init;
>     865 	}
>     866 
>     867 	/* EQ depends on poll mode, event mode depends on EQ */
>     868 	ret = hr_dev->hw->init_eq(hr_dev);
>     869 	if (ret) {
>     870 		dev_err(dev, "eq init failed!\n");
>     871 		goto error_failed_eq_table;
>     872 	}
>     873 
>     874 	if (hr_dev->cmd_mod) {
>     875 		ret = hns_roce_cmd_use_events(hr_dev);
> 
> If hns_roce_cmd_use_events() fails then that means we haven't taken the
> semaphore.
> 
>     876 		if (ret) {
>     877 			dev_warn(dev,
>     878 				 "Cmd event  mode failed, set back to poll!\n");
>     879 			hns_roce_cmd_use_polling(hr_dev);
>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This releases a semaphore but we are not holding it.
> 
> 
>     880 		}
>     881 	}
>     882 
>     883 	ret = hns_roce_init_hem(hr_dev);
>     884 	if (ret) {
>     885 		dev_err(dev, "init HEM(Hardware Entry Memory) failed!\n");
>     886 		goto error_failed_init_hem;
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^
> Let's assume we hit this goto
> 
>     887 	}
>     888 
>     889 	ret = hns_roce_setup_hca(hr_dev);
>     890 	if (ret) {
>     891 		dev_err(dev, "setup hca failed!\n");
>     892 		goto error_failed_setup_hca;
>     893 	}
>     894 
>     895 	if (hr_dev->hw->hw_init) {
>     896 		ret = hr_dev->hw->hw_init(hr_dev);
>     897 		if (ret) {
>     898 			dev_err(dev, "hw_init failed!\n");
>     899 			goto error_failed_engine_init;
>     900 		}
>     901 	}
>     902 
>     903 	INIT_LIST_HEAD(&hr_dev->qp_list);
>     904 	spin_lock_init(&hr_dev->qp_list_lock);
>     905 	INIT_LIST_HEAD(&hr_dev->dip_list);
>     906 	spin_lock_init(&hr_dev->dip_list_lock);
>     907 
>     908 	ret = hns_roce_register_device(hr_dev);
>     909 	if (ret)
>     910 		goto error_failed_register_device;
>     911 
>     912 	return 0;
>     913 
>     914 error_failed_register_device:
>     915 	if (hr_dev->hw->hw_exit)
>     916 		hr_dev->hw->hw_exit(hr_dev);
>     917 
>     918 error_failed_engine_init:
>     919 	hns_roce_cleanup_bitmap(hr_dev);
>     920 
>     921 error_failed_setup_hca:
>     922 	hns_roce_cleanup_hem(hr_dev);
>     923 
>     924 error_failed_init_hem:
>     925 	if (hr_dev->cmd_mod)
> --> 926 		hns_roce_cmd_use_polling(hr_dev);
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This will release the semaphore a second time again.
> 
>     927 	hr_dev->hw->cleanup_eq(hr_dev);
>     928 
>     929 error_failed_eq_table:
>     930 	hns_roce_cmd_cleanup(hr_dev);
>     931 
>     932 error_failed_cmd_init:
>     933 	if (hr_dev->hw->cmq_exit)
>     934 		hr_dev->hw->cmq_exit(hr_dev);
>     935 
>     936 error_failed_cmq_init:
>     937 	if (hr_dev->hw->reset) {
>     938 		if (hr_dev->hw->reset(hr_dev, false))
>     939 			dev_err(dev, "Dereset RoCE engine failed!\n");
>     940 	}
>     941 
>     942 	return ret;
>     943 }
> 
> regards,
> dan carpenter
> .
> 

Thank you for reporting this bug and I will submit a patch to fix it
as soon as possible.

regards,
Wenpeng Liang
