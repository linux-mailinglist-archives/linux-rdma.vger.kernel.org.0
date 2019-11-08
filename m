Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 199CDF5360
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2019 19:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbfKHSQO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Nov 2019 13:16:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38482 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbfKHSQL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Nov 2019 13:16:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id z19so7170111wmk.3
        for <linux-rdma@vger.kernel.org>; Fri, 08 Nov 2019 10:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lE8FBOSfE/g2hakn5G6bGrc07Q8RE7Tck3x5/3Imhks=;
        b=uk8UaAdZntNxSVFyBrPO3VFjFg5DX0vxBcQCJ7GIIvVTfRE9SMw9f4OqPDuv0hzNGK
         IARFXxXfJeOIRjBvr/vlBRafKoexTXEll+9wIHDKEVoB/qpKwCLwSEgUkmg+k71wS0GG
         AzvldGkGefX3mmpLk2rzWYApHVXVr18j7ImqNrDJ8SnPRT95sHp5AwN42QvnphScfgOz
         OW9X/BgbbHur9Tfb8BRMb3BSHM3zKdYvmJt411J5D2WdU5JNoPlWAucKanqZRXCe4cqK
         ErCSjPWaQZw9SHJwe9TGmuo+U2ZQt5RO4UpXGOIkHhJIavHf/5gIQGqNEMAPAhDx2dhR
         TdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lE8FBOSfE/g2hakn5G6bGrc07Q8RE7Tck3x5/3Imhks=;
        b=PEWGJuQY7HTXhhiCvEkgXzXM+bLi9AsN8k6eUmxrfDyD2OkKOEm3PWvHIHcef1/noB
         Bof1qTl+G+SePE4Tq3FJDqbtqkH7LafxqVcL7K3X1dX//FLazvXBAj97t/zBMVuMY6gn
         k+SSjKuBrcqsyiHWAmiwbUJJK8gkHCmnfhkQRAeQfrt/fJCNpMFsgKv4Wx09163991BI
         tOHdRP/5t/Dze1iSzLrN9Ii1J1iOX6+wF9F+lVEL6uSbNOxHOdMMuyH85olK1Nkt7WKz
         e5NB3ZM3/gcc+zedjs+Mhh0lK24VKvxT2PS/6yZENVXX6KOo+WDTQ1/cnQa5jilnwJ70
         F5sw==
X-Gm-Message-State: APjAAAUDAuym8lidprPpun8SdjFfCOchL2wiF0jcTT2oHt4B5Id1zo4a
        GwW109Wd/nkTRftcvDlsmzkl0er1doU=
X-Google-Smtp-Source: APXvYqzCguYwJ6szFdkczpR790kRZFo69/nmMpT+ShM3O+MqiuYvFJN2kS6shP6itI6ZaNYrVJc0vQ==
X-Received: by 2002:a1c:f210:: with SMTP id s16mr8513157wmc.24.1573236969351;
        Fri, 08 Nov 2019 10:16:09 -0800 (PST)
Received: from localhost (ip-94-113-220-175.net.upcbroadband.cz. [94.113.220.175])
        by smtp.gmail.com with ESMTPSA id x9sm6458681wru.32.2019.11.08.10.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 10:16:09 -0800 (PST)
Date:   Fri, 8 Nov 2019 19:16:08 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Parav Pandit <parav@mellanox.com>, davem@davemloft.net,
        kvm@vger.kernel.org, netdev@vger.kernel.org, saeedm@mellanox.com,
        kwankhede@nvidia.com, leon@kernel.org, cohuck@redhat.com,
        jiri@mellanox.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 09/19] vfio/mdev: Expose mdev alias in sysfs tree
Message-ID: <20191108181608.GV6990@nanopsycho>
References: <20191107160448.20962-1-parav@mellanox.com>
 <20191107160834.21087-1-parav@mellanox.com>
 <20191107160834.21087-9-parav@mellanox.com>
 <20191108132230.GK6990@nanopsycho>
 <20191108110355.77128e6f@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108110355.77128e6f@x1.home>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fri, Nov 08, 2019 at 07:03:55PM CET, alex.williamson@redhat.com wrote:
>On Fri, 8 Nov 2019 14:22:30 +0100
>Jiri Pirko <jiri@resnulli.us> wrote:
>
>> Thu, Nov 07, 2019 at 05:08:24PM CET, parav@mellanox.com wrote:
>> 
>> [...]
>> 
>> > 
>> >+static ssize_t alias_show(struct device *device,
>> >+			  struct device_attribute *attr, char *buf)
>> >+{
>> >+	struct mdev_device *dev = mdev_from_dev(device);
>> >+
>> >+	if (!dev->alias)
>> >+		return -EOPNOTSUPP;
>> >+
>> >+	return sprintf(buf, "%s\n", dev->alias);
>> >+}
>> >+static DEVICE_ATTR_RO(alias);  
>> 
>> I wonder, rather than adding another sysfs file, why the alias can't be
>> simply a symlink to the aliased mdev directory?
>
>The user doesn't know the alias in advance, it seems problematic to
>assume an arbitrarily named link is the alias.  Thanks,

Why the user have to know in advance?


>
>Alex
>
>> >+
>> > static const struct attribute *mdev_device_attrs[] = {
>> >+	&dev_attr_alias.attr,
>> > 	&dev_attr_remove.attr,
>> > 	NULL,
>> > };
>> >-- 
>> >2.19.2
>> >  
>
