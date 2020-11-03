Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3A72A47A1
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Nov 2020 15:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgKCONB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Nov 2020 09:13:01 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:42201 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729568AbgKCOLm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Nov 2020 09:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1604412702; x=1635948702;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=jMZAa/MfvlQ4KlIh4vzyh3+dHs+Urn9Aj9sxxL/Z2jc=;
  b=G9CpLcsjLo6xTUCp8/outRpzeLnb08fqNBRg6+xet0jh7wJGwlIMmZF2
   3FPvmP+wJTLh1f4zQCAXg34riVxm77s2eSVBzAUFVIDtLRQv7/Y1RKX3m
   74Oy42sktwtOo0LI9wbxdkC5tQHoFAkG99omF6DY/02wcuhg8ZCcQzVKa
   E=;
X-IronPort-AV: E=Sophos;i="5.77,448,1596499200"; 
   d="scan'208";a="83177808"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 03 Nov 2020 14:11:31 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 8EFE724108E;
        Tue,  3 Nov 2020 14:11:27 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.144) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 3 Nov 2020 14:11:24 +0000
Subject: Re: [PATCH for-next] RDMA/nldev: Add parent bdf to device information
 dump
To:     Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
References: <20201103132627.67642-1-galpress@amazon.com>
 <20201103134522.GL36674@ziepe.ca> <20201103135719.GK5429@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <0825e1bf-f913-d2c1-ad3f-35ba3d6b75ef@amazon.com>
Date:   Tue, 3 Nov 2020 16:11:19 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103135719.GK5429@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.144]
X-ClientProxiedBy: EX13D25UWC004.ant.amazon.com (10.43.162.201) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 03/11/2020 15:57, Leon Romanovsky wrote:
> On Tue, Nov 03, 2020 at 09:45:22AM -0400, Jason Gunthorpe wrote:
>> On Tue, Nov 03, 2020 at 03:26:27PM +0200, Gal Pressman wrote:
>>> Add the ability to query the device's bdf through rdma tool netlink
>>> command (in addition to the sysfs infra).
>>>
>>> In case of virtual devices (rxe/siw), the netdev bdf will be shown.
>>
>> Why? What is the use case?
> 
> Right, and why isn't netdev (RDMA_NLDEV_ATTR_NDEV_NAME) enough?

When taking system topology into consideration you need some way to pair the
ibdev and bdf, especially when working with multiple devices.
The netdev name doesn't exist on devices with no netdevs (IB, EFA).

Why rdma tool? Because it's more intuitive than sysfs.
