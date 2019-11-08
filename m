Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 355E8F50FB
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2019 17:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfKHQWu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Nov 2019 11:22:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55993 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfKHQWt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Nov 2019 11:22:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so6756625wmb.5
        for <linux-rdma@vger.kernel.org>; Fri, 08 Nov 2019 08:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1hEKhdVfyO4yewnCI8/1KBs9vIJ4ofje9lXGykRyyCQ=;
        b=b1qFA61Tma0gRUWaFZBFRrOCcniNjzRFqKPQkAbRS3u+qT7PYE9m8/7fMRuvG7bRkK
         NigudxLRzuodvlkqXlZURobWU4FFkHzMUax94X8fnGrSR3qjrw1bTLBYQUCg7AK8hz/b
         1c7pjzr+9/9Xpkp1IVQTCopyuf0OKkdM3vNRcL9oRe0C3nxWZWgLvwxxuqR4n+10I5Iz
         dHM43QKKbMRtBYYT+ViQuQ1/TgyG1YEBH5mQYrIAoIVaAaoY8xcgU7pW8tCPN40FUNh7
         q6K14XCHPaeeCKHOXfmFuB4jHyI3FlxLSble/sPhXSnJJGiFJQh3yMR5BsLde2Ww/btE
         ApHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1hEKhdVfyO4yewnCI8/1KBs9vIJ4ofje9lXGykRyyCQ=;
        b=ta85SQBVicfOnPSmTsHXu/jKTyYGtWhrdYf+x8MS/cT2XI9ZPUgu/yygN98jii6hMw
         CmHRnqnFVrc6c7vW3UZBzfTx2s+w8NLMmVrOEZlKlPTTagTicdQQ3naA/oW610rJP/BV
         Klm64imZnE3HPIxXyuFn/+t0He1I5BJRllcn2TZ+JoV6tLVvQ6dYJGawcHt90hFqfGqY
         ZM5v3w+HrlUDe0liQd4kT6h2hb3lN+uRTvIM+P4zfflcA28wRQF31dUw2au9brCzxnJ7
         qS5agXt7n5sjlXesz3fAyFvLuatecLsEoucNbBWW1+yD/B7d5HJQazuwFRjC0cwm2pfp
         nyPw==
X-Gm-Message-State: APjAAAX7nV6bsJF3ITrb2H464t4dAzQli46eP2LCgKETQfvlzcdQU1Nr
        ZY68xFLOQbjXVBonogn6PUdroA==
X-Google-Smtp-Source: APXvYqyEO3yYImFDMX6b+ebGJ70btDiELBQr7l+ul6qPtiqg5rSRR1thE5ikNvJniBIAXxVobGvrGw==
X-Received: by 2002:a1c:6309:: with SMTP id x9mr8521783wmb.108.1573230167714;
        Fri, 08 Nov 2019 08:22:47 -0800 (PST)
Received: from localhost (ip-94-113-220-175.net.upcbroadband.cz. [94.113.220.175])
        by smtp.gmail.com with ESMTPSA id w132sm9995010wma.6.2019.11.08.08.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 08:22:47 -0800 (PST)
Date:   Fri, 8 Nov 2019 17:22:46 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Parav Pandit <parav@mellanox.com>
Cc:     "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Vu Pham <vuhuong@mellanox.com>
Subject: Re: [PATCH net-next 06/19] net/mlx5: Add support for mediated
 devices in switchdev mode
Message-ID: <20191108162246.GN6990@nanopsycho>
References: <20191107160448.20962-1-parav@mellanox.com>
 <20191107160834.21087-1-parav@mellanox.com>
 <20191107160834.21087-6-parav@mellanox.com>
 <20191108103249.GE6990@nanopsycho>
 <AM0PR05MB486609CBD40E1E26BB18C6B3D17B0@AM0PR05MB4866.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR05MB486609CBD40E1E26BB18C6B3D17B0@AM0PR05MB4866.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fri, Nov 08, 2019 at 05:03:13PM CET, parav@mellanox.com wrote:
>
>
>> -----Original Message-----
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Friday, November 8, 2019 4:33 AM
>> To: Parav Pandit <parav@mellanox.com>
>> Cc: alex.williamson@redhat.com; davem@davemloft.net;
>> kvm@vger.kernel.org; netdev@vger.kernel.org; Saeed Mahameed
>> <saeedm@mellanox.com>; kwankhede@nvidia.com; leon@kernel.org;
>> cohuck@redhat.com; Jiri Pirko <jiri@mellanox.com>; linux-
>> rdma@vger.kernel.org; Vu Pham <vuhuong@mellanox.com>
>> Subject: Re: [PATCH net-next 06/19] net/mlx5: Add support for mediated
>> devices in switchdev mode
>> 
>> Thu, Nov 07, 2019 at 05:08:21PM CET, parav@mellanox.com wrote:
>> >From: Vu Pham <vuhuong@mellanox.com>
>> 
>> [...]
>> 
>> 
>> >+static ssize_t
>> >+max_mdevs_show(struct kobject *kobj, struct device *dev, char *buf) {
>> >+	struct pci_dev *pdev = to_pci_dev(dev);
>> >+	struct mlx5_core_dev *coredev;
>> >+	struct mlx5_mdev_table *table;
>> >+	u16 max_sfs;
>> >+
>> >+	coredev = pci_get_drvdata(pdev);
>> >+	table = coredev->priv.eswitch->mdev_table;
>> >+	max_sfs = mlx5_core_max_sfs(coredev, &table->sf_table);
>> >+
>> >+	return sprintf(buf, "%d\n", max_sfs); } static
>> >+MDEV_TYPE_ATTR_RO(max_mdevs);
>> >+
>> >+static ssize_t
>> >+available_instances_show(struct kobject *kobj, struct device *dev,
>> >+char *buf) {
>> >+	struct pci_dev *pdev = to_pci_dev(dev);
>> >+	struct mlx5_core_dev *coredev;
>> >+	struct mlx5_mdev_table *table;
>> >+	u16 free_sfs;
>> >+
>> >+	coredev = pci_get_drvdata(pdev);
>> >+	table = coredev->priv.eswitch->mdev_table;
>> >+	free_sfs = mlx5_get_free_sfs(coredev, &table->sf_table);
>> >+	return sprintf(buf, "%d\n", free_sfs); } static
>> >+MDEV_TYPE_ATTR_RO(available_instances);
>> 
>> These 2 arbitrary sysfs files are showing resource size/usage for the whole
>> eswitch/asic. That is a job for "devlink resource". Please implement that.
>>
>Jiri,
>This series is already too long. I will implement it as follow on. It is already in plan.
>However, available_instances file is needed regardless of devlink resource, as its read by the userspace for all mdev drivers.

If that is the case, why isn't that implemented in mdev code rather than
individual drivers? I don't understand.


> 
>> 
>> >+
>> >+static struct attribute *mdev_dev_attrs[] = {
>> >+	&mdev_type_attr_max_mdevs.attr,
>> >+	&mdev_type_attr_available_instances.attr,
>> >+	NULL,
>> >+};
>> >+
>> >+static struct attribute_group mdev_mgmt_group = {
>> >+	.name  = "local",
>> >+	.attrs = mdev_dev_attrs,
>> >+};
>> >+
>> >+static struct attribute_group *mlx5_meddev_groups[] = {
>> >+	&mdev_mgmt_group,
>> >+	NULL,
>> >+};
>> 
>> [...]
