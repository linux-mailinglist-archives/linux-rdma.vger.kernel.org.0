Return-Path: <linux-rdma+bounces-8054-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3150AA433C0
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 04:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A9C1793D6
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 03:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763FC24C689;
	Tue, 25 Feb 2025 03:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PBEmxPNj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D04024CED6
	for <linux-rdma@vger.kernel.org>; Tue, 25 Feb 2025 03:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740454959; cv=none; b=kvbuB9Pa5YdV85MTgBa/goawO8uBZaPccT2ZNtuw2ixTcU8wqxQr44H3dRbVtztPBireebJ+kppDpBy04hU61QBes4ISzsqYXlzA5VKZ4Xu+uVF+TK0iZRfM4P++7QrS8gtL9r16eLIxtp4fsCSO1GlR/3WAnuoB14RSXYV9ZoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740454959; c=relaxed/simple;
	bh=H+RyLfFamXo1oAGjUqvJZhcQXerEfcHPpC15CMvkWnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnYzNNLGsPh1IeKEOMFDQUI2w191TxnXccgQ6jULsHTW9vPgjAtb4uaKpOiZ/X8VuSO3HgUH+GD+vqvbmutoZ8uVoKKlRvfxYvch1+eX7vSLyc9qRqZCjc3ANvig5EqHAq0sycjo4q7eFiO7f6iN2M7zxzgWWbyGqdohFvVdSqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PBEmxPNj; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 25 Feb 2025 03:42:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740454954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9afZ+NqTLgZXLQIzPGVnqR+tzegyYgOtZzHHZW/wF2c=;
	b=PBEmxPNjhz6LPVmwSdF4iTOOk+6D43wZb4Gt6sdGtIY9OPHp6VF6ODgHepIUHMZSwMjckq
	oDo8txB3t0S9MWzIhPks8UV+zIpgHCvS+pYVtIh+YTJAEoQ8/PlEOQXou9bLuAYSY6l3fo
	lfq3v0ddWuZ58ugt1znbO82wQRoMldU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@mellanox.com>, Leon Romanovsky <leon@kernel.org>,
	Maher Sanalla <msanalla@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/core: fix a NULL-pointer dereference in
 hw_stat_device_show()
Message-ID: <Z708JNt6-vPIuDBm@google.com>
References: <20250221020555.4090014-1-roman.gushchin@linux.dev>
 <CY8PR12MB71958C150D7604EAD4463F4ADCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7gARTF0mpbOj7gN@google.com>
 <CY8PR12MB7195F3ACB8CFA05C4B8D26D3DCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250221174347.GA314593@nvidia.com>
 <CY8PR12MB7195A82F6CE17D9BDC674D72DCC62@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250224151127.GT50639@nvidia.com>
 <CY8PR12MB7195E91917FD5329932FA3FCDCC02@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7z_NcGWIr3_Dxtt@google.com>
 <20250224233004.GD520155@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224233004.GD520155@nvidia.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 24, 2025 at 07:30:04PM -0400, Jason Gunthorpe wrote:
> On Mon, Feb 24, 2025 at 11:22:29PM +0000, Roman Gushchin wrote:
> > On Mon, Feb 24, 2025 at 03:16:46PM +0000, Parav Pandit wrote:
> > > 
> > > 
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Monday, February 24, 2025 8:41 PM
> > > > 
> > > > On Sat, Feb 22, 2025 at 06:34:21PM +0000, Parav Pandit wrote:
> > > > > ib_setup_device_attrs() should be merged to ib_setup_port_attrs() by
> > > > > renaming ib_setup_port_attrs() to be generic.  To utilize the group
> > > > > initialization ib_setup_port_attrs() needs to move up before
> > > > > device_add().
> > > > 
> > > > It needs more than that, somehow you have to maintain two groups list or
> > > > somehow remove the coredev->dev.groups assignment..
> > > > 
> > > I was thinking that if both device and port attr setup is done in
> > > same function, there is knowledge of is_full_dev that can be used
> > > for device level hw_stats setup. (similar to how its done at port
> > > level).
> > 
> > Given that there is a bit of discussion on how to move forward with this,
> > can we please merge the trivial fix in the mean time? (Just sent out v2 with
> > the fixed commit log).
> 
> Well, the issue now is the ABI break
> 
> If the right answer is to remove the sysfs entirely then it doesn't
> make sense to make it work in the stable and LTS kernels since that
> would create users. Currently it is fully broken so there are no
> users. Can we say that so certainly after it is fixed?

It's a good point.

Ok, then we need something like this (obviously, coded more nicely):

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 0ded91f056f3..6998907fc779 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -956,6 +956,7 @@ static int add_one_compat_dev(struct ib_device *device,
        ret = device_add(&cdev->dev);
        if (ret)
                goto add_err;
+       device->groups[2] = NULL;
        ret = ib_setup_port_attrs(cdev);
        if (ret)
                goto port_err;

