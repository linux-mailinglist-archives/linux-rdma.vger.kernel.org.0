Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 658DEF532E
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2019 19:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfKHSEc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Nov 2019 13:04:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40410 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfKHSEc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Nov 2019 13:04:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id i10so8059790wrs.7
        for <linux-rdma@vger.kernel.org>; Fri, 08 Nov 2019 10:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rhP9GYj9sB3quxMJEvN07RZn9DFfM5rZt8DENJt4Ftk=;
        b=eqeVu4gMo1gD/Rt1yILhcv9vdSwKMb572vK2LnFpeh7lMtfIUAd5ExMeA9fb9eAHvm
         sJtmfSXRrZzPWAbTEzaSc6XUSQr1Rqlr1gp8salxfqltjb3QJF3v7RuyDXI9lCFwveAx
         y5UQTScZbnCkSWpFYqoVPTYr6SkleyrIcBldQ6caE9E8953td8aqfX2dxo65cLTEo5VX
         KMx7d2jbX7/LzQh5bDw3yO/5iXS2F3kkJObQ+zueJk7rT51XFXBfHeJRQggLk2uMHRkc
         wXYW0n/lsTz2eAmEB+TOqZP8PYEIsp0JYiXUHx7Cdwrx1sVL8d5dE/ImCSKrUfNINThR
         vBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rhP9GYj9sB3quxMJEvN07RZn9DFfM5rZt8DENJt4Ftk=;
        b=Jc2PMgavDWGCYpnn5IFBuEmsnJ5GcHs2bqhr+NY3x2H2NdlfqiZjfzRAa3KxWjgib2
         RVU0M5l+NMArnW0XdXV+plw/H2tWwkQkDy+uR2ECoiJoibhbt8vGhtMA6ffdNlfuFZyU
         uMfmet6hmp4frlAdxfEDFM0O4NpN8HB9tkTroU2CEQXAeEMgebkNkJ6dBa6b9aKodcw+
         Z7d0fM0vtw0iaKhC5frX3KHZnRUVWr9GO1osTybinbSw1XD/tucosLfSd7r/+9MDWgE4
         Cy1RXxXceRuKC9uQRk8yPSgNRHlHBf1+vKbxMBwUWNEjeSk4dSY60bedaFRahWKRxZst
         br9A==
X-Gm-Message-State: APjAAAWrvZPD16M+wr5BbchWzAJaOc0gZVHfLM7fCkJWmvHlJPsg14WJ
        CVQJgH2i07hHmVZ1fSnQJBMyqA==
X-Google-Smtp-Source: APXvYqxS4WjU3UUomb8GvXXH1CA49N5Xq4JpPgXgHozULL2oh1BPDAugAaMnFNdN3RFM3UX44Q3j0A==
X-Received: by 2002:adf:ebd2:: with SMTP id v18mr9200033wrn.71.1573236270073;
        Fri, 08 Nov 2019 10:04:30 -0800 (PST)
Received: from localhost (ip-94-113-220-175.net.upcbroadband.cz. [94.113.220.175])
        by smtp.gmail.com with ESMTPSA id g184sm10503077wma.8.2019.11.08.10.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 10:04:29 -0800 (PST)
Date:   Fri, 8 Nov 2019 19:04:29 +0100
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
Message-ID: <20191108180429.GS6990@nanopsycho>
References: <20191107160448.20962-1-parav@mellanox.com>
 <20191107160834.21087-1-parav@mellanox.com>
 <20191107160834.21087-6-parav@mellanox.com>
 <20191108103249.GE6990@nanopsycho>
 <AM0PR05MB486609CBD40E1E26BB18C6B3D17B0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20191108162246.GN6990@nanopsycho>
 <AM0PR05MB48665096F40059F63B0895C6D17B0@AM0PR05MB4866.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR05MB48665096F40059F63B0895C6D17B0@AM0PR05MB4866.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fri, Nov 08, 2019 at 05:29:56PM CET, parav@mellanox.com wrote:
>
>
>> -----Original Message-----
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Friday, November 8, 2019 10:23 AM
>> To: Parav Pandit <parav@mellanox.com>
>> Cc: alex.williamson@redhat.com; davem@davemloft.net;
>> kvm@vger.kernel.org; netdev@vger.kernel.org; Saeed Mahameed
>> <saeedm@mellanox.com>; kwankhede@nvidia.com; leon@kernel.org;
>> cohuck@redhat.com; Jiri Pirko <jiri@mellanox.com>; linux-
>> rdma@vger.kernel.org; Vu Pham <vuhuong@mellanox.com>
>> Subject: Re: [PATCH net-next 06/19] net/mlx5: Add support for mediated
>> devices in switchdev mode
>> 
>> Fri, Nov 08, 2019 at 05:03:13PM CET, parav@mellanox.com wrote:
>> >
>> >
>> >> -----Original Message-----
>> >> From: Jiri Pirko <jiri@resnulli.us>
>> >> Sent: Friday, November 8, 2019 4:33 AM
>> >> To: Parav Pandit <parav@mellanox.com>
>> >> Cc: alex.williamson@redhat.com; davem@davemloft.net;
>> >> kvm@vger.kernel.org; netdev@vger.kernel.org; Saeed Mahameed
>> >> <saeedm@mellanox.com>; kwankhede@nvidia.com; leon@kernel.org;
>> >> cohuck@redhat.com; Jiri Pirko <jiri@mellanox.com>; linux-
>> >> rdma@vger.kernel.org; Vu Pham <vuhuong@mellanox.com>
>> >> Subject: Re: [PATCH net-next 06/19] net/mlx5: Add support for
>> >> mediated devices in switchdev mode
>> >>
>> >> Thu, Nov 07, 2019 at 05:08:21PM CET, parav@mellanox.com wrote:
>> >> >From: Vu Pham <vuhuong@mellanox.com>
>> >>
>> >> [...]
>> >>
>> >>
>> >> >+static ssize_t
>> >> >+max_mdevs_show(struct kobject *kobj, struct device *dev, char *buf) {
>> >> >+	struct pci_dev *pdev = to_pci_dev(dev);
>> >> >+	struct mlx5_core_dev *coredev;
>> >> >+	struct mlx5_mdev_table *table;
>> >> >+	u16 max_sfs;
>> >> >+
>> >> >+	coredev = pci_get_drvdata(pdev);
>> >> >+	table = coredev->priv.eswitch->mdev_table;
>> >> >+	max_sfs = mlx5_core_max_sfs(coredev, &table->sf_table);
>> >> >+
>> >> >+	return sprintf(buf, "%d\n", max_sfs); } static
>> >> >+MDEV_TYPE_ATTR_RO(max_mdevs);
>> >> >+
>> >> >+static ssize_t
>> >> >+available_instances_show(struct kobject *kobj, struct device *dev,
>> >> >+char *buf) {
>> >> >+	struct pci_dev *pdev = to_pci_dev(dev);
>> >> >+	struct mlx5_core_dev *coredev;
>> >> >+	struct mlx5_mdev_table *table;
>> >> >+	u16 free_sfs;
>> >> >+
>> >> >+	coredev = pci_get_drvdata(pdev);
>> >> >+	table = coredev->priv.eswitch->mdev_table;
>> >> >+	free_sfs = mlx5_get_free_sfs(coredev, &table->sf_table);
>> >> >+	return sprintf(buf, "%d\n", free_sfs); } static
>> >> >+MDEV_TYPE_ATTR_RO(available_instances);
>> >>
>> >> These 2 arbitrary sysfs files are showing resource size/usage for the
>> >> whole eswitch/asic. That is a job for "devlink resource". Please implement
>> that.
>> >>
>> >Jiri,
>> >This series is already too long. I will implement it as follow on. It is already
>> in plan.
>> >However, available_instances file is needed regardless of devlink resource,
>> as its read by the userspace for all mdev drivers.
>> 
>> If that is the case, why isn't that implemented in mdev code rather than
>> individual drivers? I don't understand.
>>
>It should be. It isn't yet.
>It is similar to how phys_port_name preparation was done in legacy way in individual drivers and later on moved to devlink.c
>So some other time, can move this to mdev core.

Btw, Documentation/driver-api/vfio-mediated-device.rst says:
  "[<type-id>], device_api, and available_instances are mandatory attributes
   that should be provided by vendor driver."

Why don't you implement "device_api" as well?


>
> 
>> 
>> >
>> >>
>> >> >+
>> >> >+static struct attribute *mdev_dev_attrs[] = {
>> >> >+	&mdev_type_attr_max_mdevs.attr,
>> >> >+	&mdev_type_attr_available_instances.attr,
>> >> >+	NULL,
>> >> >+};
>> >> >+
>> >> >+static struct attribute_group mdev_mgmt_group = {
>> >> >+	.name  = "local",

This local name is "type-id"? Why "local?





>> >> >+	.attrs = mdev_dev_attrs,
>> >> >+};
>> >> >+
>> >> >+static struct attribute_group *mlx5_meddev_groups[] = {
>> >> >+	&mdev_mgmt_group,
>> >> >+	NULL,
>> >> >+};
>> >>
>> >> [...]
